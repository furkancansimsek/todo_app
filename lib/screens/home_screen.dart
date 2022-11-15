import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/helpers/drawer_navigation.dart';

import '../models/todo.dart';
import '../repositories/database_connection.dart';
import '../widgets/todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _categoryNameController = TextEditingController();

  var db = DatabaseConnection();

  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  void deleteItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: Column(
        children: [
          TodoList(insertFunction: addItem, deleteFunction: deleteItem),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              barrierDismissible: true,
              radius: 5,
              titlePadding:
                  const EdgeInsets.only(top: 20, left: 20, bottom: 20),
              contentPadding: const EdgeInsets.all(10),
              confirm: MaterialButton(
                onPressed: () async {
                  if (_categoryNameController.text != '') {
                    var myTodo = Todo(
                      title: _categoryNameController.text == ''
                          ? 'Untitled'
                          : _categoryNameController.text,
                      creationDate: DateFormat('EEE, MMM d')
                          .format(DateTime.now())
                          .toString(),
                      isChecked: false,
                    );
                    _categoryNameController.text = '';
                    Get.back();
                    addItem(myTodo);
                  } else {
                    Get.snackbar('Attention', 'Please enter a task',
                        backgroundColor: Colors.white,
                        isDismissible: true,
                        dismissDirection: DismissDirection.horizontal,
                        duration: const Duration(seconds: 2));
                  }
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('Save'),
              ),
              cancel: MaterialButton(
                onPressed: () {
                  Get.back();
                },
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Cancel'),
              ),
              title: 'What do you need to do?',
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _categoryNameController,
                      decoration: const InputDecoration(
                        hintText: 'Write a task',
                        labelText: 'Task',
                      ),
                    )
                  ],
                ),
              ));
        },
        child: const Icon(Icons.add),
      ),
      drawer: const DrawerNavigation(),
    );
  }
}
