// D4rt test script: Tests PopupMenuItem from material
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

Widget buildMenuItemDemo(
  String label,
  String description,
  IconData icon,
  Color color,
  bool enabled,
) {
  print('Building menu item demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: enabled ? Colors.white : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(enabled ? 100 : 50)),
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withAlpha(enabled ? 30 : 15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: enabled ? color : Colors.grey.shade400,
            size: 24,
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
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: enabled ? Colors.grey.shade800 : Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: enabled ? Colors.grey.shade600 : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
        if (enabled)
          Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
            size: 20,
          ),
        if (!enabled)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Disabled',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
          ),
      ],
    ),
  );
}

Widget buildValuePropertySection() {
  print('Building value property section');
  List<String> valueLabels = ['String Value', 'Int Value', 'Object Value', 'Enum Value'];
  List<String> valueDescs = [
    '"option_copy" - String identifier',
    '42 - Numeric identifier',
    'UserAction(id: 1) - Custom object',
    'Actions.delete - Enum value',
  ];
  List<IconData> valueIcons = [Icons.text_fields, Icons.numbers, Icons.data_object, Icons.list];
  List<MaterialColor> valueColors = [Colors.blue, Colors.green, Colors.orange, Colors.purple];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < valueLabels.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: valueColors[i].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: valueColors[i].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(valueIcons[i], color: valueColors[i].shade700, size: 22),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueLabels[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: valueColors[i].shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    valueDescs[i],
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Generic Value Parameter <T>',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'PopupMenuItem<T> accepts any type as value',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildOnTapCallbackSection() {
  print('Building onTap callback section');
  List<String> tapLabels = ['Show Dialog', 'Copy Text', 'Navigate', 'Update State', 'Show Snackbar'];
  List<String> tapDescs = [
    'Opens a confirmation dialog',
    'Copies content to clipboard',
    'Pushes a new route',
    'Modifies app state',
    'Displays feedback message',
  ];
  List<IconData> tapIcons = [Icons.open_in_new, Icons.copy, Icons.navigation, Icons.refresh, Icons.message];
  List<MaterialColor> tapColors = [Colors.indigo, Colors.teal, Colors.amber, Colors.pink, Colors.green];

  List<Widget> callbacks = [];
  int c = 0;
  for (c = 0; c < tapLabels.length; c = c + 1) {
    callbacks.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: tapColors[c].shade200),
        ),
        child: Row(
          children: [
            Icon(tapIcons[c], color: tapColors[c].shade600, size: 22),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tapLabels[c],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    tapDescs[c],
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: tapColors[c].shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'onTap',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: tapColors[c].shade700,
                ),
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
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, color: Colors.indigo.shade600, size: 24),
            SizedBox(width: 8),
            Text(
              'onTap Callback Examples',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Common actions triggered when menu item is tapped',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: callbacks),
      ],
    ),
  );
}

Widget buildEnabledStateSection() {
  print('Building enabled state section');
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
          'Enabled vs Disabled States',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Visual and interactive differences based on enabled property',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade600, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'enabled: true',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Interactive',
                      style: TextStyle(fontSize: 11, color: Colors.green.shade600),
                    ),
                    Text(
                      'Full opacity',
                      style: TextStyle(fontSize: 11, color: Colors.green.shade600),
                    ),
                    Text(
                      'Triggers onTap',
                      style: TextStyle(fontSize: 11, color: Colors.green.shade600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Icon(Icons.cancel, color: Colors.grey.shade400, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'enabled: false',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Non-interactive',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                    ),
                    Text(
                      'Reduced opacity',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                    ),
                    Text(
                      'No callback',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildMenuItemDemo('Edit Document', 'Modify the current file', Icons.edit, Colors.blue, true),
        buildMenuItemDemo('Delete Document', 'Requires admin permissions', Icons.delete, Colors.red, false),
        buildMenuItemDemo('Share Document', 'Available action', Icons.share, Colors.green, true),
        buildMenuItemDemo('Archive Document', 'Premium feature only', Icons.archive, Colors.orange, false),
      ],
    ),
  );
}

Widget buildChildWidgetSection() {
  print('Building child widget section');
  List<Widget> children = [];

  children.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.text_fields, color: Colors.blue.shade700, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Text Widget',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  'child: Text("Menu Option")',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  children.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.view_column, color: Colors.purple.shade700, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Row with Icon',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  'child: Row(children: [Icon(...), Text(...)])',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  children.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.list_alt, color: Colors.teal.shade700, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ListTile',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  'child: ListTile(leading: ..., title: ...)',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  children.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.dashboard, color: Colors.orange.shade700, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Custom Layout',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  'child: Container with complex widgets',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Child Widget Configurations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'PopupMenuItem can contain any widget as its child',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: children),
      ],
    ),
  );
}

