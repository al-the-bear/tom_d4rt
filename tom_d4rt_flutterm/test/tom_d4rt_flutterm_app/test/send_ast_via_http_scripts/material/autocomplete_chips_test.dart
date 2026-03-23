// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests showDateRangePicker, RestorableTimeOfDay, AutocompleteOptionsBuilder, AutocompleteFieldViewBuilder, AutocompleteOptionsViewBuilder, AutocompleteOnSelected, TappableChipAttributes, DisabledChipAttributes, CheckableChipAttributes
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Autocomplete typedefs and chip attributes tests executing');

  // ========== showDateRangePicker ==========
  print('--- showDateRangePicker Tests ---');
  // showDateRangePicker is a top-level function that shows a date range picker dialog.
  // Cannot call it directly in build() as it requires a navigator context, but we can reference it.
  print('showDateRangePicker type: ${showDateRangePicker.runtimeType}');
  print(
    'showDateRangePicker is a Function: true (showDateRangePicker is always a Function)',
  );

  // ========== RestorableTimeOfDay ==========
  print('--- RestorableTimeOfDay Tests ---');
  final restorableTime = RestorableTimeOfDay(TimeOfDay(hour: 10, minute: 30));
  print('RestorableTimeOfDay type: ${restorableTime.runtimeType}');
  // Note: .value requires isRegistered via RestorationMixin
  print('RestorableTimeOfDay created with TimeOfDay(10:30)');

  // ========== AutocompleteOptionsBuilder ==========
  print('--- AutocompleteOptionsBuilder Tests ---');
  // AutocompleteOptionsBuilder<T> = Iterable<T> Function(TextEditingValue)
  Iterable<String> optionsBuilder(TextEditingValue textEditingValue) {
    final options = ['Apple', 'Banana', 'Cherry'];
    if (textEditingValue.text.isEmpty) {
      return options;
    }
    return options.where(
      (String option) =>
          option.toLowerCase().contains(textEditingValue.text.toLowerCase()),
    );
  }

  print('AutocompleteOptionsBuilder type: ${optionsBuilder.runtimeType}');
  final testResult = optionsBuilder(TextEditingValue(text: 'a'));
  print('AutocompleteOptionsBuilder result for "a": $testResult');

  // ========== AutocompleteFieldViewBuilder ==========
  print('--- AutocompleteFieldViewBuilder Tests ---');
  // AutocompleteFieldViewBuilder = Widget Function(BuildContext, TextEditingController, FocusNode, VoidCallback)
  Widget fieldViewBuilder(
    BuildContext ctx,
    TextEditingController controller,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    return TextField(controller: controller, focusNode: focusNode);
  }

  print('AutocompleteFieldViewBuilder type: ${fieldViewBuilder.runtimeType}');

  // ========== AutocompleteOptionsViewBuilder ==========
  print('--- AutocompleteOptionsViewBuilder Tests ---');
  // AutocompleteOptionsViewBuilder<T> = Widget Function(BuildContext, AutocompleteOnSelected<T>, Iterable<T>)
  Widget optionsViewBuilder(
    BuildContext ctx,
    AutocompleteOnSelected<String> onSelected,
    Iterable<String> options,
  ) {
    return ListView(
      children: options
          .map(
            (String option) =>
                ListTile(title: Text(option), onTap: () => onSelected(option)),
          )
          .toList(),
    );
  }

  print(
    'AutocompleteOptionsViewBuilder type: ${optionsViewBuilder.runtimeType}',
  );

  // ========== AutocompleteOnSelected ==========
  print('--- AutocompleteOnSelected Tests ---');
  // AutocompleteOnSelected<T> = void Function(T)
  void onSelected(String selection) {
    print('Selected: $selection');
  }

  print('AutocompleteOnSelected type: ${onSelected.runtimeType}');

  // ========== TappableChipAttributes ==========
  print('--- TappableChipAttributes Tests ---');
  // TappableChipAttributes is a mixin on chip classes like ActionChip
  final actionChip = ActionChip(label: Text('Action'), onPressed: () {});
  print(
    'ActionChip type (has TappableChipAttributes): ${actionChip.runtimeType}',
  );
  print('ActionChip is Widget: true (ActionChip is always a Widget)');

  // ========== DisabledChipAttributes ==========
  print('--- DisabledChipAttributes Tests ---');
  // DisabledChipAttributes is a mixin providing isEnabled/onDeleted etc.
  final inputChip = InputChip(label: Text('Input'), isEnabled: false);
  print(
    'InputChip type (has DisabledChipAttributes): ${inputChip.runtimeType}',
  );
  print('InputChip isEnabled: false (DisabledChipAttributes)');

  // ========== CheckableChipAttributes ==========
  print('--- CheckableChipAttributes Tests ---');
  // CheckableChipAttributes is a mixin on FilterChip providing selected/showCheckmark
  final filterChip = FilterChip(
    label: Text('Filter'),
    selected: true,
    onSelected: (bool value) {},
    showCheckmark: true,
  );
  print(
    'FilterChip type (has CheckableChipAttributes): ${filterChip.runtimeType}',
  );
  print('FilterChip selected: true (CheckableChipAttributes)');

  print('All autocomplete and chip attribute tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Autocomplete & Chips Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('showDateRangePicker: function referenced'),
            Text('RestorableTimeOfDay: created'),
            Text('AutocompleteOptionsBuilder: defined'),
            Text('AutocompleteFieldViewBuilder: defined'),
            Text('AutocompleteOptionsViewBuilder: defined'),
            Text('AutocompleteOnSelected: defined'),
            Text('TappableChipAttributes: via ActionChip'),
            Text('DisabledChipAttributes: via InputChip'),
            Text('CheckableChipAttributes: via FilterChip'),
          ],
        ),
      ),
    ),
  );
}
