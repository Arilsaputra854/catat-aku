import 'package:catat_aku/note/presentation/bloc/note_cubit.dart';
import 'package:catat_aku/note/presentation/bloc/note_state.dart';
import 'package:catat_aku/note/presentation/pages/add_note_page.dart';
import 'package:catat_aku/utility/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    context.read<NoteCubit>().getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Catat Aku!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state is NoteSuccess) {
              return state.notes.length > 0
                  ? GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4.0,
                        color: const Color.fromARGB(255, 255, 252, 226),
                        margin: EdgeInsets.all(10),
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${DateFormatter.convertToString(state.notes[index].updateAt!)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  state.notes[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Text(
                                    state.notes[index].note,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        AddNotePage(note: state.notes[index]),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                  )
                  : SizedBox(
                    height: 500,
                    child: Center(child: Text("Tidak ada Catatan")),
                  );
            } else {
              return SizedBox(
                height: 500,
                child: Center(child: Text("Tidak dapat memuat catatan")),
              );
            }
          },
        ),
      ),
    );
  }
}
