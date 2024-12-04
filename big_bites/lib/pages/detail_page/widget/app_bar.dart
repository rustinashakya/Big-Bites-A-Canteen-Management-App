import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.home_outlined),
        Icon(Icons.shopping_cart_outlined),
        Icon(Icons.menu_outlined),
        Icon(Icons.timer_outlined),
        Icon(Icons.favorite_outlined),
      ],
    );
  }
}
