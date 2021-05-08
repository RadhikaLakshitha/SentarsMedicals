import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sentars/helpers/auth_service.dart';
import 'file:///E:/Developments/Flutter/Mobile/sentars/lib/screens/doctor/doc_signin.dart';
import 'package:sentars/screens/forgot_Password.dart';
import 'package:sentars/screens/home_page.dart';
import 'package:sentars/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



final doc = Firestore.instance.collection("doctor");

class Signin extends StatefulWidget{
  final DocumentSnapshot post;

  const Signin({Key key, this.post}) : super(key: key);


  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  dynamic data;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthService authService = AuthService();

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
                    children: [

                      SizedBox(height: 50),
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
                        height: 2,
                      ),
                      Container(
                        alignment: Alignment(0.5,0.0),
                        padding: EdgeInsets.only(top: 15, left: 20),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPassword()),
                            );
                          },
                          child: Text('Forgot Password?',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      new FlatButton(
                          minWidth: 200,
                          color: Colors.blue,
                          child: new Text("Sign In",style: TextStyle(color: Colors.white, fontSize: 17),),
                          onPressed: () async{

                            storeLogingInfo(true);

                            if(_formKey.currentState.validate()) {

                              var res = await Firestore.instance.collection("user").document(email).get();

                              if (res.exists) {


                                var post = await Firestore.instance.collection("user").document(email).get().then((DocumentSnapshot snapshot) async {
                                  var e = snapshot.data['email'];
                                  var p = snapshot.data['password'];


                                  if (e == email && p == pass) {

                                    try {

                                      bool email = await getLoggedInfo();

                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                        return email ? HomePage(post: snapshot,) : Signin(post: snapshot,);
                                      } ));
                                      print(snapshot.data);
                                    } catch (ee) {
                                      print(ee.message);
                                    }

                                  }
                                });

                              }else
                                {
                                errorLogin(context);
                              }
                            }

                          },
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Center(
                          child:
                          RichText(text: TextSpan(
                            text: 'Don\'t have a account?',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                              text: 'Register',
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            ]
                          ),),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      new FlatButton(
                          minWidth: 200,
                          color: Colors.green,
                          child: new Text("Sign In with google",style: TextStyle(color: Colors.white, fontSize: 17),),
                          onPressed: () async {
                            FirebaseUser user = await authService.googleSignIn();
                            if(user.email != null){


                              Map<String, dynamic> userData = {
                                "username": user.displayName.toString(),
                                "email": user.email,
                                "Role": "user",
                                "Photo": user.photoUrl.toString(),

                              };
                              DocumentReference docref = Firestore.instance.collection("user").document(user.email.toString());
                              docref.setData(userData);

                              Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => HomePage(user: user,)));

                            }else{
                              Scaffold.of(context).showSnackBar(new SnackBar(
                                content: new Text('Sign In Faild'),
                              ));
                            }


                          },
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                      ),
                      SizedBox(
                        height: 200,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DocSignIn()),
                          );
                        },
                        child: Center(
                          child:
                          RichText(text: TextSpan(
                              text: 'For Doctors Sign In  ',
                              style: TextStyle(color: Colors.black, fontSize: 15),
                              children: [
                                TextSpan(
                                  text: 'Click here',
                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                              ]
                          ),),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]
                ),
              ),
            ),
          ),
        )
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
