import 'package:flutter/material.dart';

/// Deep visual demo for CalendarDelegate.
/// Shows calendar date selection delegate.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CalendarDelegate')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Calendar Date Selection', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Used internally by date picker widgets', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 24),
        const Text('Delegate Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
        _Method('buildItems', 'Build calendar day widgets'),
        _Method('firstDayOfMonth', 'Get first day of displayed month'),
        _Method('handleMonthPageChanged', 'Handle month navigation'),
        _Method('selectableDayPredicate', 'Filter selectable dates'),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (date != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: ' + date.toString().split(' ')[0])),
              );
            }
          },
          icon: const Icon(Icons.calendar_today),
          label: const Text('Open DatePicker'),
        ),
      ],
    ),
  );
}

class _Method extends StatelessWidget {
  final String name, desc;
  const _Method(this.name, this.desc);
  @override
  Widget build(BuildContext context) => ListTile(
    leading: const Icon(Icons.code, size: 20),
    title: Text(name, style: const TextStyle(fontFamily: 'monospace')),
    subtitle: Text(desc),
    dense: true,
  );
}
