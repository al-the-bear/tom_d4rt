// StatefulWidget under test. Lives in a separate file from `main.dart`
// so that the multi-file class-resolution path (relative import →
// resolveImportsRecursively → d4rt sources map → cross-module
// `extends State<CounterHome>` binding) is exercised. If the displayed
// count stays at 0 when the FAB is tapped, setState is not propagating
// for cross-file user-defined StatefulWidgets.
import 'package:flutter/material.dart';

class CounterHome extends StatefulWidget {
  const CounterHome({super.key});

  @override
  State<CounterHome> createState() => _CounterHomeState();
}

class _CounterHomeState extends State<CounterHome> {
  int _count = 0;
  int _builds = 0;

  void _increment() {
    setState(() {
      _count = _count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    _builds++;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter (multi-file)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'count = $_count',
              style: theme.textTheme.displayMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'build #$_builds',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
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
