import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:flutter/material.dart';

class FoodItemWidget extends StatelessWidget {
  const FoodItemWidget({super.key, this.onItemClick});
  final VoidCallback? onItemClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemClick,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Even lighter for sides
              blurRadius: 10,
              offset: Offset(-5, 0), // Left shadow
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Even lighter for sides
              blurRadius: 10,
              offset: Offset(5, 0), // Right shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                AppIcons.friedChickenBurger,
              ),
            ),
            Text(
              'Double Cheese Burger',
              style: AppTextStyle.bodyMediumInter,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
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
                Icon(Icons.favorite_border),
              ],
            )
          ],
        ),
      ),
    );
  }
}
