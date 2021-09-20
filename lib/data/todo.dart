import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  static String boxName = "todos";

  @HiveField(0)
  String? agenda;

  @HiveField(1)
  DateTime? createdAt;

  @HiveField(2)
  DateTime? doneAt;

  Todo({
    this.agenda,
    this.createdAt,
    this.doneAt,
  });
}
