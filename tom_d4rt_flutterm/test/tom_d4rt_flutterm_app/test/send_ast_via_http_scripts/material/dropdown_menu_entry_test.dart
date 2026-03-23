// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DropdownMenuEntry from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.cyan.shade700,
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

Widget buildBasicDropdownMenu(String label, Color accentColor) {
  print('Building basic dropdown menu: $label');
  List<DropdownMenuEntry<String>> entries = [];
  entries.add(DropdownMenuEntry(value: 'apple', label: 'Apple'));
  entries.add(DropdownMenuEntry(value: 'banana', label: 'Banana'));
  entries.add(DropdownMenuEntry(value: 'cherry', label: 'Cherry'));
  entries.add(DropdownMenuEntry(value: 'date', label: 'Date'));
  entries.add(DropdownMenuEntry(value: 'elderberry', label: 'Elderberry'));

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
          'Simple string entries with labels',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        DropdownMenu(
          initialSelection: 'apple',
          dropdownMenuEntries: entries,
          label: Text('Select Fruit'),
          expandedInsets: EdgeInsets.zero,
        ),
      ],
    ),
  );
}

Widget buildDropdownMenuWithIcons(String label) {
  print('Building dropdown menu with icons: $label');
  List<DropdownMenuEntry<String>> entries = [];
  entries.add(
    DropdownMenuEntry(
      value: 'home',
      label: 'Home',
      leadingIcon: Icon(Icons.home, color: Colors.blue),
    ),
  );
  entries.add(
    DropdownMenuEntry(
      value: 'work',
      label: 'Work',
      leadingIcon: Icon(Icons.work, color: Colors.orange),
    ),
  );
  entries.add(
    DropdownMenuEntry(
      value: 'school',
      label: 'School',
      leadingIcon: Icon(Icons.school, color: Colors.green),
    ),
  );
  entries.add(
    DropdownMenuEntry(
      value: 'gym',
      label: 'Gym',
      leadingIcon: Icon(Icons.fitness_center, color: Colors.red),
    ),
  );
  entries.add(
    DropdownMenuEntry(
      value: 'park',
      label: 'Park',
      leadingIcon: Icon(Icons.park, color: Colors.teal),
    ),
  );

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
          'Entries with leading icons',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        DropdownMenu(
          initialSelection: 'home',
          dropdownMenuEntries: entries,
          label: Text('Select Place'),
          expandedInsets: EdgeInsets.zero,
          leadingIcon: Icon(Icons.place, color: Colors.cyan.shade700),
        ),
      ],
    ),
  );
}

Widget buildDropdownMenuWithTrailingIcons(String label) {
  print('Building dropdown menu with trailing icons: $label');
  List<DropdownMenuEntry<String>> entries = [];
  entries.add(
    DropdownMenuEntry(
      value: 'high',
      label: 'High Priority',
      trailingIcon: Icon(Icons.arrow_upward, color: Colors.red),
    ),
  );
  entries.add(
    DropdownMenuEntry(
      value: 'medium',
      label: 'Medium Priority',
      trailingIcon: Icon(Icons.remove, color: Colors.orange),
    ),
  );
  entries.add(
    DropdownMenuEntry(
      value: 'low',
      label: 'Low Priority',
      trailingIcon: Icon(Icons.arrow_downward, color: Colors.green),
    ),
  );
  entries.add(
    DropdownMenuEntry(
      value: 'none',
      label: 'No Priority',
      trailingIcon: Icon(Icons.block, color: Colors.grey),
    ),
  );

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
          'Entries with trailing icons for status indication',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        DropdownMenu(
          initialSelection: 'medium',
          dropdownMenuEntries: entries,
          label: Text('Priority'),
          expandedInsets: EdgeInsets.zero,
        ),
      ],
    ),
  );
}

