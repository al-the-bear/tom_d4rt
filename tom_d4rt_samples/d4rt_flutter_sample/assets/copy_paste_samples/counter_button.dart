// Copy-paste snippet: a script-defined StatefulWidget whose `setState`
// drives a real Flutter rebuild through the interpreter.
import 'package:flutter/material.dart';

Widget build(BuildContext context) => const CounterDemo();

class CounterDemo extends StatefulWidget {
  const CounterDemo({super.key});

  @override
  State<CounterDemo> createState() => _CounterDemoState();
}

class _CounterDemoState extends State<CounterDemo> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Text('Count: $_count', style: const TextStyle(fontSize: 28)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count = _count + 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
