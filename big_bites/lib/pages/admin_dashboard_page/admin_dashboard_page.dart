import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_home_page/admin_home_page.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_menu_page/admin_menu_page.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_orders_page/admin_order_page.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_profile_page/admin_profile_page.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_track_orders_page/admin_track_order_page.dart';
import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  final int initialIndex;

  const AdminDashboardPage({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 12, right: 12, bottom: 20),
        child: IndexedStack(
          index: currentIndex,
          children: [
            AdminHomePage(),
            AdminMenuPage(),
            AdminCartPage(),
            AdminTrackOrderPage(),
            AdminProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryColor,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          _bottomNavigationBarItem(
            selectedIcon: AppIcons.homeSelected,
            unselectedIcon: AppIcons.homeUnselected,
            isSelected: currentIndex == 0,
            selectedWidth: 36,
            selectedHeight: 36,
            unselectedWidth: 23,
            unselectedHeight: 23,
          ),
          _bottomNavigationBarItem(
            selectedIcon: AppIcons.menuSelected,
            unselectedIcon: AppIcons.menuUnselected,
            isSelected: currentIndex == 1,
            selectedWidth: 26,
            selectedHeight: 26,
            unselectedWidth: 34,
            unselectedHeight: 34,
          ),
          _bottomNavigationBarItem(
            selectedIcon: AppIcons.cartSelected,
            unselectedIcon: AppIcons.cartUnselected,
            isSelected: currentIndex == 2,
            selectedWidth: 26,
            selectedHeight: 26,
            unselectedWidth: 40,
            unselectedHeight: 40,
          ),
          _bottomNavigationBarItem(
            selectedIcon: AppIcons.trackerSelected,
            unselectedIcon: AppIcons.trackerUnselected,
            isSelected: currentIndex == 3,
            selectedWidth: 26,
            selectedHeight: 26,
            unselectedWidth: 34,
            unselectedHeight: 34,
          ),
          _bottomNavigationBarItem(
            selectedIcon: AppIcons.userSelected,
            unselectedIcon: AppIcons.userUnselected,
            isSelected: currentIndex == 4,
            selectedWidth: 24.5,
            selectedHeight: 24.5,
            unselectedWidth: 24.5,
            unselectedHeight: 24.5,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required String selectedIcon,
    required String unselectedIcon,
    required bool isSelected,
    required double selectedWidth,
    required double selectedHeight,
    required double unselectedWidth,
    required double unselectedHeight,
  }) {
    return BottomNavigationBarItem(
      label: '',
      icon: SizedBox(
        width: isSelected ? selectedWidth : unselectedWidth,
        height: isSelected ? selectedHeight : unselectedHeight,
        child: Image.asset(
          isSelected ? selectedIcon : unselectedIcon,
        ),
      ),
    );
  }
}