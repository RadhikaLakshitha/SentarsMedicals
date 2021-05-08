import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OngoingChannelings extends StatefulWidget {

  final DocumentSnapshot post;

  const OngoingChannelings({Key key, this.post}) : super(key: key);

  @override
  _OngoingChannelingsState createState() => _OngoingChannelingsState();
}

class _OngoingChannelingsState extends State<OngoingChannelings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ongoing channeling List"),
        backgroundColor: Colors.grey,
      ),
      body: UserChannelings(post : widget.post),
    );
  }
}

class UserChannelings extends StatefulWidget {
  final DocumentSnapshot post;

  const UserChannelings({Key key, this.post}) : super(key: key);

  @override
  _UserChannelingsState createState() => _UserChannelingsState();
}

class _UserChannelingsState extends State<UserChannelings> {
  Future getChannelList() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var db = Firestore.instance;
    QuerySnapshot qn = await db.collection("channel").where("userEmail", isEqualTo: user?.email != null  ?   user.email  :   widget.post.data['email']).getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getChannelList(),
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
                        leading: Text("Channel No: " + snapshot.data[index].data['channelNo']),
                        title: Text("Date : "+snapshot.data[index].data["date"]),
                        subtitle: Text("Status : "+snapshot.data[index].data["Status"]),
                      ),


                    );

                  });

            }
          }),
    );
  }
}

