import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:sqflite_common_ffi_web/sqflite_common_ffi_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'database_helper.dart';
import 'note.dart';

void main() {
  if (kIsWeb) {
    // databaseFactory = databaseFactoryFfiWeb;
  } else {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteListPage(),
    );
  }
}

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  Future<void> _refreshNotes() async {
    final notes = await dbHelper.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _showNoteDialog({Note? note}) async {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(note == null ? '添加便签' : '编辑便签'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: '标题'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: '内容'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                final newNote = Note(
                  id: note?.id,
                  title: titleController.text,
                  content: contentController.text,
                );
                if (note == null) {
                  await dbHelper.insertNote(newNote);
                } else {
                  await dbHelper.updateNote(newNote);
                }
                _refreshNotes();
                Navigator.of(context).pop();
              },
              child: Text(note == null ? '添加' : '更新'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('便签列表')),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_notes[index].title),
          subtitle: Text(_notes[index].content),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _showNoteDialog(note: _notes[index]),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await dbHelper.deleteNote(_notes[index].id!);
                  _refreshNotes();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showNoteDialog(),
      ),
    );
  }
}