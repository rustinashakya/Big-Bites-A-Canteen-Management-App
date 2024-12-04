import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:flutter/material.dart';

class TopTitleWidget extends StatelessWidget {
  const TopTitleWidget(
      {super.key,
      required this.title,
      this.isStaff = false,
      this.onAddButtonClicked,
      this.isTodayMenu = false});

  final bool isStaff;

  final String title;
  final bool isTodayMenu;
  final VoidCallback? onAddButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.topTitleLargeKaushan,
            ),
          ),
          isStaff
              ? (isTodayMenu
                  ? IconButton(
                      onPressed: onAddButtonClicked,
                      icon: Image.asset(AppIcons.addMenu))
                  : SizedBox.shrink())
              : SizedBox(
                  height: 50,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Image.asset(Images.profileImage),
                  )),
        ],
      ),
    );
  }
}
