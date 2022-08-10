import 'package:ebook/app_con.dart';
import 'package:flutter/material.dart';

Widget Favorite(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: appcolor.withOpacity(0.1),
        border: Border.all(color: appcolor, width: 0.5),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Icon(
          Icons.favorite,
          color: Colors.pink,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          "Favorite",
          style: TextStyle(fontFamily: 'a'),
          textScaleFactor: 1,
        )),
        Icon(
          Icons.arrow_forward_ios,
          color: appcolor,
        )
      ],
    ),
  );
}

Widget ShippingAdress(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: appcolor.withOpacity(0.1),
        border: Border.all(color: appcolor, width: 0.5),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Icon(
          Icons.local_shipping,
          color: Colors.orange,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          "Shipping Adress",
          style: TextStyle(fontFamily: 'a'),
          textScaleFactor: 1,
        )),
        Icon(
          Icons.arrow_forward_ios,
          color: appcolor,
        )
      ],
    ),
  );
}

Widget Setting(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: appcolor.withOpacity(0.1),
        border: Border.all(color: appcolor, width: 0.5),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Icon(
          Icons.settings,
          color: Colors.purple,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          "Setting",
          style: TextStyle(fontFamily: 'a'),
          textScaleFactor: 1,
        )),
        Icon(
          Icons.arrow_forward_ios,
          color: appcolor,
        )
      ],
    ),
  );
}

Widget Logout(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: appcolor.withOpacity(0.1),
        border: Border.all(color: appcolor, width: 0.5),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Icon(
          Icons.logout,
          color: Colors.red,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          "Logout",
          style: TextStyle(fontFamily: 'a'),
          textScaleFactor: 1,
        )),
        // Icon(
        //   Icons.arrow_forward_ios,
        //   color: maincolor,
        // )
      ],
    ),
  );
}
