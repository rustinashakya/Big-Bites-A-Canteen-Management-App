import 'package:flutter/material.dart';

import '../../common_widget/top_title_widget.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopTitleWidget(
            title: "Track your orders",
          )
        ],
      ),
    );
    ;
  }
}
