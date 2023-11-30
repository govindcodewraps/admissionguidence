import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../my_theme.dart';
import 'Home_Screen.dart';

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


  @override
  void initState() {
    // TODO: implement initState
    getValidationData().whenComplete(() async {
 Navigator.push(context, MaterialPageRoute(builder: (context)=>finalEmail == null ?LoginScreen() : HomeScreen()));
    });

    super.initState();
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
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: MyTheme.backgroundcolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  decoration: BoxDecoration(
                    color: MyTheme.WHITECOLOR,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 485,
                  width: 335,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Image.asset("assets/logo.png"),
                      SizedBox(height: 30,),
                      Text("Email", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16),),

                      TextField(
                        controller: _useridController,
                       // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Email",
                          filled: true,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),


                      // TextField(
                      //   controller: _useridController,
                      //   decoration: InputDecoration(
                      //     hintText: "Email",
                      //     contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //   ),
                      // ),

                      SizedBox(height: 10,),
                      Text("Password", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16)),



                      TextField(
                        controller: _userpasswordController,
                        // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Password",
                          filled: true,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),



                      // TextField(
                      //
                      //   controller: _userpasswordController,
                      //   decoration: InputDecoration(
                      //     hintText: "Password",
                      //     contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //   ),
                      // ),


                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Text(
                      //     'Forget Password?',
                      //     style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16),
                      //   ),
                      // ),
                      SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(),
                                  ),
                                ),
                              ),
                              onPressed: () async {
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

                                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                  sharedPreferences.setString('email',_useridController.text);

                                  loginapi(_useridController.text.toString(), _userpasswordController.text.toString());





                                }
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Future<void> loginapi(userid, password) async {
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

    var url = 'https://admissionguidanceindia.com/appdata/webservice.php';

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      print("response");
      print(json.encode(json.decode(response.body)));
      print("response");
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
