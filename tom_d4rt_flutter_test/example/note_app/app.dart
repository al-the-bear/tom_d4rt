// MaterialApp wrapper for the note_app sample.
//
// Kept in its own file so `main.dart` reads cleanly as just the
// `build(BuildContext)` contract the harness expects. Centralising
// the theme here also makes it easy to tweak without touching the
// home page logic.
import 'package:flutter/material.dart';

import 'home.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const NoteAppHome(),
    );
  }
}
