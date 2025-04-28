import 'package:catat_aku/note/domain/repositories/note_repository.dart';

class RemoveNoteUsecase {
    final NoteRepository repository;

    RemoveNoteUsecase(this.repository);

    Future<void> call(String id) async {
        await repository.deleteNote(id);
    }
}