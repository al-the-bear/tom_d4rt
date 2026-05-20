// Counter UI using `StatefulBuilder` for interactivity.
//
// State lives on a plain Dart object captured by the builder closure;
// the bridged `StatefulBuilder.setState` is what marks the element dirty
// so Flutter actually re-runs the builder when the FAB is tapped.
//
// (Equivalent code written with `class CounterHome extends StatefulWidget`
// + `class _CounterHomeState extends State<CounterHome>` would compile and
// run, but the script's `setState(() => _count++)` is a no-op in tom_d4rt
// today — see the multi-line note in main.dart.)
import 'package:flutter/material.dart';

class CounterState {
  int count = 0;
  int builds = 0;
}

class CounterHome extends StatelessWidget {
  final CounterState state = CounterState();

  CounterHome({super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        state.builds = state.builds + 1;
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Counter (multi-file)')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'count = ${state.count}',
                  style: theme.textTheme.displayMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'build #${state.builds}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                state.count = state.count + 1;
              });
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
