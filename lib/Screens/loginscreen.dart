import 'dart:convert';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../USER_Screens/User_Home_Screen.dart';
import '../USER_Screens/userscreen.dart';
import '../baseurl.dart';
import '../main.dart';
import '../my_theme.dart';
import 'Home_Screen.dart';
import 'commanwebview.dart';

String? finalEmail;
String? finalE="govind";
String? userType;
String? useriid;

class LoginScreen extends StatefulWidget {


  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _useridController = TextEditingController();
  TextEditingController _userpasswordController = TextEditingController();
  bool _isLoading = false;
  bool _isAgree = false;
  bool _obscureText = true;



  late DeviceInfoPlugin deviceInfo;

  @override
  void initState() {
    super.initState();
    deviceInfo = DeviceInfoPlugin();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Android Device Info: $androidInfo');
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('iOS Device Info: $iosInfo');
      }
    } catch (e) {
      print('Error getting device info: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child:

              Container(

                decoration: BoxDecoration(
                  //color: Colors.yellow,

                  image: DecorationImage(

                    image: AssetImage('assets/background.jpg'), // Replace with your image asset path
                    fit: BoxFit.fill,
                  ),
                ),

                child:BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY:4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.387,
                        child: SizedBox(
                            child: Image.asset("assets/logo.png",)),
                        // height: 200,
                        //olor: Colors.red,
                      ),
                      Container(
                        //height: MediaQuery.of(context).size.height*0.6,
                        padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                        decoration: BoxDecoration(
                          color: MyTheme.WHITECOLOR,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                          //border: Border.all(color: MyTheme.backgroundcolor)
                        ),
                        // height: 485,
                        //width: 335,
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Welcome Back !",style:TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: MyTheme.backgroundcolor),),
                            //SizedBox(height: 20,),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            Text("User Name", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16,),),

                            TextField(
                              controller: _useridController,

                              cursorColor: MyTheme.backgroundcolor,
                              decoration: InputDecoration(
                                hintText: "User Name",
                                hintStyle: TextStyle(color: MyTheme.backgroundcolor.withOpacity(0.5)), // Adjust the opacity as needed
                              ),
                            ),



                            SizedBox(height: 20,),
                            Text("Password", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16,)),


                            TextField(
                              controller: _userpasswordController,
                              cursorColor: MyTheme.backgroundcolor,
                              obscureText: _obscureText,
                             // obscureText: _obscureText,

                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: _obscureText
                                      ? Icon(Icons.visibility,color: MyTheme.backgroundcolor
                                    // Feather.eye_off, // Use Feather for Flutter icons
                                  )
                                      : Icon(
                                    Icons.visibility_off,color: Colors.grey,
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(color: MyTheme.backgroundcolor.withOpacity(0.5)), // Adjust the opacity as needed
                              ),
                            ),

                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                            Padding(
                              padding:  EdgeInsets.only(top: 0.0, left: 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      value: _isAgree,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _isAgree = newValue ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 8,),
                                  // RichText(
                                  //   text: TextSpan(
                                  //     text: 'Hello ',
                                  //     style: DefaultTextStyle.of(context).style,
                                  //     children: <TextSpan>[
                                  //       TextSpan(
                                  //         text: 'world',
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.blue,
                                  //           fontSize: 20,
                                  //         ),
                                  //       ),
                                  //       TextSpan(
                                  //         text: '!',
                                  //         style: TextStyle(
                                  //           fontStyle: FontStyle.italic,
                                  //           color: Colors.green,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Flexible(child: Text("I hereby agree to the Terms and Conditions and Privacy Policy.")),
                                  Flexible(child:
                                  RichText(
                                    text: TextSpan(
                                    //  text: 'I hereby agree to the ',
                                      //style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'I hereby agree to the ',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            //fontSize: 20,
                                          ),
                                        ),
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CommonWebviewScreen(
                                                            page_name:
                                                            "Terms Conditions",
                                                            url:
                                                            //"https://umonm.com/",
                                                            "https://admissionguidanceindia.com/about-us",
                                                          )));
                                            },
                                          text: 'Terms  Conditions ',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '& ',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                          ),
                                        ),

                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CommonWebviewScreen(
                                                            page_name:
                                                            "Privacy Policy",
                                                            url:
                                                            //"https://umonm.com/",
                                                            "https://admissionguidanceindia.com/about-us",
                                                          )));
                                            },

                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 8.0),
                                  //   child: Container(
                                  //     width: DeviceInfo(context).width - 130,
                                  //     child: RichText(
                                  //         maxLines: 2,
                                  //         text: TextSpan(
                                  //             style: TextStyle(
                                  //                 color: MyTheme.font_grey, fontSize: 12),
                                  //             children: [
                                  //               TextSpan(
                                  //                 text: "I agree to the",
                                  //               ),
                                  //               TextSpan(
                                  //                 recognizer: TapGestureRecognizer()
                                  //                   ..onTap = () {
                                  //                     Navigator.push(
                                  //                         context,
                                  //                         MaterialPageRoute(
                                  //                             builder: (context) =>
                                  //                                 CommonWebviewScreen(
                                  //                                   page_name:
                                  //                                   "Terms Conditions",
                                  //                                   url:
                                  //                                   //"https://umonm.com/",
                                  //                                   "${AppConfig.RAW_BASE_URL}/mobile-page/terms",
                                  //                                 )));
                                  //                   },
                                  //                 style:
                                  //                 TextStyle(color: MyTheme.accent_color),
                                  //                 text: " Terms Conditions",
                                  //               ),
                                  //               TextSpan(
                                  //                 text: " &",
                                  //               ),
                                  //               TextSpan(
                                  //                 recognizer: TapGestureRecognizer()
                                  //                   ..onTap = () {
                                  //                     Navigator.push(
                                  //                         context,
                                  //                         MaterialPageRoute(
                                  //                             builder: (context) =>
                                  //                                 CommonWebviewScreen(
                                  //                                   page_name:
                                  //                                   "Privacy Policy",
                                  //                                   url:
                                  //                                   "${AppConfig.RAW_BASE_URL}/mobile-page/privacy-policy",
                                  //                                 )));
                                  //                   },
                                  //                 text: " Privacy Policy",
                                  //                 style:
                                  //                 TextStyle(color: MyTheme.accent_color),
                                  //               )
                                  //             ])),
                                  //   ),
                                  // ),


                                ],
                              ),
                            ),

                            //Text(devicetoken.toString()),
                            Text(useridd.toString()),

                            SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 45,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        _isAgree ? MyTheme.backgroundcolor : Colors.grey,
                                      ),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: MyTheme.WHITECOLOR,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: _isAgree
                                        ? () {
                                      if (_useridController.text.isEmpty ||
                                          _userpasswordController.text.isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Please fill in all fields",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      } else {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        loginapi(
                                          _useridController.text.toString(),
                                          _userpasswordController.text.toString(),
                                        );
                                      }
                                    }
                                        : null,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],),
                ),
              ),

            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  // Future loginapi(userid, password) async {
  //   // Your existing loginapi function remains unchanged
  //
  //   var headers = {
  //     'accept': 'application/json',
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'Cookie': 'PHPSESSID=f96183e9729c0eae79af2650a7464f8d'
  //   };
  //
  //   var data = {
  //     'login': '1',
  //     'username': userid,
  //     'password': password,
  //     //Text(devicetoken.toString()),
  //    // 'device_token': "fhxbFNwFRVup2rH01xNX2I:APA91bHczbBlZuh79yIf38xk-jewg0dNzjID7o5NT1M-d6FWeKmigDSAO5qAW4Mt1EcOmJLgTyseH8phIXPyJJwcD0_3mWDEFIZVuCqAG6Il4HgnBQU6Ux31QEq4r97FqlNuLQNUrxIw"
  //     'device_token': devicetoken
  //   };
  //
  //
  //   var url =
  //       //BASEURL.DOMAIN_PATH;
  //       "https://admissionguidanceindia.com/appdata/login.php";
  //       //'https://admissionguidanceindia.com/appdata/webservice.php';
  //
  //   var response = await http.post(
  //     Uri.parse(url),
  //     headers: headers,
  //     body: data,
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print("response");
  //     print(json.encode(json.decode(response.body)));
  //     print("response");
  //
  //     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //     sharedPreferences.setString('email',_useridController.text);
  //
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //
  //     Fluttertoast.showToast(
  //       msg: "Login Successfully",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.green,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //
  //   } else {
  //     print('Error: ${response.reasonPhrase}');
  //     Fluttertoast.showToast(
  //       msg: "Invalid User ID & Password",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //   }
  //
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }



  Future loginapi(userid, password) async {
    // Your existing loginapi function remains unchanged

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=f96183e9729c0eae79af2650a7464f8d'
    };

    var data = {
      'login': '1',
      'username': userid,
      'password': password,
      'device_token': devicetoken
    };

    var url = "https://admissionguidanceindia.com/appdata/login.php";

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      print("response");
      print(json.encode(json.decode(response.body)));
      print("response");

      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('email', _useridController.text,);
     // sharedPreferences.setString('usertypee', userType.toString());

      var responseData = json.decode(response.body);

      print("reeeeeeeee");
      userType = responseData['type'];
      useriid = responseData['id'];
      print(responseData['type']);
      print("reeeeeeeee");
      print(userType);
      print(useriid);
      print("usertttty");


      if (responseData['type'] == 'superadmin') {
        userType="superadmin";
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('usertypee', userType.toString());
        sharedPreferences.setString('useriid', useriid.toString());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        userType="admin";
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('usertypee', userType.toString());
        sharedPreferences.setString('useriid', useriid.toString());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>UserHomeScreen()));
      }

      Fluttertoast.showToast(
        msg: "Login Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    } else {
      print('Error: ${response.reasonPhrase}');
      Fluttertoast.showToast(
        msg: "Invalid User ID & Password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }


}
