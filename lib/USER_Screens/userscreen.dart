
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
var intiii;
var intii;

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
 // String _PAGECOUNT="1";
  int _PAGECOUNT = 1;
  late int totalPa;
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
  List<String> hours=[];
  List<String> minutes=[];
  List<String> hoursss = [];
  String? hourss ;
  dynamic? hour ;
  dynamic? minutess ;
  //var hour;
  //var minutess;
  //taskDateTime

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
  DateTime selecteDate = DateTime.now();
  DateFormat formatter = DateFormat("dd-MM-yyyy");
  String? formatted;

  Future<void> _selectedDate(BuildContext context) async {}
  dynamic length;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tasklistapi(_PAGECOUNT);
    print("Govind hhhhhhhhh");
    print(intiii);
    print("Govind hhhhhhhhh");
    print(finalEmail);
    //print("Userrrrrrrr;;;  ${useriid}");

  }


  bool isButtonEnabled(String hoursss) {
    final now = DateTime.now();
    final taskDateTime = DateTime(now.year, now.month, now.day,
        int.parse(hoursss.split(":")[0]), int.parse(hoursss.split(":")[1]));
    final timeDifference = taskDateTime.difference(now);
    return timeDifference.inMinutes <= 10 ;
    //return timeDifference.inMinutes <= 10 && timeDifference.inMinutes >= 0;
  }



