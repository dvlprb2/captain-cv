import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';

class Spinner extends StatelessWidget {
  const Spinner() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitFadingFour(
        color: Vx.red600,
        size: 30.0,
      ),
    );
  }
}
