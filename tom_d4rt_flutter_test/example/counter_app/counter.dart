// Counter UI exercising an idiomatic script-defined `StatefulWidget`.
//
// State lives on `_CounterHomeState`; `setState` is routed through the
// `_InterpretedState` proxy (GEN-112) so calling it actually schedules
// a Flutter rebuild. Used as a sanity check for the multi-file pipeline
// and the bridged-super `setState` path.
import 'package:flutter/material.dart';

class CounterHome extends StatefulWidget {
  const CounterHome({super.key});

  @override
  State<CounterHome> createState() => _CounterHomeState();
}

class _CounterHomeState extends State<CounterHome> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count = _count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter (multi-file)')),
      body: Center(
        child: Text(
          'count = $_count',
          style: theme.textTheme.displayMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
