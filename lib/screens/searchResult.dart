
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sentars/screens/home_page.dart';

import 'doc_list.dart';

class SearchResult extends StatefulWidget {
  final data;

  const SearchResult({Key key, this.data}) : super(key: key);
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data),
        backgroundColor: Colors.grey,
        // leading: InkWell(
        //   onTap: (){
        //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(post: widget.data,)));
        //   },
        //     child: Icon(Icons.arrow_back)),

      ),
      body: SearchDoc(search: widget.data),
    );
  }
}

class SearchDoc extends StatefulWidget {
  final search;

  const SearchDoc({Key key, this.search}) : super(key: key);
  @override
  _SearchDocState createState() => _SearchDocState();
}

class _SearchDocState extends State<SearchDoc> {

  Future getDoctors() async {
    var db = Firestore.instance;
    QuerySnapshot qn = await db.collection("doctor").where("Fname", isEqualTo: widget.search.toString()).getDocuments();
    return qn.documents;
  }

  navigateToDetails(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorView(post: post,)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getDoctors(),
          builder: (_, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: Text("Loading..."),
              );
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index){
                    final img = base64Decode(snapshot.data[index].data["Photo"]);

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: MemoryImage(img),
                          radius: 25,
                        ),
                        title: Text("Dr. "+snapshot.data[index].data["Fname"]+" "+snapshot.data[index].data["Lname"] ),
                        subtitle: Text(snapshot.data[index].data["Sarea"]),
                        onTap: () => navigateToDetails(snapshot.data[index]),
                      ),


                    );

                  });

            }
          }),
    );
  }
}

