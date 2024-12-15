import 'dart:convert';
import 'dart:typed_data';

import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/service/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences_helper/shared_preferences_helper.dart';

class AdminDetailPage extends StatefulWidget {
  final DocumentSnapshot detailSnapshot;
  const AdminDetailPage({
    Key? key,
    required this.detailSnapshot,
  }) : super(key: key);

  @override
  State<AdminDetailPage> createState() => _AdminDetailPageState();
}

class _AdminDetailPageState extends State<AdminDetailPage> {
  int quantity = 1;
  late int totalPrice;
  String? email;

  gettgesharedpref() async {
    email = await SharedPreferencesHelper().getUserId();
    print("Email fetched: $email"); // Debugging line
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    totalPrice = (widget.detailSnapshot['Price'] as num).toInt();
    gettgesharedpref();
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
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.07),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Price",
                          style: Fonts.bodyLargeInter
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        "Rs. $totalPrice",
                        style: Fonts.bodyLargeInter,
                      ),
                    ],
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
