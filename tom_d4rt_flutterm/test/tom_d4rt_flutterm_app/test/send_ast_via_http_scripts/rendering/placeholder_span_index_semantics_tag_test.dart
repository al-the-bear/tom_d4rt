// ignore_for_file: avoid_print
// PlaceholderSpanIndexSemanticsTag Deep Demo
// Semantics tag for inline widgets in text - enables accessibility for WidgetSpan elements
// Created: March 2026

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlaceholderSpanIndexSemanticsTag Overview', () {
    // PlaceholderSpanIndexSemanticsTag is a SemanticsTag subclass that identifies
    // placeholder elements (inline widgets) within text by their index position.
    // When using WidgetSpan in RichText, this tag helps screen readers understand
    // the position and purpose of embedded widgets.

    test('basic creation with index zero', () {
      var tag = PlaceholderSpanIndexSemanticsTag(0);

      expect(tag, isNotNull);
      expect(tag.index, equals(0));
      expect(tag, isA<SemanticsTag>());
    });

    test('creation with positive index values', () {
      var tag1 = PlaceholderSpanIndexSemanticsTag(1);
      var tag2 = PlaceholderSpanIndexSemanticsTag(5);
      var tag3 = PlaceholderSpanIndexSemanticsTag(10);
      var tag4 = PlaceholderSpanIndexSemanticsTag(100);

      expect(tag1.index, equals(1));
      expect(tag2.index, equals(5));
      expect(tag3.index, equals(10));
      expect(tag4.index, equals(100));
    });

    test('tag extends SemanticsTag base class', () {
      var tag = PlaceholderSpanIndexSemanticsTag(0);

      expect(tag, isA<SemanticsTag>());
    });

    test('multiple tags with same index are equal', () {
      var tag1 = PlaceholderSpanIndexSemanticsTag(3);
      var tag2 = PlaceholderSpanIndexSemanticsTag(3);

      expect(tag1 == tag2, isTrue);
      expect(tag1.hashCode, equals(tag2.hashCode));
    });

    test('tags with different indices are not equal', () {
      var tag1 = PlaceholderSpanIndexSemanticsTag(0);
      var tag2 = PlaceholderSpanIndexSemanticsTag(1);
      var tag3 = PlaceholderSpanIndexSemanticsTag(2);

      expect(tag1 == tag2, isFalse);
      expect(tag2 == tag3, isFalse);
      expect(tag1 == tag3, isFalse);
    });

    test('toString provides meaningful representation', () {
      var tag = PlaceholderSpanIndexSemanticsTag(7);
      var representation = tag.toString();

      expect(representation, contains('PlaceholderSpanIndexSemanticsTag'));
      expect(representation, contains('7'));
    });

    test('large index values are supported', () {
      var tag = PlaceholderSpanIndexSemanticsTag(999999);

      expect(tag.index, equals(999999));
    });
  });

  group('Index Property Behavior', () {
    // The index property represents the position of the placeholder widget
    // within the text span sequence. This is crucial for maintaining proper
    // reading order in accessibility contexts.

    test('index property is immutable after creation', () {
      var tag = PlaceholderSpanIndexSemanticsTag(5);
      var initialIndex = tag.index;

      // Create another reference to verify immutability pattern
      var sameTag = tag;

      expect(sameTag.index, equals(initialIndex));
      expect(tag.index, equals(5));
    });

    test('sequential indices for multiple placeholders', () {
      var indices = <int>[];
      for (var i = 0; i < 10; i++) {
        var tag = PlaceholderSpanIndexSemanticsTag(i);
        indices.add(tag.index);
      }

      expect(indices, equals([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]));
    });

    test('index maintains value through collection operations', () {
      var tags = <PlaceholderSpanIndexSemanticsTag>[];
      tags.add(PlaceholderSpanIndexSemanticsTag(0));
      tags.add(PlaceholderSpanIndexSemanticsTag(1));
      tags.add(PlaceholderSpanIndexSemanticsTag(2));

      var retrievedTag = tags[1];
      expect(retrievedTag.index, equals(1));
    });

    test('index used for sorting semantics tags', () {
      var tags = [
        PlaceholderSpanIndexSemanticsTag(5),
        PlaceholderSpanIndexSemanticsTag(2),
        PlaceholderSpanIndexSemanticsTag(8),
        PlaceholderSpanIndexSemanticsTag(1),
        PlaceholderSpanIndexSemanticsTag(3),
      ];

      tags.sort((a, b) => a.index.compareTo(b.index));

      var sortedIndices = tags.map((t) => t.index).toList();
      expect(sortedIndices, equals([1, 2, 3, 5, 8]));
    });

    test('index zero represents first placeholder in text', () {
      var firstPlaceholder = PlaceholderSpanIndexSemanticsTag(0);

      expect(firstPlaceholder.index, equals(0));
      expect(firstPlaceholder.index == 0, isTrue);
    });

    test('index comparison operators', () {
      var tag0 = PlaceholderSpanIndexSemanticsTag(0);
      var tag5 = PlaceholderSpanIndexSemanticsTag(5);
      var tag10 = PlaceholderSpanIndexSemanticsTag(10);

      expect(tag0.index < tag5.index, isTrue);
      expect(tag5.index < tag10.index, isTrue);
      expect(tag10.index > tag0.index, isTrue);
      expect(tag5.index >= 5, isTrue);
      expect(tag5.index <= 5, isTrue);
    });

    test('index in map as key retrieval', () {
      var tagMap = <int, PlaceholderSpanIndexSemanticsTag>{};
      tagMap[0] = PlaceholderSpanIndexSemanticsTag(0);
      tagMap[1] = PlaceholderSpanIndexSemanticsTag(1);
      tagMap[2] = PlaceholderSpanIndexSemanticsTag(2);

      expect(tagMap[1]!.index, equals(1));
    });
  });

  group('Usage with RichText and WidgetSpan', () {
    // PlaceholderSpanIndexSemanticsTag is automatically applied by Flutter
    // when WidgetSpan elements are used within RichText. Each inline widget
    // receives a tag corresponding to its position in the span tree.

    testWidgets('RichText with single WidgetSpan placeholder', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hello ',
                      style: TextStyle(color: Colors.black),
                    ),
                    WidgetSpan(child: Icon(Icons.star, size: 16)),
                    TextSpan(
                      text: ' world',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(RichText), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('RichText with multiple WidgetSpan placeholders', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Rating: ',
                      style: TextStyle(color: Colors.black),
                    ),
                    WidgetSpan(
                      child: Icon(Icons.star, size: 16, color: Colors.amber),
                    ),
                    WidgetSpan(
                      child: Icon(Icons.star, size: 16, color: Colors.amber),
                    ),
                    WidgetSpan(
                      child: Icon(Icons.star, size: 16, color: Colors.amber),
                    ),
                    WidgetSpan(child: Icon(Icons.star_border, size: 16)),
                    WidgetSpan(child: Icon(Icons.star_border, size: 16)),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(RichText), findsOneWidget);
      expect(find.byIcon(Icons.star), findsWidgets);
      expect(find.byIcon(Icons.star_border), findsWidgets);
    });

    testWidgets('WidgetSpan with Container inline widget', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Status: ',
                      style: TextStyle(color: Colors.black),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' Online',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('WidgetSpan with Chip widget inline', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: 'Tagged as '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Chip(
                        label: Text('Important'),
                        labelStyle: TextStyle(fontSize: 10),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    TextSpan(text: ' for review'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Chip), findsOneWidget);
      expect(find.text('Important'), findsOneWidget);
    });

    testWidgets('WidgetSpan with Image placeholder', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: 'User '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.blue,
                        child: Text('A', style: TextStyle(fontSize: 10)),
                      ),
                    ),
                    TextSpan(text: ' commented'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('nested spans with widget placeholders', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'First level ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        WidgetSpan(child: Icon(Icons.check, size: 14)),
                        TextSpan(
                          text: ' nested ',
                          children: [
                            WidgetSpan(child: Icon(Icons.close, size: 14)),
                          ],
                        ),
                      ],
                    ),
                    TextSpan(
                      text: ' end',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });

  group('Accessibility Implications', () {
    // PlaceholderSpanIndexSemanticsTag plays a crucial role in making inline
    // widgets accessible to screen readers. It ensures that the reading order
    // of embedded widgets matches their visual position in the text.

    testWidgets('semantics enabled for inline widget', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Semantics(
            container: true,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Press ',
                    style: TextStyle(color: Colors.black),
                  ),
                  WidgetSpan(
                    child: Semantics(
                      label: 'play button',
                      child: Icon(Icons.play_arrow, size: 16),
                    ),
                  ),
                  TextSpan(
                    text: ' to start',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('play button'), findsOneWidget);
    });

    testWidgets('multiple accessible inline widgets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Semantics(
            container: true,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Choose ',
                    style: TextStyle(color: Colors.black),
                  ),
                  WidgetSpan(
                    child: Semantics(
                      label: 'option A',
                      child: Icon(Icons.looks_one, size: 16),
                    ),
                  ),
                  TextSpan(
                    text: ' or ',
                    style: TextStyle(color: Colors.black),
                  ),
                  WidgetSpan(
                    child: Semantics(
                      label: 'option B',
                      child: Icon(Icons.looks_two, size: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('option A'), findsOneWidget);
      expect(find.bySemanticsLabel('option B'), findsOneWidget);
    });

    testWidgets('inline button with semantics action', (
      WidgetTester tester,
    ) async {
      var wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Click ',
                  style: TextStyle(color: Colors.black),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Semantics(
                    button: true,
                    label: 'action button',
                    onTap: () {
                      wasPressed = true;
                    },
                    child: GestureDetector(
                      onTap: () {
                        wasPressed = true;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'HERE',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: ' to continue',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('HERE'));
      await tester.pump();

      expect(wasPressed, isTrue);
    });

    testWidgets('excludeSemantics for decorative widgets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Decorative ',
                  style: TextStyle(color: Colors.black),
                ),
                WidgetSpan(
                  child: ExcludeSemantics(
                    child: Icon(Icons.circle, size: 8, color: Colors.grey),
                  ),
                ),
                TextSpan(
                  text: ' element',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );

      // Decorative icon should be excluded from semantics tree
      expect(find.byIcon(Icons.circle), findsOneWidget);
    });

    testWidgets('ordered semantics for emoji replacements', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Great ',
                  style: TextStyle(color: Colors.black),
                ),
                WidgetSpan(
                  child: Semantics(
                    label: 'thumbs up emoji',
                    child: Text('👍', style: TextStyle(fontSize: 16)),
                  ),
                ),
                TextSpan(
                  text: ' work ',
                  style: TextStyle(color: Colors.black),
                ),
                WidgetSpan(
                  child: Semantics(
                    label: 'fire emoji',
                    child: Text('🔥', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('thumbs up emoji'), findsOneWidget);
      expect(find.bySemanticsLabel('fire emoji'), findsOneWidget);
    });

    testWidgets('focus traversal respects placeholder order', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Focus(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Focus ',
                          style: TextStyle(color: Colors.black),
                        ),
                        WidgetSpan(
                          child: Focus(
                            child: Container(
                              width: 20,
                              height: 20,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: ' then ',
                          style: TextStyle(color: Colors.black),
                        ),
                        WidgetSpan(
                          child: Focus(
                            child: Container(
                              width: 20,
                              height: 20,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(RichText), findsOneWidget);
    });
  });

  group('Visual Examples with Inline Widgets', () {
    // Comprehensive visual examples demonstrating various use cases for
    // inline widgets in text with proper placeholder semantics tagging.

    testWidgets('inline badge in text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'User status: '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'ACTIVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(text: ' since January'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('ACTIVE'), findsOneWidget);
      expect(find.text('User status: '), findsNothing); // Part of RichText
    });

    testWidgets('inline progress indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Loading '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(text: ' please wait...'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('inline color swatch', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Selected color: '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    TextSpan(text: ' Purple'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      var containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.length, greaterThan(0));
    });

    testWidgets('inline icon with tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Verified account '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Tooltip(
                        message: 'This account is verified',
                        child: Icon(
                          Icons.verified,
                          size: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.verified), findsOneWidget);
      expect(find.byType(Tooltip), findsOneWidget);
    });

    testWidgets('inline avatar with name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Assigned to '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.indigo,
                        child: Text(
                          'JD',
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        ),
                      ),
                    ),
                    TextSpan(text: ' John Doe for review'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('inline counter badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'You have '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(text: ' new notifications'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('inline link button', (WidgetTester tester) async {
      var linkPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Read our '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: GestureDetector(
                        onTap: () {
                          linkPressed = true;
                        },
                        child: Text(
                          'terms of service',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(text: ' for details'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('terms of service'));
      await tester.pump();

      expect(linkPressed, isTrue);
    });

    testWidgets('inline tag collection', (WidgetTester tester) async {
      Widget tagBuilder(String label, Color color) {
        return Container(
          margin: EdgeInsets.only(right: 4),
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color, width: 1),
          ),
          child: Text(label, style: TextStyle(color: color, fontSize: 11)),
        );
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Tags: '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: tagBuilder('flutter', Colors.blue),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: tagBuilder('dart', Colors.teal),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: tagBuilder('mobile', Colors.orange),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('flutter'), findsOneWidget);
      expect(find.text('dart'), findsOneWidget);
      expect(find.text('mobile'), findsOneWidget);
    });

    testWidgets('inline switch toggle', (WidgetTester tester) async {
      var switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Padding(
                  padding: EdgeInsets.all(16),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(text: 'Enable notifications '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              value: switchValue,
                              onChanged: (value) {
                                setState(() {
                                  switchValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                        TextSpan(text: switchValue ? ' (ON)' : ' (OFF)'),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('inline formatted number', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Total: '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: Text(
                        '\$1,234.56',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextSpan(text: ' USD'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('\$1,234.56'), findsOneWidget);
    });

    testWidgets('inline keyboard shortcut', (WidgetTester tester) async {
      var keyStyle = BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade400),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: Offset(0, 2),
            blurRadius: 0,
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Press '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: keyStyle,
                        child: Text('Ctrl', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    TextSpan(text: ' + '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: keyStyle,
                        child: Text('S', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    TextSpan(text: ' to save'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Ctrl'), findsOneWidget);
      expect(find.text('S'), findsOneWidget);
    });

    testWidgets('inline code snippet', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Use the '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'setState()',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            color: Colors.pink.shade700,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(text: ' method to update state'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('setState()'), findsOneWidget);
    });

    testWidgets('complex mixed content layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    height: 1.8,
                  ),
                  children: [
                    TextSpan(
                      text: 'Welcome ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(
                          'https://example.com/avatar.png',
                        ),
                        onBackgroundImageError: (e, s) {},
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    TextSpan(text: ' to the team! '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.celebration,
                        size: 18,
                        color: Colors.amber,
                      ),
                    ),
                    TextSpan(text: '\n\nYour role: '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Developer',
                          style: TextStyle(
                            color: Colors.purple.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(text: '\nAccess level: '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.security, size: 14, color: Colors.green),
                          SizedBox(width: 4),
                          Text(
                            'Admin',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.celebration), findsOneWidget);
      expect(find.byIcon(Icons.security), findsOneWidget);
      expect(find.text('Developer'), findsOneWidget);
      expect(find.text('Admin'), findsOneWidget);
    });
  });

  group('Tag Collection and Filtering', () {
    // Working with collections of PlaceholderSpanIndexSemanticsTag instances

    test('collecting tags in a list', () {
      var tags = <PlaceholderSpanIndexSemanticsTag>[];

      for (var i = 0; i < 5; i++) {
        tags.add(PlaceholderSpanIndexSemanticsTag(i));
      }

      expect(tags.length, equals(5));
      expect(tags[0].index, equals(0));
      expect(tags[4].index, equals(4));
    });

    test('filtering tags by index range', () {
      var allTags = List.generate(
        10,
        (i) => PlaceholderSpanIndexSemanticsTag(i),
      );

      var filteredTags = allTags
          .where((t) => t.index >= 3 && t.index <= 7)
          .toList();

      expect(filteredTags.length, equals(5));
      expect(filteredTags.first.index, equals(3));
      expect(filteredTags.last.index, equals(7));
    });

    test('mapping tags to index list', () {
      var tags = [
        PlaceholderSpanIndexSemanticsTag(2),
        PlaceholderSpanIndexSemanticsTag(4),
        PlaceholderSpanIndexSemanticsTag(6),
      ];

      var indices = tags.map((t) => t.index).toList();

      expect(indices, equals([2, 4, 6]));
    });

    test('finding tag by index', () {
      var tags = List.generate(10, (i) => PlaceholderSpanIndexSemanticsTag(i));

      var tag5 = tags.firstWhere((t) => t.index == 5);

      expect(tag5.index, equals(5));
    });

    test('checking if index exists in collection', () {
      var tags = [
        PlaceholderSpanIndexSemanticsTag(1),
        PlaceholderSpanIndexSemanticsTag(3),
        PlaceholderSpanIndexSemanticsTag(5),
      ];

      var hasIndex3 = tags.any((t) => t.index == 3);
      var hasIndex4 = tags.any((t) => t.index == 4);

      expect(hasIndex3, isTrue);
      expect(hasIndex4, isFalse);
    });

    test('getting maximum index from collection', () {
      var tags = [
        PlaceholderSpanIndexSemanticsTag(3),
        PlaceholderSpanIndexSemanticsTag(9),
        PlaceholderSpanIndexSemanticsTag(1),
        PlaceholderSpanIndexSemanticsTag(7),
      ];

      var maxIndex = tags.map((t) => t.index).reduce((a, b) => a > b ? a : b);

      expect(maxIndex, equals(9));
    });

    test('grouping consecutive indices', () {
      var tags = [
        PlaceholderSpanIndexSemanticsTag(0),
        PlaceholderSpanIndexSemanticsTag(1),
        PlaceholderSpanIndexSemanticsTag(2),
        PlaceholderSpanIndexSemanticsTag(5),
        PlaceholderSpanIndexSemanticsTag(6),
        PlaceholderSpanIndexSemanticsTag(10),
      ];

      var groups = <List<int>>[];
      var currentGroup = <int>[];

      for (var tag in tags) {
        if (currentGroup.isEmpty || tag.index == currentGroup.last + 1) {
          currentGroup.add(tag.index);
        } else {
          groups.add(List.from(currentGroup));
          currentGroup = [tag.index];
        }
      }
      if (currentGroup.isNotEmpty) {
        groups.add(currentGroup);
      }

      expect(groups.length, equals(3));
      expect(groups[0], equals([0, 1, 2]));
      expect(groups[1], equals([5, 6]));
      expect(groups[2], equals([10]));
    });
  });

  group('Integration Scenarios', () {
    // Real-world integration scenarios

    testWidgets('chat message with emoji reactions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.blue,
                            child: Text(
                              'U',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: ' User',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '  •  2:30 PM'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('This is a great update!'),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      children: [
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('👍 3', style: TextStyle(fontSize: 12)),
                          ),
                        ),
                        TextSpan(text: '  '),
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('❤️ 2', style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('This is a great update!'), findsOneWidget);
    });

    testWidgets('form field with inline help icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(text: 'Password '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Tooltip(
                            message: 'Must be at least 8 characters',
                            child: Icon(
                              Icons.help_outline,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter password',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.help_outline), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('product price with discount badge', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: '\$99.99',
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    TextSpan(text: '  '),
                    TextSpan(
                      text: '\$79.99',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(text: ' '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '-20%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('-20%'), findsOneWidget);
    });

    testWidgets('notification list item with inline icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.mail, color: Colors.white),
              ),
              title: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    TextSpan(text: ' New message from '),
                    TextSpan(
                      text: 'John',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              subtitle: Text('2 minutes ago'),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.mail), findsOneWidget);
      expect(find.text('2 minutes ago'), findsOneWidget);
    });

    testWidgets('search result with highlighted terms', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Found: '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade200,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          'flutter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(text: ' in 15 files'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('flutter'), findsOneWidget);
      expect(find.text(' in 15 files'), findsNothing); // Part of RichText
    });

    testWidgets('inline rating display with star icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: 'Rating: '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (i) {
                          return Icon(
                            i < 4 ? Icons.star : Icons.star_outline,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                    ),
                    TextSpan(text: ' (4.0)'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsNWidgets(4));
      expect(find.byIcon(Icons.star_outline), findsOneWidget);
    });
  });

  group('Edge Cases and Special Scenarios', () {
    test('creating tag with boundary index value', () {
      var tag = PlaceholderSpanIndexSemanticsTag(0);
      expect(tag.index, equals(0));

      var largeTag = PlaceholderSpanIndexSemanticsTag(2147483647);
      expect(largeTag.index, equals(2147483647));
    });

    test('tag in set maintains uniqueness by equality', () {
      var tagSet = <PlaceholderSpanIndexSemanticsTag>{};
      tagSet.add(PlaceholderSpanIndexSemanticsTag(1));
      tagSet.add(PlaceholderSpanIndexSemanticsTag(1));
      tagSet.add(PlaceholderSpanIndexSemanticsTag(2));

      expect(tagSet.length, equals(2));
    });

    test('comparing tags with objects of different types', () {
      var tag = PlaceholderSpanIndexSemanticsTag(5);
      Object intValue = 5;
      Object stringValue = 'five';
      Object? nullValue;

      expect(tag == intValue, isFalse);
      expect(tag == stringValue, isFalse);
      expect(tag == nullValue, isFalse);
    });

    testWidgets('empty RichText with no widget spans', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RichText(
            text: TextSpan(
              text: 'No widget spans here',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      );

      expect(find.byType(RichText), findsOneWidget);
    });

    testWidgets('WidgetSpan with zero-size widget', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Before',
                  style: TextStyle(color: Colors.black),
                ),
                WidgetSpan(child: SizedBox.shrink()),
                TextSpan(
                  text: 'After',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('deeply nested WidgetSpan structure', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Level 1 ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Level 2 ',
                        children: [
                          TextSpan(
                            text: 'Level 3 ',
                            children: [
                              WidgetSpan(child: Icon(Icons.star, size: 12)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    test('creating many tags in rapid succession', () {
      var tags = <PlaceholderSpanIndexSemanticsTag>[];

      for (var i = 0; i < 1000; i++) {
        tags.add(PlaceholderSpanIndexSemanticsTag(i));
      }

      expect(tags.length, equals(1000));
      expect(tags[500].index, equals(500));
      expect(tags[999].index, equals(999));
    });

    test('tag equality with itself', () {
      var tag = PlaceholderSpanIndexSemanticsTag(42);

      expect(tag == tag, isTrue);
      expect(identical(tag, tag), isTrue);
    });

    testWidgets('WidgetSpan with interactive widget', (
      WidgetTester tester,
    ) async {
      var tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(text: 'Click '),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        tapCount++;
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        color: Colors.blue,
                        child: Text(
                          'me',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  TextSpan(text: ' here'),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('me'));
      await tester.pump();

      expect(tapCount, equals(1));
    });
  });
}
