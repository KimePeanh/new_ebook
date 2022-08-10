import 'package:ebook/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigator() async {
    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    // });
    await Future.delayed(Duration(seconds: 2), () {});
    FirebaseAuth.instance.authStateChanges().listen((firebaseuser) {
      print(firebaseuser);
      if (firebaseuser != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigator()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
    });
  }

  @override
  void initState() {
    _navigator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          width: MediaQuery.of(context).size.width * 0.7,
          image: AssetImage("assets/images/logo.png"),
        ),
      ),
    );
  }
}
