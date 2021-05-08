
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentars/screens/previous_records.dart';




class AppoinmentList extends StatefulWidget{
 final DocumentSnapshot post;

  const AppoinmentList({Key key, this.post}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _AppoinmentList();
  }

}

class _AppoinmentList extends State<AppoinmentList>{




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appoinment List"),
        backgroundColor: Colors.grey,
      ),
      body: List(docinfo : widget.post),
    );

  }

}

class List extends StatefulWidget {

final DocumentSnapshot docinfo;

  const List({Key key, this.docinfo}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {

  Future getChennelList() async {
    var db = Firestore.instance;
    QuerySnapshot qn = await db.collection("channel").where('docEmail', isEqualTo: widget.docinfo.data['Email']).getDocuments();
    return qn.documents;
  }

  // Future getAppoinment() async {
  //   var db = Firestore.instance;
  //   QuerySnapshot qn = await db.collection("channel").where("docEmail", isEqualTo: widget.post.data['Email']).getDocuments();
  //   return qn.documents;
  // }

  navigateToChannel(DocumentSnapshot post, DocumentSnapshot doinfo){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Appoinment(post: post, docinfo : widget.docinfo)));
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      child: FutureBuilder(
          future: getChennelList(),
          builder: (_, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: Text("Loading..."),
              );
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index){

                    return Card(
                      child: ListTile(
                        title: Text("channel No : "+snapshot.data[index].data["channelNo"] ),
                        subtitle: Text("Status : " +snapshot.data[index].data["Status"]),
                        onTap: () => navigateToChannel(snapshot.data[index], widget.docinfo),
                      ),


                    );

                  });
            }
          }),
    );
  }
}

class Appoinment extends StatefulWidget {
  final DocumentSnapshot post;
  final DocumentSnapshot docinfo;

  const Appoinment({Key key, this.post, this.docinfo}) : super(key: key);
  @override
  _AppoinmentState createState() => _AppoinmentState();
}

class _AppoinmentState extends State<Appoinment> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime now = new DateTime.now();
  String  pres, prob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appoinments"),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Center(
                    child: Text(widget.post.data['username'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Date : " +now.year.toString()+":"+now.month.toString()+":"+now.day.toString(), style: TextStyle(fontSize: 15), ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Channel No: " +widget.post.data['channelNo'], style: TextStyle(fontSize: 15, color: Colors.black ),),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PreviousRecords(post: widget.post, docinfo : widget.docinfo)),
                    );

                  },
                  child: Text(
                    "View Previous Prescriptions",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2.2,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children:[
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("Problem          :", style: TextStyle(fontSize: 15),  )),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (val){
                              prob = val;
                            },

                            validator: (value){
                              if(value.isEmpty){
                                return "*required";
                              }else{
                                prob = value;
                              }
                              return null;
                            },


                            onSaved: (value){
                              prob = value;
                            },


                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                helperStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Prescription ", style: TextStyle(fontSize: 15),  )),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    onChanged: (val){
                      pres = val;
                    },

                    validator: (value){
                      if(value.isEmpty){
                        return "*required";
                      }else{
                        pres = value;
                      }
                      return null;
                    },


                    onSaved: (value){
                      pres = value;
                    },



                    decoration: InputDecoration(
                        hintText: "Write here...",
                        border: OutlineInputBorder()
                    ),
                    maxLines: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        color: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 160.0),
                        shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () async{

                          if(_formKey.currentState.validate()){
                            DateTime now = new DateTime.now();

                            Map<String, dynamic> prescription = {
                              "channelNo": widget.post.data['channelNo'].toString(),
                              "date": widget.post.data['date'],
                              "problem": prob.toString(),
                              "prescription": pres.toString(),
                              "username": widget.post.data['username'],
                              "userEmail": widget.post.data['userEmail'],
                              "docEmail": widget.docinfo.data['Email']


                            };
                            DocumentReference docref = Firestore.instance.collection("prescription").document(widget.post.data['userEmail'].toString()).collection('preslist').document(now.year.toString()+" : "+now.month.toString()+" : "+now.day.toString());
                            docref.setData(prescription);

                            Map<String, dynamic> userData = {
                              "Status": "Done",
                            };
                            Firestore.instance.collection('channel')
                                .where('username', isEqualTo: widget.post.data['username'])
                                .getDocuments()
                                .then((querySnapshot) {
                              querySnapshot.documents.forEach((documentSnapshot) {
                                documentSnapshot.reference.updateData(userData);
                              });
                            });
                          }
                          Next(context);

                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2.2,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
  void Next(BuildContext context)async{

    final QuerySnapshot qSnap = await Firestore.instance.collection('channel').getDocuments();
    int documents = qSnap.documents.length;

    documents = documents + 1;

    var alertDialog = CupertinoAlertDialog(
      title: Text("Prescription is saved"),
      content: Text("Please get the next Channel number", style: TextStyle(fontSize: 15),),
      actions: [
        CupertinoDialogAction(child: Text("OK"),onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppoinmentList(post: widget.docinfo)),
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
