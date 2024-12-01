import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/search_widget.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:big_bites/pages/dashboard_page/cart_page/widget/order_placed_widget.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.isStaff});
  final bool isStaff;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopTitleWidget(
          title: "My cart",
          isStaff: isStaff,
        ),
        10.verticalBox,
        SearchWidget(),
        10.verticalBox,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                OrderPlacedWidget(),
                OrderPlacedWidget(
                  isPaid: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
