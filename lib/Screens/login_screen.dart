import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 65.00,),
          Image(
            image: AssetImage('assets/images/EZY-GO-Logo.jpeg'),
            height: 120.0,
            width: 120.0,
          ),
          ],
      ),
    );
  }
}
 
