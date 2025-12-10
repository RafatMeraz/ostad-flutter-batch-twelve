import 'package:flutter/material.dart';
import 'package:live_class_app/add_new_todo_screen.dart';
import 'package:live_class_app/todo_list_controller.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: Consumer<TodoListController>(
        builder: (context, todoListController, child) {
          return ListView.separated(
            itemCount: todoListController.todoList.length,
            itemBuilder: (context, index) {
              final todo = todoListController.todoList[index];

              return ListTile(
                onTap: () {
                  todoListController.changeStatus(todo.id);
                },
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 4);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddNewTodoScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
