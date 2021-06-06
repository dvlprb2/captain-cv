import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  Home() : super();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: "Home"
          .text
          .uppercase
          .minFontSize(30.0)
          .makeCentered()
          .box
          .makeCentered(),
    );
  }
}
