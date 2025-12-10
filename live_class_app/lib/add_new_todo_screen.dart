import 'package:flutter/material.dart';
import 'package:live_class_app/todo.dart';
import 'package:live_class_app/todo_list_controller.dart';
import 'package:provider/provider.dart';

class AddNewTodoScreen extends StatefulWidget {
  const AddNewTodoScreen({super.key});

  @override
  State<AddNewTodoScreen> createState() => _AddNewTodoScreenState();
}

class _AddNewTodoScreenState extends State<AddNewTodoScreen> {
  final TextEditingController _todoTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Todo')),
      body: Column(
        children: [
          TextFormField(controller: _todoTEController),
          ElevatedButton(
            onPressed: () {
              context.read<TodoListController>().addTodo(
                Todo(title: _todoTEController.text),
              );
              _todoTEController.clear();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('New todo added')));
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _todoTEController.dispose();
    super.dispose();
  }
}
