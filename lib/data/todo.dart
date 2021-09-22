import 'package:hive/hive.dart';

class Todo {
  String? agenda;

  DateTime? createdAt;

  DateTime? doneAt;

  Todo({
    this.agenda,
    this.createdAt,
    this.doneAt,
  });
}
