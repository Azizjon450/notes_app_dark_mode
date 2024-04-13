import 'package:flutter/material.dart';
import 'package:notes_app_dark_mode/models/note_database.dart';
import 'package:notes_app_dark_mode/pages/notes_page.dart';
import 'package:notes_app_dark_mode/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize not isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        // Note provider
        ChangeNotifierProvider(create: (context) => NoteDatabase()),

        // Theme provider
        ChangeNotifierProvider(create: (context) => ThemProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: NotesPage(),
      home: NotesPage(),
      theme: Provider.of<ThemProvider>(context).themeData,
    );
  }
}
