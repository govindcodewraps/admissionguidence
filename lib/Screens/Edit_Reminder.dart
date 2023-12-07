// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
// import 'package:day_night_time_picker/lib/state/time.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
//
// import '../my_theme.dart';
// import 'Reminder_Screen.dart';
//
// class EditReminderScreen extends StatefulWidget {
//
//   final String meetingid;
//
//    EditReminderScreen({super.key, required this.meetingid});
//
//   @override
//   State<EditReminderScreen> createState() => _EditReminderScreenState();
// }
//
// class _EditReminderScreenState extends State<EditReminderScreen> {
//   TextEditingController dateInputController = TextEditingController();
//   TextEditingController remarkInputtextController = TextEditingController();
//   bool _isLoading = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.white,
//         ),
//         backgroundColor: MyTheme.backgroundcolor,
//         title: Text(
//           "Edit Reminder",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body:
//
//       Container(
//         width: double.infinity,
//         color: MyTheme.backgroundcolor,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
//                 decoration: BoxDecoration(
//                   color: MyTheme.WHITECOLOR,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 width: 300,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                    // Text(widget.meetingid.toString()),
//                     Text(
//                       "Edit Reminder",
//                       style: TextStyle(
//                         color: MyTheme.backgroundcolor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     // DOB
//                     TextFormField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                             width: 3,
//                             color: Colors.greenAccent,
//                           ),
//                         ),
//                         labelText: "Date",
//                         hintText: 'Date',
//                         suffixIcon: Icon(Icons.calendar_month, color: Colors.black),
//                       ),
//                       controller: dateInputController,
//                       readOnly: true,
//                       onTap: () async {
//                         DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(1950),
//                           lastDate: DateTime(2050),
//                         );
//
//                         if (pickedDate != null) {
//                           dateInputController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                         }
//                       },
//                     ),
//
//                     SizedBox(height: 30),
//                     TextField(
//                       controller: remarkInputtextController,
//                       maxLines: 4,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.symmetric(vertical: 10.0),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Container(
//                         alignment: Alignment.center,
//                         child: SizedBox(
//                           height: 50,
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
//                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                               ),
//                             ),
//                             onPressed: ()
//                             {
//                               if (dateInputController.text.isEmpty ||
//                                   remarkInputtextController.text.isEmpty) {
//                                 Fluttertoast.showToast(
//                                   msg: "Please fill in all fields",
//                                   toastLength: Toast.LENGTH_SHORT,
//                                   gravity: ToastGravity.CENTER,
//                                   timeInSecForIosWeb: 1,
//                                   backgroundColor: Colors.red,
//                                   textColor: Colors.white,
//                                   fontSize: 16.0,
//                                 );
//                               } else {
//                                 setState(() {
//                                   _isLoading = true;
//                                 });
//                                 updatemeeting(dateInputController.text,remarkInputtextController.text,widget.meetingid);                              }
//                             },
//
//                             //
//                             // {
//                             //   print("Date input ${dateInputController.text}");
//                             //   print("Remark input ${remarkInputtextController.text}");
//                             //   updatemeeting(dateInputController.text,remarkInputtextController.text,widget.meetingid);
//                             //   // Handle button press
//                             // },
//
//                             child: Text(
//                               "Save",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> updatemeeting(date,remark,id) async{
//
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=98f15c64ab923ccf587d6169af3d3708'
//     };
//     var data = {
//       'reminder_update': '1',
//       'date': date,
//       'remark': remark,
//       'id': id
//     };
//     var dio = Dio();
//     var response = await dio.request(
//       'https://admissionguidanceindia.com/appdata/webservice.php',
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//       print(json.encode(response.data));
//       Fluttertoast.showToast(
//           msg: "Update Reminder",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//           fontSize: 16.0
//       );
//       Navigator.pop(context);
//       Navigator.pop(context);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Reminder_Screen()));
//
//     }
//     else {
//       print(response.statusMessage);
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }




