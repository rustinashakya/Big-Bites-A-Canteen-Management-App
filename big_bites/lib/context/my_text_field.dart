import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final void Function(String)? onChanged;

  final Color borderColor;
  final Color backgroundColor;
  final List<DropdownMenuItem<String>>? dropdownItems;
  final String? dropdownValue;
  final void Function(String?)? onDropdownChanged;

  final bool isImagePicker;
  final Function(File?)? onImagePicked;
  final File? selectedImage;

  final bool isDescription;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.borderColor = const Color.fromARGB(255, 205, 205, 205),
    this.backgroundColor = const Color.fromARGB(255, 245, 245, 245),
    this.dropdownItems,
    this.dropdownValue,
    this.onDropdownChanged,
    this.isImagePicker = false,
    this.onImagePicked,
    this.selectedImage,
    this.isDescription = false,
    this.readOnly = false,
    this.maxLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    if (isImagePicker) {
      return GestureDetector(
        onTap: () async {
          final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            final imageFile = File(pickedFile.path);
            onImagePicked?.call(imageFile);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const Icon(Icons.image, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  selectedImage == null
                      ? hintText
                      : "Image selected",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.file(
                    selectedImage!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return dropdownItems != null
        ? DropdownButtonFormField<String>(
            value: dropdownValue,
            items: dropdownItems,
            onChanged: onDropdownChanged,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              fillColor: backgroundColor,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[500],
              ),
              errorText: errorMsg,
            ),
            validator: validator,
          )
        : TextFormField(
            validator: validator,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            focusNode: focusNode,
            readOnly: readOnly,
            onTap: onTap,
            textInputAction: TextInputAction.next,
            onChanged: onChanged,
            maxLines: isDescription ? maxLines ?? 5 : 1,
            maxLength: isDescription ? maxLength : null,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              fillColor: backgroundColor,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              errorText: errorMsg,
              alignLabelWithHint: true,
            ),
          );
  }
}
