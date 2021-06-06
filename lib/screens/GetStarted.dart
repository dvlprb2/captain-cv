import 'package:captain_cv/adapters/user.dart';
import 'package:captain_cv/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:linkedin_login/linkedin_login.dart';
import "package:velocity_x/velocity_x.dart";

final String redirectUrl = 'http://localhost:3000/auth/linkedin/callback';
final String clientId = '782d781y7xq9hc';
final String clientSecret = 'PibNxbE3KFDIrgKK';

class GetStarted extends StatefulWidget {
  GetStarted() : super();

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool logoutUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: ZStack([
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Image(
                image: AssetImage("assets/images/cover.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: VxBox()
                  .withDecoration(BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Vx.gray900,
                        ],
                        stops: [
                          0.0,
                          0.8
                        ],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        tileMode: TileMode.clamp),
                  ))
                  .width(context.screenWidth)
                  .height(600.0)
                  .make(),
            ),
            Positioned(
              bottom: 0,
              child: VStack(
                [
                  'Captain CV'
                      .text
                      .headline4(context)
                      .fontFamily("SellyCalligraphy")
                      .coolGray100
                      .make()
                      .box
                      .margin(Vx.mV12)
                      .make(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LinkedInUserWidget(
                            destroySession: logoutUser,
                            redirectUrl: redirectUrl,
                            clientId: clientId,
                            clientSecret: clientSecret,
                            projection: [
                              ProjectionParameters.id,
                              ProjectionParameters.localizedFirstName,
                              ProjectionParameters.localizedLastName,
                              ProjectionParameters.firstName,
                              ProjectionParameters.lastName,
                              ProjectionParameters.profilePicture,
                            ],
                            onGetUserProfile:
                                (UserSucceededAction linkedInUser) {
                              Box<User> userBox = Hive.box<User>('user');
                              userBox.put('user',
                                  User(linkedInUser.user.token.accessToken));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Home()));
                            },
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: VxBox(
                            child: ConstrainedBox(
                                constraints: BoxConstraints.expand(),
                                child: MaterialButton(
                                    onPressed: null,
                                    padding: EdgeInsets.all(0.0),
                                    child: Image.asset(
                                        'assets/images/login-button.png'))))
                        .margin(Vx.mV12)
                        .width(context.screenWidth)
                        .height(40.0)
                        .make(),
                  ),
                  "Made with 💙 in india"
                      .text
                      .uppercase
                      .caption(context)
                      .fontWeight(FontWeight.bold)
                      .white
                      .make()
                      .box
                      .margin(Vx.mV8)
                      .make()
                      .shaderMask(
                          gradient: LinearGradient(
                              colors: [Vx.orange400, Vx.white, Vx.green400])),
                ],
                alignment: MainAxisAlignment.end,
                crossAlignment: CrossAxisAlignment.center,
              )
                  .box
                  .width(context.screenWidth)
                  .height(context.screenHeight)
                  .makeCentered(),
            ),
          ]),
        ));
  }
}
