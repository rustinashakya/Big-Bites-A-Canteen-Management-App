import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          //Title Name
        Positioned(
          top: deviceHeight * 0.1, // Vertical position (10% of the screen height)
          left: 25, // Horizontal position from the left edge
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the left
            children: [
              Text(
                'Add Menu',
                style: TextStyle(
                  fontFamily: 'Kaushan Script',
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                  color: Color(0xFF000000),
                ),
              ),
            ],
          ),
          ),

          //Text Field
          Positioned(
            top: deviceHeight * 0.2,
            left: 20.0,
            right: 20.0,
            child: Center(
              child: Column(
                children: [
                  //
                  TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'Name of the Item',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30.0),
                //
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'Add picture ',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30.0),

                // Description
                SizedBox(
                  width: 400, // Desired width
                  height: 170, // Desired height
                  child: TextField(
                    maxLines: null, // Allows unlimited lines for multi-line input
                    expands: true,  // Ensures the TextField expands to fill its parent
                    textAlignVertical: TextAlignVertical.top, // Aligns text to the top
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      hintText: 'Description',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 20.0),

                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'Price',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20.0),

                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'Ratings',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20.0),

                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'Ordered By',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    
                    ),
                  ),
                ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        
          // Buttons
          Positioned(
            top: deviceHeight * 0.830, 
            left: 15.0,
            right: 20.0,
            child: Column(
              children: [
                //Add Today's menu 
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF63333), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                      side: BorderSide(
                        color: Colors.black.withOpacity(0.25), 
                        width: 1.0,
                      ),
                    ),
                    minimumSize: const Size(double.infinity, 50), 
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignInPage()),
                    // );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0), // Adjust padding as needed
                    child: Text(
                      "Add to Today's Menu",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16.0), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}
