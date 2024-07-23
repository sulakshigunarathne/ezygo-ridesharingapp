// import 'package:ezygo/Pages/otp_verification.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool loading = false;
//   String? verificationID;
//   final phoneNumberController = TextEditingController();
//   final auth = FirebaseAuth.instance;
//   String? phoneNumber;
//   bool hasAccount = false;

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.grey,
//       body: SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         child: Container(
//           height: height,
//           color: Colors.white,
//           child: Column(
//             children: [
//               Container(
//                 height: height * 0.55,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topRight,
//                     end: Alignment.bottomLeft,
//                     colors: [
//                       Colors.lightGreen,
//                       Colors.blueGrey,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(120.0),
//                     bottomLeft: Radius.circular(120.0),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(top: 20),
//                       alignment: Alignment.center,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(100),
//                         child: Image.asset(
//                           "assets/images/EZY-GO-Logo.jpeg",
//                           scale: 2,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Welcome!",
//                         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: height * 0.04),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const Spacer(),
//                           Image.asset(
//                             "assets/images/sri-lanka.png",
//                             width: width * 0.12,
//                           ),
//                           const Spacer(),
//                           SizedBox(
//                             width: width * 0.1,
//                             child: const Text(
//                               "+94",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const Spacer(),
//                           SizedBox(
//                             height: height * 0.08,
//                             width: width * 0.6,
//                             child: TextFormField(
//                               controller: phoneNumberController,
//                               decoration: InputDecoration(
//                                 hintText: '766033817',
//                                 labelText: 'Enter your phone number',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                               ),
//                               keyboardType: TextInputType.number,
//                               validator: (String? value) {
//                                 if (value!.length != 9) {
//                                   return "Enter valid phone number";
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           const Spacer(),
//                         ],
//                       ),
//                       SizedBox(height: height * 0.05),
//                       Container(
//                         alignment: Alignment.center,
//                         child: SizedBox(
//                           width: 200,
//                           height: 50,
//                           child: DecoratedBox(
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(colors: [
//                                 Colors.blueGrey,
//                                 Colors.green,
//                               ]),
//                               borderRadius: BorderRadius.circular(25),
//                               boxShadow: const <BoxShadow>[
//                                 BoxShadow(
//                                   color: Color.fromRGBO(0, 0, 0, 0.57),
//                                   blurRadius: 5,
//                                 ),
//                               ],
//                             ),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.transparent,
//                                 disabledForegroundColor: Colors.transparent.withOpacity(0.38),
//                                 disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
//                                 shadowColor: Colors.transparent,
//                               ),
//                               onPressed: loading
//                                   ? null
//                                   : () async {
//                                       setState(() {
//                                         loading = true;
//                                       });
//                                       await FirebaseAuth.instance.verifyPhoneNumber(
//                                         phoneNumber: '+94${phoneNumberController.text}',
//                                         verificationCompleted: (PhoneAuthCredential credential) {
//                                           setState(() {
//                                             loading = false;
//                                           });
//                                         },
//                                         verificationFailed: (FirebaseAuthException ex) {
//                                           print("Verification failed");
//                                           setState(() {
//                                             loading = false;
//                                           });
//                                         },
//                                         codeSent: (String verificationId, int? resendToken) {
//                                           verificationID = verificationId;
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                               builder: (context) => OTPVerificationPage(verificationId: verificationId!,
//                                                 phoneNumber:
//                                                     '+94${phoneNumberController.text}'),
//                                             ),
//                                           );

//                                           setState(() {
//                                             loading = false;
//                                           });
//                                         },
//                                         codeAutoRetrievalTimeout: (String verificationId) {
//                                           setState(() {
//                                             loading = false;
//                                           });
//                                         },
//                                       );
//                                     },
//                               child: loading
//                                   ? const CircularProgressIndicator(color: Colors.white)
//                                   : const Text("Verify", style: TextStyle(fontSize: 18, color: Colors.white)),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class PhoneVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Enter Phone Number',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTPVerificationPage(),
                    ),
                  );
                },
                child: Text(
                  "Verify",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class OTPVerificationPage extends StatelessWidget {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtpInput(_fieldOne, true), // auto focus
                  OtpInput(_fieldTwo, false),
                  OtpInput(_fieldThree, false),
                  OtpInput(_fieldFour, false),
                  OtpInput(_fieldFive, false),
                  OtpInput(_fieldSix, false),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement your OTP verification logic here
                  // For testing UI, you can simulate verification success or failure
                  // For example:
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SuccessPage(), // Navigate to success page
                  //   ),
                  // );
                  // or
                  // showDialog(...); // Show dialog for verification success or failure
                },
                child: Text(
                  "Verify",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 40,
      child: TextField(
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        autofocus: autoFocus,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          counterText: '',
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
