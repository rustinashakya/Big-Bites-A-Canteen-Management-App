import 'dart:convert';
import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavouriteListWidget extends StatefulWidget {
  final Map<String, dynamic> favItem;
  final String favId;

  const FavouriteListWidget({
    super.key,
    required this.favItem,
    required this.favId,
  });

  @override
  State<FavouriteListWidget> createState() => _FavouriteListWidgetState();
}

class _FavouriteListWidgetState extends State<FavouriteListWidget> {
  String? userId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await SharedPreferencesHelper().getUserId();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _removeFavorite() async {
    if (userId == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(widget.favId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Removed from favorites',
            style: Fonts.bodyMediumInter,
          ),
          backgroundColor: AppColors.successColor,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error removing from favorites',
            style: Fonts.bodyMediumInter,
          ),
          backgroundColor: Colors.red,
        ),
      );
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
    final String name = widget.favItem['Name'] ?? 'Unknown Item';
    final double ratings = widget.favItem['Ratings'] ?? 0;
    final double price = widget.favItem['Price'] ?? 0;
    final String imageBase64 = widget.favItem['Image'] ?? '';

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
                  name,
                  style: Fonts.bodyLargeInter
                      .copyWith(fontWeight: FontWeight.bold),
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
                  ],
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
                SizedBox(height: 5),
                Text(
                  'Rs. $price/-',
                  style: Fonts.bodyMediumInter,
                ),
              ],
            ),
          ),
          Row(
            children: [
              if (imageBase64.isNotEmpty)
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(right: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      base64Decode(imageBase64),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppIcons.friedChickenBurger,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              GestureDetector(
                onTap: isLoading ? null : _removeFavorite,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        )
                      : Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 24,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).py(8);
  }
}
