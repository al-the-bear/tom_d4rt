// ignore_for_file: avoid_print
// D4rt test script: Tests MaterialTextSelectionControls from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.blue.shade700,
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

Widget buildDescriptionCard(String title, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue.shade600, size: 20),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget buildSelectableTextDemo(String label, String content, Color bgColor) {
  print('Building SelectableText demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, color: Colors.blue.shade600, size: 18),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SelectableText(
          content,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade800,
            height: 1.5,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Tap and drag to select text',
            style: TextStyle(fontSize: 11, color: Colors.blue.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget buildTextFieldDemo(String label, String hint, Color accentColor) {
  print('Building TextField demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: accentColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: accentColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: TextStyle(fontSize: 15),
          cursorColor: accentColor,
        ),
        SizedBox(height: 8),
        Text(
          'Selection handles appear when text is selected',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
      ],
    ),
  );
}

Widget buildStyledSelectableText(
  String text,
  TextStyle style,
  String description,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(text, style: style),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget buildColoredSelectionDemo(
  String title,
  Color containerColor,
  Color textColor,
) {
  print('Building colored selection demo: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: containerColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 12),
        SelectableText(
          'MaterialTextSelectionControls provides the selection handles and toolbar for copy/cut/paste operations. Try selecting this text to see the material-styled handles.',
          style: TextStyle(
            fontSize: 14,
            color: textColor.withAlpha(200),
            height: 1.5,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: textColor.withAlpha(50),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.touch_app, color: textColor, size: 12),
            ),
            SizedBox(width: 6),
            Text(
              'Long press to select',
              style: TextStyle(fontSize: 11, color: textColor.withAlpha(150)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildSelectionToolbarConceptCard(
  String toolName,
  IconData icon,
  Color color,
  String desc,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withAlpha(40),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                toolName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildHandleShapeCard(String shapeName, Color color, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(100)),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(20),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomPaint(painter: _HandleShapePainter(color)),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shapeName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSelectionAreaDemo() {
  print('Building SelectionArea demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.select_all, color: Colors.purple.shade600, size: 20),
            SizedBox(width: 8),
            Text(
              'SelectionArea Wrapping Multiple Children',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'First paragraph inside SelectionArea',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
              ),
              SizedBox(height: 8),
              Text(
                'Second paragraph with different content',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Content inside a container - also selectable',
                  style: TextStyle(fontSize: 13, color: Colors.purple.shade800),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'All text in this area can be selected together',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.purple.shade700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.purple.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'SelectionArea uses MaterialTextSelectionControls by default',
            style: TextStyle(fontSize: 11, color: Colors.purple.shade900),
          ),
        ),
      ],
    ),
  );
}

Widget buildInteractiveTextDemo() {
  print('Building interactive text selection demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.touch_app,
                color: Colors.indigo.shade600,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Interactive Text Selection Demo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.indigo.shade100),
          ),
          child: SelectableText(
            'This is a demonstration of MaterialTextSelectionControls in action. '
            'When you select text on a Material-design Flutter app, the selection '
            'handles that appear are provided by this class. The handles have a '
            'distinctive teardrop shape that follows Material Design guidelines.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              height: 1.6,
            ),
          ),
        ),
        SizedBox(height: 14),
        Row(
          children: [
            _buildFeatureBadge('Cut', Icons.content_cut, Colors.red),
            SizedBox(width: 8),
            _buildFeatureBadge('Copy', Icons.content_copy, Colors.blue),
            SizedBox(width: 8),
            _buildFeatureBadge('Paste', Icons.content_paste, Colors.green),
            SizedBox(width: 8),
            _buildFeatureBadge('Select All', Icons.select_all, Colors.orange),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Selection toolbar actions available in Material controls',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildFeatureBadge(String label, IconData icon, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildControlsOverviewGrid() {
  print('Building controls overview grid');
  List<Map<String, dynamic>> controlItems = [
    {
      'name': 'handleDragStart',
      'icon': Icons.swipe,
      'color': Colors.blue,
      'desc': 'Called when handle drag begins',
    },
    {
      'name': 'handleDragUpdate',
      'icon': Icons.pan_tool_alt,
      'color': Colors.green,
      'desc': 'Called during handle drag',
    },
    {
      'name': 'handleDragEnd',
      'icon': Icons.stop_circle_outlined,
      'color': Colors.orange,
      'desc': 'Called when handle drag ends',
    },
    {
      'name': 'buildHandle',
      'icon': Icons.crop_free,
      'color': Colors.purple,
      'desc': 'Creates selection handle widget',
    },
    {
      'name': 'buildToolbar',
      'icon': Icons.construction,
      'color': Colors.teal,
      'desc': 'Creates the toolbar overlay',
    },
    {
      'name': 'getHandleAnchor',
      'icon': Icons.anchor,
      'color': Colors.red,
      'desc': 'Returns handle anchor offset',
    },
  ];

  List<Widget> gridItems = [];
  int i = 0;
  for (i = 0; i < controlItems.length; i = i + 1) {
    Map<String, dynamic> item = controlItems[i];
    gridItems.add(
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (item['color'] as Color).withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: (item['color'] as Color).withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color,
                  size: 18,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item['name'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: item['color'] as Color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              item['desc'] as String,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  return Wrap(spacing: 8, runSpacing: 8, children: gridItems);
}

Widget buildRichTextSelectionDemo() {
  print('Building RichText selection demo');
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
            Icon(
              Icons.format_color_text,
              color: Colors.teal.shade600,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Rich Text Selection',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SelectableText.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'MaterialTextSelectionControls ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              TextSpan(
                text: 'extends ',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              TextSpan(
                text: 'TextSelectionControls ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              TextSpan(
                text: 'to provide the Material Design implementation for ',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              TextSpan(
                text: 'selection handles ',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.purple.shade600,
                ),
              ),
              TextSpan(
                text: 'and ',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              TextSpan(
                text: 'toolbar actions.',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.purple.shade600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.teal.shade600, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Rich text preserves formatting during selection',
                  style: TextStyle(fontSize: 12, color: Colors.teal.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('MaterialTextSelectionControls deep demo executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('MaterialTextSelectionControls Demo'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildDescriptionCard(
              'MaterialTextSelectionControls',
              'MaterialTextSelectionControls is the Material Design implementation of TextSelectionControls. '
                  'It provides the teardrop-shaped selection handles and the toolbar with cut, copy, paste, and select all actions. '
                  'This class is used by default in Material widgets like TextField and SelectableText.',
            ),
            buildInfoCard('Package', 'package:flutter/material.dart'),
            buildInfoCard('Extends', 'TextSelectionControls'),
            buildInfoCard('Handle Shape', 'Teardrop / Water droplet'),
            buildInfoCard('Toolbar Actions', 'Cut, Copy, Paste, Select All'),

            buildSectionHeader('2. SelectableText Default Behavior'),
            buildSelectableTextDemo(
              'Basic SelectableText',
              'This text is selectable. When you tap and drag, selection handles will appear. These handles follow the Material Design teardrop shape provided by MaterialTextSelectionControls.',
              Colors.white,
            ),
            buildSelectableTextDemo(
              'Multi-line Selection',
              'MaterialTextSelectionControls handles multi-line text selection seamlessly. '
                  'The selection can span multiple lines and the handles remain properly positioned '
                  'at the start and end of the selection.',
              Colors.blue.shade50,
            ),

            buildSectionHeader('3. TextField with Selection'),
            buildTextFieldDemo(
              'Primary TextField',
              'Type here to test selection...',
              Colors.blue,
            ),
            buildTextFieldDemo(
              'Secondary TextField',
              'Another input field example',
              Colors.green,
            ),
            buildTextFieldDemo(
              'Accent TextField',
              'Custom accent color styling',
              Colors.purple,
            ),

            buildSectionHeader('4. Multiple SelectableText Widgets'),
            buildStyledSelectableText(
              'Bold Selection Text',
              TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
              'FontWeight.bold applied',
            ),
            buildStyledSelectableText(
              'Italic Selection Text',
              TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade700,
              ),
              'FontStyle.italic applied',
            ),
            buildStyledSelectableText(
              'Large Font Selection',
              TextStyle(fontSize: 20, color: Colors.indigo.shade700),
              'Font size: 20',
            ),
            buildStyledSelectableText(
              'Letter Spaced Selection',
              TextStyle(
                fontSize: 16,
                letterSpacing: 2.0,
                color: Colors.teal.shade700,
              ),
              'Letter spacing: 2.0',
            ),
            buildStyledSelectableText(
              'Colored Selection Text',
              TextStyle(fontSize: 16, color: Colors.deepOrange.shade600),
              'Custom text color',
            ),

            buildSectionHeader('5. Colored Container Selection'),
            buildColoredSelectionDemo(
              'Light Blue Container',
              Colors.blue.shade100,
              Colors.blue.shade900,
            ),
            buildColoredSelectionDemo(
              'Amber Container',
              Colors.amber.shade100,
              Colors.amber.shade900,
            ),
            buildColoredSelectionDemo(
              'Green Container',
              Colors.green.shade100,
              Colors.green.shade900,
            ),
            buildColoredSelectionDemo(
              'Purple Container',
              Colors.purple.shade100,
              Colors.purple.shade900,
            ),

            buildSectionHeader('6. RichText with Selectable Content'),
            buildRichTextSelectionDemo(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Different Styles: ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    TextSpan(
                      text: 'Normal ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    TextSpan(
                      text: 'Bold ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    TextSpan(
                      text: 'Italic ',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    TextSpan(
                      text: 'Colored',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            buildSectionHeader('7. SelectionArea Wrapping'),
            buildSelectionAreaDemo(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.cyan.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SelectionArea Features',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan.shade800,
                    ),
                  ),
                  SizedBox(height: 10),
                  SelectionArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '- Wraps multiple Text widgets',
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '- Uses MaterialTextSelectionControls',
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '- Enables cross-widget selection',
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '- Provides unified toolbar',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            buildSectionHeader('8. Handle Shape Visualization'),
            buildHandleShapeCard(
              'Teardrop Handle',
              Colors.blue,
              'The default Material handle shape resembles a water droplet with a circular top tapering to a point.',
            ),
            buildHandleShapeCard(
              'Start Handle',
              Colors.green,
              'Left handle positioned at selection start, with droplet pointing right toward the text.',
            ),
            buildHandleShapeCard(
              'End Handle',
              Colors.orange,
              'Right handle at selection end, droplet pointing left. Both handles mirror each other.',
            ),
            buildHandleShapeCard(
              'Collapsed Handle',
              Colors.purple,
              'Single handle shown when cursor is positioned without selection (collapsed selection).',
            ),

            buildSectionHeader('9. Selection Toolbar Concepts'),
            buildSelectionToolbarConceptCard(
              'Cut',
              Icons.content_cut,
              Colors.red,
              'Removes selected text and copies to clipboard',
            ),
            buildSelectionToolbarConceptCard(
              'Copy',
              Icons.content_copy,
              Colors.blue,
              'Copies selected text to clipboard',
            ),
            buildSelectionToolbarConceptCard(
              'Paste',
              Icons.content_paste,
              Colors.green,
              'Inserts clipboard content at cursor',
            ),
            buildSelectionToolbarConceptCard(
              'Select All',
              Icons.select_all,
              Colors.orange,
              'Selects all text in the field',
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.grey.shade600,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Toolbar appears above or below selection based on available space',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            buildSectionHeader('10. Interactive Selection Demo'),
            buildInteractiveTextDemo(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Control Methods',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                  SizedBox(height: 12),
                  buildControlsOverviewGrid(),
                ],
              ),
            ),

            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'MaterialTextSelectionControls is the foundation for text selection in Material Flutter apps. '
                    'It provides consistent selection handles and toolbar actions across TextField, SelectableText, and SelectionArea widgets.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade300,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('MaterialTextSelectionControls deep demo completed');
  return result;
}

class _HandleShapePainter extends CustomPainter {
  Color color;
  _HandleShapePainter(this.color);

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    double cx = size.width / 2;
    double cy = size.height * 0.35;
    double radius = size.width / 4;

    canvas.drawCircle(Offset(cx, cy), radius, paint);

    Path path = Path();
    path.moveTo(cx - radius * 0.8, cy + radius * 0.3);
    path.quadraticBezierTo(
      cx,
      size.height * 0.85,
      cx + radius * 0.8,
      cy + radius * 0.3,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  bool shouldRepaint(_HandleShapePainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
