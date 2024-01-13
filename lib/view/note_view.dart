// ignore_for_file: library_private_types_in_public_api, unnecessary_string_interpolations

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/note.dart';
import '../viewmodel/NoteViewModel.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          backgroundColor: Colors.blue,
        ),
      ),
      home: ChangeNotifierProvider(
        create: (context) => NoteViewModel(),
        child: const NoteList(),
      ),
    );
  }
}

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Colors.blue,
  title: const Text('Notes'),
  actions: [
    StreamBuilder<QuerySnapshot>(
      stream: Provider.of<NoteViewModel>(context).getNotesStream(),
      builder: (context, snapshot) {
        return _buildNotesCountIndicator(context, snapshot);
      },
    ),
  ],
),

      body: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<NoteViewModel>(context).getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading notes'),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No notes available'),
            );
          } else {
            final notes = snapshot.data!.docs
                .map((doc) => Note.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteTile(model: NoteViewModel(), note: notes[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteDialog(context, NoteViewModel());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

 Widget _buildNotesCountIndicator(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const CircularProgressIndicator();
  } else if (snapshot.hasError) {
    return const Text('Error loading notes');
  } else {
    int notesCount = snapshot.data!.docs.length;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(86, 249, 249, 249),
        child: Text(
          notesCount.toString(),
          style: const TextStyle(color: Color.fromARGB(255, 97, 148, 243)),
        ),
      ),
    );
  }
}

Future<void> _showAddNoteDialog(BuildContext context, NoteViewModel model) async {
  String defaultTitle = 'Default Title';
  String defaultContent = 'Default Content';


  String uniqueId = '${DateTime.now().millisecondsSinceEpoch}_${_randomHexString(6)}';

  Note newNote = Note(
    id: uniqueId, 
    title: defaultTitle,
    content: defaultContent,
  );

  await model.addNote(newNote);
  await model.fetchNotes(); 
  setState(() {});
}


String _randomHexString(int length) {
  final random = Random.secure();
  final values = List<String>.generate(
    length,
    (index) => "${random.nextInt(16).toRadixString(16).toUpperCase()}",
  );
  return values.join();
}




}

class NoteTile extends StatefulWidget {
  final NoteViewModel model;
  final Note note;

  const NoteTile({required this.model, required this.note, Key? key})
      : super(key: key);

  @override
  _NoteTileState createState() => _NoteTileState();
}


class _NoteTileState extends State<NoteTile> {
  bool isEditing = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isEditing = true;
        });
      },
      child: ListTile(
        title: isEditing
            ? TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              )
            : Text(widget.note.title),
        subtitle: isEditing
            ? TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content'),
              )
            : Text(widget.note.content),
        trailing: isEditing
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () async {
                  
                      Note editedNote = Note(
                        id: widget.note.id,
                        title: titleController.text,
                        content: contentController.text,
                      );

                      await widget.model.editNote(editedNote);

                      setState(() {
                        isEditing = false;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await widget.model.deleteNote(widget.note.id);

                      setState(() {
                        isEditing = false;
                      });
                    },
                  ),
                ],
              )
            : null,
      ),
    );
  }
}