
import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../my_theme.dart';

class Reschedule_Meeting_Screen extends StatefulWidget {
  String meetingid;
  String date;
  String appointmenttime;

   Reschedule_Meeting_Screen({super.key, required this.meetingid,required this.date,required this.appointmenttime,});

  @override
  State<Reschedule_Meeting_Screen> createState() => _Reschedule_Meeting_ScreenState();
}

class _Reschedule_Meeting_ScreenState extends State<Reschedule_Meeting_Screen> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController remarkInputController = TextEditingController();
 var _inputdate;
 var _inputtime;

  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(_time);
    //print(_time.format(context));
    _inputtime=_time.format(context);
    print("Input time ${_inputtime}");
    _inputdate=dateInputController.text;

    print("Input Date ${_inputdate}");
    print("Input Remark ${remarkInputController.text}");
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
      Container(
        width: double.infinity,


        color: MyTheme.backgroundcolor,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
                decoration: BoxDecoration(
                    color: MyTheme.WHITECOLOR,
                    borderRadius:BorderRadius.circular(12)
                  // borderRadius: BorderRadius.all(Radius.circular(10))
                ),

                //height: 276,
                width: 300,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(widget.meetingid),


                    Text("Reschedule Meeting",  style: TextStyle(
                        color:MyTheme.backgroundcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),),

                    SizedBox(height: 10,),

                    //DOB
                    TextFormField(

                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 3, color: Colors.greenAccent), //<-- SEE HERE
                        ),
                        // border: InputBorder.none,
                        //label: "DOB",
                        labelText:"Date",
                        hintText: "Date",
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
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                        }
                      },
                    ),
                    SizedBox(height: 30,),
                    //Time picker
                    TextFormField(

                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 3, color: Colors.greenAccent), //<-- SEE HERE
                        ),
                        // border: InputBorder.none,
                        //label: "DOB",
                        labelText: _time.format(context),
                        hintText: _time.format(context),
                        suffixIcon: Icon(Icons.watch_later_outlined,color: Colors.black,),

                      ),
                      //  controller: dateInputController,
                      readOnly: true,
                      onTap: () async {
                        Navigator.of(context).push(
                          showPicker(
                            context: context,
                            value: _time,
                            sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                            sunset: TimeOfDay(hour: 18, minute: 0), // optional
                            duskSpanInMinutes: 120, // optional
                            onChange: onTimeChanged,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30,),

                    TextField(
                      controller: remarkInputController,
                      maxLines: 4,
                      decoration:InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
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
                              _inputdate=dateInputController.text;
                              print("Input Date ${_inputdate}");
                              print("Input Remark ${remarkInputController.text}");

                              // Navigator.push(context,MaterialPageRoute(builder: (context)=>Reschedule_Screen()));
                              // onPressUpdatePassword();

                              reschedulemeetingapi(widget.meetingid,widget.date,widget.appointmenttime,remarkInputController.text);
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
            ),
          ],),

      ),);
  }


  Future reschedulemeetingapi(_bookindid,_date,_time,_remark) async{
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=30ead7cbd26e9fcee6465b06417e7aba'
    };
    var data = {
      'reschedule_appointment': '1',
      'booking_id': _bookindid,
      'date': _date,
      'appointment_time': _time,
      'remark': _remark
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

      Fluttertoast.showToast(
        msg: "Meeting Reschedule Successful Submit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }
  }


}