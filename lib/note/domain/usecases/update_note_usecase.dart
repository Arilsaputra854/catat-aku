import 'package:catat_aku/note/domain/entities/note.dart';
import 'package:catat_aku/note/domain/repositories/note_repository.dart';

class UpdateNoteUsecase {
  final NoteRepository repository;

  UpdateNoteUsecase(this.repository);

  Future<void> call(Note note) async {
    await repository.updateNote(note);
  }
}