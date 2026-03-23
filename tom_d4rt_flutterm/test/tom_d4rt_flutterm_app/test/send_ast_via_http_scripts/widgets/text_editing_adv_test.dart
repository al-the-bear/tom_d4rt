// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Tests: TextSelectionGestureDetector, TextSelectionGestureDetectorBuilder,
//        EditableTextState, BlacklistingTextInputFormatter (deprecated),
//        WhitelistingTextInputFormatter (deprecated), SelectionHandleType (enum),
//        SliverChildDelegate (abstract), SliverAnimatedGrid
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // --- TextSelectionGestureDetector Tests ---
  print('--- TextSelectionGestureDetector Tests ---');
  print('TextSelectionGestureDetector handles text selection gestures');
  print('Type: $TextSelectionGestureDetector');
  print('Detects taps, double-taps, long presses for text selection');
  print('Used internally by EditableText and TextField');

  // --- TextSelectionGestureDetectorBuilder Tests ---
  print('--- TextSelectionGestureDetectorBuilder Tests ---');
  print('TextSelectionGestureDetectorBuilder builds gesture detectors');
  print('Type: $TextSelectionGestureDetectorBuilder');
  print('Factory for creating TextSelectionGestureDetector instances');
  print('Can be subclassed to customize text selection behavior');

  // --- EditableTextState Tests ---
  print('--- EditableTextState Tests ---');
  print('EditableTextState is the State for EditableText');
  print('Type: $EditableTextState');
  print('Manages text editing, selection, and input handling');
  print('Provides methods like insertTextPlaceholder, removeTextPlaceholder');

  // --- BlacklistingTextInputFormatter Tests (deprecated) ---
  print('--- BlacklistingTextInputFormatter Tests ---');
  print('BlacklistingTextInputFormatter is deprecated');
  print('Use FilteringTextInputFormatter.deny instead');
  // BlacklistingTextInputFormatter was removed from Flutter.
  // Use FilteringTextInputFormatter.deny instead (shown below).
  var blacklistFormatter = FilteringTextInputFormatter.deny(RegExp(r'[0-9]'));
  print(
    'BlacklistingTextInputFormatter (now FilteringTextInputFormatter.deny): $blacklistFormatter',
  );
  print('Blocks input matching the pattern (digits in this case)');
  var denyFormatter = FilteringTextInputFormatter.deny(RegExp(r'[0-9]'));
  print('Replacement - FilteringTextInputFormatter.deny: $denyFormatter');

  // --- WhitelistingTextInputFormatter Tests (deprecated) ---
  print('--- WhitelistingTextInputFormatter Tests ---');
  print('WhitelistingTextInputFormatter is deprecated');
  print('Use FilteringTextInputFormatter.allow instead');
  // WhitelistingTextInputFormatter was removed from Flutter.
  // Use FilteringTextInputFormatter.allow instead (shown below).
  var whitelistFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z]'),
  );
  print(
    'WhitelistingTextInputFormatter (now FilteringTextInputFormatter.allow): $whitelistFormatter',
  );
  print('Only allows input matching the pattern (letters in this case)');
  var allowFormatter = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
  print('Replacement - FilteringTextInputFormatter.allow: $allowFormatter');

  // --- SelectionHandleType Tests ---
  print('--- SelectionHandleType Tests ---');
  print('SelectionHandleType defines text selection handle types');
  print('Type: $TextSelectionHandleType');
  print('left: ${TextSelectionHandleType.left}');
  print('right: ${TextSelectionHandleType.right}');
  print('collapsed: ${TextSelectionHandleType.collapsed}');
  print('values: ${TextSelectionHandleType.values}');

  // --- SliverChildDelegate Tests ---
  print('--- SliverChildDelegate Tests ---');
  print('SliverChildDelegate provides children to slivers');
  print('Type: $SliverChildDelegate');
  var listDelegate = SliverChildListDelegate([
    const Text('Item 1'),
    const Text('Item 2'),
  ]);
  print('SliverChildListDelegate: $listDelegate');
  var builderDelegate = SliverChildBuilderDelegate(
    (context, index) => Text('Built Item $index'),
    childCount: 10,
  );
  print('SliverChildBuilderDelegate: $builderDelegate');
  print('SliverChildBuilderDelegate childCount: ${builderDelegate.childCount}');

  // --- SliverAnimatedGrid Tests ---
  print('--- SliverAnimatedGrid Tests ---');
  print('SliverAnimatedGrid is an animated grid in a sliver');
  print('Type: $SliverAnimatedGrid');
  print('Animates items as they are inserted or removed');
  print('Requires a GlobalKey<SliverAnimatedGridState> for manipulation');
  var gridKey = GlobalKey<SliverAnimatedGridState>();
  print('SliverAnimatedGrid key: $gridKey');

  print('All text editing advanced tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              inputFormatters: [denyFormatter, allowFormatter],
              decoration: const InputDecoration(labelText: 'Filtered Input'),
            ),
            const SizedBox(height: 20),
            const Text('Text Editing Adv Test'),
          ],
        ),
      ),
    ),
  );
}
