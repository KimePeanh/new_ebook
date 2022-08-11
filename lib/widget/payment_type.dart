import 'package:ebook/indexing/indexing_bloc.dart';
import 'package:ebook/indexing/indexing_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //disable cash on delivery
    BlocProvider.of<IndexingBloc>(context).add(Taped(index: 1));

    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: BlocBuilder<IndexingBloc, int>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Type",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 15),
              // Divider(
              //   height: 0,
              // ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<IndexingBloc>(context).add(Taped(index: 0));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      (BlocProvider.of<IndexingBloc>(context).state == 0)
                          ? Icon(Icons.radio_button_checked,
                              color: Theme.of(context).primaryColor)
                          : Icon(Icons.radio_button_unchecked,
                              color: Theme.of(context).primaryColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Cash on Delivery")
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<IndexingBloc>(context).add(Taped(index: 1));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(    
                    children: [
                      Row(
                        children: [
                          (BlocProvider.of<IndexingBloc>(context).state == 1)
                              ? Icon(Icons.radio_button_checked,
                                  color: Theme.of(context).primaryColor)
                              : Icon(Icons.radio_button_off,
                                  color: Theme.of(context).primaryColor),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Transfer")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
