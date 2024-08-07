import 'dart:convert';
import 'dart:ui';
import 'package:admissionguidence/USER_Screens/todaytask.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/Account_Details/AccountScreen.dart';
import '../Screens/Meeting_record_Screen.dart';
import '../Screens/Reminder/ReminderTabScreen.dart';
import '../Screens/loginscreen.dart';
import '../USER_Screens/userscreen.dart';
import '../baseurl.dart';
import '../loginlogoutdetails.dart';
import '../main.dart';
import '../my_theme.dart';

String? logouttime;

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<UserHomeScreen> {
  TextEditingController dateInputController = TextEditingController();

  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;
  DateTime? currentBackPressTime;
  String _appointmentscount="0";
  String _remindercount="0";
  String _percntagecount="0";
  String _TOTALREMINDERCOUNT="0";
  String _TOTALAPPOINTMENTSCOUNT="0";
  String _TOTALTRANSACTIONCOUNT="0";


  void fetchCurrentTime() {
    setState(() {
      currentTime = DateTime.now().toString();
      logouttime=currentTime;
      print("Print current time ${currentTime}");
      print("Print current timeee${logouttime}");
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    transactionfetchData();
    appoinmentsfetchData();
    reminderfetchData();
    totalAppointmentAPI();
    totalpercentageAPI();
    print("govind emaill:::");
    print(finalE);


    totalReminderAPI();
    super.initState();
  }


  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainEmail;
    });
    print("Govind");
    print(finalEmail);
  }


  @override
  Widget build(BuildContext context) {
    print(_time);
    print("time");


// ...


    void showLogoutConfirmationDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Logout Confirmation"),
            content: Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("Cancel",style: TextStyle(color: Colors.grey),),
              ),
              TextButton(
                onPressed: () async {
                  // Perform logout actions
                  logout_time_api();
                  gobaluseridd = '';
                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.remove('email');
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child:
                //Image.asset('assets/logoutbutton.jpg'),
                Text("Logout",style: TextStyle(color: Colors.red),),
              ),
            ],
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                Duration(seconds: 2)) {
          currentBackPressTime = DateTime.now();
          // Show a snackbar or a dialog to inform the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
            ),
          );
          return false;
        }
        return true;
      },
      child:   SafeArea(
        child: Scaffold(body:
        Container(
          width: double.infinity,

          decoration: BoxDecoration(
            // color: MyTheme.backgroundcolor,

            image: DecorationImage(

              image: AssetImage('assets/background.jpg'), // Replace with your image asset path
              fit: BoxFit.fill,
            ),
          ),
          child:  BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY:4),
            child:Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment. end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [




                  Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: InkWell(
                      onTap: () {
                        fetchCurrentTime();
                        showLogoutConfirmationDialog(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>loginlogoutdetails()));
                          }, child: Text("Login details"),),

                          //Icon(Icons.logout, color: Colors.red),
                          ClipOval(

                              child: Image.asset('assets/logoutbutton.jpg',height: 50,)),
                          // Text("Logout", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ),


                  Container(
                    height: MediaQuery.of(context).size.height*0.387,
                    child: SizedBox(
                        child: Image.asset("assets/logo.png",)),
                    // height: 200,
                    //olor: Colors.red,
                  ),



                  // Container(
                  //   padding: EdgeInsets.fromLTRB(16, 10, 16, 16 ),
                  //   decoration: BoxDecoration(
                  //     // color: MyTheme.WHITECOLOR,
                  //       borderRadius:BorderRadius.circular(12)
                  //     // borderRadius: BorderRadius.all(Radius.circular(10))
                  //   ),
                  //
                  //   //height: 276,
                  //   //width: 400,
                  //
                  //   child: Column(
                  //     //mainAxisAlignment: MainAxisAlignment.center,
                  //     //crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Colors.black.withOpacity(0.4),
                  //                   //color: Colors.black.withOpacity(0.2),
                  //                   spreadRadius: 2,
                  //                   blurRadius: 4,
                  //                   offset: Offset(0, 3),
                  //                 ),
                  //               ],
                  //               borderRadius: BorderRadius.circular(12),
                  //             ),
                  //             height: 200,
                  //             width: 130,
                  //             child:   Center(
                  //               child: Column(
                  //                 children: [
                  //                   SizedBox(height: 10,),
                  //                   Text("${_appointmentscount}",style:TextStyle(fontSize: 30),),
                  //
                  //                   Text("Today",style:TextStyle(color: Colors.black),),
                  //                   Text("Appointments",style:TextStyle(color: Colors.black),),
                  //
                  //
                  //                   SizedBox(height: 0,),
                  //                   Text("${_percntagecount}%",style:TextStyle(fontSize: 30),),
                  //                   Text("Today",style:TextStyle(color: Colors.black),),
                  //                   Text("Pending",style:TextStyle(color: Colors.black),),
                  //                   Text("Appointments",style:TextStyle(color: Colors.black),),
                  //
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(width: 30,),
                  //
                  //
                  //           Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //
                  //
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Colors.black.withOpacity(0.4),
                  //                   //color: Colors.black.withOpacity(0.2),
                  //                   spreadRadius: 2,
                  //                   blurRadius: 4,
                  //                   offset: Offset(0, 3),
                  //                 ),
                  //               ],
                  //
                  //               borderRadius: BorderRadius.circular(12),
                  //             ),
                  //             height: 110,
                  //             width: 130,
                  //             child:  Center(
                  //               child: Column(
                  //                 children: [
                  //                   SizedBox(height: 10,),
                  //
                  //                   Text("${_remindercount}",style:TextStyle(fontSize: 30),),
                  //
                  //                   Text("Today",style:TextStyle(color: Colors.black),),
                  //                   Text("Reminders",style:TextStyle(color: Colors.black),),
                  //
                  //
                  //                   // SizedBox(height: 0,),
                  //                   //
                  //                   // Text("${_percntagecount}%",style:TextStyle(fontSize: 30),),
                  //                   // Text("Today",style:TextStyle(color: Colors.black),),
                  //                   // Text("Pending",style:TextStyle(color: Colors.black),),
                  //                   // Text("Reminders",style:TextStyle(color: Colors.black),),
                  //
                  //                 ],
                  //               ),
                  //             ),
                  //
                  //           ),
                  //
                  //
                  //         ],),
                  //
                  //
                  //     ],
                  //   ),
                  // ),


                  // ElevatedButton(onPressed: (){
                  //   Navigator.push(context,MaterialPageRoute(builder: (context)=>UserScreen()));
                  // }, child: Text("User Screen")),

                  //Text(userType),

                  Container(
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                      //border: Border.all(color: MyTheme.backgroundcolor)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60,),
                       // Text(currentTime.toString()),
                       //  Text("asdfghj"),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            alignment: Alignment.center,
                            //width: DeviceInfo(context).width/1,

                            child:
                            SizedBox(
                              height: 50,
                              width:double.infinity,
                              child: ElevatedButton(

                                style: ButtonStyle(
                                    backgroundColor:MaterialStateProperty.all<Color>(MyTheme.YELLOCOLOR),

                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(12.0),
                                          // side: BorderSide()
                                        )
                                    )
                                ),

                                onPressed: (){

                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>UserScreen()));



                                  // Navigator.push(context,MaterialPageRoute(builder: (context)=>Meeting_record_screen())).then((value){ if(value != null && value)
                                  // {
                                  //   setState(() {
                                  //     transactionfetchData();
                                  //     appoinmentsfetchData();
                                  //     reminderfetchData();
                                  //     totalAppointmentAPI();
                                  //     totalpercentageAPI();
                                  //     totalReminderAPI();
                                  //   });
                                  // };
                                  // });


                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Task",
                                      // AppLocalizations.of(context).update_password_ucf,
                                      style: TextStyle(
                                          color:MyTheme.WHITECOLOR,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    //SizedBox(width: 10,),
                                    // Text(
                                    //   //" 98 ",
                                    //   "(${_TOTALAPPOINTMENTSCOUNT})",
                                    //   //TOTALAPPOINTMENTSCOUNT.toString(),
                                    //   // AppLocalizations.of(context).update_password_ucf,
                                    //   style: TextStyle(
                                    //       color:MyTheme.WHITECOLOR,
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
                                  ],
                                ),),
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            alignment: Alignment.center,
                            //width: DeviceInfo(context).width/1,

                            child:
                            SizedBox(
                              height: 50,
                              width:double.infinity,
                              child: ElevatedButton(

                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(MyTheme.WHITECOLOR),
                                    // MaterialStateProperty.all<Color>(MyTheme.YELLOCOLOR),

                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(12.0),
                                          //side: BorderSide()
                                        )
                                    )
                                ),

                                onPressed: (){
                                  //Navigator.push(context,MaterialPageRoute(builder: (context)=>stembuilddd()));
                                   Navigator.push(context,MaterialPageRoute(builder: (context)=>TodayTaskScreen()));


                                  // Navigator.push(context,MaterialPageRoute(builder: (context)=>ReminderTabScreen())).then((value){ if(value != null && value)
                                  // {
                                  //   setState(() {
                                  //     transactionfetchData();
                                  //     appoinmentsfetchData();
                                  //     reminderfetchData();
                                  //     totalAppointmentAPI();
                                  //     totalpercentageAPI();
                                  //     totalReminderAPI();
                                  //   });
                                  // };
                                  // });

                                },
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Today Task",
                                      // AppLocalizations.of(context).update_password_ucf,
                                      style: TextStyle(
                                          color: MyTheme.backgroundcolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 10,),
                                    // Text(
                                    //   "(${_TOTALREMINDERCOUNT})",
                                    //   //"8",
                                    //   // AppLocalizations.of(context).update_password_ucf,
                                    //   style: TextStyle(
                                    //       color: MyTheme.backgroundcolor,
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
                                  ],
                                ),),
                            ),
                          ),
                        ),
                        //Text(gobaluseridd.toString()),
                        SizedBox(height: 40,),

                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     //width: DeviceInfo(context).width/1,
                        //
                        //     child:
                        //     SizedBox(
                        //       height: 50,
                        //       width:double.infinity,
                        //       child: ElevatedButton(
                        //
                        //         style: ButtonStyle(
                        //             backgroundColor: MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
                        //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        //                 RoundedRectangleBorder(
                        //
                        //                   borderRadius: BorderRadius.circular(12.0),
                        //                   //side: BorderSide()
                        //                 )
                        //             )
                        //         ),
                        //
                        //         onPressed: (){
                        //           //Navigator.push(context,MaterialPageRoute(builder: (context)=>stembuilddd()));
                        //           // onPressUpdatePassword();
                        //
                        //           // Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountdetailsScreen()));
                        //
                        //           Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountdetailsScreen())).then((value){ if(value != null && value)
                        //           {
                        //             setState(() {
                        //               transactionfetchData();
                        //               appoinmentsfetchData();
                        //               reminderfetchData();
                        //               totalAppointmentAPI();
                        //               totalpercentageAPI();
                        //               totalReminderAPI();
                        //             });
                        //           };
                        //           });
                        //
                        //         },
                        //         child:Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Text(
                        //               "TRANS",
                        //               // AppLocalizations.of(context).update_password_ucf,
                        //               style: TextStyle(
                        //                   color:MyTheme.WHITECOLOR,
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.w600),
                        //             ),
                        //             SizedBox(width: 10,),
                        //             Text(
                        //               "(${_TOTALTRANSACTIONCOUNT})",
                        //               // AppLocalizations.of(context).update_password_ucf,
                        //               style: TextStyle(
                        //                   color:MyTheme.WHITECOLOR,
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.w600),
                        //             ),
                        //           ],
                        //         ),),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 40,),
                      ],
                    ),
                  ),
                ],),
            ),
          ),

        ),),
      ),
    );
  }

  Future<int?> totalAppointmentAPI() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=d317ff54f034d4b459a98f619c622a7a'
    };
    var data = {
      'totle_appointment': '1'
    };
    var dio = Dio();
    var response = await dio.request(
      //'https://admissionguidanceindia.com/appdata/webservice.php',
      BASEURL.DOMAIN_PATH,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      print("Total Appointmentss");
      // Decode the JSON string to a Map
      Map<String, dynamic> responseData = json.decode(response.data);

      // Check if 'data' field is present in the response
      if (responseData.containsKey('data')) {
        var dataValue = responseData['data'];

        print("Data value: $dataValue");
        _appointmentscount = dataValue.toString();
        print("_nitificationcount: $_appointmentscount");
        setState(() {
          _appointmentscount = dataValue.toString();
        });
        return dataValue;
      }
    }
    else {
      print(response.statusMessage);
    }
  }

  Future<int?> totalReminderAPI() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=d317ff54f034d4b459a98f619c622a7a'
    };
    var data = {
      'totle_reminder': '1'
    };
    var dio = Dio();
    var response = await dio.request(
      //'https://admissionguidanceindia.com/appdata/webservice.php',
      BASEURL.DOMAIN_PATH,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      print("Total Appointmentss");
      // Decode the JSON string to a Map
      Map<String, dynamic> responseData = json.decode(response.data);

      // Check if 'data' field is present in the response
      if (responseData.containsKey('data')) {
        var dataValue = responseData['data'];

        print("Data value: $dataValue");
        _remindercount = dataValue.toString();
        print("_remindercount: $_remindercount");
        setState(() {
          _remindercount = dataValue.toString();
        });
        return dataValue;
      }
    }
    else {
      print(response.statusMessage);
    }
  }

  Future<int?> totalpercentageAPI() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=d317ff54f034d4b459a98f619c622a7a'
    };
    var data = {
      'appointment_percentage': '1'
    };
    var dio = Dio();
    var response = await dio.request(
      BASEURL.DOMAIN_PATH,
      //'https://admissionguidanceindia.com/appdata/webservice.php',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      print("Total Appointmentss");
      // Decode the JSON string to a Map
      Map<String, dynamic> responseData = json.decode(response.data);

      // Check if 'data' field is present in the response
      if (responseData.containsKey('data')) {
        var dataValue = responseData['data'];

        print("Data value: $dataValue");
        _percntagecount = dataValue.toString();
        print("_percntagecount: $_percntagecount");
        setState(() {
          _percntagecount = dataValue.toString();
        });
        return dataValue;
      }
    }
    else {
      print(response.statusMessage);
    }
  }


  Future<int?> reminderfetchData() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=d317ff54f034d4b459a98f619c622a7a'
    };
    var data = {
      'new_totle_reminder_count': '1',
    };
    var dio = Dio();
    var response = await dio.request(
      BASEURL.DOMAIN_PATH,
      //'https://admissionguidanceindia.com/appdata/webservice.php',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      print("Total Appointmentss");
      // Decode the JSON string to a Map
      Map<String, dynamic> responseData = json.decode(response.data);

      // Check if 'data' field is present in the response
      if (responseData.containsKey('data')) {
        var dataValue = responseData['data'];

        print("Data value: $dataValue");
        _TOTALREMINDERCOUNT = dataValue.toString();
        print("_TOTALREMINDERCOUNT: $_TOTALREMINDERCOUNT");
        setState(() {
          _TOTALREMINDERCOUNT = dataValue.toString();
        });
        return dataValue;
      }
    }
    else {
      print(response.statusMessage);
    }
  }
  Future<int?> appoinmentsfetchData() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=d317ff54f034d4b459a98f619c622a7a'
    };
    var data = {
      'new_totle_appointment_count': '1',
    };
    var dio = Dio();
    var response = await dio.request(
      BASEURL.DOMAIN_PATH,
      //'https://admissionguidanceindia.com/appdata/webservice.php',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      print("Total Appointmentss");
      // Decode the JSON string to a Map
      Map<String, dynamic> responseData = json.decode(response.data);

      // Check if 'data' field is present in the response
      if (responseData.containsKey('data')) {
        var dataValue = responseData['data'];

        print("Data value: $dataValue");
        _TOTALAPPOINTMENTSCOUNT = dataValue.toString();
        print("_TOTALAPPOINTMENTSCOUNT: $_TOTALAPPOINTMENTSCOUNT");
        setState(() {
          _TOTALAPPOINTMENTSCOUNT = dataValue.toString();
        });
        return dataValue;
      }
    }
    else {
      print(response.statusMessage);
    }
  }
  Future<int?> transactionfetchData() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=d317ff54f034d4b459a98f619c622a7a'
    };
    var data = {
      'totle_payment': '1'
    };
    var dio = Dio();
    var response = await dio.request(
      BASEURL.DOMAIN_PATH,
      //'https://admissionguidanceindia.com/appdata/webservice.php',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      print("Total Appointmentss");
      // Decode the JSON string to a Map
      Map<String, dynamic> responseData = json.decode(response.data);

      // Check if 'data' field is present in the response
      if (responseData.containsKey('data')) {
        var dataValue = responseData['data'];

        print("Data value: $dataValue");
        _TOTALTRANSACTIONCOUNT = dataValue.toString();
        print("_TOTALTRANSACTIONCOUNT: $_TOTALTRANSACTIONCOUNT");
        setState(() {
          _TOTALTRANSACTIONCOUNT = dataValue.toString();
        });
        return dataValue;
      }
    }
    else {
      print(response.statusMessage);
    }
  }

  Future logout_time_api()async {
    var headers = {
      'access_token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMTQiLCJhY2Nlc3NfdG9rZW4iOiIxMjM0NTYifQ.IBe_g4HmFhe4RNylBNzJR1HalgCqaI5WIYTK89oC6Q8',
      'Cookie': 'PHPSESSID=islv5lvuqil9bhmas8d10o8kgb'
    };

    var data = FormData.fromMap({
      'logout': '1',
      'logout_time': logouttime,
      'user_id': gobaluseridd.toString()
    });

    var dio = Dio();

    try {
      var response = await dio.request(
        'https://admissionguidanceindia.com/appdata/task.php',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {

        print("logout api :::${response.data}");
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}



