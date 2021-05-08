import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'doc_list.dart';





class Neurologist extends StatefulWidget {
  @override
  _NeurologistState createState() {
    return _NeurologistState();
  }

}

class _NeurologistState extends State<Neurologist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neurologist List"),
        backgroundColor: Colors.grey,
      ),
      body: NeuroList(),

    );
  }
}

class NeuroList extends StatefulWidget {
  @override
  _NeuroListState createState() => _NeuroListState();
}

class _NeuroListState extends State<NeuroList> {

  Future getDoctors() async {
    var db = Firestore.instance;
    QuerySnapshot qn = await db.collection("doctor").where("Sarea", isEqualTo: "Neurologist").getDocuments();
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
                        subtitle: Text(snapshot.data[index].data["Email"]),
                         onTap: () => navigateToDetails(snapshot.data[index]),
                      ),


                    );

                  });

            }
          }),
    );
  }
}
