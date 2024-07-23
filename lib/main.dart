import 'package:ezygo/Widgets/otp_verification.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:ezygo/Pages/splash_screen.dart';
import 'package:ezygo/Pages/map_page.dart';
import 'package:ezygo/Pages/role_page.dart';
// import 'Screens/login_screen.dart';
//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

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    //webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EzyGO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.lightGreen),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.lightGreen),
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
      ),
      home: const RolePage(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == 'otp') {
          final String? verificationId = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) {
              return OtpVerification(verificationID: verificationId ?? 'dummyVerificationId');
            },
          );
        }
   } );
  }
}
