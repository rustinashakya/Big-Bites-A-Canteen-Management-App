import 'dart:convert';
import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/service/app.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

class CustomerOrderListWidget extends StatefulWidget {
  final Map<String, dynamic> cartItem;
  final String itemId;

  const CustomerOrderListWidget({
    super.key,
    required this.cartItem,
    required this.itemId,
  });

  @override
  State<CustomerOrderListWidget> createState() => _CustomerOrderListWidgetState();
}

class _CustomerOrderListWidgetState extends State<CustomerOrderListWidget> {
  bool isLoading = false;

  Future<void> _removeItem() async {
    try {
      setState(() {
        isLoading = true;
      });

      final userId = await SharedPreferencesHelper().getUserId();
      if (userId == null) {
        throw Exception('User not logged in');
      }

      await DatabaseMethods().removeFromCart(userId, widget.itemId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Item removed from cart',
              style: Fonts.bodyMediumInter.copyWith(color: Colors.white),
            ),
            backgroundColor: AppColors.successColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to remove item',
              style: Fonts.bodyMediumInter.copyWith(color: Colors.white),
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
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.cartItem['Name'] ?? 'Unknown Item';
    final int quantity = widget.cartItem['Quantity'] ?? 0;
    final int ratings = widget.cartItem['Ratings'] ?? 0;
    final int total = widget.cartItem['Total'] ?? 0;
    final String imageBase64 = widget.cartItem['Image'] ?? '';

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name - $quantity",
                  style: Fonts.bodyLargeInter.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Ratings",
                      style: Fonts.bodyMediumInter.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightgrey,
                      ),
                    ),
                    SizedBox(width: 16),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < ratings ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Rs. $total/-',
                  style: Fonts.bodyMediumInter,
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: isLoading ? null : _removeItem,
                  child: Row(
                    children: [
                      if (isLoading)
                        const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        )
                      else
                        const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                      const SizedBox(width: 5),
                      Text(
                        'Remove',
                        style: Fonts.bodyMediumInter.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (imageBase64.isNotEmpty)
            SizedBox(
              width: 100,
              height: 100,
              child: Image.memory(
                base64Decode(imageBase64),
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    ).py(8);
  }
}
