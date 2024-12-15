// import 'package:big_bites/pages/dashboard_page/home_page/widget/food_item_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:big_bites/context/app_colors.dart';
// import 'package:big_bites/context/fonts.dart';
// import 'package:big_bites/pages/common_widget/search_widget.dart';
// import 'package:big_bites/pages/common_widget/top_title_widget.dart';
// import 'package:big_bites/pages/dashboard_page/home_page/widget/select_category_widget.dart';
// import 'package:big_bites/pages/detail_page/detail_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white, // Background for the entire page
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TopTitleWidget(
//             title: 'Big Bites',
//           ),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 0),
//             child: Text(
//               'Hi Shivam,',
//               style: Fonts.titleLargeInter.copyWith(
//                 color: AppColors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 0),
//             child: Text(
//               'Order your favorite food!',
//               style: Fonts.bodyLargeInter.copyWith(color: AppColors.grey),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 0),
//             child: Row(
//               children: [
//                 const Expanded(flex: 4, child: SearchWidget()),
//                 const SizedBox(width: 5),
//               ],
//             ),
//           ),
//           const SizedBox(height: 6),
//           SelectCategoryWidget(categories: categories),
//           Expanded(
//             child: Container(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10.0,
//                   mainAxisSpacing: 15.0,
//                   childAspectRatio: 0.78,
//                 ),
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   return FoodItemWidget(
//                     categoryName: categories[index], // Pass category name here
//                     onItemClick: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailPage(),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// const List<String> categories = [
//   'momo',
//   'burger',
//   'pizza',
//   'hot Beverages',
//   'cold Beverages',
// ];


import 'package:big_bites/pages/admin_dashboard_page/admin_home_page/admin_home_page.dart';
import 'package:big_bites/pages/dashboard_page/home_page/widget/food_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:big_bites/pages/dashboard_page/home_page/widget/select_category_widget.dart';
import 'package:big_bites/pages/detail_page/detail_page.dart';

class HomePage extends StatefulWidget {
  final String firstName;
  const HomePage({super.key, required this.firstName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String firstName;

  @override
  void initState() {
    super.initState();
    firstName = widget.firstName;
  }

  String selectedCategory = 'momo';

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Background for the entire page
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopTitleWidget(
            title: 'Big Bites',
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              'Hi ${firstName},',
              style: Fonts.titleLargeInter.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              'Order your favorite food!',
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
                  return Center(child: Text("No Food Items Available"
                    ,style: Fonts.bodyMediumInter,));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: foodItems.length, // Set itemCount to the number of food items
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = foodItems[index];

                    return FoodItemWidget(
                      foodItemSnapshot: ds, // Pass the snapshot here
                      onItemClick: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(detailSnapshot: ds,),
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
