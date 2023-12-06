import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../my_theme.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController remarkInputtextController = TextEditingController();
  bool _isLoading = false;


 //TextEditingController dateInputController = TextEditingController();
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  List<String> timeSlotOptions = ['Time Slot', '10:00 - 10:15', '10:30 - 11:11', '20:00 - 20:20'];
  String selectedTimeSlot = 'Time Slot'; // Initial value, you can set it based on your requirements

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: MyTheme.backgroundcolor,
        title: Text(
          "Add Reminder",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body:
      Container(
        width: double.infinity,
        //color: MyTheme.backgroundcolor,
        decoration: BoxDecoration(
          color: Colors.yellow,

          image: DecorationImage(

            image: AssetImage('assets/background.jpg'), // Replace with your image asset path
            fit: BoxFit.fill,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY:4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child:
                _isLoading
                    ? CircularProgressIndicator() // Show the circular progress indicator
                    :
                Container(
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
                      // Text(widget.meetingid.toString()),
                      Text(
                        "Add Reminder",
                        style: TextStyle(
                          color: MyTheme.backgroundcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                          child: SizedBox(
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
                              onPressed: ()
                              {
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
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  addmeeting(dateInputController.text,remarkInputtextController.text);                              }
                              },

                              //
                              // {
                              //   print("Date input ${dateInputController.text}");
                              //   print("Remark input ${remarkInputtextController.text}");
                              //   updatemeeting(dateInputController.text,remarkInputtextController.text,widget.meetingid);
                              //   // Handle button press
                              // },

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

  Future<void> addmeeting(date,remark) async{
    setState(() {
      _isLoading = true;
    });

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=98f15c64ab923ccf587d6169af3d3708'
    };
    var data = {
      'reminder_add': '1',
      'date': date,
      'remark': remark
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
        msg: "Reminder Set Succesfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.pop(context);
    }
    else {
      print(response.statusMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
