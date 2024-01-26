
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
//import 'package:my_notes_app/database_helper.dart';
import 'package:my_notes_app/model/note_model.dart';
import 'package:my_notes_app/provider/note_provider.dart';
import 'package:my_notes_app/screens/note_home.dart';
import 'package:provider/provider.dart';

class NoteAddScreen extends StatefulWidget {
  NoteAddScreen(
      {super.key,
      this.isUpdate = false,
      this.id = 0,
      this.nTitle = '',
      this.nDesc = '',
      this.ntime=''});

  final bool isUpdate;
  final int id;
  final String nTitle;
  final String nDesc;
  final String ntime;
  
  @override
  State<NoteAddScreen> createState()=>_MyState();
}
  class _MyState extends State<NoteAddScreen>{

  // late AppDataBase appDB;
  // List<NoteModel> data = [];

  final titleController = TextEditingController();
  final descController = TextEditingController();

  // bool _mounted = false;

  late DateTime currentDate=DateTime.now();
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate=DateFormat('MMM dd, yyyy').format(currentDate);
   //context.read<NoteProvider>().getAllNotes();
    // _mounted = true; // Set to true when the widget is mounted
    // appDB = AppDataBase.instance;
    // getAllNote();
  }

  

  // void getAllNote() async {
  //   data = await appDB.fetchNoteDB();
  //   if (_mounted) {
  //     setState(() {}); // Only call setState if the widget is still mounted
  //   }
  // }

  // @override
  // void dispose() {
  //   _mounted = false; // Set to false when the widget is disposed
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.nTitle;
    descController.text = widget.nDesc;
    //formattedDate=widget.ntime;
    
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
        child: Column(children: [
          Container(
            height: 50,
            width: double.maxFinite,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade800),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (titleController.text.isNotEmpty &&
                          descController.text.isNotEmpty) {
                        if (widget.isUpdate) {
                          //update note here..
                          context.read<NoteProvider>()
                          .updateNote(
                            NoteModel(
                              noteId: widget.id,
                              noteTitle: titleController.text.toString(),
                              noteDesc: descController.text.toString(),
                              time: formattedDate,
                            ),
                          );
                        } else {
                          context.read<NoteProvider>().addNote(
                            NoteModel(
                              noteId: 0,
                              noteTitle: titleController.text.toString(),
                              noteDesc: descController.text.toString(),
                             time: formattedDate,
                            ),
                          );
                        }

                        //getAllNote();
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteHomeScreen(formattedDate: formattedDate,isUpdate: true,)),
                        );
                      }
                    },
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade800),
                      child: Center(
                          child: Text(
                        widget.isUpdate ? 'Update' : 'Save',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                  )
                ]),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    maxLines: 4,
                    minLines: 1,
                    cursorColor: Colors.grey.shade800,
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade600)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    formattedDate,
                    
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade600),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.76,
                      child: TextField(
                        controller: descController,
                        minLines: 1,
                        maxLines: 27,
                        cursorColor: Colors.grey.shade800,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type something...',
                            hintStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
