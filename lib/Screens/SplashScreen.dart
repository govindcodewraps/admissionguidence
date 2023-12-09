
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home_Screen.dart';
import 'loginscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a splash screen delay using a timer
    Timer(Duration(seconds: 3), () {
      // Navigate to the home screen after the delay
      getValidationData().whenComplete(() async {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>finalEmail == null ?LoginScreen() : HomeScreen()));
      });
    });
  }


  Future getValidationData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail =obtainEmail;
    });
    print("""""""""""");
    print(finalEmail);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to My App',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            // You can add a logo or other widgets here if needed
          ],
        ),
      ),
    );
  }
}

