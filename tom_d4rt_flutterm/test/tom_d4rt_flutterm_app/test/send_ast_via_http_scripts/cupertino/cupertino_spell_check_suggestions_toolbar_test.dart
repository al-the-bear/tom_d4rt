// D4rt test script: Tests CupertinoSpellCheckSuggestionsToolbar from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoSpellCheckSuggestionsToolbar test executing');

  // ===== 1. Basic toolbar with anchors and buttonItems =====
  print('--- Basic CupertinoSpellCheckSuggestionsToolbar ---');
  final anchors = TextSelectionToolbarAnchors(
    primaryAnchor: Offset(100.0, 200.0),
  );
  final buttonItems = <ContextMenuButtonItem>[
    ContextMenuButtonItem(
      label: 'Replace with "hello"',
      onPressed: () {
        print('  Replace tapped');
      },
    ),
    ContextMenuButtonItem(
      label: 'Replace with "world"',
      onPressed: () {
        print('  Replace tapped');
      },
    ),
  ];
  final toolbar = CupertinoSpellCheckSuggestionsToolbar(
    anchors: anchors,
    buttonItems: buttonItems,
  );
  print('  toolbar created');
  print('  anchors primary: ${anchors.primaryAnchor}');
  print('  buttonItems count: ${buttonItems.length}');

  // ===== 2. With single suggestion =====
  print('--- Single suggestion ---');
  final singleToolbar = CupertinoSpellCheckSuggestionsToolbar(
    anchors: TextSelectionToolbarAnchors(
      primaryAnchor: Offset(50.0, 100.0),
    ),
    buttonItems: [
      ContextMenuButtonItem(
        label: 'Suggestion',
        onPressed: () {},
      ),
    ],
  );
  print('  single-suggestion toolbar created');

  // ===== 3. With many suggestions =====
  print('--- Many suggestions ---');
  final manyItems = <ContextMenuButtonItem>[];
  for (var i = 0; i < 5; i++) {
    manyItems.add(ContextMenuButtonItem(
      label: 'Suggestion $i',
      onPressed: () {},
    ));
  }
  final manyToolbar = CupertinoSpellCheckSuggestionsToolbar(
    anchors: TextSelectionToolbarAnchors(
      primaryAnchor: Offset(150.0, 300.0),
    ),
    buttonItems: manyItems,
  );
  print('  ${manyItems.length}-suggestion toolbar created');

  // ===== 4. With secondary anchor =====
  print('--- With secondary anchor ---');
  final dualAnchor = TextSelectionToolbarAnchors(
    primaryAnchor: Offset(100.0, 200.0),
    secondaryAnchor: Offset(100.0, 180.0),
  );
  final dualToolbar = CupertinoSpellCheckSuggestionsToolbar(
    anchors: dualAnchor,
    buttonItems: buttonItems,
  );
  print('  toolbar with secondary anchor: ${dualAnchor.secondaryAnchor}');

  // ===== 5. Usage in context with CupertinoTextField =====
  print('--- TextField context ---');
  final textField = CupertinoTextField(
    placeholder: 'Type here to see spell check',
    spellCheckConfiguration: SpellCheckConfiguration(),
  );
  print('  text field with spellcheck created');

  // ===== 6. ContextMenuButtonItem types =====
  print('--- ButtonItem types ---');
  final typedItems = <ContextMenuButtonItem>[
    ContextMenuButtonItem(
      label: 'Cut',
      type: ContextMenuButtonType.cut,
      onPressed: () {},
    ),
    ContextMenuButtonItem(
      label: 'Copy',
      type: ContextMenuButtonType.copy,
      onPressed: () {},
    ),
    ContextMenuButtonItem(
      label: 'Paste',
      type: ContextMenuButtonType.paste,
      onPressed: () {},
    ),
    ContextMenuButtonItem(
      label: 'Custom',
      type: ContextMenuButtonType.custom,
      onPressed: () {},
    ),
  ];
  for (final item in typedItems) {
    print('  button: ${item.label} type: ${item.type}');
  }

  print('CupertinoSpellCheckSuggestionsToolbar test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('SpellCheck Toolbar')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Spell Check Toolbar Tests', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              Text('TextField with spellcheck:'),
              textField,
              SizedBox(height: 16.0),
              Text('Toolbar types tested:'),
              Text('  - Basic (2 suggestions)'),
              Text('  - Single suggestion'),
              Text('  - Many suggestions (5)'),
              Text('  - Dual anchor'),
              Text('  - Typed button items'),
              SizedBox(height: 16.0),
              Text('Button types: ${typedItems.map((i) => i.type).join(", ")}'),
            ],
          ),
        ),
      ),
    ),
  );
}
