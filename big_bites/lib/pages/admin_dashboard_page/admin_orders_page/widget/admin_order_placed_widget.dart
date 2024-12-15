import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderPlacedWidget extends StatelessWidget {
  final String orderId;
  final String userId;
  final String orderName;
  final int totalPrice;
  final String paymentMethod;
  final String orderStatus;
  final String paymentStatus;
  final VoidCallback onPaymentComplete;
  final VoidCallback onOrderComplete;
  final VoidCallback onCancel;

  const OrderPlacedWidget({
    super.key,
    required this.orderId,
    required this.userId,
    required this.orderName,
    required this.totalPrice,
    required this.paymentMethod,
    required this.orderStatus,
    required this.paymentStatus,
    required this.onPaymentComplete,
    required this.onOrderComplete,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: AppColors.grey.withOpacity(0.3), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #$orderId',
                      style: Fonts.bodyLargeInter.copyWith(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                    15.verticalBox,
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError || !snapshot.hasData) {
                          return Text(
                            'Order Placed by Unknown User',
                            style: Fonts.bodyMediumInter.copyWith(
                              color: Colors.grey[600],
                            ),
                          );
                        }

                        final userData =
                            snapshot.data!.data() as Map<String, dynamic>?;
                        final firstName =
                            userData?['First Name'] as String? ?? '';
                        final lastName =
                            userData?['Last Name'] as String? ?? '';
                        final fullName = '$firstName $lastName'.trim();

                        return Text(
                          'Order Placed by ${fullName.isEmpty ? 'Unknown User' : fullName}',
                          style: Fonts.bodyMediumInter.copyWith(
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.verticalBox,
          _OrderPlacedKeyValue(
            title: 'Order Items',
            value: orderName,
          ),
          10.verticalBox,
          _OrderPlacedKeyValue(
            title: 'Total Price',
            value: 'Rs. $totalPrice/-',
          ),
          10.verticalBox,
          _OrderPlacedKeyValue(
            title: 'Payment Method',
            value: paymentMethod,
          ),
          10.verticalBox,
          _OrderPlacedKeyValue(
            title: 'Payment\n Status',
            value: paymentStatus,
          ),
          10.verticalBox,
          _OrderPlacedKeyValue(
            title: 'Order Status',
            value: orderStatus,
          ),
          20.verticalBox,
          if (orderStatus.toLowerCase() != 'completed' && orderStatus.toLowerCase() != 'cancelled') ...[
            SizedBox(
              width: double.infinity,
                child: AppButtonWidget(
                onButtonPressed: onPaymentComplete,
                height: 45,
                color: AppColors.buttonGreen,
                child: Text(
                  'Payment Completed',
                  style: Fonts.bodyMediumInter.copyWith(color: Colors.white),
                ),
              ),
            ),
            10.verticalBox,
            SizedBox(
              width: double.infinity,
                child: AppButtonWidget(
                onButtonPressed: onOrderComplete,
                height: 45,
                color: AppColors.primaryColor,
                child: Text(
                  'Order Completed',
                  style: Fonts.bodyMediumInter.copyWith(color: Colors.white),
                ),
              ),
            ),
            10.verticalBox,
            SizedBox(
              width: double.infinity,
                child: AppButtonWidget(
                onButtonPressed: onCancel,
                height: 45,
                color: AppColors.buttonRed,
                child: Text(
                  'Cancel Order',
                  style: Fonts.bodyMediumInter.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ],
      ),
    ).py(16);
  }
}

class _OrderPlacedKeyValue extends StatelessWidget {
  const _OrderPlacedKeyValue({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontStyle: FontStyle.italic,
              fontSize: 18.0, 
            ),
          ),
        ),
        Text(': '),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Fonts.bodyMediumInter,
          ),
        ),
      ],
    );
  }
}