Widget buildHeightCustomizationSection() {
  print('Building height customization section');
  List<double> heights = [32.0, 48.0, 56.0, 64.0, 72.0];
  List<String> heightLabels = ['Compact (32)', 'Standard (48)', 'Default (56)', 'Large (64)', 'Extra Large (72)'];
  List<MaterialColor> heightColors = [Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.pink];

  List<Widget> heightItems = [];
  int h = 0;
  for (h = 0; h < heights.length; h = h + 1) {
    double heightVal = heights[h];
    heightItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: heightVal,
        decoration: BoxDecoration(
          color: heightColors[h].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: heightColors[h].shade300),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.height, color: heightColors[h].shade600, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  heightLabels[h],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: heightColors[h].shade800,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: heightColors[h].shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${heightVal.toInt()}px',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: heightColors[h].shade700,
                  ),
                ),
              ),
            ],
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
        Row(
          children: [
            Icon(Icons.height, color: Colors.indigo.shade600, size: 24),
            SizedBox(width: 8),
            Text(
              'Height Property',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Minimum height of the menu item (default: kMinInteractiveDimension)',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: heightItems),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'kMinInteractiveDimension = 48.0 logical pixels',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTextStyleThemingSection() {
  print('Building text style theming section');
  List<String> styleNames = ['Default', 'Bold', 'Italic', 'Large', 'Small', 'Colored'];
  List<TextStyle> styles = [
    TextStyle(fontSize: 14, color: Colors.grey.shade800),
    TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
    TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey.shade700),
    TextStyle(fontSize: 18, color: Colors.grey.shade800),
    TextStyle(fontSize: 12, color: Colors.grey.shade600),
    TextStyle(fontSize: 14, color: Colors.indigo.shade700, fontWeight: FontWeight.w600),
  ];
  List<MaterialColor> styleBgColors = [
    Colors.grey,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.indigo,
  ];

  List<Widget> styleItems = [];
  int s = 0;
  for (s = 0; s < styleNames.length; s = s + 1) {
    styleItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: styleBgColors[s].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: styleBgColors[s].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: styleBgColors[s].shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Aa',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: styleBgColors[s].shade700,
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
                    styleNames[s],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text('Menu Item Text', style: styles[s]),
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
          'Text Style and Theming',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Customize text appearance within PopupMenuItem',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: styleItems),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme Integration',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.palette, color: Colors.blue.shade600, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'PopupMenuTheme.of(context)',
                    style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.style, color: Colors.blue.shade600, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'TextTheme.bodyMedium (default)',
                    style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
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

Widget buildIconsAndLeadingSection() {
  print('Building icons and leading widgets section');
  List<IconData> menuIcons = [
    Icons.content_copy,
    Icons.content_paste,
    Icons.content_cut,
    Icons.delete,
    Icons.share,
    Icons.print,
    Icons.save,
    Icons.settings,
  ];
  List<String> menuLabels = ['Copy', 'Paste', 'Cut', 'Delete', 'Share', 'Print', 'Save', 'Settings'];
  List<MaterialColor> menuColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.teal,
    Colors.purple,
    Colors.indigo,
    Colors.grey,
  ];

  List<Widget> iconItems = [];
  int m = 0;
  for (m = 0; m < menuIcons.length; m = m + 1) {
    iconItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: menuColors[m].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: menuColors[m].shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(menuIcons[m], color: menuColors[m].shade700, size: 18),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                menuLabels[m],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Row layout',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
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
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dashboard_customize, color: Colors.indigo.shade600, size: 24),
            SizedBox(width: 8),
            Text(
              'With Icons and Leading Widgets',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Common patterns for menu items with icons',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: iconItems),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Implementation Pattern:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'child: Row(children: [Icon(...), SizedBox(width: 12), Text(...)])',
                style: TextStyle(fontSize: 11, color: Colors.indigo.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMultipleMenuItemsSection() {
  print('Building multiple menu items section');
  List<String> fileActions = ['New File', 'Open File', 'Save', 'Save As', 'Export', 'Close'];
  List<IconData> fileIcons = [
    Icons.create_new_folder,
    Icons.folder_open,
    Icons.save,
    Icons.save_as,
    Icons.upload,
    Icons.close,
  ];
  List<String> editActions = ['Undo', 'Redo', 'Cut', 'Copy', 'Paste', 'Select All'];
  List<IconData> editIcons = [
    Icons.undo,
    Icons.redo,
    Icons.content_cut,
    Icons.content_copy,
    Icons.content_paste,
    Icons.select_all,
  ];
  List<String> viewActions = ['Zoom In', 'Zoom Out', 'Full Screen', 'Split View', 'Dark Mode'];
  List<IconData> viewIcons = [Icons.zoom_in, Icons.zoom_out, Icons.fullscreen, Icons.vertical_split, Icons.dark_mode];

  Widget buildMenuGroup(String title, List<String> actions, List<IconData> icons, MaterialColor color) {
    List<Widget> items = [];
    int a = 0;
    for (a = 0; a < actions.length; a = a + 1) {
      items.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: a < actions.length - 1 ? Colors.grey.shade200 : Colors.transparent,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(icons[a], color: color.shade600, size: 18),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  actions[a],
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
          ),
          Column(children: items),
        ],
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multiple Menu Items (Menu Groups)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Organizing PopupMenuItems into logical groups',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        buildMenuGroup('File', fileActions, fileIcons, Colors.blue),
        buildMenuGroup('Edit', editActions, editIcons, Colors.green),
        buildMenuGroup('View', viewActions, viewIcons, Colors.purple),
      ],
    ),
  );
}

Widget buildInteractiveShowcase() {
  print('Building interactive showcase');
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
        Row(
          children: [
            Icon(Icons.star, color: Colors.indigo.shade600, size: 24),
            SizedBox(width: 8),
            Text(
              'Interactive Item Showcase',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Visual representation of all PopupMenuItem features',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        _buildShowcaseItem(
          'Standard Item',
          'Basic menu item with text',
          Icons.menu,
          Colors.blue,
          true,
          false,
        ),
        _buildShowcaseItem(
          'Item with Subtitle',
          'Secondary information displayed below',
          Icons.subtitles,
          Colors.green,
          true,
          true,
        ),
        _buildShowcaseItem(
          'Disabled Item',
          'Non-interactive state',
          Icons.block,
          Colors.grey,
          false,
          false,
        ),
        _buildShowcaseItem(
          'Colored Item',
          'Custom text color for emphasis',
          Icons.palette,
          Colors.orange,
          true,
          false,
        ),
        _buildShowcaseItem(
          'Item with Badge',
          'Shows notification count',
          Icons.notifications,
          Colors.red,
          true,
          true,
        ),
        _buildShowcaseItem(
          'Premium Item',
          'Locked feature indicator',
          Icons.workspace_premium,
          Colors.amber,
          true,
          false,
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PopupMenuItem Properties Used:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 8),
              _buildPropertyChip('value', Colors.blue),
              _buildPropertyChip('onTap', Colors.green),
              _buildPropertyChip('enabled', Colors.orange),
              _buildPropertyChip('height', Colors.purple),
              _buildPropertyChip('padding', Colors.pink),
              _buildPropertyChip('textStyle', Colors.teal),
              _buildPropertyChip('labelTextStyle', Colors.indigo),
              _buildPropertyChip('mouseCursor', Colors.red),
              _buildPropertyChip('child', Colors.amber),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildShowcaseItem(
  String title,
  String subtitle,
  IconData icon,
  MaterialColor color,
  bool enabled,
  bool hasExtra,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: enabled ? Colors.white : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: enabled ? color.shade200 : Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: enabled ? color.shade100 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: enabled ? color.shade700 : Colors.grey.shade400,
            size: 22,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: enabled ? Colors.grey.shade800 : Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: enabled ? Colors.grey.shade600 : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
        if (hasExtra && enabled)
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: color.shade600,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(
                '3',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (!enabled)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Disabled',
              style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
            ),
          ),
      ],
    ),
  );
}

Widget _buildPropertyChip(String label, MaterialColor color) {
  return Container(
    margin: EdgeInsets.only(bottom: 4),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color.shade600,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: color.shade800,
          ),
        ),
      ],
    ),
  );
}

