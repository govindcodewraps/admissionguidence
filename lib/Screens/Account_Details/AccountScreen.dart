import 'dart:convert';

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
  var accountNumber='';
  var transationtype='';

  String accountselectedValue = 'Select Account Number';
   @override
  void initState() {
    // TODO: implement initState
     accountNameNumberApi();
     paymentlistapi();
     todaybalanceApi();
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
      Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Column(
        children: [
          SizedBox(height: 10,),
          todaybalancelistwidget(),
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
      );
  }

  Widget Transactionwidget(context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // Text(valu),
              //SizedBox(height: 15,),
              Text(
                "Amount : ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10,),
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
              SizedBox(height: 15,),
              Text(
                "Account Number : ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10,),
              accountNameNumberwidget(),
            //  timeslotwidget(),

            ],
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text('Error: Internal error'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
          return Container(
            child: Center(
              child: Text('No data available.'),
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
        } else if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text('Error: Internal error'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
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
                                  Text("Type"),
                                  SizedBox(width: 5,),
                                  Text(snapshot.data!.data![index]
                                      .type.toString()),
                                ],
                              ),

                            ],
                          ),

                          Row(
                            children: [
                              Text("Amount :"),
                              Text(snapshot.data!.data![index].amount.toString()),
                              SizedBox(width: 10,),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Old Balance:"),
                              SizedBox(width: 2,),
                              Text(snapshot.data!.data![index].oldBalance.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              Text("New Balance :"),
                              SizedBox(width: 10,),
                              Text(snapshot.data!.data![index].newBalance.toString()),
                            ],
                          ),

                          Row(
                            children: [
                              Text("Bank Name :"),
                              SizedBox(width: 10,),
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
          return Container(
            child: Center(
               // child: CircularProgressIndicator()
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text('Error: Internal error'),
            ),
          );
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                              Text("Balance :"),
                              SizedBox(width: 10,),
                              Text(snapshot.requireData!.data.toString()),
                            ],
                          ),

                          Row(
                            children: [
                              Text("Message :"),
                              SizedBox(width: 10,),
                              Text(snapshot.requireData!.message.toString()),
                            ]
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
      'payment_list': '1'
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
