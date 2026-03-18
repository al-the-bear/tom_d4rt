// D4rt test script: Tests CupertinoSpellCheckSuggestionsToolbar from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoSpellCheckSuggestionsToolbar test executing');

  // Basic toolbar with anchors and buttonItems (max 3 suggestions allowed)
  final anchors = TextSelectionToolbarAnchors(
    primaryAnchor: Offset(100.0, 200.0),
  );
  final buttonItems = <ContextMenuButtonItem>[
    ContextMenuButtonItem(
      label: 'Replace with "hello"',
      onPressed: () {
        print('Replace tapped');
      },
    ),
    ContextMenuButtonItem(
      label: 'Replace with "world"',
      onPressed: () {
        print('Replace tapped');
      },
    ),
  ];
  final toolbar = CupertinoSpellCheckSuggestionsToolbar(
    anchors: anchors,
    buttonItems: buttonItems,
  );
  print('toolbar created: ${toolbar.runtimeType}');
  print('anchors primary: ${anchors.primaryAnchor}');
  print('buttonItems count: ${buttonItems.length}');

  // Single suggestion
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
  print('single-suggestion toolbar created [${singleToolbar.hashCode }]');

  // Max 3 suggestions (the internal limit is _kMaxSuggestions = 3)
  final threeItems = <ContextMenuButtonItem>[
    ContextMenuButtonItem(label: 'Sug 1', onPressed: () {}),
    ContextMenuButtonItem(label: 'Sug 2', onPressed: () {}),
    ContextMenuButtonItem(label: 'Sug 3', onPressed: () {}),
  ];
  final maxToolbar = CupertinoSpellCheckSuggestionsToolbar(
    anchors: TextSelectionToolbarAnchors(
      primaryAnchor: Offset(150.0, 300.0),
    ),
    buttonItems: threeItems,
  );
  print('3-suggestion toolbar created (max allowed) [${maxToolbar.hashCode }]');

  // With secondary anchor
  final dualAnchor = TextSelectionToolbarAnchors(
    primaryAnchor: Offset(100.0, 200.0),
    secondaryAnchor: Offset(100.0, 180.0),
  );
  final dualToolbar = CupertinoSpellCheckSuggestionsToolbar(
    anchors: dualAnchor,
    buttonItems: buttonItems,
  );
  print('toolbar with secondary anchor: ${dualAnchor.secondaryAnchor} [${dualToolbar.hashCode }]');

  // ContextMenuButtonItem types
  final typedItems = <ContextMenuButtonItem>[
    ContextMenuButtonItem(label: 'Cut', type: ContextMenuButtonType.cut, onPressed: () {}),
    ContextMenuButtonItem(label: 'Copy', type: ContextMenuButtonType.copy, onPressed: () {}),
    ContextMenuButtonItem(label: 'Paste', type: ContextMenuButtonType.paste, onPressed: () {}),
  ];
  for (final item in typedItems) {
    print('button: ${item.label} type: ${item.type}');
  }

  print('CupertinoSpellCheckSuggestionsToolbar test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('SpellCheck Toolbar')),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Spell Check Toolbar Tests', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            Text('2-suggestion toolbar OK'),
            Text('3-suggestion toolbar OK (max)'),
            Text('Dual anchor toolbar OK'),
          ],
        ),
      ),
    ),
  );
}
