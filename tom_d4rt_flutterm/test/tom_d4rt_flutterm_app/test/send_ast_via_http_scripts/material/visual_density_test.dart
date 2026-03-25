// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests VisualDensity from material
import 'package:flutter/material.dart';

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

Widget buildDensityCard(String name, VisualDensity density, Color accentColor) {
  print('Building density card: $name');
  double horizontal = density.horizontal;
  double vertical = density.vertical;
  Offset baseSizeAdjustment = density.baseSizeAdjustment;

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor, width: 2),
      boxShadow: [
        BoxShadow(
          color: accentColor.withAlpha(40),
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
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Horizontal:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    horizontal.toStringAsFixed(1),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vertical:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    vertical.toStringAsFixed(1),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Base Size Adjustment:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '(${baseSizeAdjustment.dx.toStringAsFixed(1)}, ${baseSizeAdjustment.dy.toStringAsFixed(1)})',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildStandardDensitySection() {
  print('Building standard density section');
  VisualDensity standardDensity = VisualDensity.standard;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildDensityCard('VisualDensity.standard', standardDensity, Colors.blue),
      SizedBox(height: 8),
      buildInfoCard(
        'Description',
        'The default density for visual components.',
      ),
      buildInfoCard('Horizontal Value', '${standardDensity.horizontal}'),
      buildInfoCard('Vertical Value', '${standardDensity.vertical}'),
      buildInfoCard(
        'Use Case',
        'General purpose default spacing for most applications.',
      ),
    ],
  );
}

Widget buildCompactDensitySection() {
  print('Building compact density section');
  VisualDensity compactDensity = VisualDensity.compact;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildDensityCard('VisualDensity.compact', compactDensity, Colors.orange),
      SizedBox(height: 8),
      buildInfoCard(
        'Description',
        'Reduces spacing to fit more content on screen.',
      ),
      buildInfoCard('Horizontal Value', '${compactDensity.horizontal}'),
      buildInfoCard('Vertical Value', '${compactDensity.vertical}'),
      buildInfoCard(
        'Use Case',
        'Data-dense interfaces, desktop applications, power users.',
      ),
      Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.compress, color: Colors.orange),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Compact density uses minimum values to reduce spacing',
                style: TextStyle(color: Colors.orange.shade800),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildComfortableDensitySection() {
  print('Building comfortable density section');
  VisualDensity comfortableDensity = VisualDensity.comfortable;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildDensityCard(
        'VisualDensity.comfortable',
        comfortableDensity,
        Colors.green,
      ),
      SizedBox(height: 8),
      buildInfoCard(
        'Description',
        'Increases spacing for touch-friendly interfaces.',
      ),
      buildInfoCard('Horizontal Value', '${comfortableDensity.horizontal}'),
      buildInfoCard('Vertical Value', '${comfortableDensity.vertical}'),
      buildInfoCard(
        'Use Case',
        'Touch interfaces, accessibility, mobile devices.',
      ),
      Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.touch_app, color: Colors.green),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Comfortable density provides larger touch targets',
                style: TextStyle(color: Colors.green.shade800),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildMinimumMaximumDensitySection() {
  print('Building minimum/maximum density section');
  double minDensity = VisualDensity.minimumDensity;
  double maxDensity = VisualDensity.maximumDensity;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade100, Colors.blue.shade100],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_downward, color: Colors.red, size: 32),
                        SizedBox(height: 8),
                        Text(
                          'Minimum Density',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$minDensity',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_upward, color: Colors.blue, size: 32),
                        SizedBox(height: 8),
                        Text(
                          'Maximum Density',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$maxDensity',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      buildInfoCard(
        'Minimum',
        'VisualDensity.minimumDensity = $minDensity (most compact)',
      ),
      buildInfoCard(
        'Maximum',
        'VisualDensity.maximumDensity = $maxDensity (most spacious)',
      ),
      buildInfoCard(
        'Range',
        'Values from $minDensity to $maxDensity are valid',
      ),
    ],
  );
}

