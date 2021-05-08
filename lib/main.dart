
import 'dart:async';
import 'dart:ffi';

import 'package:sentars/screens/login_screen.dart';
import 'package:sentars/screens/register_screen.dart';
import 'package:sentars/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentars/screens/splash_screen.dart';

Future<void> main() async {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Sentars(),
  ));
}

class Sentars extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Sentars> {
  @override
  void initState(){
    super.initState();

    Timer(Duration(seconds: 5), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin())));
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
