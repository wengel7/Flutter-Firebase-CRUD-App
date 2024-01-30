import 'package:flutter/material.dart';
import'service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadNote extends StatefulWidget {
  ReadNote({required this.index});

  final int index;


  @override
  State<ReadNote> createState() => _ReadNoteState();
}

class _ReadNoteState extends State<ReadNote> {

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String result = '';
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: NoteStream,
      builder: (context, AsyncSnapshot snapshot){
              if (snapshot.hasData) {
                DocumentSnapshot ds=snapshot.data.docs[widget.index];
                titleController.text = ds["Title"];
                noteController.text = ds["Note"];
                return Scaffold(
                backgroundColor: Color(0xFFF9A84D),
                appBar: AppBar(
                  backgroundColor: Color(0xFFE3681A),
                  title:TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                    ),
                    controller: titleController,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    keyboardType: TextInputType.text,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () async{
                        Map<String, dynamic> updateInfo={
                          "Title": titleController.text,
                          "Note": noteController.text,
                          "id": ds["id"],
                        };
                        await DatabaseMethods()
                            .updateNoteDetail(ds["id"], updateInfo
                        ).then((value)
                        {
                          Fluttertoast.showToast(
                              msg: "The note has been Updated successfully.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.deepOrangeAccent,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        });
                      },
                      icon: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Icon(Icons.check,
                            color: Colors.black,
                            size: 30.0,),
                        ),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                      //   onChanged: (text) {
                      //   // print('First text field: $text (${text.characters.length})');
                      // },

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                        controller: noteController,
                        style: TextStyle(color:Colors.black,fontSize: 17),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              );
              } else {
                return Container(
        );
              }

      },
    );
  }
  Future EditNoteDetail (String id)=>
      showDialog(context: context, builder: (contex)=> AlertDialog(
        backgroundColor: Color(0xFFF9A84D),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(contex);
                    },
                    child: Icon(Icons.cancel, color: Colors.black,),
                  ),
                  Text(
                    'Edit NOTE',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
              Text(
                'Title',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
              TextField(
                controller: titleController,
                style: TextStyle(color:Colors.white),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 50),
              Text(
                'NOTE',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
              TextField(
                controller: noteController,
                style: TextStyle(color:Colors.white),
                keyboardType: TextInputType.text,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async{
                      Map<String, dynamic> updateInfo={
                        "Title": titleController.text,
                        "Note": noteController.text,
                        "id": id,
                      };
                      await DatabaseMethods()
                          .updateNoteDetail(id, updateInfo
                      ).then((value)
                      {
                        Navigator.pop(contex);
                        Fluttertoast.showToast(
                            msg: "The note has been Updated successfully.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      });
                    }, child:
                const Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Roboto',
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ],
          ),
        ),
      ));
}
