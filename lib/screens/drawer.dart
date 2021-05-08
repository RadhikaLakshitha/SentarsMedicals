import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentars/helpers/auth_service.dart';

import 'file:///E:/Developments/Flutter/Mobile/sentars/lib/screens/doctor/doc_Home.dart';
import 'package:sentars/screens/ongoingChannelings.dart';
import 'package:sentars/screens/previous_channelings.dart';

import 'package:sentars/screens/sign_in.dart';


import 'my_account.dart';

class Mydrawer extends StatefulWidget{
  final DocumentSnapshot post;




  AuthService authService = AuthService();

  final Function onTap;
  Mydrawer({
    this.onTap, this.post,
  });

  @override
  _MydrawerState createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {



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
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => myaccount(post: widget.post,)),
                          );
                        },
                        child: user!= null ? Container(
                          width: 500,
                          height: 50,
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("${user?.photoUrl}"),
                            radius: 25,
                          ),
                        ): Container(
                          width: 500,
                          height: 50,
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundImage: MemoryImage(base64Decode(widget.post.data['Photo'])),
                            radius: 25,
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(user?.displayName != null ?  user.displayName : widget.post.data['username'],
                          style: TextStyle(

                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 3,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(user?.email != null ?  user.email : widget.post.data['email'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: ()=>widget.onTap(
                Navigator.pop(context,true),),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My account'),
              onTap: ()=>widget.onTap(
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => myaccount(post: widget.post,)),
                  )
                  // Navigator.pop(context,true),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('My channelings'),
              onTap: ()=>widget.onTap(
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OngoingChannelings(post: widget.post)),
                  )
              ),
            ),
            Divider(height: 1,),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: () async{
                FirebaseUser user = await authService.signOut().whenComplete(() => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signin()),
                ),
                );


              },
            ),
          ],
        ),
      ),
    );
  }
}
