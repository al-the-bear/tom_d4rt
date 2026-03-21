// D4rt test script: Tests DropdownMenuFormField from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.amber.shade800,
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

List<DropdownMenuEntry<String>> buildStringEntries(List<String> labels) {
  List<DropdownMenuEntry<String>> entries = [];
  int i = 0;
  for (i = 0; i < labels.length; i = i + 1) {
    entries.add(DropdownMenuEntry(value: labels[i], label: labels[i]));
  }
  return entries;
}

List<DropdownMenuEntry<String>> buildIconEntries(
  List<String> labels,
  List<IconData> icons,
  List<Color> colors,
) {
  List<DropdownMenuEntry<String>> entries = [];
  int i = 0;
  for (i = 0; i < labels.length; i = i + 1) {
    entries.add(
      DropdownMenuEntry(
        value: labels[i],
        label: labels[i],
        leadingIcon: Icon(icons[i], color: colors[i], size: 20),
      ),
    );
  }
  return entries;
}

Widget buildBasicFormField(
  String label,
  String hint,
  List<String> items,
  String initialValue,
) {
  print('Building basic form field: $label');
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
        Text(hint, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        SizedBox(height: 12),
        DropdownMenu(
          initialSelection: initialValue,
          dropdownMenuEntries: buildStringEntries(items),
          label: Text(label),
          hintText: hint,
          expandedInsets: EdgeInsets.zero,
        ),
      ],
    ),
  );
}

Widget buildFormFieldWithDecoration(
  String label,
  Color borderColor,
  Color fillColor,
) {
  print('Building form field with decoration: $label');
  List<String> items = ['Option A', 'Option B', 'Option C', 'Option D'];
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
          'Custom border and fill decoration',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        DropdownMenu(
          initialSelection: 'Option A',
          dropdownMenuEntries: buildStringEntries(items),
          label: Text(label),
          expandedInsets: EdgeInsets.zero,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor, width: 3),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildFormWithMultipleFields() {
  print('Building form with multiple dropdown fields');
  List<String> countries = [
    'United States',
    'United Kingdom',
    'Germany',
    'France',
    'Japan',
  ];
  List<String> cities = ['New York', 'London', 'Berlin', 'Paris', 'Tokyo'];
  List<String> languages = [
    'English',
    'French',
    'German',
    'Japanese',
    'Spanish',
  ];
  List<String> currencies = ['USD', 'GBP', 'EUR', 'JPY', 'MXN'];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Profile Form',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Multiple DropdownMenu form fields in a Form context',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 16),
          DropdownMenu(
            initialSelection: 'United States',
            dropdownMenuEntries: buildStringEntries(countries),
            label: Text('Country'),
            expandedInsets: EdgeInsets.zero,
          ),
          SizedBox(height: 16),
          DropdownMenu(
            initialSelection: 'New York',
            dropdownMenuEntries: buildStringEntries(cities),
            label: Text('City'),
            expandedInsets: EdgeInsets.zero,
          ),
          SizedBox(height: 16),
          DropdownMenu(
            initialSelection: 'English',
            dropdownMenuEntries: buildStringEntries(languages),
            label: Text('Language'),
            expandedInsets: EdgeInsets.zero,
          ),
          SizedBox(height: 16),
          DropdownMenu(
            initialSelection: 'USD',
            dropdownMenuEntries: buildStringEntries(currencies),
            label: Text('Currency'),
            expandedInsets: EdgeInsets.zero,
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade800,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Save Profile',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildThemedFormSection(String title, MaterialColor themeColor) {
  print('Building themed form section: $title');
  List<String> items = ['Primary', 'Secondary', 'Tertiary', 'Default'];
  List<IconData> icons = [
    Icons.looks_one,
    Icons.looks_two,
    Icons.looks_3,
    Icons.looks_4,
  ];
  List<Color> iconColors = [
    themeColor,
    themeColor.shade400,
    themeColor.shade300,
    Colors.grey,
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: themeColor.shade200, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 32,
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: themeColor.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        DropdownMenu(
          initialSelection: 'Primary',
          dropdownMenuEntries: buildIconEntries(items, icons, iconColors),
          label: Text('Level'),
          expandedInsets: EdgeInsets.zero,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: themeColor.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: themeColor.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: themeColor.shade300),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildFormFieldsComparison() {
  print('Building form fields comparison');
  List<String> fieldTypes = ['Outlined', 'Filled', 'Underline', 'Dense'];
  List<String> fieldDescs = [
    'Standard outlined border styling',
    'Filled background with subtle border',
    'Simple underline decoration',
    'Compact form with dense padding',
  ];
  List<MaterialColor> fieldColors = [
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.purple,
  ];

  List<Widget> fieldCards = [];
  int f = 0;
  for (f = 0; f < fieldTypes.length; f = f + 1) {
    fieldCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: fieldColors[f].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: fieldColors[f].shade200),
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
                    color: fieldColors[f],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '${f + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  fieldTypes[f],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              fieldDescs[f],
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            SizedBox(height: 10),
            DropdownMenu(
              initialSelection: 'Choice 1',
              dropdownMenuEntries: buildStringEntries([
                'Choice 1',
                'Choice 2',
                'Choice 3',
              ]),
              expandedInsets: EdgeInsets.zero,
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
          'Form Field Decoration Styles',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different InputDecorationTheme configurations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: fieldCards),
      ],
    ),
  );
}