Widget buildHorizontalVerticalPropertiesSection() {
  print('Building horizontal/vertical properties section');

  List<Map<String, dynamic>> densityConfigs = [
    {'h': -4.0, 'v': 0.0, 'label': 'Compact Horizontal Only'},
    {'h': 0.0, 'v': -4.0, 'label': 'Compact Vertical Only'},
    {'h': 4.0, 'v': 0.0, 'label': 'Spacious Horizontal Only'},
    {'h': 0.0, 'v': 4.0, 'label': 'Spacious Vertical Only'},
    {'h': -2.0, 'v': -2.0, 'label': 'Slightly Compact Both'},
    {'h': 2.0, 'v': 2.0, 'label': 'Slightly Spacious Both'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...densityConfigs.map((config) {
        double h = config['h'] as double;
        double v = config['v'] as double;
        String label = config['label'] as String;

        VisualDensity customDensity = VisualDensity(horizontal: h, vertical: v);

        Color cardColor = h < 0 || v < 0 ? Colors.orange : Colors.teal;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cardColor.withAlpha(100)),
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: cardColor.withAlpha(40),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    'H:${h.toInt()}\nV:${v.toInt()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cardColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Adjustment: ${customDensity.baseSizeAdjustment}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    ],
  );
}

Widget buildBaseSizeAdjustmentSection() {
  print('Building base size adjustment section');

  List<VisualDensity> densities = [
    VisualDensity.compact,
    VisualDensity.standard,
    VisualDensity.comfortable,
    VisualDensity(horizontal: -3.0, vertical: -1.0),
    VisualDensity(horizontal: 2.0, vertical: 3.0),
  ];

  List<String> names = [
    'Compact',
    'Standard',
    'Comfortable',
    'Custom (-3, -1)',
    'Custom (2, 3)',
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard(
        'baseSizeAdjustment',
        'Returns an Offset representing size modifications',
      ),
      SizedBox(height: 12),
      ...List.generate(densities.length, (index) {
        VisualDensity d = densities[index];
        Offset adjustment = d.baseSizeAdjustment;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(names[index], style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'dx: ${adjustment.dx.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'dy: ${adjustment.dy.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    ],
  );
}

Widget buildEffectiveConstraintsSection() {
  print('Building effective constraints section');

  BoxConstraints baseConstraints = BoxConstraints(
    minWidth: 88,
    minHeight: 36,
    maxWidth: 200,
    maxHeight: 48,
  );

  List<VisualDensity> densities = [
    VisualDensity.compact,
    VisualDensity.standard,
    VisualDensity.comfortable,
  ];

  List<String> names = ['Compact', 'Standard', 'Comfortable'];
  List<Color> colors = [Colors.orange, Colors.blue, Colors.green];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
              'Base Constraints:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('minWidth: ${baseConstraints.minWidth}'),
            Text('minHeight: ${baseConstraints.minHeight}'),
            Text('maxWidth: ${baseConstraints.maxWidth}'),
            Text('maxHeight: ${baseConstraints.maxHeight}'),
          ],
        ),
      ),
      SizedBox(height: 16),
      ...List.generate(densities.length, (index) {
        VisualDensity d = densities[index];
        BoxConstraints effective = d.effectiveConstraints(baseConstraints);

        return Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors[index].withAlpha(30),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors[index]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${names[index]} Density',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colors[index],
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'minWidth: ${effective.minWidth.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'minHeight: ${effective.minHeight.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'maxWidth: ${effective.maxWidth.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'maxHeight: ${effective.maxHeight.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    ],
  );
}

Widget buildButtonDensitySection() {
  print('Building button density section');

  List<VisualDensity> densities = [
    VisualDensity.compact,
    VisualDensity.standard,
    VisualDensity.comfortable,
  ];

  List<String> names = ['Compact', 'Standard', 'Comfortable'];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(densities.length, (index) {
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
                '${names[index]} Buttons',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      visualDensity: densities[index],
                    ),
                    child: Text('Elevated'),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      visualDensity: densities[index],
                    ),
                    child: Text('Outlined'),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      visualDensity: densities[index],
                    ),
                    child: Text('Text'),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add, size: 18),
                    label: Text('Add'),
                    style: ElevatedButton.styleFrom(
                      visualDensity: densities[index],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit, size: 18),
                    label: Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      visualDensity: densities[index],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    ],
  );
}

Widget buildTextFieldDensitySection() {
  print('Building text field density section');

  List<VisualDensity> densities = [
    VisualDensity.compact,
    VisualDensity.standard,
    VisualDensity.comfortable,
  ];

  List<String> names = ['Compact', 'Standard', 'Comfortable'];
  List<Color> colors = [Colors.orange, Colors.blue, Colors.green];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(densities.length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors[index].withAlpha(15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors[index].withAlpha(100)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      names[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  isDense: densities[index] == VisualDensity.compact,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter email',
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.check_circle),
                  border: OutlineInputBorder(),
                  isDense: densities[index] == VisualDensity.compact,
                ),
              ),
            ],
          ),
        );
      }),
    ],
  );
}

Widget buildIconDensitySection() {
  print('Building icon density section');

  List<VisualDensity> densities = [
    VisualDensity.compact,
    VisualDensity.standard,
    VisualDensity.comfortable,
  ];

  List<String> names = ['Compact', 'Standard', 'Comfortable'];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(densities.length, (index) {
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
                '${names[index]} Icon Buttons',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.home),
                    visualDensity: densities[index],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite),
                    visualDensity: densities[index],
                    color: Colors.red,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings),
                    visualDensity: densities[index],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                    visualDensity: densities[index],
                    color: Colors.amber,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    visualDensity: densities[index],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton.filled(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    visualDensity: densities[index],
                  ),
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                    visualDensity: densities[index],
                  ),
                  IconButton.outlined(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    visualDensity: densities[index],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    ],
  );
}

