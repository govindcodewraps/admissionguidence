// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'my_theme.dart';
//
// class logggin extends StatefulWidget {
//   const logggin({super.key});
//
//   @override
//   State<logggin> createState() => _loggginState();
// }
//
// class _loggginState extends State<logggin> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: SafeArea(child:
//       Container(
//
//         decoration: BoxDecoration(
//           color: Colors.yellow,
//
//           image: DecorationImage(
//
//             image: AssetImage('assets/background.jpg'), // Replace with your image asset path
//             fit: BoxFit.fill,
//           ),
//         ),
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//           Container(
//             height: 200,
//             child: Image.asset("assets/logo.png"),
//            // height: 200,
//             //olor: Colors.red,
//           ),
//           Container(
//             padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
//             decoration: BoxDecoration(
//               color: MyTheme.WHITECOLOR,
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
//               //border: Border.all(color: MyTheme.backgroundcolor)
//             ),
//             // height: 485,
//             //width: 335,
//             child:
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 Text("Welcome"),
//                 SizedBox(height: 10,),
//
//                 Text("Email", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16,),),
//
//                 TextField(
//                   //controller: _useridController,
//
//                   cursorColor: MyTheme.backgroundcolor,
//                   decoration: InputDecoration(
//                     hintText: "Email",
//                     hintStyle: TextStyle(color: MyTheme.backgroundcolor.withOpacity(0.5)), // Adjust the opacity as needed
//                   ),
//                 ),
//
//
//
//
//                 SizedBox(height: 20,),
//                 Text("Password", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16,)),
//
//
//                 TextField(
//                  // controller: _userpasswordController,
//                   cursorColor: MyTheme.backgroundcolor,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: "Password",
//                     hintStyle: TextStyle(color: MyTheme.backgroundcolor.withOpacity(0.5)), // Adjust the opacity as needed
//                   ),
//                 ),
//
//
//
//
//
//
//
//                 SizedBox(height: MediaQuery.of(context).size.height*0.13,),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: SizedBox(
//                       height: 45,
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),
//                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               // side: BorderSide(),
//                             ),
//                           ),
//                         ),
//                         onPressed: () async {
//
//
//
//                            // loginapi(_useridController.text.toString(), _userpasswordController.text.toString());
//
//
//                         },
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                             color:MyTheme.WHITECOLOR,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],),
//       ),
//     ),);
//   }
// }
