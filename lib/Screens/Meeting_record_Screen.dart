import 'package:admissionguidence/my_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/Time_slot_model.dart';
import '../models/Todays_Appointment_model.dart';
import '../models/Upcoming_Appointment.dart';
import '../models/pastpast_appointment_model.dart';
import 'RescheduleScreen.dart';

class Meeting_record_screen extends StatefulWidget {
  const Meeting_record_screen({Key? key}) : super(key: key);

  @override
  State<Meeting_record_screen> createState() => _Meeting_record_screenState();
}

class _Meeting_record_screenState extends State<Meeting_record_screen> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController dateInputController2 = TextEditingController();


  int buttonvalue = 0; // Set an initial value

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pastappointmentapi();
    todayappointmentlist();
    upcoming_appointment();
    time_slot();

    print("sidhu ");
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              color: MyTheme.backgroundcolor,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      InkWell(
                          onTap:(){
                            Navigator.pop(context);
                             },
                          child: Icon(Icons.arrow_back, color: Colors.white)),
                      SizedBox(width: 10),
                      Text(
                        "Meetings",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),

                  ToggleSwitch(
                    minWidth: 190.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.red[800]!]
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
              child: SingleChildScrollView(
                child:
                Column(children: [

                  SizedBox(height: 20,),


                  if (buttonvalue == 0)

                    todayappointmentlist(),


                   /* Container(
                      padding: EdgeInsets.only(left: 0,right: 0),

                      child:   Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text("From Date"),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.42,
                                    child: TextFormField(

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
                                      controller: dateInputController,
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
                                  ),
                                ],
                              ),

                              SizedBox(width: 10,),

                              Column(
                                children: [
                                  Text("To Date"),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.42,
                                    child: TextFormField(

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
                                      controller: dateInputController2,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2050));

                                        if (pickedDate != null) {
                                          dateInputController2.text =
                                              DateFormat('yyyy-MM-dd').format(pickedDate);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),

                            ],),
                          SizedBox(height: 20,),

                          Padding(
                            padding: const EdgeInsets.only(left: 16,right: 16),
                            child: ListView.separated(
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
                                                Text("Date slot :"),
                                                SizedBox(width: 10,),
                                                Text("10:00 Am-11:00 AM"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                    onTap:(){
                                                 Navigator.push(context,MaterialPageRoute(builder: (context)=>Reschedule_Screen()));
                                  },
                                                    child: Icon(Icons.calendar_month_outlined)),
                                                Icon(Icons.done),
                                                Icon(Icons.cancel_outlined),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Date :"),
                                            SizedBox(width: 10,),
                                            Text("03/11/2023"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Name :"),
                                            SizedBox(width: 10,),
                                            Text("Govind"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Email : :"),
                                            SizedBox(width: 10,),
                                            Text("govind@gmail.com"),
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
                                // This widget will be used as a separator between items
                                return SizedBox(height: 16); // Adjust the height as needed
                              },
                              itemCount: 15,
                            ),
                          ),
                          SizedBox(height: 20,),




                        ],
                      ),
                    ),*/

                  if (buttonvalue == 1)

                    Container(
                      padding: EdgeInsets.only(left: 0,right: 0),

                      child:   Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text("From Date"),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.42,
                                    child: TextFormField(

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
                                      controller: dateInputController,
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
                                  ),
                                ],
                              ),

                              SizedBox(width: 10,),

                              Column(
                                children: [
                                  Text("To Date"),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.42,
                                    child: TextFormField(

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
                                      controller: dateInputController2,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2050));

                                        if (pickedDate != null) {
                                          dateInputController2.text =
                                              DateFormat('yyyy-MM-dd').format(pickedDate);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),

                            ],),
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



                          SizedBox(height: 20,),


                        ],
                      ),
                    ),

                ],),
              ),
            )



          ],
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

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(child: Text("Error: ${snapshot.error}")),
          );
        } else if (snapshot.hasData) {
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
                                      Text("Time slot:"),
                                      SizedBox(width: 5,),
                                      Text(snapshot.data!.data![index]
                                          .appointmentTime.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            // Add your logic here
                                          },
                                          child: Icon(Icons.calendar_month_outlined)),
                                      Icon(Icons.done),
                                      Icon(Icons.cancel_outlined),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Date :"),
                                  SizedBox(width: 10,),
                                  Text(snapshot.data!.data![index]
                                      .appointmentDate.toString()),
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
    return FutureBuilder(
      future: pastappointmentapi(),
      builder: (context, snapshot) {
        print("object");

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(child: Text("Error: ${snapshot.error}")),
          );
        } else if (snapshot.hasData) {
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
                                      Text("Time slot:"),
                                      SizedBox(width: 5,),
                                      Text(snapshot.data!.data![index]
                                          .appointmentTime
                                          .toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.done),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Date :"),
                                  SizedBox(width: 10,),
                                  Text(snapshot.data!.data![index]
                                      .appointmentDate
                                      .toString()),
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


  Widget upcomingappointmentlisrt(){
    return

      FutureBuilder(
        future: upcoming_appointment(),
        builder: (context, snapshot) {
          print("object");
          print(snapshot.data!.data!.length);
          print("object");
          if (snapshot.hasData) {
            return


              Container(
              padding: EdgeInsets.only(left: 16,right: 16),
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
                                      //Text("10:00Am-11:00AM"),
                                      Text(snapshot.data!.data![index].appointmentTime.toString()),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      //InkWell(
                                          // onTap:(){
                                          //   Navigator.push(context,MaterialPageRoute(builder: (context)=>Reschedule_Screen()));
                                          // },
                                          // child: Icon(Icons.calendar_month_outlined)),
                                      Icon(Icons.done),
                                      //Icon(Icons.cancel_outlined),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Date :"),
                                  SizedBox(width: 10,),
                                  //Text("03/11/2023"),
                                  Text(snapshot.data!.data![index].appointmentDate.toString()),

                                ],
                              ),
                              Row(
                                children: [
                                  Text("Name :"),
                                  Text(snapshot.data!.data![index].name.toString()),
                                  SizedBox(width: 10,),
                                 // Text("Govind"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Email:"),
                                  SizedBox(width: 2,),
                                  //Text("govind@gmail.com"),
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
                      // This widget will be used as a separator between items
                      return SizedBox(height: 16); // Adjust the height as needed
                    },
                    //itemCount: 15,
                    itemCount: snapshot.data!.data!.length,
                  ),

                ],
              ),
            );
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
  }

  Widget upcomingappointmentlist() {
    return FutureBuilder(
      future: upcoming_appointment(),
      builder: (context, snapshot) {
        print("object");

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(child: Text("Error: ${snapshot.error}")),
          );
        } else if (snapshot.hasData) {
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
                                      Text("Time slot:"),
                                      SizedBox(width: 5,),
                                      Text(snapshot.data!.data![index]
                                          .appointmentTime
                                          .toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.done),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Date :"),
                                  SizedBox(width: 10,),
                                  Text(snapshot.data!.data![index]
                                      .appointmentDate
                                      .toString()),
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

        // Check if the response is a string, then decode it to a Map
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

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
        print(json.encode(response.data));
        print(response.data);
        print("print response");

        // Check if the response is a string, then decode it to a Map
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        return UpcommingAppointmentModel.fromJson(responseData);
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



}
