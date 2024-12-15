import 'dart:convert';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:big_bites/service/app.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';

class FoodItemWidget extends StatefulWidget {
  const FoodItemWidget({
    super.key,
    this.onItemClick,
    required this.foodItemSnapshot,
  });

  final VoidCallback? onItemClick;
  final DocumentSnapshot foodItemSnapshot;

  @override
  State<FoodItemWidget> createState() => _FoodItemWidgetState();
}

class _FoodItemWidgetState extends State<FoodItemWidget> {
  bool isFavorite = false;
  bool isLoading = false;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadUserId() async {
    userId = await SharedPreferencesHelper().getUserId();
    if (mounted) {
      setState(() {});
      _listenToFavoriteStatus();
    }
  }

  void _listenToFavoriteStatus() {
    if (userId == null) return;

    final favoriteRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(widget.foodItemSnapshot.id);

    favoriteRef.snapshots().listen(
      (docSnapshot) {
        if (mounted) {
          setState(() {
            isFavorite = docSnapshot.exists;
          });
        }
      },
      onError: (error) {
        print('Error listening to favorite status: $error');
      },
    );
  }

  Future<void> _toggleFavorite() async {
    if (userId == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final data = widget.foodItemSnapshot.data() as Map<String, dynamic>;
      final favoriteRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(widget.foodItemSnapshot.id);

      if (isFavorite) {
        await favoriteRef.delete();
      } else {
        await favoriteRef.set(data);
      }
    } catch (e) {
      print('Error toggling favorite: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error updating favorites. Please try again.',
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

  Widget foodItemDetails(DocumentSnapshot ds) {
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
            onTap: widget.onItemClick,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageWidget,
                const SizedBox(height: 8),
                Text(
                  ds['Name'] ?? 'No Name',
                  style: Fonts.bodyMediumInter
                      .copyWith(fontWeight: FontWeight.bold),
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
                onTap: () async {
                  await _toggleFavorite();
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
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
    return foodItemDetails(widget.foodItemSnapshot);
  }
}
