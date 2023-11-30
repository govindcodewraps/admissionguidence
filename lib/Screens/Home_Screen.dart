import 'package:admissionguidence/Screens/stembuilder.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../my_theme.dart';
import 'Account_Details/AccountScreen.dart';
import 'Meeting_record_Screen.dart';
import 'Reminder_Screen.dart';
import 'RescheduleScreen.dart';
import 'loginscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController dateInputController = TextEditingController();

  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;
  DateTime? currentBackPressTime;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_time);
    print("time");

    return WillPopScope(
      onWillPop: () async {
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                Duration(seconds: 2)) {
          currentBackPressTime = DateTime.now();
          // Show a snackbar or a dialog to inform the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
            ),
          );
          return false;
        }
        return true;
      },
      child:   SafeArea(
        child: Scaffold(body:
        Container(
          width: double.infinity,
          color: MyTheme.backgroundcolor,
          child: Stack(
            children: [
              Positioned(
                  right: 15,
                  top: 13,
                  child:
                  //ElevatedButton(onPressed: (){}, child:Text("Logout",style:TextStyle(color: Colors.red),) )
                  InkWell(
                      onTap: () async{
                        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.remove('email');
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child:
                      Column(
                        children: [
                          Icon(Icons.logout,color: Colors.red,),
                          Text("Logout",style: TextStyle(color: Colors.red),),
                        ],
                      )
                     // Text("Logout",style:TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.w500),)
                  )

              ),

              Center(
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
                                      backgroundColor: MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),

                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(

                                            borderRadius: BorderRadius.circular(12.0),
                                            // side: BorderSide()
                                          )
                                      )
                                  ),

                                  onPressed: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Meeting_record_screen()));

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
                                      backgroundColor: MaterialStateProperty.all<Color>(MyTheme.YELLOCOLOR),

                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(

                                            borderRadius: BorderRadius.circular(12.0),
                                            //side: BorderSide()
                                          )
                                      )
                                  ),

                                  onPressed: (){
                                    //Navigator.push(context,MaterialPageRoute(builder: (context)=>stembuilddd()));
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Reminder_Screen()));
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
                                    //Navigator.push(context,MaterialPageRoute(builder: (context)=>stembuilddd()));
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountdetailsScreen()));
                                    // onPressUpdatePassword();
                                  },
                                  child:Text(
                                    "TRANSACTION",
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
            ],
          ),

        ),),
      ),
    );

  }
}
