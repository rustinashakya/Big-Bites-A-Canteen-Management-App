import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:flutter/material.dart';

class CustomerOrderListWidget extends StatelessWidget {
  const CustomerOrderListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: AppColors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Double Cheese Burger",
                style: AppTextStyle.bodyMediumInter,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.yellow,
                  ),
                  Text(
                    '4.9',
                    style: AppTextStyle.bodyMediumInter,
                  )
                ],
              ),
              Text(
                'Quantity - 1',
                style: AppTextStyle.bodyMediumInter,
              ),
              AppButtonWidget(
                color: AppColors.primaryColor,
                child: Text(
                  'Rs. 150/-',
                  style: AppTextStyle.bodyMediumInter,
                ),
              ),
            ],
          ),
          Expanded(child: Image.asset(Images.doubleCheese))
        ],
      ),
    ).py(8);
  }
}
