import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sentars/helpers/auth_service.dart';
import 'package:sentars/screens/sign_in.dart';

class ForgotPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _forgotpass();
    
  }

}

class _forgotpass extends State<ForgotPassword>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  AuthService authService = AuthService();
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
            child: Form(
              key: _formKey,
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
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Reset password", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                      )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("We will mail a reset link to your mailbox. Please click on that to reset the password", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Theme(data: ThemeData(
                    hintColor: Colors.red
                  ),
                      child: Padding (padding: EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            onChanged: (val){
                              email = val;
                            },
                            validator: (value){
                                if(value.isEmpty){
                                  return "please enter the email";
                                }else{
                                  email = value;
                                }if (!RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value))
                                {
                                  return 'Invalid Email format';
                                }
                                return null;
                            },
                            onSaved: (_email){
                              email = _email;
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter the Email'
                            ),
                          ),

                  )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  new FlatButton(
                      minWidth: 200,
                      color: Colors.blue,
                      child: new Text("Reset Password",style: TextStyle(color: Colors.white, fontSize: 17),),
                      onPressed: () async{
                        try {
                          if (_formKey.currentState.validate()) {
                            await authService.resetPassword(email);
                            dialog(context);
                            return;
                          } else {
                            print("Invalid email");
                          }
                        } catch(e){
                          print(e.message);

                        }

                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                  ),
                  Container(

                    padding: EdgeInsets.only(top: 10, left: 0),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) => Signin()),
                        );
                      },
                      child: Text('Return to Sign In',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  void dialog(BuildContext context){

    var alertDialog = CupertinoAlertDialog(
      title: Text("Reset password Successfully"),
      content: Text("\nPlease click the reset password link in your mailbox", style: TextStyle(fontSize: 15),),
      actions: [
        CupertinoDialogAction(child: Text("OK"),onPressed: (){
          Navigator.pop(
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
}