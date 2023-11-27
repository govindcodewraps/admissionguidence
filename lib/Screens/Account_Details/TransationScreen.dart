import 'package:flutter/material.dart';

class Transation_Screen extends StatefulWidget {
  const Transation_Screen({super.key});

  @override
  State<Transation_Screen> createState() => _Transation_ScreenState();
}

class _Transation_ScreenState extends State<Transation_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      Text("Transaction screen"),
    ],),);
  }
}
