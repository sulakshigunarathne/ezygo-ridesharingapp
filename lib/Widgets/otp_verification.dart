import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ezygo/Pages/test_page.dart';

class OtpVerification extends StatefulWidget {
  final String verificationID;
  const OtpVerification({super.key, required this.verificationID});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  bool loading = false;
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();
  final auth = FirebaseAuth.instance;
  String? otp;
  String? phonenumber;
  bool hasaccount = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Verification',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Enter your OTP code number",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OtpInput(_fieldOne, true),
                    OtpInput(_fieldTwo, false),
                    OtpInput(_fieldThree, false),
                    OtpInput(_fieldFour, false),
                    OtpInput(_fieldFive, false),
                    OtpInput(_fieldSix, false),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Colors.orange,
                        Colors.red,
                      ]),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.57),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        disabledForegroundColor:
                            Colors.transparent.withOpacity(0.38),
                        disabledBackgroundColor:
                            Colors.transparent.withOpacity(0.12),
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        if (loading) {
                          verify();
                        }
                      },
                      child: const Text(
                        "Verify",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "Didn't you receive any code?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Resend New Code",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            child: const Text(
              "Back",
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () {
              setState(() {
                loading = false;
              });
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void verify() async {
    setState(() {
      otp = _fieldOne.text +
          _fieldTwo.text +
          _fieldThree.text +
          _fieldFour.text +
          _fieldFive.text +
          _fieldSix.text;
    });

    try {
      PhoneAuthCredential credentials = PhoneAuthProvider.credential(
        verificationId: widget.verificationID,
        smsCode: otp!,
      );

      await auth.signInWithCredential(credentials);
      print("Login successful");

      setState(() {
        loading = false;
        phonenumber = auth.currentUser!.phoneNumber!;
      });

      QuerySnapshot data = await FirebaseFirestore.instance
          .collection('Users')
          .where('Phone Number', isEqualTo: phonenumber)
          .get();

      setState(() {
        hasaccount = data.docs.isNotEmpty;
      });

      if (hasaccount) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestPage(),
          ),
        );
      } else {
        Navigator.pushNamed(context, 'sign-up');
      }
    } catch (e) {
      print("Invalid OTP");
      setState(() {
        loading = false;
      });
    }
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Colors.black,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
