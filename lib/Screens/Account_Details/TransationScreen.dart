import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../baseurl.dart';
import '../../models/AccountNameNumberModel.dart';
import '../../my_theme.dart';
import 'AccountScreen.dart';

class Transation_Screen extends StatefulWidget {
  const Transation_Screen({super.key});

  @override
  State<Transation_Screen> createState() => _Transation_ScreenState();
}

class _Transation_ScreenState extends State<Transation_Screen> {

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
    return Scaffold(body: Container(




        // height: MediaQuery.of(context).size.height*1,
        height: MediaQuery.of(context).size.height*1,
        decoration: BoxDecoration(
          //color: Colors.yellow,
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Replace with your image asset path
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        child:BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY:6),
          child: Column(
            children: [
              Expanded(child: SingleChildScrollView(child: Transactionwidget())),

              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * 1,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: MyTheme.backgroundcolor),
                      ),
                    ),
                  ),
                  onPressed: () {


                    if (_amountcontroller.text.isEmpty ||
                        _remarkcontroller.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please fill in all fields",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else
                    {

                      print("Print Amount Controoler:${_amountcontroller.text}");
                      //  print("Print Transaction Type:${transationtype}");
                      //print("account number name:${accountNumber}");
                      print("account type:${_remarkcontroller.text}");

                      var AMOUNTVAR =_amountcontroller.text;
                      var TRANSACTIONTYPEVAR =selectedValue;
                      //var ACCOUNTNUMVAR =accountNumber!;
                      var ACCOUNTNUMVAR =accountselectedValue!;
                      var REMARKVAR =_remarkcontroller.text;

                      print(":::::::::::::::::::::::::::::::::");
                      print("AMOUNT ${AMOUNTVAR}");
                      print("TRANSATCTION ${TRANSACTIONTYPEVAR}");
                      print("ACCOUNT NUM ${ACCOUNTNUMVAR}");
                      print("REMARK ${REMARKVAR}");
                      print(":::::::::::::::::::::::::::::::::");
                      // _timeslotid
                      addpaymentapi(AMOUNTVAR,TRANSACTIONTYPEVAR,ACCOUNTNUMVAR,REMARKVAR);
                    }


                    //addpaymentapi(_amountcontroller.text,transationtype,accountNumber,_remarkcontroller.text);
                    //_amount,_type,_bankid
                    // Add the logic for the button press here
                  },
                  child: Text(
                    "Pay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 10,),
            ],),


      ),




    ),);
  }

  Widget Transactionwidget() {
    return SingleChildScrollView(
      child:

      Column(
        children: [
          Center(
            child: _isLoading
                ? CircularProgressIndicator() // Show the circular progress indicator
                :
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Amount : ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Enter Amount",
                    filled: true,
                    isDense: true,
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),



                SizedBox(height: 15,),
                // Text(valu),
                //SizedBox(height: 15,),

                Text(
                  "Transaction Type: ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width*0.98,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),  // Set the color of the border
                    borderRadius: BorderRadius.circular(12), // Set the border radius
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,

                    value: selectedValue,
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                        //  transationtype=newValue;
                        print("Transation type ${newValue}");
                      });
                    },
                    underline: Container(),
                    items: options.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10,),


                Text(
                  "Account Number : ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10,),
                accountNumberWidget(),

                SizedBox(height: 10,),
                Text(
                  "Remark : ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 15,),
                TextField(
                  maxLines: 4,
                  controller: _remarkcontroller,
                  //keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Type Remark",
                    filled: true,
                    isDense: true,
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                // SizedBox(height: 100,),




              ],
            ),

          ),

        ],
      ),
    );
  }

  Widget accountNumberWidget() {
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
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Container(
            // padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [

                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  padding: EdgeInsets.only(left: 16,right: 11),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),  // Set the color of the border
                    borderRadius: BorderRadius.circular(12), // Set the border radius
                  ),
                  child:

                  DropdownButton<String>(
                    isExpanded: true,

                    value: accountselectedValue,
                    onChanged: (newValue) {
                      setState(() {
                        accountselectedValue = newValue!;
                        // remindertypeid=newValue;
                        print("Account Number ${newValue}");
                        print("Account Numberasa ${accountselectedValue}");
                        //print("Account Number id ${remindertypeid}");
                      });
                    },
                    underline: Container(),
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Select Account Number',
                        child: Text('Select Account Number'),
                      ),
                      ...snapshot.data!.data!.map((datum) {
                        return DropdownMenuItem<String>(
                          value: datum.id!,
                          // child: Text("${(datum.type!)}"),
                          child: Text("${formatAccountNumber(datum.type!)}"),
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

  Future<AccountNameNumberModel?> remindertypeAPI() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      //'reminder_type': '1',
      'account_list': '1'
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


      var responseData = response.data is String
          ? json.decode(response.data)
          : response.data;
      print("Account numberrr");
      print(responseData);
      print("Account numberrr");
      //optionss=responseData;
      return AccountNameNumberModel.fromJson(responseData);
    }
    else {
      print(response.statusMessage);
    }
  }

  Future addpaymentapi(amountt,typee,bankidd,remarkk) async{
    setState(() {
      _isLoading = true;
    });

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      'add_payment': '1',
      'amount': amountt,
      'type': typee,
      'bank_id': bankidd,
      'remark': remarkk

      // 'add_payment': '1',
      // 'amount': '100',
      // 'type': 'CR',
      // 'bank_id': '1',
      // 'remark': 'DR'


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
      Fluttertoast.showToast(
        msg: "Payment Successfully Submitted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      print(json.encode(response.data));
       //Navigator.pop(context, true);
      //Navigator.pop(context);
      _amountcontroller.clear();
      _remarkcontroller.clear();
      transationtype = "";
      accountNumber = "";
      //options="Transaction Type" as List<String>;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AccountdetailsScreen()));


    }
    else {
      print(response.statusMessage);
      print("Error");
    }
    setState(() {
      _isLoading = false;
    });

  }

}
