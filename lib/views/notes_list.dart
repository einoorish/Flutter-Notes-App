import 'package:flutter/material.dart';
import 'package:notes_sqlite/inherited_widgets/note_inherited_widget.dart';
import 'package:notes_sqlite/providers/note_provider.dart';

import 'note.dart';

class NoteList extends StatefulWidget{
  @override
  State createState() => NoteListState();
}

class NoteListState extends State<NoteList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Notes")),
        body: FutureBuilder(
          future: NoteProvider.getNoteList(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              var notes = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Note(NoteMode.Edit, notes[index]))
                        );
                      },
                      child: _NoteCard(notes[index]["title"], notes[index]["text"])
                  );
                },
                itemCount: notes.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
         ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Note(NoteMode.Add, null))
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget{

  String _title, _text;

  _NoteCard(this._title, this._text);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 30, bottom: 30, left: 14, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                _title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 12),
            Text(
              _text,
              style: TextStyle(color: Colors.grey.shade700),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}