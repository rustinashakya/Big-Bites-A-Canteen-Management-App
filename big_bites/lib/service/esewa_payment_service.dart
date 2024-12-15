import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';

class EsewaPaymentService {
  static const String _merchantId = "EPAYTEST"; // Replace with your merchant ID
  static const String _merchantSecret = "8gBm/:&EnhH.1/q"; // Replace with your secret key
  
  static Future<void> initiatePayment({
    required BuildContext context,
    required String productId,
    required String productName,
    required double amount,
    required Function(EsewaPaymentSuccessResult result) onSuccess,
    required Function(String errorMessage) onFailure,
  }) async {
    try {
      final payment = EsewaPayment(
        productId: productId,
        productName: productName,
        productPrice: amount.toString(),
        callbackUrl: "https://example.com",
      );

      final config = EsewaConfig(
        clientId: _merchantId,
        secretId: _merchantSecret,
        environment: Environment.test,
      );

      try {
        EsewaFlutterSdk.initPayment(
          esewaPayment: payment,
          esewaConfig: config,
          onPaymentSuccess: (EsewaPaymentSuccessResult result) {
            onSuccess(result);
          },
          onPaymentFailure: () {
            onFailure("Payment failed");
          },
          onPaymentCancellation: () {
            onFailure("Payment cancelled");
          },
        );
      } catch (e) {
        onFailure(e.toString());
      }
    } catch (e) {
      onFailure("Error initializing payment: ${e.toString()}");
    }
  }
}
