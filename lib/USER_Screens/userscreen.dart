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
  DateTime  date = DateTime.now();

  String? date1;
  String? date2;
  String? _taskid;
  String? Timeeee;

  String? typeValue;
  var items = [
    "no choice",
    "weekly",
    'monthly',
    "daily"
  ];

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

  Future<void> _calculateTimeDifference() async {
    final currentTime = DateTime.now();
    final targetTime = DateTime(currentTime.year, currentTime.month, currentTime.day, 16, 15); // 4:15 PM
    final tenMinutesBeforeTarget = targetTime.subtract(Duration(minutes: 14));

    if (currentTime.isAfter(tenMinutesBeforeTarget)) {
      setState(() {
        _isButtonEnabled = true;
      });
    } else {
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }




  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _calculateTimeDifference();

    print("Govind hhhhhhhhh");
    print(finalEmail);
    print("Userrrrrrrr;;;  ${useriid}");
   // _admissionController.getTasksList();
  }





  void filterListByType(String type) {
    setState(() {
      filterType = type;
      filteredTypeList = listdata!.data
          .where((element) => element.type.contains(filterType))
          .toList();
    });
  }

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
                    padding:  EdgeInsets.all(5.0),
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
                              date1 = date.toString().split(" ")[0];
                            });

                            print(date1);
                            print("1111111111");
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

                        // Center(
                        //   child: ElevatedButton(
                        //     onPressed: _isButtonEnabled ? () {
                        //       // Button logic
                        //     } : null,
                        //     child: Text('Your Button'),
                        //   ),
                        // ),
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
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
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
                        _taskid= snapshot.data!.data![index].id.toString();

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
                              child:
                              Container(
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
                                              'Task Name: ',
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



                                      SizedBox(
                                        height: 10,
                                      ),


                                        Row(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 0.0),
                                            child: Text(
                                              'Task Time : ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                                            child: Text(
                                              _formatTime(snapshot.data!.data![index].taskTime),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],),



                                      if(snapshot.data!.data![index].status==1)
                                      Row(
                                        children: [
                                          // Text(DateFormat("hh:mm").parse(snapshot.data!.data![index].taskTime) as String),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 10.0),
                                            child: Text(
                                              'Submission Time: ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 10.0),
                                            child: Text(
                                              snapshot.data!.data![index].submissionTime
                                                  .toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),

                                        ],
                                      ),





                                      SizedBox(
                                        height: 10,
                                      ),

                                      if(snapshot.data!.data![index].status==0)
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: isSelected,
                                            onChanged: (bool? value) {
                                              setState(() {

                                                final currentTime = DateTime.now();
                                                final targetTime = DateTime(currentTime.year, currentTime.month, currentTime.day, 16, 40); // 4:15 PM
                                               // final targetTime = DateTime(currentTime.year, currentTime.month, currentTime.day, 16, 40); // 4:15 PM
                                                final tenMinutesBeforeTarget = targetTime.subtract(Duration(minutes: 1));

                                                if (currentTime.isAfter(tenMinutesBeforeTarget)) {
                                                  setState(() {
                                                    _isButtonEnabled = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _isButtonEnabled = false;
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

                                                onPressed: isSelected ? () {
                                                var taskidd= snapshot.data!.data![index].id.toString();
                                                  print(taskidd);
                                                  print("Hello QWERT");

                                                var submissiontime =DateFormat.jm().format(DateTime.now());

                                                print(submissiontime);
                                                alltasksubmit(taskidd,submissiontime);

                                               //   print(_taskid);

                                                  // Add your submit logic here
                                                } : null,

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
                                      if(snapshot.data!.data![index].status==1)
                                        Center(child: Icon(Icons.done_all,color: Colors.green,))


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
                            ));

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


  Future<TaskListModel?> tasklistapi() async {
    var dio = Dio();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=30iojdud9ae6v0038eaojook6m'
    };

    try {
      var response = await dio.post(
        'https://admissionguidanceindia.com/appdata/webservice.php',
        data: {'tasklist': '1', 'user_id': '5','date':date1,'type': typeValue},
        options: Options(headers: headers),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;
        return TaskListModel.fromJson(responseData);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed with error: $e');
    }
  }

}

Future alltasksubmit(taskid,submissiontime) async {
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


