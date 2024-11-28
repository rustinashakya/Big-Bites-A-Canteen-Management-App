import 'package:big_bites/context/app_colors.dart';
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
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IndexedStack(
          index: currentIndex,
          children: const [
            HomePage(),
            MenuPage(),
            CartPage(),
            TrackOrderPage(),
            FavoritePage()
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
            BottomNavigationBarItem(
                icon:

                    // currentIndex == 0
                    //     ? SvgPicture.asset(
                    //         AppIcons.homeSelected,
                    //       )
                    //     : SvgPicture.asset(
                    //         'assets/icons/home_icon.svg',
                    //         height: 15,
                    //         width: 15,
                    //       ),
                    Icon(
                  currentIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: Colors.black,
                ),
                label: "",
                backgroundColor: AppColors.primaryColor),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu_outlined,
                  color: Colors.black,
                ),
                label: "",
                backgroundColor: AppColors.primaryColor),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
                label: "",
                backgroundColor: AppColors.primaryColor),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.timer,
                  color: Colors.black,
                ),
                label: "",
                backgroundColor: AppColors.primaryColor),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
                label: "",
                backgroundColor: AppColors.primaryColor),
          ]),
    );
  }
}
