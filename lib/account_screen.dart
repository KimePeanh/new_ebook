import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/login_screen.dart';
import 'package:ebook/profile.dart';
import 'package:ebook/widget/favorite.dart';
import 'package:ebook/widget/status.dart';
import 'package:ebook/widget/wallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    print('${FirebaseAuth.instance.currentUser}');
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("ebookuser")
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    UserProfile(snapshot.data!.docs[0].get('url'),
                        snapshot.data!.docs[0].get('email')),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      // height: 100,
                      child: Row(
                        children: [
                          Status(context, "assets/images/money.png", "Payment"),
                          Status(context, "assets/images/income.png", "Paid"),
                          Status(context, "assets/images/motorbike.png",
                              "Delivery"),
                          Status(context, "assets/images/done.png", "Received")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Wallet(context, "120 USD"),
                    SizedBox(
                      height: 20,
                    ),
                    Setting(context),
                    SizedBox(
                      height: 10,
                    ),
                    Favorite(context),
                    SizedBox(
                      height: 10,
                    ),
                    ShippingAdress(context),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Logout(context),
                      onTap: () {
                        FirebaseAuth.instance.signOut().then((onValue) {
                          Fluttertoast.showToast(msg: "Logout");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text("data");
          }
        },
      ),
    );
  }
}
