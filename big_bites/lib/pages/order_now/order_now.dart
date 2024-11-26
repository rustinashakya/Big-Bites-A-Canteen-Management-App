import 'package:flutter/material.dart';

class OrderNow extends StatefulWidget {
  @override
  _OrderNowState createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                // Add your logic here, such as navigating back
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
