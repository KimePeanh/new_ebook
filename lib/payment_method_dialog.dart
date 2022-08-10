import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'indexing/indexing_bloc.dart';
import 'indexing/indexing_event.dart';

List<Map> paymentMethodList = [
  {
    "name": "ABA",
    "image": "assets/images/payment_service/aba.png",
    "description": "002127691 | PEANH KIME"
  },
  {
    "name": "Wing",
    "image": "assets/images/payment_service/wing.png",
    "description": "0887112932"
  },
];
Future<void> paymentMethodDialog(BuildContext c) async {
  return showDialog(
      context: c,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.white,
            content: Container(
              padding: EdgeInsets.all(15),
              //height: 500,
              width: MediaQuery.of(context).size.width - 30,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 5),
                  Text(
                    "Choose Payment Mathod",
                    textScaleFactor: 1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Divider(
                      // height: 8,
                      ),
                  ...paymentMethodList
                      .map(
                        (data) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<IndexingBloc>(c).add(Taped(
                                    index: paymentMethodList.indexOf(data)));
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                color: Colors.green.withOpacity(0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                //color: Colors.red,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      height: 50,
                                      // width: 15,
                                      // height: 15,
                                      image: AssetImage(data["image"]),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data["name"],
                                            textScaleFactor: 0.9,
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            data["description"],
                                            textScaleFactor: 0.85,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 8,
                            )
                          ],
                        ),
                      )
                      .toList()
                ]),
              ),
            ));
      });
}
