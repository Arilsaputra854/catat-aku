import 'package:catat_aku/note/data/datasources/note_database_helper.dart';
import 'package:catat_aku/note/data/models/note_model.dart';
import 'package:catat_aku/note/domain/repositories/note_repository.dart';
import 'package:catat_aku/note/domain/entities/note.dart';

class NoteRepositoryImpl extends NoteRepository {
  NoteDatabaseHelper _databaseHelper = NoteDatabaseHelper();

  @override
  Future<void> addNote(Note note) async {
    await _databaseHelper.insertNote(NoteModel.fromEntity(note));
  }

  @override
  Future<void> deleteNote(String id) async {
    await _databaseHelper.deleteNote(id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return await _databaseHelper.getNotes();
  }

  @override
  Future<void> updateNote(Note note) async {
     await _databaseHelper.updateNote(NoteModel.fromEntity(note));
  }
}
