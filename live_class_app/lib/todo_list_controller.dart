import 'package:flutter/foundation.dart';
import 'package:live_class_app/todo.dart';

class TodoListController extends ChangeNotifier {
  final List<Todo> _todoList = [];

  List<Todo> get todoList => _todoList;

  void addTodo(Todo todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void changeStatus(int id) {
    for (Todo todo in _todoList) {
      if (todo.id == id) {
        todo.changeStatus();
        notifyListeners();
      }
    }
  }
}
