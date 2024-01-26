import 'package:flutter/material.dart';
import 'package:my_notes_app/database_helper.dart';
import 'package:my_notes_app/model/note_model.dart';

class NoteProvider extends ChangeNotifier{

  AppDataBase db;
  NoteProvider({required this.db});

   List<NoteModel> _arrNotes =[];

  List<NoteModel> getNotes() => _arrNotes;

  //events..
  void getAllNotes()async{
    _arrNotes=await db.fetchNoteDB();
    notifyListeners();
  }

  void addNote(NoteModel newNote)async{
    await db.addNoteDB(newNote);
    _arrNotes=await db.fetchNoteDB();
    notifyListeners();
  }

  void updateNote(NoteModel updateNote)async{
    await db.updateNoteDB(updateNote);
    _arrNotes=await db.fetchNoteDB();
    notifyListeners();
  }

  void deleteNote(int id)async{
    await db.deleteNoteDB(id);
    _arrNotes=await db.fetchNoteDB();
    notifyListeners();
  }
}