Widget buildPropertiesTable() {
  print('Building properties table');
  List<String> propNames = [
    'value',
    'onTap',
    'enabled',
    'height',
    'padding',
    'textStyle',
    'labelTextStyle',
    'mouseCursor',
    'child',
  ];
  List<String> propTypes = [
    'T?',
    'VoidCallback?',
    'bool',
    'double?',
    'EdgeInsets?',
    'TextStyle?',
    'WidgetStateProperty<TextStyle?>?',
    'MouseCursor?',
    'Widget?',
  ];
  List<String> propDescs = [
    'Value returned when this item is selected',
    'Called when the item is tapped',
    'Whether the item is interactive (default: true)',
    'Minimum height of the item',
    'Padding inside the menu item',
    'Text style for the menu item',
    'Label text style using WidgetStateProperty',
    'Mouse cursor when hovering',
    'The content to display in the menu item',
  ];

  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: p % 2 == 0 ? Colors.grey.shade50 : Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              child: Text(
                propNames[p],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade700,
                ),
              ),
            ),
            Container(
              width: 120,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                propTypes[p],
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.blue.shade700,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                propDescs[p],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
            'PopupMenuItem Properties',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

Widget buildUsageTips() {
  print('Building usage tips');
  List<String> tips = [
    'Use PopupMenuItem<T> with generic typing for type-safe value handling',
    'Combine with PopupMenuButton for a complete dropdown menu implementation',
    'Use enabled: false to create visual separators or disabled options',
    'Wrap child in Row with Icon and Text for icon-prefixed menu items',
    'Use CheckedPopupMenuItem for items with checkmark state',
    'PopupMenuDivider can be used between items for visual separation',
    'Access selectedItemBuilder for custom display of selected item',
    'Use onSelected callback on PopupMenuButton to handle menu item selection',
  ];

  List<Widget> tipCards = [];
  int t = 0;
  for (t = 0; t < tips.length; t = t + 1) {
    tipCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '${t + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                tips[t],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
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
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.green.shade600, size: 24),
            SizedBox(width: 8),
            Text(
              'Usage Tips',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: tipCards),
      ],
    ),
  );
}

