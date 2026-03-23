// ignore_for_file: avoid_print
// D4rt test script: Tests DropdownMenuItem from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  debugPrint('Section: $title');
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

Widget _buildInfoCard(String label, String value) {
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

Widget _buildBasicTextItems() {
  debugPrint('Building basic text dropdown items');
  String selectedValue = 'Apple';
  List<String> fruits = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  List<DropdownMenuItem<String>> items = [];
  for (int i = 0; i < fruits.length; i = i + 1) {
    String fruit = fruits[i];
    items.add(
      DropdownMenuItem<String>(
        value: fruit,
        child: Text(fruit, style: TextStyle(fontSize: 16)),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Text DropdownMenuItems',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            underline: SizedBox(),
            items: items,
            onChanged: (String? value) {
              debugPrint('Selected: $value');
            },
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Five fruit options in a simple text dropdown',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildIconAndTextItems() {
  debugPrint('Building icon+text dropdown items');
  List<String> labels = ['Home', 'Work', 'School', 'Gym', 'Park'];
  List<IconData> icons = [
    Icons.home,
    Icons.work,
    Icons.school,
    Icons.fitness_center,
    Icons.park,
  ];
  List<Color> iconColors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.teal,
  ];
  List<DropdownMenuItem<String>> items = [];
  for (int i = 0; i < labels.length; i = i + 1) {
    items.add(
      DropdownMenuItem<String>(
        value: labels[i],
        child: Row(
          children: [
            Icon(icons[i], color: iconColors[i], size: 20),
            SizedBox(width: 10),
            Text(labels[i], style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icon + Text DropdownMenuItems',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: 'Home',
            isExpanded: true,
            underline: SizedBox(),
            items: items,
            onChanged: (String? value) {
              debugPrint('Selected location: $value');
            },
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Each item has an icon and label',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildCustomChildItems() {
  debugPrint('Building custom child dropdown items');
  List<String> names = ['Alice', 'Bob', 'Charlie'];
  List<String> roles = ['Designer', 'Developer', 'Manager'];
  List<Color> avatarColors = [Colors.purple, Colors.blue, Colors.green];
  List<DropdownMenuItem<String>> items = [];
  for (int i = 0; i < names.length; i = i + 1) {
    items.add(
      DropdownMenuItem<String>(
        value: names[i],
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: avatarColors[i],
                child: Text(
                  names[i].substring(0, 1),
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    names[i],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    roles[i],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Rich Child Items',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: 'Alice',
            isExpanded: true,
            underline: SizedBox(),
            items: items,
            onChanged: (String? value) {
              debugPrint('Selected person: $value');
            },
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Each item shows avatar, name, and role',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildEnabledDisabledComparison() {
  debugPrint('Building enabled/disabled items comparison');
  List<String> options = [
    'Active A',
    'Disabled B',
    'Active C',
    'Disabled D',
    'Active E',
  ];
  List<bool> enabledStates = [true, false, true, false, true];
  List<DropdownMenuItem<String>> items = [];
  for (int i = 0; i < options.length; i = i + 1) {
    items.add(
      DropdownMenuItem<String>(
        value: options[i],
        enabled: enabledStates[i],
        child: Text(
          options[i],
          style: TextStyle(
            fontSize: 15,
            color: enabledStates[i] ? Colors.black : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enabled vs Disabled Items',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: 'Active A',
            isExpanded: true,
            underline: SizedBox(),
            items: items,
            onChanged: (String? value) {
              debugPrint('Selected: $value');
            },
          ),
        ),
        SizedBox(height: 8),
        _buildStatusRow('Active A', true),
        _buildStatusRow('Disabled B', false),
        _buildStatusRow('Active C', true),
        _buildStatusRow('Disabled D', false),
        _buildStatusRow('Active E', true),
      ],
    ),
  );
}

Widget _buildStatusRow(String label, bool enabled) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Icon(
          enabled ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: enabled ? Colors.green : Colors.red.shade300,
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: enabled ? Colors.black : Colors.grey.shade400,
          ),
        ),
        SizedBox(width: 8),
        Text(
          enabled ? 'enabled' : 'disabled',
          style: TextStyle(
            fontSize: 11,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCustomAlignmentItems() {
  debugPrint('Building custom alignment items');
  List<String> alignLabels = [
    'Left Aligned',
    'Center Aligned',
    'Right Aligned',
  ];
  List<Alignment> alignments = [
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
  ];
  List<DropdownMenuItem<String>> items = [];
  for (int i = 0; i < alignLabels.length; i = i + 1) {
    items.add(
      DropdownMenuItem<String>(
        value: alignLabels[i],
        alignment: alignments[i],
        child: Text(alignLabels[i], style: TextStyle(fontSize: 15)),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Alignment DropdownMenuItems',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: 'Left Aligned',
            isExpanded: true,
            underline: SizedBox(),
            items: items,
            onChanged: (String? value) {
              debugPrint('Aligned selection: $value');
            },
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Items have different alignment within the dropdown',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildDifferentHeightItems() {
  debugPrint('Building different height items');
  List<String> sizes = ['Small', 'Medium', 'Large', 'Extra Large'];
  List<double> heights = [36.0, 48.0, 64.0, 80.0];
  List<Color> colors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
  ];
  List<DropdownMenuItem<String>> items = [];
  for (int i = 0; i < sizes.length; i = i + 1) {
    items.add(
      DropdownMenuItem<String>(
        value: sizes[i],
        child: Container(
          height: heights[i],
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 8),
          color: colors[i],
          child: Text(sizes[i], style: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items with Different Heights',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.brown.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: 'Small',
            isExpanded: true,
            underline: SizedBox(),
            items: items,
            onChanged: (String? value) {
              debugPrint('Size selected: $value');
            },
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Height catalog:',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        SizedBox(height: 4),
        _buildHeightIndicator('Small', 36.0, Colors.blue.shade200),
        _buildHeightIndicator('Medium', 48.0, Colors.green.shade200),
        _buildHeightIndicator('Large', 64.0, Colors.orange.shade200),
        _buildHeightIndicator('Extra Large', 80.0, Colors.purple.shade200),
      ],
    ),
  );
}

Widget _buildHeightIndicator(String label, double height, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: height,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '$label - ${height.toInt()}px',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget _buildColoredBackgroundItems() {
  debugPrint('Building colored background items');
  List<String> colorNames = ['Red', 'Green', 'Blue', 'Amber', 'Teal', 'Purple'];
  List<Color> bgColors = [
    Colors.red.shade50,
    Colors.green.shade50,
    Colors.blue.shade50,
    Colors.amber.shade50,
    Colors.teal.shade50,
    Colors.purple.shade50,
  ];
  List<Color> textColors = [
    Colors.red.shade800,
    Colors.green.shade800,
    Colors.blue.shade800,
    Colors.amber.shade800,
    Colors.teal.shade800,
    Colors.purple.shade800,
  ];
  List<DropdownMenuItem<String>> items = [];
  for (int i = 0; i < colorNames.length; i = i + 1) {
    items.add(
      DropdownMenuItem<String>(
        value: colorNames[i],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bgColors[i],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            colorNames[i],
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColors[i],
            ),
          ),
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Colored Background Items',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: 'Red',
            isExpanded: true,
            underline: SizedBox(),
            items: items,
            onChanged: (String? value) {
              debugPrint('Color selected: $value');
            },
          ),
        ),
        SizedBox(height: 12),
        _buildColorSwatchRow('Red', Colors.red.shade50, Colors.red.shade800),
        _buildColorSwatchRow(
          'Green',
          Colors.green.shade50,
          Colors.green.shade800,
        ),
        _buildColorSwatchRow('Blue', Colors.blue.shade50, Colors.blue.shade800),
        _buildColorSwatchRow(
          'Amber',
          Colors.amber.shade50,
          Colors.amber.shade800,
        ),
        _buildColorSwatchRow('Teal', Colors.teal.shade50, Colors.teal.shade800),
        _buildColorSwatchRow(
          'Purple',
          Colors.purple.shade50,
          Colors.purple.shade800,
        ),
      ],
    ),
  );
}

Widget _buildColorSwatchRow(String label, Color bg, Color fg) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 14,
          decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: fg, width: 1),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 12, color: fg)),
      ],
    ),
  );
}

Widget _buildPaddingVariationItems() {
  debugPrint('Building padding variation items');
  List<String> paddingLabels = [
    'No Padding',
    'Small Padding',
    'Medium Padding',
    'Large Padding',
  ];
  List<EdgeInsets> paddings = [
    EdgeInsets.zero,
    EdgeInsets.all(4),
    EdgeInsets.all(12),
    EdgeInsets.all(20),
  ];
  List<DropdownMenuItem<String>> items = [];
  for (int i = 0; i < paddingLabels.length; i = i + 1) {
    items.add(
      DropdownMenuItem<String>(
        value: paddingLabels[i],
        child: Container(
          padding: paddings[i],
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(paddingLabels[i], style: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items with Padding Variations',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyan.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: 'No Padding',
            isExpanded: true,
            underline: SizedBox(),
            items: items,
            onChanged: (String? value) {
              debugPrint('Padding option: $value');
            },
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Each item has different internal padding',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildPropertiesSummary() {
  debugPrint('Building DropdownMenuItem properties summary');
  List<String> propNames = ['value', 'child', 'enabled', 'alignment', 'onTap'];
  List<String> propDescs = [
    'The value this item represents when selected',
    'The widget displayed as the item content',
    'Whether this item can be selected (default true)',
    'How the child is aligned within the item',
    'Callback when the item is tapped',
  ];
  List<IconData> propIcons = [
    Icons.data_object,
    Icons.widgets,
    Icons.toggle_on,
    Icons.format_align_left,
    Icons.touch_app,
  ];
  List<Widget> rows = [];
  for (int i = 0; i < propNames.length; i = i + 1) {
    rows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(propIcons[i], size: 20, color: Colors.teal.shade600),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    propNames[i],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    propDescs[i],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows),
  );
}

dynamic build(BuildContext context) {
  print('DropdownMenuItem deep demo test executing');
  debugPrint('=== DropdownMenuItem Visual Demo ===');
  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DropdownMenuItem Deep Demo'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Basic Text Items'),
            _buildBasicTextItems(),
            SizedBox(height: 16),
            _buildSectionHeader('2. Icon + Text Items'),
            _buildIconAndTextItems(),
            SizedBox(height: 16),
            _buildSectionHeader('3. Custom Rich Child Items'),
            _buildCustomChildItems(),
            SizedBox(height: 16),
            _buildSectionHeader('4. Enabled vs Disabled Items'),
            _buildEnabledDisabledComparison(),
            SizedBox(height: 16),
            _buildSectionHeader('5. Custom Alignment'),
            _buildCustomAlignmentItems(),
            SizedBox(height: 16),
            _buildSectionHeader('6. Different Heights'),
            _buildDifferentHeightItems(),
            SizedBox(height: 16),
            _buildSectionHeader('7. Colored Backgrounds'),
            _buildColoredBackgroundItems(),
            SizedBox(height: 16),
            _buildSectionHeader('8. Padding Variations'),
            _buildPaddingVariationItems(),
            SizedBox(height: 16),
            _buildSectionHeader('9. Properties Reference'),
            _buildPropertiesSummary(),
            SizedBox(height: 32),
            _buildInfoCard('Widget', 'DropdownMenuItem<T>'),
            _buildInfoCard('Package', 'package:flutter/material.dart'),
            _buildInfoCard(
              'Purpose',
              'An item in a menu created by a DropdownButton',
            ),
            _buildInfoCard(
              'Key Properties',
              'value, child, enabled, alignment, onTap',
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
  print('DropdownMenuItem deep demo completed');
  return result;
}
