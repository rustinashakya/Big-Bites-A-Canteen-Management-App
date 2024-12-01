import 'package:flutter/material.dart';

import '../../../../context/fonts.dart';
import '../../../../context/images.dart';

class ItemStaffWidget extends StatelessWidget {
  const ItemStaffWidget({super.key, this.onItemClick});
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
              style: Fonts.bodyMediumInter,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {}, icon: Image.asset(AppIcons.editItemIcon)),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(AppIcons.deleteItemIcon)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
