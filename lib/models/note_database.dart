
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app_dark_mode/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{
  static late Isar isar;

  // I N I T I A L I Z E - D A T A B A S E
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  // list of notes
  final List<Note> currentNotes = [];

  // C R E A T E - a note and save database
  Future<void> addNote(String textFromUser) async {
    // create a new note object
    final newNote = Note()..text = textFromUser;

    // save to database
    await isar.writeTxn(() => isar.notes.put(newNote));

    // re-read from database

  }

  // R E A D - notes from database
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }

  // U P D A T E - a note in db
  Future<void> updateNote (int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if(existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // D E L E T E - a note from the db
  Future<void> deleteNote (int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
