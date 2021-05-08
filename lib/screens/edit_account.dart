import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sentars/helpers/auth_service.dart';
import 'package:sentars/screens/home_page.dart';
import 'package:sentars/screens/sign_in.dart';


class EditAccount extends StatefulWidget{
  final DocumentSnapshot post;

  const EditAccount({Key key, this.post}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EditAccount();
  }
}


class _EditAccount extends State<EditAccount>{

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference reference = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username, mobile;
  File file;


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
              fit: BoxFit.fill
          ),
          color: Colors.white
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    child: Text("Edit account", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: (){
                    pickphoto();
                    dialog(context);
                  },
                  child: Stack(
                    children: [
                      user!=null ? Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage("${user?.photoUrl}"),
                        ),
                      ) : Center(
                            child: CircleAvatar(
                            radius: 50,
                            backgroundImage: MemoryImage(base64Decode(widget.post.data['Photo'])),
                          ),
                      ),
                      Align(
                        alignment: Alignment(0.2,0),
                        child: Container(
                          height: 50,
                          width: 30,
                          margin: EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(
                            color: Theme.of(context).focusColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt, color: Colors.black87,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(user?.displayName != null ?  user.displayName : widget.post.data['username'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                Text(user?.email != null ?  user.email : widget.post.data['email'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextFormField(

                          onChanged: (val){
                            username = val;
                          },

                          validator: (val){
                            if(val.isEmpty){
                              return "*required";
                            }else{
                              username = val;
                            }
                            return null;
                          },

                          onSaved: (val){
                            username = val;
                          },


                          decoration: InputDecoration(
                              labelText: "Username",
                              labelStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: "Enter a name",
                              helperStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                        ),
                      ),
                    SizedBox(height: 10,),

                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextFormField(

                          onChanged: (val){
                            mobile = val;
                          },

                          validator: (val){
                            if(val.isEmpty){
                              return "*required";
                            }else{
                              mobile = val;
                            }
                            return null;
                          },

                          onSaved: (val){
                            mobile = val;
                          },


                          decoration: InputDecoration(
                            labelText: "Mobile",
                            labelStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Enter the mobile No",
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
                        onPressed: () async{
                         if(_formKey.currentState.validate())
                         {
                              final user =
                                  await FirebaseAuth.instance.currentUser();

                              Map<String, dynamic> userData = {
                                "username": username,
                                "mobile": mobile,

                              };
                              Firestore.instance
                                  .collection('user')
                                  .where('email', isEqualTo: widget.post.data['email'])
                                  .getDocuments()
                                  .then((querySnapshot) {
                                querySnapshot.documents
                                    .forEach((documentSnapshot) {
                                  documentSnapshot.reference
                                      .updateData(userData);
                                });
                              });
                              change(context);
                            }else{
                           error(context);

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
                        onPressed: () {

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
                        ),),
                      SizedBox(height: 300,)
                    ],
                  ),
                )
              ],
            ),
            ),
        ),
      ),
      ),
    );
  }


void change(BuildContext context){

  var alertDialog = CupertinoAlertDialog(
    title: Text("Your account details has been changed Successfully"),
    content: Text("Please signin again"),
    actions: [
      CupertinoDialogAction(child: Text("OK"),onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Signin(post: widget.post,)),
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

pickphoto() async{

    // // ignore: deprecated_member_use
    // File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    //
    // setState(() {
    //   file = imageFile;
    // });
  ImagePicker picker = ImagePicker();

 var pickedFile = await picker.getImage(
    source: ImageSource.gallery,

  );

  String encodedImageString = base64.encode(File(pickedFile.path).readAsBytesSync().toList());

  Map<String, dynamic> userData = {
    "Photo": encodedImageString,
  };
  Firestore.instance.collection('user')
      .where('email', isEqualTo: widget.post.data['email'])
      .getDocuments()
      .then((querySnapshot) {
    querySnapshot.documents.forEach((documentSnapshot) {
      documentSnapshot.reference.updateData(userData);
    });
  });


}


  void error(BuildContext context){

    var alertDialog = CupertinoAlertDialog(
      title: Text("Fields are empty"),
      content: Text("Please enter details correctly"),

      actions: [
        CupertinoDialogAction(child: Text("OK"),onPressed: (){
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => EditAccount()),
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

  Future<void> dialog(BuildContext context) async {

    var alertDialog = CupertinoAlertDialog(
      title: Text("Profile picture changed Successfully"),
      content: Text(
        "\nChnage will apply with your next login ", style: TextStyle(fontSize: 15),),
      actions: [
        CupertinoDialogAction(child: Text("OK"), onPressed: () {
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => EditAccount()),
          );
        },),
      ],

    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }
}
