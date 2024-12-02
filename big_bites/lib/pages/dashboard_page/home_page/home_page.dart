import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/search_widget.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:big_bites/pages/dashboard_page/home_page/widget/select_category_widget.dart';
import 'package:big_bites/pages/detail_page/detail_page.dart';
import 'package:flutter/material.dart';

import '../../common_widget/app_button_widget.dart';
import '../../common_widget/food_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.isStaff});
  final bool isStaff;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopTitleWidget(
          title: 'Big Bites',
          isStaff: isStaff,
        ),
        Text(
          'Order your favorite food!',
          style: Fonts.bodyLargeInter.copyWith(color: AppColors.grey),
        ).px(10),
        16.verticalBox,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 4, child: const SearchWidget()),
            12.horizontalBox,
            Expanded(
              child: IntrinsicHeight(
                child: AppButtonWidget(
                  child: Image.asset(AppIcons.filterIcon),
                ),
              ),
            ),
          ],
        ).px(10),
        6.verticalBox,
        SelectCategoryWidget(categories: categories),
        Expanded(
          child: SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items in a row
                crossAxisSpacing: 10.0, // Space between items horizontally
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.8, // Space between items vertically
              ),
              itemCount: 6,
              // Total number of items
              itemBuilder: (context, index) {
                return FoodItemWidget(
                  onItemClick: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailPage())),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

const List<String> categories = [
  'All',
  'Combo',
  'MO:MO',
  'Burger',
  'Pizza',
  'dfafasfsfsa'
];
