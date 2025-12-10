class Todo {
  final String title;
  final int id = DateTime.timestamp().millisecondsSinceEpoch;
  bool isDone = false;

  Todo({required this.title});

  void changeStatus() {
    isDone = !isDone;
  }
}
