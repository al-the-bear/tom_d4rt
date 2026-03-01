// D4rt test script: Tests Semantics classes from package:flutter/semantics.dart
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('Semantics test executing');

  // ========== SEMANTICSPROPERTIES ==========
  print('--- SemanticsProperties Tests ---');

  // Basic SemanticsProperties
  final basicProps = SemanticsProperties(
    label: 'Button',
    hint: 'Tap to activate',
  );
  print('Basic SemanticsProperties:');
  print('  label: ${basicProps.label}');
  print('  hint: ${basicProps.hint}');

  // Full SemanticsProperties
  final fullProps = SemanticsProperties(
    enabled: true,
    checked: false,
    selected: true,
    toggled: false,
    button: true,
    link: false,
    header: false,
    textField: false,
    slider: false,
    keyboardKey: false,
    readOnly: false,
    focusable: true,
    focused: false,
    inMutuallyExclusiveGroup: false,
    hidden: false,
    obscured: false,
    multiline: false,
    scopesRoute: false,
    namesRoute: false,
    image: false,
    liveRegion: false,
    maxValueLength: 100,
    currentValueLength: 50,
    label: 'Full properties',
    value: 'Current value',
    increasedValue: 'Increased',
    decreasedValue: 'Decreased',
    hint: 'Tap for action',
    hintOverrides: null,
    textDirection: TextDirection.ltr,
    sortKey: const OrdinalSortKey(1.0),
    tagForChildren: const SemanticsTag('test-tag'),
    onTap: () => print('Tapped'),
    onLongPress: () => print('Long pressed'),
    onScrollLeft: () => print('Scroll left'),
    onScrollRight: () => print('Scroll right'),
    onScrollUp: () => print('Scroll up'),
    onScrollDown: () => print('Scroll down'),
    onIncrease: () => print('Increase'),
    onDecrease: () => print('Decrease'),
    onCopy: () => print('Copy'),
    onCut: () => print('Cut'),
    onPaste: () => print('Paste'),
    onDismiss: () => print('Dismiss'),
    onSetSelection: (TextSelection selection) => print('Set selection'),
    onSetText: (String text) => print('Set text'),
    onDidGainAccessibilityFocus: () => print('Gained focus'),
    onDidLoseAccessibilityFocus: () => print('Lost focus'),
  );
  print('Full SemanticsProperties created');
  print('  enabled: ${fullProps.enabled}');
  print('  button: ${fullProps.button}');
  print('  selected: ${fullProps.selected}');
  print('  maxValueLength: ${fullProps.maxValueLength}');
  print('  currentValueLength: ${fullProps.currentValueLength}');

  // Test toStringShort
  print('toStringShort: ${fullProps.toStringShort()}');

  // ========== CUSTOMSEMANTICSACTION ==========
  print('--- CustomSemanticsAction Tests ---');

  // Standard semantic actions
  print('SemanticsAction.tap: ${SemanticsAction.tap}');
  print('SemanticsAction.longPress: ${SemanticsAction.longPress}');
  print('SemanticsAction.scrollLeft: ${SemanticsAction.scrollLeft}');
  print('SemanticsAction.scrollRight: ${SemanticsAction.scrollRight}');
  print('SemanticsAction.scrollUp: ${SemanticsAction.scrollUp}');
  print('SemanticsAction.scrollDown: ${SemanticsAction.scrollDown}');
  print('SemanticsAction.increase: ${SemanticsAction.increase}');
  print('SemanticsAction.decrease: ${SemanticsAction.decrease}');
  print('SemanticsAction.showOnScreen: ${SemanticsAction.showOnScreen}');
  print(
    'SemanticsAction.moveCursorForwardByCharacter: ${SemanticsAction.moveCursorForwardByCharacter}',
  );
  print(
    'SemanticsAction.moveCursorBackwardByCharacter: ${SemanticsAction.moveCursorBackwardByCharacter}',
  );
  print('SemanticsAction.setSelection: ${SemanticsAction.setSelection}');
  print('SemanticsAction.copy: ${SemanticsAction.copy}');
  print('SemanticsAction.cut: ${SemanticsAction.cut}');
  print('SemanticsAction.paste: ${SemanticsAction.paste}');
  print(
    'SemanticsAction.didGainAccessibilityFocus: ${SemanticsAction.didGainAccessibilityFocus}',
  );
  print(
    'SemanticsAction.didLoseAccessibilityFocus: ${SemanticsAction.didLoseAccessibilityFocus}',
  );
  print('SemanticsAction.customAction: ${SemanticsAction.customAction}');
  print('SemanticsAction.dismiss: ${SemanticsAction.dismiss}');
  print(
    'SemanticsAction.moveCursorForwardByWord: ${SemanticsAction.moveCursorForwardByWord}',
  );
  print(
    'SemanticsAction.moveCursorBackwardByWord: ${SemanticsAction.moveCursorBackwardByWord}',
  );
  print('SemanticsAction.setText: ${SemanticsAction.setText}');
  print('SemanticsAction.focus: ${SemanticsAction.focus}');

  // Custom semantic action
  final customAction = CustomSemanticsAction(label: 'Delete item');
  print('CustomSemanticsAction:');
  print('  label: ${customAction.label}');

  // CustomSemanticsAction with icon
  final customActionWithHint = CustomSemanticsAction.overridingAction(
    hint: 'Double-tap to delete',
    action: SemanticsAction.tap,
  );
  print('CustomSemanticsAction.overridingAction created');

  // ========== SEMANTICSFLAGS ==========
  print('--- SemanticsFlag Tests ---');

  print('SemanticsFlag.hasCheckedState: ${SemanticsFlag.hasCheckedState}');
  print('SemanticsFlag.isChecked: ${SemanticsFlag.isChecked}');
  print('SemanticsFlag.isSelected: ${SemanticsFlag.isSelected}');
  print('SemanticsFlag.isButton: ${SemanticsFlag.isButton}');
  print('SemanticsFlag.isLink: ${SemanticsFlag.isLink}');
  print('SemanticsFlag.isTextField: ${SemanticsFlag.isTextField}');
  print('SemanticsFlag.isSlider: ${SemanticsFlag.isSlider}');
  print('SemanticsFlag.isKeyboardKey: ${SemanticsFlag.isKeyboardKey}');
  print('SemanticsFlag.isReadOnly: ${SemanticsFlag.isReadOnly}');
  print('SemanticsFlag.isFocusable: ${SemanticsFlag.isFocusable}');
  print('SemanticsFlag.isFocused: ${SemanticsFlag.isFocused}');
  print('SemanticsFlag.hasEnabledState: ${SemanticsFlag.hasEnabledState}');
  print('SemanticsFlag.isEnabled: ${SemanticsFlag.isEnabled}');
  print(
    'SemanticsFlag.isInMutuallyExclusiveGroup: ${SemanticsFlag.isInMutuallyExclusiveGroup}',
  );
  print('SemanticsFlag.isHeader: ${SemanticsFlag.isHeader}');
  print('SemanticsFlag.isObscured: ${SemanticsFlag.isObscured}');
  print('SemanticsFlag.isMultiline: ${SemanticsFlag.isMultiline}');
  print('SemanticsFlag.scopesRoute: ${SemanticsFlag.scopesRoute}');
  print('SemanticsFlag.namesRoute: ${SemanticsFlag.namesRoute}');
  print('SemanticsFlag.isHidden: ${SemanticsFlag.isHidden}');
  print('SemanticsFlag.isImage: ${SemanticsFlag.isImage}');
  print('SemanticsFlag.isLiveRegion: ${SemanticsFlag.isLiveRegion}');
  print('SemanticsFlag.hasToggledState: ${SemanticsFlag.hasToggledState}');
  print('SemanticsFlag.isToggled: ${SemanticsFlag.isToggled}');

  // ========== SEMANTICSTAG ==========
  print('--- SemanticsTag Tests ---');

  const tag1 = SemanticsTag('navigation-button');
  const tag2 = SemanticsTag('form-field');
  print('SemanticsTag(navigation-button): ${tag1.name}');
  print('SemanticsTag(form-field): ${tag2.name}');
  print('Tags equal: ${tag1 == tag2}');
  print('Same tag equal: ${tag1 == const SemanticsTag("navigation-button")}');

  // ========== SEMANTICSSORTKEY ==========
  print('--- SemanticsSort Key Tests ---');

  // OrdinalSortKey
  const ordinal1 = OrdinalSortKey(1.0);
  const ordinal2 = OrdinalSortKey(2.0);
  const ordinal3 = OrdinalSortKey(1.0, name: 'header');
  print('OrdinalSortKey(1.0): order=${ordinal1.order}, name=${ordinal1.name}');
  print('OrdinalSortKey(2.0): order=${ordinal2.order}');
  print('OrdinalSortKey(1.0, header): name=${ordinal3.name}');

  // Compare
  print('Compare 1.0 to 2.0: ${ordinal1.compareTo(ordinal2)}');
  print('Compare 2.0 to 1.0: ${ordinal2.compareTo(ordinal1)}');

  // ========== SEMANTICS ANNOUNCEMENT ==========
  print('--- AttributedString Tests ---');

  final attrString = AttributedString(
    'Hello World',
    attributes: [
      SpellOutStringAttribute(range: const TextRange(start: 0, end: 5)),
    ],
  );
  print('AttributedString: ${attrString.string}');
  print('Attributes count: ${attrString.attributes.length}');

  // ========== SEMANTICS WITH WIDGETS ==========
  print('--- Semantics Widget Tests ---');

  // Semantics widget is tested visually below

  print('Semantics test completed');

  // Return visual demonstration
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Semantics Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Semantics Widget:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Semantics(
              label: 'Primary action button',
              hint: 'Double tap to perform action',
              button: true,
              enabled: true,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'Button with Semantics',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'MergeSemantics:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            MergeSemantics(
              child: Row(
                children: [
                  Icon(Icons.star, color: Color(0xFFFFD700)),
                  SizedBox(width: 8.0),
                  Text('Favorite'),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'ExcludeSemantics:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Visible: '),
                ExcludeSemantics(child: Text('(excluded from accessibility)')),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'BlockSemantics:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Stack(
              children: [
                Text('Background text'),
                Positioned(
                  top: 0,
                  left: 0,
                  child: BlockSemantics(
                    child: Container(
                      color: Color(0xFFFFFFFF).withOpacity(0.9),
                      padding: EdgeInsets.all(4.0),
                      child: Text('Blocking overlay'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'SemanticsProperties:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• label - accessibility label',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• hint - accessibility hint',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• value - current value',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• enabled/checked/selected - states',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• button/link/header - roles',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• onTap/onLongPress - actions',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'SemanticsAction (common):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: [
                for (final action in [
                  'tap',
                  'longPress',
                  'scrollUp',
                  'scrollDown',
                  'increase',
                  'decrease',
                  'copy',
                  'paste',
                ])
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    color: Color(0xFF4CAF50),
                    child: Text(
                      action,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'SemanticsFlag (common):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: [
                for (final flag in [
                  'isButton',
                  'isLink',
                  'isTextField',
                  'isChecked',
                  'isSelected',
                  'isEnabled',
                  'isFocused',
                ])
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    color: Color(0xFF9C27B0),
                    child: Text(
                      flag,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Sort Keys:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  sortKey: OrdinalSortKey(1.0),
                  child: Text('1. First in order'),
                ),
                Semantics(
                  sortKey: OrdinalSortKey(2.0),
                  child: Text('2. Second in order'),
                ),
                Semantics(
                  sortKey: OrdinalSortKey(3.0),
                  child: Text('3. Third in order'),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Custom Semantic Actions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Semantics(
              customSemanticsActions: {
                CustomSemanticsAction(label: 'Delete'): () {},
                CustomSemanticsAction(label: 'Archive'): () {},
                CustomSemanticsAction(label: 'Share'): () {},
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Color(0xFFE0E0E0),
                child: Text('Item with custom actions'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
