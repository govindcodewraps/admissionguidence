import 'dart:convert';
import 'dart:ui';

import 'package:admissionguidence/my_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/AccountNameNumberModel.dart';
import '../../models/PaymentListModel.dart';
import '../../models/Time_slot_model.dart';
import '../../models/TodayBalanceModel.dart';

class AccountdetailsScreen extends StatefulWidget {
  @override
  _AccountdetailsScreenState createState() => _AccountdetailsScreenState();
}

class _AccountdetailsScreenState extends State<AccountdetailsScreen> {
  TextEditingController _amountcontroller = TextEditingController();
  var valu;
  String selectedValue = 'Transaction Type';
  List<String> options = ['Transaction Type', 'CR', 'DR',];

  String selectedtransactiontype = 'all';
  List<String> optionslist = ['all', 'CR', 'DR',];
  var transationtypevalue='';

  var accountNumber='';
  var transationtype='';

  String accountselectedValue = 'Select Account Number';
   @override
  void initState() {
    // TODO: implement initState
     accountNameNumberApi();
     paymentlistapi();
     todaybalanceApi();
     accountNameNumberwidget();
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


  @override
  Widget build(BuildContext context) {





    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
                Text('  Account Details'),
              ],
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Balance History',
                ),
                Tab(
                  text: 'New Transaction',
                ),
              ],
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(fontSize: 16),
            ),
            backgroundColor: MyTheme.backgroundcolor,
          ),
          body: TabBarView(
            children: [
              Center(
                child: balancewidget(),
              ),
              Center(
                child: Transactionwidget(context),
              ),
            ],
          ),
        ),
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
            todaybalancelistwidget(),
            SizedBox(height: 10,),

            // Text("Govindd"),
            // if(selectedtransactiontype == "CR")
            //   Text("creadet cart"),
            // if(selectedtransactiontype == "DR")
            //   Text("DR cart"),
            // if(selectedtransactiontype == "Transaction Type")
            //   Text("Transaction Type"),


            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),  // Set the color of the border
                borderRadius: BorderRadius.circular(12), // Set the border radius
              ),
              child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Transaction Type: "),
                  SizedBox(width: 10,),
                  Row(
                    children: [
                      DropdownButton<String>(

                        value: selectedtransactiontype,
                        onChanged: (newValue) {
                          setState(() {
                            selectedtransactiontype = newValue!;
                            transationtypevalue=newValue;
                            print("Transation type ${newValue}");
                          });
                        },
                        underline: Container(),
                        items: optionslist.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ),
                      SizedBox(width: 15,),
                    ],
                  ),
                  //SizedBox(width: 1,),
                ],
              ),
            ),
            SizedBox(height: 10,),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //MMM
                   // todaybalancelistwidget(),
                    SizedBox(height: 10,),
                    paymentlistwidget(),
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

  Widget Transactionwidget(context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            //color: Colors.yellow,

            image: DecorationImage(

              image: AssetImage('assets/background.jpg'), // Replace with your image asset path
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.only(left: 16, right: 16, top: 20),
          child:BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY:6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Number : ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10,),
                accountNameNumberwidget(),
                SizedBox(height: 15,),
               // Text(valu),
                //SizedBox(height: 15,),

                Text(
                  "Transaction Type: ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),  // Set the color of the border
                    borderRadius: BorderRadius.circular(12), // Set the border radius
                  ),
                  child: DropdownButton<String>(

                    value: selectedValue,
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                        transationtype=newValue;
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

               // if(selectedValue == "CR")
               //   Text("creadet cart"),
               //  if(selectedValue == "DR")
               //    Text("DR cart"),
               //  if(selectedValue == "Transaction Type")
               //    Text("Transaction Type"),





              //  timeslotwidget(),

              ],
            ),
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          bottom: 10,
          child: SizedBox(
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

                print("Print Amount Controoler ${_amountcontroller.text}");
                print("Print Transaction Type ${selectedValue}");



                print("account number name ${accountNumber}");
                print("account type      ${transationtype}");

                addpaymentapi(_amountcontroller.text,transationtype,accountNumber);
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
        ),
      ],
    );
  }



  Widget accountNameNumberwidget() {
    return FutureBuilder(
      future: accountNameNumberApi(),
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
                  //width: MediaQuery.of(context).size.width*0.5,
                  padding: EdgeInsets.only(left: 16,right: 11),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),  // Set the color of the border
                    borderRadius: BorderRadius.circular(12), // Set the border radius
                  ),
                  child:

                  DropdownButton<String>(
                    value: accountselectedValue,
                    onChanged: (newValue) {
                      setState(() {
                        accountselectedValue = newValue!;
                        accountNumber=newValue;
                        print("Account Number ${newValue}");
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



  Future<AccountNameNumberModel?> accountNameNumberApi() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      'account_list': '1',
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
      return AccountNameNumberModel.fromJson(responseData);
    }
    else {
      print(response.statusMessage);
    }
  }


  Widget paymentlistwidget() {
    return FutureBuilder(
      future: paymentlistapi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        // else if (snapshot.hasError) {
        //   return Container(
        //     child: Center(
        //       child: Text('Error: Internal error'),
        //     ),
        //   );
        // }
        else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
          return Container(
            child: Center(
              child: Text('No data available.'),
            ),
          );
        } else {
          return  ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Transaction Type : "),
                                  SizedBox(width: 5,),
                                  // Text(snapshot.data!.data![index]
                                  //     .type.toString()),

                                  if(snapshot.data!.data![index].type.toString() == "Cr" || snapshot.data!.data![index].type.toString() == "CR")
                                   Text("Credit",style:TextStyle(color: Colors.black),),
                                  if(snapshot.data!.data![index].type.toString()=="Dr" || snapshot.data!.data![index].type.toString()=="DR")
                                  Text("Debit",style: TextStyle(color: Colors.black),),
                                ],
                              ),

                              if(snapshot.data!.data![index].type.toString() == "Cr" || snapshot.data!.data![index].type.toString() == "CR")
                                Icon(Icons.arrow_circle_left_outlined,color: Colors.green,),
                              if(snapshot.data!.data![index].type.toString()=="Dr" || snapshot.data!.data![index].type.toString()=="DR")
                              //Icon(Icons.arrow_upward_outlined,color: Colors.red,),
                              Icon(Icons.arrow_circle_right_outlined,color: Colors.red,),



                            ],
                          ),

                          Row(
                            children: [
                              Text("Amount :"),
                              SizedBox(width: MediaQuery.of(context).size.width*0.180,),
                              if(snapshot.data!.data![index].type.toString() == "Cr" || snapshot.data!.data![index].type.toString() == "CR")
                                Text("+₹${snapshot.data!.data![index].amount.toString()}",style: TextStyle(color: Colors.green),),
                              if(snapshot.data!.data![index].type.toString()=="Dr" || snapshot.data!.data![index].type.toString()=="DR")
                                Text("-₹${snapshot.data!.data![index].amount.toString()}",style: TextStyle(color: Colors.red),),

                             // Text("₹${snapshot.data!.data![index].amount.toString()}"),

                            ],
                          ),
                          Row(
                            children: [
                              Text("Old Balance:   "),
                              SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                              Text("₹${snapshot.data!.data![index].oldBalance.toString()}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("New Balance :"),
                              SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                              Text("₹${snapshot.data!.data![index].newBalance.toString()}"),
                            ],
                          ),

                          Row(
                            children: [
                              Text("Bank Name :   "),
                              SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                              Flexible(child: Text(snapshot.data!.data![index].bankName.toString())),
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
            itemCount: snapshot.data!.data!.length,
          );
        }
      },
    );
  }

  Widget todaybalancelistwidget() {
    return FutureBuilder(
      future: todaybalanceApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()
          );
        } else if (snapshot.hasError) {
          return Text('Error: Internal error');
        }
        // else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
        //   return Container(
        //     child: Center(
        //       child: Text('No data available.'),
        //     ),
        //   );
        // }
        else {
          return  ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, int index) {
              return

                InkWell(
                  onTap: (){
                    print("govind kkk");
                  },
                  child:  Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.23,right: MediaQuery.of(context).size.width*0.23),
                    height: 60,
                    //width: MediaQuery.of(context).size.width*0.1,
                    //color: Colors.red,
                    child:    Container(

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
                        padding: EdgeInsets.only(left: 7,right: 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 1,),
                            Row(
                              children: [
                                Text("Balance ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
                                SizedBox(width: 7,),
                                Text("+₹${snapshot.requireData!.data.toString()}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.green),),
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  )

                );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 16);
            },
            itemCount:1,
          );
        }
      },
    );
  }

  Future addpaymentapi(_amount,_type,_bankid) async{
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      'add_payment': '1',
      'amount': _amount,
      'type': _type,
      'bank_id': _bankid

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
      Fluttertoast.showToast(
        msg: "Payments Added Successful Submit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      print(json.encode(response.data));
      //Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AccountdetailsScreen()));


    }
    else {
      print(response.statusMessage);
    }
  }

  Future<PaymentListModel?> paymentlistapi() async{
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      'payment_filter': '1',
      'type': selectedtransactiontype
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
      print("payment list ");
      print(responseData);
      print("payment list");
      //optionss=responseData;
      return PaymentListModel.fromJson(responseData);
    }
    else {
      print(response.statusMessage);
    }

  }

  Future<TodayBalanceModel?> todaybalanceApi() async{
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      'today_balance': '1'
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
      print("today balance ");
      print(responseData);
      print("today balance");
      //optionss=responseData;
      return TodayBalanceModel.fromJson(responseData);

    }
    else {
      print(response.statusMessage);
    }
  }


}
