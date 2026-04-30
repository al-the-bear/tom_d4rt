// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SimpleDialogOption from material
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

Widget buildBasicOption(String labelText, Color backgroundColor) {
  print('Building basic option: $labelText');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: SimpleDialogOption(
      onPressed: () {
        print('Option pressed: $labelText');
      },
      child: Text(
        labelText,
        style: TextStyle(fontSize: 16),
      ),
    ),
  );
}

Widget buildOptionWithIcon(
  String labelText,
  IconData iconData,
  Color iconColor,
) {
  print('Building option with icon: $labelText');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: SimpleDialogOption(
      onPressed: () {
        print('Icon option pressed: $labelText');
      },
      child: Row(
        children: [
          Icon(iconData, color: iconColor, size: 24),
          SizedBox(width: 12),
          Text(
            labelText,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

Widget buildOptionWithPadding(
  String labelText,
  EdgeInsets customPadding,
  Color highlightColor,
) {
  print('Building option with custom padding: $labelText');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: highlightColor.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: highlightColor.withAlpha(100)),
    ),
    child: SimpleDialogOption(
      onPressed: () {
        print('Padded option pressed: $labelText');
      },
      padding: customPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Padding: ${customPadding.toString()}',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    ),
  );
}

Widget buildSimpleDialogPreview() {
  print('Building SimpleDialog preview');
  List<String> optionLabels = [
    'Option One',
    'Option Two',
    'Option Three',
    'Option Four',
  ];
  List<IconData> optionIcons = [
    Icons.looks_one,
    Icons.looks_two,
    Icons.looks_3,
    Icons.looks_4,
  ];

  List<Widget> optionWidgets = [];
  int i = 0;
  for (i = 0; i < optionLabels.length; i = i + 1) {
    optionWidgets.add(
      SimpleDialogOption(
        onPressed: () {
          print('Dialog option pressed: ${optionLabels[i]}');
        },
        child: Row(
          children: [
            Icon(optionIcons[i], color: Colors.indigo, size: 22),
            SizedBox(width: 12),
            Text(
              optionLabels[i],
              style: TextStyle(fontSize: 15),
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
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select an option',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Divider(color: Colors.grey.shade300),
        Column(children: optionWidgets),
      ],
    ),
  );
}

Widget buildIconTextOptionGrid() {
  print('Building icon text option grid');
  List<String> actionLabels = [
    'Share',
    'Download',
    'Print',
    'Delete',
    'Archive',
    'Favorite',
    'Edit',
    'Copy',
  ];
  List<IconData> actionIcons = [
    Icons.share,
    Icons.download,
    Icons.print,
    Icons.delete,
    Icons.archive,
    Icons.favorite,
    Icons.edit,
    Icons.copy,
  ];
  List<MaterialColor> actionColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.amber,
  ];

  List<Widget> gridItems = [];
  int i = 0;
  for (i = 0; i < actionLabels.length; i = i + 1) {
    gridItems.add(
      Container(
        decoration: BoxDecoration(
          color: actionColors[i].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: actionColors[i].shade200),
        ),
        child: SimpleDialogOption(
          onPressed: () {
            print('Action pressed: ${actionLabels[i]}');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: actionColors[i].shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  actionIcons[i],
                  color: actionColors[i].shade700,
                  size: 24,
                ),
              ),
              SizedBox(height: 8),
              Text(
                actionLabels[i],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: actionColors[i].shade800,
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
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.9,
      physics: NeverScrollableScrollPhysics(),
      children: gridItems,
    ),
  );
}

Widget buildStylingPatternCard(
  String patternName,
  String patternDescription,
  Widget exampleWidget,
) {
  print('Building styling pattern: $patternName');
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
          patternName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 4),
        Text(
          patternDescription,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        exampleWidget,
      ],
    ),
  );
}

Widget buildLeadingIconPattern() {
  return Column(
    children: [
      SimpleDialogOption(
        onPressed: () {
          print('Settings pressed');
        },
        child: Row(
          children: [
            Icon(Icons.settings, color: Colors.grey.shade700),
            SizedBox(width: 16),
            Text('Settings', style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () {
          print('Account pressed');
        },
        child: Row(
          children: [
            Icon(Icons.account_circle, color: Colors.grey.shade700),
            SizedBox(width: 16),
            Text('Account', style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    ],
  );
}

Widget buildTrailingBadgePattern() {
  return Column(
    children: [
      SimpleDialogOption(
        onPressed: () {
          print('Notifications pressed');
        },
        child: Row(
          children: [
            Expanded(
              child: Text('Notifications', style: TextStyle(fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '5',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () {
          print('Messages pressed');
        },
        child: Row(
          children: [
            Expanded(
              child: Text('Messages', style: TextStyle(fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '12',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildSubtitlePattern() {
  return Column(
    children: [
      SimpleDialogOption(
        onPressed: () {
          print('Wi-Fi pressed');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wi-Fi',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 2),
            Text(
              'Connected to HomeNetwork',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () {
          print('Bluetooth pressed');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bluetooth',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 2),
            Text(
              'Off',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildAccessibilityShowcase() {
  print('Building accessibility showcase');
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
          'Accessibility Features',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        _buildAccessibilityItem(
          'Semantic Labels',
          'SimpleDialogOption wraps InkWell with semantics',
          Icons.label,
          Colors.blue,
        ),
        _buildAccessibilityItem(
          'Touch Target',
          'Full-width tappable area for easy interaction',
          Icons.touch_app,
          Colors.green,
        ),
        _buildAccessibilityItem(
          'Screen Reader',
          'Announces child content when focused',
          Icons.record_voice_over,
          Colors.orange,
        ),
        _buildAccessibilityItem(
          'Focus Traversal',
          'Standard focus navigation support',
          Icons.keyboard_tab,
          Colors.purple,
        ),
      ],
    ),
  );
}

Widget _buildAccessibilityItem(
  String title,
  String description,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color.shade700, size: 22),
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
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCallbackDemonstration() {
  print('Building callback demonstration');
  int tapCount = 0;
  
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
          'onPressed Callback',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'The onPressed callback is triggered when the option is tapped',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: SimpleDialogOption(
            onPressed: () {
              tapCount = tapCount + 1;
              print('Tap count: $tapCount');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.touch_app, color: Colors.indigo.shade700),
                SizedBox(width: 8),
                Text(
                  'Tap this option',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.grey.shade600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Check console for tap events',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildPaddingComparisonGrid() {
  print('Building padding comparison grid');
  List<String> paddingLabels = [
    'Default',
    'Small',
    'Large',
    'Horizontal',
    'Vertical',
    'Custom',
  ];
  List<EdgeInsets> paddingValues = [
    EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    EdgeInsets.all(4),
    EdgeInsets.all(24),
    EdgeInsets.symmetric(horizontal: 32, vertical: 8),
    EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    EdgeInsets.fromLTRB(8, 16, 24, 8),
  ];
  List<MaterialColor> paddingColors = [
    Colors.grey,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];

  List<Widget> paddingCards = [];
  int i = 0;
  for (i = 0; i < paddingLabels.length; i = i + 1) {
    paddingCards.add(
      Container(
        decoration: BoxDecoration(
          color: paddingColors[i].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: paddingColors[i].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: paddingColors[i].shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Text(
                paddingLabels[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: paddingColors[i].shade800,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                print('Padding option pressed: ${paddingLabels[i]}');
              },
              padding: paddingValues[i],
              child: Text(
                'Option Text',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.3,
      physics: NeverScrollableScrollPhysics(),
      children: paddingCards,
    ),
  );
}

Widget buildOptionsListDemo() {
  print('Building options list demo');
  List<String> countryNames = [
    'United States',
    'United Kingdom',
    'Germany',
    'France',
    'Japan',
    'Australia',
  ];
  List<String> countryFlags = [
    '🇺🇸',
    '🇬🇧',
    '🇩🇪',
    '🇫🇷',
    '🇯🇵',
    '🇦🇺',
  ];

  List<Widget> countryOptions = [];
  int i = 0;
  for (i = 0; i < countryNames.length; i = i + 1) {
    countryOptions.add(
      SimpleDialogOption(
        onPressed: () {
          print('Country selected: ${countryNames[i]}');
        },
        child: Row(
          children: [
            Text(
              countryFlags[i],
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(width: 16),
            Text(
              countryNames[i],
              style: TextStyle(fontSize: 15),
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
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.public, color: Colors.indigo.shade700),
              SizedBox(width: 12),
              Text(
                'Select Country',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ],
          ),
        ),
        Column(children: countryOptions),
      ],
    ),
  );
}

Widget buildChildWidgetVariantsCard() {
  print('Building child widget variants');
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
          'Child Widget Variants',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'SimpleDialogOption accepts any widget as child',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        _buildVariantItem(
          'Text Only',
          SimpleDialogOption(
            onPressed: () {
              print('Text only pressed');
            },
            child: Text('Simple text option'),
          ),
        ),
        _buildVariantItem(
          'Icon + Text',
          SimpleDialogOption(
            onPressed: () {
              print('Icon text pressed');
            },
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 12),
                Text('Icon with text'),
              ],
            ),
          ),
        ),
        _buildVariantItem(
          'Rich Content',
          SimpleDialogOption(
            onPressed: () {
              print('Rich content pressed');
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.indigo.shade100,
                  child: Text(
                    'JD',
                    style: TextStyle(
                      color: Colors.indigo.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'john.doe@example.com',
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
          ),
        ),
        _buildVariantItem(
          'Custom Widget',
          SimpleDialogOption(
            onPressed: () {
              print('Custom widget pressed');
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.indigo.shade400],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Premium Option',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildVariantItem(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade700,
          ),
        ),
        SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: child,
        ),
      ],
    ),
  );
}

Widget buildSimpleDialogIntegration() {
  print('Building SimpleDialog integration demo');
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
          'SimpleDialog Integration',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'SimpleDialogOption is designed for use within SimpleDialog',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.code, color: Colors.blue.shade700, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Typical Usage',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'SimpleDialog(\n'
                  '  title: Text("Select Option"),\n'
                  '  children: [\n'
                  '    SimpleDialogOption(...),\n'
                  '    SimpleDialogOption(...),\n'
                  '  ],\n'
                  ')',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.green.shade400,
                  ),
                ),
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
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Use Navigator.pop() in onPressed to close the dialog and return a value',
                  style: TextStyle(fontSize: 13, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildThemeAwareSection() {
  print('Building theme aware section');
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
          'Theme Integration',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Light Theme',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: SimpleDialogOption(
                        onPressed: () {
                          print('Light theme option');
                        },
                        child: Text(
                          'Option in Light',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Dark Theme',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: SimpleDialogOption(
                        onPressed: () {
                          print('Dark theme option');
                        },
                        child: Text(
                          'Option in Dark',
                          style: TextStyle(color: Colors.white),
                        ),
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
  );
}

dynamic build(BuildContext context) {
  print('SimpleDialogOption deep demo starting');
  print('Testing SimpleDialogOption from material library');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('SimpleDialogOption Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. SimpleDialogOption Basics'),
            buildInfoCard('Class', 'SimpleDialogOption'),
            buildInfoCard(
              'Purpose',
              'An option used in a SimpleDialog to represent a choice',
            ),
            buildInfoCard('Package', 'package:flutter/material.dart'),
            buildInfoCard(
              'Behavior',
              'Tappable widget that triggers onPressed callback',
            ),

            buildSectionHeader('2. Child Widget Variants'),
            buildChildWidgetVariantsCard(),
            buildBasicOption('Basic Text Option', Colors.grey.shade100),
            buildBasicOption('Another Text Option', Colors.blue.shade50),

            buildSectionHeader('3. onPressed Callback'),
            buildCallbackDemonstration(),

            buildSectionHeader('4. Padding Customization'),
            buildPaddingComparisonGrid(),
            buildOptionWithPadding(
              'Extra Left Padding',
              EdgeInsets.fromLTRB(32, 12, 16, 12),
              Colors.blue,
            ),
            buildOptionWithPadding(
              'Symmetric Large Padding',
              EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              Colors.green,
            ),

            buildSectionHeader('5. SimpleDialog with Options List'),
            buildSimpleDialogPreview(),
            buildOptionsListDemo(),
            buildSimpleDialogIntegration(),

            buildSectionHeader('6. Icon with Text'),
            buildOptionWithIcon('Add New Item', Icons.add_circle, Colors.green),
            buildOptionWithIcon('Edit Item', Icons.edit, Colors.blue),
            buildOptionWithIcon('Delete Item', Icons.delete, Colors.red),
            buildOptionWithIcon('Share Item', Icons.share, Colors.orange),
            buildIconTextOptionGrid(),

            buildSectionHeader('7. Styling Patterns'),
            buildStylingPatternCard(
              'Leading Icon Pattern',
              'Icon positioned before the text label',
              buildLeadingIconPattern(),
            ),
            buildStylingPatternCard(
              'Trailing Badge Pattern',
              'Badge or count displayed after the label',
              buildTrailingBadgePattern(),
            ),
            buildStylingPatternCard(
              'Subtitle Pattern',
              'Secondary text below the main label',
              buildSubtitlePattern(),
            ),
            buildThemeAwareSection(),

            buildSectionHeader('8. Accessibility'),
            buildAccessibilityShowcase(),
            buildInfoCard(
              'Semantic Role',
              'Acts as a button with semantic tap action',
            ),
            buildInfoCard(
              'Text Scaling',
              'Child text respects MediaQuery.textScaler',
            ),
            buildInfoCard(
              'Color Contrast',
              'Use sufficient contrast for text visibility',
            ),
            buildInfoCard(
              'Focus Ring',
              'Shows focus indicator during keyboard navigation',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('SimpleDialogOption deep demo completed');
  return result;
}
