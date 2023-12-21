import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../baseurl.dart';
import '../models/AppointmentsList_Model.dart';
import '../models/Upcoming_Appointment.dart';

class stembuilddd extends StatefulWidget {
  const stembuilddd({Key? key}) : super(key: key);

  @override
  _stembuildddState createState() => _stembuildddState();
}

class _stembuildddState extends State<stembuilddd> {
  String Approved = "1";
  String Canceled = "2";

  bool _isApproving = false;
  bool _isCanceling = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshData(),
                child: upcomingappointmentlist(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    // You can add any logic you need to refresh the data here
    setState(() {});
  }

  Widget upcomingappointmentlist() {
    return FutureBuilder(
      future: upcoming_appointment(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(child: Text("No more Meetings")),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data != null && snapshot.data!.data != null) {
            return _buildAppointmentList(snapshot);
          } else {
            return Container(
              child: Center(child: Text("No data available")),
            );
          }
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildAppointmentList(AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Time slot:"),
                              SizedBox(width: 5,),
                              Text(snapshot.data!.data![index]
                                  .appointmentTime
                                  .toString()),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Add your logic here
                                    },
                                    child: Icon(Icons.calendar_month_outlined),
                                  ),
                                  SizedBox(width: 10,),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _isApproving = true;
                                      });

                                      await _updateBookingStatus(
                                        snapshot.data!.data![index].id.toString(),
                                        Approved,
                                      );

                                      Fluttertoast.showToast(
                                        msg: "Meeting Approved",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );

                                      setState(() {
                                        _isApproving = false;
                                      });
                                    },
                                    child: _isApproving
                                        ? CircularProgressIndicator()
                                        : Icon(Icons.done),
                                  ),
                                  SizedBox(width: 10,),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _isCanceling = true;
                                      });

                                      await _updateBookingStatus(
                                        snapshot.data!.data![index].id.toString(),
                                        Canceled,
                                      );

                                      Fluttertoast.showToast(
                                        msg: "Meeting Canceled",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );

                                      setState(() {
                                        _isCanceling = false;
                                      });
                                    },
                                    child: _isCanceling
                                        ? CircularProgressIndicator()
                                        : Icon(Icons.cancel_outlined),
                                  ),
                                ],
                              ),
                              if(snapshot.data!.data![index].status == "1")
                                Icon(Icons.done,color: Colors.green,),
                              if(snapshot.data!.data![index].status == "2")
                                Icon(Icons.cancel_outlined,color: Colors.red,),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Date :"),
                          SizedBox(width: 10,),


                          // Text(snapshot.data!.data![index]
                          //     .appointmentDate
                          //     .toString()),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Name :"),
                          Text(snapshot.data!.data![index].name.toString()),
                          SizedBox(width: 10,),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Email:"),
                          SizedBox(width: 2,),
                          Text(snapshot.data!.data![index].email.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Contact :"),
                          SizedBox(width: 10,),
                          Text("+91 98765432121"),
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
  }

  Future<UpcommingAppointmentModel> upcoming_appointment() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
    };
    var data = {
      'upcoming_appointment': '1'
    };
    var dio = Dio();

    try {
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
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        return UpcommingAppointmentModel.fromJson(responseData);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data');
    }
  }

  Future<void> bookin_status(bookingid, statusid) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=5827392eb2f001817976c6a08e1f94c9'
    };
    var data = {
      'booking_status': '1',
      'booking_id': bookingid,
      'status': statusid
    };
    var dio = Dio();
    var response = await dio.request(
     // 'https://admissionguidanceindia.com/appdata/webservice.php',
      BASEURL.DOMAIN_PATH,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print("successfully hit booking status");
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> _updateBookingStatus(String bookingId, String statusId) async {
    await bookin_status(bookingId, statusId);

    Fluttertoast.showToast(
      msg: statusId == Approved ? "Meeting Approved" : "Meeting Canceled",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: statusId == Approved ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    setState(() {});
  }
}
