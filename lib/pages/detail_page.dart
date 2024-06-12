import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/pages/form_page.dart';
import 'package:notes_app/utils/notes_database.dart';

class DetailPage extends StatefulWidget {
  final Note note;
  const DetailPage({Key? key, required this.note}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  late Note note;

  Future refreshNotes() async {
    note = await NotesDatabase.instance.readNote(widget.note.id!);
    setState(() {});
  }

  @override
  void initState() {
    note = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Catatan",
          style: TextStyle(fontWeight: FontWeight.w700),
        ), //agar yg dipencet data itu yg keluar (berdasarkan data yg dipilih)
        actions: [
          InkWell(
            onTap: () async{
             await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return FormPage(
                  note: note,
                );
              }));
            },
            child: const Icon(Icons.edit),
          ),
          InkWell(
            onTap: () async {
              await NotesDatabase.instance.delete(widget.note.id!);
              Navigator.of(context).pop(); 
            },
            child: const Icon(Icons.delete),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListView(
          children: [
            Text(DateFormat.yMMMMEEEEd().format(note.time), //pake depedency intl  //formatnya berdasarkan dari note dari waktunyanya
            style: const TextStyle(
              color: Color.fromARGB(255, 41, 40, 40),
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              note.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 26,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              note.description,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
