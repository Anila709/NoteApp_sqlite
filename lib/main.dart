import 'package:flutter/material.dart';
import 'package:my_notes_app/database_helper.dart';
import 'package:my_notes_app/provider/note_provider.dart';

import 'package:my_notes_app/screens/note_home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: ((context) => NoteProvider(db: AppDataBase.instance)),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: NoteHomeScreen(),
    );
  }
}
