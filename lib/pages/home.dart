import'service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'note.dart';
import 'readNote.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController titleController1 = TextEditingController();
  TextEditingController noteController1 = TextEditingController();

  Stream? NoteStream;

  getontheload() async{
    NoteStream = await DatabaseMethods().getNoteDetails();
    setState(() {

    });
  }
  @override
  void initState(){
    getontheload();
        super.initState();
  }
  Widget allNoteDetails(){
    return StreamBuilder(
      stream: NoteStream,
      builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData?
      ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot ds=snapshot.data.docs[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  ReadNote(index: index,)));
              },
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Color(0xFFFFBE76), borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text( ds["Title"],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                  ),
                            ),
                            Spacer(),
                            SizedBox(height: 10.0,),
                            // GestureDetector(
                                 Center(
                                  child: GestureDetector(
                                    onTap: () async{
                                      await DatabaseMethods().deleteNoteDetail(ds["id"]);
                                    },
                                    // child: Icon(Icons.remove, weight: 123.0,),
                                    child: Image.asset('assets/Icons/cancel.png', width: 15.0, height: 20.0,),
                                  ),
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }): Container(

      );
    }, );
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF9A84D),
      appBar: AppBar(
        backgroundColor: Color(0xFFF09642),
        title: const Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'SIMPLE NOTES',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
            ]),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Note()));

              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(Icons.add,
                  color: Colors.black,
                  size: 30.0,),
              ),
          ),
        ],


      ),
      body: Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, ),
        child: Column(
            children: <Widget>[
                  Expanded(child: allNoteDetails()),
            ]),
      ),
    );
  }

}
