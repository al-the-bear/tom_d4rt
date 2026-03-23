// ignore_for_file: avoid_print
// D4rt test script: Tests MaterialTextSelectionHandleControls from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
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
      border: Border.all(color: Colors.teal.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withAlpha(20),
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
            Icon(Icons.info_outline, color: Colors.teal.shade600, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
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

Widget buildSelectableTextWithHandles(
  String label,
  String content,
  Color bgColor,
) {
  print('Building SelectableText with handle controls: $label');
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
            Icon(Icons.text_fields, color: Colors.teal.shade600, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
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
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.touch_app, color: Colors.teal.shade600, size: 14),
              SizedBox(width: 4),
              Text(
                'Handles appear on selection - no toolbar',
                style: TextStyle(fontSize: 11, color: Colors.teal.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTextFieldWithHandles(String label, String hint, Color accentColor) {
  print('Building TextField with handle controls: $label');
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
          'Selection handles visible when text is selected',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
      ],
    ),
  );
}

Widget buildHandleShapeCard(
  String shapeName,
  Color color,
  String description,
  IconData icon,
) {
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
          child: CustomPaint(painter: _TeardropHandlePainter(color)),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 16),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      shapeName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
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

Widget buildThemeHandleColorDemo(
  String themeName,
  Color handleColor,
  Color backgroundColor,
) {
  print('Building theme handle color demo: $themeName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: handleColor.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: handleColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: CustomPaint(painter: _SmallTeardropPainter(Colors.white)),
            ),
            SizedBox(width: 12),
            Text(
              themeName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: handleColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            hintText: 'Type to see selection handles...',
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          style: TextStyle(fontSize: 14),
          cursorColor: handleColor,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: handleColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6),
            Text(
              'Handle color: ${handleColor.toString().split('(')[1].split(')')[0]}',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildSelectionAreaWithHandles() {
  print('Building SelectionArea with handle controls');
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
              'SelectionArea with Handle Controls',
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
                'MaterialTextSelectionHandleControls is used here',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'This provides only selection handles without the toolbar overlay.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'All text in this area can be selected with teardrop handles',
                  style: TextStyle(fontSize: 13, color: Colors.purple.shade800),
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
            'Handles appear but no cut/copy/paste toolbar',
            style: TextStyle(fontSize: 11, color: Colors.purple.shade900),
          ),
        ),
      ],
    ),
  );
}

Widget buildTextScaleDemo(String scaleName, double textScale, Color color) {
  print('Building text scale demo: $scaleName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              scaleName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Scale: ${textScale}x',
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
          child: SelectableText(
            'Handle sizes adjust with text scale',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            CustomPaint(
              size: Size(20 * textScale, 24 * textScale),
              painter: _ScaledHandlePainter(color, textScale),
            ),
            SizedBox(width: 8),
            Text(
              'Handle preview at ${textScale}x',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildComparisonCard(
  String controlType,
  bool hasToolbar,
  Color color,
  List<String> features,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              hasToolbar ? Icons.build : Icons.drag_handle,
              color: color,
              size: 20,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                controlType,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: hasToolbar
                    ? Colors.green.shade100
                    : Colors.orange.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                hasToolbar ? 'Full' : 'Handles Only',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: hasToolbar
                      ? Colors.green.shade800
                      : Colors.orange.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildFeatureList(features, color),
        ),
      ],
    ),
  );
}

List<Widget> _buildFeatureList(List<String> features, Color color) {
  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < features.length; i = i + 1) {
    items.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Icon(Icons.check_circle_outline, color: color, size: 14),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                features[i],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return items;
}

