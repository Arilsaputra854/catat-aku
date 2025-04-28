import 'package:catat_aku/note/data/repositories/note_repository_impl.dart';
import 'package:catat_aku/note/domain/repositories/note_repository.dart';
import 'package:catat_aku/note/domain/usecases/add_note_usecase.dart';
import 'package:catat_aku/note/domain/usecases/get_note_usecase.dart';
import 'package:catat_aku/note/domain/usecases/remove_note_usecase.dart';
import 'package:catat_aku/note/domain/usecases/update_note_usecase.dart';
import 'package:catat_aku/note/presentation/bloc/note_cubit.dart';
import 'package:catat_aku/note/presentation/pages/note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    NoteRepositoryImpl repository = NoteRepositoryImpl();
    return BlocProvider(
      create:
          (_) => NoteCubit(
            addNoteUseCase: AddNoteUseCase(repository),
            getNoteUsecase: GetNoteUsecase(repository),
            updateNoteUsecase: UpdateNoteUsecase(repository),
            removeNoteUsecase: RemoveNoteUsecase(repository),
          ),
      child: MaterialApp(
        title: 'Catat Aku',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        ),
        home: NotePage(),
      ),
    );
  }
}
