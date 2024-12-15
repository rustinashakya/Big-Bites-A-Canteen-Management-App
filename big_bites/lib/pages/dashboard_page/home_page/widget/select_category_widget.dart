import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/service/app.dart';
import 'package:flutter/material.dart';

class SelectCategoryWidget extends StatefulWidget {
  const SelectCategoryWidget({super.key, required this.categories, required this.onCategorySelected});
  final List<String> categories;
  final ValueChanged<String> onCategorySelected; // Callback to pass selected category

  @override
  State<SelectCategoryWidget> createState() => _SelectCategoryWidgetState();
}

class _SelectCategoryWidgetState extends State<SelectCategoryWidget> {
  int selectedIndex = 0;

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


// class SelectCategoryWidget extends StatefulWidget {
//   const SelectCategoryWidget({super.key, required this.categories});
//   final List<String> categories;

//   @override
//   State<SelectCategoryWidget> createState() => _SelectCategoryWidgetState();
// }

// class _SelectCategoryWidgetState extends State<SelectCategoryWidget> {
//   int selectedIndex = 0; 

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 70,
//       child: ListView.builder(
//         itemCount: widget.categories.length,
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           bool isSelected = index == selectedIndex;
//           return GestureDetector(
//             onTap: () async{
//               if(selectedIndex==0){
//                 fooditemStream = await DatabaseMethods().getFoodItem("momo");
//               }
//               if(selectedIndex==1){
//                 fooditemStream = await DatabaseMethods().getFoodItem("burger");
//               }
//               if(selectedIndex==2){
//                 fooditemStream = await DatabaseMethods().getFoodItem("pizza");
//               }
//               if(selectedIndex==3){
//                 fooditemStream = await DatabaseMethods().getFoodItem("hot beverages");
//               }
//               if(selectedIndex==4){
//                 fooditemStream = await DatabaseMethods().getFoodItem("cold beverages");
//               }
//               setState(() {
//                 selectedIndex = index; 
//               });
//             },
//             child: Material(
//               elevation: 4,
//               borderRadius: BorderRadius.circular(20),
//               color: isSelected
//                   ? AppColors.black 
//                   : AppColors.primaryColor, 
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Text(
//                     widget.categories[index],
//                     style: Fonts.bodyLargeInter.copyWith(
//                       color: isSelected
//                           ? Colors.white // Selected text color
//                           : const Color.fromARGB(255, 26, 25, 25), // Default text color
//                     ),
//                   ),
//                 ),
//               ),
//             ).py(15).px(8),
//           );
//         },
//       ),
//     );
//   }
// }