//18800
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
      future: tasklistapi(_PAGECOUNT),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("No more Meetings"));
        } else if (snapshot.hasData) {
          if (snapshot.data != null && snapshot.data!.data != null) {
            return Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Filter: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            if (picked != null && picked != selecteDate) {
                              setState(() {
                                selecteDate = picked;
                                formatted = formatter.format(selecteDate);
                              });
                            }
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                selecteDate.toString().substring(0, 10),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Type : ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 85,
                          height: 40,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              isDense: true,
                              isExpanded: true,
                              iconEnabledColor: Colors.blue,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                                ),
                              ),
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
                    flex: 1,
                    child: ListView.builder(
                      reverse: false,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        bool buttonClicked2 = selectedButtonIndices.contains(index);
                        bool isSelected = selectedCheckboxIndices.contains(index);
                        _taskid = snapshot.data!.data![index].id.toString();
                        length = snapshot.data!.data!.length.toString();

                        DateTime currentTime = DateTime.now();
                        DateTime taskTime = DateFormat.Hm().parse(snapshot.data!.data![index].taskTime.toString());
                        DateTime tenMinutesBefore = taskTime.subtract(Duration(minutes: 10));

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            surfaceTintColor: Colors.transparent,
                            color: Colors.white,
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                        child: Text(
                                          'Task Name: ',
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                                        child: Container(
                                          width: 150,
                                          child: Text(
                                            snapshot.data!.data![index].taskName.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      //Spacer(),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Divider(
                                      color: Colors.black.withOpacity(0.7),
                                      thickness: 1,
                                      height: 2,
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     const Padding(
                                  //       padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                  //       child: Text(
                                  //         'Task Name : ',
                                  //         style: TextStyle(fontSize: 20),
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                                  //       child: Container(
                                  //         width: 150,
                                  //         child: Text(
                                  //           snapshot.data!.data![index].taskName.toString(),
                                  //           overflow: TextOverflow.ellipsis,
                                  //           style: const TextStyle(fontSize: 20),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Spacer(),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                        child: Text(
                                          'Type of Task : ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                                        child: Text(
                                          snapshot.data!.data![index].type.toString(),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                        child: Text(
                                          'Task Time : ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                                        child: Text(
                                          _formatTime(snapshot.data!.data![index].taskTime!),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                        child: Text(
                                          'Task Date : ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                                        child: Text(
                                          snapshot.data!.data![index].date!.toString().split(' ')[0], // Extracts only the date part
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (snapshot.data!.data![index].status == 1)
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                          child: Text(
                                            'Submission Time : ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                                          child: Text(
                                            snapshot.data!.data![index].submissionTime.toString(),
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 10),


                                  if (snapshot.data!.data![index].status == 0)


                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: ElevatedButton(
                                        onPressed: isButtonEnabled(snapshot.data!.data![index].taskTime.toString())
                                            ? () {
                                          // Handle button press


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


                                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          //   content: Text('Button pressed for task at $hourss'),
                                          // ));
                                        }
                                            : null,
                                        child: Text('Submit'),
                                      ),
                                    ),


                                  if (snapshot.data!.data![index].status == 1)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Task Submitted",
                                            style: TextStyle(color: Colors.green),
                                          ),
                                          Icon(
                                            Icons.done_all,
                                            color: Colors.green,
                                          ),
                                        ],
                                      ),
                                    ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      // snapshot.data!.pagination!.prevPage!.toString()
                      Visibility(
                        visible: _PAGECOUNT > 1, // Show the button only if _PAGECOUNT is greater than 1
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_PAGECOUNT > 1) {
                                _PAGECOUNT--; // Decrease _PAGECOUNT when button is pressed
                                print("page count previous $_PAGECOUNT");
                                // Call your pagination function here with _PAGECOUNT if needed
                                // paymentlistpagination(_PAGECOUNT);
                                // tasklistapi(_PAGECOUNT);
                              } else {
                                print("Already on the first page");
                              }
                            });
                          },
                          child: Text("Previous"),
                        ),
                      ),

                      Spacer(),
                      //if(snapshot.data!.pagination!.nextPage! <= 1)
                     // if(snapshot.data!.pagination!.nextPage! > 1)
                     // if(_PAGECOUNT >= 1)


                      Visibility(
                        visible: _PAGECOUNT < totalPa, // Hide the button when _PAGECOUNT is equal to totalPa
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_PAGECOUNT < totalPa) {
                                _PAGECOUNT++; // Increase _PAGECOUNT when button is pressed
                                print("page count next $_PAGECOUNT");
                                tasklistapi(_PAGECOUNT);
                              } else {
                                print("Already on the last page");
                              }
                            });
                          },
                          child: Text("Next"),
                        ),
                      )


                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No tasks available"));
          }
        }
        return const Center(child: Text("No tasks available"));
      },
    );
  }


  Future<TaskListModel?> tasklistapi(page) async {
    var dio = Dio();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=30iojdud9ae6v0038eaojook6m'
    };
    var data = {
      'tasklist': '1',
      'user_id': gobaluseridd.toString(),
      'date': formatted,
      'type': typeValue,
      'page': page,
      'limit': 5
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

      if (response.statusCode == 200) {
        var responseData = response.data is String ? json.decode(response.data) : response.data;

        print("Response Status: ${response.statusCode}");
        print("Response Data: $responseData");

        final success = responseData['success'];
        print("Success: $success");

        if (success == 1) {
          var total_pages = responseData['total_pages'];
          print("Total Pages: $total_pages");
          totalPa=total_pages;

          List<Datum> tasks = TaskListModel.fromJson(responseData).data ?? [];
          List<String> taskTimes = tasks.map((task) => task.taskTime ?? '').toList();
          // Handle your task data as needed

          return TaskListModel.fromJson(responseData);
        } else {
          print("Failed to fetch tasks: ${responseData['message']}");
          return null;
        }
      } else {
        print("Failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print('Failed with error: $e');
      return null;
    }
  }




  // Future<TaskListModel?> tasklistapi(page) async {
  //   var dio = Dio();
  //
  //   var headers = {
  //     'accept': 'application/json',
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'Cookie': 'PHPSESSID=30iojdud9ae6v0038eaojook6m'
  //   };
  //   var data = {
  //     'tasklist': '1',
  //     'user_id': gobaluseridd.toString(),
  //     'date': formatted,
  //     'type': typeValue,
  //     'page':page,
  //     'limit':5
  //   };
  //   try {
  //     var response = await dio.request(
  //       'https://admissionguidanceindia.com/appdata/webservice.php',
  //       options: Options(
  //         method: 'POST',
  //         headers: headers,
  //       ),
  //       data: data,
  //     );
  //     print({
  //       'tasklist': '1',
  //       'user_id': gobaluseridd.toString(),
  //       'date': formatted,
  //       'type': typeValue
  //     }.toString());
  //
  //     if (response.statusCode == 200) {
  //       print("Response Status: ${response.statusCode}");
  //       print("Response Data: ${response.data}");
  //
  //       var responseData = response.data is String
  //           ? json.decode(response.data)
  //           : response.data;
  //
  //       print(responseData);
  //
  //       final success = responseData['success'];
  //       print("Success: $success");
  //
  //       if (success == 1) {
  //         List<Datum> tasks = TaskListModel.fromJson(responseData).data ?? [];
  //         List<String> taskTimes = tasks.map((task) => task.taskTime ?? '').toList();
  //
  //
  //         print("Task Times: $taskTimes");
  //
  //
  //         hoursss=taskTimes;
  //         print(hoursss);
  //          hourss = hoursss.toString().replaceAll('[', '').replaceAll(']', '');
  //         print("ASDFGHJK ${hourss}");
  //         print("Task Timesll: $hoursss");
  //         //hourss=taskTimes;
  //
  //         // Splitting task times into hours and minutes
  //         List<String> hours = taskTimes.map((time) => time.split(':')[0]).toList();
  //         List<String> minutes = taskTimes.map((time) => time.split(':')[1]).toList();
  //         //  hourss =hours.join(', ');
  //         hour =hours.join(', ');
  //         minutess =minutes.join(', ');
  //
  //         // print("Task Hours: ${hours.join(', ')}");
  //         print("Task Hours: ${hour}");
  //         print("Task minutess: ${minutess}");
  //         //print("Task Minutes: ${minutes.join(', ')}");
  //
  //         print(hourss);
  //
  //
  //         return TaskListModel.fromJson(responseData);
  //       } else {
  //         print("Failed to fetch tasks: ${responseData['message']}");
  //         return null;
  //       }
  //     } else {
  //       print("Failed with status code: ${response.statusCode}");
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Failed with error: $e');
  //     return null;
  //   }
  // }




  Future alltasksubmit(taskid, submissiontime) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8dnvc9nunmrc4ig0995hstfisr'
    };
    var data = {
      'taskSubmit': '1',
      'user_id': gobaluseridd.toString(),
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
        setState(() {
          tasklistapi(_PAGECOUNT);
        });

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




}

