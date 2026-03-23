// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Chip, InputChip, FilterChip, ChoiceChip, ActionChip from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Chip widgets test executing');

  // ========== CHIP ==========
  print('--- Chip Tests ---');

  // Test basic Chip
  final basicChip = Chip(label: Text('Basic Chip'));
  print('Basic Chip created');

  // Test Chip with avatar
  final avatarChip = Chip(
    avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
    label: Text('Avatar Chip'),
  );
  print('Chip with avatar created');

  // Test Chip with deleteIcon
  final deleteChip = Chip(
    label: Text('Deletable'),
    deleteIcon: Icon(Icons.cancel),
    onDeleted: () {
      print('Chip deleted');
    },
  );
  print('Chip with deleteIcon created');

  // Test Chip with deleteIconColor
  final deleteColorChip = Chip(
    label: Text('Delete Color'),
    deleteIconColor: Colors.red,
    onDeleted: () {},
  );
  print('Chip with deleteIconColor created');
  print('  Type: $deleteColorChip');

  // Test Chip with backgroundColor
  final bgColorChip = Chip(
    label: Text('Colored'),
    backgroundColor: Colors.purple.shade100,
  );
  print('Chip with backgroundColor created');

  // Test Chip with labelStyle
  final styleChip = Chip(
    label: Text('Styled'),
    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    backgroundColor: Colors.teal,
  );
  print('Chip with labelStyle created');

  // Test Chip with padding
  final paddedChip = Chip(
    label: Text('Padded'),
    labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(8.0),
  );
  print('Chip with padding created');
  print('  Type: $paddedChip');

  // Test Chip with shape
  final shapedChip = Chip(
    label: Text('Shaped'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
      side: BorderSide(color: Colors.blue),
    ),
  );
  print('Chip with shape created');

  // Test Chip with elevation
  final elevatedChip = Chip(
    label: Text('Elevated'),
    elevation: 8.0,
    shadowColor: Colors.black,
  );
  print('Chip with elevation created');

  // Test Chip with side
  final sideChip = Chip(
    label: Text('Bordered'),
    side: BorderSide(color: Colors.orange, width: 2.0),
  );
  print('Chip with side created');

  // ========== INPUTCHIP ==========
  print('--- InputChip Tests ---');

  // Test basic InputChip
  final basicInputChip = InputChip(
    label: Text('Input Chip'),
    onPressed: () {
      print('InputChip pressed');
    },
  );
  print('Basic InputChip created');

  // Test InputChip with avatar
  final avatarInputChip = InputChip(
    avatar: Icon(Icons.person, size: 18),
    label: Text('John'),
    onPressed: () {},
  );
  print('InputChip with avatar created');

  // Test InputChip with selected
  final selectedInputChip = InputChip(
    label: Text('Selected'),
    selected: true,
    onPressed: () {},
  );
  print('InputChip selected created');

  // Test InputChip with onSelected
  final selectableInputChip = InputChip(
    label: Text('Selectable'),
    onSelected: (bool selected) {
      print('InputChip selected: $selected');
    },
  );
  print('InputChip with onSelected created');
  print('  Type: $selectableInputChip');

  // Test InputChip with onDeleted
  final deletableInputChip = InputChip(
    label: Text('Remove'),
    onDeleted: () {
      print('InputChip deleted');
    },
  );
  print('InputChip with onDeleted created');

  // Test InputChip disabled
  final disabledInputChip = InputChip(
    label: Text('Disabled'),
    isEnabled: false,
  );
  print('Disabled InputChip created');

  // Test InputChip with selectedColor
  final coloredInputChip = InputChip(
    label: Text('Color Selected'),
    selected: true,
    selectedColor: Colors.green.shade100,
    onPressed: () {},
  );
  print('InputChip with selectedColor created');

  // Test InputChip with checkmarkColor
  final checkmarkInputChip = InputChip(
    label: Text('Checkmark'),
    selected: true,
    showCheckmark: true,
    checkmarkColor: Colors.purple,
    onPressed: () {},
  );
  print('InputChip with checkmarkColor created');

  // ========== FILTERCHIP ==========
  print('--- FilterChip Tests ---');

  // Test basic FilterChip
  final basicFilterChip = FilterChip(
    label: Text('Filter'),
    selected: false,
    onSelected: (bool selected) {
      print('FilterChip selected: $selected');
    },
  );
  print('Basic FilterChip created');

  // Test FilterChip selected
  final selectedFilterChip = FilterChip(
    label: Text('Active'),
    selected: true,
    onSelected: (selected) {},
  );
  print('FilterChip selected created');

  // Test FilterChip with avatar
  final avatarFilterChip = FilterChip(
    avatar: Icon(Icons.label, size: 18),
    label: Text('Tag'),
    selected: false,
    onSelected: (selected) {},
  );
  print('FilterChip with avatar created');

  // Test FilterChip with selectedColor
  final coloredFilterChip = FilterChip(
    label: Text('Yellow Selected'),
    selected: true,
    selectedColor: Colors.yellow.shade200,
    onSelected: (selected) {},
  );
  print('FilterChip with selectedColor created');

  // Test FilterChip with backgroundColor
  final bgFilterChip = FilterChip(
    label: Text('Background'),
    selected: false,
    backgroundColor: Colors.grey.shade200,
    onSelected: (selected) {},
  );
  print('FilterChip with backgroundColor created');
  print('  Type: $bgFilterChip');

  // Test FilterChip with showCheckmark
  final noCheckFilterChip = FilterChip(
    label: Text('No Check'),
    selected: true,
    showCheckmark: false,
    onSelected: (selected) {},
  );
  print('FilterChip showCheckmark=false created');

  // Test FilterChip with checkmarkColor
  final checkFilterChip = FilterChip(
    label: Text('Red Check'),
    selected: true,
    checkmarkColor: Colors.red,
    onSelected: (selected) {},
  );
  print('FilterChip with checkmarkColor created');

  // Test FilterChip disabled
  final disabledFilterChip = FilterChip(
    label: Text('Disabled'),
    selected: false,
    onSelected: null,
  );
  print('Disabled FilterChip created');

  // Test FilterChip with elevation
  final elevatedFilterChip = FilterChip(
    label: Text('Elevated'),
    selected: false,
    elevation: 4.0,
    onSelected: (selected) {},
  );
  print('FilterChip with elevation created');
  print('  Type: $elevatedFilterChip');

  // Test FilterChip with pressElevation
  final pressFilterChip = FilterChip(
    label: Text('Press Elevation'),
    selected: false,
    pressElevation: 8.0,
    onSelected: (selected) {},
  );
  print('FilterChip with pressElevation created');
  print('  Type: $pressFilterChip');

  // ========== CHOICECHIP ==========
  print('--- ChoiceChip Tests ---');

  // Test basic ChoiceChip
  final basicChoiceChip = ChoiceChip(
    label: Text('Choice'),
    selected: false,
    onSelected: (bool selected) {
      print('ChoiceChip selected: $selected');
    },
  );
  print('Basic ChoiceChip created');

  // Test ChoiceChip selected
  final selectedChoiceChip = ChoiceChip(
    label: Text('Selected Choice'),
    selected: true,
    onSelected: (selected) {},
  );
  print('ChoiceChip selected created');

  // Test ChoiceChip with avatar
  final avatarChoiceChip = ChoiceChip(
    avatar: CircleAvatar(child: Text('S')),
    label: Text('Small'),
    selected: true,
    onSelected: (selected) {},
  );
  print('ChoiceChip with avatar created');

  // Test ChoiceChip with selectedColor
  final coloredChoiceChip = ChoiceChip(
    label: Text('Blue Selected'),
    selected: true,
    selectedColor: Colors.blue.shade200,
    onSelected: (selected) {},
  );
  print('ChoiceChip with selectedColor created');

  // Test ChoiceChip with disabledColor
  final disabledColorChoiceChip = ChoiceChip(
    label: Text('Grey Disabled'),
    selected: false,
    disabledColor: Colors.grey.shade300,
    onSelected: null,
  );
  print('ChoiceChip with disabledColor created');

  // Test ChoiceChip with labelStyle
  final styleChoiceChip = ChoiceChip(
    label: Text('Styled'),
    selected: true,
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
    onSelected: (selected) {},
  );
  print('ChoiceChip with labelStyle created');
  print('  Type: $styleChoiceChip');

  // Test ChoiceChip with elevation
  final elevatedChoiceChip = ChoiceChip(
    label: Text('Elevated'),
    selected: false,
    elevation: 4.0,
    onSelected: (selected) {},
  );
  print('ChoiceChip with elevation created');
  print('  Type: $elevatedChoiceChip');

  // Test ChoiceChip with shape
  final shapedChoiceChip = ChoiceChip(
    label: Text('Shaped'),
    selected: true,
    shape: StadiumBorder(side: BorderSide(color: Colors.purple)),
    onSelected: (selected) {},
  );
  print('ChoiceChip with shape created');

  // ========== ACTIONCHIP ==========
  print('--- ActionChip Tests ---');

  // Test basic ActionChip
  final basicActionChip = ActionChip(
    label: Text('Action'),
    onPressed: () {
      print('ActionChip pressed');
    },
  );
  print('Basic ActionChip created');

  // Test ActionChip with avatar
  final avatarActionChip = ActionChip(
    avatar: Icon(Icons.add, size: 18),
    label: Text('Add'),
    onPressed: () {},
  );
  print('ActionChip with avatar created');

  // Test ActionChip with tooltip
  final tooltipActionChip = ActionChip(
    label: Text('Tooltip'),
    tooltip: 'This is a tooltip',
    onPressed: () {},
  );
  print('ActionChip with tooltip created');

  // Test ActionChip with backgroundColor
  final coloredActionChip = ActionChip(
    label: Text('Colored'),
    backgroundColor: Colors.orange.shade100,
    onPressed: () {},
  );
  print('ActionChip with backgroundColor created');

  // Test ActionChip with labelStyle
  final styleActionChip = ActionChip(
    label: Text('Styled Action'),
    labelStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    onPressed: () {},
  );
  print('ActionChip with labelStyle created');
  print('  Type: $styleActionChip');

  // Test ActionChip disabled
  final disabledActionChip = ActionChip(
    label: Text('Disabled'),
    onPressed: null,
  );
  print('Disabled ActionChip created');

  // Test ActionChip with elevation
  final elevatedActionChip = ActionChip(
    label: Text('Elevated'),
    elevation: 4.0,
    onPressed: () {},
  );
  print('ActionChip with elevation created');
  print('  Type: $elevatedActionChip');

  // Test ActionChip with pressElevation
  final pressActionChip = ActionChip(
    label: Text('Press'),
    pressElevation: 8.0,
    onPressed: () {},
  );
  print('ActionChip with pressElevation created');
  print('  Type: $pressActionChip');

  // Test ActionChip with side
  final sideActionChip = ActionChip(
    label: Text('Bordered'),
    side: BorderSide(color: Colors.green, width: 2.0),
    onPressed: () {},
  );
  print('ActionChip with side created');

  // Test ActionChip.elevated
  final elevatedActionVariant = ActionChip.elevated(
    label: Text('Elevated Variant'),
    onPressed: () {},
  );
  print('ActionChip.elevated created');

  print('Chip widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chip Widgets Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Chip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicChip,
            avatarChip,
            deleteChip,
            bgColorChip,
            styleChip,
            shapedChip,
            elevatedChip,
            sideChip,
          ],
        ),
        SizedBox(height: 16.0),

        Text('InputChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicInputChip,
            avatarInputChip,
            selectedInputChip,
            deletableInputChip,
            disabledInputChip,
            coloredInputChip,
            checkmarkInputChip,
          ],
        ),
        SizedBox(height: 16.0),

        Text('FilterChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicFilterChip,
            selectedFilterChip,
            avatarFilterChip,
            coloredFilterChip,
            noCheckFilterChip,
            checkFilterChip,
            disabledFilterChip,
          ],
        ),
        SizedBox(height: 16.0),

        Text('ChoiceChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicChoiceChip,
            selectedChoiceChip,
            avatarChoiceChip,
            coloredChoiceChip,
            disabledColorChoiceChip,
            shapedChoiceChip,
          ],
        ),
        SizedBox(height: 16.0),

        Text('ActionChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicActionChip,
            avatarActionChip,
            tooltipActionChip,
            coloredActionChip,
            disabledActionChip,
            sideActionChip,
            elevatedActionVariant,
          ],
        ),
      ],
    ),
  );
}
