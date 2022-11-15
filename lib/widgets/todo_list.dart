import 'package:flutter/material.dart';
import 'package:todo_app/repositories/database_connection.dart';
import 'package:todo_app/widgets/todo_card.dart';

class TodoList extends StatefulWidget {
  const TodoList({
    Key? key,
    required this.deleteFunction,
    required this.insertFunction,
  }) : super(key: key);

  final Function deleteFunction;
  final Function insertFunction;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  DatabaseConnection db = DatabaseConnection();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: db.getTodo(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            if (data!.isEmpty) {
              return const Center(
                child: Text('Write some task!'),
              );
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, i) {
                return TodoCard(
                  isChecked: data[i].isChecked,
                  id: data[i].id,
                  title: data[i].title,
                  creationDate: data[i].creationDate,
                  insertFunction: widget.insertFunction,
                  deleteFunction: widget.deleteFunction,
                );
              }),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
