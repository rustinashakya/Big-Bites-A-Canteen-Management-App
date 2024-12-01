import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/pages/dashboard_page/cart_page/cart_page.dart';
import 'package:big_bites/pages/dashboard_page/favorite_page/favorite_page.dart';
import 'package:big_bites/pages/dashboard_page/home_page/home_page.dart';
import 'package:big_bites/pages/dashboard_page/menu_page/menu_page.dart';
import 'package:big_bites/pages/dashboard_page/track_order_page/track_order_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isStaff = true;
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: IndexedStack(
          index: currentIndex,
          children: [
            HomePage(
              isStaff: isStaff,
            ),
            MenuPage(
              isStaff: isStaff,
            ),
            CartPage(
              isStaff: isStaff,
            ),
            TrackOrderPage(
              isStaff: isStaff,
            ),
            FavoritePage(
              isStaff: isStaff,
            )
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
                displayIcon: currentIndex == 0
                    ? AppIcons.homeSelected
                    : AppIcons.homeUnselected),
            _bottomNavigationBarItem(
                displayIcon: currentIndex == 1
                    ? AppIcons.menuSelected
                    : AppIcons.menuUnselected),
            _bottomNavigationBarItem(
                displayIcon: currentIndex == 2
                    ? AppIcons.cartSelected
                    : AppIcons.cartUnselected),
            _bottomNavigationBarItem(
                displayIcon: currentIndex == 3
                    ? AppIcons.trackerSelected
                    : AppIcons.trackerUnselected),
            _bottomNavigationBarItem(
                displayIcon: currentIndex == 4
                    ? AppIcons.favoriteSelected
                    : AppIcons.favoriteUnselected),
          ]),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      {required String displayIcon}) {
    return BottomNavigationBarItem(
      label: '',
      icon: Image.asset(
        displayIcon,
      ),
    );
  }
}
