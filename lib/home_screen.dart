import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/app_con.dart';
import 'package:ebook/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imageslider = [
    "assets/images/image 1.png",
    "assets/images/image 1(1).png",
    "assets/images/image 1(2).png",
    "assets/images/image 1(3).png",
  ];

  int indexx = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: width,
                height: height * 0.4,
                decoration: BoxDecoration(
                    color: appcolor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(40))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SafeArea(
                      child: Container(
                        height: height * 0.23,
                        width: width,
                        child: CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  indexx = index;
                                });
                              }),
                          items: imageslider
                              .map((item) => Container(
                                    child: Center(
                                        child: Image.asset(item,
                                            fit: BoxFit.contain, width: 1500)),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageslider.map((url) {
                        int index = imageslider.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: indexx == index
                                ? Color(0xff1A1C9D).withOpacity(0.6)
                                : Colors.white.withOpacity(0.4),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: width * 0.9,
                height: height * 0.075,
                decoration: BoxDecoration(
                  color: appcolor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Buy Now",
                      style: TextStyle(fontFamily: 'a', color: white),
                      textScaleFactor: 1.5,
                    )),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      width: 80,
                      height: height * 0.075 - 13,
                      decoration: BoxDecoration(
                          color: Color(0xff1A1C9D).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: width * 0.92,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          "More Books",
                          style: TextStyle(fontFamily: 'b'),
                          textScaleFactor: 1.3,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "See more",
                          style: TextStyle(fontFamily: 'b'),
                          textScaleFactor: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("book")
                      // .where('uid',
                      //     isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                snapshot.data!.docs[0].get("books").length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 6.5 / 8,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      // color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(30),
                                      border:
                                          Border.all(color: black, width: 1)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${snapshot.data!.docs[0].get('books')[index]['title']}",
                                        style: TextStyle(fontFamily: 'a'),
                                      ),
                                      Expanded(
                                          child: Container(
                                        padding: EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        // child: Image(
                                        //     image: NetworkImage(snapshot
                                        //         .data!.docs[0]
                                        //         .get('books')[index]['url'])),
                                        child: FadeInImage.assetNetwork(
                                          imageCacheWidth: 500,
                                          placeholder: 'assets/images/load.gif',
                                          image: snapshot.data!.docs[0]
                                              .get('books')[index]['url'],
                                        ),
                                      )),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            child: Text(
                                              "\$ ${snapshot.data!.docs[0].get('books')[index]['price']}",
                                              style: TextStyle(fontFamily: 'a'),
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: appcolor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              "Buy Now",
                                              style: TextStyle(
                                                  fontFamily: 'a',
                                                  color: white),
                                            ),
                                          ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: ProductDetail(
                                      title: snapshot.data!.docs[0]
                                          .get('books')[index]['title'],
                                      price: snapshot.data!.docs[0]
                                          .get('books')[index]['price'],
                                      image: snapshot.data!.docs[0]
                                          .get('books')[index]['url'],
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                              );
                            }),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
