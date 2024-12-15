import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_orders_page/widget/admin_order_placed_widget.dart';
import 'package:big_bites/pages/common_widget/admin_top_title_widget.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:big_bites/context/fonts.dart';

class AdminCartPage extends StatelessWidget {
  const AdminCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminTopTitleWidget(
          title: "Orders",
        ),
        10.verticalBox,
        Expanded(
          child: AdminOrderPage(),
        ),
      ],
    );
  }
}

class AdminOrderPage extends StatelessWidget {
  const AdminOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .orderBy('orderDateTime', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading orders: ${snapshot.error}',
              style: Fonts.bodyMediumInter,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final orders = snapshot.data?.docs ?? [];

        if (orders.isEmpty) {
          return Center(
            child: Text(
              'No orders available',
              style: Fonts.bodyMediumInter,
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: orders.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final order = orders[index].data() as Map<String, dynamic>;
            final orderId = orders[index].id;
            final userId = order['userId'] as String? ?? '';

            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .snapshots(),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasError) {
                  return const SizedBox();
                }

                final userData =
                    userSnapshot.data?.data() as Map<String, dynamic>?;
                final firstName = userData?['First Name'] as String? ?? '';
                final lastName = userData?['Last Name'] as String? ?? '';
                final fullName = '$firstName $lastName'.trim();

                return OrderPlacedWidget(
                  orderId: orderId,
                  userId: userId,
                  orderName: order['orderName'] ?? '',
                  totalPrice: (order['totalPrice'] ?? 0).toInt(),
                  paymentMethod: order['paymentMethod'] ?? '',
                  orderStatus: order['orderStatus'] ?? 'pending',
                  paymentStatus: order['paymentStatus'] ?? 'pending',
                  onPaymentComplete: () async {
                    try {
                      // Update payment status
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(orderId)
                          .update({
                        'paymentStatus': 'Completed',
                      });

                      // Also update in user's orders
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .collection('orders')
                          .doc(orderId)
                          .update({
                        'paymentStatus': 'Completed',
                      });

                      // Add notification for user
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .collection('notifications')
                          .add({
                        'message':
                            'Payment confirmed for order #$orderId. Your order is being prepared. 😊 \n Customer: $fullName\nOrder Items: ${order['orderName']}\nTotal Amount: Rs. ${order['totalPrice']}/-',
                        'timestamp': DateTime.now().toIso8601String(),
                        'isRead': false,
                        'type': 'payment_confirmed',
                        'orderId': orderId
                      });

                      // Add notification for admin
                      await FirebaseFirestore.instance
                          .collection('admin')
                          .doc('notifications')
                          .collection('orders')
                          .add({
                        'message':
                            '$fullName has paid for order #$orderId\nOrder Items: ${order['orderName']}\nPayment Method: ${order['paymentMethod']}\nTotal Amount: Rs. ${order['totalPrice']}/-',
                        'timestamp': DateTime.now().toIso8601String(),
                        'isRead': false,
                        'type': 'payment_received',
                        'orderId': orderId
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Payment status updated successfully'),
                          backgroundColor: AppColors.successColor,
                        ),
                      );
                    } catch (e) {
                      print('Error updating payment status: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to update payment status'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  onOrderComplete: () async {
                    try {
                      // Update order status in main collection
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(orderId)
                          .update({
                        'orderStatus': 'Completed',
                      });

                      // Update order status in user's collection
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .collection('orders')
                          .doc(orderId)
                          .update({
                        'orderStatus': 'Completed',
                      });

                      // Add notification for user
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .collection('notifications')
                          .add({
                        'message':
                            'Your order #$orderId is ready for pickup! 😊🎉\nCustomer: $fullName\nOrder Items: ${order['orderName']}\nTotal Amount: Rs. ${order['totalPrice']}/-',
                        'timestamp': DateTime.now().toIso8601String(),
                        'isRead': false,
                        'type': 'order_completed',
                        'orderId': orderId
                      });

                      // Add notification for admin
                      await FirebaseFirestore.instance
                          .collection('admin')
                          .doc('notifications')
                          .collection('orders')
                          .add({
                        'message':
                            'Order #$orderId is completed Customer: $fullName\nOrder Items: ${order['orderName']}',
                        'timestamp': DateTime.now().toIso8601String(),
                        'isRead': false,
                        'type': 'order_completed',
                        'orderId': orderId
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Order marked as completed'),
                          backgroundColor: AppColors.successColor,
                        ),
                      );
                    } catch (e) {
                      print('Error completing order: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to complete order'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  onCancel: () async {
                    final shouldCancel = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Cancel Order',
                          style: Fonts.bodyMediumInter,
                        ),
                        content: Text(
                          'Are you sure you want to cancel this order?',
                          style: Fonts.bodyMediumInter,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(
                              'No',
                              style: Fonts.bodyMediumInter
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(
                              'Yes',
                              style: Fonts.bodyMediumInter
                                  .copyWith(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (shouldCancel == true) {
                      try {
                        // Update main orders collection
                        await FirebaseFirestore.instance
                            .collection('orders')
                            .doc(orderId)
                            .update({
                          'orderStatus': 'Cancelled',
                          'paymentStatus': 'Cancelled',
                        });

                        // Update user's orders subcollection
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('orders')
                            .doc(orderId)
                            .update({
                          'orderStatus': 'Cancelled',
                          'paymentStatus': 'Cancelled',
                        });

                        // Add notification for user
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('notifications')
                            .add({
                          'message':
                              'Your order #$orderId has been cancelled by the admin since no payment was made.',
                          'timestamp': DateTime.now().toIso8601String(),
                          'isRead': false,
                          'type': 'order_cancelled',
                          'orderId': orderId
                        });

                        // Add notification for admin
                        await FirebaseFirestore.instance
                            .collection('admin')
                            .doc('notifications')
                            .collection('orders')
                            .add({
                          'message':
                              'Order #$orderId has been cancelled Customer: $fullName\nOrder Items: ${order['orderName']}\nTotal Amount: Rs. ${order['totalPrice']}/-',
                          'timestamp': DateTime.now().toIso8601String(),
                          'isRead': false,
                          'type': 'order_cancelled',
                          'orderId': orderId
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Order cancelled successfully'),
                            backgroundColor: AppColors.successColor,
                          ),
                        );
                      } catch (e) {
                        print('Error cancelling order: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Failed to cancel order. Please try again.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
