
import 'package:catat_aku/note/domain/entities/note.dart';
import 'package:catat_aku/note/domain/repositories/note_repository.dart';

class GetNoteUsecase {
  final NoteRepository repository;

  GetNoteUsecase(this.repository);

  Future<List<Note>> call()async {
    List<Note> notes = await repository.getNotes();

    notes.sort((a, b) {
      return b.updateAt!.compareTo(a.updateAt!);
    },);

    return notes;
  }

}