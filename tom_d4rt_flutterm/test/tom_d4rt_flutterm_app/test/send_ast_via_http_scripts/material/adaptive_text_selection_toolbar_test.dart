// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AdaptiveTextSelectionToolbar from material
// Demonstrates toolbar-like visuals with different button configurations
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade700,
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

// Helper to build a toolbar button
Widget buildToolbarButton(
  String label,
  IconData icon,
  Color color, {
  bool isEnabled = true,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: isEnabled ? color.withAlpha(25) : Colors.grey.shade100,
      border: Border.all(
        color: isEnabled ? color : Colors.grey.shade300,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: isEnabled ? color : Colors.grey.shade400),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isEnabled ? color : Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// Helper to build a full toolbar strip
Widget buildToolbarStrip(
  String label,
  List<Widget> buttons,
  Color backgroundColor,
  double elevation,
  double borderRadius,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Material(
          elevation: elevation,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: intersperseWidgets(SizedBox(width: 4), buttons),
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper to intersperse separators between items
List<Widget> intersperseWidgets(Widget separator, List<Widget> items) {
  List<Widget> result = [];
  for (int i = 0; i < items.length; i++) {
    result.add(items[i]);
    if (i < items.length - 1) {
      result.add(separator);
    }
  }
  return result;
}

// Helper to build a text selection visual with highlighted text
Widget buildTextSelectionVisual(
  String beforeText,
  String selectedText,
  String afterText,
  Color selectionColor,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(beforeText, style: TextStyle(fontSize: 15)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2),
          color: selectionColor.withAlpha(80),
          child: Text(
            selectedText,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
        Text(afterText, style: TextStyle(fontSize: 15)),
      ],
    ),
  );
}

// Helper to build platform-specific toolbar appearance
Widget buildPlatformToolbar(
  String platformName,
  Color bgColor,
  Color buttonColor,
  double borderRadius,
  bool showIcons,
  List<String> buttonLabels,
) {
  return Card(
    elevation: 3,
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: buttonColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '$platformName Toolbar Style',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Selection area
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(text: 'Some text with '),
                  TextSpan(
                    text: 'selected portion',
                    style: TextStyle(
                      backgroundColor: buttonColor.withAlpha(50),
                    ),
                  ),
                  TextSpan(text: ' here for demo.'),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          // Toolbar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: buttonLabels.map((label) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showIcons) ...[
                        Icon(
                          getIconForAction(label),
                          size: 16,
                          color: buttonColor,
                        ),
                        SizedBox(width: 4),
                      ],
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 13,
                          color: buttonColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),
  );
}

IconData getIconForAction(String action) {
  switch (action.toLowerCase()) {
    case 'cut':
      return Icons.content_cut;
    case 'copy':
      return Icons.content_copy;
    case 'paste':
      return Icons.content_paste;
    case 'select all':
      return Icons.select_all;
    case 'share':
      return Icons.share;
    case 'look up':
      return Icons.search;
    case 'translate':
      return Icons.translate;
    default:
      return Icons.more_horiz;
  }
}

// Helper to build a custom action chip
Widget buildActionChip(String label, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 4),
    child: Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(label, style: TextStyle(fontSize: 13)),
      backgroundColor: color.withAlpha(25),
      side: BorderSide(color: color.withAlpha(80)),
    ),
  );
}

// Helper to build toolbar with vertical dividers
Widget buildDividedToolbar(
  List<List<Widget>> groups,
  Color bgColor,
  Color dividerColor,
) {
  List<Widget> items = [];
  for (int i = 0; i < groups.length; i++) {
    items.addAll(groups[i]);
    if (i < groups.length - 1) {
      items.add(
        Container(
          width: 1,
          height: 24,
          margin: EdgeInsets.symmetric(horizontal: 6),
          color: dividerColor,
        ),
      );
    }
  }
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: items),
  );
}

// Helper to build icon-only toolbar button
Widget buildIconOnlyButton(
  IconData icon,
  Color color, {
  double size = 20,
  bool isActive = false,
}) {
  return Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: isActive ? color.withAlpha(30) : Colors.transparent,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Icon(icon, size: size, color: color),
  );
}

