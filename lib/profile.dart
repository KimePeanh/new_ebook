import 'package:ebook/app_con.dart';
import 'package:flutter/material.dart';

Widget UserProfile(String url, String name) {
  return Column(
    children: [
      SafeArea(
          child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: appcolor.withOpacity(0.3))),
            child: CircleAvatar(
              backgroundColor: white,
              backgroundImage: NetworkImage(url),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            width: 120,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 90, bottom: 15),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(3),
                    decoration:
                        BoxDecoration(color: appcolor, shape: BoxShape.circle),
                    child: Icon(
                      Icons.camera_enhance,
                      color: white,
                      size: 20,
                    )),
              ],
            ),
          )
        ],
      )),
      SizedBox(
        height: 10,
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(fontFamily: 'a', fontWeight: bold),
          textScaleFactor: 1.2,
        ),
      )
    ],
  );
}
