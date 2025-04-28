import 'package:catat_aku/note/domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    required super.id,
    required super.name,
    required super.note,
    super.createAt,
    super.updateAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      name: json['name'],
      note: json['note'],
      createAt:
          json['create_at'] != null
              ? DateTime.parse(json['create_at'])
              : DateTime.now(),
      updateAt: json['update_at'] != null? DateTime.parse(json['update_at']) : DateTime.now(),
    );
  }

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      name: note.name,
      note: note.note,
      createAt: note.createAt,
      updateAt: note.updateAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'note': note,
      'create_at': createAt!.toIso8601String(),
      'update_at': updateAt!.toIso8601String(),
    };
  }
}
