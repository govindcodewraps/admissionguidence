// import 'dart:convert';
//
// import 'package:admissionguidence/usermodel/tasklistmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
//
// import '../main.dart';
// import '../my_theme.dart';
// import '../usermodel/TodayTaskModel.dart';
//
// class TodayTaskScreen extends StatefulWidget {
//   const TodayTaskScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TodayTaskScreen> createState() => _TodayTaskScreenState();
// }
//
// class _TodayTaskScreenState extends State<TodayTaskScreen> {
//   //final AdmissionController _admissionController = AdmissionController();
//   Set<int> selectedCheckboxIndices = {};
//   Set<int> selectedButtonIndices = {};
//   DateTime? submitDate;
//   bool isSelected = false;
//   // bool buttonClicked = false;
//   DateTime date = DateTime.now();
//   String? typeValue;
//   TaskListModel? listdata;
//
//   String filterType = '';
//   List filteredTypeList = [];
//   bool isloading = true;
//
//   // TodayTaskModel? allTasks;
//   // getTodayTasks() async {
//   //   try {
//   //     final res = await http.post(
//   //         Uri.parse('https://admissionguidanceindia.com/appdata/task.php'));
//   //     final body = json.decode(res.body);
//   //
//   //     if (res.statusCode == 200) {
//   //       allTasks = TodayTaskModel.fromJson(body);
//   //       isloading = false;
//   //       setState(() {});
//   //     }
//   //   } catch (err) {}
//   // }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //_admissionController.getTasksList();
//   }
//
//   void filterListByType(String type) {
//     setState(() {
//       filterType = type;
//       filteredTypeList = listdata!.data
//           .where((element) => element.type.contains(filterType))
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.white, // Change the icon color here
//         ),
//         backgroundColor: MyTheme.backgroundcolor,
//         title: Text(
//           "Total Task",
//           style: TextStyle(
//             color: Colors.white, // Change the text color here
//           ),
//         ),
//       ),
//       body: taskliswidget(),
//
//     );
//   }
//
//
//
//   Widget taskliswidget() {
//     return FutureBuilder(
//       future: tasklistapi(),
//       builder: (context, snapshot) {
//         print("object");
//
//         // if (snapshot.connectionState == ConnectionState.waiting) {
//         //   return Container(
//         //     child: Center(child: CircularProgressIndicator()),
//         //   );
//         // }
//         if (snapshot.hasError) {
//           return Container(
//             child: Center(child: Text("No More Today Task")),
//           );
//         }
//         else if (snapshot.hasData) {
//           bool showMore = false;
//           if (snapshot.data != null && snapshot.data!= null) {
//             // print(snapshot.data!.length);
//             print("object");
//
//             return
//               Container(
//                 padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Filter : ",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           InkWell(
//                             onTap: () async {
//                               DateTime? newDate = await showDatePicker(
//                                   context: context,
//                                   initialDate: date,
//                                   firstDate: DateTime(1900),
//                                   lastDate: DateTime(2100));
//
//                               if (newDate == null) return;
//
//                               setState(() {
//                                 date = newDate;
//                               });
//                             },
//                             child: Container(
//                               width: 70,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: Colors.blue,
//                                   ),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Center(
//                                   child: Text(
//                                     "Select Date",
//                                     style: TextStyle(
//                                         fontSize: 12, fontWeight: FontWeight.bold),
//                                   )),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "Type : ",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           Container(
//                             width: 120,
//                             height: 60,
//                             child: DropdownButtonFormField(
//                               iconEnabledColor: Colors.blue,
//                               decoration: InputDecoration(
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: BorderSide(color: Colors.blue)),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                       BorderSide(color: Colors.black))),
//                               value: typeValue,
//                               onChanged: (value) {
//                                 setState(() {
//                                   typeValue = value;
//                                 });
//                               },
//                               items: snapshot.data!.data!.map((element) {
//                                 return DropdownMenuItem<String>(
//                                   value: element.type,
//                                   child: Text(
//                                     element.type.toString(),
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: snapshot.data!.data!.length,
//                         itemBuilder: (context, index) {
//                           bool buttonClicked =
//                           selectedCheckboxIndices.contains(index);
//                           bool isSelected = selectedCheckboxIndices.contains(index);
//
//                           bool buttonClicked2 =
//                           selectedButtonIndices.contains(index);
//
//                           return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Card(
//                                 surfaceTintColor: Colors.transparent,
//                                 color: Colors.orange.shade50,
//                                 elevation: 20,
//                                 shape: RoundedRectangleBorder(
//                                   // side: BorderSide(color: Colors.blue, width: 1),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child:
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   height:
//                                   MediaQuery.of(context).size.height * 0.3,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 8.0),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             const Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: 8.0, top: 10.0),
//                                               child: Text(
//                                                 'Task Name : ',
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0, top: 10.0),
//                                               child: Text(
//                                                 snapshot.data!.data![index].id
//                                                     .toString(),
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold),
//                                               ),
//                                             ),
//                                             Spacer(),
//
//                                             Row(
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                   const EdgeInsets.all(
//                                                       8.0),
//                                                   child: Text(
//                                                     DateFormat.jm().format(DateTime.now()),
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                   const EdgeInsets.all(
//                                                       5.0),
//                                                   child: Icon(
//                                                     Icons.verified_user,
//                                                     color: Colors.green,
//                                                   ),
//                                                 )
//                                               ],
//                                             )
//
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding:
//                                           const EdgeInsets.only(top: 10.0),
//                                           child: Divider(
//                                             color: Colors.black.withOpacity(0.7),
//                                             thickness: 1,
//                                             height: 1,
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0, top: 10.0),
//                                               child: Text(
//                                                 'Task Submission : ',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0, top: 10.0),
//                                               child: Text(
//                                                 snapshot
//                                                     .data!.data![index].taskName
//                                                     .toString(),
//                                                 style: TextStyle(fontSize: 16),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0, top: 10.0),
//                                               child: Text(
//                                                 'Type of Task : ',
//                                                 style: TextStyle(fontSize: 16),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0, top: 10.0),
//                                               child: Text(
//                                                 snapshot.data!.data![index].type
//                                                     .toString(),
//                                                 style: TextStyle(fontSize: 16),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             // Text(DateFormat("hh:mm").parse(snapshot.data!.data![index].taskTime) as String),
//
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0, top: 10.0),
//                                               child: Text(
//                                                 'Submission Date : ',
//                                                 style: TextStyle(fontSize: 16),
//                                               ),
//                                             ),
//                                             // Padding(
//                                             //   padding: const EdgeInsets.only(
//                                             //       left: 8.0, top: 10.0),
//                                             //   child: Text(
//                                             //     snapshot
//                                             //         .data!.data![index].taskTime
//                                             //         .toString(),
//                                             //     style: TextStyle(fontSize: 16),
//                                             //   ),
//                                             // ),
//
//
//                                             // Padding(
//                                             //   padding: const EdgeInsets.only(left: 8.0, top: 10.0),
//                                             //   child: Text(
//                                             //     _formatTime(snapshot.data!.data![index].taskTime),
//                                             //     style: TextStyle(fontSize: 16),
//                                             //   ),
//                                             // ),
//
//
//
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 20,
//                                         ),
//
//                                         Row(
//                                           children: [
//                                             Checkbox(
//                                               value: isSelected,
//                                               onChanged: (bool? value) {
//                                                 setState(() {
//
//                                                   final currentTime = DateTime.now();
//                                                   final targetTime = DateTime(currentTime.year, currentTime.month, currentTime.day, 16, 40); // 4:15 PM
//                                                   // final targetTime = DateTime(currentTime.year, currentTime.month, currentTime.day, 16, 40); // 4:15 PM
//                                                   final tenMinutesBeforeTarget = targetTime.subtract(Duration(minutes: 1));
//
//                                                   if (currentTime.isAfter(tenMinutesBeforeTarget)) {
//                                                     setState(() {
//                                                       _isButtonEnabled = true;
//                                                     });
//                                                   } else {
//                                                     setState(() {
//                                                       _isButtonEnabled = false;
//                                                     });
//                                                   }
//
//
//                                                   //isSelected = value!;
//                                                   if (value == true) {
//                                                     selectedCheckboxIndices
//                                                         .add(index);
//                                                   } else {
//                                                     selectedCheckboxIndices
//                                                         .remove(index);
//                                                   }
//                                                 });
//                                               },
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(1.0),
//                                               child: Container(
//                                                 //width: 80,
//                                                 child: ElevatedButton(
//
//                                                   onPressed: isSelected ? () {
//                                                     var taskidd= snapshot.data!.data![index].id.toString();
//                                                     print(taskidd);
//                                                     print("Hello QWERT");
//
//                                                     var submissiontime =DateFormat.jm().format(DateTime.now());
//
//                                                     print(submissiontime);
//                                                     alltasksubmit(taskidd,submissiontime);
//
//                                                     //   print(_taskid);
//
//                                                     // Add your submit logic here
//                                                   } : null,
//
//                                                   child: Center(
//                                                       child: Text(
//                                                         'Submit',
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       )),
//                                                   style:
//                                                   ElevatedButton.styleFrom(
//                                                     backgroundColor:
//                                                     Colors.green,
//                                                   ),
//
//
//
//                                                   //  onPressed:(){
//                                                   //       setState(() {
//                                                   //         buttonClicked =
//                                                   //         true;
//                                                   //         if (buttonClicked ==
//                                                   //             true) {
//                                                   //           selectedCheckboxIndices
//                                                   //               .add(index);
//                                                   //         } else {
//                                                   //           selectedCheckboxIndices
//                                                   //               .remove(
//                                                   //               index);
//                                                   //         }
//                                                   //         tasksubmit();
//                                                   //       }
//                                                   //
//                                                   // );
//                                                   //   }
//
//                                                   // isSelected
//                                                   //     ? ()  {
//                                                   //         setState(() {
//                                                   //           buttonClicked =
//                                                   //               true;
//                                                   //           if (buttonClicked ==
//                                                   //               true) {
//                                                   //             selectedCheckboxIndices
//                                                   //                 .add(index);
//                                                   //           } else {
//                                                   //             selectedCheckboxIndices
//                                                   //                 .remove(
//                                                   //                     index);
//                                                   //           }
//                                                   //           tasksubmit();
//                                                   //         }
//                                                   //         );
//                                                   //       }
//                                                   //     : null
//
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//
//
//                                         // Row(
//                                         //   children: [
//                                         //     Checkbox(
//                                         //       value: isSelected,
//                                         //       onChanged: (bool? value) {
//                                         //         setState(() {
//                                         //           //isSelected = value!;
//                                         //           if (value == true) {
//                                         //             selectedCheckboxIndices.add(index);
//                                         //           } else {
//                                         //             selectedCheckboxIndices.remove(index);
//                                         //           }
//                                         //         });
//                                         //       },
//                                         //     ),
//                                         //     Padding(
//                                         //       padding: const EdgeInsets.all(1.0),
//                                         //       child: Container(
//                                         //         //width: 80,
//                                         //         child: ElevatedButton(
//                                         //           onPressed: _isButtonEnabled ? () {
//                                         //             var taskidd = snapshot.data!.data![index].id.toString();
//                                         //             print(taskidd);
//                                         //             print("Hello QWERT");
//                                         //
//                                         //             var submissiontime = DateFormat.jm().format(DateTime.now());
//                                         //             print(submissiontime);
//                                         //
//                                         //             alltasksubmit(taskidd, submissiontime);
//                                         //
//                                         //             //   print(_taskid);
//                                         //
//                                         //             // Add your submit logic here
//                                         //           } : null,
//                                         //           child: Center(
//                                         //             child: Text(
//                                         //               'Submit',
//                                         //               style: TextStyle(
//                                         //                 color: Colors.white,
//                                         //               ),
//                                         //             ),
//                                         //           ),
//                                         //           style: ElevatedButton.styleFrom(
//                                         //             backgroundColor: _isButtonEnabled ? Colors.green : Colors.grey, // Change button color based on enabled state
//                                         //           ),
//                                         //         ),
//                                         //       ),
//                                         //     ),
//                                         //   ],
//                                         // ),
//
//
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//                               ));
//                           /*
//                           Container(
//                           padding: EdgeInsets.all(8.0),
//                           margin: EdgeInsets.all(8.0),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey, width: 2.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: Center(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text('Task Name'),
//                                         Text('Task Submission'),
//                                         Text('Type of Task'),
//                                         Text('Submission Date'),
//                                       ],
//                                     ),
//                                     SizedBox(width: 10,),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(snapshot.data!.data![index].id.toString()),
//                                         Text(snapshot.data!.data![index].taskName.toString()),
//                                         Text(snapshot.data!.data![index].taskTime.toString()),
//                                         Text(snapshot.data!.data![index].type.toString()),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Checkbox(
//                                       value: isSelected,
//                                       onChanged: (bool? value) {
//                                         setState(() {
//                                           if (value == true) {
//                                             selectedCheckboxIndices.add(index);
//                                           } else {
//                                             selectedCheckboxIndices.remove(index);
//                                           }
//                                         });
//                                       },
//                                     ),
//                                     InkWell(
//                                       onTap: isSelected ? () {
//                                         // Add your submit logic here
//                                       } : null,
//                                       child: Text(
//                                         "Submit",
//                                         style: TextStyle(
//                                           color: isSelected ? Colors.green : Colors.grey,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                         */
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//           } else {
//             return Container(
//               child: Center(child: Text("No data available")),
//             );
//           }
//         } else {
//           return Container(
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }
//       },
//     );
//   }
//
//
//   Future<TodayTaskModel> tasklistapi() async {
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
//     };
//     var data = {
//
//       'todayTask': '1',
//       'user_id': '5'
//
//
//     };
//     var dio = Dio();
//
//     try {
//       var response = await dio.request(
//         'https://admissionguidanceindia.com/appdata/task.php',
//         //'https://www.webcluestechnology.com/php/admissionguidance/appdata/webservice.php',
//         //BASEURL.DOMAIN_PATH,
//         options: Options(
//           method: 'POST',
//           headers: headers,
//         ),
//         data: data,
//       );
//
//       if (response.statusCode == 200) {
//         print(json.encode(response.data));
//         print(response.data);
//         print("print response");
//         // setState(() {});
//         // Check if the response is a string, then decode it to a Map
//         var responseData = response.data is String
//             ? json.decode(response.data)
//             : response.data;
//
//         return TodayTaskModel.fromJson(responseData);
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
// }
//
//
// Future alltasksubmit(taskid,submissiontime) async {
//   var headers = {
//     'accept': 'application/json',
//     'Content-Type': 'application/x-www-form-urlencoded',
//     'Cookie': 'PHPSESSID=8dnvc9nunmrc4ig0995hstfisr'
//   };
//   var data = {
//     'taskSubmit': '1',
//     'user_id': useridd ?? '5',
//     'task_id': taskid,
//     'submission_time': submissiontime
//   };
//   var dio = Dio();
//
//   try {
//     var response = await dio.request(
//       'https://admissionguidanceindia.com/appdata/task.php',
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
//         msg: "Task Successfully Submitted",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } else {
//       print(response.statusMessage);
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }

