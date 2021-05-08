import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentars/helpers/auth_service.dart';
import 'package:sentars/helpers/chennelID.dart';
import 'package:sentars/screens/cardiologist.dart';
import 'package:sentars/screens/doc_list.dart';
import 'package:sentars/screens/my_account.dart';
import 'package:sentars/screens/neuorologist.dart';
import 'package:sentars/screens/optometrist.dart';
import 'package:sentars/screens/searchResult.dart';


import 'drawer.dart';
import 'ongoingChannelings.dart';

class HomePage extends StatefulWidget{

  final DocumentSnapshot post;
  final FirebaseUser user;



  const HomePage({Key key, this.user, this.post}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchval;

  AuthService authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  Future getDoctors() async {
    var db = Firestore.instance;
    QuerySnapshot qn = await db.collection("doctor").getDocuments();
    return qn.documents;
  }

  navigateToDetails(DocumentSnapshot doc){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorView(doc: doc,)));
  }


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
      resizeToAvoidBottomInset: false,
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Container(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(icon: Icon(Icons.menu), onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Mydrawer(post: widget.post,)),
                        );
                      }),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => myaccount(post: widget.post)),
                      );
                    },
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment(0.9,1),
                            child: widget.user != null ? Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage("${user?.photoUrl}"),
                                  )
                              ),
                            ) : Container(

                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(base64Decode(widget.post.data['Photo'])),
                              ) ),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      child: Text(widget.user?.displayName != null  ?  "Hello " + widget.user.displayName + " !" :  "Hello " + widget.post.data['username'] + " !", textAlign: TextAlign.left, style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      child: Text("Find your specialist", textAlign: TextAlign.right, style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      width: 350,
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        child: TextFormField(

                          onChanged: (val){
                            searchval = val;
                          },

                          onSaved: (val){
                            searchval = val;
                          },



                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 14.0),
                            hintText: 'Search your doctor',
                            suffixIcon: Material(
                              borderRadius: BorderRadius.circular(30.0),
                              child: IconButton(icon: Icon(Icons.search,color: Colors.black),onPressed: ()async{

                                Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => SearchResult(data: searchval.toString())));


                              },
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors. white60,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0,4),
                                blurRadius: 20,
                                color: Color(0xFFB0CCE1).withOpacity(0.32),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Cardiologist()),
                                );

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(25),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.13),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        "assets/images/cardiology.png",
                                        height: 50,
                                        width: 50,
                                      ),
                                      ),
                                    Text("Cardiologist",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors. white60,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0,4),
                                blurRadius: 20,
                                color: Color(0xFFB0CCE1).withOpacity(0.32),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Neurologist()),
                                );

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(25),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.13),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        "assets/images/neuro.png",
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                    Text("Neurologist",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors. white60,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0,4),
                                blurRadius: 20,
                                color: Color(0xFFB0CCE1).withOpacity(0.32),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Optometrist()),
                                );

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(25),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.13),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        "assets/images/opti.png",
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                    Text("Optometrists",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],

                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text("  Top Doctors", style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DocList(userinfo : widget.post)),
                            );

                          },
                          child: Text("See all", style: TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold, ),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.5),
                    child: Divider(thickness: 1.5,color: Colors.black.withOpacity(0.3),),
                  ),
                  SingleChildScrollView(
                    child: FutureBuilder(
                        future: getDoctors(),
                        builder: (_, snapshot){

                          return ListView.builder(

                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),

                              itemCount: 5,
                              itemBuilder: (_, index) {
                                final img = base64Decode(snapshot.data[index].data["Photo"]);

                                return Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: MemoryImage(img),
                                      radius: 25,
                                    ),
                                    title: Text("Dr. "+snapshot.data[index].data["Fname"]),
                                    subtitle: Text(snapshot.data[index].data["Sarea"]),
                                    trailing: FlatButton(
                                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                                      color: Colors.blue.shade100,
                                      child: Text("Appoinment now", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                      onPressed: ()async{


                                        channelID(widget.user?.email != null  ?   widget.user.email  :   widget.post.data['email'], snapshot.data[index].data['Fname'], snapshot.data[index].data['Email'],widget.user?.displayName != null  ?   widget.user.displayName  : widget.post.data['username']);
                                        dialog(context);






                                      },
                                    ),
                                    tileColor: Colors.grey.shade200,
                                    // onTap: () =>
                                    //     navigateToDetails(snapshot.data[index]),
                                  ),
                                );
                              });
                        }),
                  ),


                ],
            ),
          ),
        ),
      ),
      drawer: Mydrawer(post: widget.post,),
    );
  }

  Future<void> dialog(BuildContext context) async {


    var alertDialog = CupertinoAlertDialog(
      title: Text("Appoinment is done"),
      content: Text(
        "\nYour can check the channel no in your profile(Ongoing Channelings section) ", style: TextStyle(fontSize: 15),),
      actions: [
        CupertinoDialogAction(child: Text("OK"), onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OngoingChannelings(post: widget.post,)),
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


