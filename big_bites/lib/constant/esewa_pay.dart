import 'package:big_bites/constant/esewa.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Esewa {
  static const String callbackUrl = "https://bigbites.com/payment/verify";

  static void pay({
    required String orderId, 
    required String orderName, 
    required int totalPrice,
  }) {
    try {
      final payment = EsewaPayment(
        productId: orderId,
        productName: orderName,
        productPrice: totalPrice.toString(),
        callbackUrl: callbackUrl,
      );

      final config = EsewaConfig(
        clientId: kEsewaClientId,
        secretId: kESewaSecretKey,
        environment: Environment.test,
      );

      EsewaFlutterSdk.initPayment(
        esewaPayment: payment,
        esewaConfig: config,
        onPaymentSuccess: (EsewaPaymentSuccessResult result) async {
          debugPrint('Payment Successful');
          await _updatePaymentStatus(
            orderId: orderId,
            status: 'completed',
            transactionId: result.refId,
          );
        }, 
        onPaymentFailure: () async {
          debugPrint('Payment Failed');
          await _updatePaymentStatus(
            orderId: orderId,
            status: 'failed'
          );
        }, 
        onPaymentCancellation: () async {
          debugPrint('Payment Cancelled');
          await _updatePaymentStatus(
            orderId: orderId,
            status: 'cancelled'
          );
        }
      );
    } catch(e) {
      debugPrint('Payment Exception: $e');
      _updatePaymentStatus(
        orderId: orderId,
        status: 'failed',
        error: e.toString()
      );
    }
  }

  static Future<void> _updatePaymentStatus({
    required String orderId,
    required String status,
    String? transactionId,
    String? error,
  }) async {
    try {
      // Get the order to find the userId
      final orderDoc = await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .get();
      
      if (!orderDoc.exists) {
        debugPrint('Order not found: $orderId');
        return;
      }

      final orderData = orderDoc.data()!;
      final userId = orderData['userId'] as String?;

      if (userId == null) {
        debugPrint('User ID not found in order: $orderId');
        return;
      }

      // Update order status in main orders collection
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({
        'paymentStatus': status,
        if (transactionId != null) 'transactionId': transactionId,
        if (error != null) 'paymentError': error,
        'lastUpdated': FieldValue.serverTimestamp(),
      });

      // Update order status in user's orders collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .update({
        'paymentStatus': status,
        if (transactionId != null) 'transactionId': transactionId,
        if (error != null) 'paymentError': error,
        'lastUpdated': FieldValue.serverTimestamp(),
      });

      // Add notification for payment status
      final message = status == 'completed'
          ? 'Payment successful for order #$orderId! Your order is being processed.'
          : status == 'cancelled'
              ? 'Payment cancelled for order #$orderId. Please try again.'
              : 'Payment failed for order #$orderId. Please try again or contact support.';

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .add({
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false,
        'type': 'payment_${status}',
        'orderId': orderId,
      });

    } catch (e) {
      debugPrint('Error updating payment status: $e');
    }
  }
}