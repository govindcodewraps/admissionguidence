//
// import 'dart:convert';
// import 'dart:ui';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
// import 'package:day_night_time_picker/lib/state/time.dart';
// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
//
// import '../baseurl.dart';
// import '../models/ReminderTypeModel.dart';
// import '../models/Reminder_List_Model.dart';
// import '../my_theme.dart';
// import 'Add_Reminder_screen.dart';
// import 'Edit_Reminder.dart';
// import 'ReminderTypeScreen.dart';
// import 'dropdownscreen.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'show CalendarCarousel;
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/classes/event_list.dart';
// import 'package:intl/intl.dart' show DateFormat;
//
// class Reminder_Screen extends StatefulWidget {
//   const Reminder_Screen({super.key});
//
//   @override
//   State<Reminder_Screen> createState() => _Reminder_ScreenState();
// }
//
// class _Reminder_ScreenState extends State<Reminder_Screen> {
//   int selectedIdx = 1;
//   bool isLoading = false;
//   var Remindertypevalue;
//   var ReminderListvalue;
//   var deletereminderid="";
//   bool _isLoading = false;
//   //String formattedDate="0";
//   String formattedDatee="0";
//   //String formatte='2023-12-12';
//   //DateTime? selectedDate;
//   String _PAGECOUNT="1";
//   String accountselectedValue = 'Select Reminder Type';
//   var remindertypeid='';
//
//
//
//
//   TextEditingController dateInputController = TextEditingController();
//   FocusNode dateInputFocusNode = FocusNode();
//
//   DateTime selectedDate = DateTime.now();
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
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // dateInputController = TextEditingController();
//     // WidgetsBinding.instance?.addPostFrameCallback((_) {
//     //   _selectDate(context);
//    // });
//     DateTime today = DateTime.now();
//     print('Todays date: $today');
//
//     formattedDatee = DateFormat('yyyy-MM-dd').format(today);
//     print('Todays only date: $formattedDatee');
//
//     reminderListApi(formattedDatee,_PAGECOUNT);
//     //reminderListApi(formattedDatee,_PAGECOUNT);
//     ReminderTypeApi();
//     //_selectDate();
//
//     super.initState();
//   }
//   bool showMore = false;
//
//
//
//   DateTime _currentDate = DateTime.now();
//   DateTime _currentDate2 = DateTime.now();
//   String _currentMonth = DateFormat.yMMM().format(DateTime.now());
//
//   DateTime _targetDateTime = DateTime.now();
//
//
//
//   int _selectedIndex = -1;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final _calendarCarouselNoHeader = CalendarCarousel<Event>(
//       todayBorderColor: Colors.green,
//
//
//       onDayPressed: (date, events) {
//         this.setState(() => _currentDate2 = date);
//         events.forEach((event) => print(event.title)
//         );
//
//         String formattedDate = DateFormat('yyyy-MM-dd').format(_currentDate2);
//         formattedDatee= "$formattedDate";
//         print('Current  date: $_currentDate2');
//
//
//
//         print('Selected datae: $formattedDatee');
//
//         setState(() {
//
//
//           _PAGECOUNT="1";
//          // reminderListApi(formattedDatee);
//           reminderListApi(formattedDatee,_PAGECOUNT);
//
//         });
//
//       },
//
//
//
//       daysHaveCircularBorder: true,
//       showOnlyCurrentMonthDate: false,
//       weekendTextStyle: TextStyle(
//         color: Colors.red,
//       ),
//       //thisMonthDayBorderColor: Colors.grey,
//       weekFormat: false,
// //      firstDayOfWeek: 4,
//       // markedDatesMap: _markedDateMap,
//       height: 400.0,
//       selectedDateTime: _currentDate2,
//       targetDateTime: _targetDateTime,
//       customGridViewPhysics: NeverScrollableScrollPhysics(),
//       markedDateCustomShapeBorder:
//       CircleBorder(side: BorderSide(color: Colors.yellow)),
//       markedDateCustomTextStyle: TextStyle(
//         fontSize: 18,
//         color: Colors.blue,
//       ),
//       showHeader: true,
//       todayTextStyle: TextStyle(
//         color: Colors.blue,
//       ),
//       // markedDateShowIcon: true,
//       // markedDateIconMaxShown: 2,
//       // markedDateIconBuilder: (event) {
//       //   return event.icon;
//       // },
//       // markedDateMoreShowTotal:
//       //     true,
//       todayButtonColor: Colors.yellow,
//       selectedDayTextStyle: TextStyle(
//         color: Colors.yellow,
//       ),
//       minSelectedDate: _currentDate.subtract(Duration(days: 11360)),
//       maxSelectedDate: _currentDate.add(Duration(days: 11360)),
//       prevDaysTextStyle: TextStyle(
//         fontSize: 16,
//         color: Colors.pinkAccent,
//       ),
//       inactiveDaysTextStyle: TextStyle(
//         color: Colors.tealAccent,
//         fontSize: 16,
//       ),
//       onCalendarChanged: (DateTime date) {
//         this.setState(() {
//           _targetDateTime = date;
//           _currentMonth = DateFormat.yMMM().format(_targetDateTime);
//         });
//       },
//       onDayLongPressed: (DateTime date) {
//         print('long pressed date $date');
//       },
//     );
//
//
//     return WillPopScope(
//         onWillPop: () async {
//           Navigator.pop(context, true);
//           return true;
//         },
//         child:
//       Scaffold(
//       // appBar: AppBar(
//       //   iconTheme: IconThemeData(
//       //     color: Colors.white, // Change the icon color here
//       //   ),
//       //   backgroundColor: MyTheme.backgroundcolor,
//       //   title: Text(
//       //     "Reminder",
//       //     style: TextStyle(
//       //       color: Colors.white, // Change the text color here
//       //     ),
//       //   ),
//       //   leading: IconButton(
//       //     icon: Icon(Icons.arrow_back),
//       //     onPressed: () {
//       //       // Navigate back when back arrow is pressed
//       //       Navigator.pop(context, true);
//       //     },
//       //   ),
//       // ),
//       body:
//
//
//       Container(
//         height: double.infinity,
//         decoration: BoxDecoration(
//           //color: Colors.yellow,
//
//           image: DecorationImage(
//
//             image: AssetImage('assets/background.jpg'), // Replace with your image asset path
//             fit: BoxFit.fill,
//           ),
//         ),
//         child:
//         BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 4, sigmaY:4),
//           child: SingleChildScrollView(
//             child:
//             Center(
//               child:
//               // isLoading
//               //     ? CircularProgressIndicator() // Show the circular progress indicator
//               //     :
//               Container(
//                 width: double.infinity,
//                 child:
//                 Column(
//                   //mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//
//                     // Container(
//                     //   decoration: BoxDecoration(
//                     //       color: Colors.white70,
//                     //
//                     //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))),
//                     //  // margin: EdgeInsets.symmetric(horizontal: 16.0),
//                     //   child: _calendarCarouselNoHeader,
//                     // ),
//
//
//
//                     Card(
//                       child: ExpansionPanelList(
//                         expansionCallback: (int index, bool isExpanded) {
//                           setState(() {
//                             _selectedIndex = isExpanded ? 2 : index;
//                           });
//                         },
//                         children: [
//                           ExpansionPanel(
//                             headerBuilder: (BuildContext context, bool isExpanded) {
//                               return ListTile(
//                                 title: Text('Type'),
//                               );
//                             },
//                             body: Container(
//                               padding: EdgeInsets.all(10),
//                               child: reminderTypewidget(),
//                             ),
//                             isExpanded: _selectedIndex == 2,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Card(
//                       child: ExpansionPanelList(
//                         expansionCallback: (int index, bool isExpanded) {
//                           setState(() {
//                             _selectedIndex = isExpanded ? 1 : index;
//                           });
//                         },
//                         children: [
//                           ExpansionPanel(
//                             headerBuilder: (BuildContext context, bool isExpanded) {
//                               return ListTile(
//                                 title: Text('Date'),
//                               );
//                             },
//                             body: Container(
//                               padding: EdgeInsets.all(10),
//                               child: _calendarCarouselNoHeader,
//                             ),
//                             isExpanded: _selectedIndex == 1,
//                           ),
//                         ],
//                       ),
//                     ),
//
//
//
//
//
//
//
//
//             //         Card(
//             //           child: ExpansionTile(
//             //             title: Text("Type"),
//             //             children: [
//             //               reminderTypewidget(),
//             //               SizedBox(height: 25,),
//             //
//             //             ],
//             //           ),
//             //         ),
//             //
//             //
//             //      Card(
//             //     child:
//             //     ExpansionTile(
//             //     title: Text("Date"),
//             //     children: [
//             //       Container(
//             //         decoration: BoxDecoration(
//             //             color: Colors.white70,
//             //
//             //             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))),
//             //        // margin: EdgeInsets.symmetric(horizontal: 16.0),
//             //         child: _calendarCarouselNoHeader,
//             //       ),
//             //
//             //     ],
//             //   ),
//             // ),
//
//
//
//
//                   SizedBox(height: 30,),
//
//
//                     reminderlistwidget(),
//                     // lllist(),
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//
//
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle the "Add Reminder" button tap
//           //Navigator.push(context, MaterialPageRoute(builder: (context) => AddReminderScreen(),),);
//
//           Navigator.push(context,MaterialPageRoute(builder: (context)=>AddReminderScreen())).then((value){ if(value != null && value)
//           {
//             setState(() {
//              // reminderListApi(formattedDatee);
//               reminderListApi(formattedDatee,_PAGECOUNT);
//
//               ReminderTypeApi();
//             });
//           };
//           });
//         },
//         backgroundColor: Colors.blue, // Set the FAB background color
//         child: Icon(Icons.add,size: 20,),
//       ),
//
//
//
//
//     ),
//     );
//   }
//
//
//
//
//
//   Widget reminderlistwidget() {
//     return
//       FutureBuilder(
//         //future: reminderListApi(formattedDatee),
//         future:    reminderListApi(formattedDatee,_PAGECOUNT),
//           builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Container(
//               child: Center(child: Text("No Reminder")),
//             );
//           } else if (snapshot.hasData) {
//             var appointmentsListModel =
//             snapshot.data as ReminderListModel;
//
//             return
//               Container(
//                 decoration:BoxDecoration(
//                   borderRadius: (BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))),
//                   color: Colors.white70
//                 ),
//                 padding: EdgeInsets.only(top: 30),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, int index) {
//                         return
//                           Container(
//                             padding: EdgeInsets.only(left: 10,right: 10),
//                             // height: 100,
//                             // color: Colors.pink,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.only(top: 10),
//                                   height: 100,
//                                   width: MediaQuery.of(context).size.width*0.33,
//                                   decoration: BoxDecoration(
//                                       color:MyTheme.backgroundcolor,
//                                       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),topLeft: Radius.circular(16))
//                                   ),
//
//                                   child: Column(
//                                     children: [
//                                       Icon(Icons.notifications,color: Colors.white,),
//                                       SizedBox(height: 10,),
//                                       //Text("2023-11-11",style: TextStyle(color: Colors.white),),
//                                       //Text(snapshot.data!.data![index].date.toString(),style: TextStyle(color: Colors.white),),
//                                       Text(
//                                         DateFormat('yyyy-MM-dd').format(DateTime.parse(snapshot.data!.data![index].date.toString())),
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//
//
//                                       SizedBox(height: 10,),
//
//                                       Text(
//                                         snapshot.data!.data![index].time != null
//                                             ? snapshot.data!.data![index].time.toString()
//                                             : ' ',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//
//                                 Column(
//                                   children: [
//
//                                     Container(
//                                       padding: EdgeInsets.all(8),
//                                       height: 100,
//                                       width: MediaQuery.of(context).size.width * 0.50,
//                                       color: Colors.white,
//                                       child: OverflowBox(
//                                         //maxWidth: double.infinity,
//                                         child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             maxLines: 2,
//                                             snapshot.data!.data![index].remark.toString(),
//                                             //enumToString(snapshot.data!.data![index].reminderType.toString()),
//                                             overflow: TextOverflow.ellipsis,
//                                             textAlign: TextAlign.left,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//
//                                   ],
//                                 ),
//
//
//
//
//                                 Container(
//
//                                   height: 100,
//                                   decoration: BoxDecoration(
//                                       color:MyTheme.WHITECOLOR,
//                                       borderRadius: BorderRadius.only(bottomRight: Radius.circular(16),topRight: Radius.circular(16))
//                                   ),
//                                   width: MediaQuery.of(context).size.width*0.1,
//                                   //color: Colors.red,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//                                           print("id ${snapshot.data!.data![index].id.toString()}");
//                                           print("date ${snapshot.data!.data![index].date.toString()}");
//                                           print("remark ${snapshot.data!.data![index].remark.toString()}");
//                                           print("time ${snapshot.data!.data![index].time.toString()}");
//                                           print("Reminder type ${snapshot.data!.data![index].reminderType.toString()}");
//                                           print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//
//                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditReminderScreen(meetingid:snapshot.data!.data![index].id.toString(),reminderType: snapshot.data!.data![index].reminderType.toString(),datew: snapshot.data!.data![index].date.toString(),timew:snapshot.data!.data![index].time.toString() ,remarkw: snapshot.data!.data![index].remark.toString(),)));
//
//
//
//                                           Navigator.push(context,MaterialPageRoute(builder: (context)=>EditReminderScreen(meetingid:snapshot.data!.data![index].id.toString(),reminderType: snapshot.data!.data![index].reminderType.toString(),datew: snapshot.data!.data![index].date.toString(),timew:snapshot.data!.data![index].time.toString() ,remarkw: snapshot.data!.data![index].remark.toString(),))).then((value){ if(value != null && value)
//                                           {
//                                             setState(() {
//                                               //reminderListApi(formattedDatee);
//                                               reminderListApi(formattedDatee,_PAGECOUNT);
//                                               ReminderTypeApi();
//                                             });
//                                           };
//                                           });
//
//
//
//                                           // Handle the "Edit Reminder" tap
//                                         },
//                                         child: Icon(Icons.edit),
//
//                                       ),
//
//
//
//                                       InkWell(
//                                           onTap: (){
//                                             var reminderid=snapshot.data!.data![index].id.toString();
//                                             print("delet id ${reminderid}");
//                                             deletereminderid=reminderid;
//                                             //
//                                             // deletreminderapi(reminderid.toString());
//
//                                             showDeleteConfirmationDialog(context);
//                                           },
//                                           child: Icon(Icons.delete)),
//
//
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//
//                       },
//                       separatorBuilder: (context, index) {
//                         return SizedBox(height: 16);
//                       },
//                       itemCount:snapshot.data!.data!.length,
//                     ),
//
//
//                     Row(
//                       //crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//
//                         // snapshot.data!.pagination!.prevPage!.toString()
//                         if(snapshot.data!.pagination!.prevPage! >= 1)
//                           ElevatedButton(onPressed: (){
//                             _PAGECOUNT=snapshot.data!.pagination!.prevPage!.toString();
//                             reminderListApi(formattedDatee,_PAGECOUNT);
//                             print("page count prev ${_PAGECOUNT}");
//                             setState(() {
//                               reminderListApi(formattedDatee,_PAGECOUNT);
//
//                             });
//                           }, child:Text("Prev")),
//                         Spacer(),
//                         //if(snapshot.data!.pagination!.nextPage! <= 1)
//                         if(snapshot.data!.pagination!.nextPage! > 1)
//                           ElevatedButton(onPressed: (){
//                             _PAGECOUNT=snapshot.data!.pagination!.nextPage!.toString();
//
//                             reminderListApi(formattedDatee,_PAGECOUNT);
//                             print("page count next ${_PAGECOUNT}");
//                             setState(() {
//                              // paymentlistpagination(_PAGECOUNT);
//                               reminderListApi(formattedDatee,_PAGECOUNT);
//
//
//                             });
//                           }, child:Text("Next")),
//
//                       ],
//                     ),
//                     SizedBox(height: 80,),
//
//
//                   ],
//                 ),
//               );
//
//           } else {
//             return Container(
//               child: Center(child: Text("No data available")),
//             );
//           }
//         },
//       );
//   }
//
//   void showDeleteConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Are you sure want to delete?"),
//           // content: Text("Are you sure you want to logout?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Cancel",style: TextStyle(color: Colors.grey),),
//             ),
//             TextButton(
//               onPressed: () async {
//                 // Perform logout actions
//                 // var reminderid=snapshot.data!.data![index].id.toString();
//                 print("delete reminder id  ${deletereminderid}");
//
//                 deletreminderapi(deletereminderid.toString());
//               },
//               child:
//               //Image.asset('assets/logoutbutton.jpg'),
//               Text("Delete",style: TextStyle(color: Colors.red),),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   Future setreminderapi(reminderid,typeid) async{
//     var headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=30ead7cbd26e9fcee6465b06417e7aba'
//     };
//     var data = {
//       'set_reminder': '1',
//       'reminder_id':reminderid,
//       'type_id': typeid
//     };
//     var dio = Dio();
//     var response = await dio.request(
//       //'https://admissionguidanceindia.com/appdata/webservice.php',
//       BASEURL.DOMAIN_PATH,
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//       print("successfully set remionder");
//       print(json.encode(response.data));
//       Fluttertoast.showToast(
//         msg: "successfully set remionder",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//       Navigator.pop(context);
//     }
//
//     else if (response.statusCode == 401) {
//
//       Fluttertoast.showToast(
//         msg: "Please enter all required fields",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//
//     }
//
//     else {
//       print(response.statusMessage);
//     }
//   }
//
//   Future deletreminderapi(reminderid,) async{
//     setState(() {
//       isLoading = true;
//     });
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=30ead7cbd26e9fcee6465b06417e7aba'
//     };
//     var data = {
//       'reminder_delete': '1',
//       'id': reminderid
//     };
//     var dio = Dio();
//     var response = await dio.request(
//       //'https://admissionguidanceindia.com/appdata/webservice.php',
//       BASEURL.DOMAIN_PATH,
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//       print(json.encode(response.data));
//       Fluttertoast.showToast(
//         msg: "Reminder Deleted successfully",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//       Navigator.pop(context,true);
//       //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Reminder_Screen()));
//     }
//     else {
//       print(response.statusMessage);
//     }
//     setState(() {
//       isLoading = true;
//     });
//   }
//
//
//
//   Future<ReminderListModel?> areminderListApi() async {
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
//     };
//     var data = {
//       'reminder_list': '1'
//     };
//     var dio = Dio();
//
//     try {
//       var response = await dio.post(
//         //'https://admissionguidanceindia.com/appdata/webservice.php',
//         BASEURL.DOMAIN_PATH,
//         options: Options(
//           headers: headers,
//         ),
//         data: data,
//       );
//
//       if (response.statusCode == 200) {
//         print(json.encode(response.data));
//         print(response.data);
//         print("Reminder list response printed ");
//
//         // Check if the response is a string, then decode it to a Map
//         var responseData = response.data is String
//             ? json.decode(response.data)
//             : response.data;
//
//         return ReminderListModel.fromJson(responseData);
//       } else {
//         print(response.statusMessage);
//         throw Exception('Failed to load data');
//       }
//     } catch (error) {
//       print(error.toString());
//       throw Exception('Failed to load data');
//     }
//   }
//
//   Future<ReminderListModel?> reminderListApi(date,pagecount) async {
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
//     };
//     var data = {
//       'reminder_filter': '1',
//        'date': date,
//        'page': pagecount
//       //'page': '1'
//
//        //'date': '2023-12-11'
//     };
//     var dio = Dio();
//
//     try {
//       var response = await dio.post(
//        //'https://admissionguidanceindia.com/appdata/webservice.php',
//         BASEURL.DOMAIN_PATH,
//         options: Options(
//           headers: headers,
//         ),
//         data: data,
//       );
//
//       if (response.statusCode == 200) {
//         print(json.encode(response.data));
//         print(response.data);
//         print("Reminder list response printed ");
//
//         // Check if the response is a string, then decode it to a Map
//         var responseData = response.data is String
//             ? json.decode(response.data)
//             : response.data;
//
//         return ReminderListModel.fromJson(responseData);
//       } else {
//         print(response.statusMessage);
//         throw Exception('Failed to load data');
//       }
//     } catch (error) {
//       print(error.toString());
//       throw Exception('Failed to load data');
//     }
//   }
//
//   Future<ReminderTypeModel?> ReminderTypeApi() async {
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=30ead7cbd26e9fcee6465b06417e7aba'
//     };
//     var data = {
//       'reminder_type': '1'
//     };
//     var dio = Dio();
//     var response = await dio.request(
//      // 'https://admissionguidanceindia.com/appdata/webservice.php',
//       BASEURL.DOMAIN_PATH,
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//       //print(json.encode(response.data));
//
//       var responseData = response.data is String
//           ? json.decode(response.data)
//           : response.data;
//
//       print("Reminder type print ${responseData}");
//
//       return ReminderTypeModel.fromJson(responseData);
//     }
//
//     else {
//       print(response.statusMessage);
//     }
//   }
//
//
//
//
//   Widget reminderTypewidget() {
//     return FutureBuilder(
//       future: remindertypeAPI(),
//       builder: (context, snapshot) {
//         // if (snapshot.connectionState == ConnectionState.waiting) {
//         //   return Container(
//         //     child: Center(child: CircularProgressIndicator()),
//         //   );
//         // } else if (snapshot.hasError) {
//         //   return Container(
//         //     child: Center(
//         //       child: Text('Error: Internal error'),
//         //     ),
//         //   );
//         // } else
//         if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
//           return Container(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else {
//           return Container(
//             // padding: EdgeInsets.only(left: 16, right: 16),
//             child: Column(
//               children: [
//
//                 Container(
//                   width: MediaQuery.of(context).size.width*0.8,
//                   padding: EdgeInsets.only(left: 16,right: 11),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),  // Set the color of the border
//                     borderRadius: BorderRadius.circular(12), // Set the border radius
//                   ),
//                   child:
//
//                   DropdownButton<String>(
//                     isExpanded: true,
//
//                     value: accountselectedValue,
//                     onChanged: (newValue) {
//                       setState(() {
//                         accountselectedValue = newValue!;
//                         remindertypeid=newValue;
//                         print("Account Number ${newValue}");
//                         print("Account Number id ${remindertypeid}");
//                       });
//                     },
//                     underline: Container(),
//                     items: [
//                       DropdownMenuItem<String>(
//                         value: 'Select Reminder Type',
//                         child: Text('Select Reminder Type'),
//                       ),
//                       ...snapshot.data!.data!.map((datum) {
//                         return DropdownMenuItem<String>(
//                           value: datum.id!,
//                           child: Text("${(datum.type!)}"),
//                         );
//                       }).toList(),
//                     ],
//                   ),
//
//                 ),
//
//                 // selectedValue= snapshot.data.data.length;
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
//   Future<ReminderTypeModel?> remindertypeAPI() async {
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
//     };
//     var data = {
//       'reminder_type': '1',
//     };
//     var dio = Dio();
//     var response = await dio.request(
//       //'https://admissionguidanceindia.com/appdata/webservice.php',
//       BASEURL.DOMAIN_PATH,
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//
//
//       var responseData = response.data is String
//           ? json.decode(response.data)
//           : response.data;
//       print("time slot list");
//       print(responseData);
//       print("time slot list");
//       //optionss=responseData;
//       return ReminderTypeModel.fromJson(responseData);
//     }
//     else {
//       print(response.statusMessage);
//     }
//   }
//
// }


















