import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:flutter/material.dart';

class SelectCategoryWidget extends StatefulWidget {
  const SelectCategoryWidget({super.key, required this.categories});
  final List<String> categories;

  @override
  State<SelectCategoryWidget> createState() => _SelectCategoryWidgetState();
}

class _SelectCategoryWidgetState extends State<SelectCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ListView.builder(
          itemCount: widget.categories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return AppButtonWidget(
              elevation: 10,
              child: Text(
                widget.categories[index],
                style: AppTextStyle.bodyLargeInter,
              ).px(5),
            ).py(20).px(8);
          }),
    );
  }
}
