import 'package:captain_cv/adapters/user.dart';
import 'package:captain_cv/screens/GetStarted.dart';
import 'package:captain_cv/screens/Home.dart';
import 'package:captain_cv/widgets/Spinner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  await Hive.openBox<User>('user');
  runApp(MyApp());
}

Future<bool> isLoggedIn() async {
  Box<User> box = Hive.box<User>('user');
  return box.get('user') != null;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Captain CV',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 102, color: Color(0xff4a4c4f))),
            headline2: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 64, color: Color(0xff4a4c4f))),
            headline3: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 51, color: Color(0xff4a4c4f))),
            headline4: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 36, color: Color(0xff4a4c4f))),
            headline5: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 25, color: Color(0xff4a4c4f))),
            headline6: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 18, color: Color(0xff4a4c4f))),
            subtitle1: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 17, color: Color(0xff4a4c4f))),
            subtitle2: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 15, color: Color(0xff4a4c4f))),
            bodyText1: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 16, color: Color(0xff4a4c4f))),
            bodyText2: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 14, color: Color(0xff4a4c4f))),
            button: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 15, color: Color(0xff4a4c4f))),
            caption: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 13, color: Color(0xff4a4c4f))),
            overline: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 11, color: Color(0xff4a4c4f))),
          )),
      home: FutureBuilder(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            if (snapshot.hasData && snapshot.data == true) {
              return Home();
            } else {
              return GetStarted();
            }
          }

          return Spinner();
        },
      ),
    );
  }
}
