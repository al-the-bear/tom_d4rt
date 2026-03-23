// ignore_for_file: avoid_print
// D4rt test script: Tests VerticalDivider from material
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

Widget buildBasicVerticalDividerInRow(String label, double width) {
  print('Building basic vertical divider in row: $label');
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
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Width: $width',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Left Content',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                VerticalDivider(width: width),
                Expanded(
                  child: Center(
                    child: Text(
                      'Right Content',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildVerticalDividerWithThickness(
  String label,
  double thickness,
  Color color,
) {
  print('Building vertical divider with thickness: $label');
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
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Thickness: $thickness, Color: $color',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  child: Center(child: Text('Item A')),
                ),
                VerticalDivider(thickness: thickness, color: color),
                Container(
                  width: 80,
                  child: Center(child: Text('Item B')),
                ),
                VerticalDivider(thickness: thickness, color: color),
                Container(
                  width: 80,
                  child: Center(child: Text('Item C')),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildVerticalDividerWithIndent(
  String label,
  double indent,
  double endIndent,
) {
  print('Building vertical divider with indent: $label');
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
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Indent: $indent, EndIndent: $endIndent',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.green.shade100,
                    child: Center(
                      child: Text(
                        'Section 1',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(
                  indent: indent,
                  endIndent: endIndent,
                  thickness: 2,
                  color: Colors.blue.shade700,
                ),
                Expanded(
                  child: Container(
                    color: Colors.orange.shade100,
                    child: Center(
                      child: Text(
                        'Section 2',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildColoredVerticalDivider(String label, Color color, double width) {
  print('Building colored vertical divider: $label');
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
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
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
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.home, size: 28),
                ),
                VerticalDivider(color: color, width: width, thickness: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.settings, size: 28),
                ),
                VerticalDivider(color: color, width: width, thickness: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.person, size: 28),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildToolbarWithDividers(String label, List<IconData> icons) {
  print('Building toolbar with dividers: $label');
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
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildToolbarItems(icons),
            ),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildToolbarItems(List<IconData> icons) {
  List<Widget> items = [];
  for (int i = 0; i < icons.length; i++) {
    items.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Icon(icons[i], color: Colors.white, size: 24),
      ),
    );
    if (i < icons.length - 1) {
      items.add(
        VerticalDivider(
          color: Colors.grey.shade500,
          width: 20,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
      );
    }
  }
  return items;
}

Widget buildDividerComparison() {
  print('Building divider comparison section');
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
          'Horizontal vs Vertical Dividers',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Horizontal Divider (for Column layouts):',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text('Top Content'),
              Divider(color: Colors.blue, thickness: 2),
              Text('Bottom Content'),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Vertical Divider (for Row layouts):',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 8),
        Container(
          height: 60,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Left Content'),
                VerticalDivider(color: Colors.green, thickness: 2, width: 32),
                Text('Right Content'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildButtonBarWithDividers(String label) {
  print('Building button bar with dividers: $label');
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
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('Cancel'),
                ),
                VerticalDivider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Reset'),
                ),
                VerticalDivider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Submit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildVerticalDividerWithCustomHeight(
  String label,
  double containerHeight,
  Color backgroundColor,
) {
  print('Building vertical divider with height: $label');
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
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Container height: $containerHeight',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          height: containerHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 24),
                        SizedBox(height: 4),
                        Text('Featured'),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey.shade700,
                  thickness: 1,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.trending_up, size: 24),
                        SizedBox(height: 4),
                        Text('Trending'),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey.shade700,
                  thickness: 1,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.new_releases, size: 24),
                        SizedBox(height: 4),
                        Text('New'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildMultipleDividersShowcase() {
  print('Building multiple dividers showcase');
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
          'Multiple Dividers in Sequence',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberedCell('1'),
                VerticalDivider(color: Colors.purple, thickness: 1),
                _buildNumberedCell('2'),
                VerticalDivider(color: Colors.purple, thickness: 1),
                _buildNumberedCell('3'),
                VerticalDivider(color: Colors.purple, thickness: 1),
                _buildNumberedCell('4'),
                VerticalDivider(color: Colors.purple, thickness: 1),
                _buildNumberedCell('5'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildNumberedCell(String number) {
  return Container(
    width: 40,
    child: Center(
      child: Text(
        number,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.purple.shade700,
        ),
      ),
    ),
  );
}

Widget buildNavigationBarWithDividers() {
  print('Building navigation bar with dividers');
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
          'Navigation Bar Example',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.teal.shade700,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'App Title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.teal.shade400,
                  width: 24,
                  thickness: 1,
                  indent: 12,
                  endIndent: 12,
                ),
                _buildNavItem('Home'),
                VerticalDivider(
                  color: Colors.teal.shade400,
                  width: 16,
                  thickness: 1,
                  indent: 12,
                  endIndent: 12,
                ),
                _buildNavItem('Products'),
                VerticalDivider(
                  color: Colors.teal.shade400,
                  width: 16,
                  thickness: 1,
                  indent: 12,
                  endIndent: 12,
                ),
                _buildNavItem('About'),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.menu, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildNavItem(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
  );
}

Widget buildDividerThicknessVariations() {
  print('Building divider thickness variations');
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
          'Thickness Variations',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildThicknessLabel('1px'),
                VerticalDivider(thickness: 1, color: Colors.amber.shade800),
                _buildThicknessLabel('2px'),
                VerticalDivider(thickness: 2, color: Colors.amber.shade800),
                _buildThicknessLabel('3px'),
                VerticalDivider(thickness: 3, color: Colors.amber.shade800),
                _buildThicknessLabel('4px'),
                VerticalDivider(thickness: 4, color: Colors.amber.shade800),
                _buildThicknessLabel('5px'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildThicknessLabel(String text) {
  return Container(
    width: 40,
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.amber.shade900,
        ),
      ),
    ),
  );
}

Widget buildStyledCardWithDivider() {
  print('Building styled card with divider');
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
          'Styled Info Card',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan.shade100, Colors.cyan.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.cyan.shade200,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Statistics',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan.shade900,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '1,234 users',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.cyan.shade400,
                  thickness: 2,
                  indent: 16,
                  endIndent: 16,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Growth',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan.shade900,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                              size: 20,
                            ),
                            Text(
                              '+12%',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildFormFieldSeparators() {
  print('Building form field separators');
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
          'Form Layout With Dividers',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _buildFormField('First Name', Icons.person),
                ),
                VerticalDivider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                  indent: 4,
                  endIndent: 4,
                ),
                Expanded(
                  child: _buildFormField('Last Name', Icons.person_outline),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildFormField('Email', Icons.email),
                ),
                VerticalDivider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                  indent: 4,
                  endIndent: 4,
                ),
                Expanded(
                  child: _buildFormField('Phone', Icons.phone),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFormField(String label, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        SizedBox(height: 4),
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
      ],
    ),
  );
}

Widget main() {
  print('Starting VerticalDivider deep demo');

  Widget result = MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('VerticalDivider Deep Demo'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoCard(
              'Widget',
              'VerticalDivider - A vertical line separator between elements in a Row',
            ),
            buildInfoCard(
              'Purpose',
              'Creates visual separation between horizontally arranged widgets',
            ),

            buildSectionHeader('1. Basic VerticalDivider in Row'),
            buildInfoCard(
              'Usage',
              'VerticalDivider must be placed in a Row with IntrinsicHeight wrapper',
            ),
            buildBasicVerticalDividerInRow('Default Divider', 16),
            buildBasicVerticalDividerInRow('Narrow Width', 8),
            buildBasicVerticalDividerInRow('Wide Width', 32),
            buildBasicVerticalDividerInRow('Minimal Width', 1),

            buildSectionHeader('2. Width Property'),
            buildInfoCard(
              'Width',
              'Controls the total horizontal space the divider occupies',
            ),
            buildBasicVerticalDividerInRow('Width: 10', 10),
            buildBasicVerticalDividerInRow('Width: 20', 20),
            buildBasicVerticalDividerInRow('Width: 40', 40),
            buildBasicVerticalDividerInRow('Width: 60', 60),

            buildSectionHeader('3. Thickness Property'),
            buildInfoCard(
              'Thickness',
              'The actual width of the line drawn',
            ),
            buildVerticalDividerWithThickness(
              'Thickness: 1px',
              1,
              Colors.red,
            ),
            buildVerticalDividerWithThickness(
              'Thickness: 2px',
              2,
              Colors.blue,
            ),
            buildVerticalDividerWithThickness(
              'Thickness: 4px',
              4,
              Colors.green,
            ),
            buildDividerThicknessVariations(),

            buildSectionHeader('4. Indent Properties'),
            buildInfoCard(
              'indent',
              'Space at the top of the divider',
            ),
            buildInfoCard(
              'endIndent',
              'Space at the bottom of the divider',
            ),
            buildVerticalDividerWithIndent('No Indent', 0, 0),
            buildVerticalDividerWithIndent('Top Indent: 20', 20, 0),
            buildVerticalDividerWithIndent('Bottom Indent: 20', 0, 20),
            buildVerticalDividerWithIndent('Both Indents: 15', 15, 15),
            buildVerticalDividerWithIndent('Large Indents: 30', 30, 30),

            buildSectionHeader('5. Color Customization'),
            buildInfoCard(
              'color',
              'Sets the color of the divider line',
            ),
            buildColoredVerticalDivider('Red Divider', Colors.red, 24),
            buildColoredVerticalDivider('Blue Divider', Colors.blue, 24),
            buildColoredVerticalDivider('Green Divider', Colors.green, 24),
            buildColoredVerticalDivider('Orange Divider', Colors.orange, 24),
            buildColoredVerticalDivider('Purple Divider', Colors.purple, 24),
            buildColoredVerticalDivider('Teal Divider', Colors.teal, 24),

            buildSectionHeader('6. Divider vs VerticalDivider'),
            buildDividerComparison(),
            buildInfoCard(
              'Divider',
              'Used in Column layouts - creates horizontal line',
            ),
            buildInfoCard(
              'VerticalDivider',
              'Used in Row layouts - creates vertical line',
            ),

            buildSectionHeader('7. VerticalDivider in ButtonBar'),
            buildButtonBarWithDividers('Action Button Group'),
            buildButtonBarWithDividers('Dialog Actions'),

            buildSectionHeader('8. Toolbar Layouts'),
            buildToolbarWithDividers(
              'Edit Toolbar',
              [Icons.undo, Icons.redo, Icons.cut, Icons.copy, Icons.paste],
            ),
            buildToolbarWithDividers(
              'Format Toolbar',
              [
                Icons.format_bold,
                Icons.format_italic,
                Icons.format_underline,
              ],
            ),
            buildToolbarWithDividers(
              'Media Toolbar',
              [Icons.image, Icons.videocam, Icons.audiotrack, Icons.link],
            ),
            buildNavigationBarWithDividers(),

            buildSectionHeader('9. Different Heights'),
            buildVerticalDividerWithCustomHeight(
              'Small Container',
              80,
              Colors.grey.shade100,
            ),
            buildVerticalDividerWithCustomHeight(
              'Medium Container',
              120,
              Colors.blue.shade50,
            ),
            buildVerticalDividerWithCustomHeight(
              'Large Container',
              160,
              Colors.green.shade50,
            ),

            buildSectionHeader('10. Advanced Examples'),
            buildMultipleDividersShowcase(),
            buildStyledCardWithDivider(),
            buildFormFieldSeparators(),

            buildSectionHeader('Best Practices'),
            buildInfoCard(
              'Tip 1',
              'Always wrap Row in IntrinsicHeight for VerticalDivider to render',
            ),
            buildInfoCard(
              'Tip 2',
              'Use width to control spacing around the line',
            ),
            buildInfoCard(
              'Tip 3',
              'Use thickness to control the visual weight of the line',
            ),
            buildInfoCard(
              'Tip 4',
              'indent and endIndent create whitespace at top and bottom',
            ),
            buildInfoCard(
              'Tip 5',
              'Match divider color with your app theme for consistency',
            ),
            buildInfoCard(
              'Tip 6',
              'Use dividers sparingly to avoid visual clutter',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('VerticalDivider deep demo completed');
  return result;
}
