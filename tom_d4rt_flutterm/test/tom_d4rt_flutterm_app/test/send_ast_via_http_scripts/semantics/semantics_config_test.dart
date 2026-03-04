// D4rt test script: Tests Semantics widget advanced, SemanticsNode concepts,
// SemanticsOwner concepts, SemanticsConfiguration, SemanticsSortKey
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('Semantics configuration test executing');

  // ========== SemanticsConfiguration ==========
  print('--- SemanticsConfiguration Tests ---');
  final config = SemanticsConfiguration()
    ..isSemanticBoundary = true
    ..label = 'Test Label'
    ..value = 'Test Value'
    ..hint = 'Test Hint'
    ..textDirection = TextDirection.ltr
    ..isButton = true
    ..isEnabled = true
    ..isFocused = false
    ..isSelected = false
    ..isChecked = false
    ..isToggled = false
    ..isReadOnly = false
    ..isObscured = false
    ..isMultiline = false
    ..isSlider = false
    ..isLink = false
    ..isHeader = false
    ..isImage = false
    ..hasImplicitScrolling = false;
  print('SemanticsConfiguration created');
  print('  isSemanticBoundary: ${config.isSemanticBoundary}');
  print('  label: ${config.label}');
  print('  isButton: ${config.isButton}');

  // ========== Semantics widget ==========
  print('--- Semantics widget Tests ---');
  final semanticsWidget = Semantics(
    label: 'Interactive button',
    hint: 'Double tap to activate',
    value: 'Current state',
    button: true,
    enabled: true,
    focused: false,
    selected: false,
    checked: false,
    toggled: false,
    readOnly: false,
    obscured: false,
    multiline: false,
    slider: false,
    link: false,
    header: false,
    image: false,
    liveRegion: false,
    sortKey: OrdinalSortKey(1.0),
    onTap: () => print('Semantics tap'),
    onLongPress: () => print('Semantics long press'),
    onDismiss: () => print('Semantics dismiss'),
    onIncrease: () => print('Semantics increase'),
    onDecrease: () => print('Semantics decrease'),
    child: Container(
      width: 100,
      height: 40,
      color: Colors.blue.shade100,
      child: Center(child: Text('Button')),
    ),
  );
  print('Semantics widget created with callbacks');

  // ========== MergeSemantics ==========
  print('--- MergeSemantics Tests ---');
  final mergeSemantics = MergeSemantics(
    child: Row(children: [Icon(Icons.star), Text('Favorite')]),
  );
  print('MergeSemantics created');

  // ========== ExcludeSemantics ==========
  print('--- ExcludeSemantics Tests ---');
  final excludeSemantics = ExcludeSemantics(
    excluding: true,
    child: Text('Excluded'),
  );
  print('ExcludeSemantics created: excluding=true');

  // ========== BlockSemantics ==========
  print('--- BlockSemantics Tests ---');
  final blockSemantics = BlockSemantics(
    blocking: true,
    child: Text('Blocking'),
  );
  print('BlockSemantics created: blocking=true');

  // ========== SemanticsDebugger ==========
  print('--- SemanticsDebugger Tests ---');
  print('SemanticsDebugger visualizes the semantics tree');

  print('All semantics configuration tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Semantics Configuration Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            semanticsWidget,
            SizedBox(height: 8.0),
            mergeSemantics,
            SizedBox(height: 8.0),
            excludeSemantics,
            SizedBox(height: 8.0),
            blockSemantics,
          ],
        ),
      ),
    ),
  );
}
