import 'dart:convert';
import 'dart:typed_data';

import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/service/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot detailSnapshot;
  const DetailPage({
    Key? key,
    required this.detailSnapshot,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  int totalPrice = 0;
  String? userId;
  bool isLoading = false;

  getUserId() async {
    try {
      userId = await SharedPreferencesHelper().getUserId();
      print("UserId fetched: $userId"); // Debug print
      setState(() {});
    } catch (e) {
      print("Error fetching userId: $e"); // Debug print
    }
  }

  @override
  void initState() {
    super.initState();
    totalPrice = (widget.detailSnapshot['Price'] as num).toInt();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    final ds = widget.detailSnapshot;
    final String binaryImage = ds['Image'];
    final String foodName = ds['Name'] ?? 'No Name';
    final String description = ds['Description'] ?? 'No Description';
    final String deliveryTime = ds['Time'] ?? 'N/A';
    final int price = (ds['Price'] as num).toInt();
    final int ratings = (ds['Ratings'] as num).toInt();

    Uint8List imageBytes = base64.decode(binaryImage);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 50, left: 20.0, right: 20.0, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.memory(
                    imageBytes,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            foodName,
                            style: Fonts.bodyLargeInter
                                .copyWith(fontWeight: FontWeight.bold),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                              totalPrice -= price;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.remove, color: AppColors.white),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(quantity.toString(), style: Fonts.labelMediumInter),
                      SizedBox(
                        width: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            quantity++;
                            totalPrice += price;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.add, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < ratings ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Delivery Time",
                          style: Fonts.bodyMediumInter
                              .copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.alarm,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(deliveryTime, style: Fonts.bodyMediumInter),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    description,
                    style: Fonts.bodyMediumInter,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 90,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 214, 214),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Price',
                        style: Fonts.bodyMediumInter,
                      ),
                      Text(
                        'Rs. $totalPrice',
                        style: Fonts.bodyLargeInter.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  AppButtonWidget(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    color: AppColors.black,
                    onButtonPressed: isLoading ? null : () async {
                      if (userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please login first',
                              style: Fonts.bodyMediumInter.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      setState(() {
                        isLoading = true;
                      });

                      try {
                        Map<String, dynamic> cartItem = {
                          "Name": foodName,
                          "Quantity": quantity,
                          "Ratings": ratings,
                          "Total": totalPrice,
                          "Image": binaryImage,
                          "userId": userId,
                          "addedAt": DateTime.now().millisecondsSinceEpoch,
                          "status": "pending"
                        };

                        await DatabaseMethods().addFoodToCart(cartItem, userId!);

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added to cart successfully',
                                style: Fonts.bodyMediumInter.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: const Color.fromARGB(255, 109, 226, 59),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Failed to add to cart',
                                style: Fonts.bodyMediumInter.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Add to Cart',
                            style: Fonts.bodyMediumInter.copyWith(
                              color: AppColors.white
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
