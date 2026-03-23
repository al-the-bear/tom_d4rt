// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DropdownButtonHideUnderline from material
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

Widget buildDropdownWithUnderline(
  String label,
  List<String> items,
  String selectedValue,
  Color accentColor,
) {
  print('Building dropdown WITH underline: $label');
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
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'WITH underline',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          child: DropdownButton(
            value: selectedValue,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: accentColor),
            style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
            items: _buildDropdownItems(items),
            onChanged: (dynamic val) {},
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.visibility, size: 14, color: Colors.orange.shade600),
            SizedBox(width: 4),
            Text(
              'Default underline is visible',
              style: TextStyle(fontSize: 12, color: Colors.orange.shade700),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildDropdownHidden(
  String label,
  List<String> items,
  String selectedValue,
  Color accentColor,
) {
  print('Building dropdown WITHOUT underline: $label');
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
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'HIDDEN underline',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selectedValue,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: accentColor),
              style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
              items: _buildDropdownItems(items),
              onChanged: (dynamic val) {},
            ),
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.visibility_off, size: 14, color: Colors.green.shade600),
            SizedBox(width: 4),
            Text(
              'Underline hidden via DropdownButtonHideUnderline',
              style: TextStyle(fontSize: 12, color: Colors.green.shade700),
            ),
          ],
        ),
      ],
    ),
  );
}

List<DropdownMenuItem> _buildDropdownItems(List<String> items) {
  List<DropdownMenuItem> menuItems = [];
  int i = 0;
  for (i = 0; i < items.length; i = i + 1) {
    menuItems.add(DropdownMenuItem(value: items[i], child: Text(items[i])));
  }
  return menuItems;
}

Widget buildComparisonPanel(
  String title,
  List<String> items,
  String selected,
  Color color,
) {
  print('Building comparison panel: $title');
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
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'With Underline',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade700,
                          ),
                        ),
                        SizedBox(height: 8),
                        DropdownButton(
                          value: selected,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down, size: 20),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade800,
                          ),
                          items: _buildDropdownItems(items),
                          onChanged: (dynamic val) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Hidden Underline',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                        SizedBox(height: 8),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selected,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down, size: 20),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade800,
                            ),
                            items: _buildDropdownItems(items),
                            onChanged: (dynamic val) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildInCardContext(
  String label,
  List<String> items,
  String selected,
  Color cardColor,
) {
  print('Building dropdown in card context: $label');
  return Card(
    margin: EdgeInsets.symmetric(vertical: 8),
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.credit_card, color: cardColor),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: cardColor.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cardColor.withAlpha(60)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: selected,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down, color: cardColor),
                style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                items: _buildDropdownItems(items),
                onChanged: (dynamic val) {},
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Clean dropdown in card — no underline',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    ),
  );
}

Widget buildInAppBarContext() {
  print('Building dropdown in app bar context');
  List<String> navItems = ['Dashboard', 'Analytics', 'Reports', 'Settings'];
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.indigo.shade700,
            child: Row(
              children: [
                Icon(Icons.menu, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade600,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: 'Dashboard',
                        isExpanded: true,
                        dropdownColor: Colors.indigo.shade700,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white70,
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        items: _buildDropdownItems(navItems),
                        onChanged: (dynamic val) {},
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.notifications, color: Colors.white),
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey.shade100,
            child: Center(
              child: Text(
                'Page Content Area',
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildStyledContainerDropdowns() {
  print('Building styled container dropdowns');
  List<String> fruits = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  List<String> sizes = ['Small', 'Medium', 'Large', 'X-Large'];
  List<String> priorities = ['Low', 'Normal', 'High', 'Urgent'];

  List<MaterialColor> containerColors = [Colors.blue, Colors.teal, Colors.red];
  List<String> containerLabels = [
    'Category Selector',
    'Size Filter',
    'Priority Level',
  ];
  List<List<String>> containerItems = [fruits, sizes, priorities];
  List<String> containerSelected = ['Apple', 'Medium', 'Normal'];
  List<IconData> containerIcons = [
    Icons.category,
    Icons.straighten,
    Icons.flag,
  ];

  List<Widget> containers = [];
  int c = 0;
  for (c = 0; c < containerLabels.length; c = c + 1) {
    containers.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [containerColors[c].shade50, containerColors[c].shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: containerColors[c].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: containerColors[c].shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(containerIcons[c], color: Colors.white, size: 22),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    containerLabels[c],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: containerColors[c].shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: containerSelected[c],
                      isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: containerColors[c],
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                      ),
                      items: _buildDropdownItems(containerItems[c]),
                      onChanged: (dynamic val) {},
                    ),
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
          'Styled Container Dropdowns',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'DropdownButtonHideUnderline in custom containers',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: containers),
      ],
    ),
  );
}

Widget buildWidgetTreeDiagram() {
  print('Building widget tree diagram');
  List<String> layers = [
    'DropdownButtonHideUnderline',
    '  InheritedWidget (provides flag)',
    '    DropdownButton',
    '      InputDecorator (checks flag)',
    '        underline: hidden / shown',
  ];
  List<Color> layerColors = [
    Colors.indigo.shade700,
    Colors.indigo.shade500,
    Colors.indigo.shade400,
    Colors.indigo.shade300,
    Colors.indigo.shade200,
  ];
  List<Widget> layerWidgets = [];
  int l = 0;
  for (l = 0; l < layers.length; l = l + 1) {
    double indent = l * 16.0;
    layerWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.only(left: indent),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: layerColors[l],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            layers[l],
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
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
          'Widget Tree Diagram',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'How DropdownButtonHideUnderline works internally',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: layerWidgets,
        ),
      ],
    ),
  );
}

