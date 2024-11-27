import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/search_widget.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:big_bites/pages/dashboard_page/home_page/widget/select_category_widget.dart';
import 'package:flutter/material.dart';

import '../../common_widget/app_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopTitleWidget(
            title: 'Big Bites',
          ),
          Text(
            'Order your favorite food!',
            style: Fonts.bodyLargeInter.copyWith(color: AppColors.grey),
          ).px(10),
          16.verticalBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: const SearchWidget()),
              12.horizontalBox,
              AppButtonWidget(
                height: 65,
                child: Image.asset(AppIcons.filterIcon),
              ),
            ],
          ).px(10),
          16.verticalBox,
          SelectCategoryWidget(categories: categories),
        ],
      ),
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
