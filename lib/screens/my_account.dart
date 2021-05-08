import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sentars/helpers/auth_service.dart';
import 'package:sentars/screens/change_password.dart';
import 'package:sentars/screens/edit_account.dart';
import 'package:sentars/screens/help.dart';
import 'package:sentars/screens/home_page.dart';
import 'package:sentars/screens/ongoingChannelings.dart';
import 'package:sentars/screens/previous_channelings.dart';

class myaccount extends StatefulWidget{
  final DocumentSnapshot post;

  const myaccount({Key key, this.post}) : super(key: key);

  @override
  _myaccountState createState() => _myaccountState();
}

class _myaccountState extends State<myaccount> {
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
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context,true);
                    },
                child: Align(
                  alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back),
                ),
              ),
            ),
            Center(
                child: Text("My account", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: (){

              },
              child: Stack(
                children: [
                  user!=null ? Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("${user?.photoUrl}"),
                    ),
                  ): Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: MemoryImage(base64Decode(widget.post.data['Photo'])
                    ),
                  ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //Text("${user?.uid}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Text(user?.displayName != null ?  user.displayName : widget.post.data['username'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Text(user?.email != null ?  user.email : widget.post.data['email'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditAccount(post : widget.post)),
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
                      Icons.edit,
                      size: 25,
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text("Edit account", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
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
                  MaterialPageRoute(builder: (context) => ChangePassword(post : widget.post)),
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
                      Icons.account_box,
                      size: 25,
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text("Change password", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
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
                  MaterialPageRoute(builder: (context) => OngoingChannelings(post : widget.post)),
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
                      Icons.run_circle_outlined,
                      size: 25,
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text("Ongoing channelings", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
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
                  MaterialPageRoute(builder: (context) => PreviousChannelinList(post: widget.post,)),
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
                      Icons.calendar_today_sharp,
                      size: 25,
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text("Previous prescriptions", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
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
            )
          ],
        ),
      ),
      )
    );
  }
}