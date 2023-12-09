//
// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
// import 'package:day_night_time_picker/lib/state/time.dart';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
//
// import '../my_theme.dart';
// import 'Add_Reminder_screen.dart';
//
// class Reschedule_Screen extends StatefulWidget {
//   const Reschedule_Screen({super.key});
//
//   @override
//   State<Reschedule_Screen> createState() => _Reschedule_ScreenState();
// }
//
// class _Reschedule_ScreenState extends State<Reschedule_Screen> {
//   TextEditingController dateInputController = TextEditingController();
//
//   Time _time = Time(hour: 11, minute: 30, second: 20);
//   bool iosStyle = true;
//
//   void onTimeChanged(Time newTime) {
//     setState(() {
//       _time = newTime;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(_time);
//     print("time");
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.white, // Change the icon color here
//         ),
//         backgroundColor: MyTheme.backgroundcolor,
//         title: Text("Reschedule",
//           style: TextStyle(
//             color: Colors.white, // Change the text color here
//           ),),
//       ),
//       body:
//     SingleChildScrollView(
//       child: Container(
//         //width: double.infinity,
//
//
//         color: MyTheme.backgroundcolor,
//         child: Column(
//           //crossAxisAlignment: CrossAxisAlignment.center,
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//
//             Container(
//               padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
//               decoration: BoxDecoration(
//                   color: MyTheme.WHITECOLOR,
//                   borderRadius:BorderRadius.circular(12)
//                 // borderRadius: BorderRadius.all(Radius.circular(10))
//               ),
//
//               //height: 276,
//               width: 300,
//
//               child: Column(
//                 //mainAxisAlignment: MainAxisAlignment.center,
//                 //crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Reschedule meeting",  style: TextStyle(
//                   color:MyTheme.backgroundcolor,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600),),
//
//                SizedBox(height: 10,),
//
//                   //DOB
//                   TextFormField(
//
//                     decoration:  InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                             width: 3, color: Colors.greenAccent), //<-- SEE HERE
//                       ),
//                       // border: InputBorder.none,
//                       //label: "DOB",
//                       labelText: "Date",
//                       hintText: 'Date',
//                       suffixIcon: Icon(Icons.calendar_month,color: Colors.black,),
//
//                     ),
//                     controller: dateInputController,
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(1950),
//                           lastDate: DateTime(2050));
//
//                       if (pickedDate != null) {
//                         dateInputController.text =
//                             DateFormat('yyyy-MM-dd').format(pickedDate);
//                       }
//                     },
//                   ),
//                 SizedBox(height: 30,),
//                   //Time picker
//                   TextFormField(
//
//                     decoration:  InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                             width: 3, color: Colors.greenAccent), //<-- SEE HERE
//                       ),
//                       // border: InputBorder.none,
//                       //label: "DOB",
//                       labelText: "Time slot",
//                       hintText: _time.format(context),
//                       suffixIcon: Icon(Icons.watch_later_outlined,color: Colors.black,),
//
//                     ),
//                     //  controller: dateInputController,
//                     readOnly: true,
//                     onTap: () async {
//                       Navigator.of(context).push(
//                         showPicker(
//                           context: context,
//                           value: _time,
//                           sunrise: TimeOfDay(hour: 6, minute: 0), // optional
//                           sunset: TimeOfDay(hour: 18, minute: 0), // optional
//                           duskSpanInMinutes: 120, // optional
//                           onChange: onTimeChanged,
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 30,),
//
//
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       alignment: Alignment.center,
//                       //width: DeviceInfo(context).width/1,
//
//                       child:
//                       SizedBox(
//                         height: 50,
//                         width:double.infinity,
//                         child: ElevatedButton(
//
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
//
//                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//
//                                     borderRadius: BorderRadius.circular(12.0),
//                                     //side: BorderSide()
//                                   )
//                               )
//                           ),
//
//                           onPressed: (){
//                             Navigator.pop(context);
//                            // Navigator.push(context,MaterialPageRoute(builder: (context)=>Add_reminder_Screen()));
//                             // onPressUpdatePassword();
//                           },
//                           child:Text(
//                             "Save",
//                             // AppLocalizations.of(context).update_password_ucf,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600),
//                           ),),
//                       ),
//                     ),
//                   ),
//
//                 ],
//               ),
//             ),
//           ],),
//
//       ),
//     ),);
//   }
//
//
// }
