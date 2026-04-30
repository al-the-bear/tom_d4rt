// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FloatingLabelBehavior from material
// Deep Demo: Visual demonstration of text field label floating behaviors
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FloatingLabelBehavior Deep Demo executing');

  // ============================================================
  // SECTION 1: FloatingLabelBehavior Overview
  // ============================================================
  print('=== Section 1: FloatingLabelBehavior Overview ===');

  // Demonstrate all three enum values
  final behaviors = [
    FloatingLabelBehavior.auto,
    FloatingLabelBehavior.always,
    FloatingLabelBehavior.never,
  ];

  print('FloatingLabelBehavior.auto: ${FloatingLabelBehavior.auto}');
  print('FloatingLabelBehavior.always: ${FloatingLabelBehavior.always}');
  print('FloatingLabelBehavior.never: ${FloatingLabelBehavior.never}');
  print('Total enum values: ${behaviors.length}');

  // Enum index values
  for (final behavior in behaviors) {
    print('${behavior.name}: index=${behavior.index}');
  }

  final overviewCards = <Widget>[];
  final behaviorDescriptions = {
    FloatingLabelBehavior.auto: {
      'title': 'Auto',
      'description': 'Label floats when focused or has content. Default behavior.',
      'icon': Icons.auto_fix_high,
      'color': Colors.blue,
      'states': ['Empty+Unfocused: Inside', 'Focused: Floats', 'Has Text: Floats'],
    },
    FloatingLabelBehavior.always: {
      'title': 'Always',
      'description': 'Label always floats above the input, regardless of focus or content.',
      'icon': Icons.vertical_align_top,
      'color': Colors.green,
      'states': ['Empty+Unfocused: Floats', 'Focused: Floats', 'Has Text: Floats'],
    },
    FloatingLabelBehavior.never: {
      'title': 'Never',
      'description': 'Label never floats. Disappears when there is content.',
      'icon': Icons.vertical_align_center,
      'color': Colors.orange,
      'states': ['Empty+Unfocused: Inside', 'Focused: Inside', 'Has Text: Hidden'],
    },
  };

  for (final behavior in behaviors) {
    final data = behaviorDescriptions[behavior]!;
    final color = data['color'] as Color;
    final states = data['states'] as List<String>;

    overviewCards.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(data['icon'] as IconData, color: color, size: 24.0),
                  ),
                  SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'] as String,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        'FloatingLabelBehavior.${behavior.name}',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['description'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'State Behavior:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ...states.map((state) => Container(
                    margin: EdgeInsets.symmetric(vertical: 2.0),
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 8.0, color: color),
                        SizedBox(width: 8.0),
                        Text(
                          state,
                          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${overviewCards.length} overview cards');

  // ============================================================
  // SECTION 2: Visual TextField Examples with Each Behavior
  // ============================================================
  print('=== Section 2: TextField Visual Examples ===');

  final textFieldExamples = <Widget>[];

  // Auto behavior - empty field
  textFieldExamples.add(
    _buildTextFieldExample(
      behavior: FloatingLabelBehavior.auto,
      label: 'Email Address',
      hint: 'Enter your email',
      prefixIcon: Icons.email_outlined,
      initialValue: '',
      stateDescription: 'Empty - Label inside field',
    ),
  );

  // Auto behavior - with content
  textFieldExamples.add(
    _buildTextFieldExample(
      behavior: FloatingLabelBehavior.auto,
      label: 'Email Address',
      hint: 'Enter your email',
      prefixIcon: Icons.email_outlined,
      initialValue: 'user@example.com',
      stateDescription: 'Has content - Label floats',
    ),
  );

  // Always behavior - empty field
  textFieldExamples.add(
    _buildTextFieldExample(
      behavior: FloatingLabelBehavior.always,
      label: 'Username',
      hint: 'Choose a username',
      prefixIcon: Icons.person_outline,
      initialValue: '',
      stateDescription: 'Empty - Label still floats',
    ),
  );

  // Always behavior - with content
  textFieldExamples.add(
    _buildTextFieldExample(
      behavior: FloatingLabelBehavior.always,
      label: 'Username',
      hint: 'Choose a username',
      prefixIcon: Icons.person_outline,
      initialValue: 'john_doe',
      stateDescription: 'Has content - Label floats',
    ),
  );

  // Never behavior - empty field
  textFieldExamples.add(
    _buildTextFieldExample(
      behavior: FloatingLabelBehavior.never,
      label: 'Search',
      hint: 'Type to search',
      prefixIcon: Icons.search,
      initialValue: '',
      stateDescription: 'Empty - Label acts as placeholder',
    ),
  );

  // Never behavior - with content
  textFieldExamples.add(
    _buildTextFieldExample(
      behavior: FloatingLabelBehavior.never,
      label: 'Search',
      hint: 'Type to search',
      prefixIcon: Icons.search,
      initialValue: 'flutter widgets',
      stateDescription: 'Has content - Label hidden',
    ),
  );
  print('Created ${textFieldExamples.length} text field examples');

  // ============================================================
  // SECTION 3: Side-by-Side Comparison
  // ============================================================
  print('=== Section 3: Side-by-Side Comparison ===');

  final comparisonWidget = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare, color: Colors.indigo, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Side-by-Side Comparison',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'All three behaviors with identical empty fields:',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Auto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Label',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Always',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Label',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Never',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Label',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
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
  print('Created comparison widget');

  // ============================================================
  // SECTION 4: Form Use Cases
  // ============================================================
  print('=== Section 4: Form Use Cases ===');

  // Login Form (Auto behavior - most common)
  final loginForm = _buildFormCard(
    title: 'Login Form',
    subtitle: 'Uses Auto behavior (default)',
    icon: Icons.login,
    color: Colors.blue,
    behavior: FloatingLabelBehavior.auto,
    fields: [
      {'label': 'Email', 'icon': Icons.email, 'obscure': false},
      {'label': 'Password', 'icon': Icons.lock, 'obscure': true},
    ],
  );

  // Search Form (Never behavior)
  final searchForm = _buildFormCard(
    title: 'Search Interface',
    subtitle: 'Uses Never behavior - cleaner look',
    icon: Icons.search,
    color: Colors.orange,
    behavior: FloatingLabelBehavior.never,
    fields: [
      {'label': 'Search products...', 'icon': Icons.search, 'obscure': false},
    ],
  );

  // Registration Form (Always behavior)
  final registrationForm = _buildFormCard(
    title: 'Registration Form',
    subtitle: 'Uses Always behavior - clear field identification',
    icon: Icons.person_add,
    color: Colors.green,
    behavior: FloatingLabelBehavior.always,
    fields: [
      {'label': 'Full Name', 'icon': Icons.person, 'obscure': false},
      {'label': 'Email', 'icon': Icons.email, 'obscure': false},
      {'label': 'Phone', 'icon': Icons.phone, 'obscure': false},
    ],
  );

  print('Created form use case cards');

  // ============================================================
  // SECTION 5: InputDecoration Integration
  // ============================================================
  print('=== Section 5: InputDecoration Integration ===');

  final decorationExamples = <Widget>[];

  // Outlined border
  decorationExamples.add(
    _buildDecorationExample(
      title: 'Outlined Border',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      behavior: FloatingLabelBehavior.auto,
      color: Colors.indigo,
    ),
  );

  // Underline border
  decorationExamples.add(
    _buildDecorationExample(
      title: 'Underline Border',
      border: UnderlineInputBorder(),
      behavior: FloatingLabelBehavior.auto,
      color: Colors.teal,
    ),
  );

  // Rounded outlined
  decorationExamples.add(
    _buildDecorationExample(
      title: 'Rounded Border (Always)',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
      behavior: FloatingLabelBehavior.always,
      color: Colors.purple,
    ),
  );

  // Filled style
  decorationExamples.add(
    _buildDecorationExample(
      title: 'Filled Style',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
      behavior: FloatingLabelBehavior.auto,
      color: Colors.deepOrange,
      filled: true,
    ),
  );

  print('Created ${decorationExamples.length} decoration examples');

  // ============================================================
  // SECTION 6: Enum Methods and Properties
  // ============================================================
  print('=== Section 6: Enum Methods and Properties ===');

  final enumInfoCards = <Widget>[];

  // Values list
  final allValues = FloatingLabelBehavior.values;
  print('FloatingLabelBehavior.values: $allValues');
  print('values.length: ${allValues.length}');

  // Index access
  for (var i = 0; i < allValues.length; i++) {
    final value = allValues[i];
    print('values[$i] = ${value.name}');
    
    enumInfoCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$i',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FloatingLabelBehavior.${value.name}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      _buildEnumProperty('index', '${value.index}'),
                      SizedBox(width: 16.0),
                      _buildEnumProperty('name', '"${value.name}"'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Equality tests
  final testAuto = FloatingLabelBehavior.auto;
  final testAlways = FloatingLabelBehavior.always;
  print('auto == auto: ${testAuto == FloatingLabelBehavior.auto}');
  print('auto == always: ${testAuto == testAlways}');
  print('auto.hashCode: ${testAuto.hashCode}');

  final enumCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.blueGrey.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Enum Properties & Methods',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...enumInfoCards,
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Useful Enum Operations:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8.0),
              _buildCodeSnippet('FloatingLabelBehavior.values', '[auto, always, never]'),
              _buildCodeSnippet('behavior.name', '"auto"'),
              _buildCodeSnippet('behavior.index', '0'),
              _buildCodeSnippet('FloatingLabelBehavior.values[1]', 'always'),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created enum info card');

  // ============================================================
  // SECTION 7: Accessibility Considerations
  // ============================================================
  print('=== Section 7: Accessibility Considerations ===');

  final accessibilityItems = [
    {
      'icon': Icons.visibility,
      'title': 'Label Visibility',
      'description': 'Always behavior ensures labels are always visible, improving form comprehension for users with cognitive disabilities.',
      'recommendation': 'Use Always for complex forms',
    },
    {
      'icon': Icons.text_fields,
      'title': 'Placeholder vs Label',
      'description': 'Never behavior uses labels as placeholders. This can cause accessibility issues as the label disappears when typing.',
      'recommendation': 'Provide separate hintText with Never behavior',
    },
    {
      'icon': Icons.hearing,
      'title': 'Screen Reader Support',
      'description': 'All behaviors work with screen readers via semanticLabel. The label text is announced regardless of visual state.',
      'recommendation': 'Always set semanticLabel for accessibility',
    },
    {
      'icon': Icons.contrast,
      'title': 'Color Contrast',
      'description': 'Floating labels are typically smaller and may have reduced contrast. Ensure sufficient color contrast for readability.',
      'recommendation': 'Test with WCAG contrast requirements',
    },
  ];

  final accessibilityCards = <Widget>[];
  for (final item in accessibilityItems) {
    accessibilityCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.purple.shade100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                item['icon'] as IconData,
                color: Colors.purple.shade400,
                size: 24.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    item['description'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green.shade600, size: 14.0),
                        SizedBox(width: 4.0),
                        Text(
                          item['recommendation'] as String,
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.green.shade700,
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
      ),
    );
  }

  final accessibilityCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility_new, color: Colors.purple.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Accessibility Considerations',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...accessibilityCards,
      ],
    ),
  );
  print('Created accessibility card');

  // ============================================================
  // SECTION 8: API Reference Summary
  // ============================================================
  print('=== Section 8: API Reference Summary ===');

  final apiItems = [
    {
      'signature': 'FloatingLabelBehavior.auto',
      'description': 'Label floats when field is focused or has content. This is the default.',
      'icon': Icons.auto_mode,
    },
    {
      'signature': 'FloatingLabelBehavior.always',
      'description': 'Label always floats above the text field, regardless of state.',
      'icon': Icons.upload,
    },
    {
      'signature': 'FloatingLabelBehavior.never',
      'description': 'Label never floats. Acts as placeholder, hidden when there is content.',
      'icon': Icons.stop,
    },
    {
      'signature': 'FloatingLabelBehavior.values',
      'description': 'Static list containing all enum values: [auto, always, never].',
      'icon': Icons.list,
    },
    {
      'signature': 'behavior.name',
      'description': 'Returns the string name of the enum value (e.g., "auto").',
      'icon': Icons.label,
    },
    {
      'signature': 'behavior.index',
      'description': 'Returns the zero-based index in the enum definition.',
      'icon': Icons.tag,
    },
  ];

  final apiCards2 = <Widget>[];
  for (final api in apiItems) {
    apiCards2.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.cyan.shade100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.cyan.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                api['icon'] as IconData,
                color: Colors.cyan.shade600,
                size: 20.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    api['signature'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan.shade800,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    api['description'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade600,
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

  final apiSummaryCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Colors.cyan.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'API Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...apiCards2,
      ],
    ),
  );
  print('Created API summary card');

  // ============================================================
  // Final Layout Assembly
  // ============================================================
  print('FloatingLabelBehavior Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.text_fields, size: 48.0, color: Colors.white),
              SizedBox(height: 12.0),
              Text(
                'FloatingLabelBehavior',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Control how text field labels float and animate',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        // Section 1: Overview
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 1: Enum Overview', Icons.info_outline),
        Wrap(
          alignment: WrapAlignment.center,
          children: overviewCards,
        ),

        // Section 2: TextField Examples
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 2: TextField Examples', Icons.text_snippet),
        Wrap(
          alignment: WrapAlignment.center,
          children: textFieldExamples,
        ),

        // Section 3: Side-by-Side Comparison
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 3: Comparison', Icons.compare),
        comparisonWidget,

        // Section 4: Form Use Cases
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 4: Form Use Cases', Icons.assignment),
        loginForm,
        searchForm,
        registrationForm,

        // Section 5: InputDecoration Integration
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 5: Decoration Styles', Icons.style),
        Wrap(
          alignment: WrapAlignment.center,
          children: decorationExamples,
        ),

        // Section 6: Enum Properties
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 6: Enum Details', Icons.code),
        enumCard,

        // Section 7: Accessibility
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 7: Accessibility', Icons.accessibility_new),
        accessibilityCard,

        // Section 8: API Reference
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 8: API Reference', Icons.api),
        apiSummaryCard,

        SizedBox(height: 32.0),
      ],
    ),
  );
}

