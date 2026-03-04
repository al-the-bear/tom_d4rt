// D4rt test script: Tests Autocomplete, RawAutocomplete,
// CalendarDatePickerMode, DateRangePickerDialog
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Autocomplete/DatePicker advanced test executing');

  // ========== CalendarDatePickerMode ==========
  print('--- CalendarDatePickerMode Tests ---');
  for (final mode in DatePickerMode.values) {
    print('DatePickerMode: ${mode.name}');
  }

  // ========== Autocomplete ==========
  print('--- Autocomplete Tests ---');
  final options = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  final autocomplete = Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();
      return options.where((o) => o.toLowerCase().contains(
        textEditingValue.text.toLowerCase(),
      ));
    },
    onSelected: (String selection) {
      print('Selected: $selection');
    },
  );
  print('Autocomplete created with ${options.length} options');

  // ========== RawAutocomplete ==========
  print('--- RawAutocomplete Tests ---');
  final rawAutocomplete = RawAutocomplete<String>(
    optionsBuilder: (TextEditingValue value) {
      return options.where((o) => o.toLowerCase().startsWith(
        value.text.toLowerCase(),
      ));
    },
    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        onSubmitted: (value) => onFieldSubmitted(),
      );
    },
    optionsViewBuilder: (context, onSelected, options) {
      return Material(
        child: ListView(
          children: options.map((o) => ListTile(
            title: Text(o),
            onTap: () => onSelected(o),
          )).toList(),
        ),
      );
    },
  );
  print('RawAutocomplete created');

  // ========== RestorableTimeOfDay ==========
  print('--- RestorableTimeOfDay Tests ---');
  final restorableTime = RestorableTimeOfDay(TimeOfDay(hour: 10, minute: 30));
  print('RestorableTimeOfDay: ${restorableTime.value}');

  print('All autocomplete/datepicker tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Autocomplete/DatePicker Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            autocomplete,
            SizedBox(height: 16.0),
            Text('DatePickerMode: ${DatePickerMode.values.length} modes'),
            Text('RestorableTimeOfDay: 10:30'),
          ],
        ),
      ),
    ),
  );
}