import 'dart:convert';
import 'package:admissionguidence/Screens/loginscreen.dart';
import 'package:admissionguidence/usermodel/tasklistmodel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../my_theme.dart';
import '../usermodel/TodayTaskModel.dart';

class TodayTaskScreen extends StatefulWidget {
  const TodayTaskScreen({Key? key}) : super(key: key);

  @override
  State<TodayTaskScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<TodayTaskScreen> {
  //final AdmissionController _admissionController = AdmissionController();
  Set<int> selectedCheckboxIndices = {};
  Set<int> selectedButtonIndices = {};
  DateTime? submitDate;
  bool isSelected = false;
  bool isSelectedd = false;
  // bool buttonClicked = false;
  DateTime date = DateTime.now();

  String? date1;
  String? date2;
  String? _taskid;
  String? Timeeee;

  String? typeValue;
  var items = ["no choice", "weekly", 'monthly', "daily"];

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainEmail;
    });
    print("Govind hhhhhhhhhhhhhhhhhhhhhfff");
    print(finalEmail);
  }

  TaskListModel? listdata;

  String filterType = '';
  List filteredTypeList = [];
  bool isloading = true;

  bool _isButtonEnabled = false;

  // Future<void> _calculateTimeDifference() async {
  //   final currentTime = DateTime.now();
  //   final targetTime = DateTime(currentTime.year, currentTime.month,
  //       currentTime.day, 16, 15); // 4:15 PM
  //   final tenMinutesBeforeTarget = targetTime.subtract(Duration(minutes: 14));
  //
  //   if (currentTime.isAfter(tenMinutesBeforeTarget)) {
  //     setState(() {
  //       _isButtonEnabled = true;
  //     });
  //   } else {
  //     setState(() {
  //       _isButtonEnabled = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // _calculateTimeDifference();

    print("Govind hhhhhhhhh");
    print(finalEmail);
    print("Userrrrrrrr;;;  ${useriid}");
    // _admissionController.getTasksList();
  }

  // void filterListByType(String type) {
  //   setState(() {
  //     filterType = type;
  //     filteredTypeList = listdata!.data
  //         .where((element) => element.type.contains(filterType))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change the icon color here
        ),
        backgroundColor: MyTheme.backgroundcolor,
        title: Text(
          "Today Task",
          style: TextStyle(
            color: Colors.white, // Change the text color here
          ),
        ),
      ),
      body: taskliswidget(),
    );
  }

  String _formatTime(String timeString) {
    // Split the time string into hours and minutes
    final parts = timeString.split(':');
    final int hour = int.parse(parts[0]);
    final int minute = int.parse(parts[1]);

    // Create a DateTime object with the current date and specified time
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, hour, minute);

    // Format the DateTime to desired format
    final formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  Widget taskliswidget() {
    return FutureBuilder<TodayTaskModel?>(
      future: tasklistapi(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Center(child: CircularProgressIndicator());
        // }
        if (snapshot.hasError) {
          return Center(child: Text("No more Meetings"));
        } else if (snapshot.hasData) {
          if (snapshot.data != null && snapshot.data!.data != null) {
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding:  EdgeInsets.all(5.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Filter : ",
                  //         style: TextStyle(
                  //             fontSize: 18, fontWeight: FontWeight.bold),
                  //       ),
                  //       InkWell(
                  //         onTap: () async {
                  //           DateTime? newDate = await showDatePicker(
                  //               context: context,
                  //               initialDate: date,
                  //               firstDate: DateTime(1900),
                  //               lastDate: DateTime(2100));
                  //
                  //           if (newDate == null) return;
                  //
                  //           setState(() {
                  //             date = newDate;
                  //             date1 = date.toString().split(" ")[0];
                  //           });
                  //
                  //           print(date1);
                  //           print("1111111111");
                  //         },
                  //         child: Container(
                  //           width: 70,
                  //           height: 50,
                  //           decoration: BoxDecoration(
                  //               border: Border.all(
                  //                 color: Colors.blue,
                  //               ),
                  //               borderRadius: BorderRadius.circular(10)),
                  //           child: Center(
                  //               child: Text(
                  //                 "Select Date",
                  //                 style: TextStyle(
                  //                     fontSize: 12, fontWeight: FontWeight.bold),
                  //               )),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //
                  //       // Center(
                  //       //   child: ElevatedButton(
                  //       //     onPressed: _isButtonEnabled ? () {
                  //       //       // Button logic
                  //       //     } : null,
                  //       //     child: Text('Your Button'),
                  //       //   ),
                  //       // ),
                  //       Text(
                  //         "Type : ",
                  //         style: TextStyle(
                  //             fontSize: 18, fontWeight: FontWeight.bold),
                  //       ),
                  //       Container(
                  //         width: 120,
                  //         height: 60,
                  //         child: DropdownButtonFormField(
                  //           iconEnabledColor: Colors.blue,
                  //           decoration: InputDecoration(
                  //               enabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   borderSide: BorderSide(color: Colors.blue)),
                  //               focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   borderSide:
                  //                   BorderSide(color: Colors.black))),
                  //           value: typeValue,
                  //           onChanged: (value) {
                  //             setState(() {
                  //               typeValue = value;
                  //             });
                  //           },
                  //           items: items.map((String items) {
                  //             return DropdownMenuItem(
                  //               value: items,
                  //               child: Text(items),
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      reverse: false,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        //bool buttonClicked = selectedCheckboxIndices.contains(index);
                        bool buttonClicked2 =
                            selectedButtonIndices.contains(index);
                        bool isSelected =
                            selectedCheckboxIndices.contains(index);
                        _taskid = snapshot.data!.data![index].id.toString();

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            surfaceTintColor: Colors.transparent,
                            color: Colors.white,
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              // side: BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.28,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, top: 10.0),
                                        child: Text(
                                          'Task Name : ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 10.0),
                                        child: Text(
                                          snapshot.data!.data![index].id
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),

                                      // Row(
                                      //   children: [
                                      //     Padding(
                                      //       padding:
                                      //       const EdgeInsets.all(
                                      //           8.0),
                                      //       child: Text(
                                      //         DateFormat.jm().format(DateTime.now()),
                                      //       ),
                                      //     ),
                                      //     Padding(
                                      //       padding:
                                      //       const EdgeInsets.all(
                                      //           5.0),
                                      //       child: Icon(
                                      //         Icons.verified_user,
                                      //         color: Colors.green,
                                      //       ),
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Divider(
                                      color: Colors.black.withOpacity(0.7),
                                      thickness: 1,
                                      height: 1,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 10.0),
                                        child: Text(
                                          'Task Name : ',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 10.0),
                                        child: Text(
                                          snapshot.data!.data![index].taskName
                                              .toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 10.0),
                                        child: Text(
                                          'Type of Task : ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       left: 8.0, top: 10.0),
                                      //   child: Text(
                                      //     snapshot.data!.data![index].type
                                      //         .toString(),
                                      //     style: TextStyle(fontSize: 16),
                                      //   ),
                                      // ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 10.0),
                                        child: Text(
                                          snapshot.data!.data![index].type
                                              .toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      // Text(DateFormat("hh:mm").parse(snapshot.data!.data![index].taskTime) as String),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 10.0),
                                        child: Text(
                                          'Task Time : ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       left: 8.0, top: 10.0),
                                      //   child: Text(
                                      //     snapshot
                                      //         .data!.data![index].taskTime
                                      //         .toString(),
                                      //     style: TextStyle(fontSize: 16),
                                      //   ),
                                      // ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 10.0),
                                        child: Text(
                                          _formatTime(snapshot
                                              .data!.data![index].taskTime
                                              .toString()),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  if (snapshot.data!.data![index].status == 1)
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 1.0),
                                          child: Text(
                                            'Submission Time : ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 1.0),
                                          child: Text(
                                            snapshot.data!.data![index]
                                                .submissionTime
                                                .toString(),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),

                                  SizedBox(
                                    height: 20,
                                  ),

                                  if (snapshot.data!.data![index].status == 0)
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: isSelected ,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              final currentTime =
                                              DateTime.now();
                                              // final targetTime = DateTime(
                                              //     currentTime.year,
                                              //     currentTime.month,
                                              //     currentTime.day,
                                              //     16,
                                              //     40); // 4:15 PM
                                              final targetTime = DateTime(
                                                currentTime.year,
                                                currentTime.month,
                                                currentTime.day,
                                                int.parse(snapshot.data!
                                                    .data![index].taskTime
                                                    .toString()
                                                    .substring(0, 2)),
                                                int.parse(snapshot.data!
                                                    .data![index].taskTime
                                                    .toString()
                                                    .substring(3)),
                                              ); // 4:15 PM
                                              print("targetTime");
                                              print(targetTime);
                                              final tenMinutesBeforeTarget =
                                              targetTime.subtract(
                                                  const Duration(
                                                      minutes: 10));
                                              print(
                                                  "tenMinutesBeforeTarget");
                                              print(
                                                  tenMinutesBeforeTarget);

                                              if (currentTime.isAfter(
                                                  tenMinutesBeforeTarget)) {
                                                setState(() {
                                                  _isButtonEnabled = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _isButtonEnabled =
                                                  false;
                                                });
                                              }

                                              //isSelected = value!;
                                              if (value == true) {
                                                selectedCheckboxIndices
                                                    .add(index);
                                              } else {
                                                selectedCheckboxIndices
                                                    .remove(index);
                                              }
                                            });
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Container(
                                            //width: 80,
                                            child: ElevatedButton(
                                              onPressed:  isSelected &&
                                                  _isButtonEnabled
                                                  ? () {
                                                      var taskidd = snapshot
                                                          .data!.data![index].id
                                                          .toString();
                                                      print(taskidd);
                                                      print("Hello QWERT");

                                                      var submissiontime =
                                                          DateFormat.jm()
                                                              .format(DateTime
                                                                  .now());

                                                      print(submissiontime);
                                                      alltasksubmit(taskidd,
                                                          submissiontime);

                                                      //   print(_taskid);

                                                      // Add your submit logic here
                                                    }
                                                  : null,

                                              child: Center(
                                                  child: Text(
                                                'Submit',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                              ),

                                              //  onPressed:(){
                                              //       setState(() {
                                              //         buttonClicked =
                                              //         true;
                                              //         if (buttonClicked ==
                                              //             true) {
                                              //           selectedCheckboxIndices
                                              //               .add(index);
                                              //         } else {
                                              //           selectedCheckboxIndices
                                              //               .remove(
                                              //               index);
                                              //         }
                                              //         tasksubmit();
                                              //       }
                                              //
                                              // );
                                              //   }

                                              // isSelected
                                              //     ? ()  {
                                              //         setState(() {
                                              //           buttonClicked =
                                              //               true;
                                              //           if (buttonClicked ==
                                              //               true) {
                                              //             selectedCheckboxIndices
                                              //                 .add(index);
                                              //           } else {
                                              //             selectedCheckboxIndices
                                              //                 .remove(
                                              //                     index);
                                              //           }
                                              //           tasksubmit();
                                              //         }
                                              //         );
                                              //       }
                                              //     : null
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (snapshot
                                      .data!.data![index].status ==
                                      1)
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, top: 5.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Task Submitted",
                                            style: TextStyle(
                                                color: Colors.green),
                                          ),
                                          Icon(
                                            Icons.done_all,
                                            color: Colors.green,
                                          ),
                                        ],
                                      ),
                                    )

                                  // Row(
                                  //   children: [
                                  //     Checkbox(
                                  //       value: isSelected,
                                  //       onChanged: (bool? value) {
                                  //         setState(() {
                                  //           //isSelected = value!;
                                  //           if (value == true) {
                                  //             selectedCheckboxIndices.add(index);
                                  //           } else {
                                  //             selectedCheckboxIndices.remove(index);
                                  //           }
                                  //         });
                                  //       },
                                  //     ),
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(1.0),
                                  //       child: Container(
                                  //         //width: 80,
                                  //         child: ElevatedButton(
                                  //           onPressed: _isButtonEnabled ? () {
                                  //             var taskidd = snapshot.data!.data![index].id.toString();
                                  //             print(taskidd);
                                  //             print("Hello QWERT");
                                  //
                                  //             var submissiontime = DateFormat.jm().format(DateTime.now());
                                  //             print(submissiontime);
                                  //
                                  //             alltasksubmit(taskidd, submissiontime);
                                  //
                                  //             //   print(_taskid);
                                  //
                                  //             // Add your submit logic here
                                  //           } : null,
                                  //           child: Center(
                                  //             child: Text(
                                  //               'Submit',
                                  //               style: TextStyle(
                                  //                 color: Colors.white,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           style: ElevatedButton.styleFrom(
                                  //             backgroundColor: _isButtonEnabled ? Colors.green : Colors.grey, // Change button color based on enabled state
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("No data available"));
          }
        } else {
          // return Center(child: CircularProgressIndicator());
          return Center(child: Text("No Meetings"));
        }
      },
    );
  }

  Future<TodayTaskModel?> tasklistapi() async {
    var dio = Dio();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=30iojdud9ae6v0038eaojook6m'
    };

    try {
      var response = await dio.post(
        'https://admissionguidanceindia.com/appdata/task.php',
        data: {'todayTask': '1', 'user_id': '5'},
        options: Options(headers: headers),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;
        return TodayTaskModel.fromJson(responseData);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed with error: $e');
    }
  }
}

Future alltasksubmit(taskid, submissiontime) async {
  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': 'PHPSESSID=8dnvc9nunmrc4ig0995hstfisr'
  };
  var data = {
    'taskSubmit': '1',
    'user_id': useridd ?? '5',
    'task_id': taskid,
    'submission_time': submissiontime
  };
  var dio = Dio();

  try {
    var response = await dio.request(
      'https://admissionguidanceindia.com/appdata/task.php',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      Fluttertoast.showToast(
        msg: "Task Successfully Submitted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      print(response.statusMessage);
    }
  } catch (e) {
    print('Error: $e');
  }
}
