import 'package:ex3/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/note_view.dart';
import 'viewmodel/NoteViewModel.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteViewModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MVVM Note App',
        home: NoteListScreen(),
      ),
    );
  }
}
