import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/model/content_model.dart';
import 'package:big_bites/pages/admin/admin_log_in.dart';
import 'package:big_bites/pages/log_in.dart';
import 'package:big_bites/pages/welcome.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:flutter/material.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40), 
              SizedBox(
                height: 600,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Image.asset(
                            contents[i].image,
                            height: 450,
                            width: MediaQuery.of(context).size.width,
                          ),
                          SizedBox(height: 40.0),
                          Text(contents[i].title, style: Fonts.bodyLargeInter.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                          SizedBox(height: 10.0),
                          Text(contents[i].description, 
                              style: Fonts.bodyMediumInter, textAlign: TextAlign.center,),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                ),
              ),
              SizedBox(height: 20), 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppButtonWidget(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  borderRadius: 60,
                  color: AppColors.primaryColor,
                  onButtonPressed: () {
                    if (currentIndex == contents.length - 1) {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => WelcomeUserPage()));
                    } else {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
                    }
                  },
                  child: Text(
                    currentIndex == contents.length - 1?"Start":"Next",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 0),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AdminLoginPage()),
                    );
                  },
                  child: const Text(
                    'Admin ?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.lightgrey,
                    ),
                  ),
                ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.0,
      width: currentIndex == index ? 18 : 7,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: AppColors.grey),
    );
  }
}
