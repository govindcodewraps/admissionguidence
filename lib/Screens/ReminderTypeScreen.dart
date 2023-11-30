import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/ReminderTypeModel.dart';
import '../my_theme.dart';

class ReminderTypesScreen extends StatefulWidget {
  String reminderid;

   ReminderTypesScreen({super.key, required this.reminderid});

  @override
  State<ReminderTypesScreen> createState() => _ReminderTypesScreenState();
}

class _ReminderTypesScreenState extends State<ReminderTypesScreen> {
  int selectedIdx = -1;
  List<String> items = List.generate(10, (index) => 'Item $index');
  bool isLoading = false;


  var Remindertypevalue;
  var ReminderListvalue;

  @override
  void initState() {
    // TODO: implement initState
    ReminderTypeApi();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, // Change the icon color here
          ),
          backgroundColor: MyTheme.backgroundcolor,
          title: Text(
            "Select Reminder Type",
            style: TextStyle(
              color: Colors.white, // Change the text color here
            ),
          ),
        ),
        body:

        SafeArea(
          child: Container(
            padding:EdgeInsets.only(left: 16,right: 16,bottom: 20,top: 30),
            child: Column(
              children: [

                Expanded(
                  flex: 1,
                  child: FutureBuilder(
                    future: ReminderTypeApi(), // Use camelCase for function names
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (snapshot.hasData) {
                        var reminderTypeModel = snapshot.data as ReminderTypeModel;

                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: reminderTypeModel.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIdx = index;
                                  print("IDDDDD");
                                  Remindertypevalue=reminderTypeModel.data![index].id.toString();
                                  print(reminderTypeModel.data![index].id.toString(),);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedIdx == index ? MyTheme.backgroundcolor : Colors.grey,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    reminderTypeModel.data![index].type.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text("No data available"));
                      }
                    },
                  ),
                ),

                // Row(children: [
                //   TextButton(
                //     onPressed: () {
                //       setState(() {
                //         Remindertypevalue = ''; // You can assign any default or empty value
                //       });
                //       Navigator.of(context).pop(); // Close the dialog
                //     },
                //     child: Text('Close'),
                //   ),
                //   TextButton(
                //     onPressed: () {
                //
                //       ReminderListvalue=widget.reminderid;
                //
                //       setreminderapi(ReminderListvalue,Remindertypevalue);
                //     },
                //     child: Text('Save'),
                //   ),
                // ],)


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 45,
                        width:MediaQuery.of(context).size.width*0.4,
                        child:
                        ElevatedButton(

                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(MyTheme.YELLOCOLOR),

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(

                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(color:MyTheme.YELLOCOLOR)
                                  )
                              )
                          ),

                          onPressed: (){
                            Navigator.of(context).pop();
                            //onPressUpdatePassword();
                          },
                          child:Text(
                            "Close",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),),
                      ),
                      SizedBox(
                        height: 45,
                        width:MediaQuery.of(context).size.width*0.4,
                        child:
                      //   ElevatedButton(
                      //
                      //     style: ButtonStyle(
                      //         backgroundColor: MaterialStateProperty.all<Color>(MyTheme.YELLOCOLOR),
                      //
                      //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //             RoundedRectangleBorder(
                      //
                      //                 borderRadius: BorderRadius.circular(12.0),
                      //                 side: BorderSide(color:MyTheme.YELLOCOLOR)
                      //             )
                      //         )
                      //     ),
                      //
                      //     // onPressed: (){
                      //     //
                      //     //         ReminderListvalue=widget.reminderid;
                      //     //         setreminderapi(ReminderListvalue,Remindertypevalue);
                      //     // },
                      //
                      //     onPressed: () {
                      //       if (!isLoading) {
                      //         // Call your API function only if not already loading
                      //         if (Remindertypevalue != null) {
                      //           ReminderListvalue = widget.reminderid;
                      //           setreminderapi(ReminderListvalue, Remindertypevalue);
                      //         } else {
                      //           // Show a message if reminder type is not selected
                      //           Fluttertoast.showToast(
                      //             msg: "Please select a reminder type",
                      //             // Toast properties...
                      //           );
                      //         }
                      //       }
                      //     },
                      //
                      //     child: isLoading
                      //         ? CircularProgressIndicator()  // Show circular progress indicator when loading
                      //         : Text(
                      //       "Save",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      // ),
                        ElevatedButton(
                          // Existing button properties...
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(MyTheme.YELLOCOLOR),

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(

                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(color:MyTheme.YELLOCOLOR)
                                  )
                              )
                          ),
                          onPressed: () {
                            if (!isLoading) {
                              // Call your API function only if not already loading
                              if (Remindertypevalue != null) {
                                ReminderListvalue = widget.reminderid;
                                setreminderapi(ReminderListvalue, Remindertypevalue);
                              } else {
                                // Show a message if reminder type is not selected
                                Fluttertoast.showToast(
                                  msg: "Please select a reminder type",
                                  // Toast properties...
                                );
                              }
                            }
                          },

                          child:
                              // ? CircularProgressIndicator()  // Show circular progress indicator when loading
                              // :
                           Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      )

                        ],)

              ],
            ),
          ),
        ),

      );

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
      'https://admissionguidanceindia.com/appdata/webservice.php',
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

  Future setreminderapi(reminderid,typeid) async{
    setState(() {
      isLoading = true;
    });
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
      'https://admissionguidanceindia.com/appdata/webservice.php',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print("Successfully Set Reminder");
      print(json.encode(response.data));
      Fluttertoast.showToast(
        msg: "Successfully Set Reminder",
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
    setState(() {
    isLoading = false;
    });

  }


}


