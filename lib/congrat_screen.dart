import 'package:ebook/share_widget.dart';
import 'package:flutter/material.dart';

class CongratScreen extends StatefulWidget {
  const CongratScreen({Key? key}) : super(key: key);

  @override
  State<CongratScreen> createState() => _CongratScreenState();
}

class _CongratScreenState extends State<CongratScreen> {
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
              "Congrats!",
              style: TextStyle(fontFamily: 'b', fontWeight: FontWeight.bold),
              textScaleFactor: 2.5,
            ),
            Text(
              "Your profile is ready to use.",
              style: TextStyle(fontFamily: 'b'),
              textScaleFactor: 2,
            ),
            SizedBox(
              height: 70,
            ),
            InkWell(
              child: button(context, "Go homepage"),
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
