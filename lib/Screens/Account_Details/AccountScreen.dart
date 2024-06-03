// import 'dart:convert';
// import 'dart:ui';
//
// import 'package:admissionguidence/Screens/Account_Details/paginationaccount.dart';
// import 'package:admissionguidence/my_theme.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import '../../models/AccountNameNumberModel.dart';
// import '../../models/PaymentListModel.dart';
// import '../../models/Time_slot_model.dart';
// import '../../models/TodayBalanceModel.dart';
// import '../amounttransaction.dart';
//
// class AccountdetailsScreen extends StatefulWidget {
//   @override
//   _AccountdetailsScreenState createState() => _AccountdetailsScreenState();
// }
//
// class _AccountdetailsScreenState extends State<AccountdetailsScreen> {
//
//   var valu;
//
//
//   String selectedtransactiontype = 'all';
//   List<String> optionslist = ['all', 'CR', 'DR',];
//   var transationtypevalue='';
//
//
//
//  // String accountselectedValue = 'Select Account Number';
//    @override
//   void initState() {
//     // TODO: implement initState
//     // accountNameNumberApi();
//      paymentlistapi();
//      todaybalanceApi();
//     super.initState();
//   }
//
//
//   String formatAccountNumber(String accountNumber) {
//     String alphabeticPart = accountNumber.replaceAll(RegExp(r'[0-9]'), '');
//     String numericPart = accountNumber.replaceAll(RegExp(r'[^0-9]'), '');
//
//     if (numericPart.length >= 4) {
//       String lastFourDigits = numericPart.substring(numericPart.length - 4);
//       String maskedNumber = '*' * (numericPart.length - 4) + lastFourDigits;
//       return '$alphabeticPart  $maskedNumber';
//     } else {
//       // Handle cases where the numeric part is less than 4 digits
//       return '$alphabeticPart - $numericPart';
//     }
//   }
//
//   bool showMore = false;
//
//
//
//    // NEW TRANSATION
//   bool _isLoading = false;
//
//   String selectedValue = 'Transaction Type';
//   List<String> options = ['Transaction Type', 'CR', 'DR',];
//
//   TextEditingController _amountcontroller = TextEditingController();
//   TextEditingController _remarkcontroller = TextEditingController();
//
//   var accountNumber=" ";
//   var transationtype="";
//   String accountselectedValue = 'Select Account Number';
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Icon(Icons.arrow_back),
//                 ),
//                 Text('  Account Details'),
//               ],
//             ),
//             bottom: TabBar(
//               tabs: [
//                 Tab(
//                   text: 'Balance History',
//                 ),
//                 Tab(
//                   text: 'New Transaction',
//                 ),
//               ],
//               labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               unselectedLabelStyle: TextStyle(fontSize: 16),
//             ),
//             backgroundColor: MyTheme.backgroundcolor,
//           ),
//           body: TabBarView(
//             children: [
//               Center(
//                 child: balancewidget(),
//               ),
//               Center(
//                 child: Transactionwidget(),
//               //  child: TransactionAmount(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget balancewidget() {
//     return
//       Container(
//         decoration: BoxDecoration(
//          // color: Colors.yellow,
//
//           image: DecorationImage(
//
//             image: AssetImage('assets/background.jpg'), // Replace with your image asset path
//             fit: BoxFit.fill,
//           ),
//         ),
//         padding:  EdgeInsets.only(left: 16,right: 16),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 4, sigmaY:4),
//           child: Column(
//           children: [
//
//             SizedBox(height: 10,),
//             todaybalancelistwidget(),
//             SizedBox(height: 10,),
//
//             // Text("Govindd"),
//             // if(selectedtransactiontype == "CR")
//             //   Text("creadet cart"),
//             // if(selectedtransactiontype == "DR")
//             //   Text("DR cart"),
//             // if(selectedtransactiontype == "Transaction Type")
//             //   Text("Transaction Type"),
//
//
//             SizedBox(height: 10,),
//             Container(
//               padding: EdgeInsets.only(left: 10),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),  // Set the color of the border
//                 borderRadius: BorderRadius.circular(12), // Set the border radius
//               ),
//               child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Select Transaction Type: "),
//                   SizedBox(width: 10,),
//                   Row(
//                     children: [
//                       DropdownButton<String>(
//
//                         value: selectedtransactiontype,
//                         onChanged: (newValue) {
//                           setState(() {
//                             selectedtransactiontype = newValue!;
//                             transationtypevalue=newValue;
//                             print("Transation type ${newValue}");
//                           });
//                         },
//                         underline: Container(),
//                         items: optionslist.map((option) {
//                           return DropdownMenuItem<String>(
//                             value: option,
//                             child: Text(option),
//                           );
//                         }).toList(),
//                       ),
//                       SizedBox(width: 15,),
//                     ],
//                   ),
//                   //SizedBox(width: 1,),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10,),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     //MMM
//                    // todaybalancelistwidget(),
//                     SizedBox(height: 10,),
//                     paymentlistwidget(),
//                     SizedBox(height: 20,),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//     ),
//         ),
//       );
//   }
//
//
//
//
//
//
//   Widget paymentlistwidget() {
//     return FutureBuilder(
//
//       future: paymentlistapi(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Container(
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }
//         // else if (snapshot.hasError) {
//         //   return Container(
//         //     child: Center(
//         //       child: Text('Error: Internal error'),
//         //     ),
//         //   );
//         // }
//
//         // else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
//         //   return Container(
//         //     child: Center(
//         //       child: Text('No data available.'),
//         //     ),
//         //   );
//         // }
//         else {
//
//           return  ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             reverse: true,
//             itemBuilder: (context, int index) {
//               return
//
//                 InkWell(
//                   onTap: (){
//                     print("govind kkk");
//                     print("Remark: ${snapshot.data!.data![33].amount}");
//                     print("Remark: ${snapshot.data!.data![33].remark}");
//
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white70,
//                       borderRadius: BorderRadius.circular(10.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 4,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Container(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//
//                           Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text("Transaction Type  "),
//                                   SizedBox(width: 5,),
//                                   // Text(snapshot.data!.data![index]
//                                   //     .type.toString()),
//                                  // Text(snapshot.data!.data![index].type.toString(),style:TextStyle(color: Colors.black),),
//                                   if(snapshot.data!.data![index].type.toString() == "CR")
//                                    Text("Credit",style:TextStyle(color: Colors.black),),
//                                   if(snapshot.data!.data![index].type.toString()=="DR")
//                                   Text("Debit",style: TextStyle(color: Colors.black),),
//                                 ],
//                               ),
//
//                               if(snapshot.data!.data![index].type.toString() == "CR")
//                                 Icon(Icons.arrow_circle_left_outlined,color: Colors.green,),
//                               if(snapshot.data!.data![index].type.toString()=="DR")
//                               //Icon(Icons.arrow_upward_outlined,color: Colors.red,),
//                               Icon(Icons.arrow_circle_right_outlined,color: Colors.red,),
//
//
//
//                             ],
//                           ),
//
//                           Row(
//                             children: [
//                               Text("Amount "),
//                               SizedBox(width: MediaQuery.of(context).size.width*0.180,),
//                               if(snapshot.data!.data![index].type.toString() == "CR")
//                                 Text("+₹${snapshot.data!.data![index].amount.toString()}",style: TextStyle(color: Colors.green),),
//                               if(snapshot.data!.data![index].type.toString()=="DR")
//                                 Text("-₹${snapshot.data!.data![index].amount.toString()}",style: TextStyle(color: Colors.red),),
//
//                              // Text("₹${snapshot.data!.data![index].amount.toString()}"),
//
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text("Old Balance   "),
//                               SizedBox(width: MediaQuery.of(context).size.width*0.1,),
//                               Text("₹${snapshot.data!.data![index].oldBalance.toString()}"),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text("New Balance "),
//                               SizedBox(width: MediaQuery.of(context).size.width*0.1,),
//                               Text("₹${snapshot.data!.data![index].newBalance.toString()}"),
//                             ],
//                           ),
//
//                           Row(
//                             children: [
//                               Text("Bank Name   "),
//                               SizedBox(width: MediaQuery.of(context).size.width*0.1,),
//                               Flexible(child:
//                              // Text(snapshot.data!.data![index].bankName.toString().split('.').last)),
//                               Text("${formatAccountNumber(snapshot.data!.data![index].bankName.toString().split('.').last)}"),),
//                              // Text(snapshot.data!.data![index].bankName.toString().split('.').last)),
//                             ],
//                           ),
//
//                           // Row(
//                           //   children: [
//                           //     Text("Remark "),
//                           //     SizedBox(width: MediaQuery.of(context).size.width * 0.19,),
//                           //     Text("${snapshot.data!.data![index].remark.toString()}"),
//
//                               // Text(
//                               //   snapshot.data!.data![index].remark != null && snapshot.data!.data![index].remark!.isNotEmpty
//                               //       ? snapshot.data!.data![index].remark!
//                               //       : 'No Remark',
//                               // ),
//                           //   ],
//                           // ),
//
//
//                      /*     Text(
//                             snapshot.data!.data![index].remark != null && snapshot.data!.data![index].remark!.isNotEmpty
//                                 ? snapshot.data!.data![index].remark!
//                                 : 'No Remark',
//                             maxLines: showMore ? null : 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           SizedBox(height: 8),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 showMore = !showMore;
//                               });
//                             },
//                             child: Text(
//                               showMore ? 'View Less' : 'Show More',
//                               style: TextStyle(
//                                 color: Colors.blue,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),*/
//
//
//                           // Row(
//                           //   children: [
//                           //     Text("Remark :"),
//                           //     SizedBox(width: MediaQuery.of(context).size.width*0.1,),
//                           //     Text(snapshot.data!.data![index].remark.toString()),
//                           //     // Text(
//                           //     //   snapshot.data!.data![index].remark?.toString()?.isNotEmpty == true
//                           //     //       ? snapshot.data!.data![index].remark.toString()
//                           //     //       : 'No Remark',
//                           //     // ),
//                           //   ],
//                           // ),
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//             },
//             separatorBuilder: (context, index) {
//               return SizedBox(height: 16);
//             },
//             itemCount: snapshot.data!.data!.length,
//           );
//         }
//       },
//     );
//   }
//
//
//
//
//
//
//   Future<PaymentListModel?> paymentlistapi() async{
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
//     };
//     var data = {
//       'payment_filter': '1',
//       'type': selectedtransactiontype
//     };
//     var dio = Dio();
//     var response = await dio.request(
//       'https://admissionguidanceindia.com/appdata/webservice.php',
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//
//
//       var responseData = response.data is String
//           ? json.decode(response.data)
//           : response.data;
//       print("payment list ");
//       print(responseData);
//       print("payment list");
//       //optionss=responseData;
//       return PaymentListModel.fromJson(responseData);
//     }
//     else {
//       print(response.statusMessage);
//     }
//
//   }
//
//
//   Widget todaybalancelistwidget() {
//     return FutureBuilder(
//       future: todaybalanceApi(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//               child: CircularProgressIndicator()
//           );
//         }
//         // else if (snapshot.hasError) {
//         //   return Text('Error: Internal error');
//         // }
//         // else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
//         //   return Container(
//         //     child: Center(
//         //       child: Text('No data available.'),
//         //     ),
//         //   );
//         // }
//         else {
//           return  ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, int index) {
//               return
//
//                 InkWell(
//                     onTap: (){
//                       print("govind kkk");
//                     },
//                     child:  Container(
//                       padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.10,right: MediaQuery.of(context).size.width*0.10),
//                       height: 100,
//                       //width: MediaQuery.of(context).size.width*0.1,
//                       //color: Colors.red,
//                       child:    Container(
//
//                         decoration: BoxDecoration(
//                           color: Colors.white70,
//                           borderRadius: BorderRadius.circular(12.0),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               spreadRadius: 2,
//                               blurRadius: 4,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Container(
//                           padding: EdgeInsets.only(left: 7,right: 7,top: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//
//                               Text("Balance ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
//
//                               SizedBox(height: 10,),
//                               Row(
//                                 children: [
//                                   Text(""),
//                                   SizedBox(width:10,),
//                                   Text("+₹${snapshot.requireData!.data.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.green),),
//                                   InkWell(
//                                       onTap: (){
//                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>PaginationdetailsScreen()));
//                                       },
//                                       child: Text("button")),
//
//
//                                 ],
//                               ),
//
//
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//
//                 );
//             },
//             separatorBuilder: (context, index) {
//               return SizedBox(height: 16);
//             },
//             itemCount:1,
//           );
//         }
//       },
//     );
//   }
//
//   Future<TodayBalanceModel?> todaybalanceApi() async{
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
//     };
//     var data = {
//       'today_balance': '1'
//     };
//     var dio = Dio();
//     var response = await dio.request(
//       'https://admissionguidanceindia.com/appdata/webservice.php',
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//      //print(json.encode(response.data));
//
//       var responseData = response.data is String
//           ? json.decode(response.data)
//           : response.data;
//       print("today balance ");
//       print(responseData);
//       print("today balance");
//       //optionss=responseData;
//       return TodayBalanceModel.fromJson(responseData);
//
//     }
//     else {
//       print(response.statusMessage);
//     }
//   }
//
//
//
//   //  NEW TRANSACTION
//
//
//   Widget Transactionwidget() {
//     return SingleChildScrollView(
//       child:
//
//       Column(
//         children: [
//           Center(
//             child: _isLoading
//                 ? CircularProgressIndicator() // Show the circular progress indicator
//                 :
//             Container(
//               // height: MediaQuery.of(context).size.height*1,
//               height: MediaQuery.of(context).size.height*1,
//               decoration: BoxDecoration(
//                 //color: Colors.yellow,
//
//                 image: DecorationImage(
//
//                   image: AssetImage('assets/background.jpg'), // Replace with your image asset path
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               padding: EdgeInsets.only(left: 16, right: 16, top: 10),
//               child:BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 6, sigmaY:6),
//                 child:
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Account Number : ",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     SizedBox(height: 10,),
//                     accountNumberWidget(),
//                     SizedBox(height: 15,),
//                     // Text(valu),
//                     //SizedBox(height: 15,),
//
//                     Text(
//                       "Transaction Type: ",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     SizedBox(height: 10,),
//                     Container(
//                       width: MediaQuery.of(context).size.width*0.98,
//                       padding: EdgeInsets.only(left: 10),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),  // Set the color of the border
//                         borderRadius: BorderRadius.circular(12), // Set the border radius
//                       ),
//                       child: DropdownButton<String>(
//                         isExpanded: true,
//
//                         value: selectedValue,
//                         onChanged: (newValue) {
//                           setState(() {
//                             selectedValue = newValue!;
//                             //  transationtype=newValue;
//                             print("Transation type ${newValue}");
//                           });
//                         },
//                         underline: Container(),
//                         items: options.map((option) {
//                           return DropdownMenuItem<String>(
//                             value: option,
//                             child: Text(option),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//                     Text(
//                       "Amount : ",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     SizedBox(height: 15,),
//                     TextField(
//                       controller: _amountcontroller,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         labelText: "Enter Amount",
//                         filled: true,
//                         isDense: true,
//                         border: OutlineInputBorder(
//
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(height: 10,),
//                     Text(
//                       "Remark : ",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     SizedBox(height: 15,),
//                     TextField(
//                       maxLines: 4,
//                       controller: _remarkcontroller,
//                       //keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         labelText: "Type Remark",
//                         filled: true,
//                         isDense: true,
//                         border: OutlineInputBorder(
//
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//
//                     // if(selectedValue == "CR")
//                     //   Text("creadet cart"),
//                     //  if(selectedValue == "DR")
//                     //    Text("DR cart"),
//                     //  if(selectedValue == "Transaction Type")
//                     //    Text("Transaction Type"),
//
//
//
//                     //  timeslotwidget(),
//                     SizedBox(height: 100,),
//
//                     SizedBox(
//                       height: 45,
//                       width: MediaQuery.of(context).size.width * 1,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                           MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
//                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               side: BorderSide(color: MyTheme.backgroundcolor),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//
//                           print("Print Amount Controoler:${_amountcontroller.text}");
//                           //  print("Print Transaction Type:${transationtype}");
//                           //print("account number name:${accountNumber}");
//                           print("account type:${_remarkcontroller.text}");
//
//                           var AMOUNTVAR =_amountcontroller.text;
//                           var TRANSACTIONTYPEVAR =selectedValue;
//                           //var ACCOUNTNUMVAR =accountNumber!;
//                           var ACCOUNTNUMVAR =accountselectedValue!;
//                           var REMARKVAR =_remarkcontroller.text;
//
//                           print(":::::::::::::::::::::::::::::::::");
//                           print("AMOUNT ${AMOUNTVAR}");
//                           print("TRANSATCTION ${TRANSACTIONTYPEVAR}");
//                           print("ACCOUNT NUM ${ACCOUNTNUMVAR}");
//                           print("REMARK ${REMARKVAR}");
//                           print(":::::::::::::::::::::::::::::::::");
//
//
//
//                           addpaymentapi(AMOUNTVAR,TRANSACTIONTYPEVAR,ACCOUNTNUMVAR,REMARKVAR);
//
//
//                           //addpaymentapi(_amountcontroller.text,transationtype,accountNumber,_remarkcontroller.text);
//                           //_amount,_type,_bankid
//                           // Add the logic for the button press here
//                         },
//                         child: Text(
//                           "Pay",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
//
//   Widget accountNumberWidget() {
//     return FutureBuilder(
//       future: accountlistAPI(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Container(
//             child: Center(child: CircularProgressIndicator()),
//           );
//         } else if (snapshot.hasError) {
//           return Container(
//             child: Center(
//               child: Text('Error: Internal error'),
//             ),
//           );
//         } else
//         if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
//           return Container(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else {
//           return Container(
//             // padding: EdgeInsets.only(left: 16, right: 16),
//             child: Column(
//               children: [
//
//                 Container(
//                   width: MediaQuery.of(context).size.width*0.9,
//                   padding: EdgeInsets.only(left: 16,right: 11),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),  // Set the color of the border
//                     borderRadius: BorderRadius.circular(12), // Set the border radius
//                   ),
//                   child:
//
//                   DropdownButton<String>(
//                     isExpanded: true,
//
//                     value: accountselectedValue,
//                     onChanged: (newValue) {
//                       setState(() {
//                         accountselectedValue = newValue!;
//                         // remindertypeid=newValue;
//                         print("Account Number ${newValue}");
//                         print("Account Numberasa ${accountselectedValue}");
//                         //print("Account Number id ${remindertypeid}");
//                       });
//                     },
//                     underline: Container(),
//                     items: [
//                       DropdownMenuItem<String>(
//                         value: 'Select Account Number',
//                         child: Text('Select Account Number'),
//                       ),
//                       ...snapshot.data!.data!.map((datum) {
//                         return DropdownMenuItem<String>(
//                           value: datum.id!,
//                          // child: Text("${(datum.type!)}"),
//                           child: Text("${formatAccountNumber(datum.type!)}"),
//                         );
//                       }).toList(),
//                     ],
//                   ),
//
//                 ),
//
//                 // selectedValue= snapshot.data.data.length;
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   Future<AccountNameNumberModel?> accountlistAPI() async {
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
//     };
//     var data = {
//       //'reminder_type': '1',
//       'account_list': '1'
//     };
//     var dio = Dio();
//     var response = await dio.request(
//       'https://admissionguidanceindia.com/appdata/webservice.php',
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//
//
//       var responseData = response.data is String
//           ? json.decode(response.data)
//           : response.data;
//       print("Account numberrr");
//       print(responseData);
//       print("Account numberrr");
//       //optionss=responseData;
//       return AccountNameNumberModel.fromJson(responseData);
//     }
//     else {
//       print(response.statusMessage);
//     }
//   }
//
//   Future addpaymentapi(amountt,typee,bankidd,remarkk) async{
//     setState(() {
//       _isLoading = true;
//     });
//
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
//     };
//     var data = {
//       'add_payment': '1',
//       'amount': amountt,
//       'type': typee,
//       'bank_id': bankidd,
//       'remark': remarkk
//
//       // 'add_payment': '1',
//       // 'amount': '100',
//       // 'type': 'CR',
//       // 'bank_id': '1',
//       // 'remark': 'DR'
//
//
//     };
//     var dio = Dio();
//     var response = await dio.request(
//       'https://admissionguidanceindia.com/appdata/webservice.php',
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//       Fluttertoast.showToast(
//         msg: "Payment Successfully Submitted",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//
//       print(json.encode(response.data));
//       //Navigator.pop(context, true);
//       //Navigator.pop(context);
//       _amountcontroller.clear();
//       _remarkcontroller.clear();
//       transationtype = "";
//       accountNumber = "";
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AccountdetailsScreen()));
//
//
//     }
//     else {
//       print(response.statusMessage);
//       print("Error");
//     }
//     setState(() {
//       _isLoading = false;
//     });
//
//   }
//
//
// }
//
//
//
//
//
//
//





