import 'dart:convert';

import 'package:admissionguidence/usermodel/tasklistmodel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../my_theme.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Set<int> selectedCheckboxIndices = {};

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
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedCheckboxIndices.contains(index);
                        return Container(
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
        data: {
          'tasklist': '1',
          'user_id': '5'
        },
        options: Options(headers: headers),
      );

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
