import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/pages/dashboard_page/track_order_page/widget/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';
import '../../common_widget/top_title_widget.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({super.key});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await SharedPreferencesHelper().getUserId();
    if (mounted) {
      setState(() {
        userId = id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .where('isRead', isEqualTo: false)
          .snapshots(),
      builder: (context, unreadSnapshot) {
        int unreadCount = unreadSnapshot.hasData ? unreadSnapshot.data!.docs.length : 0;
        
        return Column(
          children: [
            TopTitleWidget(
              title: "Track Orders",
              suffix: unreadCount > 0 
                ? Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('notifications')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
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
                      final notification = notifications[index].data() as Map<String, dynamic>;
                      final message = notification['message'] as String;

                      // Mark notification as read when displayed
                      if (notification['isRead'] == false) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('notifications')
                            .doc(notifications[index].id)
                            .update({'isRead': true});
                      }

                      return Dismissible(
                        key: Key(notifications[index].id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .collection('notifications')
                              .doc(notifications[index].id)
                              .delete();
                        },
                        child: NotificationWidget(
                          notificationMessage: message,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}