//running reminder list screen

import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../baseurl.dart';
import '../../models/ReminderTypeModel.dart';
import '../../models/Reminder_List_Model.dart';
import '../../my_theme.dart';
import 'Add_Reminder_screen.dart';
import '../Edit_Reminder.dart';
import '../ReminderTypeScreen.dart';
import '../dropdownscreen.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class Reminder_Screen extends StatefulWidget {
  const Reminder_Screen({super.key});

  @override
  State<Reminder_Screen> createState() => _Reminder_ScreenState();
}

class _Reminder_ScreenState extends State<Reminder_Screen> {
  int selectedIdx = -1;
  bool isLoading = false;
  var Remindertypevalue;
  var ReminderListvalue;
  var deletereminderid="";
  bool _isLoading = false;
  //String formattedDate="0";
  String formattedDatee="0";
  //String formatte='2023-12-12';
  //DateTime? selectedDate;
  String _PAGECOUNT="1";


  TextEditingController dateInputController = TextEditingController();
  FocusNode dateInputFocusNode = FocusNode();

  DateTime selectedDate = DateTime.now();

  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    // dateInputController = TextEditingController();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   _selectDate(context);
   // });
    DateTime today = DateTime.now();
    print('Todays date: $today');

    formattedDatee = DateFormat('yyyy-MM-dd').format(today);
    print('Todays only date: $formattedDatee');

