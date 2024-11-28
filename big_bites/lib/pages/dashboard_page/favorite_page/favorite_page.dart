import 'package:flutter/material.dart';

import '../../common_widget/top_title_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          TopTitleWidget(
            title: "My Favorites",
          )
        ],
      ),
    );
  }
}
