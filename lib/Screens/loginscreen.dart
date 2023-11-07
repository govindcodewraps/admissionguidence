import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../my_theme.dart';
import 'Home_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
    Container(
      width: double.infinity,


      color: MyTheme.backgroundcolor,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


        Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          decoration: BoxDecoration(
              color: MyTheme.WHITECOLOR,
        borderRadius:BorderRadius.circular(12)
        // borderRadius: BorderRadius.all(Radius.circular(10))
          ),

          height: 485,
          width: 335,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Image.asset("assets/logo.png"),
              SizedBox(height: 30,),
              Text("Email",style: GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 16 ),),

              TextField(
                decoration:InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
              ),
              SizedBox(height: 10,),
              Text("Password",style: GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 16 )),
              TextField(
                decoration:InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                ),
              ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Forget Password?',style: GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 16 ),
            ),),



           SizedBox(height: 30,),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  alignment: Alignment.center,
                  //width: DeviceInfo(context).width/1,

                  child:
                  SizedBox(
                    height: 45,
                    width:double.infinity,
                    child: ElevatedButton(

                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),

                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide()
                              )
                          )
                      ),

                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
                       // onPressUpdatePassword();
                      },
                      child:Text(
                        "Login",
                       // AppLocalizations.of(context).update_password_ucf,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),),
                  ),
                ),
              ),

            ],
          ),
        )
      ],),
    ),);
  }
}
