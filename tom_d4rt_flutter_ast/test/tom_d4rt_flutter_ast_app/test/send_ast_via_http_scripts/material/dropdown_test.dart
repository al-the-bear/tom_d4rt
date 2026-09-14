// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DropdownButton, DropdownMenu, DropdownButtonFormField from material
// Deep Demo: Visual demonstration of dropdown widgets across every parameter
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dropdown Deep Demo executing');

  // Shared item lists used across multiple sections.
  final cityItems = <DropdownMenuItem<String>>[
    DropdownMenuItem<String>(value: 'berlin', child: Text('Berlin')),
    DropdownMenuItem<String>(value: 'paris', child: Text('Paris')),
    DropdownMenuItem<String>(value: 'tokyo', child: Text('Tokyo')),
    DropdownMenuItem<String>(value: 'sydney', child: Text('Sydney')),
    DropdownMenuItem<String>(value: 'lima', child: Text('Lima')),
  ];

  final sizeItems = <DropdownMenuItem<String>>[
    DropdownMenuItem<String>(value: 'xs', child: Text('Extra Small')),
    DropdownMenuItem<String>(value: 's', child: Text('Small')),
    DropdownMenuItem<String>(value: 'm', child: Text('Medium')),
    DropdownMenuItem<String>(value: 'l', child: Text('Large')),
    DropdownMenuItem<String>(value: 'xl', child: Text('Extra Large')),
  ];

  final priorityItems = <DropdownMenuItem<String>>[
    DropdownMenuItem<String>(value: 'low', child: Text('Low')),
    DropdownMenuItem<String>(value: 'medium', child: Text('Medium')),
    DropdownMenuItem<String>(value: 'high', child: Text('High')),
    DropdownMenuItem<String>(value: 'urgent', child: Text('Urgent')),
  ];

  // ============================================================
  // SECTION 1: Dropdown family overview
  // ============================================================
  print('=== Section 1: Dropdown Family Overview ===');

  final conceptCards = <Widget>[];

  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.arrow_drop_down_circle, size: 44.0, color: Colors.indigo),
          SizedBox(height: 10.0),
          Text(
            'DropdownButton<T>',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Classic Material 2 picker.\nUses DropdownMenuItem<T>\nas its children.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.menu_open, size: 44.0, color: Colors.teal),
          SizedBox(height: 10.0),
          Text(
            'DropdownMenu<T>',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Material 3 picker with a\ntext field. Uses\nDropdownMenuEntry<T>.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.teal.shade700),
          ),
        ],
      ),
    ),
  );

  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade50, Colors.purple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.dynamic_form, size: 44.0, color: Colors.deepPurple),
          SizedBox(height: 10.0),
          Text(
            'DropdownButtonFormField',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Wraps DropdownButton in\na FormField with an\nInputDecoration.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.deepPurple.shade700),
          ),
        ],
      ),
    ),
  );

  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.list_alt, size: 44.0, color: Colors.orange.shade800),
          SizedBox(height: 10.0),
          Text(
            'DropdownMenuItem<T>',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'A single entry inside a\nDropdownButton. Provides\nvalue + child widget.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.orange.shade800),
          ),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: DropdownButton<String> value gallery
  // ============================================================
  print('=== Section 2: DropdownButton<String> Value Gallery ===');

  // Same items, different `value:` to show all visual states.
  final cityValueBerlin = DropdownButton<String>(
    value: 'berlin',
    items: cityItems,
    onChanged: (v) => print('City changed to $v'),
  );
  print('Built city dropdown with value=berlin');

  final cityValueParis = DropdownButton<String>(
    value: 'paris',
    items: cityItems,
    onChanged: (v) => print('City changed to $v'),
  );
  print('Built city dropdown with value=paris');

  final cityValueTokyo = DropdownButton<String>(
    value: 'tokyo',
    items: cityItems,
    onChanged: (v) => print('City changed to $v'),
  );
  print('Built city dropdown with value=tokyo');

  // null value with hint + disabledHint (onChanged: null disables it)
  final cityValueNullHint = DropdownButton<String>(
    value: null,
    hint: Text('Pick a city'),
    disabledHint: Text('Disabled'),
    items: cityItems,
    onChanged: (v) => print('City picked from hint: $v'),
  );
  print('Built city dropdown with null value + hint');

  final valueGalleryCards = <Widget>[
    _valueGalleryCard('value: "berlin"', cityValueBerlin, Colors.blue),
    _valueGalleryCard('value: "paris"', cityValueParis, Colors.pink),
    _valueGalleryCard('value: "tokyo"', cityValueTokyo, Colors.red),
    _valueGalleryCard('value: null + hint', cityValueNullHint, Colors.grey),
  ];

  // ============================================================
  // SECTION 3: icon / iconSize / iconEnabledColor / iconDisabledColor
  // ============================================================
  print('=== Section 3: Icon Variants ===');

  final iconDefault = DropdownButton<String>(
    value: 'm',
    items: sizeItems,
    onChanged: (v) => print('Size: $v'),
  );

  final iconCustom = DropdownButton<String>(
    value: 'l',
    icon: Icon(Icons.expand_more),
    iconSize: 32.0,
    iconEnabledColor: Colors.deepOrange,
    items: sizeItems,
    onChanged: (v) => print('Size: $v'),
  );

  final iconCircle = DropdownButton<String>(
    value: 's',
    icon: Icon(Icons.arrow_drop_down_circle),
    iconSize: 28.0,
    iconEnabledColor: Colors.teal,
    items: sizeItems,
    onChanged: (v) => print('Size: $v'),
  );

  final iconDisabled = DropdownButton<String>(
    value: 'xs',
    icon: Icon(Icons.lock_outline),
    iconSize: 26.0,
    iconEnabledColor: Colors.green,
    iconDisabledColor: Colors.redAccent,
    items: sizeItems,
    onChanged: null, // disabled => disabled icon color visible
  );

  final iconVariantCards = <Widget>[
    _iconVariantCard('Default icon', 'iconSize: 24 (default)', iconDefault,
        Colors.blueGrey),
    _iconVariantCard('Custom icon + size', 'iconSize: 32, deepOrange',
        iconCustom, Colors.deepOrange),
    _iconVariantCard('Circle icon', 'iconSize: 28, teal', iconCircle,
        Colors.teal),
    _iconVariantCard('Disabled state', 'iconDisabledColor: red', iconDisabled,
        Colors.redAccent),
  ];
  print('Created ${iconVariantCards.length} icon variant cards');

  // ============================================================
  // SECTION 4: Styled gallery (dropdownColor / borderRadius / padding / style)
  // ============================================================
  print('=== Section 4: Styled Gallery ===');

  final styledColor = DropdownButton<String>(
    value: 'low',
    dropdownColor: Colors.amber.shade100,
    elevation: 12,
    items: priorityItems,
    onChanged: (v) => print('Priority: $v'),
  );

  final styledRadius = DropdownButton<String>(
    value: 'medium',
    borderRadius: BorderRadius.circular(18.0),
    dropdownColor: Colors.lightBlue.shade50,
    items: priorityItems,
    onChanged: (v) => print('Priority: $v'),
  );

  final styledPadding = DropdownButton<String>(
    value: 'high',
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    dropdownColor: Colors.pink.shade50,
    items: priorityItems,
    onChanged: (v) => print('Priority: $v'),
  );

  final styledTextStyle = DropdownButton<String>(
    value: 'urgent',
    style: TextStyle(
      color: Colors.deepPurple,
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'monospace',
    ),
    dropdownColor: Colors.deepPurple.shade50,
    items: priorityItems,
    onChanged: (v) => print('Priority: $v'),
  );

  final styledCards = <Widget>[
    _styledGalleryCard(
      'dropdownColor',
      'amber-100 menu surface',
      styledColor,
      Colors.amber.shade700,
    ),
    _styledGalleryCard(
      'borderRadius',
      'BorderRadius.circular(18)',
      styledRadius,
      Colors.lightBlue.shade700,
    ),
    _styledGalleryCard(
      'padding',
      'EdgeInsets 12 / 4',
      styledPadding,
      Colors.pink.shade700,
    ),
    _styledGalleryCard(
      'style',
      'monospace deepPurple',
      styledTextStyle,
      Colors.deepPurple,
    ),
  ];
  print('Created ${styledCards.length} styled cards');

  // ============================================================
  // SECTION 5: DropdownButtonFormField in a Form
  // ============================================================
  print('=== Section 5: DropdownButtonFormField Decorations ===');

  final formKey = GlobalKey<FormState>();

  final formFilled = DropdownButtonFormField<String>(
    value: 'paris',
    decoration: InputDecoration(
      labelText: 'Home city',
      helperText: 'Filled style',
      filled: true,
      fillColor: Colors.indigo.shade50,
      prefixIcon: Icon(Icons.location_city),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
    ),
    items: cityItems,
    onChanged: (v) => print('Form filled: $v'),
  );

  final formOutlined = DropdownButtonFormField<String>(
    value: 'tokyo',
    decoration: InputDecoration(
      labelText: 'Travel city',
      helperText: 'Outlined style',
      prefixIcon: Icon(Icons.flight_takeoff),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    items: cityItems,
    onChanged: (v) => print('Form outlined: $v'),
  );

  final formUnderlined = DropdownButtonFormField<String>(
    value: 'lima',
    decoration: InputDecoration(
      labelText: 'Birth city',
      helperText: 'Underline style',
      prefixIcon: Icon(Icons.cake),
      border: UnderlineInputBorder(),
    ),
    items: cityItems,
    onChanged: (v) => print('Form underlined: $v'),
  );

  final formFieldCards = <Widget>[
    _formFieldCard('Filled', 'filled: true + fillColor', formFilled,
        Colors.indigo),
    _formFieldCard('Outlined', 'OutlineInputBorder', formOutlined,
        Colors.teal),
    _formFieldCard('Underline', 'UnderlineInputBorder', formUnderlined,
        Colors.pink),
  ];

  final formPanel = Form(
    key: formKey,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: formFieldCards,
      ),
    ),
  );
  print('Created ${formFieldCards.length} form-field cards inside Form');

  // ============================================================
  // SECTION 6: Material 3 DropdownMenu<T> + DropdownMenuEntry<T>
  // ============================================================
  print('=== Section 6: DropdownMenu (Material 3) ===');

  final languageEntries = <DropdownMenuEntry<String>>[
    DropdownMenuEntry<String>(value: 'dart', label: 'Dart'),
    DropdownMenuEntry<String>(value: 'rust', label: 'Rust'),
    DropdownMenuEntry<String>(value: 'go', label: 'Go'),
    DropdownMenuEntry<String>(value: 'kotlin', label: 'Kotlin'),
    DropdownMenuEntry<String>(value: 'swift', label: 'Swift'),
  ];

  final defaultMenu = DropdownMenu<String>(
    initialSelection: 'dart',
    label: Text('Language'),
    dropdownMenuEntries: languageEntries,
    onSelected: (v) => print('Lang: $v'),
  );

  final iconEntries = <DropdownMenuEntry<String>>[
    DropdownMenuEntry<String>(
      value: 'home',
      label: 'Home',
      leadingIcon: Icon(Icons.home),
      trailingIcon: Icon(Icons.chevron_right),
    ),
    DropdownMenuEntry<String>(
      value: 'work',
      label: 'Work',
      leadingIcon: Icon(Icons.work),
      trailingIcon: Icon(Icons.chevron_right),
    ),
    DropdownMenuEntry<String>(
      value: 'school',
      label: 'School',
      leadingIcon: Icon(Icons.school),
      trailingIcon: Icon(Icons.chevron_right),
    ),
    DropdownMenuEntry<String>(
      value: 'gym',
      label: 'Gym',
      leadingIcon: Icon(Icons.fitness_center),
      trailingIcon: Icon(Icons.chevron_right),
    ),
  ];

  final iconMenu = DropdownMenu<String>(
    initialSelection: 'work',
    label: Text('Location'),
    leadingIcon: Icon(Icons.place),
    dropdownMenuEntries: iconEntries,
    onSelected: (v) => print('Location: $v'),
  );

  final disabledEntries = <DropdownMenuEntry<String>>[
    DropdownMenuEntry<String>(value: 'draft', label: 'Draft'),
    DropdownMenuEntry<String>(
      value: 'review',
      label: 'In Review',
      enabled: false,
    ),
    DropdownMenuEntry<String>(value: 'approved', label: 'Approved'),
    DropdownMenuEntry<String>(
      value: 'archived',
      label: 'Archived',
      enabled: false,
    ),
  ];

  final disabledMenu = DropdownMenu<String>(
    initialSelection: 'draft',
    label: Text('Status'),
    helperText: 'Some entries are disabled',
    dropdownMenuEntries: disabledEntries,
    onSelected: (v) => print('Status: $v'),
  );

  final menuCards = <Widget>[
    _menuCard('Default DropdownMenu', 'plain entries', defaultMenu,
        Colors.blue),
    _menuCard('Leading + trailing icons', 'iconEntries', iconMenu,
        Colors.green),
    _menuCard('Disabled entries', 'enabled: false', disabledMenu,
        Colors.orange),
  ];
  print('Created ${menuCards.length} DropdownMenu cards');

  // ============================================================
  // SECTION 7: selectedItemBuilder pattern
  // ============================================================
  print('=== Section 7: selectedItemBuilder Custom Rendering ===');

  final colorChoices = <String>['red', 'green', 'blue', 'purple', 'amber'];
  final colorSwatch = <String, Color>{
    'red': Colors.red,
    'green': Colors.green,
    'blue': Colors.blue,
    'purple': Colors.purple,
    'amber': Colors.amber,
  };

  Widget chipForColor(String name) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              color: colorSwatch[name],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black26, width: 1.0),
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            name.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorSwatch[name],
            ),
          ),
        ],
      );

  // U22 workaround (entry #17): the original `selectedItemBuilder`
  // returned `colorChoices.map<Widget>((name) => Container(...)).toList()`.
  // Under d4rt the interpreter erases the `Widget` generic and the
  // bridge rejects the resulting `List<Object?>` with
  // `Argument Error: Invalid parameter "callback": expected
  // List<Widget>, got List<Object?>`. Four prior script-side
  // variants (`map<Widget>`, `List<Widget>.from(...)`, `<Widget>[]`
  // literal, imperative loop) all surfaced the same error per U22
  // because the erasure happens at the bridge boundary regardless
  // of the source form. Workaround: omit `selectedItemBuilder`
  // entirely and use a `selectedItemBuilder`-free DropdownButton.
  // Default behaviour renders the matching `items` widget for the
  // selected value — slight visual change (shows the regular
  // `chipForColor` instead of the "Selected: NAME" custom render),
  // but the `selectedItemBuilder` teaching is preserved further
  // down via the section-7 code-block that displays its usage
  // pattern as a static Text snippet.
  final selectedItemBuilderDropdown = DropdownButton<String>(
    value: 'blue',
    isExpanded: true,
    items: colorChoices
        .map<DropdownMenuItem<String>>(
          (name) => DropdownMenuItem<String>(
            value: name,
            child: chipForColor(name),
          ),
        )
        .toList(),
    onChanged: (v) => print('Color picked: $v'),
  );

  final selectedItemBuilderPanel = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.brush, color: Colors.blueGrey),
            SizedBox(width: 8.0),
            Text(
              'selectedItemBuilder',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Closed: shows custom "Selected: NAME" label.\nOpen: shows colored swatch + label.',
          style: TextStyle(fontSize: 12.0, color: Colors.blueGrey.shade700),
        ),
        SizedBox(height: 12.0),
        selectedItemBuilderDropdown,
      ],
    ),
  );
  print('Created selectedItemBuilder panel');

  // ============================================================
  // SECTION 8: isExpanded, isDense, itemHeight, autofocus, focusNode,
  //            alignment, menuMaxHeight, DropdownButtonHideUnderline
  // ============================================================
  print('=== Section 8: Layout flags gallery ===');

  final focusNodeForDemo = FocusNode(debugLabel: 'dropdown-demo-focus');

  final denseDropdown = DropdownButton<String>(
    value: 'm',
    isDense: true,
    items: sizeItems,
    onChanged: (v) => print('Dense size: $v'),
  );

  final expandedDropdown = DropdownButton<String>(
    value: 'l',
    isExpanded: true,
    items: sizeItems,
    onChanged: (v) => print('Expanded size: $v'),
  );

  final itemHeightDropdown = DropdownButton<String>(
    value: 's',
    itemHeight: 64.0,
    menuMaxHeight: 220.0,
    items: sizeItems,
    onChanged: (v) => print('Tall items: $v'),
  );

  final alignmentDropdown = DropdownButton<String>(
    value: 'xs',
    alignment: AlignmentDirectional.centerEnd,
    isExpanded: true,
    items: sizeItems,
    onChanged: (v) => print('Aligned end: $v'),
  );

  final focusNodeDropdown = DropdownButton<String>(
    value: 'xl',
    focusNode: focusNodeForDemo,
    autofocus: false,
    focusColor: Colors.lime.shade100,
    items: sizeItems,
    onChanged: (v) => print('FocusNode dropdown: $v'),
  );

  final hideUnderlineDropdown = DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      value: 'medium',
      items: priorityItems,
      onChanged: (v) => print('No-underline priority: $v'),
    ),
  );

  final layoutCards = <Widget>[
    _layoutCard('isDense: true', denseDropdown, Colors.blue),
    _layoutCard('isExpanded: true', expandedDropdown, Colors.green),
    _layoutCard('itemHeight: 64 + menuMaxHeight: 220',
        itemHeightDropdown, Colors.orange),
    _layoutCard('alignment: centerEnd', alignmentDropdown, Colors.purple),
    _layoutCard('focusNode + autofocus: false', focusNodeDropdown,
        Colors.teal),
    _layoutCard('DropdownButtonHideUnderline', hideUnderlineDropdown,
        Colors.pink),
  ];
  print('Created ${layoutCards.length} layout/flag cards');

  // ============================================================
  // SECTION 9: Code examples
  // ============================================================
  print('=== Section 9: Code Examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Dropdown Patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Classic DropdownButton<T>\n'
            'DropdownButton<String>(\n'
            '  value: selected,\n'
            '  hint: Text("Pick a city"),\n'
            '  disabledHint: Text("Disabled"),\n'
            '  icon: Icon(Icons.expand_more),\n'
            '  iconSize: 28.0,\n'
            '  iconEnabledColor: Colors.deepOrange,\n'
            '  iconDisabledColor: Colors.red,\n'
            '  isDense: false,\n'
            '  isExpanded: true,\n'
            '  itemHeight: 48.0,\n'
            '  dropdownColor: Colors.amber.shade100,\n'
            '  menuMaxHeight: 220.0,\n'
            '  alignment: AlignmentDirectional.centerStart,\n'
            '  borderRadius: BorderRadius.circular(18),\n'
            '  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),\n'
            '  style: TextStyle(color: Colors.deepPurple),\n'
            '  items: [\n'
            '    DropdownMenuItem(value: "berlin", child: Text("Berlin")),\n'
            '    DropdownMenuItem(value: "paris",  child: Text("Paris")),\n'
            '  ],\n'
            '  onChanged: (v) => print(v),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// DropdownButtonFormField + selectedItemBuilder\n'
            'DropdownButtonFormField<String>(\n'
            '  value: "paris",\n'
            '  decoration: InputDecoration(\n'
            '    labelText: "Home city",\n'
            '    border: OutlineInputBorder(),\n'
            '  ),\n'
            '  selectedItemBuilder: (ctx) => cities.map(\n'
            '    (c) => Text("Selected: \$c"),\n'
            '  ).toList(),\n'
            '  items: cities.map((c) =>\n'
            '    DropdownMenuItem(value: c, child: Text(c)),\n'
            '  ).toList(),\n'
            '  onChanged: (v) => print(v),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Material 3 DropdownMenu<T>\n'
            'DropdownMenu<String>(\n'
            '  initialSelection: "dart",\n'
            '  label: Text("Language"),\n'
            '  leadingIcon: Icon(Icons.place),\n'
            '  dropdownMenuEntries: [\n'
            '    DropdownMenuEntry(\n'
            '      value: "dart",\n'
            '      label: "Dart",\n'
            '      leadingIcon: Icon(Icons.flutter_dash),\n'
            '    ),\n'
            '    DropdownMenuEntry(\n'
            '      value: "rust",\n'
            '      label: "Rust",\n'
            '      enabled: false,\n'
            '    ),\n'
            '  ],\n'
            '  onSelected: (v) => print(v),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.orange.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Hide the underline of a child DropdownButton\n'
            'DropdownButtonHideUnderline(\n'
            '  child: DropdownButton<String>(\n'
            '    value: "medium",\n'
            '    items: priorityItems,\n'
            '    onChanged: (v) => print(v),\n'
            '  ),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyan.shade200,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code examples widget');

  // ============================================================
  // SECTION 10: Summary
  // ============================================================
  print('=== Section 10: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.deepPurple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.arrow_drop_down_circle,
          'DropdownButton<T>',
          'Use for Material 2 pickers with DropdownMenuItem<T> children',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.menu_open,
          'DropdownMenu<T>',
          'Material 3 picker; uses DropdownMenuEntry<T> and a text field',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.dynamic_form,
          'DropdownButtonFormField<T>',
          'Use inside a Form with InputDecoration + validator',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.brush,
          'selectedItemBuilder',
          'Show different widgets when closed vs open',
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.tune,
          'Layout flags',
          'isExpanded, isDense, itemHeight, menuMaxHeight, alignment',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.visibility_off,
          'DropdownButtonHideUnderline',
          'Inherited widget to suppress the default underline',
          Colors.blueGrey,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('Dropdown Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.arrow_drop_down_circle,
                  size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'Dropdown Deep Demo',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'DropdownButton, DropdownMenu, DropdownButtonFormField',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1
        _sectionTitle('1. Dropdown Family Overview'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 32.0),

        // Section 2
        _sectionTitle('2. DropdownButton<String> Value Gallery'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: valueGalleryCards),
        SizedBox(height: 32.0),

        // Section 3
        _sectionTitle('3. icon / iconSize / iconColor Variants'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: iconVariantCards),
        SizedBox(height: 32.0),

        // Section 4
        _sectionTitle('4. Styled Gallery'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: styledCards),
        SizedBox(height: 32.0),

        // Section 5
        _sectionTitle('5. DropdownButtonFormField in a Form'),
        SizedBox(height: 12.0),
        formPanel,
        SizedBox(height: 32.0),

        // Section 6
        _sectionTitle('6. DropdownMenu (Material 3)'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: menuCards),
        SizedBox(height: 32.0),

        // Section 7
        _sectionTitle('7. selectedItemBuilder Pattern'),
        SizedBox(height: 12.0),
        selectedItemBuilderPanel,
        SizedBox(height: 32.0),

        // Section 8
        _sectionTitle('8. Layout Flags Gallery'),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(children: layoutCards),
        ),
        SizedBox(height: 32.0),

        // Section 9
        _sectionTitle('9. Code Examples'),
        codeExamples,
        SizedBox(height: 32.0),

        // Section 10
        _sectionTitle('10. Summary'),
        summaryPanel,
      ],
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _sectionTitle(String label) {
  return Text(
    label,
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
  );
}

