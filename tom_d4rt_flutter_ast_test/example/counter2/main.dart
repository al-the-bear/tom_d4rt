import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Multi Counter',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
    ),
    home: const MultiCounterHome(),
  );
}

class MultiCounterHome extends StatefulWidget {
  const MultiCounterHome({super.key});

  @override
  State<MultiCounterHome> createState() => _MultiCounterHomeState();
}

class _MultiCounterHomeState extends State<MultiCounterHome> {
  final List<_CounterData> _counters = [
    _CounterData(id: 1, value: 0),
  ];
  int _nextId = 2;

  void _addCounter() {
    setState(() {
      _counters.add(_CounterData(id: _nextId, value: 0));
      print('Added counter #$_nextId (total=${_counters.length})');
      _nextId = _nextId + 1;
    });
  }

  void _removeCounter(int id) {
    setState(() {
      _counters.removeWhere((c) => c.id == id);
      print('Removed counter #$id (total=${_counters.length})');
    });
  }

  void _increment(int id) {
    setState(() {
      final c = _counters.firstWhere((c) => c.id == id);
      c.value = c.value + 1;
      print('Counter #$id -> ${c.value}');
    });
  }

  void _decrement(int id) {
    setState(() {
      final c = _counters.firstWhere((c) => c.id == id);
      c.value = c.value - 1;
      print('Counter #$id -> ${c.value}');
    });
  }

  void _resetCounter(int id) {
    setState(() {
      final c = _counters.firstWhere((c) => c.id == id);
      c.value = 0;
      print('Counter #$id reset');
    });
  }

  int get _total =>
      _counters.fold<int>(0, (sum, c) => sum + c.value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Counter'),
        backgroundColor: theme.colorScheme.primaryContainer,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Σ = $_total',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _counters.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline,
                      size: 72,
                      color: theme.colorScheme.outline),
                  const SizedBox(height: 12),
                  Text(
                    'No counters yet.\nTap + to add one.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
              itemCount: _counters.length,
              itemBuilder: (context, index) {
                final c = _counters[index];
                return Padding(
                  key: ValueKey<int>(c.id),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: _CounterCard(
                    label: 'Counter #${c.id}',
                    value: c.value,
                    onIncrement: () => _increment(c.id),
                    onDecrement: () => _decrement(c.id),
                    onReset: () => _resetCounter(c.id),
                    onRemove: () => _removeCounter(c.id),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCounter,
        icon: const Icon(Icons.add),
        label: const Text('Add counter'),
      ),
    );
  }
}

class _CounterData {
  final int id;
  int value;
  _CounterData({required this.id, required this.value});
}

class _CounterCard extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;
  final VoidCallback onRemove;

  const _CounterCard({
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = value > 0;
    final isNegative = value < 0;
    final valueColor = isPositive
        ? Colors.green.shade700
        : isNegative
            ? Colors.red.shade700
            : theme.colorScheme.onSurface;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    '$value',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: valueColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton.filledTonal(
                      onPressed: onDecrement,
                      icon: const Icon(Icons.remove),
                      tooltip: 'Decrement',
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: onIncrement,
                      icon: const Icon(Icons.add),
                      tooltip: 'Increment',
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: onReset,
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Reset'),
                    ),
                    IconButton(
                      onPressed: onRemove,
                      icon: const Icon(Icons.delete_outline),
                      color: theme.colorScheme.error,
                      tooltip: 'Remove counter',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}