Widget buildDropdownMenuWithDisabledEntries(String label) {
  print('Building dropdown menu with disabled entries: $label');
  List<DropdownMenuEntry<String>> entries = [];
  entries.add(DropdownMenuEntry(value: 'free', label: 'Free Plan'));
  entries.add(DropdownMenuEntry(value: 'basic', label: 'Basic Plan'));
  entries.add(
    DropdownMenuEntry(
      value: 'pro',
      label: 'Pro Plan (Coming Soon)',
      enabled: false,
    ),
  );
  entries.add(
    DropdownMenuEntry(
      value: 'enterprise',
      label: 'Enterprise (Contact Us)',
      enabled: false,
    ),
  );

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
          'Some entries disabled — not selectable',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        DropdownMenu(
          initialSelection: 'free',
          dropdownMenuEntries: entries,
          label: Text('Select Plan'),
          expandedInsets: EdgeInsets.zero,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.info_outline, size: 14, color: Colors.orange.shade600),
            SizedBox(width: 4),
            Text(
              'Disabled entries shown but not selectable',
              style: TextStyle(fontSize: 12, color: Colors.orange.shade700),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildDropdownMenuWithStyledEntries(String label) {
  print('Building dropdown menu with styled entries: $label');
  ButtonStyle greenStyle = ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.green.shade800),
    backgroundColor: WidgetStatePropertyAll(Colors.green.shade50),
  );
  ButtonStyle redStyle = ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.red.shade800),
    backgroundColor: WidgetStatePropertyAll(Colors.red.shade50),
  );
  ButtonStyle blueStyle = ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.blue.shade800),
    backgroundColor: WidgetStatePropertyAll(Colors.blue.shade50),
  );

  List<DropdownMenuEntry<String>> entries = [];
  entries.add(
    DropdownMenuEntry(
      value: 'active',
      label: 'Active',
      style: greenStyle,
      leadingIcon: Icon(Icons.check_circle, color: Colors.green),
    ),
  );
  entries.add(
    DropdownMenuEntry(
      value: 'inactive',
      label: 'Inactive',
      style: redStyle,
      leadingIcon: Icon(Icons.cancel, color: Colors.red),
    ),
  );
  entries.add(
    DropdownMenuEntry(
      value: 'pending',
      label: 'Pending',
      style: blueStyle,
      leadingIcon: Icon(Icons.pending, color: Colors.blue),
    ),
  );

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
          'Entries with custom ButtonStyle for visual differentiation',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        DropdownMenu(
          initialSelection: 'active',
          dropdownMenuEntries: entries,
          label: Text('Status'),
          expandedInsets: EdgeInsets.zero,
        ),
      ],
    ),
  );
}

Widget buildDropdownMenuEntryAnatomy() {
  print('Building entry anatomy');
  List<String> parts = [
    'value',
    'label',
    'leadingIcon',
    'trailingIcon',
    'enabled',
    'style',
  ];
  List<String> descriptions = [
    'The value returned when this entry is selected',
    'Display text shown in the menu and selected field',
    'Optional widget displayed before the label',
    'Optional widget displayed after the label',
    'Whether the entry can be selected (default: true)',
    'Custom ButtonStyle for the entry appearance',
  ];
  List<Color> partColors = [
    Colors.cyan.shade600,
    Colors.teal.shade600,
    Colors.blue.shade600,
    Colors.orange.shade600,
    Colors.purple.shade600,
    Colors.pink.shade600,
  ];

  List<Widget> anatomyRows = [];
  int a = 0;
  for (a = 0; a < parts.length; a = a + 1) {
    anatomyRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: partColors[a].withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: partColors[a].withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: partColors[a],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${a + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
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
                    parts[a],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: partColors[a],
                    ),
                  ),
                  Text(
                    descriptions[a],
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
          'DropdownMenuEntry Anatomy',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Properties of each entry in a DropdownMenu',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: anatomyRows),
      ],
    ),
  );
}

Widget buildDropdownInContainers() {
  print('Building dropdown in different containers');
  List<DropdownMenuEntry<String>> colorEntries = [];
  colorEntries.add(
    DropdownMenuEntry(
      value: 'red',
      label: 'Red',
      leadingIcon: Icon(Icons.circle, color: Colors.red, size: 16),
    ),
  );
  colorEntries.add(
    DropdownMenuEntry(
      value: 'blue',
      label: 'Blue',
      leadingIcon: Icon(Icons.circle, color: Colors.blue, size: 16),
    ),
  );
  colorEntries.add(
    DropdownMenuEntry(
      value: 'green',
      label: 'Green',
      leadingIcon: Icon(Icons.circle, color: Colors.green, size: 16),
    ),
  );
  colorEntries.add(
    DropdownMenuEntry(
      value: 'purple',
      label: 'Purple',
      leadingIcon: Icon(Icons.circle, color: Colors.purple, size: 16),
    ),
  );

  List<String> containerNames = ['Light Card', 'Dark Card', 'Bordered Panel'];
  List<Color> containerBgs = [
    Colors.white,
    Colors.grey.shade800,
    Colors.cyan.shade50,
  ];
  List<Color> containerBorders = [
    Colors.grey.shade200,
    Colors.grey.shade600,
    Colors.cyan.shade200,
  ];
  List<Color> textColors = [Colors.black87, Colors.white, Colors.cyan.shade800];

  List<Widget> containerWidgets = [];
  int c = 0;
  for (c = 0; c < containerNames.length; c = c + 1) {
    containerWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: containerBgs[c],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: containerBorders[c], width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              containerNames[c],
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: textColors[c],
              ),
            ),
            SizedBox(height: 12),
            DropdownMenu(
              initialSelection: 'red',
              dropdownMenuEntries: colorEntries,
              label: Text('Pick Color'),
              expandedInsets: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dropdown in Different Contexts',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Column(children: containerWidgets),
      ],
    ),
  );
}

