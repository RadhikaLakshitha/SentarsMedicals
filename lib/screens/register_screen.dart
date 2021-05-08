import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sentars/helpers/auth_service.dart';
import 'package:sentars/screens/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget{
  String username,email,pass;
  String mobile;
  GlobalKey<FormState> _key = new GlobalKey();
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference reference = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        key: _key,
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signin()),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 5),
                    Image.asset("assets/images/app_main_logo.png",
                      height: 70,
                      width: 70,
                    ),
                    SizedBox(height: 10),
                    Text("Sentars \nMedicals", textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),),
                    SizedBox(height: 10,),
                    Container(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("   Sign up", textAlign: TextAlign.right, style: TextStyle(fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold),)),
                        ),
                    SizedBox(height: 20,),
                    Container(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: <Widget> [
                              IconButton(icon: Icon(Icons.person, size: 40,), onPressed: () {}),
                              Expanded(child:
                              Container(
                                  margin: EdgeInsets.only(left: 12, right: 30),
                                  child: TextFormField(
                                    onChanged: (val){
                                      username = val;
                                    },


                                    validator: (value){
                                      if(value.isEmpty){
                                        return "*required";
                                      }else{
                                        username = value;
                                      }
                                      return null;
                                    },


                                    onSaved: (value){
                                      username = value;
                                    },


                                    decoration: InputDecoration(
                                      hintText: 'Username',
                                    ),
                                  )))
                            ],),
                        ),
                        )
                      ),
                    SizedBox(height: 5,),
                    Container(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top:0.5, left: 30, right: 50),
                            child: Row(
                              children: <Widget> [
                                IconButton(icon: Icon(Icons.email, size: 40,), onPressed: () {}),
                                Expanded(child:
                                Container(
                                    margin: EdgeInsets.only(left: 12, right: 10),
                                    child: TextFormField(
                                      onChanged: (val){
                                        email = val;
                                      },

                                      validator: (value){
                                        if(value.isEmpty){
                                          return "Invalid Email address";
                                        }
                                        if (!RegExp(
                                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value))
                                        {
                                          return 'Invalid Email format';
                                        }
                                        return null;
                                      },



                                      onSaved: (value){
                                        email = value;
                                      },

                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                      ),
                                    )))
                              ],),
                          ),

                        )
                    ),
                    SizedBox(height: 30,),
                    Container(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top:0.5, left: 30, right: 50),
                            child: Row(
                              children: <Widget> [
                                IconButton(icon: Icon(Icons.lock, size: 40,), onPressed: () {}),
                                Expanded(child:
                                Container(
                                    margin: EdgeInsets.only(left: 12, right: 10),
                                    child: TextFormField(
                                      obscureText: true,
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
                                        hintText: 'Password',
                                      ),
                                    )))
                              ],),
                          ),

                        )
                    ),
                    SizedBox(height: 30,),
                    Container(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top:0.5, left: 30, right: 50),
                            child: Row(
                              children: <Widget> [
                                IconButton(icon: Icon(Icons.phone, size: 40,), onPressed: () {}),
                                Expanded(child:
                                Container(
                                    margin: EdgeInsets.only(left: 12, right: 10),
                                    child: TextFormField(
                                      onChanged: (val){
                                        mobile = val;
                                      },

                                      validator: (value){
                                        if(value.isEmpty){
                                          return "*required";
                                        }else{
                                          mobile = value;
                                        }
                                        return null;
                                      },


                                      onSaved: (value){
                                        mobile = value;
                                      },

                                      decoration: InputDecoration(
                                        hintText: 'Mobile',
                                      ),
                                    )))
                              ],),
                          ),

                        )
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    new FlatButton(
                        minWidth: 200,
                        color: Colors.blue,
                        child: new Text("Sign up",style: TextStyle(color: Colors.white, fontSize: 17),),
                        onPressed: () async {

                          try {
                            if (_formKey.currentState.validate()) {

                              //final check = FirebaseAuth.instance.fetchSignInMethodsForEmail(email: email);
                              FirebaseUser result = await _auth
                                  .createUserWithEmailAndPassword(
                                  email: email, password: pass);
                              Map<String, dynamic> userData = {
                                "username": username,
                                "email": email,
                                "password": pass,
                                "mobile": mobile,
                                "Role": "user",
                                "Photo": "",
                              };
                              DocumentReference docref = Firestore.instance.collection("user").document(email.toString());
                              docref.setData(userData);
                              // CollectionReference collectionReference = Firestore
                              //     .instance.collection('user');
                              // collectionReference.add(userData);
                              dialog(context);
                            } else {
                              emailerror(context);
                            }
                          }catch(e){
                            print(e);
                            emailerror(context);
                          }

                        },
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                    ),
                    SizedBox(
                      height: 120,
                    ),
                  ]
              ),
            ),
          ),
        ),
      )
    );
  }
  void dialog(BuildContext context){

    var alertDialog = CupertinoAlertDialog(
      title: Text("Registered Successfully"),
      content: Text("\nYou have to Sgin in again", style: TextStyle(fontSize: 15),),
      actions: [
        CupertinoDialogAction(child: Text("OK"),onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Signin()),
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

  void emailerror(BuildContext context){

    var alertDialog = CupertinoAlertDialog(
      title: Text("Email is already used"),
      actions: [
        CupertinoDialogAction(child: Text("OK"),onPressed: (){
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => Register()),
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
