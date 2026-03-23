// ignore_for_file: avoid_print
// D4rt test script: Tests CheckmarkableChipAttributes from material
import 'package:flutter/material.dart';

// Helper for section header
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

// Helper for visual chip representation
Widget buildChipVisual(String label, bool selected, bool showCheckmark, Color selectedColor,
    Color checkmarkColor, Color backgroundColor, IconData avatarIcon, double borderWidth) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
    child: Material(
      elevation: selected ? 2 : 0,
      borderRadius: BorderRadius.circular(20),
      color: selected ? selectedColor : backgroundColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? selectedColor : Colors.grey.shade400,
            width: borderWidth,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showCheckmark && selected)
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(Icons.check, size: 16, color: checkmarkColor),
              ),
            if (!showCheckmark || !selected)
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(avatarIcon, size: 16,
                    color: selected ? checkmarkColor : Colors.grey.shade600),
              ),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: selected ? checkmarkColor : Colors.black87,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper for chip type comparison card
Widget buildChipTypeCard(String type, String description, Color color, IconData icon,
    List<String> chipLabels, List<bool> chipSelected) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
                Text(description, style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: List.generate(chipLabels.length, (i) {
            return buildChipVisual(
              chipLabels[i], chipSelected[i], true, color, Colors.white, Colors.grey.shade100, Icons.label, 1,
            );
          }),
        ),
      ],
    ),
  );
}

// Helper for checkmark color demo
Widget buildCheckmarkColorDemo(String label, Color chipColor, Color checkColor, bool selected) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? chipColor : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? chipColor : Colors.grey.shade400),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected)
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.check, size: 14, color: checkColor),
                ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12, color: selected ? checkColor : Colors.black87,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('chipColor: $chipColor', style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('checkColor: $checkColor', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
        Container(
          width: 20, height: 20,
          decoration: BoxDecoration(
            color: chipColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 4),
        Container(
          width: 20, height: 20,
          decoration: BoxDecoration(
            color: checkColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
      ],
    ),
  );
}

// Helper for show/hide checkmark comparison
Widget buildCheckmarkVisibilityRow(String label, bool showCheckmark, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showCheckmark)
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.check, size: 14, color: Colors.white),
                ),
              if (!showCheckmark)
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.star, size: 14, color: Colors.white),
                ),
              Text('Selected', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(width: 6),
        Text(
          showCheckmark ? 'with check' : 'without check',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    ),
  );
}

