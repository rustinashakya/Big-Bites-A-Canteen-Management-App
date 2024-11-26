import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/pages/detail_page/widget/name_review_favorite_widget.dart';
import 'package:big_bites/pages/detail_page/widget/quantity_add_sub_widget.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(), // Set white background for the page
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_outlined)),
            Center(child: Image.asset(Images.doubleCheese)),
            NameReviewFavoriteWidget(),
            SizedBox(
              height: 10,
            ),
            Text(
              demoDetailInfo,
              style: Fonts.bodyMediumInter,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Quantity",
              style: Fonts.bodyMediumInter,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 10,
            ),
            QuantityAddSubWidget()
          ],
        ),
      ),

      // Stack(
      //   children: [
      //     Positioned(
      //       left: 22, // X position
      //       top: 499, // Y position
      //       width: 392, // Width
      //       height: 143, // Height
      //       child: Container(
      //         alignment: Alignment.center,
      //         child: Text(
      //           'A double cheeseburger has two beef patties, each with melted cheese, in a soft bun, often with toppings like lettuce, tomato, pickles, and condiments. It’s a hearty, flavorful burger option.',
      //           style: TextStyle(
      //             fontFamily: 'Inter',
      //             fontWeight: FontWeight.w500, // Medium weight
      //             fontSize: 18,
      //             color: Color(0xFF1E1E1E), // Hex color #1E1E1E
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
