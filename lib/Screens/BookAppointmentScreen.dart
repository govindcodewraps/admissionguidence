import 'dart:convert';
import 'dart:ui';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Time_slot_model.dart';
import '../my_theme.dart';

class BookingAppointments extends StatefulWidget {
  const BookingAppointments({super.key});

  @override
  State<BookingAppointments> createState() => _BookingAppointmentsState();
}

class _BookingAppointmentsState extends State<BookingAppointments> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();


  var _timeslotid;
  var selecttime;
  Time _time = Time(hour: 11, minute: 30, second: 20);

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
      selecttime=_time.format(context);
      print("Timmmmee ${selecttime}");

    });
  }

  String selectedValue = 'Select Time';


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, // Change the icon color here
      ),
      backgroundColor: MyTheme.backgroundcolor,
      title: Text(
        "Book Appontments",
        style: TextStyle(
          color: Colors.white, // Change the text color here
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          // Navigate back when back arrow is pressed
          Navigator.pop(context, true);
        },
      ),
    ),
      body:SafeArea(child:
    Container(
      width: double.infinity,
      //color: MyTheme.backgroundcolor,
      decoration: BoxDecoration(
        color: Colors.yellow,

        image: DecorationImage(

          image: AssetImage('assets/background.jpg'), // Replace with your image asset path
          fit: BoxFit.fill,
        ),
      ),

      padding: EdgeInsets.only(left: 16,right: 16,top: 16),
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 4, sigmaY:4),
    child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                    SizedBox(

                      width:MediaQuery.of(context).size.width*0.43,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date"),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  // width: 3,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              labelText: "Date",
                              hintText: 'Date',
                              suffixIcon: Icon(Icons.calendar_month, color: Colors.black),
                            ),
                            controller: dateInputController,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                              );

                              if (pickedDate != null) {
                                dateInputController.text =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);

                                //Fetch time slots for the selected date
                                 await fetchTimeSlots(dateInputController.text);
                              }
                            },
                          ),
                        ],),
                    ),
                    SizedBox(width: 10,),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text("Time"),
                          SizedBox(height: 10,),

                          timeslotwidget(),
                      ],),



                    // SizedBox(
                    //   width:MediaQuery.of(context).size.width*0.43,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Time"),
                    //       SizedBox(height: 10,),
                    //
                    //       TextFormField(
                    //
                    //         decoration:  InputDecoration(
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //             borderSide: BorderSide(
                    //                 width: 3, color: Colors.greenAccent), //<-- SEE HERE
                    //           ),
                    //           // border: InputBorder.none,
                    //           //label: "DOB",
                    //           labelText: _time.format(context),
                    //           hintText: _time.format(context),
                    //           suffixIcon: Icon(Icons.watch_later_outlined,color: Colors.black,),
                    //
                    //         ),
                    //         // controller: dateInputController,
                    //         readOnly: true,
                    //         onTap: () async {
                    //
                    //           //print("Time select  ${_time.format(context)}");
                    //           print("Time selectaa  ${selecttime}");
                    //           Navigator.of(context).push(
                    //             showPicker(
                    //               context: context,
                    //               value: _time,
                    //               sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                    //               sunset: TimeOfDay(hour: 18, minute: 0), // optional
                    //               duskSpanInMinutes: 120, // optional
                    //               onChange: onTimeChanged,
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     ],),
                    // ),



                  ],),
                  SizedBox(height: 10,),
                  Text("Name"),
                  SizedBox(height: 10,),
                  TextField(
                    controller: nameController,
                    // maxLines: 4,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Name",
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  Text("Email"),
                  SizedBox(height: 10,),
                  TextField(
                    controller: emailController,
                    // maxLines: 4,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Email",
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  Text("Contact"),
                  SizedBox(height: 10,),

                  TextField(
                    // maxLines: 4,
                    controller: contactController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Contact",
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                ],),
              ),
            ),
          ),


          SizedBox(height: 10,),
          // Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  alignment: Alignment.center,
                  //width: DeviceInfo(context).width/1,

                  child:
                  SizedBox(
                    height: 40,
                    //width:double.infinity,
                    child: ElevatedButton(

                      style: ButtonStyle(
                          backgroundColor:MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),

                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(12.0),
                                // side: BorderSide()
                              )
                          )
                      ),

                      onPressed: (){




                        // Navigator.push(context,MaterialPageRoute(builder: (context)=>Meeting_record_screen())).then((value){ if(value != null && value)
                        //   {
                        //     setState(() {
                        //       transactionfetchData();
                        //       appoinmentsfetchData();
                        //       reminderfetchData();
                        //       totalAppointmentAPI();
                        //       totalpercentageAPI();
                        //       totalReminderAPI();
                        //     });
                        //   };
                        // });



                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingAppointments()));


                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cancel",
                            // AppLocalizations.of(context).update_password_ucf,
                            style: TextStyle(
                                color:MyTheme.WHITECOLOR,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  alignment: Alignment.center,
                  //width: DeviceInfo(context).width/1,

                  child:
                  SizedBox(
                    height: 40,
                    // width:double.infinity,
                    child: ElevatedButton(

                      style: ButtonStyle(
                          backgroundColor:MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),

                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(12.0),
                                // side: BorderSide()
                              )
                          )
                      ),

                      onPressed: (){
                        // Navigator.push(context,MaterialPageRoute(builder: (context)=>Meeting_record_screen())).then((value){ if(value != null && value)
                        //   {
                        //     setState(() {
                        //       transactionfetchData();
                        //       appoinmentsfetchData();
                        //       reminderfetchData();
                        //       totalAppointmentAPI();
                        //       totalpercentageAPI();
                        //       totalReminderAPI();
                        //     });
                        //   };
                        // });


                        print("Time print ${selecttime}");
                        print("Date print ${dateInputController.text}");
                        print("Name print ${nameController.text}");
                        print("Email print ${emailController.text}");
                        print("Contact print ${contactController.text}");


                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingAppointments()));


                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Submit",
                            // AppLocalizations.of(context).update_password_ucf,
                            style: TextStyle(
                                color:MyTheme.WHITECOLOR,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),),
                  ),
                ),
              ),


            ],),
          SizedBox(height: 20,),


        ],),
    ),),),);
  }



  Widget timeslotwidget() {
    return FutureBuilder(
      future: timeslotlist(dateInputController),
      builder: (context, snapshot) {
        // if
        // (snapshot.connectionState == ConnectionState.waiting) {
        //   return Container(
        //     child: Center(child: CircularProgressIndicator()),
        //   );
        // }
        // // else if (snapshot.hasError) {
        // //   return Container(
        // //     child: Center(
        // //       child: Text('Error: Internal error'),
        // //     ),
        // //   );
        // // }
        // else
        if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        else
        {
          return Container(
            // padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [

                Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  height: 58,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),  // Set the color of the border
                    borderRadius: BorderRadius.circular(12), // Set the border radius
                  ),
                  child:

                  DropdownButton<String>(
                    isExpanded: true,

                    value: selectedValue,
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                        print(newValue);
                        _timeslotid=newValue;
                        print("time slot id print ${_timeslotid}");
                      });
                    },
                    underline: Container(),

                    items: [
                      DropdownMenuItem<String>(

                        value: 'Select Time',
                        child: Text('Select Time'),
                      ),
                      ...snapshot.data!.data!.map((datum) {
                        return DropdownMenuItem<String>(
                          value: datum.id!,
                          child: Text("${datum.slotFrom!}-${datum.slotTo!}"),
                        );
                      }).toList(),
                    ],

                  ),
                ),

                // selectedValue= snapshot.data.data.length;
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> fetchTimeSlots(String selectedDate) async {
    // Call your timeslotlist API with the selected date
    try {
      TimeslotModel? timeslotData = await timeslotlist(selectedDate);
      if (timeslotData != null) {
        // Handle the fetched time slots, if needed
      }
    } catch (error) {
      // Handle any errors that may occur during API call
      print("Error fetching time slots: $error");
    }
  }

  Future<TimeslotModel?> timeslotlist(selectedDate) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      'time_slot': '1',
      'date':"selectedDate"
      //'date': '2023-11-29'
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


      var responseData = response.data is String
          ? json.decode(response.data)
          : response.data;
      print("time slot list");
      print(responseData);
      print("time slot list");

      //optionss=responseData;
      return TimeslotModel.fromJson(responseData);
    }
    else {
      print(response.statusMessage);
    }
  }



}