Widget buildRelatedWidgets() {
  print('Building related widgets section');
  List<String> widgetNames = [
    'PopupMenuButton',
    'PopupMenuDivider',
    'CheckedPopupMenuItem',
    'PopupMenuEntry',
    'showMenu',
  ];
  List<String> widgetDescs = [
    'Displays a popup menu when pressed',
    'Horizontal rule between menu items',
    'Menu item with leading checkmark',
    'Abstract base class for menu items',
    'Function to display popup menu at position',
  ];
  List<IconData> widgetIcons = [
    Icons.more_vert,
    Icons.horizontal_rule,
    Icons.check_box,
    Icons.article,
    Icons.open_in_browser,
  ];
  List<MaterialColor> widgetColors = [Colors.blue, Colors.grey, Colors.green, Colors.purple, Colors.orange];

  List<Widget> widgetCards = [];
  int w = 0;
  for (w = 0; w < widgetNames.length; w = w + 1) {
    widgetCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: widgetColors[w].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: widgetColors[w].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(widgetIcons[w], color: widgetColors[w].shade700, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widgetNames[w],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: widgetColors[w].shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    widgetDescs[w],
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related Widgets',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Components commonly used with PopupMenuItem',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: widgetCards),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('PopupMenuItem deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('PopupMenuItem Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              print('Selected: $value');
            },
            itemBuilder: (BuildContext ctx) {
              return [
                PopupMenuItem<String>(
                  value: 'refresh',
                  child: Row(
                    children: [
                      Icon(Icons.refresh, color: Colors.grey.shade700, size: 20),
                      SizedBox(width: 12),
                      Text('Refresh'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Colors.grey.shade700, size: 20),
                      SizedBox(width: 12),
                      Text('Settings'),
                    ],
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'help',
                  child: Row(
                    children: [
                      Icon(Icons.help, color: Colors.grey.shade700, size: 20),
                      SizedBox(width: 12),
                      Text('Help'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'PopupMenuItem<T>'),
            buildInfoCard('Purpose', 'An item in a Material Design popup menu'),
            buildInfoCard('Parent', 'PopupMenuEntry<T>'),
            buildInfoCard('Used With', 'PopupMenuButton, showMenu()'),
            buildInfoCard('Generic', 'T represents the value type for selection'),

            buildSectionHeader('2. Value Property'),
            buildValuePropertySection(),

            buildSectionHeader('3. onTap Callback'),
            buildOnTapCallbackSection(),

            buildSectionHeader('4. Enabled State'),
            buildEnabledStateSection(),

            buildSectionHeader('5. Child Widget'),
            buildChildWidgetSection(),

            buildSectionHeader('6. Height Customization'),
            buildHeightCustomizationSection(),

            buildSectionHeader('7. Text Style and Theming'),
            buildTextStyleThemingSection(),

            buildSectionHeader('8. With Icons and Leading Widgets'),
            buildIconsAndLeadingSection(),

            buildSectionHeader('9. Multiple Menu Items'),
            buildMultipleMenuItemsSection(),

            buildSectionHeader('10. Interactive Item Showcase'),
            buildInteractiveShowcase(),

            buildSectionHeader('11. Properties Reference'),
            buildPropertiesTable(),

            buildSectionHeader('12. Usage Tips'),
            buildUsageTips(),

            buildSectionHeader('13. Related Widgets'),
            buildRelatedWidgets(),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('PopupMenuItem deep demo completed');
  return result;
}
