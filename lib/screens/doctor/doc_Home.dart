import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentars/helpers/auth_service.dart';
import 'file:///E:/Developments/Flutter/Mobile/sentars/lib/screens/doctor/appoinmentList.dart';
import 'file:///E:/Developments/Flutter/Mobile/sentars/lib/screens/doctor/docChangePass.dart';
import 'package:sentars/screens/help.dart';
import 'package:sentars/screens/sign_in.dart';

class DocHome extends StatefulWidget{
  final DocumentSnapshot post;

  const DocHome({Key key, this.post}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DocHomeState();
  }
}


class _DocHomeState extends State<DocHome>{

  AuthService authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }
  initUser() async {
    user = await _auth.currentUser();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new ExactAssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover
              ),
              color: Colors.white
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7)
          ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Center(
                    child: Text("Welcome to SENTARS MEDICALS", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                ),
                SizedBox(
                  height: 80,
                ),
                Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: MemoryImage(base64Decode(widget.post.data['Photo'])),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //Text("${user?.uid}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                Text("Dr. " +widget.post.data['Fname']+ " " +widget.post.data['Lname'] , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                Text(widget.post.data["Email"], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                Text(widget.post.data["Sarea"], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DocChangePass(post : widget.post)));
                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          size: 25,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text("Change Password", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AppoinmentList(post : widget.post)),
                    );

                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.view_agenda,
                          size: 25,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text("View Appoinment", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Help()),
                    );

                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.help,
                          size: 25,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text("Help", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async{
                    FirebaseUser user = await authService.signOut().whenComplete(() => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signin()),
                    ),
                    );

                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.logout,
                          size: 25,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text("SignOut", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

}