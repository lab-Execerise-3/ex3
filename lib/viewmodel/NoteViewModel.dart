// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/note.dart';
import '../services/note_service.dart';

class NoteViewModel extends ChangeNotifier {
  List<Note> notes = [];
  final NoteService _noteService = NoteService();
  bool _isNotesLoaded = false;

  bool get isNotesLoaded => _isNotesLoaded;

  Future<void> fetchNotes() async {
    try {
      notes = await _noteService.getNotes();
      _isNotesLoaded = true;
      notifyListeners();
    } catch (error) {
      print('Error fetching notes: $error');
      _isNotesLoaded = false;
    }
  }
  Stream<QuerySnapshot> getNotesStream() {
    return _noteService.getNotesStream();
  }
Future<void> addNote(Note newNote) async {
  try {
    await _noteService.addNote(newNote);
  
  
    notes.add(newNote);

    notifyListeners();
  } catch (error) {
    print('Error adding note: $error');
  }
}

  Future<Note> editNote(Note editedNote) async {
    try {
     
      print('Editing note in Firestore: $editedNote');
      await _noteService.editNote(editedNote);

      print('Note edited successfully');
  
      await fetchNotes();
      return editedNote;
    } catch (error) {
      print('Error editing note in Firestore: $error');
      throw Exception('Failed to edit note');
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _noteService.deleteNote(noteId);
      
      await fetchNotes();
    } catch (error) {
   
      print('Error deleting note: $error');
    }
  }
}
