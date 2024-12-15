import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_track_orders_page/widget/admin_notification_widget.dart';
import 'package:big_bites/pages/common_widget/admin_top_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../common_widget/top_title_widget.dart';

class AdminTrackOrderPage extends StatefulWidget {
  const AdminTrackOrderPage({super.key});

  @override
  State<AdminTrackOrderPage> createState() => _AdminTrackOrderPageState();
}

class _AdminTrackOrderPageState extends State<AdminTrackOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminTopTitleWidget(
          title: "Track Orders",
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('admin')
                .doc('notifications')
                .collection('orders')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error loading notifications'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final notifications = snapshot.data?.docs ?? [];

              if (notifications.isEmpty) {
                return Center(
                  child: Text('No notifications yet',
                    style: Fonts.bodyMediumInter,),
                );
              }

              return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  final notificationData = notification.data() as Map<String, dynamic>;
                  final message = notificationData['message'] as String? ?? '';
                  final timestamp = DateTime.parse(notificationData['timestamp'] as String? ?? DateTime.now().toIso8601String());
                  final timeAgo = _getTimeAgo(timestamp);

                  return Dismissible(
                    key: Key(notification.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Delete Notification',
                            style: Fonts.bodyMediumInter,
                          ),
                          content: Text(
                            'Are you sure you want to delete this notification?',
                            style: Fonts.bodyMediumInter,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                'No',
                                style: Fonts.bodyMediumInter.copyWith(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(
                                'Yes',
                                style: Fonts.bodyMediumInter.copyWith(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onDismissed: (direction) async {
                      try {
                        await FirebaseFirestore.instance
                            .collection('admin')
                            .doc('notifications')
                            .collection('orders')
                            .doc(notification.id)
                            .delete();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Notification deleted'),
                            backgroundColor: AppColors.successColor,
                          ),
                        );
                      } catch (e) {
                        print('Error deleting notification: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to delete notification'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: AdminNotificationWidget(
                      notificationMessage: '$message\n$timeAgo',
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}