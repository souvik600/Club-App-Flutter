import 'dart:async';
import 'package:club_app/Authentication/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../AppColors/AppColors.dart';
import '../Authentication/user_login_screen.dart'; // Your login screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 2 seconds before checking the authentication state
    Timer(const Duration(seconds: 2), _checkUserAuthentication);
  }

  // Check if the user is authenticated
  void _checkUserAuthentication() async {
    // Check the current user state
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // No user is signed in, navigate to the Login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserLogInScreen(),
        ),
      );
    } else {
      // User is signed in, navigate to the HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthWrapper(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, AppColors.pColor],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 25),
                      Image.asset(
                        "assets/images/logo.png",
                        height: 450.0,
                        width: 450.0,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          "মানব কল্যাণ যুব সংঘ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.spColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ),
                      const Text(
                        "রামনগর চর",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.sColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 150),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
