import 'package:flutter/material.dart';
import 'package:hive_todoapp/data/todo.dart';

class ItemTodo extends StatelessWidget {
  const ItemTodo({Key? key, required this.data, required this.onDelete, required this.onEdit}) : super(key: key);
  final Todo data;
  final Function() onDelete;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              data.agenda!,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onEdit,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.blue[800],
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Edit",
                        style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onDelete,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Delete",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
