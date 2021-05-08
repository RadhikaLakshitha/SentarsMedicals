import 'dart:ui';

import 'package:sentars/screens/register_screen.dart';
import 'package:sentars/screens/sign_in.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Image.asset("assets/images/app_main_logo.png"),
                SizedBox(height: 30),
                Text("Sentars \nMedicals", textAlign: TextAlign.center, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),),
                SizedBox(height: 130),
                new FlatButton(
                  minWidth: 250,
                  color: Colors.blue,
                    child: new Text("Sign In",style: TextStyle(color: Colors.white, fontSize: 17),),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signin()),
                      );
                    },
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                ),
                SizedBox(height: 15,),
                new FlatButton(
                    minWidth: 250,
                    color: Colors.blue,
                    child: new Text("Register",style: TextStyle(color: Colors.white, fontSize: 17),),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                ),
              ]
          ),
        ),
      )
    );
  }
}
