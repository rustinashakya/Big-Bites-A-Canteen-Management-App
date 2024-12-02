import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.notificationMessage});
  final String notificationMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
                color: AppColors.grey.withOpacity(0.3),
                blurRadius: 5,
                offset: Offset(0, 5)),
          ]),
      child: Text(
        notificationMessage,
        style: Fonts.bodyLargeInter,
      ),
    ).py(8);
  }
}
