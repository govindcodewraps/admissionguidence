
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../USER_Screens/User_Home_Screen.dart';
import '../main.dart';
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
        if (userTye == 'superadmin') {
         print("AAAAA${userTye}");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>finalEmail == null ?LoginScreen() : HomeScreen()));
        } else {
          print("BBBBBB${userTye}");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>finalEmail == null ?LoginScreen() : UserHomeScreen()));

        }



      });
    });
  }


  Future getValidationData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    var obtainusertype = sharedPreferences.getString('usertypee');
    setState(() {
      finalEmail =obtainEmail;
      userTye=obtainusertype;
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

