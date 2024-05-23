// // import 'package:flutter/material.dart';
// //
// // import 'Screens/loginscreen.dart';
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // TRY THIS: Try running your application with "flutter run". You'll see
// //         // the application has a blue toolbar. Then, without quitting the app,
// //         // try changing the seedColor in the colorScheme below to Colors.green
// //         // and then invoke "hot reload" (save your changes or press the "hot
// //         // reload" button in a Flutter-supported IDE, or press "r" if you used
// //         // the command line to start the app).
// //         //
// //         // Notice that the counter didn't reset back to zero; the application
// //         // state is not lost during the reload. To reset the state, use hot
// //         // restart instead.
// //         //
// //         // This works for code too, not just values: Most code changes can be
// //         // tested with just a hot reload.
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home:  LoginScreen(),
// //     );
// //   }
// // }
//
//
//
//
//
//
// import 'dart:async';
// import 'package:admissionguidence/my_theme.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'Screens/Home_Screen.dart';
// import 'Screens/loginscreen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
//
// void main() {
//
//   // await Firebase.initializeApp(
//   //   options: DefaultFirebaseOptions.currentPlatform,
//   // );
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'My App',
//       home: SplashScreen(),
//     );
//   }
// }
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   //FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _getFcmToken();
//   // }
//
//   // Future<void> _getFcmToken() async {
//   //   String? token = await _firebaseMessaging.getToken();
//   //   print("FCM Token newww: $token");
//   // }
//
//
//   @override
//   void initState() {
//     super.initState();
//     //_getFcmToken();
//
//     // Simulate a splash screen delay using a timer
//     Timer(Duration(seconds: 2), () {
//       // Navigate to the home screen after the delay
//       getValidationData().whenComplete(() async {
//        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>finalEmail == null ?LoginScreen() : HomeScreen()));
//       });
//     });
//
//   }
//
//
//   Future getValidationData() async{
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     var obtainEmail = sharedPreferences.getString('email');
//     setState(() {
//       finalEmail =obtainEmail;
//     });
//     print("""""""""""");
//     print(finalEmail);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyTheme.WHITECOLOR, // Set your desired background color
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//                Image.asset("assets/logo.png"),
//
//             // You can add a logo or other widgets here if needed
//           ],
//         ),
//       ),
//     );
//   }
// }
//


import 'dart:async';
import 'dart:developer';
import 'package:admissionguidence/my_theme.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Home_Screen.dart';
import 'Screens/loginscreen.dart';
import 'USER_Screens/User_Home_Screen.dart';
import 'firebase_options.dart';
import 'package:device_info_plus/device_info_plus.dart';

String? devicetoken;
String? userTypee;
String? userTye;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
void main() async {
  runApp( MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  log("FCMTokenaaaaa $fcmToken");
  devicetoken=fcmToken;
  //print("object")
}

String deviceId = 'Unknown';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
 // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
 // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  @override
  void initState() {
    super.initState();
    // _getFcmToken();

    Timer(Duration(seconds: 2), () {
      getValidationData().whenComplete(() async {

        if (userTye == 'superadmin') {
          print("AAAAAMM${userTye}");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => finalEmail == null ? LoginScreen() : HomeScreen(),),);
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>finalEmail == null ?LoginScreen() : HomeScreen()));
        } else {
          print("BBBBBBMM${userTye}");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => finalEmail == null ? LoginScreen() : UserHomeScreen(),),);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>finalEmail == null ?LoginScreen() : UserHomeScreen()));

        }


        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => finalEmail == null ? LoginScreen() : HomeScreen(),),);


      });
    });


    // _firebaseMessaging.getToken().then((token) {
    //   print("FCM Token: $token");
    // });




  }





  // @override
  // void initState() {
  //   super.initState();
  //
  //   _firebaseMessaging.getToken().then((token) {
  //     print("FCM Token: $token");
  //   });
  //
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //       // Handle incoming messages when the app is in the foreground.
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //       // Handle launch notifications here.
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //       // Handle resume notifications here.
  //     },
  //   );
  // }
  //



  // Future<void> _getFcmToken() async {
  //   String? token = await _firebaseMessaging.getToken();
  //   print("FCM Token: $token");
  // }


  // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.setString('token',fcmToken);
  //

  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    var obtainusertype = sharedPreferences.getString('usertypee');
    setState(() {
      finalEmail = obtainEmail;
      userTye=obtainusertype;
      print("obtainusertype:: ${obtainusertype}");
    });
    print(finalEmail);
    print("USerttt ${userTye}");
    print("obtainusertype:: ${obtainusertype}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.WHITECOLOR,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png"),
          ],
        ),
      ),
    );
  }
}
