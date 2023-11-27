import 'package:flutter/material.dart';
import '../my_theme.dart';

class Reschedule_Meeting_Screen extends StatefulWidget {


  Reschedule_Meeting_Screen({super.key,});

  @override
  State<Reschedule_Meeting_Screen> createState() => _Reschedule_Meeting_ScreenState();
}

class _Reschedule_Meeting_ScreenState extends State<Reschedule_Meeting_Screen> {


  @override
  Widget build(BuildContext context) {


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
                 Text("dropdown"),
               ],
                ),
              ),
            ),
          ],),

      ),);
  }




}