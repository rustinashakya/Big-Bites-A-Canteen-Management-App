import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/loading_button_widget.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:big_bites/pages/dashboard_page/cart_page/widget/customer_order_list_widget.dart';
import 'package:big_bites/pages/order_now/order_now.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? userId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await SharedPreferencesHelper().getUserId();
    setState(() {
      userId = id;
    });
  }

  Future<void> _placeOrder() async {
    try {
      setState(() {
        isLoading = true;
      });

      if (userId == null) {
        throw Exception('User not logged in');
      }

      final cartSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      int totalPrice = 0;
      List<Map<String, dynamic>> orderItems = [];
      
      for (var doc in cartSnapshot.docs) {
        final data = doc.data();
        totalPrice += (data['Total'] as int? ?? 0);
        orderItems.add({
          'Name': data['Name'] ?? 'Unknown Item',
          'Quantity': data['Quantity'] ?? 0,
        });
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderNow(
            totalPrice: totalPrice,
            orderItems: orderItems,
          ),
        ),
      );

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to place order: ${e.toString()}',
              style: Fonts.bodyMediumInter.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        TopTitleWidget(
          title: "My Cart",
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('cart')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: Fonts.bodyMediumInter,
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    'No Items Added to Cart',
                    style: Fonts.bodyMediumInter,
                  ),
                );
              }

              // Calculate total price
              int totalPrice = 0;
              for (var doc in snapshot.data!.docs) {
                final data = doc.data() as Map<String, dynamic>;
                totalPrice += (data['Total'] as int? ?? 0);
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        return CustomerOrderListWidget(
                          cartItem: doc.data() as Map<String, dynamic>,
                          itemId: doc.id,
                        );
                      },
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
                              'Rs. $totalPrice/-',
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
                            color: Colors.blue,
                            child: Text(
                              'Order Now',
                              style: Fonts.bodyMediumInter.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
