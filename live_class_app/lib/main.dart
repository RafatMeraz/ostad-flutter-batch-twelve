import 'package:flutter/material.dart';

// State - two type
// Local, Shared/Application

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CounterControllerInheritedWidget(
      counterController: CounterController(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final counterController = CounterControllerInheritedWidget.of(
      context,
    ).counterController;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            ListenableBuilder(
              listenable: counterController,
              builder: (context, child) {
                return Text(
                  '${counterController.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              child: Text('Navigate to Settings'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterController.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterController = CounterControllerInheritedWidget.of(
      context,
    ).counterController;

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ListenableBuilder(
              listenable: counterController,
              builder: (context, child) {
                return Text('Counter ${counterController.counter}');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterController extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class CounterControllerInheritedWidget extends InheritedWidget {
  final CounterController counterController;

  const CounterControllerInheritedWidget({
    super.key,
    required super.child,
    required this.counterController,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static CounterControllerInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CounterControllerInheritedWidget>()!;
  }
}
