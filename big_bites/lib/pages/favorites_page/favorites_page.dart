import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';
import 'package:big_bites/pages/dashboard_page/home_page/widget/food_item_widget.dart';
import 'package:big_bites/context/fonts.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String? userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await SharedPreferencesHelper().getUserId();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userId == null) {
      return Center(
        child: Text(
          'Please log in to view favorites',
          style: Fonts.bodyMediumInter,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites',
          style: Fonts.bodyMediumInter.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading favorites',
                style: Fonts.bodyMediumInter,
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final favorites = snapshot.data?.docs ?? [];

          if (favorites.isEmpty) {
            return Center(
              child: Text(
                'No favorites yet',
                style: Fonts.bodyMediumInter,
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return FoodItemWidget(
                foodItemSnapshot: favorites[index],
                onItemClick: () {
                  // Handle item click if needed
                },
              );
            },
          );
        },
      ),
    );
  }
}
