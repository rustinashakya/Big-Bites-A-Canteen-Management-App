import 'package:flutter/material.dart';

import '../../common_widget/top_title_widget.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          TopTitleWidget(
            title: "Today's Menu",
          ),
        ],
      ),
    );
  }
}
