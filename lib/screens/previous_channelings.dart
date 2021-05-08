import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PreviousChannelinList extends StatefulWidget {
  final DocumentSnapshot post;

  const PreviousChannelinList({Key key, this.post}) : super(key: key);

  @override
  _PreviousChannelinListState createState() => _PreviousChannelinListState();
}

class _PreviousChannelinListState extends State<PreviousChannelinList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Previous Prescription List"),
        backgroundColor: Colors.grey,
      ),
      body: List(post : widget.post),
    );
  }
}
class List extends StatefulWidget {
final DocumentSnapshot post;

  const List({Key key, this.post}) : super(key: key);



  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {

  Future getPrescriptionList() async {
    DateTime now = new DateTime.now();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var db = Firestore.instance;
    QuerySnapshot qn = await db.collection("prescription").document(user?.email != null  ?   user.email  : widget.post.data['email']).collection('preslist').where('userEmail', isEqualTo: user?.email != null  ?   user.email  : widget.post.data['email']).getDocuments();
    return qn.documents;
  }

  navigateToChannel(DocumentSnapshot snap){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PrescriptionInfo(post: snap,)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: FutureBuilder(
          future: getPrescriptionList(),
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
                        leading: Text("Channel No : "+snapshot.data[index].data["channelNo"], style: TextStyle(fontSize: 13), ),
                        title: Text("Date : "+snapshot.data[index].data["date"] ),
                        subtitle:Text("Doctor : "+snapshot.data[index].data["docEmail"] ),
                        tileColor: Colors.white38,
                        onTap: () => navigateToChannel(snapshot.data[index]),
                      ),


                    );

                  });
            }
          }),
    );
  }

}

class PrescriptionInfo extends StatefulWidget {
  final DocumentSnapshot post;

  const PrescriptionInfo({Key key, this.post}) : super(key: key);

  @override
  _PrescriptionInfoState createState() => _PrescriptionInfoState();
}

class _PrescriptionInfoState extends State<PrescriptionInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.data['date'], style: TextStyle(fontSize: 17),),
        backgroundColor: Colors.grey,
      ),
      body:SingleChildScrollView(
      child : Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Center(child: Text("Channel No : " +widget.post.data['channelNo'], style: TextStyle(fontSize: 15),)),
            SizedBox(height: 20,),
            Text("Name : " +widget.post.data['username'], style: TextStyle(fontSize: 15),),
            SizedBox(height: 20,),
            Text("Email : " +widget.post.data['userEmail'], style: TextStyle(fontSize: 15),),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Problem          : " +widget.post.data['problem'], style: TextStyle(fontSize: 15),  )),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children:[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Prescription   : " , style: TextStyle(fontSize: 15),  )),
                  // Flexible(child: TextFormField(
                  //   controller: TextEditingController(),
                  //
                  // )),


                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.post.data['prescription'].toString(),



                  decoration: InputDecoration(
                      hintText: "Write here...",
                      border: OutlineInputBorder()
                  ),
                  maxLines: 10,
                ),
              ),
            ),

          ],
        ),
      ),
      ),
    );
  }
}

