import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todoapp/data/todo.dart';

import 'data/boxes.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: ValueListenableBuilder<Box<Todo>>(
        valueListenable: Hive.box<Todo>(Todo.boxName).listenable(),
        builder: (context, box, _) {
          final List<Todo> todos = box.values.toList().cast<Todo>();
          if (todos.length == 0) {
            return Center(child: Text('Kosong'));
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              Todo data = todos[index];
              return ListTile(
                title: Text(data.agenda!),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: todos.length,
          );
        },
      ),
    );
  }
}
