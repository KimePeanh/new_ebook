import 'package:ebook/app_con.dart';
import 'package:ebook/bottom_navigation.dart';
import 'package:ebook/home_screen.dart';
import 'package:ebook/share_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> Login({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavigator()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    "Sign in to your account",
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
                  SizedBox(height: 5),
                  Container(
                    width: width * 0.93,
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(fontFamily: 'a', color: Colors.grey),
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
                          child: button(context, "Sign in"),
                          onTap: () {
                            Login(
                                email: emailController.text.toString(),
                                password: passwordController.text.toString());
                          },
                        )
                      : Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: appcolor.withOpacity(0.4),
                          ),
                          child: Text(
                            "Sign in",
                            style: TextStyle(fontFamily: 'a', color: appcolor),
                            textScaleFactor: 1.2,
                          ),
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
                      text: "Don't have an account?",
                      style: TextStyle(fontFamily: 'a', color: grey),
                    ),
                    TextSpan(
                      text: ' Signup',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'a',
                          color: appcolor),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/signup");
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
