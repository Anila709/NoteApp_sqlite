import 'package:my_notes_app/database_helper.dart';


class NoteModel {
  int noteId;
  String noteTitle;
  String noteDesc;
  String time;


  NoteModel({

    required this.noteId,
    required this.noteTitle,
    required this.noteDesc,
    required this.time,
    
  });

  ///from map --> model.
  ///factory functions are used to return an object of a class.
  ///NoteModel.fromMap is an extension function...fromMap is a name, 
  ///it can be any name but we are using fromMap so that we can relate..
  
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      noteId: map[AppDataBase.COLUMN_NOTE_ID],
      noteTitle: map[AppDataBase.COLUMN_NOTE_TITLE],
      noteDesc: map[AppDataBase.COLUMN_NOTE_DESC],
      time: map[AppDataBase.COLUMN_NOTE_TIME],
    );
  }

  ///model --> toMap.
  ///
  Map<String, dynamic> toMap(){
    return{
      ///we are not using noteId becoz it is in autoincrement state..
      AppDataBase.COLUMN_NOTE_TITLE: noteTitle,
      AppDataBase.COLUMN_NOTE_DESC: noteDesc,
     AppDataBase.COLUMN_NOTE_TIME:time,
    };

  }


}