    reminderListApi(formattedDatee,_PAGECOUNT);
    //reminderListApi(formattedDatee,_PAGECOUNT);
    ReminderTypeApi();
    //_selectDate();

    super.initState();
  }
  bool showMore = false;


  //
  // Future<void> _selectDate() async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2050),
  //   );
  //
  //   if (pickedDate != null) {
  //     setState(() {
  //       selectedDate = pickedDate;
  //       dateInputController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  //     });
  //   }
  // }

  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());

  DateTime _targetDateTime = DateTime.now();




  @override
  Widget build(BuildContext context) {

    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,


      onDayPressed: (date, events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title)
        );

        String formattedDate = DateFormat('yyyy-MM-dd').format(_currentDate2);
        formattedDatee= "$formattedDate";
        print('Current  date: $_currentDate2');



        print('Selected datae: $formattedDatee');

        setState(() {


          _PAGECOUNT="1";
         // reminderListApi(formattedDatee);
          reminderListApi(formattedDatee,_PAGECOUNT);

        });

      },



      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      //thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      // markedDatesMap: _markedDateMap,
      height: 400.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
      CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: true,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 11360)),
      maxSelectedDate: _currentDate.add(Duration(days: 11360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );


    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return true;
        },
        child:
      Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color: Colors.white, // Change the icon color here
      //   ),
      //   backgroundColor: MyTheme.backgroundcolor,
      //   title: Text(
      //     "Reminder",
      //     style: TextStyle(
      //       color: Colors.white, // Change the text color here
      //     ),
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       // Navigate back when back arrow is pressed
      //       Navigator.pop(context, true);
      //     },
      //   ),
      // ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          //color: Colors.yellow,

          image: DecorationImage(

            image: AssetImage('assets/background.jpg'), // Replace with your image asset path
            fit: BoxFit.fill,
          ),
        ),
        child:


        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY:4),
          child: SingleChildScrollView(
            child:
            Center(
              child:
              // isLoading
              //     ? CircularProgressIndicator() // Show the circular progress indicator
              //     :
              Container(
                width: double.infinity,
                child:
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //SizedBox(height: 10,),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //       borderSide: BorderSide(
                    //         width: 3,
                    //         color: Colors.greenAccent,
                    //       ),
                    //     ),
                    //     //labelText: "pickedDate",
                    //     hintText: "",
                    //     suffixIcon: Icon(Icons.calendar_month, color: Colors.black),
                    //   ),
                    //   controller: dateInputController,
                    //   readOnly: true,
                    //   onTap: () async {
                    //     DateTime? pickedDate = await showDatePicker(
                    //       context: context,
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime.now(),
                    //       lastDate: DateTime(2050),
                    //     );
                    //
                    //     if (pickedDate != null) {
                    //       dateInputController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                    //     }
                    //
                    //   },
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,

                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))),
                     // margin: EdgeInsets.symmetric(horizontal: 16.0),
                      child: _calendarCarouselNoHeader,
                    ),

                  SizedBox(height: 30,),


                    reminderlistwidget(),
                    // lllist(),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the "Add Reminder" button tap
          //Navigator.push(context, MaterialPageRoute(builder: (context) => AddReminderScreen(),),);


          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddReminderScreen())).then((value){ if(value != null && value)
          {
            setState(() {
             // reminderListApi(formattedDatee);
              reminderListApi(formattedDatee,_PAGECOUNT);

              ReminderTypeApi();
            });
          };
          });
        },
        backgroundColor: Colors.blue, // Set the FAB background color
        child: Icon(Icons.add,size: 20,),
      ),
    ),
    );
  }


  // Widget lllist(){
  //   return
  //
  //     ListView.separated(
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemBuilder: (context, int index) {
  //           return
  //             Container(
  //               padding: EdgeInsets.only(left: 10,right: 10),
  //               // height: 100,
  //               // color: Colors.pink,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.only(top: 20),
  //                     height: 100,
  //                     width: MediaQuery.of(context).size.width*0.33,
  //                     decoration: BoxDecoration(
  //                         color:MyTheme.backgroundcolor,
  //                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),topLeft: Radius.circular(16))
  //                     ),
  //
  //                     child: Column(
  //                       children: [
  //                         Icon(Icons.notifications,color: Colors.white,),
  //                         SizedBox(height: 10,),
  //                         Text("2023-11-11",style: TextStyle(color: Colors.white),),
  //                       ],
  //
  //
  //                     ),
  //                   ),
  //                   Container(
  //                     padding: EdgeInsets.all(8),
  //                     height: 100,
  //                     width: MediaQuery.of(context).size.width * 0.52,
  //                     color: Color(0xff68E3E3FF),
  //                     child: Center(
  //                       child: OverflowBox(
  //                         // maxWidth: double.infinity,
  //                         child: Text(
  //                           maxLines: 5,
  //                           "ydbcydbcc   dhybcydc",
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //
  //                   Container(
  //                     padding: EdgeInsets.only(top: 12),
  //                     height: 100,
  //                     decoration: BoxDecoration(
  //                         color:MyTheme.WHITECOLOR,
  //                         borderRadius: BorderRadius.only(bottomRight: Radius.circular(16),topRight: Radius.circular(16))
  //                     ),
  //                     width: MediaQuery.of(context).size.width*0.1,
  //                     //color: Colors.red,
  //                     child: Column(
  //                       children: [
  //                         Icon(Icons.edit),
  //                         SizedBox(height: 10,),
  //                         Icon(Icons.delete),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //
  //         },
  //         separatorBuilder: (context, index) {
  //           return SizedBox(height: 16);
  //         },
  //         itemCount:10
  //     );
  // }

  // String enumToString(enumItem) {
  //   return enumItem.toString().split('.').last;
  // }

  Widget reminderlistwidget() {
    return
      FutureBuilder(
        //future: reminderListApi(formattedDatee),
        future:    reminderListApi(formattedDatee,_PAGECOUNT),
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Container(
              child: Center(child: Text("No Reminder")),
            );
          } else if (snapshot.hasData) {
            var appointmentsListModel =
            snapshot.data as ReminderListModel;

            return
              Container(
                decoration:BoxDecoration(
                  borderRadius: (BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))),
                  color: Colors.white70
                ),
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 10,),
                    // Text(
                    //   "   Reminder List",
                    //   style: TextStyle(
                    //       //color: MyTheme.backgroundcolor,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w600),
                    // ),
                    //SizedBox(height: 10),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            // height: 100,
                            // color: Colors.pink,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  height: 100,
                                  width: MediaQuery.of(context).size.width*0.33,
                                  decoration: BoxDecoration(
                                      color:MyTheme.backgroundcolor,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),topLeft: Radius.circular(16))
                                  ),

                                  child: Column(
                                    children: [
                                      Icon(Icons.notifications,color: Colors.white,),
                                      SizedBox(height: 10,),
                                      //Text("2023-11-11",style: TextStyle(color: Colors.white),),
                                      //Text(snapshot.data!.data![index].date.toString(),style: TextStyle(color: Colors.white),),
                                      Text(
                                        DateFormat('yyyy-MM-dd').format(DateTime.parse(snapshot.data!.data![index].date.toString())),
                                        style: TextStyle(color: Colors.white),
                                      ),


                                      SizedBox(height: 10,),

                                      Text(
                                        snapshot.data!.data![index].time != null
                                            ? snapshot.data!.data![index].time.toString()
                                            : ' ',
                                        style: TextStyle(color: Colors.white),
                                      ),

                                    ],
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.all(8),
                                //   height: 100,
                                //   width: MediaQuery.of(context).size.width * 0.52,
                                //   color: Color(0xff68E3E3FF),
                                //   child: Center(
                                //     child: OverflowBox(
                                //       // maxWidth: double.infinity,
                                //       child: Text(
                                //         maxLines: 5,
                                //        "  ybyb ",
                                //        // snapshot.data!.data![index].remark.toString(),
                                //         overflow: TextOverflow.ellipsis,
                                //
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Column(
                                  children: [

                                    Container(
                                      padding: EdgeInsets.all(8),
                                      height: 100,
                                      width: MediaQuery.of(context).size.width * 0.50,
                                      color: Colors.white,
                                      child: OverflowBox(
                                        //maxWidth: double.infinity,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            maxLines: 2,
                                            snapshot.data!.data![index].remark.toString(),
                                            //enumToString(snapshot.data!.data![index].reminderType.toString()),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Container(
                                    //     height: 20,
                                    //     width: MediaQuery.of(context).size.width * 0.50,
                                    //     color: Color(0xff68E3E3FF),
                                    //     child: Column(
                                    //       children: [
                                    //
                                    //         Row(
                                    //           children: [
                                    //             Text("Reminder Type :"),
                                    //             // SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                                    //             Text(
                                    //               snapshot.data!.data![index].reminderType != null && snapshot.data!.data![index].reminderType.toString().isNotEmpty
                                    //                   ? snapshot.data!.data![index].reminderType.toString().split('.').last
                                    //                   : 'No Remark',
                                    //             ),
                                    //
                                    //           ],
                                    //         ),
                                    //       ],
                                    //
                                    //     )),

                                  ],
                                ),
                                //Text(enumToString(snapshot.data!.data![index].reminderType.toString()),),




                                Container(

                                  height: 100,
                                  decoration: BoxDecoration(
                                      color:MyTheme.WHITECOLOR,
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(16),topRight: Radius.circular(16))
                                  ),
                                  width: MediaQuery.of(context).size.width*0.1,
                                  //color: Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                                          print("id ${snapshot.data!.data![index].id.toString()}");
                                          print("date ${snapshot.data!.data![index].date.toString()}");
                                          print("remark ${snapshot.data!.data![index].remark.toString()}");
                                          print("time ${snapshot.data!.data![index].time.toString()}");
                                          print("Reminder type ${snapshot.data!.data![index].reminderType.toString()}");
                                          print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditReminderScreen(meetingid:snapshot.data!.data![index].id.toString(),reminderType: snapshot.data!.data![index].reminderType.toString(),datew: snapshot.data!.data![index].date.toString(),timew:snapshot.data!.data![index].time.toString() ,remarkw: snapshot.data!.data![index].remark.toString(),)));



                                          Navigator.push(context,MaterialPageRoute(builder: (context)=>EditReminderScreen(meetingid:snapshot.data!.data![index].id.toString(),reminderType: snapshot.data!.data![index].reminderType.toString(),datew: snapshot.data!.data![index].date.toString(),timew:snapshot.data!.data![index].time.toString() ,remarkw: snapshot.data!.data![index].remark.toString(),))).then((value){ if(value != null && value)
                                          {
                                            setState(() {
                                              //reminderListApi(formattedDatee);
                                              reminderListApi(formattedDatee,_PAGECOUNT);
                                              ReminderTypeApi();
                                            });
                                          };
                                          });



                                          // Handle the "Edit Reminder" tap
                                        },
                                        child: Icon(Icons.edit),

                                        //Text("Edit Reminder"),
                                      ),
                                      // InkWell(
                                      //
                                      //     onTap: (){
                                      //       setState(() {
                                      //         Remindertypevalue = ''; // You can assign any default or empty value
                                      //       });
                                      //       Remindertypevalue == null ? Remindertypevalue.clear:"";
                                      //       ReminderListvalue=snapshot.data!.data![index].id.toString();
                                      //       //_showCustomDialog(context);
                                      //       print("print reminder list id:: ${snapshot.data!.data![index].id.toString()}");
                                      //
                                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>ReminderTypesScreen(reminderid:snapshot.data!.data![index].id.toString() ,)));
                                      //
                                      //     },
                                      //     child: Icon(Icons.autorenew_rounded)),


                                      InkWell(
                                          onTap: (){
                                            var reminderid=snapshot.data!.data![index].id.toString();
                                            print("delet id ${reminderid}");
                                            deletereminderid=reminderid;
                                            //
                                            // deletreminderapi(reminderid.toString());

                                            showDeleteConfirmationDialog(context);
                                          },
                                          child: Icon(Icons.delete)),

                                      /*    Row(
                                      children: [

                                        InkWell(
                                          onTap: () {
                                            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                                            print(snapshot.data!.data![index].id.toString());
                                            print(snapshot.data!.data![index].date.toString());
                                            print(snapshot.data!.data![index].remark.toString());
                                            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditReminderScreen(meetingid:snapshot.data!.data![index].id.toString())));
                                            // Handle the "Edit Reminder" tap
                                          },
                                          child: Icon(Icons.edit),

                                          //Text("Edit Reminder"),
                                        ),
                                        SizedBox(width: 10,),

                                        InkWell(

                                            onTap: (){
                                              setState(() {
                                                Remindertypevalue = ''; // You can assign any default or empty value
                                              });
                                              Remindertypevalue == null ? Remindertypevalue.clear:"";
                                              ReminderListvalue=snapshot.data!.data![index].id.toString();
                                              //_showCustomDialog(context);
                                              print("print reminder list id:: ${snapshot.data!.data![index].id.toString()}");

                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReminderTypesScreen(reminderid:snapshot.data!.data![index].id.toString() ,)));

                                            },
                                            child: Icon(Icons.autorenew_rounded)),

                                        SizedBox(width: 10,),

                                        InkWell(
                                            onTap: (){
                                              var reminderid=snapshot.data!.data![index].id.toString();
                                              print("delet id ${reminderid}");

                                              deletreminderapi(reminderid.toString());
                                            },
                                            child: Icon(Icons.delete)),
                                        // InkWell(
                                        //     onTap: (){
                                        //       Navigator.push(context, MaterialPageRoute(builder: (context)=>griddd()));
                                        //         },
                                        //     child: Icon(Icons.delete)),


                                      ],
                                    ),*/

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );

                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16);
                      },
                      itemCount:snapshot.data!.data!.length,
                    ),


                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        // snapshot.data!.pagination!.prevPage!.toString()
                        if(snapshot.data!.pagination!.prevPage! >= 1)
                          ElevatedButton(onPressed: (){
                            _PAGECOUNT=snapshot.data!.pagination!.prevPage!.toString();
                            reminderListApi(formattedDatee,_PAGECOUNT);
                            print("page count prev ${_PAGECOUNT}");
                            setState(() {
                              reminderListApi(formattedDatee,_PAGECOUNT);

                            });
                          }, child:Text("Prev")),
                        Spacer(),
                        //if(snapshot.data!.pagination!.nextPage! <= 1)
                        if(snapshot.data!.pagination!.nextPage! > 1)
                          ElevatedButton(onPressed: (){
                            _PAGECOUNT=snapshot.data!.pagination!.nextPage!.toString();

                            reminderListApi(formattedDatee,_PAGECOUNT);
                            print("page count next ${_PAGECOUNT}");
                            setState(() {
                             // paymentlistpagination(_PAGECOUNT);
                              reminderListApi(formattedDatee,_PAGECOUNT);


                            });
                          }, child:Text("Next")),

                      ],
                    ),
                    SizedBox(height: 80,),


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
                print("delete reminder id  ${deletereminderid}");

                deletreminderapi(deletereminderid.toString());
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

  // void _showCustomDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alertDialog(context); // Call your alertDialog function here
  //     },
  //   );
  // }

  // Widget alertDialog(BuildContext context) {
  //
  //   return  FutureBuilder(
  //     future: ReminderTypeApi(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Container(
  //           //child: Center(child: CircularProgressIndicator()),
  //         );
  //       } else if (snapshot.hasError) {
  //         return Container(
  //           child: Center(child: Text(" ")),
  //         );
  //       } else if (snapshot.hasData) {
  //         var appointmentsListModel =
  //         snapshot.data as ReminderTypeModel;
  //
  //         return
  //           AlertDialog(
  //
  //             title: Text('Select Reminder Type'),
  //             content: Container(
  //               height: 600,
  //               width: double.maxFinite,
  //               child:
  //               GridView.builder(
  //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 2,
  //                   crossAxisSpacing: 8.0,
  //                   mainAxisSpacing: 8.0,
  //                 ),
  //                 itemCount: snapshot.data!.data!.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return GestureDetector(
  //                     onTap: () {
  //                       // Update the selected index
  //                       setState(() {
  //                         selectedIdx = index;
  //                       });
  //                     },
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         color: selectedIdx == index ? Colors.blue : Colors.grey,
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           snapshot.data!.data![index].type.toString(),
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     Remindertypevalue = ''; // You can assign any default or empty value
  //                   });
  //                   Navigator.of(context).pop(); // Close the dialog
  //                 },
  //                 child: Text('Close'),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //
  //                   setreminderapi(ReminderListvalue,Remindertypevalue);
  //                 },
  //                 child: Text('Save'),
  //               ),
  //             ],
  //           );
  //
  //       } else {
  //         return Container(
  //           child: Center(child: Text("No data available")),
  //         );
  //       }
  //     },
  //   );
  // }


  Future setreminderapi(reminderid,typeid) async{
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=30ead7cbd26e9fcee6465b06417e7aba'
    };
    var data = {
      'set_reminder': '1',
      'reminder_id':reminderid,
      'type_id': typeid
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
      print("successfully set remionder");
      print(json.encode(response.data));
      Fluttertoast.showToast(
        msg: "successfully set remionder",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pop(context);
    }

    else if (response.statusCode == 401) {

      Fluttertoast.showToast(
        msg: "Please enter all required fields",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    }

    else {
      print(response.statusMessage);
    }
  }

  Future deletreminderapi(reminderid,) async{
    setState(() {
      isLoading = true;
    });
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=30ead7cbd26e9fcee6465b06417e7aba'
    };
    var data = {
      'reminder_delete': '1',
      'id': reminderid
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
      print("?????????????");
      print(json.encode(response.data));
      print("response delete reminder ${response.data}");
      print("?????????????");
      Fluttertoast.showToast(
        msg: "Reminder Deleted successfullyyyyyyyyy",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      //Navigator.of(context).pop();
      //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Reminder_Screen()));
    }
    else {
      print(response.statusMessage);
    }
    setState(() {
      isLoading = true;
    });
  }

  // Future<ReminderListModel> reminderlistapill() async {
  //   var headers = {
  //     'accept': 'application/json',
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
  //   };
  //   var data = {
  //     'reminder_list': '1'
  //   };
  //   var dio = Dio();
  //
  //   try {
  //     var response = await dio.request(
  //       'https://admissionguidanceindia.com/appdata/webservice.php',
  //       options: Options(
  //         method: 'POST',
  //         headers: headers,
  //       ),
  //       data: data,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print(json.encode(response.data));
  //       print(response.data);
  //       print("reminder_list response print ");
  //
  //       // Check if the response is a string, then decode it to a Map
  //       var responseData = response.data is String
  //           ? json.decode(response.data)
  //           : response.data;
  //
  //       return ReminderListModel.fromJson(responseData);
  //     } else {
  //       print(response.statusMessage);
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //     throw Exception('Failed to load data');
  //   }
  // }


  Future<ReminderListModel?> areminderListApi() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
    };
    var data = {
      'reminder_list': '1'
    };
    var dio = Dio();

    try {
      var response = await dio.post(
        //'https://admissionguidanceindia.com/appdata/webservice.php',
        BASEURL.DOMAIN_PATH,
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        print(response.data);
        print("Reminder list response printed ");

        // Check if the response is a string, then decode it to a Map
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        return ReminderListModel.fromJson(responseData);
      } else {
        print(response.statusMessage);
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to load data');
    }
  }

  Future<ReminderListModel?> reminderListApi(date,pagecount) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
    };
    var data = {
      'reminder_filter': '1',
       'date': date,
       'page': pagecount
      //'page': '1'

       //'date': '2023-12-11'
    };
    var dio = Dio();

    try {
      var response = await dio.post(
       //'https://admissionguidanceindia.com/appdata/webservice.php',
        BASEURL.DOMAIN_PATH,
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        print(response.data);
        print("Reminder list response printed ");

        // Check if the response is a string, then decode it to a Map
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        return ReminderListModel.fromJson(responseData);
      } else {
        print(response.statusMessage);
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to load data');
    }
  }

  Future<ReminderTypeModel?> ReminderTypeApi() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=30ead7cbd26e9fcee6465b06417e7aba'
    };
    var data = {
      'reminder_type': '1'
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
      //print(json.encode(response.data));

      var responseData = response.data is String
          ? json.decode(response.data)
          : response.data;

      print("Reminder type print ${responseData}");

      return ReminderTypeModel.fromJson(responseData);
    }

    else {
      print(response.statusMessage);
    }
  }
}