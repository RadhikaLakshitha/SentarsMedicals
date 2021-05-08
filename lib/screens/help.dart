import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentars/screens/my_account.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatelessWidget{

void customLaunch(command) async{
  if (await canLaunch (command)){
  await launch(command);
  }else{
    print('could not launch $command');
  }
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
        child: SingleChildScrollView(
          child: Container(
          width: MediaQuery.of(context).size.width,decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                      Navigator.pop(context,true);
                    }),
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          Text("Do You need a help?",style: TextStyle(fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),),
                          SizedBox(height: 30,),
                          Text("Please contact us using below options",style: TextStyle(fontSize: 15, color: Colors.black),),
                          SizedBox(height: 50,),
                          new FlatButton(
                              minWidth: 200,
                              color: Colors.green[400],
                              child: new Text("Call our hotline",style: TextStyle(color: Colors.white, fontSize: 17),),
                              onPressed: (){
                                customLaunch('tel:+94778091971');
                              },
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                          ),
                          SizedBox(height: 40,),
                          new FlatButton(
                              minWidth: 200,
                              color: Colors.green[400],
                              child: new Text("Email Us",style: TextStyle(color: Colors.white, fontSize: 17),),
                              onPressed: (){
                                customLaunch(
                                    'mailto:sentarsmedicals@gmail.com?subject=test%20subject&body=test%20body');

                              },
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                          ),
                          SizedBox(height: 40,),
                          new FlatButton(
                              minWidth: 200,
                              color: Colors.green[400],
                              child: new Text("SMS with Us",style: TextStyle(color: Colors.white, fontSize: 17),),
                              onPressed: (){
                                customLaunch('sms:0778091971');
                              },
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                          ),
                          SizedBox(height: 40,),
                          new FlatButton(
                              minWidth: 200,
                              color: Colors.green[400],
                              child: new Text("Visit to our facebook page",style: TextStyle(color: Colors.white, fontSize: 17),),
                              onPressed: (){
                                customLaunch('https://google.com');
                              },
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(20),
                          ),
                          SizedBox(height: 90,)

                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}