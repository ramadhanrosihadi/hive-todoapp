import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todoapp/data/boxes.dart';
import 'package:hive_todoapp/data/todo.dart';
import 'package:hive_todoapp/detail_screen.dart';
import 'package:hive_todoapp/item_todo.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void addToDo(String agenda) {
    Todo newData = Todo()
      ..agenda = agenda
      ..createdAt = DateTime.now();

    final box = Hive.box<Todo>(Todo.boxName);
    box.add(newData);
  }

  Future<String?> upsertDialog(Todo? data) async {
    return await showDialog<String?>(
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController();
          if (data != null) {
            controller.text = data.agenda!;
          }
          return AlertDialog(
            title: Text(
              data != null ? "Edit" : "New agenda",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            contentPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            content: TextFormField(
              controller: controller,
              decoration: InputDecoration(hintText: "Tell me your agenda"),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, controller.text);
                },
                child: Text(data != null ? 'Save' : 'Add'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Today Agendas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? result = await upsertDialog(null);
          if (result != null) {
            addToDo(result);
          }
        },
        child: Icon(Icons.add),
      ),
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
              return ItemTodo(
                data: data,
                onDelete: () {
                  data.delete();
                },
                onEdit: () async {
                  String? result = await upsertDialog(data);
                  if (result != null) {
                    data.agenda = result;
                    data.save();
                  }
                },
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
