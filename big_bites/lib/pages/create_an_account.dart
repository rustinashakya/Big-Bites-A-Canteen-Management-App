import 'package:flutter/material.dart';

class CreateAnAccountPage extends StatefulWidget {
  @override
  State<CreateAnAccountPage> createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account'),
      ),
      body: Center(
        child: Text(
          'This is the Create an Account page.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}