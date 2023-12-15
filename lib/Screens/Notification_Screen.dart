
import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/NotificationListModel.dart';
import '../my_theme.dart';
import 'Meeting_record_Screen.dart';

class Notification_Screen extends StatefulWidget {
  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {
  Map responseData = {};

  @override
  void initState() {
    notification_list();
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
          "Notification",
          style: TextStyle(
            color: Colors.white, // Change the text color here
          ),
        ),
      ),
      body: SafeArea(
        child: Container(

          decoration: BoxDecoration(
            //color: Colors.yellow,

            image: DecorationImage(

              image: AssetImage('assets/background.jpg'), // Replace with your image asset path
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY:4),
            child: Column(
              children: [
                SizedBox(height: 20,),
                listview(),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listview() {
    return FutureBuilder(
      future: notification_list(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text('Error: Internal error'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
          return Container(
            child: Center(
              child: Text('No data available.'),
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, int index) {
                    return

                      InkWell(
                        onTap: () {
                          print("govind kkk");
                        },
                        child: Container(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Text("Order # ${snapshot.data!.data![index].id.toString()}"),
                                //SizedBox(height: 7,),
                                Text("Remark : ${snapshot.data!.data![index].reminder.toString()}"),
                                SizedBox(height: 7,),
                                Text("Date : ${DateFormat('MMMM d y').format(snapshot.data!.data![index].reminderCreateDate!.toLocal(),)}"),

                              ],
                            ),
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
        }
      },
    );
  }

  Future<NotificationListModel?> notification_list() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e9fa73e42b049d31d22a09758fdccf0'
    };

    var dio = Dio();

    var data = {
      'notifications_list': '1',
    };

    try {
      var response = await dio.post(
        'https://admissionguidanceindia.com/appdata/webservice.php',
        options: Options(
          headers: headers,
        ),
        data: FormData.fromMap(data),
      );

      if (response.statusCode == 200) {
        print("Notification list ${response.data}");
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        //return PastAppointmentModel.fromJson(responseData);
        print("Notification listresponse ${responseData}");
        return NotificationListModel.fromJson(responseData);
      } else {
        print(response.statusMessage);
      }
    } catch (error) {
      print("Error: $error");
      return null;
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Colors.black,),
      ),
      title: Text("Notifications"),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
