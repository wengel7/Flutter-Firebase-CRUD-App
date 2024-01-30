import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import'service/database.dart';


class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFFF9A84D),
      appBar: AppBar(
        backgroundColor: Color(0xFFE3681A),
        title:TextField(
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 20, color: Colors.white),
            hintText: 'Title',
            // suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(20),
          ),
        // ),
        // title: TextField(
        //   decoration: InputDecoration(
        //     hintText: 'Title',
        //     border: OutlineInputBorder(),
        //     // padding: EdgeInsets.all(8.0),
        //   ),
          controller: titleController,
          style: TextStyle(color:Colors.white, fontSize: 20.0),
          keyboardType: TextInputType.text,
        ),
        actions: [
          // IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () async{
                String id= randomAlphaNumeric(10);
                Map<String, dynamic> noteInfoMap={
                  "Title": titleController.text,
                  "Note": noteController.text,
                  "id": id,
                };
                await DatabaseMethods()
                    .addNoteDetails(noteInfoMap,
                    id).then((value) =>
                {
                  Fluttertoast.showToast(
                      msg: "The note has been added successfully.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.deepOrange,
                      textColor: Colors.white,
                      fontSize: 16.0
                  )
                });
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(Icons.add,
                  color: Colors.black,
                  size: 30.0,),
              ),),
        ],
           // const Row(
           //  mainAxisAlignment: MainAxisAlignment.center,
           //  children: <Widget>[
              // Text(
              //   'NOTE',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontFamily: 'Roboto',
              //     fontSize: 25.0,
              //     fontWeight: FontWeight.bold,
              //   ),)

            // ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            // Text(
            //   'Title',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: 'Roboto',
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.bold,
            //   ),),
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: 'Title',
            //     border: OutlineInputBorder(),
            //     // padding: EdgeInsets.all(8.0),
            //   ),
            //   controller: titleController,
            //   style: TextStyle(color:Colors.white),
            //   keyboardType: TextInputType.text,
            // ),
            // SizedBox(height: 50),
            // Text(
            //   'NOTE',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: 'Roboto',
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.bold,
            //   ),),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Note',
                  hintStyle: TextStyle(fontSize: 17),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                  // border: OutlineInputBorder(),
                  // padding: EdgeInsets.all(8.0),
                ),
                controller: noteController,
                style: TextStyle(color:Colors.black, fontSize: 17),
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(height: 100),
            // Center(
            //   child: ElevatedButton(
            //       onPressed: () async{
            //         String id= randomAlphaNumeric(10);
            //         Map<String, dynamic> noteInfoMap={
            //           "Title": titleController.text,
            //           "Note": noteController.text,
            //           "id": id,
            //         };
            //         await DatabaseMethods()
            //             .addNoteDetails(noteInfoMap,
            //             id).then((value) =>
            //         {
            //           Fluttertoast.showToast(
            //               msg: "The note has been added successfully.",
            //               toastLength: Toast.LENGTH_SHORT,
            //               gravity: ToastGravity.CENTER,
            //               timeInSecForIosWeb: 1,
            //               backgroundColor: Colors.red,
            //               textColor: Colors.white,
            //               fontSize: 16.0
            //           )
            //         });
            //       }, child:
            //   const Text(
            //     'Add',
            //     style: TextStyle(
            //       color: Colors.black54,
            //       fontFamily: 'Roboto',
            //       fontSize: 23.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   )),
            // ),
            // SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}

