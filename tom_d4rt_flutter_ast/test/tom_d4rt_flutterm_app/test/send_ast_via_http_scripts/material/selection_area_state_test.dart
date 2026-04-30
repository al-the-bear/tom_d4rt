// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionAreaState from material
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

Widget buildDemoCard(String title, String description, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

Widget buildSelectionAreaBasic() {
  print('Building basic SelectionArea demo');
  return SelectionArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Selectable Text',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'This text is inside a SelectionArea and can be selected by the user. '
          'SelectionArea wraps widgets to enable text selection across multiple text widgets. '
          'The SelectionAreaState manages the selection state internally.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}

Widget buildSelectionAreaWithParagraphs() {
  print('Building SelectionArea with multiple paragraphs');
  return SelectionArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'First Paragraph',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 12),
        Text(
          'Second Paragraph',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
          'nisi ut aliquip ex ea commodo consequat.',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 12),
        Text(
          'Third Paragraph',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Duis aute irure dolor in reprehenderit in voluptate velit esse '
          'cillum dolore eu fugiat nulla pariatur.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}

Widget buildSelectableTextWithinArea() {
  print('Building SelectableText within SelectionArea');
  return SelectionArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          'Heading using SelectableText',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        SizedBox(height: 8),
        SelectableText(
          'This SelectableText widget is placed inside a SelectionArea. '
          'Both widgets support text selection, but SelectionArea provides '
          'a unified selection experience across multiple children.',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 8),
        SelectableText(
          'Another SelectableText paragraph with different styling.',
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget buildRichTextSelection() {
  print('Building RichText selection demo');
  return SelectionArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: 'RichText with ',
            style: TextStyle(fontSize: 14, color: Colors.black),
            children: [
              TextSpan(
                text: 'bold',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ', '),
              TextSpan(
                text: 'italic',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              TextSpan(text: ', and '),
              TextSpan(
                text: 'colored',
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: ' spans.'),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text.rich(
          TextSpan(
            text: 'Mixed ',
            style: TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: 'LARGE',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' and '),
              TextSpan(
                text: 'small',
                style: TextStyle(fontSize: 10),
              ),
              TextSpan(text: ' text sizes in one span.'),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text.rich(
          TextSpan(
            text: 'Underlined ',
            style: TextStyle(
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
            children: [
              TextSpan(
                text: 'and strikethrough ',
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              TextSpan(
                text: 'text decorations',
                style: TextStyle(decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSelectionWithColors(Color selectionColor) {
  print('Building selection with color: $selectionColor');
  return SelectionArea(
    selectionControls: MaterialTextSelectionControls(),
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Selection Color Demo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Select this text to see the custom selection highlight. '
            'The SelectionArea allows customization of selection appearance '
            'through various theme settings and controls.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}

Widget buildContextMenuDemo() {
  print('Building context menu demo');
  return SelectionArea(
    contextMenuBuilder: (BuildContext context, SelectableRegionState selectableRegionState) {
      return AdaptiveTextSelectionToolbar.buttonItems(
        anchors: selectableRegionState.contextMenuAnchors,
        buttonItems: [
          ContextMenuButtonItem(
            label: 'Copy',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: 'Selected text copied'));
              print('Copy action triggered from context menu');
            },
          ),
          ContextMenuButtonItem(
            label: 'Select All',
            onPressed: () {
              selectableRegionState.selectAll(SelectionChangedCause.toolbar);
              print('Select All action triggered from context menu');
            },
          ),
        ],
      );
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Context Menu',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'This SelectionArea has a custom context menu with Copy and Select All options. '
          'Long press or right-click to see the custom toolbar.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}

Widget buildMagnifierDemo() {
  print('Building magnifier demo');
  return SelectionArea(
    magnifierConfiguration: TextMagnifierConfiguration(
      magnifierBuilder: (
        BuildContext context,
        MagnifierController controller,
        ValueNotifier<MagnifierInfo> magnifierInfo,
      ) {
        return TextMagnifier(
          magnifierInfo: magnifierInfo,
        );
      },
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Magnifier Configuration',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'This SelectionArea uses a custom magnifier configuration. '
          'On touch devices, a magnifier appears when selecting text to help '
          'users see the selection point more clearly.',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          'Try selecting text on a touch device to see the magnifier in action. '
          'The magnifier zooms in on the cursor position for precise selection.',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildOnSelectionChangedDemo() {
  print('Building onSelectionChanged demo');
  int tapCount = 0;
  
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.analytics, color: Colors.indigo.shade700),
                SizedBox(width: 8),
                Text(
                  'Interaction count: $tapCount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              setState(() {
                tapCount++;
              });
              print('Selection area tapped at: ${details.localPosition}');
            },
            child: SelectionArea(
              child: Text(
                'Tap or select this text to see interaction tracking. '
                'The SelectionArea widget manages selection state through SelectionAreaState. '
                'Each tap increments the counter above to demonstrate state management.',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SelectionAreaState Features:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text('• Manages selection across child widgets'),
                Text('• Coordinates with SelectableRegionState'),
                Text('• Handles clipboard operations'),
                Text('• Supports keyboard shortcuts (Ctrl+A, Ctrl+C)'),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Widget buildMultipleTextWidgets() {
  print('Building multiple text widgets demo');
  return SelectionArea(
    child: Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Chip(
          label: Text('Chip 1'),
          backgroundColor: Colors.blue.shade100,
        ),
        Chip(
          label: Text('Chip 2'),
          backgroundColor: Colors.green.shade100,
        ),
        Chip(
          label: Text('Chip 3'),
          backgroundColor: Colors.orange.shade100,
        ),
        Container(
          padding: EdgeInsets.all(8),
          color: Colors.purple.shade50,
          child: Text('Container Text'),
        ),
        Text('Regular Text'),
        Text(
          'Bold Text',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Italic Text',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget buildNestedSelectionAreas() {
  print('Building nested selection areas demo');
  return SelectionArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Outer SelectionArea',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'This is text inside the outer SelectionArea.',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nested Content',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Content inside a nested container is still selectable '
                'because it is within the SelectionArea.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSelectionControlsDemo() {
  print('Building selection controls demo');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Material Selection Controls',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      SelectionArea(
        selectionControls: MaterialTextSelectionControls(),
        child: Text(
          'This uses MaterialTextSelectionControls for selection handles. '
          'The material design selection handles are circular with a teardrop shape.',
          style: TextStyle(fontSize: 14),
        ),
      ),
      SizedBox(height: 16),
      Text(
        'Desktop Selection Controls',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      SelectionArea(
        selectionControls: DesktopTextSelectionControls(),
        child: Text(
          'This uses DesktopTextSelectionControls for desktop platforms. '
          'Desktop selection handles are typically smaller and less intrusive.',
          style: TextStyle(fontSize: 14),
        ),
      ),
    ],
  );
}

Widget buildStyledSelectionArea() {
  print('Building styled selection area');
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.all(16),
    child: SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote, color: Colors.purple.shade400),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'A Styled Quote',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '"The only way to do great work is to love what you do. '
            'If you have not found it yet, keep looking. Do not settle."',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade800,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '— Steve Jobs',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.purple.shade600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildArticleWithSelectionArea() {
  print('Building article with selection area');
  return SelectionArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Understanding SelectionAreaState',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'A deep dive into Flutter selection',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        Divider(height: 24),
        Text(
          'SelectionAreaState is the State class associated with SelectionArea widget. '
          'It manages the selection state for all selectable content within its subtree.',
          style: TextStyle(fontSize: 14, height: 1.6),
        ),
        SizedBox(height: 12),
        Text(
          'Key Features:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• Unified selection across widgets'),
              Text('• Support for multiple text styles'),
              Text('• Custom context menus'),
              Text('• Magnifier configuration'),
              Text('• Selection change callbacks'),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'The SelectionAreaState provides methods for programmatic control of selection, '
          'including selectAll, copy, and clear operations.',
          style: TextStyle(fontSize: 14, height: 1.6),
        ),
      ],
    ),
  );
}

Widget buildCodeBlockSelection() {
  print('Building code block selection demo');
  return SelectionArea(
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SelectionArea(',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              color: Color(0xFF4EC9B0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'child: Text("Selectable content"),',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: Color(0xFFCE9178),
              ),
            ),
          ),
          Text(
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              color: Color(0xFF4EC9B0),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildListItemsWithSelection() {
  print('Building list items with selection');
  return SelectionArea(
    child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          margin: EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: index.isEven ? Colors.grey.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'List item number ${index + 1} with selectable text content',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

dynamic build(BuildContext context) {
  print('SelectionAreaState deep demo test executing');

  print('Section: SelectionArea basics');
  print('Section: selecting text content');
  print('Section: SelectableText within');
  print('Section: RichText selection');
  print('Section: selection colors');
  print('Section: context menu');
  print('Section: magnifier');
  print('Section: onSelectionChanged');

  return Scaffold(
    appBar: AppBar(
      title: Text('SelectionAreaState Demo'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoCard('Widget', 'SelectionArea'),
          buildInfoCard('State Class', 'SelectionAreaState'),
          buildInfoCard('Package', 'package:flutter/material.dart'),
          buildInfoCard(
            'Description',
            'SelectionAreaState manages the selection state for SelectionArea widget',
          ),

          buildSectionHeader('SelectionArea Basics'),
          buildDemoCard(
            'Basic SelectionArea',
            'Wrap content to make it selectable',
            buildSelectionAreaBasic(),
          ),
          buildDemoCard(
            'Multiple Paragraphs',
            'Selection spans across multiple Text widgets',
            buildSelectionAreaWithParagraphs(),
          ),

          buildSectionHeader('Selecting Text Content'),
          buildDemoCard(
            'Article Content',
            'Full article with unified selection',
            buildArticleWithSelectionArea(),
          ),
          buildDemoCard(
            'Code Block',
            'Selectable code with syntax styling',
            buildCodeBlockSelection(),
          ),

          buildSectionHeader('SelectableText Within'),
          buildDemoCard(
            'SelectableText Inside SelectionArea',
            'Combining SelectableText with SelectionArea',
            buildSelectableTextWithinArea(),
          ),
          buildDemoCard(
            'Multiple Widget Types',
            'Different widgets within SelectionArea',
            buildMultipleTextWidgets(),
          ),

          buildSectionHeader('RichText Selection'),
          buildDemoCard(
            'Rich Text Styles',
            'Selection with various text styles',
            buildRichTextSelection(),
          ),
          buildDemoCard(
            'Styled Quote',
            'Artistic text layout with selection',
            buildStyledSelectionArea(),
          ),

          buildSectionHeader('Selection Colors'),
          buildDemoCard(
            'Blue Selection',
            'Custom blue selection highlight',
            buildSelectionWithColors(Colors.blue),
          ),
          buildDemoCard(
            'Green Selection',
            'Custom green selection highlight',
            buildSelectionWithColors(Colors.green),
          ),
          buildDemoCard(
            'Purple Selection',
            'Custom purple selection highlight',
            buildSelectionWithColors(Colors.purple),
          ),

          buildSectionHeader('Context Menu'),
          buildDemoCard(
            'Custom Context Menu',
            'Long press for custom toolbar options',
            buildContextMenuDemo(),
          ),
          buildDemoCard(
            'Selection Controls',
            'Different selection control styles',
            buildSelectionControlsDemo(),
          ),

          buildSectionHeader('Magnifier'),
          buildDemoCard(
            'Text Magnifier',
            'Magnifier appears during selection on touch devices',
            buildMagnifierDemo(),
          ),

          buildSectionHeader('onSelectionChanged'),
          buildDemoCard(
            'Selection Callback',
            'Track selection changes with callback',
            buildOnSelectionChangedDemo(),
          ),
          buildDemoCard(
            'Nested Content',
            'Selection in nested layouts',
            buildNestedSelectionAreas(),
          ),
          buildDemoCard(
            'List Items',
            'Selectable list content',
            buildListItemsWithSelection(),
          ),

          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SelectionAreaState Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'SelectionAreaState is the State class for SelectionArea. It manages:',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 4),
                Text('- Selection state across child widgets'),
                Text('- Context menu display and actions'),
                Text('- Magnifier configuration for touch devices'),
                Text('- Selection change callbacks'),
                Text('- Programmatic selection control'),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}
