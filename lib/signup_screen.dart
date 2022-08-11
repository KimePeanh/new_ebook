import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/app_con.dart';
import 'package:ebook/bottom_navigation.dart';
import 'package:ebook/share_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var random = new Random();
  bool rememberMe = false;
  String verificationid = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> Signup(
      {required String email,
      required String password,
      required String username}) async {
    if (email.contains(".com")) {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user!.uid.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('ebookuser')
            .doc(credential.user!.uid)
            .set({
              'id': random.nextInt(1000000).toString(),
              'username': username,
              'email': email,
              'password': password,
              'uid': credential.user!.uid,
              'address': "",
              'phonenumber':"",
              'url':
                  'https://firebasestorage.googleapis.com/v0/b/newonecam-53e7c.appspot.com/o/user%20(1).png?alt=media&token=c4dafa52-3e22-4514-9482-874bd4dde42d',
            })
            .then((value) => print('SSS'))
            .catchError((e) => print(e));
        credential.user!.updateDisplayName(email);
        credential.user!.updatePhotoURL(
            'https://firebasestorage.googleapis.com/v0/b/newonecam-53e7c.appspot.com/o/user%20(1).png?alt=media&token=c4dafa52-3e22-4514-9482-874bd4dde42d');
        credential.user!.reload();

        FirebaseFirestore.instance
            .collection("cart")
            .doc(credential.user!.uid)
            .set({'carts': [], 'uid': credential.user!.uid});
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigator()));
      } else {}
    } else {
      FirebaseAuth _auth = FirebaseAuth.instance;
      print(email.substring(0, 1));
      if (email.substring(0, 1) == "0") {
        try {
          await _auth.verifyPhoneNumber(
              timeout: const Duration(seconds: 60),
              phoneNumber: '+855' + email.substring(1),
              verificationCompleted: (PhoneAuthCredential credential) async {
                SnackBar(
                  content: Text('Hi'),
                  duration: const Duration(milliseconds: 2000),
                );
              },
              verificationFailed: (FirebaseAuthException e) {
                print(e);
                Navigator.pop(context);
                SnackBar(
                  content: Text('Fail'),
                  duration: const Duration(milliseconds: 2000),
                );
              },
              codeSent: (String verification, int? resendToken) async {
                verificationid = await verification;
                print(verificationid);
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OptScreen(
                              phonenumber: emailController.text.substring(1),
                              verificationid: verification,
                              pw: password,
                            )));
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                Navigator.pop(context);
              });
        } catch (e) {
          print(e.toString());
          throw e.toString();
        }
      } else {
        try {
          await _auth.verifyPhoneNumber(
              timeout: const Duration(seconds: 60),
              phoneNumber: '+855' + email,
              verificationCompleted: (PhoneAuthCredential credential) async {
                SnackBar(
                  content: Text('Hi'),
                  duration: const Duration(milliseconds: 2000),
                );
              },
              verificationFailed: (FirebaseAuthException e) {
                print(e);
                Navigator.pop(context);
                SnackBar(
                  content: Text('Fail'),
                  duration: const Duration(milliseconds: 2000),
                );
              },
              codeSent: (String verification, int? resendToken) async {
                verificationid = await verification;
                print(verificationid);
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OptScreen(
                              phonenumber: emailController.text,
                              verificationid: verification,
                              pw: password,
                            )));
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                Navigator.pop(context);
              });
        } catch (e) {
          print(e.toString());
          throw e.toString();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String h = "088712932";
    print(h.substring(1));
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              width: width,
              height: height * 0.3,
              decoration: BoxDecoration(
                  color: appcolor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              child: SafeArea(
                  child: Image(
                // fit: BoxFit.fitWidth,
                image: AssetImage("assets/images/logo.png"),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Sign up for free ",
                    style: TextStyle(fontFamily: 'a'),
                    textScaleFactor: 1.5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width * 0.95,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email*",
                      style: TextStyle(fontFamily: 'a'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: width * 0.95,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: black)),
                          hintText: "Example@gmail.com"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width * 0.95,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password*",
                      style: TextStyle(fontFamily: 'a'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: width * 0.95,
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: black)),
                          suffixIcon: Icon(Icons.visibility),
                          hintText: "************"),
                    ),
                  ),

                  Container(
                    child: Row(
                      children: [
                        Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                                if (rememberMe) {
                                } else {}
                              });
                            }),
                        Text(
                          "Remember me",
                          style: TextStyle(fontFamily: 'a'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // button(context, "Sigin")
                  rememberMe
                      ? InkWell(
                          child: button(context, "Sign up"),
                          onTap: () {
                            Signup(
                                email: emailController.text.toString(),
                                password: passwordController.text.toLowerCase(),
                                username: "");
                          },
                        )
                      : InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: appcolor.withOpacity(0.4),
                            ),
                            child: Text(
                              "Sign up",
                              style:
                                  TextStyle(fontFamily: 'a', color: appcolor),
                              textScaleFactor: 1.2,
                            ),
                          ),
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "Click Remember me pg mak:)");
                          },
                        ),
                  // Expanded(child: Container(

                  //   child: Text("Don't have an account"),
                  // ))
                ],
              ),
            )),
            InkWell(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account.",
                      style: TextStyle(fontFamily: 'a', color: grey),
                    ),
                    TextSpan(
                      text: ' Signin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'a',
                          color: appcolor),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/login");
              },
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
