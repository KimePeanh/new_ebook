import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/app_con.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search = TextEditingController();
  var book = [];
  @override
  Widget build(BuildContext context) {
    book.clear();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Container(
          alignment: Alignment.center,
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            controller: search,
            decoration: InputDecoration(
              hintText: "Search",
              contentPadding: EdgeInsets.only(top: 5, left: 20),
              suffixIcon: Icon(Icons.search),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade200)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade200)),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("book").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // book = [];
            if (snapshot.hasData) {
              snapshot.data!.docs[0].get('books').forEach((data) {
                if (data['title']
                    .toLowerCase()
                    .contains(search.text.toLowerCase())) {
                  book.add(data);
                } else {}
              });

              return Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: book.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Text(book[index]['title']),
                      );
                    }),
              );
            }
            return Container();
          }
          // child: Container(
          //   width: MediaQuery.of(context).size.width,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: ,
          //     itemBuilder: (context, index){

          //   }),
          // ),
          ),
    );
  }
}
