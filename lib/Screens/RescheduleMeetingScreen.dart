
import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../baseurl.dart';
import '../models/Time_slot_model.dart';
import '../my_theme.dart';
import 'Meeting_record_Screen.dart';

class Reschedule_Meeting_Screen extends StatefulWidget {
  String meetingid;
  String date;
  String? appointmenttime,remark;
  // DateFormat('yyyy-MM-dd').format(pickedDate)
  //String timeslotdate


  Reschedule_Meeting_Screen({super.key, required this.meetingid,required this.date,required this.appointmenttime, this.remark});

  @override
  State<Reschedule_Meeting_Screen> createState() => _Reschedule_Meeting_ScreenState();
}

class _Reschedule_Meeting_ScreenState extends State<Reschedule_Meeting_Screen> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController remarkInputController = TextEditingController();
  var _inputdate;
  //_inputdate = _inputdate.isEmpty ? '2023-11-20' : _inputdate,
  var _inputtime;
  var _timeslotid;
  String newdate =" ";
  bool _isLoading = false;
  var Datewidget="2023-12-12";
  String selectedDate="";
  String DDate="";


  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  String selectedValue = 'Select Time';
  // List<String> option = ['Transaction Type', 'CR', 'DR',];
  //Map optio={};

  @override
  void initState() {
    // TODO: implement initState
   // labelText: widget.remark ?? 'No remark',
    remarkInputController.text = widget.remark ?? 'No remark';
    Datewidget=DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.date.split(' ')[0]));
   // DDate=selectedDate.isEmpty ?Datewidget :selectedDate;
    selectedDate=selectedDate.isEmpty ?Datewidget :selectedDate;
    timeslotlist(DDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(option);
    print("print mapp drop down list ");
    //print(_time);
    //print(_time.format(context));
    // _inputtime=_time.format(context);
    // print("Input time ${_inputtime}");
    // _inputdate=dateInputController.text;
    //
    // print("OLD");
    // print(widget.date);
    // print("OLD");
    // print("Datee ${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.date.split(' ')[0]))}");
    //
    // Datewidget=DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.date.split(' ')[0]));
    // print("AAAAAAAAAAA${Datewidget}");
    // print("BBBBBBBBBBB${selectedDate}");

  // DDate=selectedDate.isEmpty ?Datewidget :selectedDate;
  // print("Selected Date ${DDate}");

    // print("Input Date ${_inputdate}");
    // print("Remark ${widget.remark}");
    // print("Input Remark ${remarkInputController.text}");
    //print("time");
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change the icon color here
        ),
        backgroundColor: MyTheme.backgroundcolor,
        title: Text("Reschedule Meeting",
          style: TextStyle(
            color: Colors.white, // Change the text color here
          ),),
      ),
      body:
      SingleChildScrollView(
        child:
        _isLoading
            ? Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(child: CircularProgressIndicator()),
            ) // Show the circular progress indicator
            :
        Container(
          padding: EdgeInsets.only(top:40),
          height: MediaQuery.of(context).size.height*1,
          width: double.infinity,


          color: MyTheme.backgroundcolor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
                decoration: BoxDecoration(
                    color: MyTheme.WHITECOLOR,
                    borderRadius:BorderRadius.circular(12)
                  // borderRadius: BorderRadius.all(Radius.circular(10))
                ),

                //height: 276,
                width: 300,

                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Text(widget.meetingid),

                    Text("Reschedule Meeting",  style: TextStyle(
                        color:MyTheme.backgroundcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),),

                    SizedBox(height: 10,),

                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 3, color: Colors.greenAccent),
                        ),
                        labelText:Datewidget,
                        hintText: Datewidget,
                        suffixIcon: Icon(Icons.calendar_month,color: Colors.black,),
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
                          dateInputController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          // Fetch time slots for the selected date
                           fetchTimeSlots(dateInputController.text);

                          setState(()  {
                             fetchTimeSlots(dateInputController.text);

                            selectedDate=dateInputController.text;
                            print("datewidget ${widget.date}");

                            // DDate=selectedDate.isEmpty ?Datewidget :selectedDate;
                            //timeslotlist(selectedDate);
                             //DDate=selectedDate.isEmpty ?Datewidget :selectedDate;
                             selectedDate=selectedDate.isEmpty ?Datewidget :selectedDate;
                             print("Selected Date ${DDate}");

                            timeslotlist(DDate);
                            print("date format ${selectedDate}");
                          });

                        }
                      },
                    ),



                    SizedBox(height: 30,),
                    //Time picker

                    timeslotwidget(),

                    SizedBox(height: 30,),
                    //labelText: widget.remark ?? 'No remark',
                    TextField(
                      controller: remarkInputController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        //labelText: widget.remark,
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 30,),
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

                              _inputtime=_time.format(context);
                              print("Input time ${_inputtime}");
                              _inputdate=dateInputController.text.isEmpty? Datewidget :dateInputController.text;
                              //_inputdate=dateInputController.text;
                              print("Input Date ${_inputdate}");
                             var _remarkinput=remarkInputController.text .isEmpty ? widget.remark:remarkInputController.text;
                              print("Input Remark ${remarkInputController.text}");
                              var meetingidd = widget.meetingid;
                              print("Time slotttt");
                              print(_timeslotid);
                              print("Time slotttt");


                              print("AAAAAAAAA ${widget.date}");
                              //DateFormat('yyyy-MM-dd').format(widget.date as DateTime);
                              print("Remarkk ${widget.remark}");
                              print("Datee ${widget.date}");
                              print("Datee ${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.date.split(' ')[0]))}");

                              print("print date widget ${Datewidget}");


                              // Navigator.push(context,MaterialPageRoute(builder: (context)=>Reschedule_Screen()));
                              // onPressUpdatePassword();

                             //rescheduleMeetingApi(meetingidd,_inputdate,_timeslotid,remarkInputController.text);
                             rescheduleMeetingApi(meetingidd,_inputdate,_timeslotid,_remarkinput);

                            },
                            child:Text(
                              "Save",
                              // AppLocalizations.of(context).update_password_ucf,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],),

        ),
      ),);
  }



  Future rescheduleMeetingApi(_bookingId, _date, _time, _remark)async{
    setState(() {
      _isLoading = true;
    });
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var request = http.Request('POST', Uri.parse(
      BASEURL.DOMAIN_PATH
        //'https://admissionguidanceindia.com/appdata/webservice.php'

    ));
    request.bodyFields = {
      'reschedule_appointment': '1',
      'booking_id': _bookingId,
      'date': _date,
      'appointment_time':_time,
      'remark':_remark
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      newdate=" ";
      print("200000");
      print(await response.stream.bytesToString());
      Fluttertoast.showToast(
        msg: "Meeting Reschedule Successful Submit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pop(context);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Meeting_record_screen()));
    }
    else if(response.statusCode == 401)
    {
      newdate=" ";
      print("40111");
      // Fluttertoast.showToast(
      //   msg: "Time slot is already booked. Please choose another time",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.redAccent[100],
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
    }
    else {
      print(response.reasonPhrase);
    }

    setState(() {
      _isLoading = false;
    });
  }



  Widget timeslotwidget() {
    return FutureBuilder(
      future: timeslotlist(selectedDate),
      builder: (context, snapshot) {
        if
        (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        // // else if (snapshot.hasError) {
        // //   return Container(
        // //     child: Center(
        // //       child: Text('Error: Internal error'),
        // //     ),
        // //   );
        // // }
        else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        else
        {
          return Container(
            // padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [

                Container(
                  width: MediaQuery.of(context).size.width*1,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),  // Set the color of the border
                    borderRadius: BorderRadius.circular(12), // Set the border radius
                  ),
                  child:

                  DropdownButton<String>(
                    isExpanded: true,

                    value: selectedValue,
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                        print(newValue);
                        _timeslotid=newValue;
                        print("time slot id print ${_timeslotid}");
                      });
                    },
                    underline: Container(),

                    items: [
                      DropdownMenuItem<String>(

                        value: 'Select Time',
                        child: Text('Select Time'),
                      ),
                      ...snapshot.data!.data!.map((datum) {
                        return DropdownMenuItem<String>(
                          value: datum.id!,
                          child: Text("${datum.slotFrom!}-${datum.slotTo!}"),
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

  Future<void> fetchTimeSlots(String selectedDate) async {
    // Call your timeslotlist API with the selected date
    try {
      TimeslotModel? timeslotData = await timeslotlist(selectedDate);
      if (timeslotData != null) {
        // Handle the fetched time slots, if needed
      }
    } catch (error) {
      // Handle any errors that may occur during API call
      print("Error fetching time slots: $error");
    }
  }

  Future<TimeslotModel?> timeslotlist(selectedDate) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      'time_slot': '1',
      'date':selectedDate
      //'date': '2023-12-21'
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


      var responseData = response.data is String
          ? json.decode(response.data)
          : response.data;
      print("time slot list");
      print(responseData);
      print("time slot list");

      //optionss=responseData;
      return TimeslotModel.fromJson(responseData);
    }
    else {
      print(response.statusMessage);
    }
  }


  // Widget timeslotwidget() {
  //   return FutureBuilder(
  //     future: timeslotlist(DDate),
  //     builder: (context, snapshot) {
  //       if
  //       (snapshot.connectionState == ConnectionState.waiting) {
  //         return Container(
  //           child: Center(child: CircularProgressIndicator()),
  //         );
  //       }
  //       // // else if (snapshot.hasError) {
  //       // //   return Container(
  //       // //     child: Center(
  //       // //       child: Text('Error: Internal error'),
  //       // //     ),
  //       // //   );
  //       // // }
  //        else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
  //         return Container(
  //           child: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       }
  //       else
  //       {
  //         return Container(
  //           // padding: EdgeInsets.only(left: 16, right: 16),
  //           child: Column(
  //             children: [
  //
  //               Container(
  //                 width: MediaQuery.of(context).size.width*1,
  //                 padding: EdgeInsets.only(left: 10),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.grey),  // Set the color of the border
  //                   borderRadius: BorderRadius.circular(12), // Set the border radius
  //                 ),
  //                 child:
  //
  //                 DropdownButton<String>(
  //                   isExpanded: true,
  //
  //                   value: selectedValue,
  //                   onChanged: (newValue) {
  //                     setState(() {
  //                       selectedValue = newValue!;
  //                       print(newValue);
  //                       _timeslotid=newValue;
  //                       print("time slot id print ${_timeslotid}");
  //                     });
  //                   },
  //                   underline: Container(),
  //
  //                   items: [
  //                     DropdownMenuItem<String>(
  //
  //                       value: 'Select Time',
  //                       child: Text('Select Time'),
  //                     ),
  //                     ...snapshot.data!.data!.map((datum) {
  //                       return DropdownMenuItem<String>(
  //                         value: datum.id!,
  //                         child: Text("${datum.slotFrom!}-${datum.slotTo!}"),
  //                       );
  //                     }).toList(),
  //                   ],
  //
  //                 ),
  //               ),
  //
  //               // selectedValue= snapshot.data.data.length;
  //             ],
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
  //
  // Future<void> fetchTimeSlots(String selectedDate) async {
  //   // Call your timeslotlist API with the selected date
  //   try {
  //     TimeslotModel? timeslotData = await timeslotlist(DDate);
  //     if (timeslotData != null) {
  //       // Handle the fetched time slots, if needed
  //     }
  //   } catch (error) {
  //     // Handle any errors that may occur during API call
  //     print("Error fetching time slots: $error");
  //   }
  // }
  //
  // Future<TimeslotModel?> timeslotlist(DDate) async {
  //   // setState(() {
  //   //   _isLoading = true;
  //   // });
  //   var headers = {
  //     'accept': 'application/json',
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
  //   };
  //   var data = {
  //     'time_slot': '1',
  //     //'date':selectedDate
  //     'date':DDate
  //     //'date': '2023-12-21'
  //   };
  //   var dio = Dio();
  //   var response = await dio.request(
  //     //'https://admissionguidanceindia.com/appdata/webservice.php',
  //     BASEURL.DOMAIN_PATH,
  //     options: Options(
  //       method: 'POST',
  //       headers: headers,
  //     ),
  //     data: data,
  //   );
  //
  //   if (response.statusCode == 200) {
  //
  //
  //     var responseData = response.data is String
  //         ? json.decode(response.data)
  //         : response.data;
  //     print("time slot list");
  //     print(responseData);
  //     print("time slot list");
  //
  //     //optionss=responseData;
  //     return TimeslotModel.fromJson(responseData);
  //   }
  //   else {
  //     print(response.statusMessage);
  //   }
  //
  //   // setState(() {
  //   //   _isLoading = false;
  //   // });
  // }

}

