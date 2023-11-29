import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/ReminderTypeModel.dart';
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

  var Remindertypevalue;
  var ReminderListvalue;
  int selectedIdx = -1;

  TextEditingController dateInputController = TextEditingController();

  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    reminderlistapi();
    ReminderTypeApi();

    super.initState();
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
                                          child: Icon(Icons.edit),

                                          //Text("Edit Reminder"),
                                        ),
                                        SizedBox(width: 10,),

                                        InkWell(

                                            onTap: (){
                                              setState(() {
                                                Remindertypevalue = ''; // You can assign any default or empty value
                                              });
                                              Remindertypevalue == null ? Remindertypevalue.clear:"";
                                              ReminderListvalue=snapshot.data!.data![index].id.toString();
                                              _showCustomDialog(context);
                                              print("print reminder list id:: ${snapshot.data!.data![index].id.toString()}");
                                            },
                                            child: Icon(Icons.autorenew_rounded)),

                                        SizedBox(width: 10,),

                                        InkWell(
                                            onTap: (){
                                              var reminderid=snapshot.data!.data![index].id.toString();
                                              print("delet id ${reminderid}");

                                              deletreminderapi(reminderid.toString());
                                            },
                                            child: Icon(Icons.delete)),

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


  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog(context); // Call your alertDialog function here
      },
    );
  }

  Widget alertDialog(BuildContext context) {

    return  FutureBuilder(
      future: ReminderTypeApi(),
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
          snapshot.data as ReminderTypeModel;

          return
            AlertDialog(

              title: Text('Select Reminder Type'),
              content: Container(
                height: 600,
                width: double.maxFinite,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount:snapshot.data!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GridTile(
                      child:

                      InkWell(
                        onTap: (){
                          Remindertypevalue=snapshot.data!.data![index].id.toString();
                          //print(snapshot.data!.data![index].id.toString());
                          print("Reminder type value:: ${Remindertypevalue}");
                          Fluttertoast.showToast(
                            msg: "Selected : ${snapshot.data!.data![index].type.toString()}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                            BoxShadow(
                            color: Colors.grey, // Choose your shadow color
                            blurRadius: 5.0,   // Adjust the blur radius
                            offset: Offset(0, 2), // Adjust the offset
                          ),
                          ],                          ),
                          child: Center(
                            child: Text(
                              //'Reminder Type',
                              snapshot.data!.data![index].type.toString(),
                              style: TextStyle(color: Colors.black,fontWeight:FontWeight.w500,fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      Remindertypevalue = ''; // You can assign any default or empty value
                    });
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                   // Navigator.of(context).pop();
                    // Remindertypevalue == null;
                    // Fluttertoast.showToast(
                    //   msg: "Select Reminder Type",
                    //   toastLength: Toast.LENGTH_LONG,
                    //   gravity: ToastGravity.CENTER,
                    //   timeInSecForIosWeb: 1,
                    //   backgroundColor: Colors.grey,
                    //   textColor: Colors.white,
                    //   fontSize: 16.0,
                    // );
                   // print("Select id ");

                    setreminderapi(ReminderListvalue,Remindertypevalue);
                  },
                  child: Text('Save'),
                ),
              ],
            );

        } else {
          return Container(
            child: Center(child: Text("No data available")),
          );
        }
      },
    );
  }


Future setreminderapi(reminderid,typeid) async{
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': 'PHPSESSID=30ead7cbd26e9fcee6465b06417e7aba'
  };
  var data = {
    'set_reminder': '1',
    'reminder_id':reminderid,
    'type_id': typeid
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
    print("successfully set remionder");
    print(json.encode(response.data));
    Fluttertoast.showToast(
      msg: "successfully set remionder",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.pop(context);
  }

  else if (response.statusCode == 401) {

    Fluttertoast.showToast(
      msg: "Please enter all required fields",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

  }

  else {
    print(response.statusMessage);
  }
}

Future deletreminderapi(reminderid,) async{
  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': 'PHPSESSID=30ead7cbd26e9fcee6465b06417e7aba'
  };
  var data = {
    'reminder_delete': '1',
    'id': reminderid
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
      msg: "Deleted successfully",
      toastLength: Toast.LENGTH_LONG,
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
        print("reminder_list response print ");

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


  Future<ReminderTypeModel?> ReminderTypeApi() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=30ead7cbd26e9fcee6465b06417e7aba'
    };
    var data = {
      'reminder_type': '1'
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
      //print(json.encode(response.data));

      var responseData = response.data is String
          ? json.decode(response.data)
          : response.data;

      print("Reminder type print ${responseData}");

      return ReminderTypeModel.fromJson(responseData);
    }

    else {
      print(response.statusMessage);
    }
  }





}
