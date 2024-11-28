import 'package:flutter/material.dart';

class QuantityAddSubWidget extends StatelessWidget {
  const QuantityAddSubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.cancel_rounded)),
        const SizedBox(
          width: 30,
        ),
        const Text("1"),
        const SizedBox(
          width: 30,
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle)),
      ],
    );
  }
}
