import 'package:ebook/app_con.dart';
import 'package:flutter/material.dart';

Widget Status(BuildContext context, String image, String text) {
  return Expanded(
      child: Container(
        // width: 60,
        // color: Colors.black,
    // height: 50,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appcolor,
          ),
          child: Image(
            fit: BoxFit.contain,
            image: AssetImage(image),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text("${text}", style: TextStyle(fontFamily: 'a', fontWeight: FontWeight.w400),textScaleFactor: 1,)
      ],
    ),
  ));
}
