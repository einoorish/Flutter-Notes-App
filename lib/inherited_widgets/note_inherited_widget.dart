import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget{

  final notes = [
    {
      "title" : "Title1",
      "text" : "Text1"
    },
    {
      "title" : "Title2",
      "text" : "Text2"
    },
    {
      "title" : "Title3",
      "text" : "Text3"
    },
  ];

  NoteInheritedWidget(Widget child) : super(child:child);

  static NoteInheritedWidget of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<NoteInheritedWidget>();

  //Whenever this inherited widgets gets updated => it notifies all
  // the widgets below it to redraw themself
  @override
  bool updateShouldNotify(NoteInheritedWidget oldWidget) {
    return oldWidget.notes != notes;
  }
  
}