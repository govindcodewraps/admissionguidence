import 'package:admissionguidence/Screens/stembuilder.dart';
import 'package:admissionguidence/my_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/AppointmentsList_Model.dart';
import '../models/Notification_Model.dart';
import '../models/Time_slot_model.dart';
import '../models/Todays_Appointment_model.dart';
import '../models/Upcoming_Appointment.dart';
import '../models/pastpast_appointment_model.dart';
import 'BookAppointmentScreen.dart';
import 'Home_Screen.dart';
import 'Notification_Screen.dart';
import 'RescheduleMeetingScreen.dart';
import 'RescheduleScreen.dart';

class Meeting_record_screen extends StatefulWidget {
  const Meeting_record_screen({Key? key}) : super(key: key);

  @override
  State<Meeting_record_screen> createState() => _Meeting_record_screenState();
}

class _Meeting_record_screenState extends State<Meeting_record_screen> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController dateInputController2 = TextEditingController();

  String Approved ="1";
  String Canceled ="2";
  String _nitificationcount="0";
  bool _isApproving = false;
  bool _isCanceling = false;

  var mettingiddelete;

  int buttonvalue = 0; // Set an initial value

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationCountApi();
    pastappointmentapi();
    todayappointmentlist();
    upcoming_appointment();
    time_slot();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    pastappointmentapi();
    todayappointmentlist();
    upcoming_appointment();
    //appointmentslistwidget();

    super.setState(fn);
  }
  //bool showMore = false;
  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child:

      Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                height: 120,
                color: MyTheme.backgroundcolor,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        InkWell(
                            onTap:(){
                              Navigator.pop(context, true);
                              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            },
                            child: Icon(Icons.arrow_back, color: Colors.white)),
                        SizedBox(width: 10),
                        Text(
                          "Meetings",
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),

                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingAppointments()));

                            },
                            child: Text("Book Appointment",style: TextStyle(color: Colors.white),)),
                        SizedBox(width: 10,),

                        // ElevatedButton(onPressed: (){
                        //
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => BookingAppointments()));
                        //
                        // }, child:Text("Book Appointment")),


                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Notification_Screen()));
                          },
                          child: Stack(
                            children: [
                              Icon(Icons.notifications,color: Colors.white,),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color:Colors.green,
                                    borderRadius: BorderRadius.circular(50), // Set a circular border radius
                                  ),
                                  child: Text(
                                    " ${_nitificationcount} ",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: 20,),

                    ToggleSwitch(
                      minWidth: 190.0,
                      cornerRadius: 20.0,
                      activeBgColors: [
                        [Colors.green[800]!],
                        [Colors.green[800]!]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: buttonvalue,
                      totalSwitches: 2,
                      labels: ['Today Meetings','Meetings Record'],
                      // labels: ['Meetings Record', 'Today Meetings'],
                      radiusStyle: true,
                      onToggle: (index) {
                        setState(() {
                          buttonvalue = index!;
                        });
                        print('switched to: $index');
                      },
                    ),

                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(

                  child: SingleChildScrollView(
                    child:
                    Column(children: [

                      SizedBox(height: 20,),


                      if (buttonvalue == 0)
                       // stembuilddd(),

                      todayappointmentlist(),




                      if (buttonvalue == 1)

                        Container(
                          padding: EdgeInsets.only(left: 0,right: 0),

                          child:  Column(
                            children: [


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text("From Date"),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.42,
                                        child: TextFormField(
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
                                            suffixIcon:
                                            Icon(Icons.calendar_month, color: Colors.black),
                                          ),
                                          controller: dateInputController,
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2050),
                                            );

                                            if (pickedDate != null) {
                                              setState(() {
                                                dateInputController.text =
                                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                              });

                                              if (dateInputController2.text.isNotEmpty) {
                                                // Call the future method when both dates are selected
                                                getAppointments(
                                                  dateInputController.text,
                                                  dateInputController2.text,
                                                ).then((appointments) {
                                                  if (appointments != null) {
                                                    // Do something with the fetched data
                                                    print(appointments);
                                                  }
                                                });
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text("To Date"),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.42,
                                        child: TextFormField(
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
                                            suffixIcon:
                                            Icon(Icons.calendar_month, color: Colors.black),
                                          ),
                                          controller: dateInputController2,
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2050),
                                            );

                                            if (pickedDate != null) {
                                              setState(() {
                                                dateInputController2.text =
                                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                              });

                                              if (dateInputController.text.isNotEmpty) {
                                                // Call the future method when both dates are selected
                                                getAppointments(
                                                  dateInputController.text,
                                                  dateInputController2.text,
                                                ).then((appointments) {
                                                  if (appointments != null) {
                                                    // Do something with the fetched data
                                                    print(appointments);
                                                  }
                                                });
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),


                              // ElevatedButton(onPressed: (){
                              //   pastappointmentapi();
                              //   todayappointmentlist();
                              //   upcoming_appointment();
                              //   // appointmentslistwidget();
                              //   time_slot();
                              //
                              //   print("Govindddddddd ");
                              //
                              // }, child: Text("Buttton")
                              //
                              // ),

                              // Use FutureBuilder to handle the async operation

                              SizedBox(height: 20,),

                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation: 2,
                                color: Colors.white,// Add elevation if you want a shadow effect
                                child: ExpansionTile(
                                  title: Text('Past Meetings'),
                                  children: <Widget>[
                                    ListTile(
                                      title: Column(
                                        children: [
                                          pastappointmentlist(),
                                          SizedBox(height: 20,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation: 2,
                                color: Colors.white,// Add elevation if you want a shadow effect
                                child: ExpansionTile(
                                  title: Text('Upcoming Meetings'),
                                  children: <Widget>[
                                    ListTile(
                                      title: Column(
                                        children: [
                                          upcomingappointmentlist(),
                                          SizedBox(height: 20,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              appointmentslist(),





                              SizedBox(height: 20,),


                            ],
                          ),
                        ),

                    ],),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mettingsrecoredwidget(){

    return

      Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  //Text("Date"),
                  TextFormField(

                    decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 3, color: Colors.greenAccent), //<-- SEE HERE
                      ),
                      // border: InputBorder.none,
                      //label: "DOB",
                      labelText: "Date",
                      hintText: 'Date',
                      suffixIcon: Icon(Icons.calendar_month,color: Colors.black,),

                    ),
                    //controller: dateInputController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050));

                      if (pickedDate != null) {
                        dateInputController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ],
              )
            ],
          )
        ],
      );
  }
  Widget todayappointmentlist() {
    return FutureBuilder(
      future: todayappointmentapi(),
      builder: (context, snapshot) {
        print("object");

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Container(
        //     child: Center(child: CircularProgressIndicator()),
        //   );
        // } else if (snapshot.hasError) {
        //   return Container(
        //     child: Center(child: Text("No more Meetings")),
        //   );
        // } else
          if (snapshot.hasData) {
            bool showMore = false;
          if (snapshot.data != null && snapshot.data!.data != null) {
            print(snapshot.data!.data!.length);
            print("object");

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
                          onTap: (){
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
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Date :"),
                                        SizedBox(width: 5,),
                                        Text(
                                          DateFormat('yyyy-MM-dd').format(
                                            snapshot.data!.data![index].appointmentDate!.toLocal(),
                                          ),
                                        ),
                                        SizedBox(width: 5,),

                                        Text(snapshot.data!.data![index]
                                            .appointmentTime.toString()),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        if(snapshot.data!.data![index].status == "0")
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                // Add your logic here
                                                print("Meeting ID: ${snapshot.data!.data![index].id.toString()}");
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Reschedule_Meeting_Screen(meetingid: snapshot.data!.data![index].id.toString(),date: snapshot.data!.data![index].appointmentDate.toString(),appointmenttime: snapshot.data!.data![index].appointmentTime.toString())));
                                              },
                                              child: Icon(Icons.calendar_month_outlined),
                                            ),
                                            SizedBox(width: 10,),
                                            InkWell(
                                              onTap: () {
                                                _updateBookingStatus(
                                                  snapshot.data!.data![index].id.toString(),
                                                  Approved,
                                                );
                                              },
                                              child: Icon(Icons.done),
                                            ),
                                            SizedBox(width: 10,),
                                            InkWell(
                                              onTap: () {

                                                mettingiddelete = snapshot.data!.data![index].id.toString();
                                                showDeleteConfirmationDialogtoday(context);


                                                // _updateBookingStatus(
                                                //   snapshot.data!.data![index].id.toString(),
                                                //   Canceled,
                                                // );
                                              },
                                              child: Icon(Icons.cancel_outlined),
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
                                // Row(
                                //   children: [
                                //     Text("Date :"),
                                //     SizedBox(width: 10,),
                                //     Text(
                                //       DateFormat('yyyy-MM-dd').format(
                                //         snapshot.data!.data![index].appointmentDate!.toLocal(),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Row(
                                  children: [
                                    Text("Name :"),
                                    Text(snapshot.data!.data![index].name.toString()),
                                    SizedBox(width: 10,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Contact:"),
                                    SizedBox(width: 2,),
                                    Text(snapshot.data!.data![index].email.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Remark :"),
                                    SizedBox(width: 10,),
                                    Flexible(
                                      child: Text(
                                        snapshot.data!.data![index].remark != null && snapshot.data!.data![index].remark!.isNotEmpty
                                            ? snapshot.data!.data![index].remark!
                                            : 'No Remark',


                                        //  "AAAAAAAAAAAAAAAAAAAA  BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB  CCCCCCCCCCCCCCCCCCCCCCCCC DDDDDDDDDDD",
                                        maxLines: !showMore ? null : 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showMore = !showMore;
                                        });
                                      },
                                      child:   Icon(
                                        !showMore ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                                        color: MyTheme.backgroundcolor,
                                      ),

                                    ),
                                  ],
                                ),


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
  Widget pastappointmentlist() {
    bool showMore = false;
    return FutureBuilder(
      future: pastappointmentapi(),

      builder: (context, snapshot) {
        print("object");

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Container(
        //     child: Center(child: CircularProgressIndicator()),
        //   );
        // } else if (snapshot.hasError) {
        //   return Container(
        //     child: Center(child: Text("No more Meetings")),
        //   );
        // } else
        if (snapshot.hasData) {
          bool showMore = false;
          if (snapshot.data != null && snapshot.data!.data != null) {
            print(snapshot.data!.data!.length);
            print("object");

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
                          onTap: (){
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
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Date :"),
                                          SizedBox(width: 5,),
                                          Text(
                                            DateFormat('yyyy-MM-dd').format(
                                              snapshot.data!.data![index].appointmentDate!.toLocal(),
                                            ),
                                          ),
                                          SizedBox(width: 5,),

                                          Text(snapshot.data!.data![index]
                                              .appointmentTime.toString()),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          if(snapshot.data!.data![index].status == "0")
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // Add your logic here
                                                    print("Meeting ID: ${snapshot.data!.data![index].id.toString()}");
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Reschedule_Meeting_Screen(meetingid: snapshot.data!.data![index].id.toString(),date: snapshot.data!.data![index].appointmentDate.toString(),appointmenttime: snapshot.data!.data![index].appointmentTime.toString())));
                                                  },
                                                  child: Icon(Icons.calendar_month_outlined),
                                                ),
                                                SizedBox(width: 10,),
                                                InkWell(
                                                  onTap: () {
                                                    _updateBookingStatus(
                                                      snapshot.data!.data![index].id.toString(),
                                                      Approved,
                                                    );
                                                  },
                                                  child: Icon(Icons.done),
                                                ),
                                                SizedBox(width: 10,),
                                                InkWell(
                                                  onTap: () {

                                                    mettingiddelete = snapshot.data!.data![index].id.toString();
                                                    showDeleteConfirmationDialogtoday(context);


                                                    // _updateBookingStatus(
                                                    //   snapshot.data!.data![index].id.toString(),
                                                    //   Canceled,
                                                    // );
                                                  },
                                                  child: Icon(Icons.cancel_outlined),
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
                                  // Row(
                                  //   children: [
                                  //     Text("Date :"),
                                  //     SizedBox(width: 10,),
                                  //     Text(
                                  //       DateFormat('yyyy-MM-dd').format(
                                  //         snapshot.data!.data![index].appointmentDate!.toLocal(),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      Text("Name :"),
                                      Text(snapshot.data!.data![index].name.toString()),
                                      SizedBox(width: 10,),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Contact:"),
                                      SizedBox(width: 2,),
                                      Text(snapshot.data!.data![index].email.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Remark :"),
                                      SizedBox(width: 10,),
                                      Flexible(
                                        child: Text(
                                          snapshot.data!.data![index].remark != null && snapshot.data!.data![index].remark!.isNotEmpty
                                              ? snapshot.data!.data![index].remark!
                                              : 'No Remark',


                                          //  "AAAAAAAAAAAAAAAAAAAA  BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB  CCCCCCCCCCCCCCCCCCCCCCCCC DDDDDDDDDDD",
                                          maxLines: !showMore ? null : 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showMore = !showMore;
                                          });
                                        },
                                        child:   Icon(
                                          !showMore ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                                          color: MyTheme.backgroundcolor,
                                        ),

                                      ),
                                    ],
                                  ),


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


      // builder: (context, snapshot) {
      //   print("object");
      //
      //   // if (snapshot.connectionState == ConnectionState.waiting) {
      //   //   return Container(
      //   //     child: Center(child: CircularProgressIndicator()),
      //   //   );
      //   // } else
      //     if (snapshot.hasError) {
      //     return Container(
      //       child: Center(child: Text("No more Meetings")),
      //     );
      //   } else
      //     if (snapshot.hasData) {
      //     if (snapshot.data != null && snapshot.data!.data != null) {
      //       print(snapshot.data!.data!.length);
      //       print("object");
      //
      //       return Container(
      //        // padding: EdgeInsets.only(left: 9, right: 9),
      //         child: Column(
      //           children: [
      //             ListView.separated(
      //               shrinkWrap: true,
      //               physics: const NeverScrollableScrollPhysics(),
      //               itemBuilder: (context, int index) {
      //                 return Container(
      //                   decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.circular(12.0),
      //                     boxShadow: [
      //                       BoxShadow(
      //                         color: Colors.black.withOpacity(0.2),
      //                         spreadRadius: 2,
      //                         blurRadius: 4,
      //                         offset: Offset(0, 3),
      //                       ),
      //                     ],
      //                   ),
      //                   child: Container(
      //                     padding: EdgeInsets.all(8.0),
      //                     child: Column(
      //                       children: [
      //                         Row(
      //                           mainAxisAlignment:
      //                           MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Row(
      //                               children: [
      //                                 Text("Date:"),
      //                                 SizedBox(width: 5,),
      //                                 Text(snapshot.data!.data![index]
      //                                     .appointmentDate
      //                                     .toString()),
      //                                 SizedBox(width: 5,),
      //                                 Text(snapshot.data!.data![index]
      //                                     .appointmentTime
      //                                     .toString()),
      //                               ],
      //                             ),
      //                             Row(
      //                               children: [
      //                                 Icon(Icons.done),
      //                               ],
      //                             ),
      //                           ],
      //                         ),
      //                         // Row(
      //                         //   children: [
      //                         //     Text("Date :"),
      //                         //     SizedBox(width: 10,),
      //                         //     Text(snapshot.data!.data![index]
      //                         //         .appointmentDate
      //                         //         .toString()),
      //                         //   ],
      //                         // ),
      //                         Row(
      //                           children: [
      //                             Text("Name :"),
      //                             Text(snapshot.data!.data![index].name.toString()),
      //                             SizedBox(width: 10,),
      //                           ],
      //                         ),
      //                         Row(
      //                           children: [
      //                             Text("Contact:"),
      //                             SizedBox(width: 2,),
      //                             Text(snapshot.data!.data![index].email.toString()),
      //                           ],
      //                         ),
      //                         Row(
      //                           children: [
      //                             Text("Remark :"),
      //                             SizedBox(width: 10,),
      //                             Flexible(
      //                               child: Text(
      //                                 snapshot.data!.data![index].remark != null && snapshot.data!.data![index].remark!.isNotEmpty
      //                                     ? snapshot.data!.data![index].remark!
      //                                     : 'No Remark',
      //
      //
      //                                 //  "AAAAAAAAAAAAAAAAAAAA  BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB  CCCCCCCCCCCCCCCCCCCCCCCCC DDDDDDDDDDD",
      //                                 maxLines: !showMore ? null : 4,
      //                                 overflow: TextOverflow.ellipsis,
      //                               ),
      //                             ),
      //                             SizedBox(height: 8),
      //                             GestureDetector(
      //                               onTap: () {
      //                                 setState(() {
      //                                   showMore = !showMore;
      //                                 });
      //                               },
      //                               child:   Icon(
      //                                 !showMore ? Icons.arrow_drop_down : Icons.arrow_drop_up,
      //                                 color: MyTheme.backgroundcolor,
      //                               ),
      //
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               },
      //               separatorBuilder: (context, index) {
      //                 return SizedBox(height: 16);
      //               },
      //               itemCount: snapshot.data!.data!.length,
      //             ),
      //           ],
      //         ),
      //       );
      //     } else {
      //       return Container(
      //         child: Center(child: Text("No data available")),
      //       );
      //     }
      //   } else {
      //     return Container(
      //       child: Center(child: CircularProgressIndicator()),
      //     );
      //   }
      // },
    );
  }

  Widget upcomingappointmentlist() {
    bool showMore = false;
    return FutureBuilder(

      future: upcoming_appointment(),
      builder: (context, snapshot) {
        print("object");

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Container(
        //     child: Center(child: CircularProgressIndicator()),
        //   );
        // } else if (snapshot.hasError) {
        //   return Container(
        //     child: Center(child: Text("No more Meetings")),
        //   );
        // } else

          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data!.data != null) {
            print(snapshot.data!.data!.length);
            print("object");

            return Container(
              //color: Colors.red,
              //padding: EdgeInsets.only(left: 16, right: 16),
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
                          padding: EdgeInsets.all(6.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Date:"),
                                      SizedBox(width: 5,),
                                      Text(
                                        DateFormat('yyyy-MM-dd').format(
                                          snapshot.data!.data![index].appointmentDate!.toLocal(),
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(snapshot.data!.data![index]
                                          .appointmentTime
                                          .toString()),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      if(snapshot.data!.data![index].status == "0")
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                // Add your logic here
                                                print("Meeting ID upcoming : ${snapshot.data!.data![index].id.toString()}");
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Reschedule_Meeting_Screen(meetingid: snapshot.data!.data![index].id.toString(),date: snapshot.data!.data![index].appointmentDate.toString(),appointmenttime: snapshot.data!.data![index].appointmentTime.toString())));

                                              },
                                              child: Icon(Icons.calendar_month_outlined),
                                            ),
                                            SizedBox(width: 10,),
                                            InkWell(
                                              onTap: () {
                                                _updateBookingStatus(
                                                  snapshot.data!.data![index].id.toString(),
                                                  Approved,
                                                );
                                              },
                                              child: Icon(Icons.done),
                                            ),
                                            SizedBox(width: 10,),
                                            InkWell(
                                              onTap: () {
                                                // _updateBookingStatus(
                                                //   snapshot.data!.data![index].id.toString(),
                                                //   Canceled,
                                                // );

                                               mettingiddelete = snapshot.data!.data![index].id.toString();
                                                showDeleteConfirmationDialog(context);
                                              },
                                              child: Icon(Icons.cancel_outlined),
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
                              // Row(
                              //   children: [
                              //     Text("Date :"),
                              //     SizedBox(width: 10,),
                              //     Text(
                              //       DateFormat('yyyy-MM-dd').format(
                              //         snapshot.data!.data![index].appointmentDate!.toLocal(),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Row(
                                children: [
                                  Text("Name :"),
                                  Text(snapshot.data!.data![index].name.toString().split('.').last),
                                  SizedBox(width: 10,),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Contact:"),
                                  SizedBox(width: 2,),
                                  Text(snapshot.data!.data![index].email.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Remark :"),
                                  SizedBox(width: 10,),
                                  Flexible(
                                    child: Text(
                                      snapshot.data!.data![index].remark != null && snapshot.data!.data![index].remark!.isNotEmpty
                                          ? snapshot.data!.data![index].remark!
                                          : 'No Remark',


                                    //  "AAAAAAAAAAAAAAAAAAAA  BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB  CCCCCCCCCCCCCCCCCCCCCCCCC DDDDDDDDDDD",
                                      maxLines: !showMore ? null : 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showMore = !showMore;
                                      });
                                    },
                                    child:   Icon(
                                      !showMore ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                                      color: MyTheme.backgroundcolor,
                                    ),

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
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  void showDeleteConfirmationDialogfilterd(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure want to delete?"),
          // content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel",style: TextStyle(color: Colors.grey),),
            ),
            TextButton(
              onPressed: () async {
                bookin_status(
                    mettingiddelete,
                    Canceled);

                // _updateBookingStatus(
                //   mettingiddelete,
                //   Canceled,
                // );
                Fluttertoast.showToast(
                    msg: "Meeting Canceled",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.of(context).pop();
              },
              child:
              //Image.asset('assets/logoutbutton.jpg'),
              Text("Delete",style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure want to delete?"),
          // content: Text("Are you sure you want to logout?"),
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
                // var reminderid=snapshot.data!.data![index].id.toString();
                // print("delete reminder id  ${deletereminderid}");
                //
                // deletreminderapi(deletereminderid.toString());


                _updateBookingStatus(
                  mettingiddelete,
                  Canceled,
                );
                Navigator.of(context).pop();
              },
              child:
              //Image.asset('assets/logoutbutton.jpg'),
              Text("Delete",style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }
  void showDeleteConfirmationDialogtoday(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure want to delete?"),
          // content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel",style: TextStyle(color: Colors.grey),),
            ),
            TextButton(
              onPressed: () async {



                _updateBookingStatus(
                  mettingiddelete,
                  Canceled,
                );
                Navigator.of(context).pop();
              },
              child:
              //Image.asset('assets/logoutbutton.jpg'),
              Text("Delete",style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
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
        'https://admissionguidanceindia.com/appdata/webservice.php',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        // print(json.encode(response.data));
        // print(response.data);
        // print("print response");

        // Check if the response is a string, then decode it to a Map
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        print("print upcomming  response ${responseData}");

        return UpcommingAppointmentModel.fromJson(responseData);
      } else {
        print(response.statusMessage);
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error.toString());
      throw Exception('Server Down ');
    }
  }


  Future<AppointmentsListModel?> getAppointments(String startDate, String endDate) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
    };
    var data = {
      'appointment': '1',
      'startDate': startDate,
      'endDate': endDate,
    };
    var dio = Dio();

    try {
      var response = await dio.post(
        'https://admissionguidanceindia.com/appdata/webservice.php',
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;
       print("Fillterd list ${responseData}");
        var appointmentsListModel =
        AppointmentsListModel.fromJson(responseData);

        if (appointmentsListModel.data != null) {
          return appointmentsListModel;
        } else {
          print('Received response with null data.');
          return null;
        }
      } else {
        print('Received response with status code: ${response.statusCode}');
        print(response.statusMessage);
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error during API call: $error');
      throw Exception('Error fetching appointments');
    }
  }
  Widget appointmentslist() {

    return
      FutureBuilder(

        future: getAppointments(
          dateInputController.text,
          dateInputController2.text,
        ),
        builder: (context, snapshot) {
          bool showMore = false;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          } else
            if (snapshot.hasError) {
            return Container(
              child: Center(child: Text("No Meeting ")),
            );
          } else if (snapshot.hasData) {
            var appointmentsListModel =
            snapshot.data as AppointmentsListModel;

            return Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Filterd Meeting List",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
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
                                  Row(
                                    children: [
                                      Text("Name:"),
                                      SizedBox(width: 5,),
                                      Text(snapshot.data!.data![index]
                                          .name
                                          .toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      if(snapshot.data!.data![index].status == "0")
                                        Row(
                                          children: [
                                            InkWell(onTap: () {
                                              // Add your logic here
                                              print("Filterd Meeting ID upcoming : ${snapshot.data!.data![index].id.toString()}");
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Reschedule_Meeting_Screen(meetingid: snapshot.data!.data![index].id.toString(),date: snapshot.data!.data![index].appointmentDate.toString(),appointmenttime: snapshot.data!.data![index].appointmentTime.toString())));

                                            },
                                                child: Icon(Icons.calendar_month_outlined)),
                                            SizedBox(width: 10,),
                                            InkWell(
                                                onTap:(){
                                                  bookin_status(snapshot.data!.data![index].id.toString(),Approved);
                                                  Fluttertoast.showToast(
                                                      msg: "Meeting Approved",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.green,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0
                                                  );
                                                },
                                                child: Icon(Icons.done)),
                                            SizedBox(width: 10,),
                                            InkWell(
                                                onTap: (){
                                                  // bookin_status(
                                                  //     snapshot.data!.data![index].id.toString(),
                                                  //     Canceled);

                                                  mettingiddelete = snapshot.data!.data![index].id.toString();
                                                  showDeleteConfirmationDialogfilterd(context);




                                                },
                                                child: Icon(Icons.cancel_outlined)),
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
                                  Text("Contact:"),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(appointmentsListModel
                                      .data![index].email
                                      .toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Appointment Date:"),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text( DateFormat('yyyy-MM-dd').format(
                                    appointmentsListModel
                                        .data![index].appointmentDate!.toLocal(),
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Appointment Time:"),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(appointmentsListModel
                                      .data![index].appointmentTime
                                      .toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Remark :"),
                                  SizedBox(width: 10,),
                                  Flexible(
                                    child: Text(
                                      snapshot.data!.data![index].remark != null && snapshot.data!.data![index].remark!.isNotEmpty
                                          ? snapshot.data!.data![index].remark!
                                          : 'No Remark',


                                      //  "AAAAAAAAAAAAAAAAAAAA  BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB  CCCCCCCCCCCCCCCCCCCCCCCCC DDDDDDDDDDD",
                                      maxLines: !showMore ? null : 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showMore = !showMore;
                                      });
                                    },
                                    child:   Icon(
                                      !showMore ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                                      color: MyTheme.backgroundcolor,
                                    ),

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
                    itemCount: appointmentsListModel.data!.length,
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

  Future<TodaysAppointmentModel> todayappointmentapi() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
    };
    var data = {
      'today_appointment': '1'
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
       // setState(() {});
        // Check if the response is a string, then decode it to a Map
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        return TodaysAppointmentModel.fromJson(responseData);
      } else {
        print(response.statusMessage);
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to load data');
    }
  }

  Future<PastAppointmentModel> pastappointmentapi() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
    };
    var data = {
      'past_appointment': '1'
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
        setState(() {});
        // Check if the response is a string, then decode it to a Map
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        print("past meeting record ${responseData}");
        return PastAppointmentModel.fromJson(responseData);
      } else {
        print(response.statusMessage);
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to load data');
    }
  }

  Future<TimeslotModel> time_slot() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
    };
    var data = {
      'time_slot': '1'
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
        print("print time slot response");
        setState(() {});
        // Check if the response is a string, then decode it to a Map
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        return TimeslotModel.fromJson(responseData);
      } else {
        print(response.statusMessage);
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to load data');
    }
  }

  Future<void> bookin_status(bookingid,statusid) async {
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
      'https://admissionguidanceindia.com/appdata/webservice.php',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {

      print("successfuly hit booking status");
      print(json.encode(response.data));

      setState(() {});
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Meeting_record_screen()));

    }
    else {
      print(response.statusMessage);
    }
  }

  Future<void> _updateBookingStatus(String bookingId, String statusId) async {
    await bookin_status(bookingId, statusId);

    Fluttertoast.showToast(
      msg: statusId == Approved ? "Meeting Approved" : "Meeting Canceled",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      //timeInSecForIosWeb: 1,
      backgroundColor: statusId == Approved ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    setState(() {});
  }

  Future<int?> notificationCountApi() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e9fa73e42b049d31d22a09758fdccf0'
    };
    var data = {
      'getnotificationCount': '1'
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
      print("Notification count response: ${response.data}");
      setState(() {});
      // Decode the JSON string to a Map
      Map<String, dynamic> responseData = json.decode(response.data);

      // Check if 'data' field is present in the response
      if (responseData.containsKey('data')) {
        var dataValue = responseData['data'];

        print("Data value: $dataValue");
        _nitificationcount=dataValue.toString();
        print("_nitificationcount: $_nitificationcount");
        return dataValue;
      } else {
        print("Error: 'data' field not found in the response");
        return null; // or throw an exception
      }
    } else {
      print("Error: ${response.statusMessage}");
      return null; // or throw an exception
    }
  }
}