Widget buildEntryConfigGrid() {
  print('Building entry configuration grid');
  List<String> configNames = [
    'Label Only',
    'With Leading Icon',
    'With Trailing Icon',
    'Both Icons',
    'Custom Style',
    'Disabled',
  ];
  List<String> configDescs = [
    'Basic entry with just text',
    'Icon before the label text',
    'Icon after the label text',
    'Icons on both sides',
    'Custom foreground/background',
    'Greyed out, not selectable',
  ];
  List<IconData> configIcons = [
    Icons.text_fields,
    Icons.arrow_back,
    Icons.arrow_forward,
    Icons.swap_horiz,
    Icons.palette,
    Icons.block,
  ];
  List<MaterialColor> configColors = [
    Colors.grey,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.grey,
  ];

  List<Widget> configCards = [];
  int g = 0;
  for (g = 0; g < configNames.length; g = g + 1) {
    configCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: configColors[g].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: configColors[g].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: configColors[g].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                configIcons[g],
                color: configColors[g].shade700,
                size: 22,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    configNames[g],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    configDescs[g],
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
          'Entry Configuration Types',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different ways to configure a DropdownMenuEntry',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: configCards),
      ],
    ),
  );
}

Widget buildDropdownMenuProperties() {
  print('Building properties table');
  List<String> propNames = [
    'value',
    'label',
    'leadingIcon',
    'trailingIcon',
    'enabled',
    'style',
    'labelWidget',
  ];
  List<String> propTypes = [
    'T',
    'String',
    'Widget',
    'Widget',
    'bool',
    'ButtonStyle',
    'Widget',
  ];
  List<String> propDescs = [
    'Generic value associated with this entry',
    'Display text for the entry',
    'Widget shown before the label',
    'Widget shown after the label',
    'Whether entry is selectable (default true)',
    'Custom ButtonStyle for this entry',
    'Custom widget to display instead of default label text',
  ];

  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color bg = (p % 2 == 0) ? Colors.cyan.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: bg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                propNames[p],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade800,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                propTypes[p],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
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
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'DropdownMenuEntry Properties',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('DropdownMenuEntry deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DropdownMenuEntry Deep Demo'),
        backgroundColor: Colors.cyan.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. DropdownMenuEntry Overview'),
            buildInfoCard('Class', 'DropdownMenuEntry<T>'),
            buildInfoCard(
              'Purpose',
              'Defines individual entries for a DropdownMenu widget',
            ),
            buildInfoCard('Generic', 'Parameterized on the value type T'),
            buildInfoCard(
              'Key Properties',
              'value, label, leadingIcon, trailingIcon, enabled, style',
            ),

            buildSectionHeader('2. Basic DropdownMenu'),
            buildBasicDropdownMenu('Simple Fruit Selector', Colors.cyan),

            buildSectionHeader('3. Entries with Leading Icons'),
            buildDropdownMenuWithIcons('Place Selector'),

            buildSectionHeader('4. Entries with Trailing Icons'),
            buildDropdownMenuWithTrailingIcons('Priority Selector'),

            buildSectionHeader('5. Disabled Entries'),
            buildDropdownMenuWithDisabledEntries('Plan Selection'),

            buildSectionHeader('6. Styled Entries'),
            buildDropdownMenuWithStyledEntries('Status Filter'),

            buildSectionHeader('7. Entry Anatomy'),
            buildDropdownMenuEntryAnatomy(),

            buildSectionHeader('8. Entry Configuration Types'),
            buildEntryConfigGrid(),

            buildSectionHeader('9. Different Container Contexts'),
            buildDropdownInContainers(),

            buildSectionHeader('10. API Properties'),
            buildDropdownMenuProperties(),

            buildSectionHeader('11. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Use typed generic parameter for type safety',
            ),
            buildInfoCard(
              'Tip 2',
              'Leading icons help users identify entries quickly',
            ),
            buildInfoCard('Tip 3', 'Trailing icons indicate status or action'),
            buildInfoCard(
              'Tip 4',
              'Disable entries instead of removing them for consistent UX',
            ),
            buildInfoCard(
              'Tip 5',
              'Use ButtonStyle to color-code entries by category',
            ),
            buildInfoCard(
              'Tip 6',
              'DropdownMenuEntry is immutable — create new instances for updates',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('DropdownMenuEntry deep demo completed');
  return result;
}
