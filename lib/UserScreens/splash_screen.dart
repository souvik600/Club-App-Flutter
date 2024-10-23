import 'dart:async';
import 'package:club_app/Authentication/user_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AppColors/AppColors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserLogInScreen(),
        ),
      ),
    );
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
                      SizedBox(height: 25,),
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
