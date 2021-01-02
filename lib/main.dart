import 'package:flutter/material.dart';
import 'package:notes_sqlite/inherited_widgets/note_inherited_widget.dart';

import 'views/notes_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoteInheritedWidget(
      MaterialApp(
        title: 'Notes',
        home: NoteList(),
      ),
    );
  }
}

