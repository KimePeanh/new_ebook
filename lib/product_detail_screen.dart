import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/app_con.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductDetail extends StatefulWidget {
  // const ProductDetail({ Key? key }) : super(key: key);
  final String title;
  final String price;
  final String image;
  ProductDetail(
      {required this.title, required this.price, required this.image});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ScrollController _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _counter = 1;
  bool dis = false;
  var cart = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
      dis = true;
    });
  }

  void _disCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
        dis = true;
      });
    } else if (_counter == 1) {
      setState(() {
        dis = false;
      });
    }
  }

  void checkcounter() {
    if (_counter == 1) {
      setState(() {
        dis = false;
      });
    } else {
      setState(() {
        dis = true;
      });
    }
  }

  Future<void> addtocart(
      {required String url,
      required String price,
      required int qty,
      required String title}) async {
    Map item = {};
    item.addAll({"url": url, "price": price, "Qty": qty, "title": title});
    final User user = await _auth.currentUser!;
    await FirebaseFirestore.instance
        .collection("cart")
        .get()
        .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.docs.length);

      querySnapshot.docs.forEach((doc) async {
        if (doc["uid"] == user.uid) {
          setState(() {
            cart = doc['carts'];
          });
          cart.add(item);
          await FirebaseFirestore.instance
              .collection("cart")
              .doc(user.uid)
              .update({'carts': cart});
        }
      });
    });
  }

  @override
  void initState() {
    checkcounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: appcolor,
                          statusBarIconBrightness: Brightness.light),
                      elevation: 0,
                      backgroundColor: Colors.white,
                      leading: AspectRatio(
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: RawMaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            elevation: 0.0,
                            fillColor: appcolor.withOpacity(0.3),
                            child:
                                Icon(Icons.arrow_back_rounded, color: appcolor),
                            shape: CircleBorder(),
                          ),
                        ),
                      ),
                      expandedHeight: width,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          background: SafeArea(
                              child: Stack(
                        children: [
                          Center(
                            child: FadeInImage.assetNetwork(
                              imageCacheWidth: 500,
                              placeholder: 'assets/images/load.gif',
                              image: '${widget.image}',
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 20, bottom: 10),
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '1/1',
                                style: TextStyle(color: white),
                              ),
                            ),
                          )
                        ],
                      ))),
                      actions: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: appcolor.withOpacity(0.3),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: Icon(
                                Icons.favorite_border,
                                color: appcolor,
                              )),
                        ),
                        AspectRatio(
                            aspectRatio: 1,
                            // child: Badge(
                            //   badgeContent: Text('3'),
                            //   child: Icon(Icons.settings),
                            // )
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("cart")
                                  .where('uid',
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data!.docs[0]
                                              .get("carts")
                                              .length !=
                                          0
                                      ? Badge(
                                          shape: BadgeShape.circle,
                                          // padding: EdgeInsets.only(right: 10),
                                          position: BadgePosition.topEnd(
                                              top: 0, end: 2),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Icon(
                                              Icons.shopping_cart_outlined,
                                              color: appcolor),
                                          badgeContent: Text(
                                            snapshot.data!.docs[0]
                                                .get("carts")
                                                .length
                                                .toString(),
                                            style: TextStyle(color: white),
                                          ))
                                      : Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.3),
                                          ),
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
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
                            )),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        width: width * 0.96,                   
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(1, 1),
                                blurRadius: 1,
                              ),
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: -Offset(1, 1),
                                blurRadius: 1,
                              )
                            ]),
                        child: Row(children: [                       
                          Expanded(
                            flex: 1,
                              child: Container(
                            child: Text(widget.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontWeight: bold,
                                    fontFamily: 'a'),
                                textScaleFactor: 1.7),
                          )),
                          Expanded(
                            flex: 1,
                              child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("\$${widget.price}",
                                style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontWeight: bold,
                                    fontFamily: 'a'),
                                textScaleFactor: 1.7),
                          )),
                        ])),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: dis
                                  ? null
                                  : Border.all(
                                      color: Colors.grey.shade500, width: 1),
                              color: dis ? appcolor : white,
                            ),
                            child: Text("-",
                                style: TextStyle(
                                    color: dis ? white : black,
                                    fontWeight: bold,
                                    fontFamily: 'a'),
                                textScaleFactor: 1.5),
                          ),
                          onTap: () {
                            _disCounter();
                          },
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text("${_counter}",
                            style: TextStyle(color: black, fontFamily: 'a'),
                            textScaleFactor: 1.5),
                        SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: appcolor),
                            child: Text("+",
                                style: TextStyle(
                                    color: white,
                                    fontWeight: bold,
                                    fontFamily: 'a'),
                                textScaleFactor: 1.5),
                          ),
                          onTap: () {
                            _incrementCounter();
                          },
                        ),
                      ],
                    )
                  ],
                )),
          )),
          Container(
            width: width * 0.95,
            margin: EdgeInsets.only(bottom: 40),
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      decoration: BoxDecoration(
                          color: appcolor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "BUY NOW",
                        style: TextStyle(
                            color: appcolor, fontFamily: 'a', fontWeight: bold),
                        textScaleFactor: 1.1,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      decoration: BoxDecoration(
                          color: appcolor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "ADD TO CART",
                        style: TextStyle(
                            color: white, fontFamily: 'a', fontWeight: bold),
                        textScaleFactor: 1.1,
                      ),
                    ),
                    onTap: () {
                      addtocart(
                          url: widget.image,
                          price: widget.price,
                          qty: _counter,
                          title: widget.title);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
