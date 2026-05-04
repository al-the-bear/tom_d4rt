// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests DiagnosticsProperty<T> class from foundation
// Deep Demo: Visual demonstration of DiagnosticsProperty<T> constructors,
// parameters, behaviour, levels and the family of typed sub-properties.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsProperty<T> Deep Demo executing');

  // ============================================================
  // SECTION 1: Hero header + at-a-glance summary
  // ============================================================
  print('=== Section 1: Hero header ===');

  final hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF311B92),
          Color(0xFF4A148C),
        ],
        stops: [0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 20.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 18.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.5),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(Icons.bug_report, color: Colors.white, size: 36.0),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DiagnosticsProperty<T>',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/foundation.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Text(
          'A typed DiagnosticsNode that carries one named property of type T,\n'
          'used by debugFillProperties to surface widget / object state in\n'
          'the Flutter Inspector, toStringDeep, and DevTools.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.45,
          ),
        ),
        SizedBox(height: 20.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            _heroChip('extends DiagnosticsNode', Colors.indigo),
            _heroChip('Type parameter T', Colors.deepPurple),
            _heroChip('Lazy variant', Colors.teal),
            _heroChip('Filterable by level', Colors.orange),
            _heroChip('JSON-serialisable', Colors.pink),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of the constructor signature
  // ============================================================
  print('=== Section 2: Constructor anatomy ===');

  final ctorParams = <Map<String, Object>>[
    {
      'name': 'name',
      'type': 'String?',
      'required': true,
      'desc': 'Property label shown before the value.',
      'color': Colors.indigo,
    },
    {
      'name': 'value',
      'type': 'T?',
      'required': true,
      'desc': 'The property value. Type is preserved via T.',
      'color': Colors.deepPurple,
    },
    {
      'name': 'description',
      'type': 'String?',
      'required': false,
      'desc': 'Human-readable description; overrides value text.',
      'color': Colors.blue,
    },
    {
      'name': 'ifNull',
      'type': 'String?',
      'required': false,
      'desc': 'Text emitted when value is null.',
      'color': Colors.teal,
    },
    {
      'name': 'ifEmpty',
      'type': 'String?',
      'required': false,
      'desc': 'Text emitted when valueToString() is empty.',
      'color': Colors.cyan,
    },
    {
      'name': 'showName',
      'type': 'bool',
      'required': false,
      'desc': 'Whether to print the property name. Default: true.',
      'color': Colors.green,
    },
    {
      'name': 'showSeparator',
      'type': 'bool',
      'required': false,
      'desc': 'Whether to print a separator between name and value.',
      'color': Colors.lightGreen,
    },
    {
      'name': 'defaultValue',
      'type': 'Object?',
      'required': false,
      'desc': 'When equal, level drops to fine. Default: kNoDefaultValue.',
      'color': Colors.amber,
    },
    {
      'name': 'tooltip',
      'type': 'String?',
      'required': false,
      'desc': 'Suffix shown in parentheses, e.g. units.',
      'color': Colors.orange,
    },
    {
      'name': 'missingIfNull',
      'type': 'bool',
      'required': false,
      'desc': 'If true and value is null, level becomes warning.',
      'color': Colors.deepOrange,
    },
    {
      'name': 'expandableValue',
      'type': 'bool',
      'required': false,
      'desc': 'Expose nested properties of a Diagnosticable value.',
      'color': Colors.red,
    },
    {
      'name': 'allowWrap',
      'type': 'bool',
      'required': false,
      'desc': 'Whether the value text may wrap across lines.',
      'color': Colors.pink,
    },
    {
      'name': 'allowNameWrap',
      'type': 'bool',
      'required': false,
      'desc': 'Whether the name text may wrap across lines.',
      'color': Colors.purple,
    },
    {
      'name': 'style',
      'type': 'DiagnosticsTreeStyle',
      'required': false,
      'desc': 'Tree drawing style. Default: singleLine.',
      'color': Colors.brown,
    },
    {
      'name': 'level',
      'type': 'DiagnosticLevel',
      'required': false,
      'desc': 'Suggested level. May be overridden. Default: info.',
      'color': Colors.blueGrey,
    },
  ];

  final paramCards = <Widget>[];
  for (final p in ctorParams) {
    final color = p['color'] as Color;
    final required = p['required'] as bool;
    paramCards.add(
      Container(
        width: 230.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    p['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                ),
                if (required)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'REQ',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'opt',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                p['type'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              p['desc'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade800,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final anatomySection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade100, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Colors.indigo.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Constructor Anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _signatureBlock(
          'DiagnosticsProperty<T>(\n'
          '  String? name,\n'
          '  T? value, {\n'
          '  String? description,\n'
          '  String? ifNull,\n'
          '  String? ifEmpty,\n'
          '  bool showName = true,\n'
          '  bool showSeparator = true,\n'
          '  Object? defaultValue = kNoDefaultValue,\n'
          '  String? tooltip,\n'
          '  bool missingIfNull = false,\n'
          '  String? linePrefix,\n'
          '  bool expandableValue = false,\n'
          '  bool allowWrap = true,\n'
          '  bool allowNameWrap = true,\n'
          '  DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine,\n'
          '  DiagnosticLevel level = DiagnosticLevel.info,\n'
          '})',
        ),
        SizedBox(height: 14.0),
        Wrap(alignment: WrapAlignment.start, children: paramCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-parameter live cards
  // ============================================================
  print('=== Section 3: Per-parameter live cards ===');

  // name + value
  final pNameValue = DiagnosticsProperty<String>('label', 'hello world');
  print('pNameValue.value=${pNameValue.value} name=${pNameValue.name}');

  // description
  final pDescription = DiagnosticsProperty<int>(
    'count',
    7,
    description: 'seven items',
  );
  print('pDescription.toDescription()=${pDescription.toDescription()}');

  // ifNull (null value)
  final pIfNull = DiagnosticsProperty<String>(
    'subtitle',
    null,
    ifNull: '<unset>',
  );
  print('pIfNull.toDescription()=${pIfNull.toDescription()}');

  // ifEmpty (empty string)
  final pIfEmpty = DiagnosticsProperty<String>(
    'tag',
    '',
    ifEmpty: '<empty>',
  );
  print('pIfEmpty.toDescription()=${pIfEmpty.toDescription()}');

  // showName=false
  final pHiddenName = DiagnosticsProperty<int>(
    'order',
    3,
    showName: false,
  );
  print('pHiddenName.showName=${pHiddenName.showName}');

  // tooltip
  final pTooltip = DiagnosticsProperty<double>(
    'ratio',
    1.5,
    tooltip: 'logical px per dp',
  );
  print('pTooltip.toDescription()=${pTooltip.toDescription()}');

  // defaultValue equal -> isInteresting=false
  final pDefaultEqual = DiagnosticsProperty<int>(
    'opacity',
    255,
    defaultValue: 255,
  );
  print(
    'pDefaultEqual.isInteresting=${pDefaultEqual.isInteresting} '
    'level=${pDefaultEqual.level.name}',
  );

  // defaultValue different -> isInteresting=true
  final pDefaultDifferent = DiagnosticsProperty<int>(
    'opacity',
    128,
    defaultValue: 255,
  );
  print(
    'pDefaultDifferent.isInteresting=${pDefaultDifferent.isInteresting} '
    'level=${pDefaultDifferent.level.name}',
  );

  // missingIfNull warning level
  final pMissing = DiagnosticsProperty<String>(
    'required-name',
    null,
    missingIfNull: true,
  );
  print(
    'pMissing.level=${pMissing.level.name} ifNull=${pMissing.ifNull}',
  );

  // hidden level
  final pHidden = DiagnosticsProperty<int>(
    'internal',
    0,
    level: DiagnosticLevel.hidden,
  );
  print('pHidden.level=${pHidden.level.name}');

  // lazy constructor
  final pLazy = DiagnosticsProperty<int>.lazy(
    'lazyComputed',
    () => 1 + 1,
    defaultValue: 0,
  );
  print('pLazy.value=${pLazy.value} (lazy)');

  // lazy with throwing computeValue
  final pLazyThrows = DiagnosticsProperty<int>.lazy(
    'lazyThrows',
    () => throw StateError('boom'),
  );
  // Touch value to materialise the exception capture path.
  final lazyVal = pLazyThrows.value;
  print(
    'pLazyThrows.value=$lazyVal exception=${pLazyThrows.exception}',
  );

  final liveCards = <Widget>[
    _liveCard(
      'name + value',
      'DiagnosticsProperty<String>("label", "hello world")',
      pNameValue.toString(),
      Colors.indigo,
      Icons.label,
    ),
    _liveCard(
      'description',
      'description: "seven items"',
      pDescription.toString(),
      Colors.blue,
      Icons.description,
    ),
    _liveCard(
      'ifNull',
      'value: null, ifNull: "<unset>"',
      pIfNull.toString(),
      Colors.teal,
      Icons.do_not_disturb_on,
    ),
    _liveCard(
      'ifEmpty',
      'value: "", ifEmpty: "<empty>"',
      pIfEmpty.toString(),
      Colors.cyan,
      Icons.crop_din,
    ),
    _liveCard(
      'showName: false',
      '"order", 3, showName: false',
      pHiddenName.toString(),
      Colors.green,
      Icons.visibility_off,
    ),
    _liveCard(
      'tooltip',
      '"ratio", 1.5, tooltip: "logical px per dp"',
      pTooltip.toString(),
      Colors.orange,
      Icons.help_outline,
    ),
    _liveCard(
      'defaultValue == value',
      'level demoted to fine, isInteresting=false',
      'level=${pDefaultEqual.level.name}',
      Colors.amber,
      Icons.flag_outlined,
    ),
    _liveCard(
      'defaultValue != value',
      'kept at suggested level, isInteresting=true',
      'level=${pDefaultDifferent.level.name}',
      Colors.deepOrange,
      Icons.flag,
    ),
    _liveCard(
      'missingIfNull',
      'null + missingIfNull -> warning',
      'level=${pMissing.level.name}, ifNull=${pMissing.ifNull}',
      Colors.red,
      Icons.warning_amber,
    ),
    _liveCard(
      'level: hidden',
      'level forced to hidden',
      'level=${pHidden.level.name}',
      Colors.blueGrey,
      Icons.visibility_off_outlined,
    ),
    _liveCard(
      'DiagnosticsProperty.lazy',
      'value computed only on access',
      'value=${pLazy.value}',
      Colors.purple,
      Icons.bolt,
    ),
    _liveCard(
      'lazy: thrown exception',
      'caught, value -> null, exception captured',
      'level=${pLazyThrows.level.name}',
      Colors.pink,
      Icons.error_outline,
    ),
  ];

  // ============================================================
  // SECTION 4: T-type recipe gallery
  // ============================================================
  print('=== Section 4: T-type recipes ===');

  final pStr = DiagnosticsProperty<String>('title', 'My App');
  final pInt = DiagnosticsProperty<int>('lines', 42);
  final pDouble = DiagnosticsProperty<double>('opacity', 0.85);
  final pBool = DiagnosticsProperty<bool>('enabled', true);
  final pColor = DiagnosticsProperty<Color>('seedColor', Colors.indigo);
  final pDuration =
      DiagnosticsProperty<Duration>('timeout', Duration(seconds: 30));
  final pList =
      DiagnosticsProperty<List<int>>('ids', <int>[1, 2, 3, 4, 5]);
  final pMap = DiagnosticsProperty<Map<String, int>>(
    'counts',
    <String, int>{'a': 1, 'b': 2},
  );
  final pNullableNull = DiagnosticsProperty<String>('subtitle', null);
  final pEdge = DiagnosticsProperty<EdgeInsets>(
    'padding',
    EdgeInsets.all(8.0),
  );
  final pAlignment = DiagnosticsProperty<Alignment>(
    'alignment',
    Alignment.centerLeft,
  );

  print('pStr.propertyType=${pStr.propertyType}');
  print('pInt.propertyType=${pInt.propertyType}');
  print('pDouble.propertyType=${pDouble.propertyType}');
  print('pBool.propertyType=${pBool.propertyType}');
  print('pColor.propertyType=${pColor.propertyType}');
  print('pDuration.propertyType=${pDuration.propertyType}');
  print('pList.propertyType=${pList.propertyType}');
  print('pMap.propertyType=${pMap.propertyType}');
  print('pNullableNull.propertyType=${pNullableNull.propertyType}');
  print('pEdge.propertyType=${pEdge.propertyType}');
  print('pAlignment.propertyType=${pAlignment.propertyType}');

  final recipeRows = <Widget>[
    _recipeRow('String', pStr, Colors.blue, Icons.text_fields),
    _recipeRow('int', pInt, Colors.indigo, Icons.tag),
    _recipeRow('double', pDouble, Colors.deepPurple, Icons.linear_scale),
    _recipeRow('bool', pBool, Colors.green, Icons.toggle_on),
    _recipeRow('Color', pColor, Colors.pink, Icons.palette),
    _recipeRow('Duration', pDuration, Colors.orange, Icons.timer),
    _recipeRow('List<int>', pList, Colors.teal, Icons.list),
    _recipeRow(
      'Map<String,int>',
      pMap,
      Colors.cyan,
      Icons.account_tree,
    ),
    _recipeRow(
      'String? (null)',
      pNullableNull,
      Colors.grey,
      Icons.block,
    ),
    _recipeRow('EdgeInsets', pEdge, Colors.brown, Icons.crop_square),
    _recipeRow('Alignment', pAlignment, Colors.amber, Icons.align_horizontal_left),
  ];

  final recipeSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade100, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.category, color: Colors.teal.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Type Parameter Recipes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'DiagnosticsProperty<T> preserves T at runtime via propertyType,\n'
          'even when value is null.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.teal.shade900,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        ...recipeRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Level transition matrix
  // ============================================================
  print('=== Section 5: Level transition matrix ===');

  final levelRows = <Map<String, Object?>>[
    {
      'scenario': 'Default (T value, level: info)',
      'effective': DiagnosticLevel.info,
      'note': 'No demotion, no promotion.',
    },
    {
      'scenario': 'Set level: hidden (sticky)',
      'effective': DiagnosticLevel.hidden,
      'note': 'Hidden short-circuits everything else.',
    },
    {
      'scenario': 'value == defaultValue',
      'effective': DiagnosticLevel.fine,
      'note': 'isInteresting=false demotes to fine.',
    },
    {
      'scenario': 'value == null && missingIfNull',
      'effective': DiagnosticLevel.warning,
      'note': 'Promoted to warning.',
    },
    {
      'scenario': 'lazy compute throws',
      'effective': DiagnosticLevel.error,
      'note': 'Captured exception promotes to error.',
    },
    {
      'scenario': 'level: debug, value differs from default',
      'effective': DiagnosticLevel.debug,
      'note': 'Suggested level passes through.',
    },
  ];

  final levelTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.linear_scale,
              color: Colors.orange.shade700,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Level Promotion / Demotion Matrix',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _levelHeaderCell('Scenario', 260.0),
              _levelHeaderCell('Effective level', 130.0),
              _levelHeaderCell('Note', 220.0),
            ],
          ),
        ),
        for (final row in levelRows)
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.orange.shade100,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _levelDataCell(row['scenario'] as String, 260.0),
                SizedBox(
                  width: 130.0,
                  child: _levelBadge(row['effective'] as DiagnosticLevel),
                ),
                _levelDataCell(row['note'] as String, 220.0),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison vs typed sub-properties
  // ============================================================
  print('=== Section 6: Sub-property comparison ===');

  final pBase = DiagnosticsProperty<String>('mode', 'tight');
  final pStrSub = StringProperty('mode', 'tight');
  final pIntSub = IntProperty('count', 12);
  final pDoubleSub = DoubleProperty('opacity', 0.75);
  final pFlagSub = FlagProperty(
    'visible',
    value: true,
    ifTrue: 'visible',
    ifFalse: 'hidden',
  );
  final pIterableSub = IterableProperty<int>('ids', <int>[1, 2, 3]);
  final pEnumSub = EnumProperty<TextDirection>(
    'direction',
    TextDirection.ltr,
  );

  print('pBase=${pBase.toString()}');
  print('pStrSub=${pStrSub.toString()}');
  print('pIntSub=${pIntSub.toString()}');
  print('pDoubleSub=${pDoubleSub.toString()}');
  print('pFlagSub=${pFlagSub.toString()}');
  print('pIterableSub=${pIterableSub.toString()}');
  print('pEnumSub=${pEnumSub.toString()}');

  final comparisonRows = <Widget>[
    _compareRow(
      'DiagnosticsProperty<String>',
      pBase.toString(),
      'Generic; uses .toString() for value.',
      Colors.indigo,
    ),
    _compareRow(
      'StringProperty',
      pStrSub.toString(),
      'Wraps strings in quotes; supports quoted=false.',
      Colors.blue,
    ),
    _compareRow(
      'IntProperty',
      pIntSub.toString(),
      'Specialised for integers; supports unit.',
      Colors.deepPurple,
    ),
    _compareRow(
      'DoubleProperty',
      pDoubleSub.toString(),
      'Specialised for doubles; nice decimal output.',
      Colors.purple,
    ),
    _compareRow(
      'FlagProperty',
      pFlagSub.toString(),
      'Renders ifTrue / ifFalse instead of value.',
      Colors.green,
    ),
    _compareRow(
      'IterableProperty<T>',
      pIterableSub.toString(),
      'Joins elements; expandable.',
      Colors.teal,
    ),
    _compareRow(
      'EnumProperty<T>',
      pEnumSub.toString(),
      'Renders enum.name; respects defaultValue.',
      Colors.orange,
    ),
  ];

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade100, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.compare_arrows,
              color: Colors.deepPurple.shade700,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'DiagnosticsProperty vs Typed Sub-classes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...comparisonRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Pitfalls and best practices
  // ============================================================
  print('=== Section 7: Pitfalls ===');

  final pitfalls = <Map<String, Object>>[
    {
      'icon': Icons.error_outline,
      'title': 'Forgetting <T>',
      'detail':
          'DiagnosticsProperty(\'x\', value) infers Object?, so propertyType\n'
          'becomes Object — you lose typed inspector hints. Always supply <T>.',
      'color': Colors.red,
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Setting defaultValue with the wrong type',
      'detail':
          'For .lazy, defaultValue must be assignable to T?. Otherwise the\n'
          'assert in the constructor fails in debug mode.',
      'color': Colors.orange,
    },
    {
      'icon': Icons.report_gmailerrorred,
      'title': 'Heavy work in computeValue',
      'detail':
          'value getter only invokes computeValue once but the first read may\n'
          'still be expensive — keep it cheap or guard with kReleaseMode.',
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.visibility_off_outlined,
      'title': 'Using level: hidden as a TODO',
      'detail':
          'Hidden suppresses the property entirely. If you only want it dim,\n'
          'use level: fine instead so it still appears in verbose dumps.',
      'color': Colors.indigo,
    },
    {
      'icon': Icons.swap_calls,
      'title': 'missingIfNull + ifNull together',
      'detail':
          'When missingIfNull is true and ifNull is null, ifNull is auto-set\n'
          'to "MISSING". Do not rely on ifNull staying null in that case.',
      'color': Colors.teal,
    },
    {
      'icon': Icons.bug_report_outlined,
      'title': 'Overriding toString() instead of valueToString()',
      'detail':
          'Subclasses should override valueToString() so tooltip / ifEmpty /\n'
          'ifNull decoration in toDescription() still applies.',
      'color': Colors.purple,
    },
  ];

  final pitfallCards = <Widget>[];
  for (final p in pitfalls) {
    final color = p['color'] as Color;
    pitfallCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border(
            left: BorderSide(color: color, width: 4.0),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(p['icon'] as IconData, color: color, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    p['detail'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade800,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final pitfallsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning, color: Colors.red.shade600, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & Best Practices',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        ...pitfallCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 8: debugFillProperties recipe
  // ============================================================
  print('=== Section 8: debugFillProperties recipe ===');

  final recipeCode = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0D1117),
          Color(0xFF161B22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Idiomatic debugFillProperties',
              style: TextStyle(
                color: Colors.cyan.shade200,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '@override\n'
          'void debugFillProperties(DiagnosticPropertiesBuilder properties) {\n'
          '  super.debugFillProperties(properties);\n'
          '  properties.add(StringProperty(\'title\', title));\n'
          '  properties.add(IntProperty(\'count\', count, defaultValue: 0));\n'
          '  properties.add(DoubleProperty(\'opacity\', opacity,\n'
          '      defaultValue: 1.0));\n'
          '  properties.add(FlagProperty(\'enabled\',\n'
          '      value: enabled, ifFalse: \'disabled\'));\n'
          '  properties.add(EnumProperty<TextDirection>(\n'
          '      \'direction\', direction,\n'
          '      defaultValue: TextDirection.ltr));\n'
          '  properties.add(DiagnosticsProperty<EdgeInsets>(\n'
          '      \'padding\', padding, defaultValue: EdgeInsets.zero));\n'
          '  properties.add(DiagnosticsProperty<Object>(\n'
          '      \'tag\', tag, defaultValue: null));\n'
          '}',
          Colors.greenAccent.shade100,
        ),
        SizedBox(height: 12.0),
        Text(
          'Notes:',
          style: TextStyle(
            color: Colors.amber.shade300,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          '- Always call super first; this lets parent classes contribute their\n'
          '  own properties.\n'
          '- Use the typed subclasses where possible. Fall back to\n'
          '  DiagnosticsProperty<T> for arbitrary types.\n'
          '- Provide defaultValue so uninteresting values get demoted in DevTools.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.0,
            height: 1.45,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Quick reference table
  // ============================================================
  print('=== Section 9: Quick reference ===');

  final quickRows = <Map<String, String>>[
    {
      'q': 'How do I expose a property?',
      'a': 'properties.add(DiagnosticsProperty<T>(name, value));',
    },
    {
      'q': 'Hide an uninteresting default?',
      'a': 'Pass defaultValue: thatDefault.',
    },
    {
      'q': 'Mark a required null as warning?',
      'a': 'Set missingIfNull: true.',
    },
    {
      'q': 'Show a custom string for null?',
      'a': 'Set ifNull: "<unset>".',
    },
    {
      'q': 'Show a custom string for empty?',
      'a': 'Set ifEmpty: "<empty>".',
    },
    {
      'q': 'Defer expensive value lookup?',
      'a': 'Use DiagnosticsProperty<T>.lazy(name, () => compute()).',
    },
    {
      'q': 'Append units to the value?',
      'a': 'Set tooltip: "px" or use IntProperty(unit: "px").',
    },
    {
      'q': 'Suppress entirely from output?',
      'a': 'Set level: DiagnosticLevel.hidden.',
    },
    {
      'q': 'Capture nested Diagnosticable state?',
      'a': 'Set expandableValue: true.',
    },
    {
      'q': 'Detect propertyType at runtime?',
      'a': 'Read propertyType — it returns the T type literal.',
    },
  ];

  final quickRefSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.help_outline, color: Colors.green.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final r in quickRows)
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8.0),
              border: Border(
                left: BorderSide(color: Colors.green.shade400, width: 3.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r['q']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    color: Colors.green.shade900,
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  r['a']!,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: JSON-like serialisation preview
  // ============================================================
  print('=== Section 10: JSON-like serialisation ===');

  final jsonProp = DiagnosticsProperty<String>(
    'title',
    'Hello',
    description: 'Window title',
    tooltip: 'human-readable',
    defaultValue: 'Untitled',
    level: DiagnosticLevel.info,
  );
  final jsonText = '{\n'
      '  "name": "${jsonProp.name}",\n'
      '  "value": "${jsonProp.value}",\n'
      '  "description": "${jsonProp.toDescription()}",\n'
      '  "tooltip": "${jsonProp.tooltip}",\n'
      '  "defaultValue": "${jsonProp.defaultValue}",\n'
      '  "level": "${jsonProp.level.name}",\n'
      '  "propertyType": "${jsonProp.propertyType}",\n'
      '  "missingIfNull": ${jsonProp.missingIfNull},\n'
      '  "isInteresting": ${jsonProp.isInteresting}\n'
      '}';

  final jsonSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1B1F3A),
          Color(0xFF2C2F5A),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.data_object, color: Colors.amber.shade300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'toJsonMap-like Snapshot',
              style: TextStyle(
                color: Colors.amber.shade200,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _codeBlock(jsonText, Colors.cyanAccent.shade100),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: ASCII footer
  // ============================================================
  print('=== Section 11: ASCII footer ===');

  final ascii = '''
+--------------------------------------------------+
|              DiagnosticsProperty<T>              |
|                                                  |
|   name:T   ifNull/ifEmpty   tooltip   level      |
|     |             |           |        |         |
|     v             v           v        v         |
|   "label: value (tooltip)"  -> Inspector tree    |
|                                                  |
|   defaultValue == value -> isInteresting=false   |
|   missingIfNull && null  -> level=warning        |
|   exception (lazy)       -> level=error          |
+--------------------------------------------------+
''';

  final asciiSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF101418),
          Color(0xFF1B2026),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.greenAccent.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.greenAccent.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Text(
      ascii,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Colors.greenAccent.shade100,
        height: 1.3,
      ),
    ),
  );

  // ============================================================
  // SECTION 12: Closing footer with credits
  // ============================================================
  print('=== Section 12: Closing footer ===');

  final closingFooter = Container(
    margin: EdgeInsets.only(top: 16.0, bottom: 24.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF263238),
          Color(0xFF37474F),
          Color(0xFF455A64),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flutter_dash, color: Colors.cyan.shade200, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Diagnostics is documentation.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Every DiagnosticsProperty you add becomes part of the inspector,\n'
          'toStringDeep dumps, and DevTools — invest in good labels.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _footerBadge('lib/foundation', Colors.indigo),
            SizedBox(width: 8.0),
            _footerBadge('Diagnosticable', Colors.purple),
            SizedBox(width: 8.0),
            _footerBadge('Inspector', Colors.teal),
          ],
        ),
      ],
    ),
  );

  // Drive a couple more API calls so the test exercises behavioural aspects.
  print('--- behaviour walkthrough ---');
  print('pNameValue.isFiltered(info)=${pNameValue.isFiltered(DiagnosticLevel.info)}');
  print(
    'pHidden.isFiltered(info)=${pHidden.isFiltered(DiagnosticLevel.info)}',
  );
  print(
    'pDefaultEqual.isFiltered(info)=${pDefaultEqual.isFiltered(DiagnosticLevel.info)}',
  );
  print(
    'pMissing.toDescription()=${pMissing.toDescription()}',
  );
  print(
    'pTooltip.toDescription()=${pTooltip.toDescription()}',
  );
  print('DiagnosticsProperty<T> Deep Demo completed successfully');

  // ============================================================
  // Compose the final layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        SizedBox(height: 20.0),
        _sectionTitle('1. Anatomy', Icons.api, Colors.indigo),
        anatomySection,
        SizedBox(height: 8.0),
        _sectionTitle('2. Per-parameter live cards', Icons.science, Colors.deepPurple),
        Wrap(
          alignment: WrapAlignment.start,
          children: liveCards,
        ),
        SizedBox(height: 8.0),
        _sectionTitle('3. Type recipes', Icons.category, Colors.teal),
        recipeSection,
        SizedBox(height: 8.0),
        _sectionTitle('4. Levels', Icons.linear_scale, Colors.orange),
        levelTable,
        SizedBox(height: 8.0),
        _sectionTitle('5. Sub-property comparison', Icons.compare_arrows, Colors.deepPurple),
        comparisonSection,
        SizedBox(height: 8.0),
        _sectionTitle('6. Pitfalls', Icons.warning, Colors.red),
        pitfallsSection,
        SizedBox(height: 8.0),
        _sectionTitle(
          '7. debugFillProperties recipe',
          Icons.code,
          Colors.indigo,
        ),
        recipeCode,
        SizedBox(height: 8.0),
        _sectionTitle('8. Quick reference', Icons.help_outline, Colors.green),
        quickRefSection,
        SizedBox(height: 8.0),
        _sectionTitle('9. JSON-like snapshot', Icons.data_object, Colors.amber),
        jsonSection,
        SizedBox(height: 8.0),
        _sectionTitle('10. ASCII footer', Icons.terminal, Colors.greenAccent),
        asciiSection,
        SizedBox(height: 8.0),
        closingFooter,
      ],
    ),
  );
}

