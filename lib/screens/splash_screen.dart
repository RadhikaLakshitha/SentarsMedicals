import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget{
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/app_main_logo.png', height: 100.0,),
              SizedBox(height: 30),
              Text("Sentars \nMedicals", textAlign: TextAlign.center, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),),
              SizedBox(height: 30,),
              SpinKitFadingCircle(color: Colors.blue,)

            ],
          ),
        ),
      )
    );
  }

}