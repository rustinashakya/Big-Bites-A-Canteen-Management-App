import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:big_bites/pages/detail_page/widget/name_review_favorite_widget.dart';
import 'package:big_bites/pages/detail_page/widget/quantity_add_sub_widget.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(), // Set white background for the page
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(Images.doubleCheese)),
              20.verticalBox,
              NameReviewFavoriteWidget(),
              40.verticalBox,
              Text(
                demoDetailInfo,
                style: AppTextStyle.bodyMediumInter,
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Text(
                "Quantity",
                style: AppTextStyle.bodyMediumInter,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              QuantityAddSubWidget(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButtonWidget(
                    child: Text(
                      "Rs 300",
                      style: AppTextStyle.labelLargeInter,
                    ).px(20).py(10),
                  ),
                  AppButtonWidget(
                    color: AppColors.buttonRed,
                    child: Text(
                      "Add",
                      style: AppTextStyle.labelLargeInter
                          .copyWith(color: Colors.white),
                    ).px(20).py(10),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
