import 'package:flutter/material.dart';

import 'ReminderTypeScreen.dart';
import 'Reminder_Screen.dart';
import '../../my_theme.dart';

class ReminderTabScreen extends StatefulWidget {
  const ReminderTabScreen({super.key});

  @override
  State<ReminderTabScreen> createState() => _ReminderTabScreenState();
}

class _ReminderTabScreenState extends State<ReminderTabScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2, // Define the number of tabs
        child: Scaffold(



          //    appBar: AppBar(
          //         iconTheme: IconThemeData(
          //           color: Colors.white, // Change the icon color here
          //         ),
          //         backgroundColor: MyTheme.backgroundcolor,
          //         title: Text(
          //           "Reminder",
          //           style: TextStyle(
          //             color: Colors.white, // Change the text color here
          //           ),
          //         ),
          //         leading: IconButton(
          //           icon: Icon(Icons.arrow_back),
          //           onPressed: () {
          //             // Navigate back when back arrow is pressed
          //             Navigator.pop(context, true);
          //           },
          //         ),
          //       ),
          appBar: AppBar(
            //title: Text('Tab Demo'),

            iconTheme: IconThemeData(
            color: Colors.white, // Change the icon color here
                    ),
                    backgroundColor: MyTheme.backgroundcolor,
                    title: Text(
                      "Reminder",
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

            bottom: TabBar(
              labelColor: Colors.white, // Set the text color of the selected tab
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Reminder'),
                Tab(text: 'Reminder Type'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Widgets for each tab
              Reminder_Screen(),
              //Center(child: Text('Tab 1 Content')),
              Reminder_Type_Screen(),
            ],
          ),
        ),
      ),
    );
  }
}
