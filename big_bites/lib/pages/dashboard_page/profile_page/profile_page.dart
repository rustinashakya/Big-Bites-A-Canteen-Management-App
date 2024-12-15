import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:big_bites/pages/dashboard_page/profile_page/widget/profile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TopTitleWidget(
            title: "My Profile",
          ),
          Expanded(
            child: Center(
              child: Profile(),
            ), 
          ),
        ],
      ),
    );
  }
}
