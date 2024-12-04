import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final GlobalKey _formKey = GlobalKey<FormState>();

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddMenu(),
      ),
    );

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenu();
}

class _AddMenu extends State<AddMenu> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, bottom: 10.0, top: 25.0),
        child: Column(
          children: [
            TopTitleWidget(
              title: "Add Menu",
            ),
            20.verticalBox,
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField(
                      name: 'itemName', hintText: 'Name of the item'),
                  15.verticalBox,
                  _buildTextField(name: 'image', hintText: 'Add an image'),
                  15.verticalBox,
                  _buildTextField(
                    name: 'description',
                    hintText: 'Description',
                    maxLines: 4,
                  ),
                  15.verticalBox,
                  _buildTextField(name: 'price', hintText: 'Price'),
                  15.verticalBox,
                  _buildTextField(name: 'rating', hintText: 'Ratings'),
                  15.verticalBox,
                  _buildTextField(name: 'order', hintText: 'Order By'),
                  15.verticalBox,
                ],
              ),
            )),
            AppButtonWidget(
              color: AppColors.buttonRed,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add to Today's Menu",
                  style: AppTextStyle.labelLargeInter
                      .copyWith(color: Colors.white),
                ),
              ),
              width: double.infinity,
              borderRadius: 15,
            ),
            20.verticalBox
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String name, required String hintText, int? maxLines}) {
    return FormBuilderTextField(
      name: name,
      minLines: maxLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFD9D9D9),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFD9D9D9),
          ),
        ),
      ),
    );
  }
}
