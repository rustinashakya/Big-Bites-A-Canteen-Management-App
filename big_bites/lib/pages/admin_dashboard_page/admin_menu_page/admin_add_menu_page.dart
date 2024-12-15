import 'dart:convert';
import 'dart:io';

import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/my_text_field.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddMenuPage extends StatefulWidget {
  const AdminAddMenuPage({super.key});

  @override
  State<AdminAddMenuPage> createState() => _AdminAddMenuPageState();
}

class _AdminAddMenuPageState extends State<AdminAddMenuPage> {
  final List<String> foodItems = [
    'momo',
    'burger',
    'pizza',
    'hot beverages',
    'cold beverages'
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ratingsController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  /// Convert Image to Base64 String
  String? _convertImageToBase64(File? image) {
    if (image == null) return null;
    final bytes = image.readAsBytesSync();
    return base64Encode(bytes);
  }

  /// Upload Item to Firestore
  Future<void> _uploadItem() async {
    if (_formKey.currentState!.validate() && selectedImage != null) {
      try {
        final base64Image = _convertImageToBase64(selectedImage);

        Map<String, dynamic> foodItem = {
          "Name": nameController.text.trim(),
          "Image": base64Image,
          "Category": categoryController.text.trim(),
          "Description": descriptionController.text.trim(),
          "Price": double.parse(priceController.text.trim()),
          "Ratings": double.parse(ratingsController.text.trim()),
          'Timestamp': FieldValue.serverTimestamp()
        };

        final category = categoryController.text.trim().toLowerCase();

        await FirebaseFirestore.instance.collection(category).add(foodItem);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(255, 109, 226, 59),
            content: const Text(
              "Food Item Added Successfully",
              style: TextStyle(fontSize: 16.0, color: AppColors.black),
            ),
          ),
        );

        _clearFields();
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Error: ${e.toString()}",
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        );
      }
    } else {
      if (selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Please select an image.",
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  /// Clear all input fields
  void _clearFields() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    ratingsController.clear();
    categoryController.clear();
    selectedImage = null;
    setState(() {});
  }

  /// Pick Image from Gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.yellow,
                      width: 3.0,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 10.0),
                child: const Text(
                  'Add New Food Item',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextField(
                      controller: nameController,
                      hintText: 'Name of the item',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.local_pizza),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please enter the name of the food item.'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 245, 245),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color.fromARGB(255, 205, 205, 205),
                          ),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            const Icon(Icons.image),
                            const SizedBox(width: 10),
                            Text(
                              selectedImage == null
                                  ? "Choose an Image"
                                  : "Image Selected",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (selectedImage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.file(
                          selectedImage!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(height: 16),
                    MyTextField(
                      controller: categoryController,
                      hintText: 'Select Category',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.category_rounded),
                      dropdownItems: foodItems
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      dropdownValue: foodItems.first,
                      onDropdownChanged: (val) =>
                          categoryController.text = val ?? '',
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please select a category.'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        prefixIcon: const Icon(Icons.description),
                        fillColor: const Color.fromARGB(255, 245, 245, 245),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 205, 205, 205),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter the description of the food item.';
                        }
                        if (val.trim().split(RegExp(r'\s+')).length > 100) {
                          return 'Description cannot exceed 100 words.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    MyTextField(
                      controller: priceController,
                      hintText: 'Price',
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.money),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please enter a price.'
                          : double.tryParse(val) == null
                              ? 'Please enter a valid number.'
                              : null,
                    ),
                    const SizedBox(height: 16),
                    MyTextField(
                      controller: ratingsController,
                      hintText: 'Ratings',
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.star),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter the ratings.';
                        }
                        final rating = double.tryParse(val);
                        if (rating == null || rating < 0 || rating > 5) {
                          return 'Ratings must be between 0 and 5.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    AppButtonWidget(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      borderRadius: 60,
                      color: AppColors.primaryColor,
                      onButtonPressed: _uploadItem,
                      child: const Text(
                        "Add to Today's Menu",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