// Helper: Build section header
Widget _buildSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.grey.shade700),
        SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build text field example
Widget _buildTextFieldExample({
  required FloatingLabelBehavior behavior,
  required String label,
  required String hint,
  required IconData prefixIcon,
  required String initialValue,
  required String stateDescription,
}) {
  final colorMap = {
    FloatingLabelBehavior.auto: Colors.blue,
    FloatingLabelBehavior.always: Colors.green,
    FloatingLabelBehavior.never: Colors.orange,
  };
  final color = colorMap[behavior]!;

  print('TextField example: ${behavior.name}, $stateDescription');

  return Container(
    width: 280.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.label, size: 14.0, color: color),
              SizedBox(width: 4.0),
              Text(
                behavior.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            floatingLabelBehavior: behavior,
            prefixIcon: Icon(prefixIcon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: color, width: 2.0),
            ),
          ),
          readOnly: true,
        ),
        SizedBox(height: 8.0),
        Text(
          stateDescription,
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build form card
Widget _buildFormCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color color,
  required FloatingLabelBehavior behavior,
  required List<Map<String, dynamic>> fields,
}) {
  print('Form card: $title, behavior=${behavior.name}');

  final fieldWidgets = <Widget>[];
  for (final field in fields) {
    fieldWidgets.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child: TextField(
          obscureText: field['obscure'] as bool,
          decoration: InputDecoration(
            labelText: field['label'] as String,
            floatingLabelBehavior: behavior,
            prefixIcon: Icon(field['icon'] as IconData),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28.0),
              SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(children: fieldWidgets),
        ),
      ],
    ),
  );
}

// Helper: Build decoration example
Widget _buildDecorationExample({
  required String title,
  required InputBorder border,
  required FloatingLabelBehavior behavior,
  required Color color,
  bool filled = false,
}) {
  print('Decoration example: $title');

  return Container(
    width: 220.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 12.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Label',
            floatingLabelBehavior: behavior,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            filled: filled,
            fillColor: filled ? Colors.grey.shade100 : null,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build enum property chip
Widget _buildEnumProperty(String label, String value) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '$label: ',
        style: TextStyle(
          fontSize: 11.0,
          color: Colors.grey.shade500,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 11.0,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade700,
        ),
      ),
    ],
  );
}

// Helper: Build code snippet
Widget _buildCodeSnippet(String code, String result) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            code,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Icon(Icons.arrow_forward, size: 12.0, color: Colors.grey.shade400),
        SizedBox(width: 4.0),
        Text(
          result,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}
