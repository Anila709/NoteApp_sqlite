
import 'package:flutter/material.dart';
import 'package:my_notes_app/provider/note_provider.dart';
import 'package:my_notes_app/screens/note_add.dart';
import 'package:provider/provider.dart';

class NoteHomeScreen extends StatefulWidget {
  NoteHomeScreen({super.key, this.formattedDate, this.isUpdate=false});

  final String? formattedDate;
  final bool isUpdate;

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {
  // late AppDataBase appDB;
  // List<NoteModel> data = [];

  @override
  void initState() {
    super.initState();
    context.read<NoteProvider>().getAllNotes();
    // appDB = AppDataBase.instance;
    // getAllNote();
  }

  // void getAllNote() async {
  //   data = await appDB.fetchNoteDB();
  //   setState(() {});
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 40,
              width: double.maxFinite,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notes',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade800),
                      child: Center(
                        child: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
            ),
            SizedBox(height: 10),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Consumer<NoteProvider>(
                  builder: (context, provider, child) {
                    var notes = provider.getNotes();
                    
                    return notes.isNotEmpty?
              GridView.builder(
                shrinkWrap: true,
                  itemCount: notes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 160,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    var currentData = notes[index];
                    
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteAddScreen(
                          isUpdate: true,
                          id: currentData.noteId,
                          nTitle: currentData.noteTitle,
                          nDesc: currentData.noteDesc,
                          ntime: currentData.time,
                        )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index%2==0?Colors.amber:Colors.pinkAccent),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Expanded(
                              child: Text(
                                currentData.noteTitle,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                   '${currentData.time}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black45),
                                ),
                                InkWell(
                                  onTap: () {
                                   //delete data here
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      
                                      backgroundColor: Colors.grey.shade900,
                                      title: Text('Delete?',style:TextStyle(color: Colors.white),),
                                      content: Text('Are you sure to delete this item???',style:TextStyle(color: Colors.white),),
                                      actions: [
                                        TextButton(onPressed: (){
                                          //delete here..
                                         // context.read<NoteProvider>().deleteNote(index);
                                         provider.deleteNote(notes[index].noteId);
                                          // appDB.deleteNoteDB(currentData.noteId);
                                          // getAllNote();
                                          Navigator.pop(context);
                                        }, child: Text('Yes')),
                                        TextButton(onPressed: (){
                                          //cancel here..
                                          Navigator.pop(context);
                                        }, child: Text('No')),
        
                                      ],
                                    );
        
                                  });
                                    
                                  },
                                  child: Icon(Icons.delete,color: Colors.black54,))
                              ],
                            )
                          ]),
                        ),
                      ),
                    );
                  }):Center(
                    child: Text('No Note Found',style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold,fontSize: 20),),

                  );
                  },
                )),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade800,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteAddScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
