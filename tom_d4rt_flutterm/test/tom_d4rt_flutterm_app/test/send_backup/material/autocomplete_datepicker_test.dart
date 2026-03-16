import 'package:flutter/material.dart';

/// Deep visual demo for Autocomplete with date picker.
/// Shows autocomplete for date input.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Autocomplete DatePicker')),
    body: Center(child: _DateAutocomplete()),
  );
}

class _DateAutocomplete extends StatefulWidget {
  @override
  State<_DateAutocomplete> createState() => _DateAutocompleteState();
}

class _DateAutocompleteState extends State<_DateAutocomplete> {
  DateTime? _selected;
  final _dates = List.generate(30, (i) => DateTime.now().add(Duration(days: i)));

  String _format(DateTime d) => '\${d.month}/\${d.day}/\${d.year}';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Type or pick a date:', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Autocomplete<DateTime>(
                  displayStringForOption: _format,
                  optionsBuilder: (v) => _dates.where((d) => _format(d).contains(v.text)),
                  onSelected: (d) => setState(() => _selected = d),
                  fieldViewBuilder: (ctx, ctrl, focus, submit) => TextField(
                    controller: ctrl,
                    focusNode: focus,
                    decoration: const InputDecoration(hintText: 'MM/DD/YYYY', border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (d != null) setState(() => _selected = d);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_selected != null)
            Chip(label: Text('Selected: \${_format(_selected!)}')),
        ],
      ),
    );
  }
}
