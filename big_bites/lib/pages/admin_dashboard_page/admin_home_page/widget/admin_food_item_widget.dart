import 'dart:convert';

import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodItemWidget extends StatelessWidget {
  const FoodItemWidget({
    super.key, 
    this.onItemClick,
    required this.foodItemSnapshot, 
  });

  final VoidCallback? onItemClick;
  final DocumentSnapshot foodItemSnapshot;

  Future<void> _deleteFoodItem(BuildContext context) async {
    try {
      // Show confirmation dialog
      bool? confirm = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Food Item'),
            content: const Text('Are you sure you want to delete this food item?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );

      if (confirm != true) return;

      // Delete from Firestore
      await foodItemSnapshot.reference.delete();

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food item deleted successfully'),
            backgroundColor: AppColors.successColor,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting food item: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget foodItemDetails(BuildContext context, DocumentSnapshot ds) {
    // Decode Base64 image
    final base64Image = ds['Image'] as String?;
    final imageWidget = base64Image != null
        ? Image.memory(
            base64Decode(base64Image),
            fit: BoxFit.cover,
            height: 135,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppIcons.friedChickenBurger, 
                fit: BoxFit.cover,
              );
            },
          )
        : Image.asset(
            AppIcons.friedChickenBurger,
            fit: BoxFit.cover,
          );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(-5, 0),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onItemClick,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageWidget,
                const SizedBox(height: 8),
                Text(
                  ds['Name'] ?? 'No Name',
                  style: Fonts.bodyMediumInter.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Rs. ${ds['Price']?.toStringAsFixed(2) ?? '0.00'}",
                  style: Fonts.bodyMediumInter,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              GestureDetector(
                onTap: () => _deleteFoodItem(context),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return foodItemDetails(context, foodItemSnapshot);
  }
}
