import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz_app/screens/auth/login_landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2500), landingScreen);
  }

  void landingScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LandingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: Center(
        child: Image.asset('assets/images/logo.png', height: 240)
            .animate()
            .fadeIn(duration: 500.ms)          
            .then(delay: 1000.ms)              
            ,        
      ),
    );
  }
}