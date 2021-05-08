import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentars/helpers/auth_service.dart';
import 'file:///E:/Developments/Flutter/Mobile/sentars/lib/screens/doctor/doc_Home.dart';

class DocChangePass extends StatefulWidget {
  final DocumentSnapshot post;

  const DocChangePass({Key key, this.post}) : super(key: key);

  @override
  _DocChangePassState createState() => _DocChangePassState();
}

class _DocChangePassState extends State<DocChangePass> {

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference reference = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String pass, cpass, nic;


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
            width: MediaQuery.of(context).size.width,decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7)
          ),
            child: SingleChildScrollView(
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
                      child: Text("Change Password", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: MemoryImage(base64Decode(widget.post.data['Photo']))
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Dr : "+widget.post.data['Fname'] + " " + widget.post.data['Lname'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  Text(widget.post.data['Email'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            onChanged: (val){
                              pass = val;
                            },

                            validator: (value){
                              if(value.isEmpty){
                                return "*required";
                              }else{
                                pass = value;
                              }
                              return null;
                            },


                            onSaved: (value){
                              pass = value;
                            },


                            decoration: InputDecoration(
                              labelText: "New Password",
                              labelStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: "type here",
                              helperStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(

                            onChanged: (val){
                              cpass = val;
                            },

                            validator: (value){
                              if(value.isEmpty){
                                return "*required";
                              }else{
                                cpass = value;
                              }
                              return null;
                            },


                            onSaved: (value){
                              cpass = value;
                            },


                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: "type here",
                              helperStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          color: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () async {

                              if (_formKey.currentState.validate()) {
                                // if (pass == cpass) {
                                //   final user = await FirebaseAuth.instance
                                //       .currentUser();
                                //   user.updatePassword(pass);

                                  Map<String, dynamic> userData = {
                                    "Password": pass,
                                    "Cpassword": cpass,
                                  };
                                  Firestore.instance.collection('doctor')
                                      .where('Email', isEqualTo: widget.post.data['Email'])
                                      .getDocuments()
                                      .then((querySnapshot) {
                                    querySnapshot.documents.forEach((
                                        documentSnapshot) {
                                      documentSnapshot.reference.updateData(
                                          userData);
                                    });
                                  });
                                  change(context);
                                } else {
                                  if (pass != cpass) {
                                    error(context);
                                  }
                                }
                              },
                          child: Text(
                            "Change",
                            style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 2.2,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () async{
                            _formKey.currentState.reset();

                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 2.2,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),)
                      ],
                    ),
                  )
                ],
              ),
            ),

          ),
        );
  }

  void change(BuildContext context){

    var alertDialog = CupertinoAlertDialog(
      title: Text("Your password has been changed"),
      content: Text("Pleasse use this password for the next login"),

      actions: [
        CupertinoDialogAction(child: Text("OK"),onPressed: (){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DocHome(post: widget.post,)),
          );
        },),
      ],

    );

    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );

  }

  void error(BuildContext context){

    var alertDialog = CupertinoAlertDialog(
      title: Text("Password is not matching"),
      content: Text("Please enter the password again"),

      actions: [
        CupertinoDialogAction(child: Text("OK"),onPressed: (){
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => DocChangePass()),
          );
        },),
      ],

    );

    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );

  }

}






