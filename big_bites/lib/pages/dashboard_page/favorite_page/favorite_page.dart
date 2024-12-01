import 'package:flutter/material.dart';

import '../../common_widget/top_title_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key, required this.isStaff});
  final bool isStaff;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitleWidget(
            title: "My Favorites",
            isStaff: isStaff,
          )
        ],
      ),
    );
    ;
  }
}
