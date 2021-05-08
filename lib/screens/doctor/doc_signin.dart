
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'doc_Home.dart';

class DocSignIn extends StatefulWidget {

  final DocumentSnapshot post;

  const DocSignIn({Key key, this.post}) : super(key: key);

  @override
  _DocSignInState createState() => _DocSignInState();
}

class _DocSignInState extends State<DocSignIn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email, pass;

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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 100),
                  Image.asset(
                    "assets/images/user.png",
                    height: 125,
                    width: 125,
                  ),
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.only(top:50.0, left: 50, right: 50),
                    child: Row(
                      children: <Widget> [
                        IconButton(icon: Icon(Icons.person), onPressed: () {}),
                        Expanded(child:
                        Container(
                            margin: EdgeInsets.only(left: 12, right: 25),
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
                                  hintText: 'Email'
                              ),
                            )))
                      ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0, left: 50, right: 50),
                    child: Row(
                      children: <Widget> [
                        IconButton(icon: Icon(Icons.lock), onPressed: () {}),
                        Expanded(child:
                        Container(
                            margin: EdgeInsets.only(left: 12, right: 25),
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
                  SizedBox(
                    height: 30,
                  ),
                  new FlatButton(
                      minWidth: 200,
                      color: Colors.blue,
                      child: new Text("Sign In",style: TextStyle(color: Colors.white, fontSize: 17),),
                      onPressed: () async{

                        storeLogingInfo(true);

                        if(_formKey.currentState.validate()) {

                          var res = await Firestore.instance.collection("doctor").document(email).get();

                          if (res.exists) {



                            var post = await Firestore.instance.collection("doctor").document(email).get().then((DocumentSnapshot snapshot) async {

                              var e = snapshot.data['Email'];
                              var p = snapshot.data['Password'];

                              if (e == email && p == pass) {
                                try {

                                  bool email = await getLoggedInfo();

                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return email ? DocHome(post: snapshot,) : DocSignIn(post: snapshot,);
                                  }
                                  ));
                                } catch (ee) {
                                  print(ee.message);
                                }
                              }
                            });

                          }else{
                            errorLogin(context);
                          }
                        }

                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                  ),
                  SizedBox(
                    height: 400,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void errorLogin(BuildContext context){

    var alertDialog = CupertinoAlertDialog(
      title: Image.asset(
        "assets/images/error.png",
        height: 50,
        width: 50,
      ),
      content: Text("Please check Email and Password again"),


    );

    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );

  }

  void storeLogingInfo(bool isLogged) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("email", isLogged);

  }

  Future<bool> getLoggedInfo()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('email') ?? false;

  }

}
