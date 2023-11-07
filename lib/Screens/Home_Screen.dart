import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../my_theme.dart';
import 'RescheduleScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    print(_time);
    print("time");
    return Scaffold(body:
    Container(
      width: double.infinity,


      color: MyTheme.backgroundcolor,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            decoration: BoxDecoration(
                color: MyTheme.WHITECOLOR,
                borderRadius:BorderRadius.circular(12)
              // borderRadius: BorderRadius.all(Radius.circular(10))
            ),

            height: 276,
            width: 300,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [

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
                            backgroundColor: MaterialStateProperty.all<Color>(MyTheme.YELLOCOLOR),

                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(12.0),
                                   // side: BorderSide()
                                )
                            )
                        ),

                        onPressed: (){
                          // onPressUpdatePassword();
                        },
                        child: Text(
                          "APPOINTMENTS",
                          // AppLocalizations.of(context).update_password_ucf,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),),
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
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Reschedule_Screen()));
                          // onPressUpdatePassword();
                        },
                        child:Text(
                          "REMINDERS",
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

    ),);
  }
}