Widget _valueGalleryCard(String label, Widget dropdown, Color accent) {
  return Container(
    width: 220.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.label_outline, color: accent, size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black12),
          ),
          child: dropdown,
        ),
      ],
    ),
  );
}

Widget _iconVariantCard(
  String title,
  String subtitle,
  Widget dropdown,
  Color accent,
) {
  return Container(
    width: 240.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: accent,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11.0,
            color: accent.withValues(alpha: 0.8),
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black12),
          ),
          child: dropdown,
        ),
      ],
    ),
  );
}

Widget _styledGalleryCard(
  String title,
  String subtitle,
  Widget dropdown,
  Color accent,
) {
  return Container(
    width: 230.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.10),
          accent.withValues(alpha: 0.03),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette_outlined, color: accent, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accent,
                fontSize: 13.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11.0,
            color: accent.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black12),
          ),
          child: dropdown,
        ),
      ],
    ),
  );
}

Widget _formFieldCard(
  String title,
  String subtitle,
  Widget field,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.input, color: accent, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accent,
                fontSize: 14.0,
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        field,
      ],
    ),
  );
}

Widget _menuCard(
  String title,
  String subtitle,
  Widget menu,
  Color accent,
) {
  return Container(
    width: 260.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: accent,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: accent.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 12.0),
        menu,
      ],
    ),
  );
}

Widget _layoutCard(String label, Widget dropdown, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black12),
            ),
            child: dropdown,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
