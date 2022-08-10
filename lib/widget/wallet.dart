import 'package:ebook/app_con.dart';
import 'package:flutter/material.dart';

Widget Wallet(BuildContext context, String balance) {
  return Column(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Color(0xffE55E5E),
            gradient: LinearGradient(
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
              colors: [
                Color(0xffE55E5E),
                appcolor,
              ],
            )),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.3,
              child: Image(
                image: AssetImage("assets/images/wallet.png"),
              ),
            ),
            Expanded(
                child: Container(
              child: Text(
                balance,
                style: TextStyle(
                    color: white,
                    fontFamily: 'a',
                    fontWeight: bold,
                    decoration: TextDecoration.underline),
                textScaleFactor: 1.5,
              ),
            ))
          ],
        ),
      ),
      // SizedBox(height: 20,),
      // Container(
      //   width: MediaQuery.of(context).size.width * 0.9,
      //   height: 50,
      //   child: Row(
      //     children: [
      //       Expanded(child: Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),

      //         ),
      //       )),
      //       Expanded(child: Container())
      //     ],
      //   ),
      // )
    ],
  );
}
