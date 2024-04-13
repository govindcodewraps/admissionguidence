
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
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class Reminder_Type_Screen extends StatefulWidget {
  const Reminder_Type_Screen({super.key});

  @override
  State<Reminder_Type_Screen> createState() => _Reminder_Type_ScreenState();
}

class _Reminder_Type_ScreenState extends State<Reminder_Type_Screen> {
  int selectedIdx = 1;
  bool isLoading = false;
  var Remindertypevalue;
  var ReminderListvalue;
  var deletereminderid="";
  bool _isLoading = false;
  //String formattedDate="0";
 // String formattedDatee="0";
  //String formatte='2023-12-12';
  //DateTime? selectedDate;
  String _PAGECOUNT="1";
  String _TYPEID="1";
  String accountselectedValue = 'Select Reminder Type';
  var remindertypeid='';
  int _selectedIndexx = -1;




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

    // formattedDatee = DateFormat('yyyy-MM-dd').format(today);
    // print('Todays only date: $formattedDatee');

    reminderListApi(_TYPEID,_PAGECOUNT);
   // reminderListApi(formattedDatee,_PAGECOUNT);




    ReminderTypeApi();

    super.initState();
  }
  bool showMore = false;



  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());

  DateTime _targetDateTime = DateTime.now();



  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {



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
        body:


        Container(
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

                      reminderTypewidget(),
                      SizedBox(height: 30,),

                      reminderlistwidget(),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),



        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // Handle the "Add Reminder" button tap
        //     //Navigator.push(context, MaterialPageRoute(builder: (context) => AddReminderScreen(),),);
        //
        //     Navigator.push(context,MaterialPageRoute(builder: (context)=>AddReminderScreen())).then((value){ if(value != null && value)
        //     {
        //       setState(() {
        //         // reminderListApi(formattedDatee);
        //         reminderListApi(formattedDatee,_PAGECOUNT);
        //
        //         ReminderTypeApi();
        //       });
        //     };
        //     });
        //   },
        //   backgroundColor: Colors.blue, // Set the FAB background color
        //   child: Icon(Icons.add,size: 20,),
        // ),




      ),
    );
  }



  Widget reminderlistwidget() {
    return
      FutureBuilder(
        future: reminderListApi(_TYPEID,_PAGECOUNT),
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


                                  ],
                                ),




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

                                              reminderListApi(_TYPEID,_PAGECOUNT);
                                              ReminderTypeApi();
                                            });
                                          };
                                          });



                                          // Handle the "Edit Reminder" tap
                                        },
                                        child: Icon(Icons.edit),

                                      ),



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

SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          // snapshot.data!.pagination!.prevPage!.toString()
                          if(snapshot.data!.pagination!.prevPage! >= 1)
                            ElevatedButton(onPressed: (){
                              _PAGECOUNT=snapshot.data!.pagination!.prevPage!.toString();
                              reminderListApi(_TYPEID,_PAGECOUNT);
                              print("page count prev ${_PAGECOUNT}");
                              setState(() {
                                reminderListApi(_TYPEID,_PAGECOUNT);

                              });
                            }, child:Text("Prev")),
                          Spacer(),
                          //if(snapshot.data!.pagination!.nextPage! <= 1)

                          if(snapshot.data!.pagination!.nextPage! > 1)
                            ElevatedButton(onPressed: (){
                              _PAGECOUNT=snapshot.data!.pagination!.nextPage!.toString();

                              reminderListApi(_TYPEID,_PAGECOUNT);
                              print("page count next ${_PAGECOUNT}");
                              setState(() {
                                // paymentlistpagination(_PAGECOUNT);
                                reminderListApi(_TYPEID,_PAGECOUNT);


                              });
                            }, child:Text("Next")),

                        ],
                      ),
                    ),
                    SizedBox(height: 8,),


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
                Navigator.of(context).pop(); // Close the dialog

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
      print(json.encode(response.data));
      print("response ${response.data}");
      Fluttertoast.showToast(
        msg: "Reminder Deleted successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
     // Navigator.pop(context,true);
      //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Reminder_Screen()));
    }
    else {
      print(response.statusMessage);
    }
    setState(() {
      isLoading = true;
    });
  }



  Future<ReminderListModel?> reminderListApi(typee,pagecount) async {

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=8e2678e66318bb5eea7c33540ca4eb4f'
    };
    var data = {
      'reminder_filter': '1',
      //'type_id': typee,
      'page': pagecount,
      'type_id': typee,

      // 'reminder_filter': '1',
      // 'page': '1',
      // 'type_id': typeid

      //   _PAGECOUNT=snapshot.data!.pagination!.prevPage!.toString();
      //     reminderListApi(formattedDatee,_PAGECOUNT);
      //     print("page count prev ${_PAGECOUNT}");
      //     setState(() {
      //       reminderListApi(formattedDatee,_PAGECOUNT);
      //
      //     });

      //'page': '1'

      //'date': '2023-12-11'
    };
    var dio = Dio();

    try {
      var response = await dio.post(
        'https://admissionguidanceindia.com/appdata/webservice.php',
       // BASEURL.DOMAIN_PATH,
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

  Widget reminderTypewidget() {
    return FutureBuilder(

      future: remindertypeAPI(),

      builder: (context, snapshot) {

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Container(
        //     child: Center(child: CircularProgressIndicator()),
        //   );
        // } else if (snapshot.hasError) {
        //   return Container(
        //     child: Center(
        //       child: Text('Error: Internal error'),
        //     ),
        //   );
        // } else

        if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {

          return Container(
            child:
            Center(
              //child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Container(
            // padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(

              children: [

            // Initially no button is selected

            SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  snapshot.data!.data!.length,
                      (index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _PAGECOUNT="1";
                          _selectedIndex = index; // Update the selected index
                          _TYPEID = snapshot.data!.data![index].id.toString();
                          reminderListApi(_TYPEID,_PAGECOUNT);
                        });
                        print('Button ${snapshot.data!.data![index].id.toString()} tapped');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          _selectedIndex == index ? Colors.white : Colors.white54, // Change color based on selection
                        ),
                      ),
                      child: Text(snapshot.data!.data![index].type.toString(),style: TextStyle(color: Colors.blue),),
                    ),
                  ),
                ),
              ),
            ),


              ],
            ),
          );
        }
      },
    );
  }

  Future<ReminderTypeModel?> remindertypeAPI() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      'reminder_type': '1',
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


      var responseData = response.data is String
          ? json.decode(response.data)
          : response.data;
      print("time slot list");
      print(responseData);
      print("time slot list");
      //optionss=responseData;
      return ReminderTypeModel.fromJson(responseData);
    }
    else {
      print(response.statusMessage);
    }
  }


}
