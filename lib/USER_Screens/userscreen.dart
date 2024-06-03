import 'dart:convert';
import 'dart:math';
import 'package:admissionguidence/Screens/loginscreen.dart';
import 'package:admissionguidence/models/NoTaskModel.dart';
import 'package:admissionguidence/usermodel/tasklistmodel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../my_theme.dart';

dynamic intiii=[];

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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

  var items = ["one time", "weekly", 'monthly', "daily"];

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
  bool isloading = true;

  bool _isButtonEnabled = false;

  dynamic givenTaskTime;

  List checkboxList = [];
  bool checkedValue = false;

  // Future<void> _calculateTimeDifference() async {
  //   print("tasktime");
  //   print(givenTaskTime);
  //   final currentTime = DateTime.now();
  //   final targetTime = DateTime(currentTime.year, currentTime.month,
  //       currentTime.day, givenTaskTime); // 4:15 PM
  //
  //   print("tasktime2");
  //   print(givenTaskTime);
  //
  //   // final targetTime = taskTime;
  //   final tenMinutesBeforeTarget = targetTime?.subtract(Duration(minutes: 10));
  //   print("time------");
  //   print(tenMinutesBeforeTarget);
  //
  //   if (currentTime.isAfter(tenMinutesBeforeTarget!)) {
  //     setState(() {
  //       _isButtonEnabled = true;
  //     });
  //   } else {
  //     setState(() {
  //       _isButtonEnabled = false;
  //     });
  //   }
  // }

  DateTime selecteDate = DateTime.now();
  DateFormat formatter = DateFormat("dd-MM-yyyy");
  String? formatted;

  Future<void> _selectedDate(BuildContext context) async {}
  dynamic length;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // _calculateTimeDifference();

    print("Govind hhhhhhhhh");
    print(intiii);
    print("Govind hhhhhhhhh");
    print(finalEmail);
    print("Userrrrrrrr;;;  ${useriid}");
    // _admissionController.getTasksList();
    // print("length");
    // print(length);
    // setState(() {
    //   for(int i=0; i<=length; i++){
    //     checkboxList.add(checkedValue);
    //   }
    // });
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
          "Total Task",
          style: TextStyle(
            color: Colors.white, // Change the text color here
          ),
        ),
      ),
      body: taskliswidget(),
    );
  }
  bool check = false;

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
    return FutureBuilder<TaskListModel?>(
        future: tasklistapi(),
        builder: (context, snapshot) {
          {
            // if (snapshot.connectionState == ConnectionState.waiting){
            //   return Center(child: CircularProgressIndicator());}
            if (snapshot.hasError) {
              print("1 if");
              return const Center(child: Text("No more Meetings"));
            } else if (snapshot.hasData) {
              print("2 if");

              if (snapshot.data != null && snapshot.data!.data != null) {
                print("2 if if");

                return Container(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Filter : ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100));

                                if (snapshot.data == null &&
                                    snapshot.data!.data == null &&
                                    picked != null) {
                                  print("data");
                                } else if (picked != null &&
                                    picked != selecteDate) {
                                  setState(() {
                                    selecteDate = picked;
                                    formatted = formatter.format(selecteDate);
                                    print(formatted);
                                  });
                                }
                              },
                              child: Container(
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue, width: 2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  selecteDate.toString().substring(0, 10),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),

                            // Center(
                            //   child: ElevatedButton(
                            //     onPressed: _isButtonEnabled ? () {
                            //       // Button logic
                            //     } : null,
                            //     child: Text('Your Button'),
                            //   ),
                            // ),
                            const Text(
                              "Type : ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),


                            Container(
                              width: 110,
                              height: 40,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  isDense: true,
                                  isExpanded: true,
                                  iconEnabledColor: Colors.blue,
                                  decoration: InputDecoration(
                                      labelText: "",
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.w400),
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 2)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 2))),
                                  value: typeValue,
                                  onChanged: (value) {
                                    setState(() {
                                      typeValue = value;
                                    });
                                  },
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          reverse: false,
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            //bool buttonClicked = selectedCheckboxIndices.contains(index);
                            bool buttonClicked2 =
                                selectedButtonIndices.contains(index);
                            bool isSelected = selectedCheckboxIndices.contains(index);
                            //bool _isButtonEnabled = selectedCheckboxIndices.contains(index);
                            _taskid = snapshot.data!.data![index].id.toString();
// var task = snapshot.data!
//     .data![index].taskTime.toString().substring(0, 2);
//                             var task2 = snapshot.data!
//                                 .data![index].taskTime.toString().substring(3);
//                             var task3 = snapshot.data!
//                                 .data![index].taskTime;
// print("task----");
// print(task);
//                             print(task2);
//                             print(task3);



                            length = snapshot.data!.data!.length.toString();

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
                                    height: MediaQuery.of(context).size.height *
                                        0.28,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 10.0),
                                              child: Text(
                                                'S. No. : ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, top: 10.0),
                                              child: Text(
                                                snapshot.data!.data![index].sno
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Spacer(),
                                            // InkWell(
                                            //     onTap: (){
                                            //       setState(() {
                                            //         final currentTime =
                                            //         DateTime.now();
                                            //         // final targetTime = DateTime(
                                            //         //     currentTime.year,
                                            //         //     currentTime.month,
                                            //         //     currentTime.day,
                                            //         //     16,
                                            //         //     40); // 4:15 PM
                                            //         final targetTime = DateTime(
                                            //           currentTime.year,
                                            //           currentTime.month,
                                            //           currentTime.day,
                                            //           int.parse(snapshot.data!
                                            //               .data![index].taskTime
                                            //               .toString()
                                            //               .substring(0, 2)),
                                            //           int.parse(snapshot.data!
                                            //               .data![index].taskTime
                                            //               .toString()
                                            //               .substring(3)),
                                            //         ); // 4:15 PM
                                            //         print("targetTime");
                                            //         print(targetTime);
                                            //         final tenMinutesBeforeTarget =
                                            //         targetTime.subtract(
                                            //             const Duration(
                                            //                 minutes: 110));
                                            //         print(
                                            //             "tenMinutesBeforeTarget");
                                            //         print(
                                            //             tenMinutesBeforeTarget);
                                            //
                                            //         if (currentTime.isAfter(
                                            //             tenMinutesBeforeTarget)) {
                                            //           setState(() {
                                            //             _isButtonEnabled = true;
                                            //           });
                                            //         } else {
                                            //           setState(() {
                                            //             _isButtonEnabled =
                                            //             false;
                                            //           });
                                            //         }
                                            //       });
                                            //
                                            //
                                            //
                                            //           },
                                            //     child: Text("dataaaaa")),


                                    // setState(() {
                                    //   final currentTime =
                                    //   DateTime.now();
                                    //   // final targetTime = DateTime(
                                    //   //     currentTime.year,
                                    //   //     currentTime.month,
                                    //   //     currentTime.day,
                                    //   //     16,
                                    //   //     40); // 4:15 PM
                                    //   final targetTime = DateTime(
                                    //     currentTime.year,
                                    //     currentTime.month,
                                    //     currentTime.day,
                                    //     int.parse(snapshot.data!
                                    //         .data![index].taskTime
                                    //         .toString()
                                    //         .substring(0, 2)),
                                    //     int.parse(snapshot.data!
                                    //         .data![index].taskTime
                                    //         .toString()
                                    //         .substring(3)),
                                    //   ); // 4:15 PM
                                    //   print("targetTime");
                                    //   print(targetTime);
                                    //   final tenMinutesBeforeTarget =
                                    //   targetTime.subtract(
                                    //       const Duration(
                                    //           minutes: 10));
                                    //   print(
                                    //       "tenMinutesBeforeTarget");
                                    //   print(
                                    //       tenMinutesBeforeTarget);
                                    //
                                    //   if (currentTime.isAfter(
                                    //       tenMinutesBeforeTarget)) {
                                    //     setState(() {
                                    //       _isButtonEnabled = true;
                                    //     });
                                    //   } else {
                                    //     setState(() {
                                    //       _isButtonEnabled =
                                    //       false;
                                    //     });
                                    //   }
                                    // }



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
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Divider(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            thickness: 1,
                                            height: 2,
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 10.0),
                                              child: Text(
                                                'Task Name : ',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, top: 10.0),
                                              child: Container(
                                                width: 150,
                                                child: Text(
                                                  snapshot.data!.data![index]
                                                      .taskName
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
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
                                        /*
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0, top: 10.0),
                                          child: Text(
                                            'Task Submission : ',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, top: 10.0),
                                          child: Text(
                                            snapshot.data!.data![index].taskName
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    */
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 10.0),
                                              child: Text(
                                                'Type of Task : ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, top: 10.0),
                                              child: Text(
                                                snapshot.data!.data![index].type
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 10.0),
                                              child: Text(
                                                'Task Time : ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, top: 10.0),
                                              child: Text(
                                                _formatTime(snapshot.data!
                                                    .data![index].taskTime!),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        if (snapshot
                                                .data!.data![index].status ==
                                            1)
                                          Row(
                                            children: [
                                              // Text(DateFormat("hh:mm").parse(snapshot.data!.data![index].taskTime) as String),

                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0, top: 10.0),
                                                child: Text(
                                                  'Submission Time : ',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, top: 10.0),
                                                child: Text(
                                                  snapshot.data!.data![index]
                                                      .submissionTime
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        const SizedBox(
                                          height: 10,
                                        ),




                                        if (snapshot
                                                .data!.data![index].status ==
                                            0)
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
                                                    }
                                                    else {
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
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Container(
                                                  //width: 80,
                                                  child: ElevatedButton(
                                                    onPressed:
                                                    isSelected &&
                                                        _isButtonEnabled
                                                            ? () {

                                                                var taskidd = snapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString();
                                                                print(taskidd);
                                                                print(
                                                                    "Hello QWERT");

                                                                var submissiontime =
                                                                    DateFormat
                                                                            .jm()
                                                                        .format(
                                                                            DateTime.now());

                                                                print(
                                                                    submissiontime);
                                                                alltasksubmit(
                                                                    taskidd,
                                                                    submissiontime);

                                                                //   print(_taskid);

                                                                // Add your submit logic here
                                                              }

                                                    :null,

                                                    child: Center(
                                                        child: Text(
                                                      'Submit',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
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
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                print("1 else");

                return Center(child: Text("No data available"));
              }
            } else {
              print("2 else");

              // return Center(child: CircularProgressIndicator());
              return Center(child: Text("No Meetings"));
            }
          }
        });
  }

  Future<TaskListModel?> tasklistapi() async {
    var dio = Dio();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=30iojdud9ae6v0038eaojook6m'
    };
    var data = {
      'tasklist': '1',
      'user_id': '5',
      'date': formatted,
      'type': typeValue
    };
    try {
      var response = await dio.request(
        'https://admissionguidanceindia.com/appdata/webservice.php',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print({
        'tasklist': '1',
        'user_id': '5',
        'date': formatted,
        'type': typeValue
      }.toString());
      var responseData;
      if (response.statusCode == 200) {




       // setState(() {
       //   print("AAAAAAAAAAA");
       //   print(intiii);
       //   print("AAAAAAAAAAA");
       // });
        print("11");
        print(response.statusCode);
        responseData = response.data is String
            ? json.decode(response.data)
            : response.data;
        print(response.data);
        // print(responseData['message']);
        final msg = responseData['message'];
        print(msg);
        final success = responseData['success'];
        print(success);
        return TaskListModel.fromJson(responseData);
      }
      // else if (response.statusCode != 200) {
      //   print("22");
      //   print(response.statusCode);
      //
      //   return NoTaskModel.fromJson(responseData);
      // }
      else {
        print("33");
        print(response.statusCode);

        print('Failed with status code: ${response.statusCode}');
        // return NoTaskModel.fromJson(responseData);
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
