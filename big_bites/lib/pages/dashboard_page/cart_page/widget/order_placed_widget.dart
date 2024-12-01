import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../../context/images.dart';

class OrderPlacedWidget extends StatelessWidget {
  const OrderPlacedWidget({super.key, this.isPaid = false});
  final bool isPaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: isPaid ? AppColors.primaryColor : AppColors.unpaidOrder,
          boxShadow: [
            BoxShadow(color: AppColors.grey.withOpacity(0.3), blurRadius: 5),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Order Placed by Ashwinsha',
                  maxLines: 2,
                  style: Fonts.bodyLargeInter,
                ),
              ),
              SizedBox(
                  height: 50,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Image.asset(Images.profileImage),
                  )),
            ],
          ),
          16.verticalBox,
          _OrderPlacedKeyValue(
            title: 'Order Name',
            value: 'Double Cheese Burger and Buff Jhol Momo',
          ),
          10.verticalBox,
          _OrderPlacedKeyValue(
            title: 'Total Price',
            value: 'Rs. 300/-',
          ),
          10.verticalBox,
          _OrderPlacedKeyValue(
            title: 'Payment Method',
            value: 'Cash Payment',
          ),
          10.verticalBox,
          _OrderPlacedKeyValue(
            title: 'Payment Status',
            value: isPaid ? 'Paid' : 'Unpaid',
          ),
          10.verticalBox,
          _OrderPlacedKeyValue(
            title: 'Order Status',
            value: 'Pending',
          ),
          20.verticalBox,
          isPaid
              ? Column(
                  children: [
                    AppButtonWidget(
                      height: 60,
                      width: double.infinity,
                      color: AppColors.buttonGreen,
                      child: Text(
                        'Payment Done',
                        style:
                            Fonts.labelLargeInter.copyWith(color: Colors.white),
                      ),
                    ),
                    10.verticalBox,
                    AppButtonWidget(
                        height: 60,
                        width: double.infinity,
                        color: AppColors.buttonRed,
                        child: Text('Order Completed',
                            style: Fonts.labelLargeInter
                                .copyWith(color: Colors.white))),
                  ],
                ).py(10)
              : Row(
                  children: [
                    Expanded(
                      child: AppButtonWidget(
                        height: 60,
                        color: AppColors.buttonGreen,
                        child: Text(
                          'Accept',
                          style: Fonts.labelLargeInter
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    10.horizontalBox,
                    Expanded(
                        child: AppButtonWidget(
                            height: 60,
                            color: AppColors.buttonRed,
                            child: Text('Deny',
                                style: Fonts.labelLargeInter
                                    .copyWith(color: Colors.white)))),
                  ],
                )
        ],
      ),
    ).py(16);
  }
}

class _OrderPlacedKeyValue extends StatelessWidget {
  const _OrderPlacedKeyValue(
      {super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
          style: Fonts.bodyMediumInter.copyWith(fontWeight: FontWeight.w700),
        )),
        Expanded(
            child: Text(
          value,
          style: Fonts.bodyMediumInter,
        )),
      ],
    );
  }
}
