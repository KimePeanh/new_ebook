import 'package:ebook/app_con.dart';
import 'package:ebook/file_pickup/file_pickup_bloc.dart';
import 'package:ebook/payment_method_dialog.dart';
import 'package:ebook/widget/payment_type.dart';
import 'package:ebook/widget/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helper/helper.dart';
import 'indexing/indexing_bloc.dart';
import 'indexing/indexing_event.dart';

enum SingingCharacter { Cash, Transfer }

class CheckoutScreen extends StatefulWidget {
  // const CheckoutScreen({Key? key}) : super(key: key);
  final double price;
  List url;
  List title;
  List each;
  CheckoutScreen(
      {required this.price,
      required this.url,
      required this.title,
      required this.each});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  SingingCharacter? _character = SingingCharacter.Cash;
  IndexingBloc paymentTypeIndexingBloc = IndexingBloc();
  IndexingBloc paymentMethodIndexingBloc = IndexingBloc();
  FilePickupBloc _filePickupBloc = FilePickupBloc();
  String val = "Cash";
  bool isa = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Checkout",
          style: TextStyle(color: black, fontFamily: 'a'),
          textScaleFactor: 1,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: Container(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        UserDetail(),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.url.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          width: width * 0.22,
                                          height: width * 0.22,
                                          child: FadeInImage.assetNetwork(
                                              imageCacheWidth: 500,
                                              placeholder:
                                                  "assets/images/load.gif",
                                              image: widget.url[index])),
                                      Expanded(
                                          child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  widget.title[index],
                                                  style: TextStyle(
                                                      fontFamily: 'a',
                                                      color: Colors.grey,
                                                      fontWeight: bold),
                                                  textScaleFactor: 1.3,
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "\$ ${widget.each[index]}",
                                                  style: TextStyle(
                                                      fontFamily: 'a',
                                                      color: Colors.red.shade600,
                                                      fontWeight: bold),
                                                  textScaleFactor: 1,
                                                ))
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: width * 0.95,
                          // height: 100,
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 15, top: 15),
                          decoration: BoxDecoration(
                              // color: white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Delivery",
                                        style: TextStyle(
                                            fontFamily: 'a',
                                            color: Colors.red.shade600,
                                            fontWeight: bold),
                                        textScaleFactor: 1.1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage('assets/images/Vector.png'),
                                          color: Color(0xffD12C2C),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '1-2 days after payment',
                                          style: TextStyle(
                                            fontFamily: 'a',
                                          ),
                                          textScaleFactor: 1,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                              Text(
                                "1.00 \$",
                                style: TextStyle(
                                    fontFamily: 'a',
                                    color: Colors.red.shade600,
                                    fontWeight: bold),
                                textScaleFactor: 1,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocProvider(
                            create: (BuildContext context) =>
                                paymentTypeIndexingBloc,
                            child: PaymentType()),
                        // Container(
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //           alignment: Alignment.centerLeft,
                        //           padding: EdgeInsets.only(left: 30),
                        //           child: Text(
                        //             "Payment Mathod",
                        //             style: TextStyle(fontFamily: 'a'),
                        //             textScaleFactor: 1.2,
                        //           )),
                        //       ListTile(
                        //         title: const Text('Cash on Delivery'),
                        //         leading: Radio<SingingCharacter>(
                        //           value: SingingCharacter.Cash,
                        //           groupValue: _character,
                        //           onChanged: (SingingCharacter? value) {
                        //             setState(() {
                        //               _character = value;
                        //               isa = false;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //       ListTile(
                        //         title: const Text('Transfer'),
                        //         leading: Radio<SingingCharacter>(
                        //           value: SingingCharacter.Transfer,
                        //           groupValue: _character,
                        //           onChanged: (SingingCharacter? value) {
                        //             setState(() {
                        //               _character = value;
                        //               isa = true;
                        //               print(isa);
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        BlocProvider(
                          create: (BuildContext context) =>
                              paymentMethodIndexingBloc,
                          child: BlocBuilder(
                            bloc: paymentTypeIndexingBloc,
                            builder: (c, state) {
                              if (state == 0) {
                                return Container();
                              } else {
                                paymentMethodIndexingBloc.add(Taped(index: -1));
                                return _paymentMethodWidget(context);
                              }
                            },
                          ),
                        ),

                        BlocBuilder(
                          bloc: paymentTypeIndexingBloc,
                          builder: (context, state) {
                            if (state != 0) {
                              return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // color: Theme.of(context).buttonColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Upload Image"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(),
                                      GestureDetector(
                                        onTap: () {
                                          _showPicker(context);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height:
                                              MediaQuery.of(context).size.width /
                                                  3,
                                          child: AspectRatio(
                                              aspectRatio: 1,
                                              child: BlocBuilder(
                                                bloc: _filePickupBloc,
                                                builder:
                                                    (context, dynamic state) {
                                                  return (state == null)
                                                      ? FittedBox(
                                                          child: Icon(
                                                            Icons
                                                                .add_a_photo_outlined,
                                                            color:
                                                                Colors.grey[300],
                                                          ),
                                                        )
                                                      : Image.file(state);
                                                },
                                              )),
                                        ),
                                      )
                                    ],
                                  ));
                            }
                            return Container();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: width,
                padding: EdgeInsets.only(left: 20),
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      // margin: EdgeInsets.all(15),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "TOTAl",
                                style: TextStyle(color: Colors.grey),
                                textScaleFactor: 1.3,
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "\$ ${widget.price + 1.00}",
                                style: TextStyle(
                                    color: Colors.red.shade600,
                                    fontWeight: bold),
                                textScaleFactor: 1.3,
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
                          "PAY",
                          style: TextStyle(color: white),
                        ),
                      ),
                      onTap: () {},
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        Helper.imgFromGallery((image) {
                          _filePickupBloc.add(image);
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Helper.imgFromCamera((image) {
                        _filePickupBloc.add(image);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _paymentMethodWidget(BuildContext contextt) {
    return Builder(
      builder: (c) {
        return BlocBuilder(
          bloc: BlocProvider.of<IndexingBloc>(c),
          builder: (context, int state) {
            return GestureDetector(
              onTap: () {
                paymentMethodDialog(c);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Choose Payment Method"),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      (paymentMethodIndexingBloc.state == (-1))
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Choose Here",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  flex: 20,
                                  child: Image(
                                    fit: BoxFit.fitWidth,
                                    // width: 15,
                                    // height: 15,
                                    image: AssetImage(
                                        paymentMethodList[state]["image"]),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex: 80,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(paymentMethodList[state]["name"],
                                            textScaleFactor: 1.1),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            paymentMethodList[state]
                                                ["description"],
                                            textScaleFactor: 1.1),
                                      ],
                                    )),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                    ],
                  )),
            );
          },
        );
      },
    );
  }
}