import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../models/ReminderTypeModel.dart';
import '../my_theme.dart';
import 'Reminder_Screen.dart';

class EditReminderScreen extends StatefulWidget {
  final String meetingid;

  EditReminderScreen({super.key, required this.meetingid});

  @override
  State<EditReminderScreen> createState() => _EditReminderScreenState();
}

class _EditReminderScreenState extends State<EditReminderScreen> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController remarkInputtextController = TextEditingController();
  bool _isLoading = false;
  String accountselectedValue = 'Select Reminder Type';
  var remindertypeid='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: MyTheme.backgroundcolor,
        title: Text(
          "Edit Reminder",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        //color: MyTheme.backgroundcolor,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
                  decoration: BoxDecoration(
                    color: MyTheme.WHITECOLOR,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Reminder",
                        style: TextStyle(
                          color: MyTheme.backgroundcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      reminderTypewidget(),
                      SizedBox(height: 10),
                      // DOB
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.greenAccent,
                            ),
                          ),
                          labelText: "Date",
                          hintText: 'Date',
                          suffixIcon: Icon(Icons.calendar_month, color: Colors.black),
                        ),
                        controller: dateInputController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050),
                          );

                          if (pickedDate != null) {
                            dateInputController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                          }
                        },
                      ),

                      SizedBox(height: 30),
                      TextField(
                        controller: remarkInputtextController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          alignment: Alignment.center,
                          child: Builder(
                            builder: (context) => SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (dateInputController.text.isEmpty ||
                                      remarkInputtextController.text.isEmpty) {
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(width: 20),
                                            Text("Saving..."),
                                          ],
                                        ),
                                      ),
                                    );
                                    await updatemeeting(dateInputController.text, remarkInputtextController.text, widget.meetingid,remindertypeid);
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  }
                                },
                                child: Text(
                                  "Save",
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reminderTypewidget() {
    return FutureBuilder(
      future: remindertypeAPI(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Container(
        //     child: Center(child: CircularProgressIndicator()),
        //   );
        // } else if (snapshot.hasError) {
        //   return Container(
        //     child: Center(
        //       child: Text('Error: Internal error'),
        //     ),
        //   );
        // } else
        if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Container(
            // padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [

                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  padding: EdgeInsets.only(left: 16,right: 11),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),  // Set the color of the border
                    borderRadius: BorderRadius.circular(12), // Set the border radius
                  ),
                  child:

                  DropdownButton<String>(
                    value: accountselectedValue,
                    onChanged: (newValue) {
                      setState(() {
                        accountselectedValue = newValue!;
                        remindertypeid=newValue;
                        print("Account Number ${newValue}");
                        print("Account Number id ${remindertypeid}");
                      });
                    },
                    underline: Container(),
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Select Reminder Type',
                        child: Text('Select Reminder Type'),
                      ),
                      ...snapshot.data!.data!.map((datum) {
                        return DropdownMenuItem<String>(
                          value: datum.id!,
                          child: Text("${(datum.type!)}"),
                        );
                      }).toList(),
                    ],
                  ),

                ),

                // selectedValue= snapshot.data.data.length;
              ],
            ),
          );
        }
      },
    );
  }
  Future<ReminderTypeModel?> remindertypeAPI() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      'reminder_type': '1',
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


      var responseData = response.data is String
          ? json.decode(response.data)
          : response.data;
      print("time slot list");
      print(responseData);
      print("time slot list");
      //optionss=responseData;
      return ReminderTypeModel.fromJson(responseData);
    }
    else {
      print(response.statusMessage);
    }
  }



  Future<void> updatemeeting(date, remark, id,reminderType) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=98f15c64ab923ccf587d6169af3d3708'
    };
    var data = {
      'reminder_update': '1',
      'date': date,
      'remark': remark,
      'id': id,
      'type_id':reminderType
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
      Fluttertoast.showToast(
        msg: "Update Reminder",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pop(context);
    //  Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Reminder_Screen()));
    } else {
      print(response.statusMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
