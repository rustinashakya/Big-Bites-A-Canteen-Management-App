import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/pages/log_in.dart';
import 'package:big_bites/pages/sign_up.dart';
import 'package:flutter/material.dart'; // Ensure this is the correct import path

class WelcomeUserPage extends StatefulWidget {
  const WelcomeUserPage({super.key});

  @override
  State<WelcomeUserPage> createState() => _WelcomeUserPageState();
}

class _WelcomeUserPageState extends State<WelcomeUserPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image
            Image.asset(
              'assets/images/sign_in/top_surface.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 15.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // TabBar for switching
                  TabBar(
                    controller: tabController,
                    unselectedLabelColor: AppColors.black,
                    labelColor: AppColors.black,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 4.0,
                        color: AppColors.yellow,
                      ),
                    ),
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Sign In', style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Sign Up', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                  // TabBarView for displaying pages
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        LogInPage(), // Sign In Page
                        SignUpPage(), // Sign Up Page
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
