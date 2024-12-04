import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../../context/app_colors.dart';
import '../../../../context/fonts.dart';
import '../../../../context/images.dart';

class ItemStaffWidget extends StatelessWidget {
  ItemStaffWidget({super.key, this.onItemClick});
  final VoidCallback? onItemClick;
  bool isStaff = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemClick,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Even lighter for sides
              blurRadius: 10,
              offset: Offset(-5, 0), // Left shadow
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Even lighter for sides
              blurRadius: 10,
              offset: Offset(5, 0), // Right shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                AppIcons.friedChickenBurger,
              ),
            ),
            Text(
              'Double Cheese Burger',
              style: AppTextStyle.bodyMediumInter,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            isStaff
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(AppIcons.editItemIcon)),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(AppIcons.deleteItemIcon)),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      AppButtonWidget(
                          child: Text(
                        "Done",
                        style: AppTextStyle.bodyMediumInter
                            .copyWith(color: Colors.white),
                      ))
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
