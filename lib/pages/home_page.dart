import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/detail_page.dart';
import 'package:notes_app/pages/form_page.dart';
import 'package:notes_app/utils/notes_database.dart';
import 'package:notes_app/widgets/card_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note(
      id: 1,
      title: 'Jay',
      description: 'Jay ganss',
      time: DateTime.now(),
    ),
    Note(
      id: 2,
      title: 'Favorit song',
      description: 'Paradoxx invasion',
      time: DateTime.now(),
    ),
    Note(
      id: 3,
      title: 'Bias in Enhypen',
      description: 'Sunjay',
      time: DateTime.now(),
    ),
    Note(
      id: 4,
      title: 'Enhypen',
      description: 'Fate+ 23 February 2024',
      time: DateTime.now(),
    ),
  ];

  bool isLoading = false;

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    NotesDatabase.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes Jay"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: ()  async {
                     await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return DetailPage(note: notes[index]);
                      }));
                      refreshNotes();
                    },
                    child: CardWidget(
                      index: index,
                      note: notes[index],
                    ),
                  );
                },
                itemCount: notes.length,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        await  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const FormPage();
          }));
          refreshNotes();
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}