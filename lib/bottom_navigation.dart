import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/app_con.dart';
import 'package:ebook/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'account_screen.dart';
import 'cart_screen.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        navBarStyle: NavBarStyle.style6,
        screens: _buildScreens(),
        items: _navBarsItems(),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      Container(),
      CartScreen(),
      Container(),
      AccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        textStyle: TextStyle(fontFamily: 'b'),
        activeColorPrimary: appcolor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        textStyle: TextStyle(fontFamily: 'b'),
        activeColorPrimary: appcolor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("cart")
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.docs[0].get("carts").length != 0
                  ? Badge(
                      shape: BadgeShape.circle,
                      // padding: EdgeInsets.only(right: 10),
                      position: BadgePosition.topEnd(top: -10, end: -10),
                      borderRadius: BorderRadius.circular(100),
                      child:
                          Icon(Icons.shopping_cart_outlined, ),
                      badgeContent: Text(
                        snapshot.data!.docs[0].get("carts").length.toString(),
                        style: TextStyle(color: white),
                      ))
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: appcolor,
                      ));
            } else {
              return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: appcolor,
                  ));
            }
          },
        ),
        title: ("Cart"),
        textStyle: TextStyle(fontFamily: 'b'),
        activeColorPrimary: appcolor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        title: ("Notification"),
        textStyle: TextStyle(fontFamily: 'b'),
        activeColorPrimary: appcolor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Account"),
        textStyle: TextStyle(fontFamily: 'b'),
        activeColorPrimary: appcolor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
