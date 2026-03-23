// ignore_for_file: avoid_print
// D4rt test script: Tests SelectionArea from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildBasicSelectionArea(String label, String content, Color highlightColor) {
  print('Building basic selection area: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.select_all, color: highlightColor, size: 20),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        SelectionArea(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: highlightColor.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: highlightColor.withAlpha(60)),
            ),
            child: Text(
              content,
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Try selecting the text above',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget buildTextWrapperDemo(String title, List<String> paragraphs, MaterialColor themeColor) {
  print('Building text wrapper demo: $title');
  List<Widget> textWidgets = [];
  int idx = 0;
  for (idx = 0; idx < paragraphs.length; idx = idx + 1) {
    textWidgets.add(
      Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          paragraphs[idx],
          style: TextStyle(fontSize: 14, height: 1.6, color: Colors.grey.shade800),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: themeColor.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: themeColor.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: themeColor.shade800,
            ),
          ),
        ),
        SizedBox(height: 12),
        SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: textWidgets,
          ),
        ),
      ],
    ),
  );
}

Widget buildRichTextSelectionDemo(String label, MaterialColor accentColor) {
  print('Building rich text selection demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: accentColor.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(Icons.format_color_text, color: accentColor.shade700, size: 18),
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        SelectionArea(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14, color: Colors.grey.shade800, height: 1.6),
              children: [
                TextSpan(text: 'SelectionArea '),
                TextSpan(
                  text: 'enables text selection ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: accentColor.shade700),
                ),
                TextSpan(text: 'across multiple '),
                TextSpan(
                  text: 'Text ',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.purple.shade600),
                ),
                TextSpan(text: 'and '),
                TextSpan(
                  text: 'RichText ',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.teal.shade600),
                ),
                TextSpan(text: 'widgets. Users can '),
                TextSpan(
                  text: 'select, copy, ',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                TextSpan(text: 'and interact with text content seamlessly.'),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.amber.shade700),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'RichText with multiple TextSpans is fully selectable',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildStyledRichTextDemo() {
  print('Building styled rich text demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multiple Styled Spans',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        SelectionArea(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 15, color: Colors.grey.shade900),
              children: [
                TextSpan(
                  text: 'HEADLINE: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.red.shade700,
                  ),
                ),
                TextSpan(
                  text: 'Breaking news from Flutter Development',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextSpan(text: '\n\n'),
                TextSpan(
                  text: 'By Author Name ',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade600),
                ),
                TextSpan(
                  text: '• March 2026',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                TextSpan(text: '\n\n'),
                TextSpan(
                  text: 'SelectionArea provides a powerful way to enable text selection ',
                ),
                TextSpan(
                  text: 'across widget boundaries. ',
                  style: TextStyle(backgroundColor: Colors.yellow.shade200),
                ),
                TextSpan(text: 'This feature is essential for '),
                TextSpan(
                  text: 'accessibility ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                ),
                TextSpan(text: 'and '),
                TextSpan(
                  text: 'usability.',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade700),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildContextMenuExample(String title, String description, IconData icon, MaterialColor color) {
  print('Building context menu example: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color.shade700, size: 22),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SelectionArea(
          contextMenuBuilder: (BuildContext context, SelectableRegionState selectableRegionState) {
            return AdaptiveTextSelectionToolbar.buttonItems(
              anchors: selectableRegionState.contextMenuAnchors,
              buttonItems: [
                ContextMenuButtonItem(
                  onPressed: () {
                    selectableRegionState.copySelection(SelectionChangedCause.toolbar);
                    print('Custom copy action triggered');
                  },
                  type: ContextMenuButtonType.copy,
                ),
                ContextMenuButtonItem(
                  onPressed: () {
                    selectableRegionState.selectAll(SelectionChangedCause.toolbar);
                    print('Custom select all action triggered');
                  },
                  type: ContextMenuButtonType.selectAll,
                ),
              ],
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Select this text to see the custom context menu with Copy and Select All options.',
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSelectionControlsDemo() {
  print('Building selection controls demo');
  List<String> controlTypes = [
    'Material Controls',
    'Cupertino Controls',
    'Desktop Controls',
    'Custom Controls',
  ];
  List<IconData> controlIcons = [
    Icons.android,
    Icons.apple,
    Icons.desktop_windows,
    Icons.tune,
  ];
  List<MaterialColor> controlColors = [
    Colors.green,
    Colors.grey,
    Colors.blue,
    Colors.purple,
  ];
  List<String> controlDescriptions = [
    'Standard Material Design selection handles and toolbar',
    'iOS-style selection handles with rounded appearance',
    'Desktop-optimized controls without touch handles',
    'Fully customizable selection behavior',
  ];

  List<Widget> controlCards = [];
  int c = 0;
  for (c = 0; c < controlTypes.length; c = c + 1) {
    controlCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: controlColors[c].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: controlColors[c].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(controlIcons[c], color: controlColors[c].shade700, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controlTypes[c],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    controlDescriptions[c],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: controlColors[c].shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'v${c + 1}',
                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selection Controls Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different platform-specific selection control styles',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: controlCards),
      ],
    ),
  );
}

Widget buildOnSelectionChangedDemo() {
  print('Building onSelectionChanged demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.event_note, color: Colors.teal.shade700, size: 20),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selection Change Callback',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Track selection events in real-time',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 14),
        SelectionArea(
          onSelectionChanged: (selectedContent) {
            if (selectedContent != null) {
              print('Selection changed: ${selectedContent.plainText}');
            } else {
              print('Selection cleared');
            }
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Select any portion of this text to trigger the onSelectionChanged callback. '
              'The callback receives SelectedContent with plainText property containing the selected text. '
              'This enables features like word lookup, sharing, or custom text processing.',
              style: TextStyle(fontSize: 14, height: 1.6),
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(Icons.code, size: 16, color: Colors.grey.shade600),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'onSelectionChanged: (content) => print(content?.plainText)',
                  style: TextStyle(fontSize: 12, fontFamily: 'monospace', color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSelectionEventsList() {
  print('Building selection events list');
  List<String> eventNames = [
    'Selection Started',
    'Selection Updated',
    'Selection Ended',
    'Copy Triggered',
    'Select All',
  ];
  List<String> eventDescriptions = [
    'User begins selecting text by tapping and dragging',
    'Selection bounds change as user drags',
    'User lifts finger or releases mouse button',
    'User chooses copy from context menu',
    'User selects all content in the selection area',
  ];
  List<IconData> eventIcons = [
    Icons.touch_app,
    Icons.pan_tool,
    Icons.back_hand,
    Icons.content_copy,
    Icons.select_all,
  ];
  List<MaterialColor> eventColors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.indigo,
  ];

  List<Widget> eventItems = [];
  int e = 0;
  for (e = 0; e < eventNames.length; e = e + 1) {
    eventItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: eventColors[e].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: eventColors[e].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: eventColors[e].shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(eventIcons[e], color: eventColors[e].shade700, size: 16),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventNames[e],
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    eventDescriptions[e],
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Text(
              '${e + 1}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: eventColors[e].shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selection Event Types',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Events emitted during selection interaction',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 10),
        Column(children: eventItems),
      ],
    ),
  );
}

Widget buildFocusNodeDemo() {
  print('Building focus node demo');
  FocusNode selectionFocusNode = FocusNode(debugLabel: 'SelectionAreaFocus');

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.center_focus_strong, color: Colors.deepPurple.shade700, size: 20),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FocusNode Integration',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Control focus programmatically',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        SelectionArea(
          focusNode: selectionFocusNode,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'This SelectionArea has a custom FocusNode attached. '
              'The FocusNode allows programmatic control of focus state, '
              'enabling keyboard navigation and accessibility features. '
              'Request focus, unfocus, or check focus state using the FocusNode API.',
              style: TextStyle(fontSize: 14, height: 1.6),
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Icon(Icons.keyboard, color: Colors.deepPurple.shade700, size: 20),
                    SizedBox(height: 4),
                    Text(
                      'Keyboard Nav',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Icon(Icons.accessibility_new, color: Colors.deepPurple.shade700, size: 20),
                    SizedBox(height: 4),
                    Text(
                      'Accessibility',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Icon(Icons.code, color: Colors.deepPurple.shade700, size: 20),
                    SizedBox(height: 4),
                    Text(
                      'Programmatic',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildFocusNodeMethods() {
  print('Building focus node methods');
  List<String> methodNames = [
    'requestFocus()',
    'unfocus()',
    'hasFocus',
    'hasPrimaryFocus',
    'canRequestFocus',
  ];
  List<String> methodDescriptions = [
    'Request focus for this selection area',
    'Remove focus from this selection area',
    'Check if descendant has focus',
    'Check if this node has primary focus',
    'Check if focus can be requested',
  ];
  List<String> methodReturns = [
    'void',
    'void',
    'bool',
    'bool',
    'bool',
  ];

  List<Widget> methodItems = [];
  int m = 0;
  for (m = 0; m < methodNames.length; m = m + 1) {
    methodItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                methodNames[m],
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                methodReturns[m],
                style: TextStyle(fontSize: 10, color: Colors.blue.shade800),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: Text(
                methodDescriptions[m],
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FocusNode API Reference',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Common methods and properties for focus management',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 10),
        Column(children: methodItems),
      ],
    ),
  );
}

Widget buildChildLayoutCard(String title, String description, Widget child, MaterialColor color) {
  print('Building child layout card: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.view_module, color: color.shade700, size: 20),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color.shade800),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 11, color: color.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: SelectionArea(child: child),
        ),
      ],
    ),
  );
}

Widget buildColumnLayoutDemo() {
  print('Building column layout demo');
  return buildChildLayoutCard(
    'Column Layout',
    'Multiple Text widgets stacked vertically',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'First Paragraph',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text(
          'This is the first paragraph of text in the column layout. Selection works seamlessly across all text elements.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          'Second Paragraph',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text(
          'The second paragraph continues with more content. Users can select text spanning multiple paragraphs.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          'Third Paragraph',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text(
          'Final paragraph demonstrating that SelectionArea handles complex nested widget structures gracefully.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
      ],
    ),
    Colors.blue,
  );
}

Widget buildRowLayoutDemo() {
  print('Building row layout demo');
  return buildChildLayoutCard(
    'Row Layout',
    'Text elements displayed horizontally',
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Text(
                  'Column A',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                ),
                SizedBox(height: 4),
                Text(
                  'Left column with selectable text content.',
                  style: TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Text(
                  'Column B',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                ),
                SizedBox(height: 4),
                Text(
                  'Middle column with more text to select.',
                  style: TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Text(
                  'Column C',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                ),
                SizedBox(height: 4),
                Text(
                  'Right column completing the row layout.',
                  style: TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    Colors.green,
  );
}

Widget buildNestedLayoutDemo() {
  print('Building nested layout demo');
  return buildChildLayoutCard(
    'Nested Layout',
    'Complex widget hierarchy with mixed layouts',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Document Header',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Author: John Doe',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Text(
                'Date: 2026-03-21',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          'This demonstrates deeply nested layouts within a SelectionArea. The selection capability extends through the entire widget subtree regardless of nesting depth.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Sidebar content also selectable',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Text(
                'Main content area with additional details and information that can be selected by the user.',
                style: TextStyle(fontSize: 12, height: 1.4),
              ),
            ),
          ],
        ),
      ],
    ),
    Colors.orange,
  );
}

Widget buildWrapLayoutDemo() {
  print('Building wrap layout demo');
  List<String> tags = [
    'Flutter',
    'Dart',
    'SelectionArea',
    'Material',
    'Widget',
    'Text Selection',
    'UI',
    'Mobile',
    'Cross-platform',
  ];

  List<Widget> tagWidgets = [];
  int t = 0;
  for (t = 0; t < tags.length; t = t + 1) {
    tagWidgets.add(
      Container(
        margin: EdgeInsets.only(right: 6, bottom: 6),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.purple.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          tags[t],
          style: TextStyle(fontSize: 12, color: Colors.purple.shade800),
        ),
      ),
    );
  }

  return buildChildLayoutCard(
    'Wrap Layout',
    'Flowing tags with selectable text',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selectable Tags',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(children: tagWidgets),
        SizedBox(height: 10),
        Text(
          'Each tag above contains selectable text. Users can select across multiple tags in a single selection gesture.',
          style: TextStyle(fontSize: 12, height: 1.4, color: Colors.grey.shade700),
        ),
      ],
    ),
    Colors.purple,
  );
}

Widget buildPropertySummary() {
  print('Building property summary');
  List<String> propNames = [
    'child',
    'focusNode',
    'selectionControls',
    'contextMenuBuilder',
    'magnifierConfiguration',
    'onSelectionChanged',
  ];
  List<String> propTypes = [
    'Widget',
    'FocusNode?',
    'TextSelectionControls?',
    'SelectionAreaContextMenuBuilder?',
    'TextMagnifierConfiguration?',
    'SelectionChangedCallback?',
  ];
  List<String> propDescriptions = [
    'The widget subtree to enable selection for',
    'Optional focus node for keyboard focus',
    'Platform text selection control style',
    'Builder for custom context menu',
    'Magnifier appearance configuration',
    'Callback when selection changes',
  ];

  List<Widget> propRows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    propRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                propNames[p],
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                propTypes[p],
                style: TextStyle(fontSize: 11, color: Colors.blue.shade700, fontFamily: 'monospace'),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                propDescriptions[p],
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.list_alt, color: Colors.indigo.shade700, size: 20),
              SizedBox(width: 8),
              Text(
                'SelectionArea Properties',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.indigo.shade800),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          color: Colors.grey.shade100,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Property', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text('Type', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text('Description', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        Column(children: propRows),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('SelectionArea deep demo executing');
  print('Demonstrating text selection capabilities in Flutter');

  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    appBar: AppBar(
      title: Text('SelectionArea Deep Demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoCard('Widget', 'SelectionArea'),
          buildInfoCard('Package', 'package:flutter/material.dart'),
          buildInfoCard('Purpose', 'Enables text selection for child widget subtree'),
          
          buildSectionHeader('SelectionArea Widget Basics'),
          buildBasicSelectionArea(
            'Simple Text Selection',
            'SelectionArea is a widget that enables text selection for its descendant Text and RichText widgets. '
            'When wrapped in a SelectionArea, users can tap and drag to select text, then use the context menu to copy. '
            'This is essential for creating accessible and user-friendly text content.',
            Colors.blue,
          ),
          buildBasicSelectionArea(
            'Multi-line Selection',
            'SelectionArea handles multi-line text elegantly. Users can begin selecting on one line and extend '
            'to multiple subsequent lines. The selection highlight follows the text flow naturally, wrapping '
            'at line breaks and respecting text direction. This behavior works consistently across platforms.',
            Colors.green,
          ),
          buildPropertySummary(),
          
          buildSectionHeader('Wrapping Text Widgets'),
          buildTextWrapperDemo(
            'Article Content',
            [
              'The SelectionArea widget was introduced to simplify text selection in Flutter applications.',
              'Before SelectionArea, developers had to use SelectableText for each individual Text widget, which was cumbersome for complex layouts.',
              'With SelectionArea, a single wrapper enables selection for entire widget subtrees, making it much more convenient.',
              'This approach also ensures consistent selection behavior across all wrapped text elements.',
            ],
            Colors.teal,
          ),
          buildTextWrapperDemo(
            'Documentation Example',
            [
              'To use SelectionArea, simply wrap your content with the SelectionArea widget.',
              'All descendant Text and RichText widgets become selectable automatically.',
              'The selection extends seamlessly across widget boundaries within the SelectionArea.',
            ],
            Colors.amber,
          ),
          
          buildSectionHeader('Wrapping RichText'),
          buildRichTextSelectionDemo('Formatted Text Selection', Colors.deepPurple),
          buildStyledRichTextDemo(),
          
          buildSectionHeader('contextMenuBuilder'),
          buildContextMenuExample(
            'Custom Copy Menu',
            'Customized context menu with specific actions',
            Icons.content_copy,
            Colors.blue,
          ),
          buildContextMenuExample(
            'Extended Actions',
            'Context menu supporting additional operations',
            Icons.more_horiz,
            Colors.green,
          ),
          
          buildSectionHeader('selectionControls'),
          buildSelectionControlsDemo(),
          
          buildSectionHeader('onSelectionChanged'),
          buildOnSelectionChangedDemo(),
          buildSelectionEventsList(),
          
          buildSectionHeader('focusNode Usage'),
          buildFocusNodeDemo(),
          buildFocusNodeMethods(),
          
          buildSectionHeader('Child Layout Variants'),
          buildColumnLayoutDemo(),
          buildRowLayoutDemo(),
          buildNestedLayoutDemo(),
          buildWrapLayoutDemo(),
          
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade700,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'SelectionArea deep demo completed successfully',
                    style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}
