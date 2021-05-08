import 'package:cloud_firestore/cloud_firestore.dart';


void channelID(String email, String docname, String docemail, String username) async{
  DateTime now = new DateTime.now();
  final QuerySnapshot qSnap = await Firestore.instance.collection('channel').getDocuments();
  int documents = qSnap.documents.length;

  documents = documents + 1;


  print(documents);
  Map<String, dynamic> channelInfo = {
    "channelNo": documents.toString(),
    "date": now.year.toString()+" : "+now.month.toString()+" : "+now.day.toString(),
    "docName": docname,
    "docEmail": docemail,
    "username": username,
    "userEmail": email,
    "Status": "Waiting",

  };
  DocumentReference docref = Firestore.instance.collection("channel").document(now.year.toString()+" : "+now.month.toString()+" : "+now.day.toString()+"       "+ now.hour.toString()+": "+now.minute.toString()+": "+now.second.toString());
  docref.setData(channelInfo);
}