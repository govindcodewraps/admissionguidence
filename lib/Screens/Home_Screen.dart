import 'dart:convert';
import 'dart:ui';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../my_theme.dart';
import 'Account_Details/AccountScreen.dart';
import 'Meeting_record_Screen.dart';
import 'Reminder_Screen.dart';
import 'loginscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController dateInputController = TextEditingController();

  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;
  DateTime? currentBackPressTime;
  String _appointmentscount="0";
  String _remindercount="0";
  String _percntagecount="0";

@override
  void initState() {
    // TODO: implement initState
  totalAppointmentAPI();
  totalpercentageAPI();
  totalReminderAPI();
    super.initState();
  }


  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
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
                        showLogoutConfirmationDialog(context);
                      },
                      child: Column(
                        children: [
                          //Icon(Icons.logout, color: Colors.red),
                          ClipOval(

                              child: Image.asset('assets/logoutbutton.jpg',height: 50,)),
                          // Text("Logout", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                    decoration: BoxDecoration(
                      // color: MyTheme.WHITECOLOR,
                        borderRadius:BorderRadius.circular(12)
                      // borderRadius: BorderRadius.all(Radius.circular(10))
                    ),

                    //height: 276,
                    //width: 400,

                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  //color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 100,
                            width: 130,
                            child:   Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Text("${_appointmentscount}",style:TextStyle(fontSize: 30),),

                                  Text("Total",style:TextStyle(color: Colors.black),),
                                  Text("Appointments",style:TextStyle(color: Colors.black),),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,


                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  //color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3),
                                ),
                              ],

                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 100,
                            width: 130,
                            child:  Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Text("${_percntagecount}%",style:TextStyle(fontSize: 30),),

                                  Text("Pending",style:TextStyle(color: Colors.black),),
                                  Text("Appointments",style:TextStyle(color: Colors.black),),

                                  //SizedBox(height: 1,),
                                ],
                              ),
                            ),

                          ),


                        ],),
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,


                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                //color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],

                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 100,
                          width: 130,

                          child:Center(
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Text("${_remindercount}",style:TextStyle(fontSize: 30),),

                                Text("Total",style:TextStyle(color: Colors.black),),
                                Text("Reminders ",style:TextStyle(color: Colors.black),),

                              ],
                            ),
                          ),
                        ),


                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     ClipOval(
                        //       child: Container(
                        //         height: 102,
                        //         width: 102,
                        //         padding: EdgeInsets.all(7),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(1),
                        //
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.black.withOpacity(0.3),
                        //               spreadRadius: 2,
                        //               blurRadius: 4,
                        //               offset: Offset(0, 3),
                        //             ),
                        //           ],
                        //         ),
                        //         child:Center(
                        //           child:
                        //           Column(
                        //             children: [
                        //               SizedBox(height: 10,),
                        //               Text("Today",style:TextStyle(color: Colors.black),),
                        //               Text("Appointments",style:TextStyle(color: Colors.black),),
                        //
                        //               Text("${_appointmentscount}",style:TextStyle(fontSize: 30),),
                        //                 ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 10,),
                        //
                        //     ClipOval(
                        //       child: Container(
                        //         height: 108,
                        //         width: 102,
                        //         padding: EdgeInsets.all(7),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(1),
                        //
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.black.withOpacity(0.3),
                        //               spreadRadius: 2,
                        //               blurRadius: 4,
                        //               offset: Offset(0, 3),
                        //             ),
                        //           ],
                        //         ),
                        //         child:
                        //         Center(
                        //           child: Column(
                        //             children: [
                        //               SizedBox(height: 10,),
                        //               Text("Today\nPending",style:TextStyle(color: Colors.black),),
                        //               Text("Appointments",style:TextStyle(color: Colors.black),),
                        //
                        //               Text("${_percntagecount}%",style:TextStyle(fontSize: 30),),
                        //               //SizedBox(height: 1,),
                        //                ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //
                        //     SizedBox(width: 10,),
                        //
                        //     ClipOval(
                        //       child: Container(
                        //         height: 102,
                        //         width: 102,
                        //         padding: EdgeInsets.all(7),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(1),
                        //
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.black.withOpacity(0.3),
                        //               spreadRadius: 2,
                        //               blurRadius: 4,
                        //               offset: Offset(0, 3),
                        //             ),
                        //           ],
                        //         ),
                        //         child:Center(
                        //           child: Column(
                        //             children: [
                        //               SizedBox(height: 10,),
                        //               Text("Total",style:TextStyle(color: Colors.black),),
                        //               Text("Reminder ",style:TextStyle(color: Colors.black),),
                        //
                        //               Text("${_remindercount}",style:TextStyle(fontSize: 30),),
                        //               ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //
                        //
                        //
                        //   ],),



                      ],
                    ),
                  ),

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
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Meeting_record_screen())).then((value){ if(value != null && value)
                                    {

                                      setState(() {
                                        totalAppointmentAPI();
                                        totalpercentageAPI();
                                        totalReminderAPI();
                                      });

                                    };
                                  });
                                  
                                  // setState(() {
                                  //   totalAppointmentAPI();
                                  //   totalpercentageAPI();
                                  //   totalReminderAPI();
                                  // });
                                  // onPressUpdatePassword();
                                },
                                child: Text(
                                  "APPOINTMENTS",
                                  // AppLocalizations.of(context).update_password_ucf,
                                  style: TextStyle(
                                      color:MyTheme.WHITECOLOR,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
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
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Reminder_Screen()));
                                  // onPressUpdatePassword();
                                  setState(() {
                                    totalAppointmentAPI();
                                    totalpercentageAPI();
                                    totalReminderAPI();
                                  });
                                },
                                child:Text(
                                  "REMINDERS",
                                  // AppLocalizations.of(context).update_password_ucf,
                                  style: TextStyle(
                                      color: MyTheme.backgroundcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
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
                                    backgroundColor: MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(12.0),
                                          //side: BorderSide()
                                        )
                                    )
                                ),

                                onPressed: (){
                                  //Navigator.push(context,MaterialPageRoute(builder: (context)=>stembuilddd()));
                                 // Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountdetailsScreen()));
                                  // onPressUpdatePassword();
                                  setState(() {
                                    totalAppointmentAPI();
                                    totalpercentageAPI();
                                    totalReminderAPI();
                                  });
                                },
                                child:Text(
                                  "TRANSACTION",
                                  // AppLocalizations.of(context).update_password_ucf,
                                  style: TextStyle(
                                      color:MyTheme.WHITECOLOR,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),),
                            ),
                          ),
                        ),
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
      'https://admissionguidanceindia.com/appdata/webservice.php',
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
      'https://admissionguidanceindia.com/appdata/webservice.php',
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
      'https://admissionguidanceindia.com/appdata/webservice.php',
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

}
