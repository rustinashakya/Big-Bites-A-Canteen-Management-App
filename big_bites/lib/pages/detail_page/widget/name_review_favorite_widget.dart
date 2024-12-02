import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:flutter/material.dart';

class NameReviewFavoriteWidget extends StatelessWidget {
  const NameReviewFavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Double Cheese Burger",
              style: Fonts.titleLargeInter,
            ),
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ],
        ),
        10.verticalBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Text(
                  "4.9",
                ),
              ],
            ),
            Text(
              "24 reviews",
            ),
          ],
        )
      ],
    );
  }
}
