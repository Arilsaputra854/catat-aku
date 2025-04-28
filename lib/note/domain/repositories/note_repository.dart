import 'package:catat_aku/note/domain/entities/note.dart';

abstract class NoteRepository{
  Future<void> addNote(Note note);
  Future<void> deleteNote(String id);
  Future<void> updateNote(Note note);
  Future<List<Note>> getNotes();
}