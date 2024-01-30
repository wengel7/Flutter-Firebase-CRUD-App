import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future addNoteDetails(Map<String, dynamic> noteInfoMap, String id)async{
    return await FirebaseFirestore.instance
        .collection('Note')
        .doc(id)
        .set(noteInfoMap);
  }//dynamic help us to create to the db

  Future<Stream<QuerySnapshot>> getNoteDetails()async{
      return  await FirebaseFirestore.instance.collection("Note").snapshots();
  }

  Future updateNoteDetail (String id, Map<String, dynamic> updateInfo) async{
    return await FirebaseFirestore.instance.collection("Note").doc(id).update(updateInfo);
  }

  Future deleteNoteDetail (String id) async{
    return await FirebaseFirestore.instance.collection("Note").doc(id).delete();
  }

}