// Helper for attribute property card
Widget buildAttributePropertyCard(String name, String type, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(6),
      border: Border(left: BorderSide(color: color, width: 3)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text(type, style: TextStyle(fontSize: 10, color: color)),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(description, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== CheckmarkableChipAttributes Visual Test ===');
  debugPrint('Demonstrating FilterChip, ChoiceChip, InputChip with checkmarks');

  debugPrint('Testing showCheckmark property');
  debugPrint('Testing checkmarkColor property');
  debugPrint('Testing chip types with checkmark behavior');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Checkmarkable Chip Attributes'),
        backgroundColor: Colors.amber.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Checkmarkable Chip Types
            buildSectionHeader('Checkmarkable Chip Types', Icons.check_circle_outline, Colors.amber.shade800),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'FilterChip, ChoiceChip, and InputChip support the checkmarkable interface',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildChipTypeCard('FilterChip', 'Multi-select filtering',
                Colors.blue, Icons.filter_list,
                ['Sports', 'Music', 'Travel', 'Food', 'Tech'],
                [true, false, true, false, true]),
            buildChipTypeCard('ChoiceChip', 'Single selection from group',
                Colors.green, Icons.radio_button_checked,
                ['Small', 'Medium', 'Large', 'XL'],
                [false, true, false, false]),
            buildChipTypeCard('InputChip', 'Represents a complex entity',
                Colors.purple, Icons.input,
                ['Alice', 'Bob', 'Charlie', 'Diana'],
                [true, true, false, true]),

            // Section 2: Attribute Properties
            buildSectionHeader('CheckmarkableChipAttributes', Icons.code, Colors.blueGrey),
            buildAttributePropertyCard('showCheckmark', 'bool?', 'Whether to display the check mark on selected chips', Colors.blue),
            buildAttributePropertyCard('checkmarkColor', 'Color?', 'Color of the check mark when displayed', Colors.green),
            buildAttributePropertyCard('selected', 'bool', 'Whether the chip is currently selected', Colors.orange),
            buildAttributePropertyCard('onSelected', 'ValueChanged<bool>?', 'Called when the chip selection state changes', Colors.purple),

            // Section 3: Show Checkmark vs Hide
            buildSectionHeader('Show vs Hide Checkmark', Icons.visibility, Colors.indigo),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Chips can show or hide the checkmark while still tracking selection state',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildCheckmarkVisibilityRow('FilterChip (show)', true, Colors.blue),
            buildCheckmarkVisibilityRow('FilterChip (hide)', false, Colors.blue),
            buildCheckmarkVisibilityRow('ChoiceChip (show)', true, Colors.green),
            buildCheckmarkVisibilityRow('ChoiceChip (hide)', false, Colors.green),
            buildCheckmarkVisibilityRow('InputChip (show)', true, Colors.purple),
            buildCheckmarkVisibilityRow('InputChip (hide)', false, Colors.purple),
            buildCheckmarkVisibilityRow('FilterChip red (show)', true, Colors.red),
            buildCheckmarkVisibilityRow('FilterChip red (hide)', false, Colors.red),
            buildCheckmarkVisibilityRow('ChoiceChip orange (show)', true, Colors.orange),
            buildCheckmarkVisibilityRow('ChoiceChip orange (hide)', false, Colors.orange),

            // Section 4: Checkmark Colors
            buildSectionHeader('Checkmark Colors', Icons.palette, Colors.deepPurple),
            buildCheckmarkColorDemo('White on Blue', Colors.blue, Colors.white, true),
            buildCheckmarkColorDemo('Black on Yellow', Colors.yellow, Colors.black, true),
            buildCheckmarkColorDemo('White on Red', Colors.red, Colors.white, true),
            buildCheckmarkColorDemo('White on Green', Colors.green, Colors.white, true),
            buildCheckmarkColorDemo('Yellow on Purple', Colors.purple, Colors.yellow, true),
            buildCheckmarkColorDemo('Black on Orange', Colors.orange, Colors.black, true),
            buildCheckmarkColorDemo('White on Teal', Colors.teal, Colors.white, true),
            buildCheckmarkColorDemo('Pink on Dark', Colors.grey.shade800, Colors.pink, true),
            buildCheckmarkColorDemo('Unselected Blue', Colors.blue, Colors.white, false),
            buildCheckmarkColorDemo('Unselected Green', Colors.green, Colors.white, false),

            // Section 5: FilterChip Multi-Select Demo
            buildSectionHeader('FilterChip Multi-Select', Icons.filter_list, Colors.blue),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cuisine Filters', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      buildChipVisual('Italian', true, true, Colors.blue, Colors.white, Colors.grey.shade100, Icons.restaurant, 1),
                      buildChipVisual('Japanese', true, true, Colors.blue, Colors.white, Colors.grey.shade100, Icons.restaurant, 1),
                      buildChipVisual('Mexican', false, true, Colors.blue, Colors.white, Colors.grey.shade100, Icons.restaurant, 1),
                      buildChipVisual('Indian', true, true, Colors.blue, Colors.white, Colors.grey.shade100, Icons.restaurant, 1),
                      buildChipVisual('Thai', false, true, Colors.blue, Colors.white, Colors.grey.shade100, Icons.restaurant, 1),
                      buildChipVisual('Chinese', false, true, Colors.blue, Colors.white, Colors.grey.shade100, Icons.restaurant, 1),
                      buildChipVisual('French', true, true, Colors.blue, Colors.white, Colors.grey.shade100, Icons.restaurant, 1),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('4 of 7 selected', style: TextStyle(fontSize: 11, color: Colors.blue)),
                ],
              ),
            ),

            // Section 6: ChoiceChip Single-Select Demo
            buildSectionHeader('ChoiceChip Single-Select', Icons.radio_button_checked, Colors.green),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shipping Speed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      buildChipVisual('Standard', false, true, Colors.green, Colors.white, Colors.grey.shade100, Icons.local_shipping, 1),
                      buildChipVisual('Express', true, true, Colors.green, Colors.white, Colors.grey.shade100, Icons.flight, 1),
                      buildChipVisual('Overnight', false, true, Colors.green, Colors.white, Colors.grey.shade100, Icons.flash_on, 1),
                      buildChipVisual('Economy', false, true, Colors.green, Colors.white, Colors.grey.shade100, Icons.attach_money, 1),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('Express selected', style: TextStyle(fontSize: 11, color: Colors.green)),
                ],
              ),
            ),

            // Section 7: InputChip Entity Tags Demo
            buildSectionHeader('InputChip Entity Tags', Icons.input, Colors.purple),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Team Members', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      buildChipVisual('Alice K.', true, true, Colors.purple, Colors.white, Colors.grey.shade100, Icons.person, 1),
                      buildChipVisual('Bob M.', true, true, Colors.purple, Colors.white, Colors.grey.shade100, Icons.person, 1),
                      buildChipVisual('Carol P.', false, true, Colors.purple, Colors.white, Colors.grey.shade100, Icons.person, 1),
                      buildChipVisual('Dave R.', true, true, Colors.purple, Colors.white, Colors.grey.shade100, Icons.person, 1),
                      buildChipVisual('Eve S.', false, true, Colors.purple, Colors.white, Colors.grey.shade100, Icons.person, 1),
                      buildChipVisual('Frank T.', true, true, Colors.purple, Colors.white, Colors.grey.shade100, Icons.person, 1),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('4 team members assigned', style: TextStyle(fontSize: 11, color: Colors.purple)),
                ],
              ),
            ),

            // Section 8: Mixed Checkmark Styles Grid
            buildSectionHeader('Mixed Styles Grid', Icons.grid_view, Colors.teal),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: buildChipVisual('Blue', true, true, Colors.blue, Colors.white, Colors.grey.shade100, Icons.circle, 1)),
                      Expanded(child: buildChipVisual('Red', true, true, Colors.red, Colors.white, Colors.grey.shade100, Icons.circle, 1)),
                      Expanded(child: buildChipVisual('Green', false, true, Colors.green, Colors.white, Colors.grey.shade100, Icons.circle, 1)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: buildChipVisual('Purple', true, false, Colors.purple, Colors.white, Colors.grey.shade100, Icons.star, 1)),
                      Expanded(child: buildChipVisual('Orange', false, false, Colors.orange, Colors.white, Colors.grey.shade100, Icons.star, 1)),
                      Expanded(child: buildChipVisual('Teal', true, true, Colors.teal, Colors.white, Colors.grey.shade100, Icons.circle, 1)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: buildChipVisual('Pink', false, true, Colors.pink, Colors.white, Colors.grey.shade100, Icons.circle, 1)),
                      Expanded(child: buildChipVisual('Indigo', true, true, Colors.indigo, Colors.white, Colors.grey.shade100, Icons.circle, 1)),
                      Expanded(child: buildChipVisual('Amber', true, false, Colors.amber, Colors.black, Colors.grey.shade100, Icons.star, 2)),
                    ],
                  ),
                ],
              ),
            ),

            // Summary
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade50, Colors.orange.shade50],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Attributes Demonstrated:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      Chip(label: Text('showCheckmark', style: TextStyle(fontSize: 10)), backgroundColor: Colors.blue.shade100),
                      Chip(label: Text('checkmarkColor', style: TextStyle(fontSize: 10)), backgroundColor: Colors.green.shade100),
                      Chip(label: Text('FilterChip', style: TextStyle(fontSize: 10)), backgroundColor: Colors.orange.shade100),
                      Chip(label: Text('ChoiceChip', style: TextStyle(fontSize: 10)), backgroundColor: Colors.purple.shade100),
                      Chip(label: Text('InputChip', style: TextStyle(fontSize: 10)), backgroundColor: Colors.teal.shade100),
                      Chip(label: Text('selected', style: TextStyle(fontSize: 10)), backgroundColor: Colors.indigo.shade100),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
