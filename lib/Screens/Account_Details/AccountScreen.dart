import 'package:admissionguidence/my_theme.dart';
import 'package:flutter/material.dart';


class AccountdetailsScreen extends StatelessWidget {
  var valu;
  @override
  Widget build(BuildContext context) {
    String accountNumber = "1234567890123456";


    String maskAccountNumber(String accountNumber) {
      if (accountNumber.length < 4) {
        // Account number is too short to mask
        return accountNumber;
      }

      // Extract the last 4 digits
      String lastFourDigits = accountNumber.substring(accountNumber.length - 4);

      // Create a mask with asterisks for the remaining digits
      String mask = '*' * (accountNumber.length - 4);

      // Concatenate the mask with the last 4 digits
      return mask + lastFourDigits;
    }


    String maskedNumber = maskAccountNumber(accountNumber);
    valu= maskedNumber;
    print("Account number ${maskedNumber}");




    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar:
          AppBar(
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
              labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600), // Set your desired font size for selected tab
              unselectedLabelStyle: TextStyle(fontSize: 16), // Set your desired font size for unselected tabs
            ),
            backgroundColor: MyTheme.backgroundcolor, // Set your desired color here
          ),


            body: TabBarView(
            children: [
              // Content of Tab 1
              Center(child:

              balancewidget(),

              ),

              // Content of Tab 2
              Center(child:
              Transactionwidget(context),
                //Text('Tab 2 Content')
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget balancewidget(){
    return Column(children: [

      Text("balance Screen"),
      Text("balance Screen"),

    ],);
  }


  Widget Transactionwidget(context){
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 16,right: 16,top: 20),
          child:
          Column(children: [

            Text(valu),




          Row(
              children: [
                Text("Amount : ",style:TextStyle(fontSize: 20),),
                Expanded(
                  flex: 1,
                  child: TextField(
                    //controller: useremailController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Enter your id",
                      filled: true,
                      // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,
                      // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius:
                        BorderRadius.circular(12), // Apply corner radius
                      ),
                     // prefixIcon: Icon(Icons.person, size: 24),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Transaction Type: ",style:TextStyle(fontSize: 20),),
                Expanded(
                  flex: 1,
                  child: TextField(
                    //controller: useremailController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Enter your id",
                      filled: true,
                      // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,
                      // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius:
                        BorderRadius.circular(12), // Apply corner radius
                      ),
                      // prefixIcon: Icon(Icons.person, size: 24),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Payment Type: ",style:TextStyle(fontSize: 20),),
                Expanded(
                  flex: 1,
                  child: TextField(
                    //controller: useremailController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Enter your id",
                      filled: true,
                      // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,
                      // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius:
                        BorderRadius.circular(12), // Apply corner radius
                      ),
                      // prefixIcon: Icon(Icons.person, size: 24),
                    ),
                  ),
                ),
              ],
            ),

          ],),
        ),
        Positioned(
          left: 10,
          right: 10,
          //top: 30,
          bottom: 10,

          child:
          SizedBox(
            height: 45,
            width:MediaQuery.of(context).size.width*1,
            child:
            ElevatedButton(

              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(MyTheme.backgroundcolor),

                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color:MyTheme.backgroundcolor)
                      )
                  )
              ),

              onPressed: (){
                //onPressUpdatePassword();
              },
              child:Text(
                "Pay",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),),
          ),

          //ElevatedButton(onPressed: (){}, child: Text("Out of stock",style: TextStyle(color: Colors.grey,fontSize: 49,fontWeight: FontWeight.w700),))
          //Text("Out of stock",style: TextStyle(color: Colors.grey,fontSize: 49,fontWeight: FontWeight.w700),)
        ),
      ],
    );
  }

}
