import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/addmenu.dart';
import 'package:big_bites/pages/common_widget/search_widget.dart';
import 'package:big_bites/pages/dashboard_page/menu_page/widgets/item_staff_widget.dart';
import 'package:flutter/material.dart';

import '../../common_widget/top_title_widget.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key, required this.isStaff});
  final bool isStaff;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopTitleWidget(
          title: "Today's Menu",
          isStaff: isStaff,
          isTodayMenu: isStaff,
          onAddButtonClicked: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddMenu()));
          },
        ),
        10.verticalBox,
        SearchWidget(),
        15.verticalBox,
        Expanded(
          child: SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items in a row
                crossAxisSpacing: 10.0, // Space between items horizontally
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.8, // Space between items vertically
              ),
              itemCount: 6,
              // Total number of items
              itemBuilder: (context, index) {
                return ItemStaffWidget();
              },
            ),
          ),
        )
      ],
    );
  }
}