Widget buildInteractiveSelectionDemo() {
  print('Building interactive selection demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.cyan.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.touch_app,
                color: Colors.cyan.shade600,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Interactive Selection Demo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade800,
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
            border: Border.all(color: Colors.cyan.shade100),
          ),
          child: SelectableText(
            'MaterialTextSelectionHandleControls provides the teardrop-shaped selection '
            'handles without the selection toolbar. This is useful when you want users '
            'to be able to select text visually but do not need cut, copy, or paste '
            'actions available in the overlay.',
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
            _buildDemoActionBadge('Select', Icons.text_fields, Colors.teal),
            SizedBox(width: 8),
            _buildDemoActionBadge('Drag', Icons.swipe, Colors.blue),
            SizedBox(width: 8),
            _buildDemoActionBadge('Adjust', Icons.tune, Colors.purple),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Only handle interactions - no toolbar overlay appears',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildDemoActionBadge(String label, IconData icon, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildHandleMethodsGrid() {
  print('Building handle methods grid');
  List<Map<String, dynamic>> methods = [
    {
      'name': 'buildHandle',
      'icon': Icons.crop_free,
      'color': Colors.teal,
      'desc': 'Creates teardrop handle widget',
    },
    {
      'name': 'getHandleSize',
      'icon': Icons.straighten,
      'color': Colors.blue,
      'desc': 'Returns handle dimensions',
    },
    {
      'name': 'getHandleAnchor',
      'icon': Icons.anchor,
      'color': Colors.orange,
      'desc': 'Handle attachment point offset',
    },
    {
      'name': 'handleDragStart',
      'icon': Icons.swipe,
      'color': Colors.purple,
      'desc': 'Called when drag begins',
    },
    {
      'name': 'handleDragUpdate',
      'icon': Icons.pan_tool_alt,
      'color': Colors.green,
      'desc': 'Called during drag motion',
    },
    {
      'name': 'handleDragEnd',
      'icon': Icons.stop_circle_outlined,
      'color': Colors.red,
      'desc': 'Called when drag completes',
    },
  ];

  List<Widget> gridItems = [];
  int i = 0;
  for (i = 0; i < methods.length; i = i + 1) {
    Map<String, dynamic> method = methods[i];
    gridItems.add(
      Container(
        width: 150,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 8, right: 8),
        decoration: BoxDecoration(
          color: (method['color'] as Color).withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: (method['color'] as Color).withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  method['icon'] as IconData,
                  color: method['color'] as Color,
                  size: 16,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    method['name'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: method['color'] as Color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              method['desc'] as String,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  return Wrap(children: gridItems);
}

Widget buildMultiFieldDemo() {
  print('Building multi-field demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multiple Text Fields with Handles',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 14),
        _buildStyledTextField('Name', Icons.person, Colors.blue),
        SizedBox(height: 10),
        _buildStyledTextField('Email', Icons.email, Colors.green),
        SizedBox(height: 10),
        _buildStyledTextField('Message', Icons.message, Colors.orange),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.indigo.shade600, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Each field shows handles on text selection',
                  style: TextStyle(fontSize: 11, color: Colors.indigo.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStyledTextField(String label, IconData icon, Color color) {
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: color),
      prefixIcon: Icon(icon, color: color, size: 20),
      filled: true,
      fillColor: color.withAlpha(10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color.withAlpha(80)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color.withAlpha(60)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    ),
    style: TextStyle(fontSize: 14),
    cursorColor: color,
  );
}

dynamic build(BuildContext context) {
  print('MaterialTextSelectionHandleControls deep demo executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.teal,
        selectionColor: Colors.teal.withAlpha(60),
        selectionHandleColor: Colors.teal,
      ),
    ),
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('MaterialTextSelectionHandleControls'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview - Handle-Only Controls'),
            buildDescriptionCard(
              'MaterialTextSelectionHandleControls',
              'MaterialTextSelectionHandleControls is a variant of text selection controls that '
                  'provides only the selection handles without the selection toolbar. Unlike '
                  'MaterialTextSelectionControls which includes cut, copy, and paste buttons, '
                  'this class focuses solely on the visual selection indicators - the teardrop-shaped '
                  'handles that allow users to adjust text selection boundaries.',
            ),
            buildInfoCard('Package', 'package:flutter/material.dart'),
            buildInfoCard('Extends', 'TextSelectionControls'),
            buildInfoCard('Key Feature', 'Handles only - no toolbar overlay'),
            buildInfoCard(
              'Use Case',
              'Read-only display with visual selection feedback',
            ),

            buildSectionHeader('2. SelectableText with Handles'),
            buildSelectableTextWithHandles(
              'Basic SelectableText',
              'This text demonstrates MaterialTextSelectionHandleControls in action. '
                  'When you select this text by long-pressing and dragging, you will see '
                  'the teardrop-shaped selection handles appear at the selection boundaries. '
                  'Notice that no toolbar with cut/copy/paste appears.',
              Colors.white,
            ),
            buildSelectableTextWithHandles(
              'Paragraph Text Selection',
              'MaterialTextSelectionHandleControls is particularly useful for scenarios '
                  'where you want users to be able to visually select text but do not need '
                  'clipboard operations. This creates a cleaner user experience when selection '
                  'is primarily for visual feedback or read-only content.',
              Colors.grey.shade50,
            ),
            buildSelectableTextWithHandles(
              'Rich Content Display',
              'In content-heavy applications, using handle-only controls reduces visual '
                  'clutter. The handles provide clear indication of selection boundaries while '
                  'keeping the interface minimal. The Material Design teardrop shape is instantly '
                  'recognizable to users.',
              Colors.teal.shade50,
            ),

            buildSectionHeader('3. TextField with Selection Handles'),
            buildTextFieldWithHandles(
              'Primary Input Field',
              'Type and select text to see handles...',
              Colors.teal,
            ),
            buildTextFieldWithHandles(
              'Secondary Input Field',
              'Another example with different styling...',
              Colors.blue,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: Colors.amber.shade700,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Selection handles appear when you select text within the field',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            buildSectionHeader('4. Handle Shape - Teardrop Design'),
            buildHandleShapeCard(
              'Teardrop Shape',
              Colors.teal,
              'The Material Design handle has a distinctive water-droplet shape with a circular top that tapers to a point.',
              Icons.water_drop,
            ),
            buildHandleShapeCard(
              'Start Handle (Left)',
              Colors.green,
              'Positioned at selection start, the droplet points toward the selected text with the tail on the right side.',
              Icons.keyboard_arrow_left,
            ),
            buildHandleShapeCard(
              'End Handle (Right)',
              Colors.orange,
              'At selection end, the handle mirrors the start - droplet points left with tail pointing right.',
              Icons.keyboard_arrow_right,
            ),
            buildHandleShapeCard(
              'Collapsed Handle',
              Colors.purple,
              'When the cursor has no selection (collapsed), a single handle appears below the cursor position.',
              Icons.vertical_align_bottom,
            ),

            buildSectionHeader('5. Handle Color via Theme'),
            buildDescriptionCard(
              'Theme-Based Customization',
              'Handle color is controlled through TextSelectionThemeData.selectionHandleColor. '
                  'This ensures consistent styling across all text selection interactions in your app.',
            ),
            buildThemeHandleColorDemo(
              'Teal Theme',
              Colors.teal,
              Colors.teal.shade50,
            ),
            buildThemeHandleColorDemo(
              'Blue Theme',
              Colors.blue,
              Colors.blue.shade50,
            ),
            buildThemeHandleColorDemo(
              'Deep Purple Theme',
              Colors.deepPurple,
              Colors.deepPurple.shade50,
            ),
            buildThemeHandleColorDemo(
              'Pink Theme',
              Colors.pink,
              Colors.pink.shade50,
            ),

            buildSectionHeader('6. Multiple Fields with Different Styles'),
            buildMultiFieldDemo(),
            Container(
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
                    'Form with Unified Handle Style',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),

            buildSectionHeader('7. SelectionArea with Handles'),
            buildSelectionAreaWithHandles(),
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
                  Row(
                    children: [
                      Icon(Icons.layers, color: Colors.cyan.shade700, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Nested SelectionArea',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SelectionArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Header text in selection area',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Body text that can also be selected along with the header.',
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Footer text completing the selectable region.',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            buildSectionHeader('8. Handle Sizes at Text Scales'),
            buildDescriptionCard(
              'Accessibility - Text Scaling',
              'Handle sizes automatically adjust based on text scale factor, ensuring '
                  'that selection handles remain proportional and accessible at larger text sizes.',
            ),
            buildTextScaleDemo('Small (0.8x)', 0.8, Colors.blue),
            buildTextScaleDemo('Normal (1.0x)', 1.0, Colors.teal),
            buildTextScaleDemo('Large (1.2x)', 1.2, Colors.orange),
            buildTextScaleDemo('Extra Large (1.5x)', 1.5, Colors.red),

            buildSectionHeader('9. Handle-Only vs Full Controls'),
            buildDescriptionCard(
              'Comparison',
              'Understanding when to use MaterialTextSelectionHandleControls vs '
                  'MaterialTextSelectionControls helps create the right user experience.',
            ),
            buildComparisonCard(
              'MaterialTextSelectionHandleControls',
              false,
              Colors.teal,
              [
                'Teardrop handles at selection boundaries',
                'No toolbar overlay appears',
                'Cleaner visual experience',
                'Suitable for read-only content',
                'Minimal UI footprint',
              ],
            ),
            buildComparisonCard(
              'MaterialTextSelectionControls',
              true,
              Colors.blue,
              [
                'Same teardrop handles',
                'Includes selection toolbar',
                'Cut, Copy, Paste, Select All actions',
                'Full editing capabilities',
                'Standard Material behavior',
              ],
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
                    Icons.compare_arrows,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Choose based on whether clipboard actions are needed',
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
            buildInteractiveSelectionDemo(),
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
                    'Handle Control Methods',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                  SizedBox(height: 12),
                  buildHandleMethodsGrid(),
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
                    'MaterialTextSelectionHandleControls provides selection handles without the toolbar. '
                    'It uses the same Material Design teardrop handles but omits cut/copy/paste actions. '
                    'Ideal for read-only content, visual selection feedback, and minimal UI requirements.',
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

  print('MaterialTextSelectionHandleControls deep demo completed');
  return result;
}

class _TeardropHandlePainter extends CustomPainter {
  Color color;
  _TeardropHandlePainter(this.color);

  @override
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

  @override
  bool shouldRepaint(_TeardropHandlePainter oldDelegate) {
    return color != oldDelegate.color;
  }
}

class _SmallTeardropPainter extends CustomPainter {
  Color color;
  _SmallTeardropPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    double cx = size.width / 2;
    double cy = size.height * 0.38;
    double radius = size.width / 5;

    canvas.drawCircle(Offset(cx, cy), radius, paint);

    Path path = Path();
    path.moveTo(cx - radius * 0.7, cy + radius * 0.2);
    path.quadraticBezierTo(
      cx,
      size.height * 0.8,
      cx + radius * 0.7,
      cy + radius * 0.2,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SmallTeardropPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}

class _ScaledHandlePainter extends CustomPainter {
  Color color;
  double scale;
  _ScaledHandlePainter(this.color, this.scale);

  @override
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

  @override
  bool shouldRepaint(_ScaledHandlePainter oldDelegate) {
    return color != oldDelegate.color || scale != oldDelegate.scale;
  }
}
