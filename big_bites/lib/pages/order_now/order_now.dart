import 'package:big_bites/constant/esewa_pay.dart';
import 'package:flutter/material.dart';
import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/pages/common_widget/loading_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';
import 'package:flutter/services.dart';

class OrderNow extends StatefulWidget {
  final int totalPrice;
  final List<Map<String, dynamic>> orderItems;

  const OrderNow({
    Key? key,
    required this.totalPrice,
    required this.orderItems,
  }) : super(key: key);

  @override
  _OrderNowState createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  String selectedPaymentMethod = 'ESewa';
  bool isLoading = false;
  String? orderId;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  void _generateOrderId() {
    DateTime now = DateTime.now();
    String month = DateFormat('MMM').format(now).toLowerCase();
    String day = now.day.toString();
    String timestamp = DateFormat('HHmmss').format(now);
    orderId = '${month}${day}_$timestamp';
  }

  Future<void> _loadUserId() async {
    final id = await SharedPreferencesHelper().getUserId();
    setState(() {
      userId = id;
    });
  }

  Future<void> _placeOrder() async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please wait while we process your order'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final DateTime now = DateTime.now();
      final DateTime paymentDeadline = now.add(Duration(minutes: 15));

      // Generate new order ID for each order
      _generateOrderId();

      // Create order data
      final orderData = {
        'orderId': orderId,
        'userId': userId,
        'orderItems': widget.orderItems,
        'orderName': _buildOrderItemsList(),
        'totalPrice': widget.totalPrice,
        'pickUpTime': _calculateEstimatedTime(),
        'paymentMethod': selectedPaymentMethod,
        'paymentStatus': 'pending',
        'orderStatus': 'pending',
        'orderDateTime': now.toIso8601String(),
        'paymentDeadline': paymentDeadline.toIso8601String(),
      };

      // Store in Firestore
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .set(orderData);

      // Also store in user's orders subcollection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .set(orderData);

      // Add notification for all orders
      final notificationData = {
        'message': 'Your order #$orderId has been placed successfully. Please make the payment within 15 minutes to proceed with your order. 😊',
        'timestamp': now.toIso8601String(),
        'isRead': false,
        'type': 'order_placed',
        'orderId': orderId
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .add(notificationData);

      // Get user's name for admin notification
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final userData = userDoc.data();
      final firstName = userData?['First Name'] as String? ?? '';
      final lastName = userData?['Last Name'] as String? ?? '';
      final fullName = '$firstName $lastName'.trim();

      // Add notification for admin
      await FirebaseFirestore.instance
          .collection('admin')
          .doc('notifications')
          .collection('orders')
          .add({
        'message': '$fullName has placed an order #$orderId\nOrder Items: ${_buildOrderItemsList()}\nPayment Method: $selectedPaymentMethod\nTotal Amount: Rs. ${widget.totalPrice}/-',
        'timestamp': now.toIso8601String(),
        'isRead': false,
        'type': 'new_order',
        'orderId': orderId
      });

      // If ESewa is selected, initiate payment
      if (selectedPaymentMethod == 'ESewa') {
        _handleEsewaPayment();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(selectedPaymentMethod == 'Cash Payment' 
              ? 'Order placed successfully! Please proceed to make the cash payment.'
              : 'Order placed successfully! Please complete payment within 15 minutes.'),
          backgroundColor: AppColors.successColor,
          duration: Duration(seconds: 5),
        ),
      );

      if (selectedPaymentMethod != 'ESewa') {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error placing order: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to place order. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _buildOrderItemsList() {
    return widget.orderItems.map((item) {
      return '${item['Name']} - ${item['Quantity']}';
    }).join('\n');
  }

  String _calculateEstimatedTime() {
    int baseTime = 5;
    int uniqueItems = widget.orderItems.length;
    int totalQuantity = widget.orderItems
        .fold(0, (sum, item) => sum + (item['Quantity'] as int? ?? 0));

    int additionalTime = 0;
    if (uniqueItems == 1) {
      additionalTime = (totalQuantity - 1) * 2;
    } else {
      additionalTime = (totalQuantity - 1) * 2 + (uniqueItems - 1) * 3;
    }

    int totalTime = (baseTime + additionalTime).clamp(5, 30);
    int variance = totalTime <= 10 ? 1 : 2;
    int minTime = (totalTime - variance).clamp(5, 30);
    int maxTime = (totalTime + variance).clamp(5, 30);

    return '$minTime - $maxTime Minutes';
  }

  void _handleEsewaPayment() {
    if (orderId != null) {
      Esewa.pay(
        orderId: orderId!,
        orderName: _buildOrderItemsList(),
        totalPrice: widget.totalPrice,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Order Summary',
                        style: Fonts.titleLargeInter
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      _buildSummaryItem(
                        Text(
                          'Order ID',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          orderId ?? '',
                          style: Fonts.bodyMediumInter,
                        ),
                      ),
                      _buildSummaryItem(
                        Text(
                          'Order Name',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          _buildOrderItemsList(),
                          style: Fonts.bodyMediumInter,
                        ),
                      ),
                      _buildSummaryItem(
                        Text(
                          'Total Price',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Rs. ${widget.totalPrice}/-',
                          style: Fonts.bodyMediumInter
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                      _buildSummaryItem(
                        Text(
                          'Pick Up Time',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          _calculateEstimatedTime(),
                          style: Fonts.bodyMediumInter
                              .copyWith(color: Colors.green[600]),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Payment Methods',
                        style: Fonts.titleLargeInter
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      _buildPaymentOption(
                        Text(
                          'ESewa',
                          style: TextStyle(
                            fontSize: 18,
                            color: selectedPaymentMethod == 'ESewa'
                                ? AppColors.successColor
                                : Colors.black,
                          ),
                        ),
                        Icons.account_balance_wallet,
                        Colors.grey[200]!,
                      ),
                      const SizedBox(height: 10),
                      _buildPaymentOption(
                        Text(
                          'Cash Payment',
                          style: TextStyle(
                            fontSize: 18,
                            color: selectedPaymentMethod == 'Cash Payment'
                                ? AppColors.successColor
                                : Colors.black,
                          ),
                        ),
                        Icons.money,
                        Colors.grey[200]!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Price',
                        style: Fonts.bodyMediumInter.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Rs. ${widget.totalPrice}/-',
                        style: Fonts.bodyLargeInter.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 150,
                    child: LoadingButtonWidget(
                      onPressed: _placeOrder,
                      isLoading: isLoading,
                      color: AppColors.successColor,
                      child: Text(
                        'Pay Now',
                        style: Fonts.bodyMediumInter.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(Widget title, Widget value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: title,
          ),
          Expanded(
            child: value,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
    Widget title,
    IconData icon,
    Color backgroundColor, {
    String? subtitle,
  }) {
    bool isSelected = selectedPaymentMethod == (title as Text).data;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = (title as Text).data!;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[50] : backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.successColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.successColor : Colors.black),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                ],
              ),
            ),
            Radio(
              value: (title as Text).data!,
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedPaymentMethod = value.toString();
                  });
                }
              },
              activeColor: AppColors.successColor,
            ),
          ],
        ),
      ),
    );
  }
}