Widget buildValidationStatesShowcase() {
  print('Building validation states showcase');
  List<String> states = ['Default', 'Focused', 'Error', 'Disabled'];
  List<Color> stateColors = [
    Colors.grey,
    Colors.blue,
    Colors.red,
    Colors.grey.shade400,
  ];
  List<IconData> stateIcons = [
    Icons.radio_button_unchecked,
    Icons.radio_button_checked,
    Icons.error,
    Icons.block,
  ];
  List<String> stateDescs = [
    'Normal idle state with standard border',
    'Active input with highlighted border',
    'Validation failed with red border and message',
    'Field not editable, greyed out',
  ];

  List<Widget> stateWidgets = [];
  int s = 0;
  for (s = 0; s < states.length; s = s + 1) {
    stateWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: stateColors[s].withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: stateColors[s].withAlpha(80), width: 2),
        ),
        child: Row(
          children: [
            Icon(stateIcons[s], color: stateColors[s], size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    states[s],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: stateColors[s],
                    ),
                  ),
                  Text(
                    stateDescs[s],
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
          'Form Field Validation States',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Visual representation of different field states',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: stateWidgets),
      ],
    ),
  );
}

Widget buildFormLayoutPattern() {
  print('Building form layout pattern');
  List<String> roles = ['Admin', 'Editor', 'Viewer', 'Guest'];
  List<String> depts = ['Engineering', 'Design', 'Marketing', 'Sales'];
  List<String> statuses = ['Active', 'Inactive', 'On Leave', 'Probation'];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Registration Form Pattern',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Common form layout with dropdown fields',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 14),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          SizedBox(height: 14),
          DropdownMenu(
            initialSelection: 'Admin',
            dropdownMenuEntries: buildStringEntries(roles),
            label: Text('Role'),
            expandedInsets: EdgeInsets.zero,
            leadingIcon: Icon(Icons.badge, color: Colors.amber.shade800),
          ),
          SizedBox(height: 14),
          DropdownMenu(
            initialSelection: 'Engineering',
            dropdownMenuEntries: buildStringEntries(depts),
            label: Text('Department'),
            expandedInsets: EdgeInsets.zero,
            leadingIcon: Icon(Icons.business, color: Colors.amber.shade800),
          ),
          SizedBox(height: 14),
          DropdownMenu(
            initialSelection: 'Active',
            dropdownMenuEntries: buildStringEntries(statuses),
            label: Text('Status'),
            expandedInsets: EdgeInsets.zero,
            leadingIcon: Icon(Icons.toggle_on, color: Colors.amber.shade800),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Cancel', style: TextStyle(fontSize: 15)),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade800,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildFormFieldProperties() {
  print('Building properties table');
  List<String> propNames = [
    'initialSelection',
    'dropdownMenuEntries',
    'onSelected',
    'label',
    'hintText',
    'helperText',
    'errorText',
    'inputDecorationTheme',
    'leadingIcon',
    'trailingIcon',
    'expandedInsets',
    'enabled',
  ];
  List<String> propDescs = [
    'The initially selected value',
    'List of DropdownMenuEntry items to display',
    'Callback when a new value is selected',
    'Label widget for the input field',
    'Hint text when no selection is made',
    'Helper text shown below the field',
    'Error text shown below the field in error state',
    'Theme for the input decoration appearance',
    'Widget displayed at the start of the input',
    'Widget displayed at the end of the input',
    'Insets when the dropdown menu is expanded',
    'Whether the field is interactive',
  ];

  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color bg = (p % 2 == 0) ? Colors.amber.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: bg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160,
              child: Text(
                propNames[p],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade900,
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
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'DropdownMenu Form Field Properties',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('DropdownMenuFormField deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DropdownMenuFormField Deep Demo'),
        backgroundColor: Colors.amber.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'DropdownMenuFormField'),
            buildInfoCard(
              'Purpose',
              'A FormField that wraps DropdownMenu for form integration',
            ),
            buildInfoCard(
              'Key Feature',
              'Participates in Form validation and state management',
            ),
            buildInfoCard(
              'Related To',
              'DropdownMenu, DropdownMenuEntry, FormField',
            ),

            buildSectionHeader('2. Basic Form Fields'),
            buildBasicFormField('Country', 'Select your country', [
              'USA',
              'UK',
              'Germany',
              'France',
              'Japan',
            ], 'USA'),
            buildBasicFormField('Language', 'Choose preferred language', [
              'English',
              'French',
              'German',
              'Spanish',
              'Japanese',
            ], 'English'),
            buildBasicFormField('Timezone', 'Select timezone', [
              'UTC-8',
              'UTC-5',
              'UTC+0',
              'UTC+1',
              'UTC+9',
            ], 'UTC+0'),

            buildSectionHeader('3. Decorated Form Fields'),
            buildFormFieldWithDecoration(
              'Blue Theme',
              Colors.blue,
              Colors.blue.shade50,
            ),
            buildFormFieldWithDecoration(
              'Teal Theme',
              Colors.teal,
              Colors.teal.shade50,
            ),
            buildFormFieldWithDecoration(
              'Pink Theme',
              Colors.pink,
              Colors.pink.shade50,
            ),

            buildSectionHeader('4. Complete Profile Form'),
            buildFormWithMultipleFields(),

            buildSectionHeader('5. Themed Form Sections'),
            buildThemedFormSection('Primary Level', Colors.blue),
            buildThemedFormSection('Secondary Level', Colors.teal),
            buildThemedFormSection('Alert Level', Colors.red),

            buildSectionHeader('6. Decoration Style Comparison'),
            buildFormFieldsComparison(),

            buildSectionHeader('7. Validation States'),
            buildValidationStatesShowcase(),

            buildSectionHeader('8. Registration Form Pattern'),
            buildFormLayoutPattern(),

            buildSectionHeader('9. API Properties'),
            buildFormFieldProperties(),

            buildSectionHeader('10. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Wrap in Form widget for validation support',
            ),
            buildInfoCard(
              'Tip 2',
              'Use InputDecorationTheme for consistent styling',
            ),
            buildInfoCard(
              'Tip 3',
              'Set expandedInsets for dropdown width control',
            ),
            buildInfoCard(
              'Tip 4',
              'Combine with TextFormField for mixed input forms',
            ),
            buildInfoCard(
              'Tip 5',
              'Use leadingIcon for visual context in the field',
            ),
            buildInfoCard(
              'Tip 6',
              'Always provide initialSelection for default state',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('DropdownMenuFormField deep demo completed');
  return result;
}
