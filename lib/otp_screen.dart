import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'bottom_navigation.dart';

class OptScreen extends StatefulWidget {
  // const OptScreen({ Key? key }) : super(key: key);
  final String phonenumber;
  final String verificationid;
  final String pw;
  OptScreen(
      {required this.phonenumber,
      required this.verificationid,
      required this.pw});

  @override
  State<OptScreen> createState() => _OptScreenState();
}

class _OptScreenState extends State<OptScreen> {
  @override
  FirebaseAuth _auth = FirebaseAuth.instance;
  var random = new Random();
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                height: height * 0.25,
                child: Image(image: AssetImage("assets/images/otp.jpg")),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Code has been send to +855${widget.phonenumber}",
                style: TextStyle(fontFamily: 'a'),
              ),
              SizedBox(
                height: 30,
              ),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width * 0.9,
                fieldWidth: width / 6 - 15,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) async {
                  try {
                    final PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: widget.verificationid,
                      smsCode: pin,
                    );
                    final User user =
                        (await _auth.signInWithCredential(credential)).user!;
                    if (user.uid.isNotEmpty) {
                      FirebaseFirestore.instance
                          .collection('ebookuser')
                          .doc(user.uid)
                          .set({
                            'id': random.nextInt(1000000).toString(),
                            'username': "",
                            'email': widget.phonenumber,
                            'password': widget.pw,
                            'uid': user.uid,
                            'url':
                                'https://firebasestorage.googleapis.com/v0/b/newonecam-53e7c.appspot.com/o/user%20(1).png?alt=media&token=c4dafa52-3e22-4514-9482-874bd4dde42d',
                          })
                          .then((value) => print('SSS'))
                          .catchError((e) => print(e));
                      user.updateDisplayName("+855" + widget.phonenumber);
                      user.updatePhotoURL(
                          'https://firebasestorage.googleapis.com/v0/b/newonecam-53e7c.appspot.com/o/user%20(1).png?alt=media&token=c4dafa52-3e22-4514-9482-874bd4dde42d');
                      user.reload();
                    }
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigator()));
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
