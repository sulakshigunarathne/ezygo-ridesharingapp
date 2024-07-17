import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'role_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();// Initialize the animation controller
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Define the animation
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _animationController!.forward();

    // Navigate to the next screen after the delay
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RolePage()),
      );
    });
  }

  @override
  void dispose() {
    // Dispose the animation controller
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 152, 237, 203),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo
            ScaleTransition(
              scale: _animation!,
              child: const SpinKitWave(
                color: Colors.white,
                size: 50.0,
              ),
            ),
            const SizedBox(height: 20),
            // Stylish text
            const Text(
              'EzyGO',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Connecting you to your destination',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}