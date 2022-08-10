import 'package:ebook/app_con.dart';
import 'package:flutter/widgets.dart';

Widget button(BuildContext context, String text) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width * 0.8,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: appcolor,
    ),
    child: Text(
      text,
      style: TextStyle(fontFamily: 'a', color: white),
      textScaleFactor: 1.2,
    ),
  );
}
