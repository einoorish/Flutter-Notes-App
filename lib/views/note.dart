import 'package:flutter/material.dart';
import 'package:notes_sqlite/inherited_widgets/note_inherited_widget.dart';

enum NoteMode { Edit, Add }

class Note extends StatefulWidget{

  final NoteMode noteMode;
  final int index;

  Note(this.noteMode, this.index);

  @override
  State<StatefulWidget> createState() {
    return _NoteState();
  }
}

class _NoteState extends State<Note> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  String title = "Title", text = "Description";

  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;


  @override
  void didChangeDependencies() {
    //must use inherited widget only after init state finished
    if(widget.noteMode == NoteMode.Edit){
      _titleController.text = _notes[widget.index]["title"];
      _textController.text = _notes[widget.index]["text"];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget?.noteMode == NoteMode.Add ? "New Note" : "Edit Note")
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(controller: _titleController, decoration: InputDecoration(hintText: title)),
              TextField(controller: _textController, decoration: InputDecoration(hintText: text)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Button("Save", Colors.blue, (){
                    final title = _titleController.text;
                    final text = _textController.text;

                    if(widget?.noteMode == NoteMode.Add){
                      _notes.add({"title":title, "text": text});
                    } else {
                      _notes[widget.index] = {"title":title, "text": text};
                    }

                    Navigator.pop(context);
                  }),
                  _Button("Discard", Colors.grey, (){Navigator.pop(context);}),
                  widget?.noteMode == NoteMode.Edit ?
                  _Button("Delete", Colors.red, (){
                    _notes.removeAt(widget.index);
                  })
                      : Container()
                ],
              )
            ],
          ),
        )
    );
  }
}

class _Button extends StatelessWidget {

  final String _text;
  final Color _color;
  final Function _onPressed;

  _Button(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => _onPressed(),
      child: Text(_text, style: TextStyle(color: Colors.white)),
      color: _color,
      minWidth: 100,
    );
  }
  
}