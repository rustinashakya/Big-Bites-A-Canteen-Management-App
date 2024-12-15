import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_profile_page/widget/admin_profile.dart';
import 'package:big_bites/pages/common_widget/admin_top_title_widget.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:big_bites/pages/dashboard_page/profile_page/widget/profile.dart';
import 'package:flutter/material.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AdminTopTitleWidget(
            title: "Admin's Profile",
          ),
          Expanded(
            child: Center(
              child: AdminProfile(),
            ), 
          ),
        ],
      ),
    );
  }
}
