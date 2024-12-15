import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:flutter/material.dart';

class SelectCategoryWidget extends StatefulWidget {
  const SelectCategoryWidget({super.key, required this.categories, required this.onCategorySelected});
  final List<String> categories;
  final ValueChanged<String> onCategorySelected;

  @override
  State<SelectCategoryWidget> createState() => _SelectCategoryWidgetState();
}

class _SelectCategoryWidgetState extends State<SelectCategoryWidget> {
  int selectedIndex = 0; 

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: widget.categories.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              // 
              widget.onCategorySelected(widget.categories[index]);
            },
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              color: isSelected
                  ? AppColors.black
                  : AppColors.primaryColor,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.categories[index],
                    style: Fonts.bodyLargeInter.copyWith(
                      color: isSelected
                          ? Colors.white
                          : const Color.fromARGB(255, 26, 25, 25),
                    ),
                  ),
                ),
              ),
            ).py(15).px(8),
          );
        },
      ),
    );
  }
}
