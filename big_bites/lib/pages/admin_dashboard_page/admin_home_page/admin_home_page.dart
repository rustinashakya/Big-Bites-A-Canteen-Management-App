import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_home_page/widget/admin_food_item_widget.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_home_page/widget/admin_select_category_widget.dart';
import 'package:big_bites/pages/admin_detail_page/admin_detail_page.dart';
import 'package:big_bites/pages/common_widget/admin_top_title_widget.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  String selectedCategory = 'momo';
  String searchQuery = '';

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  void _handleEdit(DocumentSnapshot foodItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Item',
          style: Fonts.bodyLargeInter.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Edit functionality coming soon!',
          style: Fonts.bodyMediumInter,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: Fonts.bodyMediumInter,
            ),
          ),
        ],
      ),
    );
  }

  void _handleDelete(DocumentSnapshot foodItem) {
    setState(() {}); // Refresh the list after delete
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminTopTitleWidget(
            title: 'Big Bites',
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, 
            children: [
              Text(
                'Hello Admin,',
                style: Fonts.titleLargeInter.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              'View all foods available!',
              style: Fonts.bodyLargeInter.copyWith(color: AppColors.grey),
            ),
          ),
          const SizedBox(height: 10),
          SelectCategoryWidget(
            categories: categories,
            onCategorySelected: updateCategory,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(selectedCategory.toLowerCase())
                  .orderBy('Timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                // Get all food items from the selected category
                List<DocumentSnapshot> foodItems = snapshot.data?.docs ?? [];

                if (foodItems.isEmpty) {
                  return Center(
                      child: Text(
                    "No food items available",
                    style: Fonts.bodyMediumInter,
                  ));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: foodItems
                      .length, // Set itemCount to the number of food items
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = foodItems[index];

                    return FoodItemWidget(
                      foodItemSnapshot: ds, // Pass the snapshot here
                      onItemClick: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminDetailPage(
                            detailSnapshot: ds,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> categories = [
  'momo',
  'burger',
  'pizza',
  'hot beverages',
  'cold beverages',
];
