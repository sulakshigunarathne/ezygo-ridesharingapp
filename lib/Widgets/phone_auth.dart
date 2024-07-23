import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  bool loading = false;
  String? verificationID;
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                "assets/images/sri-lanka.png",
                width: width * 0.12,
              ),
              const Spacer(),
              SizedBox(
                width: width * 0.1,
                child: const Text(
                  "+94",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: height * 0.08,
                width: width * 0.6,
                child: TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    hintText: '766033817',
                    labelText: 'Enter your phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value!.length != 9) {
                      return "Enter valid phone number";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Colors.blueGrey,
                    Colors.green,
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
                  // onPressed: () async {
                  //   setState(() {
                  //     loading = true;
                  //   });
                  //   if (loading) {
                  //     await FirebaseAuth.instance.verifyPhoneNumber(
                  //       phoneNumber: '+94${phoneNumberController.text}',
                  //       verificationCompleted:
                  //           (PhoneAuthCredential credential) {
                  //         setState(() {
                  //           loading = false;
                  //         });
                  //       },
                  //       verificationFailed: (FirebaseAuthException ex) {
                  //         print("Failed");
                  //         setState(() {
                  //           loading = false;
                  //         });
                  //       },
                  //       codeSent: (String verificationId, int? resendToken) {
                  //         verificationID = verificationId;
                  //         Navigator.pushNamed(
                  //           context,
                  //           'otp',
                  //           arguments: verificationId,
                  //         );
                  //         setState(() {
                  //           loading = false;
                  //         });
                  //       },
                  //       codeAutoRetrievalTimeout: (String verificationId) {
                  //         setState(() {
                  //           loading = false;
                  //         });
                  //       },
                  //     );
                  //   }
                  // },
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      Navigator.pushNamed(
                        context,
                        'otp',
                        arguments: 'dummyVerificationId', // Use a dummy verification ID
                      ).then((value) {
                        setState(() {
                          loading = false;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content: Text('Navigated to OTP Verification Screen'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "Continue",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
