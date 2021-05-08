import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentars/helpers/chennelID.dart';
import 'package:sentars/screens/ongoingChannelings.dart';


import 'home_page.dart';


class DocList extends StatefulWidget{

final DocumentSnapshot userinfo;

  const DocList({Key key, this.userinfo}) : super(key: key);



  @override
  State<StatefulWidget> createState() {
    return _DocList();
  }

}

class _DocList extends State<DocList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor List"),
        backgroundColor: Colors.grey,
      ),
      body: List(userinfo: widget.userinfo),
    );

  }

}

class List extends StatefulWidget {
  final DocumentSnapshot userinfo;

  const List({Key key, this.userinfo}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {

  Future getDoctors() async {
    var db = Firestore.instance;
    QuerySnapshot qn = await db.collection("doctor").getDocuments();
    return qn.documents;
  }

  navigateToDetails(DocumentSnapshot post, DocumentSnapshot userinfo){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorView(post: post, userinfo: widget.userinfo)));
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
                  onTap: () => navigateToDetails(snapshot.data[index], widget.userinfo),
                ),


                );

          });

        }
      }),
    );
  }
}

class DoctorView extends StatefulWidget {
  final DocumentSnapshot post;
  final DocumentSnapshot user;
  final DocumentSnapshot doc;
  final DocumentSnapshot userinfo;


  const DoctorView({ this.post, this.user, this.doc, this.userinfo, });


  @override
  _DoctorViewState createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 35,),
            Container(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
                  Navigator.pop(context, true);
                }),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.memory(base64Decode(widget.post.data["Photo"]),
                    height: size.height * 0.40,
                    width: size.height * 0.40,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xffFEE2DE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Expanded(
                      child: Column(
                        children: [
                          Text("About", style: TextStyle(fontSize: 30,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[400]),),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Name : Dr. " + widget.post.data["Fname"] + " " +
                              widget.post.data["Lname"], style: TextStyle(
                              fontSize: 15),),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Specialize area : " + widget.post.data["Sarea"],
                            style: TextStyle(fontSize: 15),),
                          SizedBox(
                            height: 25,
                          ),
                          Text(widget.post.data["About"],
                            style: TextStyle(fontSize: 12),),
                          Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(20),
                          ),
                          new FlatButton(
                              minWidth: 200,
                              color: Colors.green[400],
                              child: new Text("Appoinment Now",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),),
                              onPressed: () async {
                                FirebaseUser user = await FirebaseAuth.instance.currentUser();

                                channelID(user?.email != null  ?   user.email  :widget.userinfo.data['email'], widget.post.data['Fname'], widget.post.data['Email'], user?.displayName != null  ?   user.displayName  : widget.userinfo.data['username']);
                                print(widget.post.data['email']);


                                dialog(context);
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0))
                          ),
                          SizedBox(height: 80,)
                        ],

                      ),
                    ),
                  )


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> dialog(BuildContext context) async {
    // await Firestore.instance.collection("channel").document(
    //     widget.userinfo.data['email'].toString()).get().then((
    //     DocumentSnapshot snapshot) {
    //   var e = snapshot.data['channelNo'];


      var alertDialog = CupertinoAlertDialog(
        title: Text("Appoinment is done"),
        content: Text(
          "\nYour can check the channel no in your profile(Ongoing Channelings section) ", style: TextStyle(fontSize: 15),),
        actions: [
          CupertinoDialogAction(child: Text("OK"), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OngoingChannelings(post: widget.userinfo,)),
            );
          },),
        ],

      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialog;
          }
      );
    }
  }




