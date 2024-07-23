import 'package:flutter/material.dart';
import 'package:ezygo/Widgets/phone_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          height: height,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: height * 0.55,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.lightGreen,
                      Colors.blueGrey,
                    ],
                  ),
                  // color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(120.0),
                    bottomLeft: Radius.circular(120.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset("assets/images/EZY-GO-Logo.jpeg",
                            scale: 2)),
                    
                    ),

                  ],
                ),
              ),
              Expanded(
                child: Container(
                // height: height,
                // color: Colors.red,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: const PhoneAuth(),
                
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
