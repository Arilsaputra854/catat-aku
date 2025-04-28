import 'package:catat_aku/note/domain/entities/note.dart';
import 'package:catat_aku/note/presentation/bloc/note_cubit.dart';
import 'package:catat_aku/note/presentation/bloc/note_state.dart';
import 'package:catat_aku/utility/date_formatter.dart';
import 'package:catat_aku/utility/id_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotePage extends StatelessWidget {
  final Note? note;
  AddNotePage({this.note});
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameController.text = note?.name ?? "";
    noteController.text = note?.note ?? "";
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Tambah Catatan Baru"),
          actions: [
            if (note != null)
              BlocListener<NoteCubit, NoteState>(
                listener: (context, state) {
                  if (state is NoteDeleteSuccess) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    Navigator.pop(context);
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<NoteCubit>().deleteNote(note!.id);
                    }
                  },
                  child: Text("Hapus"),
                ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: BlocListener<NoteCubit, NoteState>(
            listener: (context, state) {
              if (state is NoteAddSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
                Navigator.pop(context);
              }
              if (state is NoteUpdateSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (note != null)
                          Center(
                            child: Text(
                              "Terakhir diperbarui pada ${DateFormatter.convertToString(note!.updateAt!)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: const Color.fromARGB(255, 117, 117, 117),
                              ),
                            ),
                          ),
                        Text("Nama Catatan:", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nama tidak boleh kosong!";
                            }
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Catatan:", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          controller: noteController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nama tidak boleh kosong!";
                            }
                          },
                          maxLines: 10,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    onPressed:
                        note != null
                            ? () {
                              if (_formKey.currentState!.validate()) {
                                context.read<NoteCubit>().updateNote(
                                  Note(
                                    id: note!.id,
                                    name: nameController.text,
                                    note: noteController.text,
                                    createAt: note!.createAt,
                                    updateAt: DateTime.now(),
                                  ),
                                );
                              }
                            }
                            : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<NoteCubit>().saveNote(
                                  Note(
                                    id: IdGenerator().generateNumeric(),
                                    name: nameController.text,
                                    note: noteController.text,
                                    createAt: DateTime.now(),
                                    updateAt: DateTime.now(),
                                  ),
                                );
                              }
                            },
                    child: Text(
                      note != null ? "Simpan Pembaruan" : "Simpan",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
