import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/Reminder_List_Model.dart';
import '../my_theme.dart';
import 'Add_Reminder_screen.dart';
import 'Edit_Reminder.dart';

class Reminder_Screen extends StatefulWidget {
  const Reminder_Screen({super.key});

  @override
  State<Reminder_Screen> createState() => _Reminder_ScreenState();
}

class _Reminder_ScreenState extends State<Reminder_Screen> {
  TextEditingController dateInputController = TextEditingController();

  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

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
          color: Colors.white, // Change the icon color here
        ),
        backgroundColor: MyTheme.backgroundcolor,
        title: Text(
          "Reminder",
          style: TextStyle(
            color: Colors.white, // Change the text color here
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: MyTheme.backgroundcolor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              reminderlistwidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the "Add Reminder" button tap
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReminderScreen(),
            ),
          );
        },
        backgroundColor: Colors.blue, // Set the FAB background color
        child: Icon(Icons.add,size: 20,),
      ),
    );
  }


  Widget reminderlistwidget() {
    return
      FutureBuilder(
        future: reminderlistapi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              //child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Container(
              child: Center(child: Text(" ")),
            );
          } else if (snapshot.hasData) {
            var appointmentsListModel =
            snapshot.data as ReminderListModel;

            return
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
                    Text(
                      "Reminder List",
                      style: TextStyle(
                          color: MyTheme.backgroundcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(width: 10),
                                            Text(snapshot.data!.data![index].date.toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(width: 10),
                                            Text(snapshot.data!.data![index].remark.toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                                            print(snapshot.data!.data![index].id.toString());
                                            print(snapshot.data!.data![index].date.toString());
                                            print(snapshot.data!.data![index].remark.toString());
                                            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");


                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditReminderScreen(meetingid:snapshot.data!.data![index].id.toString())));
                                            // Handle the "Edit Reminder" tap
                                          },
                                          child: Text("Edit Reminder"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16);
                      },
                      itemCount: snapshot.data!.data!.length,
                    ),
                  ],
                ),
              );

          } else {
            return Container(
              child: Center(child: Text("No data available")),
            );
          }
        },
      );
  }





  Future<ReminderListModel> reminderlistapi() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
    };
    var data = {
      'reminder_list': '1'
    };
    var dio = Dio();

    try {
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
        print(response.data);
        print("print response");

        // Check if the response is a string, then decode it to a Map
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        return ReminderListModel.fromJson(responseData);
      } else {
        print(response.statusMessage);
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to load data');
    }
  }
}
