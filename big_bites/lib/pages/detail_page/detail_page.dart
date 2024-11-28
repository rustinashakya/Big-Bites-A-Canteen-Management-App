import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/pages/detail_page/widget/name_review_favorite_widget.dart';
import 'package:big_bites/pages/detail_page/widget/quantity_add_sub_widget.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

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
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_outlined)),
            Center(child: Image.asset(Images.doubleCheese)),
            const NameReviewFavoriteWidget(),
            const SizedBox(height: 10),
            Text(
              demoDetailInfo,
              style: Fonts.bodyMediumInter,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "Quantity",
              style: Fonts.bodyMediumInter,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            const QuantityAddSubWidget(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Logic for the first button
                    print("Button 1 clicked");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.yellow, // Set background color to yellow
                  ),
                  child: const Text("Rs 300"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Logic for the second button
                    print("Button 2 clicked");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Set background color to red
                  ),
                  child: const Text(
                    "Add",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
