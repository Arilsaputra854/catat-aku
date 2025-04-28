import 'package:catat_aku/note/domain/repositories/note_repository.dart';
import 'package:catat_aku/note/domain/entities/note.dart';
import 'package:catat_aku/note/domain/usecases/add_note_usecase.dart';
import 'package:catat_aku/note/domain/usecases/get_note_usecase.dart';
import 'package:catat_aku/note/domain/usecases/remove_note_usecase.dart';
import 'package:catat_aku/note/domain/usecases/update_note_usecase.dart';
import 'package:catat_aku/note/presentation/bloc/note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteCubit extends Cubit<NoteState> {
  final AddNoteUseCase addNoteUseCase;
  final UpdateNoteUsecase updateNoteUsecase;
  final RemoveNoteUsecase removeNoteUsecase;
  final GetNoteUsecase getNoteUsecase;

  NoteCubit({
    required this.addNoteUseCase,
    required this.getNoteUsecase,
    required this.updateNoteUsecase,
    required this.removeNoteUsecase,
  }) : super(NoteInitial());


  Future<void> saveNote(Note note)async{
    await addNoteUseCase.call(note);
    final notes = await getNoteUsecase.call();
    emit(NoteAddSuccess(notes: notes));
  }


  Future<void> updateNote(Note note)async{
    await updateNoteUsecase.call(note);
    final notes = await getNoteUsecase.call();
    emit(NoteUpdateSuccess(notes: notes));
  }


  Future<void> deleteNote(String id)async{
    await removeNoteUsecase.call(id);
    final notes = await getNoteUsecase.call();
    emit(NoteDeleteSuccess(notes: notes));
  }

  Future<void> getNotes() async {
    final notes = await getNoteUsecase.call();
    emit(NoteLoadSuccess(notes));
  }
}
