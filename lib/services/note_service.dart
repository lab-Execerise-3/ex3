// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/note.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Note>> getNotes() async {
    try {
      print('Fetching notes from Firestore');
      QuerySnapshot querySnapshot =
          await _firestore.collection('notes').get();
      print('Fetched ${querySnapshot.docs.length} notes');
      return querySnapshot.docs
          .map((doc) => Note.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Error fetching notes from Firestore: $error');
      throw Exception('Failed to load notes');
    }
  }
 Stream<QuerySnapshot> getNotesStream() {
    return _firestore.collection('notes').snapshots();
  }
 Future<Note> addNote(Note newNote) async {
  try {
  
    await _firestore.collection('notes').add(newNote.toJson());

    return newNote;
  } catch (error) {
    throw Exception('Failed to add note');
  }
}

Future<Note> editNote(Note editedNote) async {
  try {

    QuerySnapshot querySnapshot = await _firestore
        .collection('notes')
        .where('id', isEqualTo: editedNote.id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {

      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      await documentSnapshot.reference.set(editedNote.toJson());
      return editedNote;
    } else {

      throw Exception('Note with id ${editedNote.id} not found');
    }
  } catch (error) {
    throw Exception('Failed to edit note');
  }
}


Future<void> deleteNote(String noteId) async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('notes')
        .where('id', isEqualTo: noteId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
    
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      
      await documentSnapshot.reference.delete();
    } else {
    
      throw Exception('Note with id $noteId not found');
    }
  } catch (error) {
    throw Exception('Failed to delete note');
  }
}
}