// Helper to build contextual toolbar
Widget buildContextualToolbar(
  String contextLabel,
  IconData contextIcon,
  Color color,
  List<String> actions,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(contextIcon, size: 18, color: color),
            SizedBox(width: 8),
            Text(
              contextLabel,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: actions.map((action) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color.withAlpha(80)),
              ),
              child: Text(action, style: TextStyle(fontSize: 12, color: color)),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// Helper to build toolbar state
Widget buildToolbarState(String label, double opacity, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 160,
          child: Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ),
        Opacity(
          opacity: opacity,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.content_cut, size: 16, color: color),
                SizedBox(width: 8),
                Icon(Icons.content_copy, size: 16, color: color),
                SizedBox(width: 8),
                Icon(Icons.content_paste, size: 16, color: color),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== AdaptiveTextSelectionToolbar Test Script ===');
  debugPrint('Testing text selection toolbar with different configurations');

  // Check platform for adaptive behavior
  TargetPlatform platform = Theme.of(context).platform;
  debugPrint('Current platform: $platform');

  debugPrint('Building toolbar demonstrations...');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AdaptiveTextSelectionToolbar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Demonstrates toolbar configurations for text selection',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Basic Toolbar Configurations
        buildSectionHeader('1. Basic Toolbar Configurations'),
        buildToolbarStrip(
          'Standard toolbar (Cut, Copy, Paste)',
          [
            buildToolbarButton('Cut', Icons.content_cut, Colors.deepPurple),
            buildToolbarButton('Copy', Icons.content_copy, Colors.deepPurple),
            buildToolbarButton('Paste', Icons.content_paste, Colors.deepPurple),
          ],
          Colors.white,
          4,
          8,
        ),
        buildToolbarStrip(
          'Extended toolbar with Select All',
          [
            buildToolbarButton('Cut', Icons.content_cut, Colors.blue.shade700),
            buildToolbarButton(
              'Copy',
              Icons.content_copy,
              Colors.blue.shade700,
            ),
            buildToolbarButton(
              'Paste',
              Icons.content_paste,
              Colors.blue.shade700,
            ),
            buildToolbarButton(
              'Select All',
              Icons.select_all,
              Colors.blue.shade700,
            ),
          ],
          Colors.blue.shade50,
          3,
          12,
        ),
        buildToolbarStrip(
          'Full toolbar with sharing',
          [
            buildToolbarButton('Cut', Icons.content_cut, Colors.teal.shade700),
            buildToolbarButton(
              'Copy',
              Icons.content_copy,
              Colors.teal.shade700,
            ),
            buildToolbarButton(
              'Paste',
              Icons.content_paste,
              Colors.teal.shade700,
            ),
            buildToolbarButton(
              'Select All',
              Icons.select_all,
              Colors.teal.shade700,
            ),
            buildToolbarButton('Share', Icons.share, Colors.teal.shade700),
          ],
          Colors.teal.shade50,
          2,
          16,
        ),
        buildToolbarStrip(
          'Disabled items toolbar',
          [
            buildToolbarButton(
              'Cut',
              Icons.content_cut,
              Colors.red.shade700,
              isEnabled: false,
            ),
            buildToolbarButton('Copy', Icons.content_copy, Colors.red.shade700),
            buildToolbarButton(
              'Paste',
              Icons.content_paste,
              Colors.red.shade700,
              isEnabled: false,
            ),
          ],
          Colors.white,
          2,
          8,
        ),

        // Section 2: Platform-Specific Toolbars
        buildSectionHeader('2. Platform-Specific Toolbar Styles'),
        buildPlatformToolbar(
          'Android (Material)',
          Colors.white,
          Colors.black87,
          8,
          false,
          ['Cut', 'Copy', 'Paste', 'Select All'],
        ),
        buildPlatformToolbar(
          'iOS (Cupertino)',
          Colors.grey.shade800,
          Colors.white,
          20,
          false,
          ['Cut', 'Copy', 'Paste', 'Look Up', 'Share'],
        ),
        buildPlatformToolbar(
          'Desktop',
          Colors.white,
          Colors.grey.shade700,
          4,
          true,
          ['Cut', 'Copy', 'Paste', 'Select All'],
        ),

        // Section 3: Text Selection Visuals
        buildSectionHeader('3. Text Selection Visual States'),
        Text(
          '  Word selection:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        buildTextSelectionVisual(
          'Click on a ',
          'word',
          ' to select it',
          Colors.blue,
        ),
        SizedBox(height: 12),
        Text(
          '  Phrase selection:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        buildTextSelectionVisual(
          'Drag to ',
          'select multiple words',
          ' in the text',
          Colors.deepPurple,
        ),
        SizedBox(height: 12),
        Text(
          '  Full line selection:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        buildTextSelectionVisual(
          '',
          'Triple-click selects the entire line of text for quick editing',
          '',
          Colors.green,
        ),
        SizedBox(height: 12),
        Text(
          '  Code selection:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(
                'var ',
                style: TextStyle(fontSize: 14, color: Colors.blue.shade300),
              ),
              Container(
                color: Colors.blue.withAlpha(60),
                child: Text(
                  'selectedText',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              Text(
                ' = getText();',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 4: Custom Action Toolbars
        buildSectionHeader('4. Custom Action Toolbars'),
        Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Text editing actions',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                Wrap(
                  children: [
                    buildActionChip(
                      'Bold',
                      Icons.format_bold,
                      Colors.deepPurple,
                    ),
                    buildActionChip(
                      'Italic',
                      Icons.format_italic,
                      Colors.deepPurple,
                    ),
                    buildActionChip(
                      'Underline',
                      Icons.format_underlined,
                      Colors.deepPurple,
                    ),
                    buildActionChip(
                      'Strikethrough',
                      Icons.strikethrough_s,
                      Colors.deepPurple,
                    ),
                    buildActionChip(
                      'Highlight',
                      Icons.highlight,
                      Colors.amber.shade700,
                    ),
                    buildActionChip('Link', Icons.link, Colors.blue),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Translation actions',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                Wrap(
                  children: [
                    buildActionChip('Translate', Icons.translate, Colors.green),
                    buildActionChip('Define', Icons.menu_book, Colors.brown),
                    buildActionChip(
                      'Web Search',
                      Icons.travel_explore,
                      Colors.blue,
                    ),
                    buildActionChip(
                      'Read Aloud',
                      Icons.volume_up,
                      Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Section 5: Toolbar with Grouped Actions
        buildSectionHeader('5. Grouped Action Toolbars'),
        Text(
          '  Clipboard + Format groups:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6),
        buildDividedToolbar(
          [
            [
              buildIconOnlyButton(Icons.content_cut, Colors.grey.shade700),
              buildIconOnlyButton(Icons.content_copy, Colors.grey.shade700),
              buildIconOnlyButton(Icons.content_paste, Colors.grey.shade700),
            ],
            [
              buildIconOnlyButton(
                Icons.format_bold,
                Colors.grey.shade700,
                isActive: true,
              ),
              buildIconOnlyButton(Icons.format_italic, Colors.grey.shade700),
              buildIconOnlyButton(
                Icons.format_underlined,
                Colors.grey.shade700,
              ),
            ],
          ],
          Colors.white,
          Colors.grey.shade300,
        ),
        SizedBox(height: 16),
        Text(
          '  Edit + Share groups:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6),
        buildDividedToolbar(
          [
            [
              buildIconOnlyButton(Icons.undo, Colors.grey.shade700),
              buildIconOnlyButton(Icons.redo, Colors.grey.shade700),
            ],
            [
              buildIconOnlyButton(Icons.content_cut, Colors.grey.shade700),
              buildIconOnlyButton(Icons.content_copy, Colors.grey.shade700),
              buildIconOnlyButton(Icons.content_paste, Colors.grey.shade700),
            ],
            [
              buildIconOnlyButton(Icons.share, Colors.blue.shade700),
              buildIconOnlyButton(Icons.more_horiz, Colors.grey.shade700),
            ],
          ],
          Colors.grey.shade50,
          Colors.grey.shade300,
        ),

        // Section 6: Overflow Menu Toolbar
        buildSectionHeader('6. Overflow Toolbar Pattern'),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Narrow width - shows overflow',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildIconOnlyButton(
                      Icons.content_cut,
                      Colors.grey.shade700,
                    ),
                    buildIconOnlyButton(
                      Icons.content_copy,
                      Colors.grey.shade700,
                    ),
                    buildIconOnlyButton(
                      Icons.content_paste,
                      Colors.grey.shade700,
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colors.grey.shade300,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                    ),
                    buildIconOnlyButton(Icons.more_vert, Colors.deepPurple),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Full width - all actions visible',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildToolbarButton(
                      'Cut',
                      Icons.content_cut,
                      Colors.grey.shade700,
                    ),
                    SizedBox(width: 4),
                    buildToolbarButton(
                      'Copy',
                      Icons.content_copy,
                      Colors.grey.shade700,
                    ),
                    SizedBox(width: 4),
                    buildToolbarButton(
                      'Paste',
                      Icons.content_paste,
                      Colors.grey.shade700,
                    ),
                    SizedBox(width: 4),
                    buildToolbarButton(
                      'Select All',
                      Icons.select_all,
                      Colors.grey.shade700,
                    ),
                    SizedBox(width: 4),
                    buildToolbarButton(
                      'Share',
                      Icons.share,
                      Colors.grey.shade700,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Section 7: Contextual Toolbar Variants
        buildSectionHeader('7. Contextual Toolbar Variants'),
        buildContextualToolbar(
          'Image selected',
          Icons.image,
          Colors.green.shade700,
          ['Copy Image', 'Save As', 'Open In Browser', 'Share'],
        ),
        buildContextualToolbar(
          'Link selected',
          Icons.link,
          Colors.blue.shade700,
          ['Open Link', 'Copy URL', 'Edit Link', 'Remove Link'],
        ),
        buildContextualToolbar(
          'Table cell selected',
          Icons.table_chart,
          Colors.orange.shade700,
          ['Insert Row', 'Insert Column', 'Delete Row', 'Merge Cells'],
        ),
        buildContextualToolbar(
          'Code block selected',
          Icons.code,
          Colors.purple.shade700,
          ['Copy Code', 'Format', 'Run', 'Wrap in Try/Catch'],
        ),

        // Section 8: Toolbar Animation States
        buildSectionHeader('8. Toolbar Appearance States'),
        buildToolbarState('Appearing (fade in)', 0.3, Colors.deepPurple),
        buildToolbarState('Partial (fade in)', 0.6, Colors.deepPurple),
        buildToolbarState('Full opacity', 1.0, Colors.deepPurple),
        buildToolbarState('Disappearing (fade out)', 0.4, Colors.grey),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of AdaptiveTextSelectionToolbar Demo',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
