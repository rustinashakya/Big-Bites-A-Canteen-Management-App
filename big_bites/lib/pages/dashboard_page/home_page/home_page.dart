import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitleWidget(
            title: 'Big Bites',
          ),
        ],
      ),
    );
  }
}
