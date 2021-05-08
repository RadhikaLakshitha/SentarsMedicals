import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sentars/screens/previous_channelings.dart';



class PreviousRecords extends StatefulWidget {

  final DocumentSnapshot post;
  final DocumentSnapshot docinfo;

  const PreviousRecords({Key key, this.post, this.docinfo}) : super(key: key);

  @override
  _PreviousRecordsState createState() => _PreviousRecordsState();
}

class _PreviousRecordsState extends State<PreviousRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.data['username']),
        backgroundColor: Colors.grey,
      ),
      body: Userpres(userpresinfo : widget.post, docinfo : widget.docinfo),

    );
  }
}

class Userpres extends StatefulWidget {
  final DocumentSnapshot userpresinfo;
  final DocumentSnapshot docinfo;

  const Userpres({Key key, this.userpresinfo, this.docinfo}) : super(key: key);

  @override
  _UserpresState createState() => _UserpresState();
}

class _UserpresState extends State<Userpres> {


  Future getPrescriptionList() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var db = Firestore.instance;
    QuerySnapshot qn = await db.collection("prescription").document(widget.userpresinfo.data['userEmail']).collection('preslist').where('docEmail', isEqualTo:  widget.docinfo.data['Email']).getDocuments();
    return qn.documents;
  }

  navigateToChannel(DocumentSnapshot snap){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PrescriptionInfo(post: snap,)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPrescriptionList(),
          builder: (_, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: Text("Loading..."),
              );
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index){

                    return Card(
                      child: ListTile(
                        leading: Text("Channel No : "+snapshot.data[index].data["channelNo"], style: TextStyle(fontSize: 13), ),
                        title: Text("Date : "+snapshot.data[index].data["date"] ),
                        subtitle:Text("Dr. "+snapshot.data[index].data["docEmail"] ),
                        tileColor: Colors.white38,
                        onTap: () => navigateToChannel(snapshot.data[index]),
                      ),


                    );

                  });
            }
          }),
    );
  }
}