import 'dart:convert';
import 'dart:ui';

import 'package:admissionguidence/Screens/Home_Screen.dart';
import 'package:admissionguidence/my_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../baseurl.dart';
import '../../models/AccountNameNumberModel.dart';
import '../../models/PaymentListModel.dart';
import '../../models/Time_slot_model.dart';
import '../../models/TodayBalanceModel.dart';
import '../../models/paymentlistpagination.dart';
import '../amounttransaction.dart';
import 'TransationScreen.dart';

class AccountdetailsScreen extends StatefulWidget {
  @override
  _AccountdetailsScreenState createState() => _AccountdetailsScreenState();
}

class _AccountdetailsScreenState extends State<AccountdetailsScreen> {

  var valu;


  String selectedtransactiontype = 'all';
  List<String> optionslist = ['all', 'CR', 'DR',];
  var transationtypevalue='';
  String _CASHINHANDCOUNT="0";
  String _TODAYAMOUNTCOUNT="0";
  String _PAGECOUNT="1";
  String buttontype="";



  // String accountselectedValue = 'Select Account Number';

  @override
  void initState() {
    // TODO: implement initState
    // accountNameNumberApi();
    paymentlistpagination(_PAGECOUNT);
    todayaccountfetchData();
    caseinhandfetchData();
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

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    //Navigator.pop(context, true);
                    //Navigator.pop(context);
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
                child: Transation_Screen(),
                //child: Transactionwidget(),
              ),
            ],
          ),
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
             // todaybalancelistwidget(),

              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                // padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.10),
                height: 100,
                //width: MediaQuery.of(context).size.width*0.1,
                //color: Colors.red,
                child:    Container(

                    decoration: BoxDecoration(
                      color: Colors.white70,
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
                    child:
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Account Balance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                              SizedBox(height: 6,),
                              Text("+₹${_TODAYAMOUNTCOUNT}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.green)),
                              //Text("+₹${snapshot.requireData!.data.toString()}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.green)),
                            ],
                          ),
                          VerticalDivider(color: Colors.grey, thickness: 2), // Vertical Divider


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Cash In Hand ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                              SizedBox(height: 6,),
                              Text("+₹${_CASHINHANDCOUNT}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.green)),
                              //Text("+₹${snapshot.requireData!.data.toString()}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.green)),
                            ],
                          ),
                        ],
                      ),
                    )


                  // Container(
                  //   padding: EdgeInsets.only(left: 7,right: 7,top: 20),
                  //   child: Row(
                  //     children: [
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Text("Account Balance ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  //
                  //           Text("+₹${snapshot.requireData!.data.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.green),),
                  //
                  //          // SizedBox(height: 10,),
                  //           // Row(
                  //           //   children: [
                  //           //     Text("+₹${snapshot.requireData!.data.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.green),),
                  //           //     SizedBox(width:10,),
                  //           //     Text("+₹${snapshot.requireData!.data.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.green),),
                  //           //   ],
                  //           // ),
                  //         ],
                  //       ),
                  //      SizedBox(width: 10,),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Text("Cash In Hand Balance ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  //
                  //           Text("+₹${snapshot.requireData!.data.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.green),),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
              ),
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
                              _PAGECOUNT="1";

                              selectedtransactiontype = newValue!;
                              transationtypevalue=newValue;
                              buttontype=newValue;

                              print("Transation type ${newValue}");
                              print("Transation ty ${buttontype}");

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
                     // paymentlistwidget(),
                      SizedBox(height: 20,),

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






  // Widget paymentlistwidget() {
  //   return FutureBuilder(
  //
  //     future: paymentlistapi(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Container(
  //           child: Center(child: CircularProgressIndicator()),
  //         );
  //       }
  //       // else if (snapshot.hasError) {
  //       //   return Container(
  //       //     child: Center(
  //       //       child: Text('Error: Internal error'),
  //       //     ),
  //       //   );
  //       // }
  //
  //       // else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
  //       //   return Container(
  //       //     child: Center(
  //       //       child: Text('No data available.'),
  //       //     ),
  //       //   );
  //       // }
  //       else {
  //
  //         return  ListView.separated(
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           reverse: true,
  //           itemBuilder: (context, int index) {
  //             return
  //
  //               InkWell(
  //                 onTap: (){
  //                   print("govind kkk");
  //                   print("Remark: ${snapshot.data!.data![33].amount}");
  //                   print("Remark: ${snapshot.data!.data![33].remark}");
  //
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.white70,
  //                     borderRadius: BorderRadius.circular(10.0),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.black.withOpacity(0.2),
  //                         spreadRadius: 2,
  //                         blurRadius: 4,
  //                         offset: Offset(0, 3),
  //                       ),
  //                     ],
  //                   ),
  //                   child: Container(
  //                     padding: EdgeInsets.all(8.0),
  //                     child: Column(
  //                       children: [
  //
  //                         Row(
  //                           mainAxisAlignment:
  //                           MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Text("Transaction Type  "),
  //                                 SizedBox(width: 5,),
  //                                 // Text(snapshot.data!.data![index]
  //                                 //     .type.toString()),
  //                                 // Text(snapshot.data!.data![index].type.toString(),style:TextStyle(color: Colors.black),),
  //                                 if(snapshot.data!.data![index].type.toString() == "CR")
  //                                   Text("Credit",style:TextStyle(color: Colors.black),),
  //                                 if(snapshot.data!.data![index].type.toString()=="DR")
  //                                   Text("Debit",style: TextStyle(color: Colors.black),),
  //                               ],
  //                             ),
  //
  //                             if(snapshot.data!.data![index].type.toString() == "CR")
  //                               Icon(Icons.arrow_circle_left_outlined,color: Colors.green,),
  //                             if(snapshot.data!.data![index].type.toString()=="DR")
  //                             //Icon(Icons.arrow_upward_outlined,color: Colors.red,),
  //                               Icon(Icons.arrow_circle_right_outlined,color: Colors.red,),
  //
  //
  //
  //                           ],
  //                         ),
  //
  //                         Row(
  //                           children: [
  //                             Text("Amount "),
  //                             SizedBox(width: MediaQuery.of(context).size.width*0.180,),
  //                             if(snapshot.data!.data![index].type.toString() == "CR")
  //                               Text("+₹${snapshot.data!.data![index].amount.toString()}",style: TextStyle(color: Colors.green),),
  //                             if(snapshot.data!.data![index].type.toString()=="DR")
  //                               Text("-₹${snapshot.data!.data![index].amount.toString()}",style: TextStyle(color: Colors.red),),
  //
  //                             // Text("₹${snapshot.data!.data![index].amount.toString()}"),
  //
  //                           ],
  //                         ),
  //                         Row(
  //                           children: [
  //                             Text("Old Balance   "),
  //                             SizedBox(width: MediaQuery.of(context).size.width*0.1,),
  //                             Text("₹${snapshot.data!.data![index].oldBalance.toString()}"),
  //                           ],
  //                         ),
  //                         Row(
  //                           children: [
  //                             Text("New Balance "),
  //                             SizedBox(width: MediaQuery.of(context).size.width*0.1,),
  //                             Text("₹${snapshot.data!.data![index].newBalance.toString()}"),
  //                           ],
  //                         ),
  //
  //                         Row(
  //                           children: [
  //                             Text("Bank Name   "),
  //                             SizedBox(width: MediaQuery.of(context).size.width*0.1,),
  //                             Flexible(child:
  //                             // Text(snapshot.data!.data![index].bankName.toString().split('.').last)),
  //                             Text("${formatAccountNumber(snapshot.data!.data![index].bankName.toString().split('.').last)}"),),
  //                             // Text(snapshot.data!.data![index].bankName.toString().split('.').last)),
  //                           ],
  //                         ),
  //
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //           },
  //           separatorBuilder: (context, index) {
  //             return SizedBox(height: 16);
  //           },
  //           itemCount: snapshot.data!.data!.length,
  //         );
  //       }
  //     },
  //   );
  // }


  // Widget paymentlistwidgettt() {
  //   return FutureBuilder(
  //     future: paymentlistpagination(_PAGECOUNT),
  //     builder: (context, AsyncSnapshot snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Container(
  //           child: Center(child: CircularProgressIndicator()),
  //         );
  //       } else if (snapshot.hasError) {
  //         return Container(
  //           child: Center(
  //             child: Text('Server Error '),
  //           ),
  //         );
  //       } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.data != null && snapshot.data!.pagination != null) {
  //         return Column(
  //           children: [
  //             ListView.separated(
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               reverse: true,
  //               itemBuilder: (context, int index) {
  //                 return InkWell(
  //                   onTap: () {
  //                     // Handle onTap event
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       color: Colors.white70,
  //                       borderRadius: BorderRadius.circular(10.0),
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.black.withOpacity(0.2),
  //                           spreadRadius: 2,
  //                           blurRadius: 4,
  //                           offset: Offset(0, 3),
  //                         ),
  //                       ],
  //                     ),
  //                     child: Container(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: Column(
  //                         children: [
  //                           // Your widget content for each item
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //               separatorBuilder: (context, index) {
  //                 return SizedBox(height: 16);
  //               },
  //               itemCount: snapshot.data!.data!.length,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 if (snapshot.data!.pagination!.prevPage! >= 1)
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       // Handle previous page button tap
  //                     },
  //                     child: Text("Prev"),
  //                   ),
  //                 Spacer(),
  //                 if (snapshot.data!.pagination!.nextPage! > 1)
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       // Handle next page button tap
  //                     },
  //                     child: Text("Next"),
  //                   ),
  //               ],
  //             ),
  //           ],
  //         );
  //       } else {
  //         return Container(
  //           child: Center(
  //             child: Text('No data available.'),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }




  Widget paymentlistwidgettt() {
    return FutureBuilder(
      future: paymentlistpagination(_PAGECOUNT),
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

        else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
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
                        print("Remark: ${snapshot.data!.data![33].amount}");
                        print("Remark: ${snapshot.data!.data![33].remark}");

                        print("prevPage: ${snapshot.data!.pagination!.prevPage.toString()}");
                        print("nextPage: ${snapshot.data!.pagination!.nextPage.toString()}");

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
                                      Text("Transaction Type  "),
                                      SizedBox(width: 5,),
                                      // Text(snapshot.data!.data![index]
                                      //     .type.toString()),
                                      // Text(snapshot.data!.data![index].type.toString(),style:TextStyle(color: Colors.black),),
                                      if(snapshot.data!.data![index].type.toString() == "CR")
                                        Text("Credit",style:TextStyle(color: Colors.black),),
                                      if(snapshot.data!.data![index].type.toString()=="DR")
                                        Text("Debit",style: TextStyle(color: Colors.black),),
                                    ],
                                  ),

                                  if(snapshot.data!.data![index].type.toString() == "CR")
                                    Icon(Icons.arrow_circle_left_outlined,color: Colors.green,),
                                  if(snapshot.data!.data![index].type.toString()=="DR")
                                  //Icon(Icons.arrow_upward_outlined,color: Colors.red,),
                                    Icon(Icons.arrow_circle_right_outlined,color: Colors.red,),



                                ],
                              ),

                              Row(
                                children: [
                                  Text("Amount "),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.180,),
                                  if(snapshot.data!.data![index].type.toString() == "CR")
                                    Text("+₹${snapshot.data!.data![index].amount.toString()}",style: TextStyle(color: Colors.green),),
                                  if(snapshot.data!.data![index].type.toString()=="DR")
                                    Text("-₹${snapshot.data!.data![index].amount.toString()}",style: TextStyle(color: Colors.red),),

                                  // Text("₹${snapshot.data!.data![index].amount.toString()}"),

                                ],
                              ),
                              Row(
                                children: [
                                  Text("Old Balance   "),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                                  Text("₹${snapshot.data!.data![index].oldBalance.toString()}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("New Balance "),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                                  Text("₹${snapshot.data!.data![index].newBalance.toString()}"),
                                ],
                              ),

                              Row(
                                children: [
                                  Text("Bank Name   "),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                                  Flexible(child:
                                  // Text(snapshot.data!.data![index].bankName.toString().split('.').last)),
                                  Text("${formatAccountNumber(snapshot.data!.data![index].bankName.toString().split('.').last)}"),),
                                  // Text(snapshot.data!.data![index].bankName.toString().split('.').last)),
                                ],
                              ),

                              // Row(
                              //   children: [
                              //     Text("Date   "),
                              //     SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                              //     Text("${formatAccountNumber(snapshot.data!.data![index].d.toString().split('.').last)}"),
                              //     // Text(snapshot.data!.data![index].bankName.toString().split('.').last)),
                              //   ],
                              // ),


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
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                 // snapshot.data!.pagination!.prevPage!.toString()
                  if(snapshot.data!.pagination!.prevPage! >= 1)
                  ElevatedButton(onPressed: (){
                    _PAGECOUNT=snapshot.data!.pagination!.prevPage!.toString();
                    paymentlistpagination(_PAGECOUNT);
                    print("page count prev ${_PAGECOUNT}");
                    setState(() {
                      paymentlistpagination(_PAGECOUNT);

                    });
                  }, child:Text("Prev")),
                  Spacer(),
                  //if(snapshot.data!.pagination!.nextPage! <= 1)
                  if(snapshot.data!.pagination!.nextPage! > 1)
                  ElevatedButton(onPressed: (){
                  _PAGECOUNT=snapshot.data!.pagination!.nextPage!.toString();

                  paymentlistpagination(_PAGECOUNT);
                  print("page count next ${_PAGECOUNT}");
                  setState(() {
                    paymentlistpagination(_PAGECOUNT);

                  });
                      }, child:Text("Next")),

                ],
              ),
            ],
          );
        }
      },
    );
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


  Future<PaymentListpaginationModel?> paymentlistpagination(page) async{
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=166abf8a3ff4cbe9eb5f7a030e7ee562'
    };
    var data = {
      'payment_list': '1',
      'page': page,
      'type': selectedtransactiontype
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
      print("payment pagination ");
      print(responseData);
      print("payment pagination");
      //optionss=responseData;
      return PaymentListpaginationModel.fromJson(responseData);
    }
    else {
      print(response.statusMessage);
    }

  }





  Widget todaybalancelistwidget() {
    return FutureBuilder(
      future: todaybalanceApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()
          );
        }
        // else if (snapshot.hasError) {
        //   return Text('Error: Internal error');
        // }
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
                    child:
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                     // padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.10),
                      height: 100,
                      //width: MediaQuery.of(context).size.width*0.1,
                      //color: Colors.red,
                      child:    Container(

                        decoration: BoxDecoration(
                          color: Colors.white70,
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
                        child:
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Account Balance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                  SizedBox(height: 6,),
                                  Text("+₹${_TODAYAMOUNTCOUNT}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.green)),
                                  //Text("+₹${snapshot.requireData!.data.toString()}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.green)),
                                ],
                              ),
                              VerticalDivider(color: Colors.grey, thickness: 2), // Vertical Divider


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Cash In Hand ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                  SizedBox(height: 6,),
                                  Text("+₹${_CASHINHANDCOUNT}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.green)),
                                  //Text("+₹${snapshot.requireData!.data.toString()}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.green)),
                                ],
                              ),
                            ],
                          ),
                        )


                        // Container(
                        //   padding: EdgeInsets.only(left: 7,right: 7,top: 20),
                        //   child: Row(
                        //     children: [
                        //       Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           Text("Account Balance ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                        //
                        //           Text("+₹${snapshot.requireData!.data.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.green),),
                        //
                        //          // SizedBox(height: 10,),
                        //           // Row(
                        //           //   children: [
                        //           //     Text("+₹${snapshot.requireData!.data.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.green),),
                        //           //     SizedBox(width:10,),
                        //           //     Text("+₹${snapshot.requireData!.data.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.green),),
                        //           //   ],
                        //           // ),
                        //         ],
                        //       ),
                        //      SizedBox(width: 10,),
                        //       Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           Text("Cash In Hand Balance ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                        //
                        //           Text("+₹${snapshot.requireData!.data.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.green),),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
      //'https://admissionguidanceindia.com/appdata/webservice.php',
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



  //  NEW TRANSACTION


  // Widget Transactionwidget() {
  //   return SingleChildScrollView(
  //     child:
  //
  //     Column(
  //       children: [
  //         Center(
  //           child: _isLoading
  //               ? CircularProgressIndicator() // Show the circular progress indicator
  //               :
  //           Container(
  //             // height: MediaQuery.of(context).size.height*1,
  //             height: MediaQuery.of(context).size.height*1,
  //             decoration: BoxDecoration(
  //               //color: Colors.yellow,
  //
  //               image: DecorationImage(
  //
  //                 image: AssetImage('assets/background.jpg'), // Replace with your image asset path
  //                 fit: BoxFit.fill,
  //               ),
  //             ),
  //             padding: EdgeInsets.only(left: 16, right: 16, top: 10),
  //             child:BackdropFilter(
  //               filter: ImageFilter.blur(sigmaX: 6, sigmaY:6),
  //               child:
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "Amount : ",
  //                     style: TextStyle(fontSize: 20),
  //                   ),
  //                   SizedBox(height: 15,),
  //                   TextField(
  //                     controller: _amountcontroller,
  //                     keyboardType: TextInputType.number,
  //                     decoration: InputDecoration(
  //                       floatingLabelBehavior: FloatingLabelBehavior.never,
  //                       labelText: "Enter Amount",
  //                       filled: true,
  //                       isDense: true,
  //                       border: OutlineInputBorder(
  //
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                     ),
  //                   ),
  //
  //
  //
  //                   SizedBox(height: 15,),
  //                   // Text(valu),
  //                   //SizedBox(height: 15,),
  //
  //                   Text(
  //                     "Transaction Type: ",
  //                     style: TextStyle(fontSize: 20),
  //                   ),
  //                   SizedBox(height: 10,),
  //                   Container(
  //                     width: MediaQuery.of(context).size.width*0.98,
  //                     padding: EdgeInsets.only(left: 10),
  //                     decoration: BoxDecoration(
  //                       border: Border.all(color: Colors.black),  // Set the color of the border
  //                       borderRadius: BorderRadius.circular(12), // Set the border radius
  //                     ),
  //                     child: DropdownButton<String>(
  //                       isExpanded: true,
  //
  //                       value: selectedValue,
  //                       onChanged: (newValue) {
  //                         setState(() {
  //                           selectedValue = newValue!;
  //                           //  transationtype=newValue;
  //                           buttontype=newValue;
  //                           print("Transation typre ${newValue}");
  //                           print("Transation buttontype ${buttontype}");
  //                           print("Transation selectedValue ${selectedValue}");
  //                         });
  //                       },
  //                       underline: Container(),
  //                       items: options.map((option) {
  //                         return DropdownMenuItem<String>(
  //                           value: option,
  //                           child: Text(option),
  //                         );
  //                       }).toList(),
  //                     ),
  //                   ),
  //                   SizedBox(height: 10,),
  //
  //
  //                   Text(
  //                     "Account Number : ",
  //                     style: TextStyle(fontSize: 20),
  //                   ),
  //                   SizedBox(height: 10,),
  //                   accountNumberWidget(),
  //
  //                   SizedBox(height: 10,),
  //                   Text(
  //                     "Remark : ",
  //                     style: TextStyle(fontSize: 20),
  //                   ),
  //                   SizedBox(height: 15,),
  //                   TextField(
  //                     maxLines: 4,
  //                     controller: _remarkcontroller,
  //                     //keyboardType: TextInputType.number,
  //                     decoration: InputDecoration(
  //                       floatingLabelBehavior: FloatingLabelBehavior.never,
  //                       labelText: "Type Remark",
  //                       filled: true,
  //                       isDense: true,
  //                       border: OutlineInputBorder(
  //
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                     ),
  //                   ),
  //
  //                   // if(selectedValue == "CR")
  //                   //   Text("creadet cart"),
  //                   //  if(selectedValue == "DR")
  //                   //    Text("DR cart"),
  //                   //  if(selectedValue == "Transaction Type")
  //                   //    Text("Transaction Type"),
  //
  //
  //
  //                   //  timeslotwidget(),
  //                   SizedBox(height: 100,),
  //
  //                   SizedBox(
  //                     height: 45,
  //                     width: MediaQuery.of(context).size.width * 1,
  //                     child: ElevatedButton(
  //                       style: ButtonStyle(
  //                         backgroundColor:
  //                         MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
  //                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                           RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(12.0),
  //                             side: BorderSide(color: MyTheme.backgroundcolor),
  //                           ),
  //                         ),
  //                       ),
  //                       onPressed: () {
  //
  //                         print("Print Amount Controoler:${_amountcontroller.text}");
  //                         //  print("Print Transaction Type:${transationtype}");
  //                         //print("account number name:${accountNumber}");
  //                         print("account type:${_remarkcontroller.text}");
  //
  //                         var AMOUNTVAR =_amountcontroller.text;
  //                         var TRANSACTIONTYPEVAR =selectedValue;
  //                         //var ACCOUNTNUMVAR =accountNumber!;
  //                         var ACCOUNTNUMVAR =accountselectedValue!;
  //                         var REMARKVAR =_remarkcontroller.text;
  //
  //                         print(":::::::::::::::::::::::::::::::::");
  //                         print("AMOUNT ${AMOUNTVAR}");
  //                         print("TRANSATCTION ${TRANSACTIONTYPEVAR}");
  //                         print("ACCOUNT NUM ${ACCOUNTNUMVAR}");
  //                         print("REMARK ${REMARKVAR}");
  //                         print(":::::::::::::::::::::::::::::::::");
  //
  //
  //
  //                         addpaymentapi(AMOUNTVAR,TRANSACTIONTYPEVAR,ACCOUNTNUMVAR,REMARKVAR);
  //
  //
  //                         //addpaymentapi(_amountcontroller.text,transationtype,accountNumber,_remarkcontroller.text);
  //                         //_amount,_type,_bankid
  //                         // Add the logic for the button press here
  //                       },
  //                       child:
  //
  //                       Text(
  //                       //  buttontype == "CR" ? "Receive" : "Pay",
  //                         "Paygg",
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                       )
  //
  //
  //
  //                     ),
  //                   ),
  //
  //
  //                   SizedBox(
  //                     height: 45,
  //                     width: MediaQuery.of(context).size.width * 1,
  //                     child: ElevatedButton(
  //                       style: ButtonStyle(
  //                         backgroundColor:
  //                         MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
  //                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                           RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(12.0),
  //                             side: BorderSide(color: MyTheme.backgroundcolor),
  //                           ),
  //                         ),
  //                       ),
  //                       onPressed: () {
  //
  //                         print("Print Amount Controoler:${_amountcontroller.text}");
  //                         //  print("Print Transaction Type:${transationtype}");
  //                         //print("account number name:${accountNumber}");
  //                         print("account type:${_remarkcontroller.text}");
  //
  //                         var AMOUNTVAR =_amountcontroller.text;
  //                         var TRANSACTIONTYPEVAR =selectedValue;
  //                         //var ACCOUNTNUMVAR =accountNumber!;
  //                         var ACCOUNTNUMVAR =accountselectedValue!;
  //                         var REMARKVAR =_remarkcontroller.text;
  //
  //                         print(":::::::::::::::::::::::::::::::::");
  //                         print("AMOUNT ${AMOUNTVAR}");
  //                         print("TRANSATCTION ${TRANSACTIONTYPEVAR}");
  //                         print("ACCOUNT NUM ${ACCOUNTNUMVAR}");
  //                         print("REMARK ${REMARKVAR}");
  //                         print(":::::::::::::::::::::::::::::::::");
  //
  //
  //
  //                         addpaymentapi(AMOUNTVAR,TRANSACTIONTYPEVAR,ACCOUNTNUMVAR,REMARKVAR);
  //
  //
  //                         //addpaymentapi(_amountcontroller.text,transationtype,accountNumber,_remarkcontroller.text);
  //                         //_amount,_type,_bankid
  //                         // Add the logic for the button press here
  //                       },
  //                       child:
  //
  //                       Text(
  //                       //  buttontype == "CR" ? "Receive" : "Pay",
  //                         "Receive",
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                       ),
  //
  //
  //
  //                     ),
  //                   ),
  //
  //
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }

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



  Future<int?> caseinhandfetchData() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=d317ff54f034d4b459a98f619c622a7a'
    };
    var data = {
      'cash_inhand_balance': '1'
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
      print("Total Appointmentss");
      // Decode the JSON string to a Map
      Map<String, dynamic> responseData = json.decode(response.data);

      // Check if 'data' field is present in the response
      if (responseData.containsKey('data')) {
        var dataValue = responseData['data'];

        print("Data value: $dataValue");
        _CASHINHANDCOUNT = dataValue.toString();
        print("_CASHINHANDCOUNT: $_CASHINHANDCOUNT");
        setState(() {
          _CASHINHANDCOUNT = dataValue.toString();
        });
        return dataValue;
      }
    }
    else {
      print(response.statusMessage);
    }
  }
  Future<int?> todayaccountfetchData() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=d317ff54f034d4b459a98f619c622a7a'
    };
    var data = {
      'today_balance': '1'
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
      print("Total Appointmentss");
      // Decode the JSON string to a Map
      Map<String, dynamic> responseData = json.decode(response.data);

      // Check if 'data' field is present in the response
      if (responseData.containsKey('data')) {
        var dataValue = responseData['data'];

        print("Data value: $dataValue");
        _TODAYAMOUNTCOUNT = dataValue.toString();
        print("_TODAYAMOUNTCOUNT: $_TODAYAMOUNTCOUNT");
        setState(() {
          _TODAYAMOUNTCOUNT = dataValue.toString();
        });
        return dataValue;
      }
    }
    else {
      print(response.statusMessage);
    }
  }



}