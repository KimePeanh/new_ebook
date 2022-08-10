import 'package:ebook/share_widget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(
                child: Image(
              height: width * 0.7,
              image: AssetImage("assets/images/logo.png"),
            )),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome to ebook",
              style: TextStyle(fontFamily: 'b', fontWeight: FontWeight.bold),
              textScaleFactor: 2.5,
            ),
            Text(
              "find your books you want to buy here.",
              style: TextStyle(fontFamily: 'b'),
              textScaleFactor: 2,
            ),
            SizedBox(
              height: 70,
            ),
            InkWell(
              child: button(context, "Next"),
              onTap: () {
                Navigator.of(context).pushNamed("/login");
              },
            )
          ],
        ),
      ),
    );
  }
}
