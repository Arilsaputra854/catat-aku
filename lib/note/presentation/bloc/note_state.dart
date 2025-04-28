

import 'package:catat_aku/note/domain/entities/note.dart';

abstract class NoteState{}

class NoteInitial extends NoteState{

}

class NoteSuccess extends NoteState{
  final List<Note> notes;
  final String message;
  NoteSuccess({required this.notes, this.message = ""});
}


class NoteLoadSuccess extends NoteSuccess{
  final List<Note> notes;
  NoteLoadSuccess(this.notes) : super(notes: notes);
}

class NoteAddSuccess extends NoteSuccess{
  final List<Note> notes;
  NoteAddSuccess({required this.notes}) : super(notes: notes, message: "Berhasil menambahkan catatan");
}

class NoteUpdateSuccess extends NoteSuccess{
  final List<Note> notes;
  NoteUpdateSuccess({required this.notes}) : super(notes: notes, message: "Berhasil memperbarui catatan");
}


class NoteDeleteSuccess extends NoteSuccess{
  final List<Note> notes;
  NoteDeleteSuccess({required this.notes}) : super(notes: notes, message: "Berhasil menghapus catatan");
}


class NoteUpdateFailure extends NoteState{
  final String message;
  NoteUpdateFailure(this.message);
}

