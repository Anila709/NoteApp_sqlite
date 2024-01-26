import 'package:my_notes_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class AppDataBase{
  //private constructor (singleton) creation, so that nobody can make multiple copies of this db or create multiple objects and do any changes.

  AppDataBase._();

//create a static instance, so that any one can access the db without modifying the db.
  static final AppDataBase instance=AppDataBase._();

//database reference
Database? myDB;


//table
static final String NOTE_TABLE="notes";
///columns
static final String COLUMN_NOTE_ID="noteId";
static final String COLUMN_NOTE_TITLE="title";
static final String COLUMN_NOTE_DESC="desc";
static final String COLUMN_NOTE_TIME="time";

//fuctions to perform db operations


//initialise db
Future<Database> initDB() async{
  var docDirectory = await getApplicationDocumentsDirectory();
  var dbPath=join(docDirectory.path, "noteDB.db");
  return await openDatabase(dbPath, version: 1,
  onCreate: (db,version){
    //create tables here..

    db.execute("create table $NOTE_TABLE ( $COLUMN_NOTE_ID integer primary key autoIncrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text, $COLUMN_NOTE_TIME text)");

  });

  
}

//get or fetch db...
Future<Database> getDB()async{
  if(myDB != null){
    return myDB!;
  }
  else{
    myDB = await initDB();
    return myDB!;
  }
}

//add note..
Future<void>addNoteDB(NoteModel newNote)async{
  var db= await getDB();

  db.insert(NOTE_TABLE, newNote.toMap());
}

//fetch note..
Future<List<NoteModel>> fetchNoteDB()async{
  var db=await getDB();
  List<NoteModel> arrNotes=[];

  var data=await db.query(NOTE_TABLE);
  
  for(Map<String,dynamic> eachNote in data){
    var noteModel= NoteModel.fromMap(eachNote);
    arrNotes.add(noteModel);

  }
  return arrNotes;
  
}

 //update note..
 Future<void> updateNoteDB(NoteModel updateNote)async{
  var db=await getDB();
  //type 1 to use where clause..
  //db.update(NOTE_TABLE, updateNote.toMap(),where: "$COLUMN_NOTE_ID=${updateNote.noteId}");
  //type 2 to use where clause..
  db.update(NOTE_TABLE, updateNote.toMap(),where: "$COLUMN_NOTE_ID= ?",whereArgs:["${updateNote.noteId}"]);

 } 

//delete note..
Future<void> deleteNoteDB(int id)async{
  var db=await getDB();
  db.delete(NOTE_TABLE,where: "$COLUMN_NOTE_ID=$id");
}
}