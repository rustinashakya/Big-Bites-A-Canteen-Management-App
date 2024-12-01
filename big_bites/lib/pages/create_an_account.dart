import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:big_bites/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateAnAccountPage extends StatefulWidget {
  const CreateAnAccountPage({super.key});

  @override
  State<CreateAnAccountPage> createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
  bool _isPasswordVisible = false;
  String? _selectedUserType;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/create_an_account/top_surface.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.20, // Top 35%
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // Top Section
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.89, // Takes 85% of the screen
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      40.verticalBox,
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      80.verticalBox,
                      Expanded(
                        child: Column(
                          children: [
                            // Email Field
                            _buildTextField(name: 'email', hintText: 'Email'),

                            const SizedBox(height: 10),

                            // Name Fields
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                      name: 'firstName',
                                      hintText: 'First Name'),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildTextField(
                                      name: 'lastName', hintText: 'Last Name'),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // User Type Dropdown
                            _buildDropdown(
                              name: 'userType',
                              hintText: 'User Type',
                              items: const [
                                DropdownMenuItem(
                                    value: 'Staff', child: Text('Staff')),
                                DropdownMenuItem(
                                    value: 'Customer', child: Text('Customer')),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // Organization Dropdown
                            _buildDropdown(
                              name: 'organization',
                              hintText: 'Organization',
                              items: const [
                                DropdownMenuItem(
                                    value: 'Company A',
                                    child: Text('Company A')),
                                DropdownMenuItem(
                                    value: 'Company B',
                                    child: Text('Company B')),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // Password Fields
                            _buildTextField(
                                name: 'password', hintText: 'Password'),
                            const SizedBox(height: 10),
                            _buildTextField(
                                name: 'confirmPassword',
                                hintText: 'Confirm Password'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF1B136),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(
                              color: Colors.black.withOpacity(0.25),
                              width: 1.0,
                            ),
                          ),
                          minimumSize: const Size(
                              double.infinity, 50), // Full-width button
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardPage()));
                        },
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                ),

                // Footer Section
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.15, // Takes 15% of the screen
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an Account?",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF5F5F5F),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFFF1B136),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String name, required String hintText}) {
    return FormBuilderTextField(
      name: name,
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

  Widget _buildDropdown(
      {required String name,
      required String hintText,
      required List<DropdownMenuItem> items}) {
    return FormBuilderDropdown(
      name: name,
      items: items,
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

//
// SingleChildScrollView(
// child: Padding(
// padding: const EdgeInsets.all(10.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// 1.verticalBox,
// Text(
// 'Create An Account',
// style: Fonts.labelLargeInter,
// ),
// Column(
// children: [
// FormBuilderTextField(
// name: 'email',
// decoration: InputDecoration(
// filled: true,
// fillColor: const Color(0xFFF5F5F5),
// hintText: 'Email',
// hintStyle: Fonts.bodySmallInter
//     .copyWith(color: Colors.grey),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10.0),
// borderSide: const BorderSide(
// color: Color(0xFFD9D9D9),
// ),
// ),
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10.0),
// borderSide: const BorderSide(
// color: Color(0xFFD9D9D9),
// ),
// ),
// ),
// ),
//
// 10.verticalBox,
//
// FormBuilderTextField(
// name: 'firstName',
// decoration: InputDecoration(
// filled: true,
// fillColor: const Color(0xFFF5F5F5),
// hintText: 'Email',
// hintStyle: Fonts.bodySmallInter
//     .copyWith(color: Colors.grey),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10.0),
// borderSide: const BorderSide(
// color: Color(0xFFD9D9D9),
// ),
// ),
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10.0),
// borderSide: const BorderSide(
// color: Color(0xFFD9D9D9),
// ),
// ),
// ),
// ),
// 10.verticalBox,
//
// // First Name Field
//
// // SizedBox(height: 20.0),
//
// // // Last Name Field
// // TextField(
// //   decoration: InputDecoration(
// //     filled: true,
// //     fillColor: Color(0xFFF5F5F5),
// //     hintText: 'Last Name',
// //     hintStyle: TextStyle(
// //       fontFamily: 'Inter',
// //       fontWeight: FontWeight.w400,
// //       fontSize: 16,
// //       color: Colors.grey,
// //     ),
// //     border: OutlineInputBorder(
// //       borderRadius: BorderRadius.circular(10.0),
// //       borderSide: BorderSide(
// //         color: Color(0xFFD9D9D9),
// //       ),
// //     ),
// //     enabledBorder: OutlineInputBorder(
// //       borderRadius: BorderRadius.circular(10.0),
// //       borderSide: BorderSide(
// //         color: Color(0xFFD9D9D9),
// //       ),
// //     ),
// //   ),
// // ),
//
// const SizedBox(height: 20.0),
//
// // User Type Field
// TextField(
// decoration: InputDecoration(
// filled: true,
// fillColor: const Color(0xFFF5F5F5),
// hintText: 'User Type',
// hintStyle: const TextStyle(
// fontFamily: 'Inter',
// fontWeight: FontWeight.w400,
// fontSize: 16,
// color: Colors.grey,
// ),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10.0),
// borderSide: const BorderSide(
// color: Color(0xFFD9D9D9),
// ),
// ),
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10.0),
// borderSide: const BorderSide(
// color: Color(0xFFD9D9D9),
// ),
// ),
// ),
// ),
//
// const SizedBox(height: 20.0),
//
// // Password Text Field
// TextField(
// obscureText: !_isPasswordVisible,
// decoration: InputDecoration(
// filled: true,
// fillColor: const Color(0xFFF5F5F5),
// hintText: 'Password',
// hintStyle: const TextStyle(
// fontFamily: 'Inter',
// fontWeight: FontWeight.w400,
// fontSize: 16,
// color: Colors.grey,
// ),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10.0),
// borderSide: const BorderSide(
// color: Color(0xFFD9D9D9),
// ),
// ),
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10.0),
// borderSide: const BorderSide(
// color: Color(0xFFD9D9D9),
// ),
// ),
// suffixIcon: IconButton(
// icon: Icon(
// _isPasswordVisible
// ? Icons.visibility
//     : Icons.visibility_off,
// color: Colors.grey,
// ),
// onPressed: () {
// setState(() {
// _isPasswordVisible = !_isPasswordVisible;
// });
// },
// ),
// ),
// ),
// const SizedBox(height: 20.0),
//
// // Confirm Password Text Field
// TextField(
// obscureText: !_isPasswordVisible,
// decoration: InputDecoration(
// filled: true,
// fillColor: const Color(0xFFF5F5F5),
// hintText: 'Confirm Password',
// hintStyle: const TextStyle(
// fontFamily: 'Inter',
// fontWeight: FontWeight.w400,
// fontSize: 16,
// color: Colors.grey,
// ),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10.0),
// borderSide: const BorderSide(
// color: Color(0xFFD9D9D9),
// ),
// ),
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10.0),
// borderSide: const BorderSide(
// color: Color(0xFFD9D9D9),
// ),
// ),
// suffixIcon: IconButton(
// icon: Icon(
// _isPasswordVisible
// ? Icons.visibility
//     : Icons.visibility_off,
// color: Colors.grey,
// ),
// onPressed: () {
// setState(() {
// _isPasswordVisible = !_isPasswordVisible;
// });
// },
// ),
// ),
// ),
// ],
// ),

// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => OTPConfirmationPage()),
// );
// },
// child: const Text(
// 'Create An Account',
// style: TextStyle(
// fontFamily: 'Inter',
// fontWeight: FontWeight.w400,
// fontSize: 18,
// color: Colors.black,
// ),
// ),
// ),
// ],
// ),
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// const Text(
// "Already have an Account?",
// style: TextStyle(
// fontFamily: 'Inter',
// fontWeight: FontWeight.w400,
// fontSize: 16,
// color: Color(0xFF5F5F5F),
// ),
// ),
// TextButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => const SignInPage()),
// );
// },
// child: const Text(
// 'Sign In',
// style: TextStyle(
// fontFamily: 'Inter',
// fontWeight: FontWeight.w400,
// fontSize: 16,
// color: Color(0xFFF1B136),
// ),
// ),
// ),
// ],
// ),
// ],
// ),
// ),
// ),
