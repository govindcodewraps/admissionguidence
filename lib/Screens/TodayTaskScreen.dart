import 'dart:convert';

import 'package:admissionguidence/controller/AdmissionController.dart';
import 'package:admissionguidence/models/TodayTaskModel.dart';
import 'package:admissionguidence/usermodel/tasklistmodel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../my_theme.dart';

class TodayTaskScreen extends StatefulWidget {
  const TodayTaskScreen({Key? key}) : super(key: key);

  @override
  State<TodayTaskScreen> createState() => _TodayTaskScreenState();
}

class _TodayTaskScreenState extends State<TodayTaskScreen> {
  // final AdmissionController _admissionController = AdmissionController();
  Set<int> selectedCheckboxIndices = {};
  Set<int> selectedButtonIndices = {};
  DateTime? submitDate;
  bool isSelected = false;
  // bool buttonClicked = false;
  DateTime date = DateTime.now();
  String? typeValue;
  TaskListModel? listdata;

  String filterType = '';
  List filteredTypeList = [];
  bool isloading = true;

  TodayTaskModel? allTasks;
  getTodayTasks() async {
    try {
      final res = await http.post(
          Uri.parse('https://admissionguidanceindia.com/appdata/task.php'));
      final body = json.decode(res.body);

      if (res.statusCode == 200) {
        allTasks = TodayTaskModel.fromJson(body);
        isloading = false;
        setState(() {});
      }
    } catch (err) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          "Total Task",
          style: TextStyle(
            color: Colors.white, // Change the text color here
          ),
        ),
      ),
      body: taskliswidget(),
      // Obx((){
      //   print("1---"+_admissionController.admDataLoading.value.toString());
      //   print("2---"+_admissionController.admListData.toString());
      //
      //   if(_admissionController.admDataLoading.value || _admissionController.admListData == null){
      //     return Center(
      //       child:Text("No data"),
      //     );
      //   }
      //   else{
      //     return Column(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 "Filter : ",
      //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //               ),
      //               InkWell(
      //                 onTap: () async {
      //                   DateTime? newDate = await showDatePicker(
      //                       context: context,
      //                       initialDate: date,
      //                       firstDate: DateTime(1900),
      //                       lastDate: DateTime(2100));
      //
      //                   if (newDate == null) return;
      //
      //                   setState(() {
      //                     date = newDate;
      //                   });
      //                 },
      //                 child: Container(
      //                   width: 70,
      //                   height: 50,
      //                   decoration: BoxDecoration(
      //                       border: Border.all(
      //                         color: Colors.blue,
      //                       ),
      //                       borderRadius: BorderRadius.circular(10)),
      //                   child: Center(
      //                       child: Text(
      //                         "Select Date",
      //                         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      //                       )),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: 10,
      //               ),
      //               Text(
      //                 "Type : ",
      //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //               ),
      //               // Container(
      //               //   width: 120,
      //               //   height: 60,
      //               //   child: DropdownButtonFormField(
      //               //     iconEnabledColor: Colors.blue,
      //               //     decoration: InputDecoration(
      //               //         enabledBorder: OutlineInputBorder(
      //               //             borderRadius: BorderRadius.circular(10),
      //               //             borderSide: BorderSide(color: Colors.blue)),
      //               //         focusedBorder: OutlineInputBorder(
      //               //             borderRadius: BorderRadius.circular(10),
      //               //             borderSide: BorderSide(color: Colors.black))),
      //               //     value: typeValue,
      //               //     onChanged: (value) {
      //               //       setState(() {
      //               //         typeValue = value;
      //               //       });
      //               //     },
      //               //     items: allTasks!.data!.map((element) {
      //               //       return DropdownMenuItem<String>(
      //               //         value: element.type,
      //               //         child: Text(
      //               //           element.type.toString(),
      //               //           style: TextStyle(color: Colors.black),
      //               //         ),
      //               //       );
      //               //     }).toList(),
      //               //   ),
      //               // ),
      //             ],
      //           ),
      //         ),
      //         ListView.builder(
      //             itemCount: _admissionController.admListData!.data?.length ?? 0,
      //             itemBuilder: (BuildContext context, int index) {
      //               bool buttonClicked = selectedCheckboxIndices.contains(index);
      //               bool buttonClicked2 = selectedButtonIndices.contains(index);
      //
      //               return Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Card(
      //                     surfaceTintColor: Colors.transparent,
      //                     color: Colors.orange.shade50,
      //                     elevation: 20,
      //                     shape: RoundedRectangleBorder(
      //                       // side: BorderSide(color: Colors.blue, width: 1),
      //                       borderRadius: BorderRadius.circular(10),
      //                     ),
      //                     child: Container(
      //                       width: MediaQuery.of(context).size.width,
      //                       height: MediaQuery.of(context).size.height * 0.3,
      //                       child: Padding(
      //                         padding: const EdgeInsets.only(left: 8.0),
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.start,
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Row(
      //                               children: [
      //                                 const Padding(
      //                                   padding:
      //                                   EdgeInsets.only(left: 8.0, top: 10.0),
      //                                   child: Text(
      //                                     'Task Name : ',
      //                                     style: TextStyle(
      //                                         fontSize: 18,
      //                                         fontWeight: FontWeight.bold),
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       left: 8.0, top: 10.0),
      //                                   child: Text(
      //                                     _admissionController
      //                                         .admListData!.data![index].id
      //                                         .toString(),
      //                                     // snapshot.data!.data![index].id
      //                                     //     .toString(),
      //                                     style: TextStyle(
      //                                         fontSize: 18,
      //                                         fontWeight: FontWeight.bold),
      //                                   ),
      //                                 ),
      //                                 Spacer(),
      //                                 buttonClicked
      //                                     ? Row(
      //                                   children: [
      //                                     Padding(
      //                                       padding: const EdgeInsets.all(8.0),
      //                                       child: Text(
      //                                         DateFormat.jm()
      //                                             .format(DateTime.now()),
      //                                       ),
      //                                     ),
      //                                     Padding(
      //                                       padding: const EdgeInsets.all(5.0),
      //                                       child: Icon(
      //                                         Icons.verified_user,
      //                                         color: Colors.green,
      //                                       ),
      //                                     )
      //                                   ],
      //                                 )
      //                                     : SizedBox()
      //                               ],
      //                             ),
      //                             Padding(
      //                               padding: const EdgeInsets.only(top: 10.0),
      //                               child: Divider(
      //                                 color: Colors.black.withOpacity(0.7),
      //                                 thickness: 1,
      //                                 height: 1,
      //                               ),
      //                             ),
      //                             Row(
      //                               children: [
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       left: 8.0, top: 10.0),
      //                                   child: Text(
      //                                     'Task Submission : ',
      //                                     style: TextStyle(
      //                                       fontSize: 16,
      //                                     ),
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       left: 8.0, top: 10.0),
      //                                   child: Text(
      //                                     // snapshot
      //                                     //     .data!.data![index].taskName
      //                                     //     .toString(),
      //                                     _admissionController
      //                                         .admListData!.data![index].taskName
      //                                         .toString(),
      //                                     style: TextStyle(fontSize: 16),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                             Row(
      //                               children: [
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       left: 8.0, top: 10.0),
      //                                   child: Text(
      //                                     'Type of Task : ',
      //                                     style: TextStyle(fontSize: 16),
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       left: 8.0, top: 10.0),
      //                                   child: Text(
      //                                     // snapshot.data!.data![index].type
      //                                     //     .toString(),
      //                                     _admissionController
      //                                         .admListData!.data![index].type
      //                                         .toString(),
      //                                     style: TextStyle(fontSize: 16),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                             Row(
      //                               children: [
      //                                 // Text(DateFormat("hh:mm").parse(snapshot.data!.data![index].taskTime) as String),
      //
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       left: 8.0, top: 10.0),
      //                                   child: Text(
      //                                     'Submission Date : ',
      //                                     style: TextStyle(fontSize: 16),
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       left: 8.0, top: 10.0),
      //                                   child: Text(
      //                                     // snapshot
      //                                     //     .data!.data![index].taskTime
      //                                     //     .toString(),
      //                                     _admissionController
      //                                         .admListData!.data![index].taskTime
      //                                         .toString(),
      //                                     style: TextStyle(fontSize: 16),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(
      //                               height: 20,
      //                             ),
      //                             Row(
      //                               children: [
      //                                 Checkbox(
      //                                   value: buttonClicked2,
      //                                   onChanged: (bool? value) {
      //                                     setState(() {
      //                                       // isSelected = value!;
      //                                       if (value == true) {
      //                                         selectedCheckboxIndices.add(index);
      //                                       } else {
      //                                         selectedCheckboxIndices.remove(index);
      //                                       }
      //                                     });
      //                                   },
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.all(8.0),
      //                                   child: Container(
      //                                     width: 80,
      //                                     child: ElevatedButton(
      //                                         child: Center(
      //                                             child: Text(
      //                                               'Submit',
      //                                               style: TextStyle(color: Colors.white),
      //                                             )),
      //                                         style: ElevatedButton.styleFrom(
      //                                           backgroundColor: Colors.green,
      //                                         ),
      //                                         onPressed: isSelected
      //                                             ? () {
      //                                           setState(() {
      //                                             buttonClicked = true;
      //                                             if (buttonClicked == true) {
      //                                               selectedCheckboxIndices
      //                                                   .add(index);
      //                                             } else {
      //                                               selectedCheckboxIndices
      //                                                   .remove(index);
      //                                             }
      //                                           });
      //                                         }
      //                                             : null),
      //                                   ),
      //                                 ),
      //                               ],
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   ));
      //             }),
      //       ],
      //     );
      //   }
      // })
    );
  }

  // Widget taskliswidget() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //
  //
  //
  //
  //     ],
  //   );
  // }

  Widget taskliswidget() {
    return FutureBuilder<TodayTaskModel?>(
      future: tasklistapi(),
      builder: (context, snapshot) {
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Filter : ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));

                            if (newDate == null) return;

                            setState(() {
                              date = newDate;
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                                  "Select Date",
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Type : ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 120,
                          height: 60,
                          child: DropdownButtonFormField(
                            iconEnabledColor: Colors.blue,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    BorderSide(color: Colors.black))),
                            value: typeValue,
                            onChanged: (value) {
                              setState(() {
                                typeValue = value;
                              });
                            },
                            items: snapshot.data!.data!.map((element) {
                              return DropdownMenuItem<String>(
                                value: element.type,
                                child: Text(
                                  element.type.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        bool buttonClicked =
                        selectedCheckboxIndices.contains(index);
                        bool buttonClicked2 =
                        selectedButtonIndices.contains(index);

                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              surfaceTintColor: Colors.transparent,
                              color: Colors.orange.shade50,
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                // side: BorderSide(color: Colors.blue, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                MediaQuery.of(context).size.height * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                          buttonClicked
                                              ? Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    8.0),
                                                child: Text(
                                                  DateFormat.jm().format(
                                                      DateTime.now()),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    5.0),
                                                child: Icon(
                                                  Icons.verified_user,
                                                  color: Colors.green,
                                                ),
                                              )
                                            ],
                                          )
                                              : SizedBox()
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 10.0),
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
                                              'Task Submission : ',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 10.0),
                                            child: Text(
                                              snapshot
                                                  .data!.data![index].taskName
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
                                              'Submission Date : ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 10.0),
                                            child: Text(
                                              snapshot
                                                  .data!.data![index].taskTime
                                                  .toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: buttonClicked2,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                // isSelected = value!;
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 80,
                                              child: ElevatedButton(
                                                  child: Center(
                                                      child: Text(
                                                        'Submit',
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      )),
                                                  style:
                                                  ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    Colors.green,
                                                  ),
                                                  onPressed: isSelected
                                                      ? () {
                                                    setState(() {
                                                      buttonClicked =
                                                      true;
                                                      if (buttonClicked ==
                                                          true) {
                                                        selectedCheckboxIndices
                                                            .add(index);
                                                      } else {
                                                        selectedCheckboxIndices
                                                            .remove(
                                                            index);
                                                      }
                                                    });
                                                  }
                                                      : null),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
                        /*
                          Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Task Name'),
                                        Text('Task Submission'),
                                        Text('Type of Task'),
                                        Text('Submission Date'),
                                      ],
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data!.data![index].id.toString()),
                                        Text(snapshot.data!.data![index].taskName.toString()),
                                        Text(snapshot.data!.data![index].taskTime.toString()),
                                        Text(snapshot.data!.data![index].type.toString()),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: isSelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            selectedCheckboxIndices.add(index);
                                          } else {
                                            selectedCheckboxIndices.remove(index);
                                          }
                                        });
                                      },
                                    ),
                                    InkWell(
                                      onTap: isSelected ? () {
                                        // Add your submit logic here
                                      } : null,
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                          color: isSelected ? Colors.green : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                        */
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
          return Center(child: CircularProgressIndicator());
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
