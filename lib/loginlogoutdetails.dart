
import 'dart:convert';
import 'dart:ui';
import 'package:admissionguidence/Screens/Home_Screen.dart';
import 'package:admissionguidence/USER_Screens/User_Home_Screen.dart';
import 'package:admissionguidence/my_theme.dart';
import 'package:admissionguidence/usermodel/logindetailsmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Screens/loginscreen.dart';


class loginlogoutdetails extends StatefulWidget {
  @override
  _loginlogoutdetailsState createState() => _loginlogoutdetailsState();
}

class _loginlogoutdetailsState extends State<loginlogoutdetails> {

  @override
  void initState() {
    // TODO: implement initState
    logindetailslist();
    super.initState();
  }


  String formatAccountNumber(String accountNumber) {
    String alphabeticPart = accountNumber.replaceAll(RegExp(r'[0-9]'), '');
    String numericPart = accountNumber.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericPart.length >= 4) {
      String lastFourDigits = numericPart.substring(numericPart.length - 4);
      String maskedNumber = '*' * (numericPart.length - 4) + lastFourDigits;
      return '$alphabeticPart  $maskedNumber';
    } else {
      // Handle cases where the numeric part is less than 4 digits
      return '$alphabeticPart - $numericPart';
    }
  }

  bool showMore = false;



  // NEW TRANSATION
  bool _isLoading = false;

  String selectedValue = 'Transaction Type';
  List<String> options = ['Transaction Type', 'CR', 'DR',];

  TextEditingController _amountcontroller = TextEditingController();
  TextEditingController _remarkcontroller = TextEditingController();

  var accountNumber=" ";
  var transationtype="";
  String accountselectedValue = 'Select Account Number';




  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child:
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  InkWell(
                    onTap: () {

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserHomeScreen()));
                      //Navigator.pop(context, true);
                      //Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Text('  Login Details'),
                ],
              ),
              backgroundColor: MyTheme.backgroundcolor,
            ),
            body:
                   balancewidget(),

         )
        )
      ),
    );
  }

  Widget balancewidget() {
    return
      Container(
        decoration: BoxDecoration(
          // color: Colors.yellow,

          image: DecorationImage(

            image: AssetImage('assets/background.jpg'), // Replace with your image asset path
            fit: BoxFit.fill,
          ),
        ),
        padding:  EdgeInsets.only(left: 16,right: 16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY:4),
          child: Column(
            children: [
              SizedBox(height: 10,),
              // todaybalancelistwidget(),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      paymentlistwidgettt(),

                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }



  Widget paymentlistwidgettt() {
    return FutureBuilder(
      future: logindetailslist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        else if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text('No Transaction Found !'),
            ),
          );
        }

        else {

          return  Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                reverse: true,
                itemBuilder: (context, int index) {
                  return

                    InkWell(
                      onTap: (){
                        print("govind kkk");

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [

                              Row(
                                children: [
                                  Text("Login Date: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                  //SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                                  //Text("${snapshot.data!.data![index].loginDate.toString()}"),
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(snapshot.data!.data![index].loginDate),
                                  )
                                ],
                              ),

                              Row(
                                children: [
                                  Text("Login Time: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                  //SizedBox(width: MediaQuery.of(context).size.width*0.180,),
                                  Text("${snapshot.data!.data[index].loginTime.toString()}"),

                                ],
                              ),
                              Row(
                                children: [
                                  Text("Logout Time: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                  //SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                                  Text("${snapshot.data!.data![index].logoutTime ??""}"),
                                ],
                              ),





                            ],
                          ),
                        ),
                      ),
                    );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16);
                },
                itemCount: snapshot.data!.data.length,
              ),
            ],
          );
        }
      },
    );
  }



  //LogindetailsModel




  Future<LogindetailsModel?> logindetailslist() async {
    var dio = Dio();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=islv5lvuqil9bhmas8d10o8kgb'
    };

    try {
      var response = await dio.post(
        'https://admissionguidanceindia.com/appdata/task.php',
        data: {
          'LoginLlist': '1',
          'user_id': gobaluseridd.toString()
        },
        options: Options(headers: headers),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;
        return LogindetailsModel.fromJson(responseData);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed with error: $e');
    }
  }




}