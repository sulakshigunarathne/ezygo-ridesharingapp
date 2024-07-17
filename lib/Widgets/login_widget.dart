import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ezygo/Pages/test_page.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:rideshareapp/Pages/home.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:firebase_core/firebase_core.dart';
//import 'package:ezygo/Pages/signup_page.dart';
//import 'package:ezygo/Widget/splash_service.dart';

//import '../Pages/mylocation.dart';

// import '../Utils/next_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool index = true;
  bool loading = false;

  String? VerificationID;
  String? Otp;
  final phoneNumberController = TextEditingController();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();
  final auth = FirebaseAuth.instance;

  String? phonenumber;
  bool hasaccount = false;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return index == true
        ? Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 5,
                // ),
                // const Text(
                //   "Hello! nice to meet you",
                //   style: TextStyle(fontSize: 20),
                // ),
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

                        // onChanged: (value) {
                        //   phonenumber = value;
                        // },
                        decoration: InputDecoration(
                          hintText: '766033817',
                          labelText: 'Enter your phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        ),

                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value!.length != 9) {
                            return "enter valid phone number";
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
                              //add more colors
                            ]),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.57), //shadow for button
                                  blurRadius: 5) //blur radius of shadow
                            ]),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              disabledForegroundColor:
                                  Colors.transparent.withOpacity(0.38),
                              disabledBackgroundColor:
                                  Colors.transparent.withOpacity(0.12),
                              shadowColor: Colors.transparent,
                              //make color or elevated button transparent
                            ),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              //  print(phoneNumberController.text);
                              loading
                                  ? await FirebaseAuth.instance
                                      .verifyPhoneNumber(
                                      phoneNumber:
                                          '+94${phoneNumberController.text}',
                                      verificationCompleted:
                                          (PhoneAuthCredential credential) {
                                        setState(() {
                                          loading = false;
                                        });
                                      },
                                      verificationFailed:
                                          (FirebaseAuthException ex) {
                                        print("Failed");
                                        setState(() {
                                          loading = false;
                                        });
                                      },
                                      codeSent: (
                                        String verificationId,
                                        int? resendToken,
                                      ) {
                                        VerificationID = verificationId;
                                        resendToken = null;
                                        Navigator.pushNamed(context, "otp");
                                        setState(() {
                                          index = false;
                                        });
                                      },
                                      codeAutoRetrievalTimeout:
                                          (String verificationId) {
                                        setState(() {
                                          loading = false;
                                        });
                                      },
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator(
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                              // if (!loading) {
                              //   setState(() {
                              //     index = false;
                              //   });
                              // }

                              // print(phoneNumberController);
                            },
                            child: loading
                                ? const CircularProgressIndicator()
                                : const Padding(
                                    padding: EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white),),
                                  ))
                                  ),
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   // children: [
                //   //   const Text(
                //   //     "Powered by:",
                //   //     style: TextStyle(color: Colors.black54),
                //   //   ),
                //   //   const SizedBox(
                //   //     width: 5,
                //   //   ),
                //   //   SizedBox(
                //   //       width: 100,
                //   //       child: Image.asset(
                //   //           "assets/images/beesoftlogo edited.png")),
                //   // ],
                // ),
              ],
            ),
          )
        : Container(
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: GestureDetector(
                //     // onTap: () => Navigator.pop(context),
                //     child: Icon(
                //       Icons.arrow_back,
                //       size: 32,
                //       color: Colors.black54,
                //     ),
                //   ),
                // ),
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
                // const SizedBox(
                //   height: 8,
                // ),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OtpInput(_fieldOne, true), // auto focus
                          OtpInput(_fieldTwo, false),
                          OtpInput(_fieldThree, false),
                          OtpInput(_fieldFour, false),
                          OtpInput(_fieldFive, false),
                          OtpInput(_fieldSix, false)
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

                                  //add more colors
                                ]),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.57), //shadow for button
                                      blurRadius: 5) //blur radius of shadow
                                ]),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                disabledForegroundColor:
                                    Colors.transparent.withOpacity(0.38),
                                disabledBackgroundColor:
                                    Colors.transparent.withOpacity(0.12),
                                shadowColor: Colors.transparent,
                                //make color or elevated button transparent
                              ),
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });
                                loading
                                    ? verify()
                                    : Container(
                                        alignment: Alignment.center,
                                        child: const CircularProgressIndicator(
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                              },
                              child: const Text("Verify", style: TextStyle(fontSize: 17, color: Colors.white),),
                            )),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 8,
                // ),
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
                      index = true;
                      loading = false;
                    });
                  },
                )
              ],
            ),
          );
  }

  void verify() async {
    
    setState(() {
      Otp = _fieldOne.text +
          _fieldTwo.text +
          _fieldThree.text +
          _fieldFour.text +
          _fieldFive.text +
          _fieldSix.text;
    });

    // ignore: empty_catches
    try {
      PhoneAuthCredential credentials =
          PhoneAuthProvider.credential(verificationId: VerificationID!, smsCode: Otp!);

      await auth.signInWithCredential(credentials);
      print("Login successfull");


      setState(() {
        loading = false;
        phonenumber = auth.currentUser!.phoneNumber!;
      });

       QuerySnapshot data;


      data = await FirebaseFirestore.instance
          .collection('users')
          .where('phone_number', isEqualTo: phonenumber)

          //  .orderBy('latitude', descending: false)
          //   .limit(10)
          .get();
   

    if (data.docs.length > 0) {
         print("object");
      hasaccount = true;
     
    } else{
         print("object 1");
    }
      
      if(hasaccount){

        Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context){
                    
                    return TestPage(
                      );
                  }
                      ));

      }
      else{
         newpage();
      }
      // const SignupPage();
      
    } catch (e) {
      print("Login unsuccessfull");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Invalied OTP"),
            content: const Text("Your OTP is invalied."),
            actions: <Widget>[
              TextButton(
                child: const Text("close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      setState(() {
        loading = false;
      });
    }
  }

  void newpage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TestPage()
      ),
    );

    

  //   Future<Null> _getData() async {
  
  //   QuerySnapshot data;

  //  print("object");
  //     data = await firestore
  //         .collection('users')
  //         .where('phone_number', isEqualTo: phone)

  //         //  .orderBy('latitude', descending: false)
  //         //   .limit(10)
  //         .get();
   

  //   if (data.docs.length > 0) {
  //        print("object");
  //     hasaccount = true;
     
  //   } else{
  //        print("object 1");
  //   }
  //   return null;
  // }
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(2),
      height: height * 0.06,
      width: width * 0.12,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