Widget buildListDensitySection() {
  print('Building list density section');

  List<VisualDensity> densities = [
    VisualDensity.compact,
    VisualDensity.standard,
    VisualDensity.comfortable,
  ];

  List<String> names = ['Compact', 'Standard', 'Comfortable'];
  List<Color> colors = [Colors.orange, Colors.blue, Colors.green];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(densities.length, (index) {
        double verticalPadding = 4 + (densities[index].vertical + 4) * 2;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors[index]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors[index].withAlpha(30),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(11),
                    topRight: Radius.circular(11),
                  ),
                ),
                child: Text(
                  '${names[index]} List (padding: ${verticalPadding.toStringAsFixed(0)})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors[index],
                  ),
                ),
              ),
              ListTile(
                visualDensity: densities[index],
                leading: CircleAvatar(
                  backgroundColor: colors[index],
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                title: Text('John Doe'),
                subtitle: Text('john.doe@email.com'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(height: 1),
              ListTile(
                visualDensity: densities[index],
                leading: CircleAvatar(
                  backgroundColor: colors[index].withAlpha(150),
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                title: Text('Jane Smith'),
                subtitle: Text('jane.smith@email.com'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(height: 1),
              ListTile(
                visualDensity: densities[index],
                leading: CircleAvatar(
                  backgroundColor: colors[index].withAlpha(100),
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                title: Text('Bob Wilson'),
                subtitle: Text('bob.wilson@email.com'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        );
      }),
    ],
  );
}

Widget buildDensityComparisonGrid() {
  print('Building density comparison grid');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 80),
            Expanded(
              child: Center(
                child: Text(
                  'Compact',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Standard',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Comfortable',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                'Horizontal',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Center(child: Text('${VisualDensity.compact.horizontal}')),
            ),
            Expanded(
              child: Center(
                child: Text('${VisualDensity.standard.horizontal}'),
              ),
            ),
            Expanded(
              child: Center(
                child: Text('${VisualDensity.comfortable.horizontal}'),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                'Vertical',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Center(child: Text('${VisualDensity.compact.vertical}')),
            ),
            Expanded(
              child: Center(child: Text('${VisualDensity.standard.vertical}')),
            ),
            Expanded(
              child: Center(
                child: Text('${VisualDensity.comfortable.vertical}'),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildAdaptiveDensitySection() {
  print('Building adaptive density section');

  VisualDensity adaptiveForDesktop = VisualDensity.adaptivePlatformDensity;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard(
        'adaptivePlatformDensity',
        'Automatically selects density based on platform',
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.indigo.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.devices, color: Colors.indigo),
                SizedBox(width: 8),
                Text(
                  'Platform Adaptive Density',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Current Platform Density:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 4),
            Text(
              'Horizontal: ${adaptiveForDesktop.horizontal}',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            Text(
              'Vertical: ${adaptiveForDesktop.vertical}',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.amber.shade700),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Desktop platforms use compact, mobile uses comfortable',
                style: TextStyle(color: Colors.amber.shade900),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildCustomDensityShowcase() {
  print('Building custom density showcase');

  List<Map<String, dynamic>> customDensities = [
    {'h': -4.0, 'v': -4.0, 'name': 'Ultra Compact'},
    {'h': -2.0, 'v': -2.0, 'name': 'Slightly Compact'},
    {'h': 0.0, 'v': 0.0, 'name': 'Zero Adjustment'},
    {'h': 1.0, 'v': 1.0, 'name': 'Slightly Spacious'},
    {'h': 4.0, 'v': 4.0, 'name': 'Ultra Spacious'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...customDensities.map((config) {
        double h = config['h'] as double;
        double v = config['v'] as double;
        String name = config['name'] as String;

        VisualDensity density = VisualDensity(horizontal: h, vertical: v);
        double fraction = (h + 4) / 8;
        Color barColor = Color.lerp(Colors.orange, Colors.green, fraction)!;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: barColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '(${h.toInt()}, ${v.toInt()})',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: barColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  widthFactor: fraction,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  visualDensity: density,
                  backgroundColor: barColor,
                ),
                child: Text('Sample Button'),
              ),
            ],
          ),
        );
      }),
    ],
  );
}

Widget buildCopyWithSection() {
  print('Building copyWith section');

  VisualDensity original = VisualDensity.standard;
  VisualDensity modified1 = original.copyWith(horizontal: -2.0);
  VisualDensity modified2 = original.copyWith(vertical: 2.0);
  VisualDensity modified3 = original.copyWith(horizontal: -2.0, vertical: 2.0);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard(
        'copyWith()',
        'Creates a copy with specified properties changed',
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.cyan.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Original (standard):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'horizontal: ${original.horizontal}, vertical: ${original.vertical}',
            ),
            SizedBox(height: 12),
            Text(
              'copyWith(horizontal: -2.0):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'horizontal: ${modified1.horizontal}, vertical: ${modified1.vertical}',
            ),
            SizedBox(height: 12),
            Text(
              'copyWith(vertical: 2.0):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'horizontal: ${modified2.horizontal}, vertical: ${modified2.vertical}',
            ),
            SizedBox(height: 12),
            Text(
              'copyWith(horizontal: -2.0, vertical: 2.0):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'horizontal: ${modified3.horizontal}, vertical: ${modified3.vertical}',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildLerpSection() {
  print('Building lerp section');

  VisualDensity start = VisualDensity.compact;
  VisualDensity end = VisualDensity.comfortable;

  List<double> tValues = [0.0, 0.25, 0.5, 0.75, 1.0];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard(
        'lerp()',
        'Linearly interpolates between two VisualDensity values',
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.pink.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interpolating from compact to comfortable:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ...tValues.map((t) {
              VisualDensity interpolated = VisualDensity.lerp(start, end, t);
              double h = interpolated.horizontal;
              double v = interpolated.vertical;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('t = ${t.toStringAsFixed(2)}'),
                    Text(
                      'h: ${h.toStringAsFixed(1)}, v: ${v.toStringAsFixed(1)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget buildDensityVisualization() {
  print('Building density visualization');

  return Container(
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
          'Visual Density Scale',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text('-4', style: TextStyle(fontSize: 12, color: Colors.orange)),
            Expanded(
              child: Container(
                height: 24,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.grey, Colors.green],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Compact',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Standard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        'Comfortable',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text('+4', style: TextStyle(fontSize: 12, color: Colors.green)),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 4),
                Text('Tight', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 4),
                Text('Normal', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 4),
                Text('Spacious', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('Starting VisualDensity deep demo');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('VisualDensity Deep Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. VisualDensity.standard'),
            buildStandardDensitySection(),

            buildSectionHeader('2. VisualDensity.compact'),
            buildCompactDensitySection(),

            buildSectionHeader('3. VisualDensity.comfortable'),
            buildComfortableDensitySection(),

            buildSectionHeader('4. Minimum & Maximum Density'),
            buildMinimumMaximumDensitySection(),

            buildSectionHeader('5. Horizontal & Vertical Properties'),
            buildHorizontalVerticalPropertiesSection(),

            buildSectionHeader('6. baseSizeAdjustment'),
            buildBaseSizeAdjustmentSection(),

            buildSectionHeader('7. effectiveConstraints'),
            buildEffectiveConstraintsSection(),

            buildSectionHeader('8. Applying Density to Buttons'),
            buildButtonDensitySection(),

            buildSectionHeader('9. Applying Density to TextFields'),
            buildTextFieldDensitySection(),

            buildSectionHeader('10. Applying Density to Icons'),
            buildIconDensitySection(),

            buildSectionHeader('11. Applying Density to Lists'),
            buildListDensitySection(),

            buildSectionHeader('12. Density Comparison Grid'),
            buildDensityComparisonGrid(),

            buildSectionHeader('13. Adaptive Platform Density'),
            buildAdaptiveDensitySection(),

            buildSectionHeader('14. Custom Density Showcase'),
            buildCustomDensityShowcase(),

            buildSectionHeader('15. copyWith Method'),
            buildCopyWithSection(),

            buildSectionHeader('16. lerp Method'),
            buildLerpSection(),

            buildSectionHeader('17. Density Visualization'),
            buildDensityVisualization(),

            buildSectionHeader('18. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Use VisualDensity.adaptivePlatformDensity for cross-platform apps',
            ),
            buildInfoCard(
              'Tip 2',
              'Compact density is ideal for data-heavy desktop interfaces',
            ),
            buildInfoCard(
              'Tip 3',
              'Comfortable density improves touch target sizes on mobile',
            ),
            buildInfoCard(
              'Tip 4',
              'Set density in theme data to apply globally',
            ),
            buildInfoCard(
              'Tip 5',
              'Use effectiveConstraints to calculate adjusted sizes',
            ),
            buildInfoCard(
              'Tip 6',
              'Negative values reduce spacing, positive values increase it',
            ),
            buildInfoCard(
              'Tip 7',
              'The range is from -4 (minimum) to +4 (maximum)',
            ),
            buildInfoCard(
              'Tip 8',
              'baseSizeAdjustment multiplies density by 4 for pixel adjustments',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('VisualDensity deep demo completed');
  return result;
}
