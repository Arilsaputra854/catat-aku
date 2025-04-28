import 'package:catat_aku/note/domain/entities/note.dart';
import 'package:catat_aku/note/domain/repositories/note_repository.dart';

class AddNoteUseCase {
  final NoteRepository repository;

  AddNoteUseCase(this.repository);

  Future<void> call(Note note)async {
    await repository.addNote(note);
  }
}