import 'dart:convert';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../baseurl.dart';
import '../my_theme.dart';
import 'Home_Screen.dart';
import 'commanwebview.dart';

String? finalEmail;

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
      'password': password
    };

    var url =
        BASEURL.DOMAIN_PATH;
        //'https://admissionguidanceindia.com/appdata/webservice.php';

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
      sharedPreferences.setString('email',_useridController.text);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

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
