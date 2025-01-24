import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newautobox/Screens/SignInScreen.dart';
import 'package:newautobox/Screens/dashboard_screen.dart';
import 'package:newautobox/Utils/Colors.dart';

import 'package:shared_preferences/shared_preferences.dart'; // For Timer

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  String email = '';
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _navigateToNextScreen();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool('isLoggedIn');
    String? isemail = prefs.getString('isUserEmail').toString() == null
        ? ''
        : prefs.getString('isUserEmail').toString();

    setState(() {
      isLoggedIn = status ?? false;
      email = isemail ?? '';
    });
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => isLoggedIn
              ? DashboardScreen(
                  email: email,
                )
              : SignInScreen(
                  Email: '',
                  Password: '',
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Center(
        child: Text(
          'Welcome to AUTOBOX',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
