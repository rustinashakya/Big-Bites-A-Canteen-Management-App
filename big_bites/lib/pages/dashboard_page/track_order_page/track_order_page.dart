import 'package:big_bites/pages/dashboard_page/track_order_page/widget/notification_widget.dart';
import 'package:flutter/material.dart';

import '../../common_widget/top_title_widget.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key, required this.isStaff});
  final bool isStaff;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopTitleWidget(
          title: isStaff ? "Track Orders/Payments" : "Track your orders",
          isStaff: isStaff,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return NotificationWidget(
                      notificationMessage:
                          "Please wait. You will be notified as soon as your order is ready.");
                }))
      ],
    );
  }
}