// ============================================================================
// Helper widgets
// ============================================================================

Widget _sectionTitle(String text, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.05),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 5.0),
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _heroChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.5,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _signatureBlock(String text) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: Colors.cyanAccent.shade100,
        height: 1.45,
      ),
    ),
  );
}

Widget _liveCard(
  String title,
  String invocation,
  String result,
  Color color,
  IconData icon,
) {
  return Container(
    width: 320.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.06),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(icon, color: color, size: 18.0),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            invocation,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.greenAccent.shade100,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(
            result,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.grey.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recipeRow(
  String label,
  DiagnosticsProperty<Object?> prop,
  Color color,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 130.0,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            prop.toString(),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.grey.shade900,
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            prop.level.name,
            style: TextStyle(
              fontSize: 10.0,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _levelHeaderCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.orange.shade900,
      ),
    ),
  );
}

Widget _levelDataCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        color: Colors.grey.shade800,
        height: 1.4,
      ),
    ),
  );
}

Widget _levelBadge(DiagnosticLevel level) {
  final color = _levelColor(level);
  return Container(
    margin: EdgeInsets.only(right: 8.0),
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      level.name,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

Color _levelColor(DiagnosticLevel level) {
  switch (level) {
    case DiagnosticLevel.hidden:
      return Colors.grey;
    case DiagnosticLevel.fine:
      return Colors.blueGrey;
    case DiagnosticLevel.debug:
      return Colors.blue;
    case DiagnosticLevel.info:
      return Colors.green;
    case DiagnosticLevel.warning:
      return Colors.orange;
    case DiagnosticLevel.hint:
      return Colors.teal;
    case DiagnosticLevel.summary:
      return Colors.indigo;
    case DiagnosticLevel.error:
      return Colors.red;
    case DiagnosticLevel.off:
      return Colors.black;
  }
}

Widget _compareRow(
  String label,
  String rendered,
  String note,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.label, color: color, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            rendered,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade100,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          note,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.grey.shade700,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.45,
      ),
    ),
  );
}

Widget _footerBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.6),
          color.withValues(alpha: 0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
      ),
    ),
  );
}
