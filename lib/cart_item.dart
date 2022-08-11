import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/app_con.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'checkout_screen.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  static List<String> selecteList = [];
  static List<String> pricelist = [];
  static List<String> urllist = [];
  static List<String> titlelist = [];

  void _onSelectIndex(bool selected, String topupId, double pri, String url,
      String title, String eachprice) {
    if (selected == true) {
      setState(() {
        selecteList.add(topupId);
        price.add(pri);
        urllist.add(url);
        pricelist.add(eachprice);
        titlelist.add(title);
        total = price.sum;
      });
    } else {
      setState(() {
        selecteList.remove(topupId);
        price.remove(pri);
        urllist.remove(url);
        titlelist.remove(title);
        pricelist.remove(eachprice);
        total = price.sum;
      });
    }
  }

  //delete item from cart
  Future<void> DeleteItem({required int index, required List cart}) async {
    cart.remove(cart[index]);
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'carts': cart});
  }

  List<double> price = [];
  int? hi;
  bool isclick = false;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      child: Column(
        children: [
          Expanded(
            flex: 12,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("cart")
                  .where('uid',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs[0].get('carts').length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red.shade600,
                            child: Icon(
                              Icons.delete,
                              color: white,
                              size: 30,
                            ),
                          ),
                          onDismissed: (DismissDirection direction) {
                            DeleteItem(
                                index: index,
                                cart: snapshot.data!.docs[0].get('carts'));
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Checkbox(
                                    shape: CircleBorder(),
                                    value:
                                        selecteList.contains(index.toString()),
                                    onChanged: (selected) {
                                      print(3.0 * 2.0);
                                      setState(() {
                                        _onSelectIndex(
                                            selected!,
                                            index.toString(),
                                            double.parse(snapshot.data!.docs[0]
                                                    .get('carts')[index]
                                                        ['price']
                                                    .toString()) *
                                                double.parse(snapshot
                                                    .data!.docs[0]
                                                    .get('carts')[index]['Qty']
                                                    .toString()),
                                            snapshot.data!.docs[0]
                                                .get('carts')[index]['url'],
                                            snapshot.data!.docs[0]
                                                .get('carts')[index]['title'],
                                            snapshot.data!.docs[0]
                                                .get('carts')[index]['price']);
                                      });
                                    }),
                                Container(
                                  width: width * 0.2,
                                  height: width * 0.2,
                                  child: FadeInImage.assetNetwork(
                                    imageCacheWidth: 500,
                                    placeholder: 'assets/images/load.gif',
                                    image: snapshot.data!.docs[0]
                                        .get('carts')[index]['url'],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${snapshot.data!.docs[0].get('carts')[index]['title']}",
                                            style: TextStyle(fontFamily: 'a'),
                                            textScaleFactor: 1.2,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${snapshot.data!.docs[0].get('carts')[index]['price']}\$",
                                            style: TextStyle(
                                                color: Colors.red.shade600,
                                                fontFamily: 'a',
                                                fontWeight: bold),
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.left,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: int.parse(snapshot.data!.docs[0]
                                                .get('carts')[index]['Qty']
                                                .toString()) ==
                                            1
                                        ? Border.all(color: Colors.grey)
                                        : null,
                                    color: int.parse(snapshot.data!.docs[0]
                                                .get('carts')[index]['Qty']
                                                .toString()) ==
                                            1
                                        ? white
                                        : Colors.red.shade700,
                                  ),
                                  child: Text("-",
                                      style: TextStyle(
                                          color: int.parse(snapshot
                                                      .data!.docs[0]
                                                      .get('carts')[index]
                                                          ['Qty']
                                                      .toString()) ==
                                                  1
                                              ? Colors.grey
                                              : white,
                                          fontWeight: bold,
                                          fontFamily: 'a'),
                                      textScaleFactor: 1.1),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                    '${snapshot.data!.docs[0].get('carts')[index]['Qty']}'),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  child: Text("+",
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: bold,
                                          fontFamily: 'a'),
                                      textScaleFactor: 1.1),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: width,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    // margin: EdgeInsets.all(15),
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "TOTAl",
                              style: TextStyle(color: Colors.grey),
                              textScaleFactor: 1.2,
                            )),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "\$ ${total}",
                              style: TextStyle(color: Colors.red.shade600),
                              textScaleFactor: 1.2,
                            )),
                      ],
                    ),
                  )),
                  Expanded(
                      // flex: 1,
                      child: InkWell(
                    child: Container(
                      color: appcolor,
                      alignment: Alignment.center,
                      child: Text(
                        "CHECKOUT",
                        style: TextStyle(color: white),
                      ),
                    ),
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: CheckoutScreen(
                          price: total,
                          url: urllist,
                          title: titlelist,
                          each: pricelist,
                        ),
                        withNavBar: false,
                      );
                    },
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