Widget buildHideUnderlineProperties() {
  print('Building properties table');
  List<String> propNames = [
    'child',
    'DropdownButtonHideUnderline.of()',
    'Behavior',
  ];
  List<String> propDescs = [
    'The DropdownButton widget to wrap',
    'Static method to check if underline should be hidden in context',
    'Uses InheritedWidget to propagate hide-underline flag down the tree',
  ];
  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color bg = (p % 2 == 0) ? Colors.indigo.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: bg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              child: Text(
                propNames[p],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                propDescs[p],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
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
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'DropdownButtonHideUnderline API',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('DropdownButtonHideUnderline deep demo test executing');

  List<String> colorItems = ['Red', 'Blue', 'Green', 'Yellow', 'Purple'];
  List<String> countryItems = ['USA', 'UK', 'Germany', 'France', 'Japan'];
  List<String> fontItems = [
    'Roboto',
    'Arial',
    'Helvetica',
    'Georgia',
    'Courier',
  ];

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DropdownButtonHideUnderline Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'DropdownButtonHideUnderline'),
            buildInfoCard(
              'Purpose',
              'An InheritedWidget to hide the underline of DropdownButton descendants',
            ),
            buildInfoCard(
              'Typical Use',
              'Wrap DropdownButton to remove its default underline',
            ),
            buildInfoCard(
              'Mechanism',
              'Propagates a flag via InheritedWidget context',
            ),

            buildSectionHeader('2. With Underline (Default)'),
            buildDropdownWithUnderline(
              'Color Selection',
              colorItems,
              'Red',
              Colors.red,
            ),
            buildDropdownWithUnderline(
              'Country Selection',
              countryItems,
              'USA',
              Colors.blue,
            ),

            buildSectionHeader('3. Hidden Underline'),
            buildDropdownHidden(
              'Color Selection',
              colorItems,
              'Red',
              Colors.red,
            ),
            buildDropdownHidden(
              'Country Selection',
              countryItems,
              'USA',
              Colors.blue,
            ),

            buildSectionHeader('4. Side-by-Side Comparison'),
            buildComparisonPanel(
              'Color Dropdown Comparison',
              colorItems,
              'Red',
              Colors.red,
            ),
            buildComparisonPanel(
              'Font Dropdown Comparison',
              fontItems,
              'Roboto',
              Colors.purple,
            ),

            buildSectionHeader('5. In Card Context'),
            buildInCardContext('Color Theme', colorItems, 'Blue', Colors.blue),
            buildInCardContext(
              'Font Family',
              fontItems,
              'Arial',
              Colors.purple,
            ),

            buildSectionHeader('6. In AppBar Context'),
            buildInAppBarContext(),

            buildSectionHeader('7. Styled Container Dropdowns'),
            buildStyledContainerDropdowns(),

            buildSectionHeader('8. Widget Tree Diagram'),
            buildWidgetTreeDiagram(),

            buildSectionHeader('9. API Reference'),
            buildHideUnderlineProperties(),

            buildSectionHeader('10. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Always wrap DropdownButton — not DropdownButtonFormField',
            ),
            buildInfoCard(
              'Tip 2',
              'Works via InheritedWidget — must be an ancestor',
            ),
            buildInfoCard(
              'Tip 3',
              'Useful in Cards and AppBars for cleaner look',
            ),
            buildInfoCard(
              'Tip 4',
              'Does not affect DropdownMenu or other dropdown types',
            ),
            buildInfoCard(
              'Tip 5',
              'Combine with custom Container borders for styled dropdowns',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('DropdownButtonHideUnderline deep demo completed');
  return result;
}
