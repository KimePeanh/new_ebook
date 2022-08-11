import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/app_con.dart';
import 'package:ebook/user_information_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("ebookuser")
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
                decoration: BoxDecoration(
                    // color: white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      child: Image(
                        image: AssetImage('assets/images/map.png'),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data!.docs[0].get('username') == ""
                                        ? "Username"
                                        : snapshot.data!.docs[0]
                                            .get('username'),
                                    style: TextStyle(
                                        fontFamily: 'a', fontWeight: bold),
                                    textScaleFactor: 1.1,
                                  ),
                                )),
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data!.docs[0]
                                                .get('email')
                                                .contains("@gmail.com") &&
                                            snapshot.data!.docs[0]
                                                    .get('phonenumber') ==
                                                ""
                                        ? "Enter your phone"
                                        : snapshot.data!.docs[0]
                                            .get('phonenumber'),
                                    style: TextStyle(
                                        fontFamily: 'a', fontWeight: bold),
                                    textScaleFactor: 1.1,
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              snapshot.data!.docs[0].get('address') == ""
                                  ? "Select your location"
                                  : snapshot.data!.docs[0].get('address'),
                              style: TextStyle(
                                  fontFamily: 'a',
                                  fontWeight: bold,
                                  color: Colors.grey),
                              textScaleFactor: 1.1,
                            ),
                          )
                        ],
                      ),
                    )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInformation()));
              },
            );
          }
          return Center();
        });
  }
}
