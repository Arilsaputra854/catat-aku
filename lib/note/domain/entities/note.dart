
class Note{
  String id;
  String name;
  String note;
  DateTime? createAt;
  DateTime? updateAt;

  Note({required this.id,
    required this.name, required this.note,  this.createAt, this.updateAt
  });

}