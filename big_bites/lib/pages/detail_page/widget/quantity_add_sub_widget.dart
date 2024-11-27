import 'package:flutter/material.dart';

class QuantityAddSubWidget extends StatelessWidget {
  const QuantityAddSubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.cancel_rounded)),
        SizedBox(
          width: 30,
        ),
        Text("1"),
        SizedBox(
          width: 30,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.add_circle)),
      ],
    );
  }
}
