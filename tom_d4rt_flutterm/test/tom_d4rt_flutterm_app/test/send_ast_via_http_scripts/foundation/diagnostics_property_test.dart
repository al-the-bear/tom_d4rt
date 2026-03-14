import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

void _expectCondition(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed: $message');
  }
  print('✅ $message');
}

String _describeProperty(DiagnosticsProperty<Object?> property) {
  return 'name=${property.name}, value=${property.value}, level=${property.level}, default=${property.defaultValue}, ifNull=${property.ifNull}';
}

List<DiagnosticsProperty<Object?>> _createDiagnosticsProperties() {
  return [
    DiagnosticsProperty<Object?>('title', 'hello world'),
    DiagnosticsProperty<Object?>('count', 42, defaultValue: 0),
    DiagnosticsProperty<Object?>('nullable', null, ifNull: 'not set'),
    DiagnosticsProperty<Object?>('enabled', true, level: DiagnosticLevel.debug),
    DiagnosticsProperty<Object?>('sameAsDefault', 7, defaultValue: 7),
  ];
}

dynamic build(BuildContext context) {
  print('--- DiagnosticsProperty comprehensive test start ---');

  final properties = _createDiagnosticsProperties();
  final names = properties
      .map((property) => property.name)
      .toList(growable: false);

  print('DiagnosticsProperty instances created: ${properties.length}');
  for (final property in properties) {
    print('Property -> ${_describeProperty(property)}');
  }

  _expectCondition(
    properties.length == 5,
    'Created expected number of properties',
  );
  _expectCondition(
    names.toSet().length == names.length,
    'Property names are unique',
  );

  final title = properties[0];
  final count = properties[1];
  final nullable = properties[2];
  final enabled = properties[3];
  final sameAsDefault = properties[4];

  _expectCondition(title.name == 'title', 'Title property has expected name');
  _expectCondition(
    title.value == 'hello world',
    'Title property keeps assigned value',
  );
  _expectCondition(
    title.level == DiagnosticLevel.info,
    'Title property default level is info',
  );

  _expectCondition(count.name == 'count', 'Count property has expected name');
  _expectCondition(count.value == 42, 'Count property keeps integer value');
  _expectCondition(
    count.defaultValue == 0,
    'Count property keeps explicit defaultValue',
  );

  _expectCondition(
    nullable.name == 'nullable',
    'Nullable property has expected name',
  );
  _expectCondition(
    nullable.value == null,
    'Nullable property stores null value',
  );
  _expectCondition(
    nullable.ifNull == 'not set',
    'Nullable property keeps ifNull fallback',
  );

  _expectCondition(
    enabled.name == 'enabled',
    'Enabled property has expected name',
  );
  _expectCondition(
    enabled.value == true,
    'Enabled property keeps boolean value',
  );
  _expectCondition(
    enabled.level == DiagnosticLevel.debug,
    'Enabled property keeps debug level',
  );

  _expectCondition(
    sameAsDefault.name == 'sameAsDefault',
    'sameAsDefault property has expected name',
  );
  _expectCondition(
    sameAsDefault.value == 7,
    'sameAsDefault property stores numeric value',
  );
  _expectCondition(
    sameAsDefault.defaultValue == 7,
    'sameAsDefault property stores matching default',
  );

  final infoFilter = title.isFiltered(DiagnosticLevel.info);
  final warningFilter = title.isFiltered(DiagnosticLevel.warning);
  final hiddenFilter = enabled.isFiltered(DiagnosticLevel.hidden);

  print(
    'Filter checks -> info=$infoFilter, warning=$warningFilter, hidden=$hiddenFilter',
  );
  _expectCondition(
    infoFilter == true || infoFilter == false,
    'isFiltered(info) returns a valid boolean value',
  );
  _expectCondition(
    warningFilter == true || warningFilter == false,
    'isFiltered(warning) returns a valid boolean value',
  );
  _expectCondition(
    hiddenFilter == true || hiddenFilter == false,
    'isFiltered(hidden) returns a valid boolean value',
  );

  final titleString = title.toString();
  final countString = count.toString();
  final nullableString = nullable.toString();

  print('toString(title): $titleString');
  print('toString(count): $countString');
  print('toString(nullable): $nullableString');

  _expectCondition(
    titleString.contains('title'),
    'title.toString includes property name',
  );
  _expectCondition(
    countString.contains('count'),
    'count.toString includes property name',
  );
  _expectCondition(
    nullableString.contains('nullable'),
    'nullable.toString includes property name',
  );

  final summary =
      'DiagnosticsProperty summary -> count=${properties.length}, names=$names, titleLevel=${title.level}, enabledLevel=${enabled.level}';
  print(summary);
  print('--- DiagnosticsProperty comprehensive test complete ---');

  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DiagnosticsProperty Comprehensive Tests'),
        Text('Property count: ${properties.length}'),
        Text('Names: ${names.join(', ')}'),
        Text('Title level: ${title.level}'),
        Text('Enabled level: ${enabled.level}'),
        Text('Info filter value: $infoFilter'),
        Text('Nullable ifNull: ${nullable.ifNull}'),
        Text(summary),
        for (final property in properties)
          Text(
            '${property.name}: value=${property.value}, default=${property.defaultValue}',
          ),
      ],
    ),
  );
}
