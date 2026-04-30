// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DeletableChipAttributes from material
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF37474F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}

// Helper to build a demo card
Widget buildDemoCard(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

// Helper: info row
Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0xFF616161),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Color(0xFF212121)),
          ),
        ),
      ],
    ),
  );
}

// Helper: chip with delete button
Widget buildDeletableChip(
  String label,
  Color bgColor,
  Color fgColor,
  Color deleteIconColor,
  IconData deleteIcon,
  bool useAvatar,
  IconData avatarIcon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    child: Chip(
      avatar: useAvatar
          ? CircleAvatar(
              backgroundColor: fgColor,
              child: Icon(avatarIcon, size: 16, color: bgColor),
            )
          : null,
      label: Text(label, style: TextStyle(color: fgColor, fontSize: 13)),
      backgroundColor: bgColor,
      deleteIcon: Icon(deleteIcon, size: 18, color: deleteIconColor),
      onDeleted: () {
        debugPrint('Deleted chip: $label');
      },
      deleteButtonTooltipMessage: 'Remove $label',
    ),
  );
}

// Helper: input chip with delete
Widget buildInputChip(
  String label,
  Color bgColor,
  Color fgColor,
  bool isSelected,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    child: InputChip(
      label: Text(label, style: TextStyle(color: fgColor, fontSize: 13)),
      backgroundColor: bgColor,
      selected: isSelected,
      selectedColor: Color(0xFFBBDEFB),
      deleteIcon: Icon(Icons.cancel, size: 18),
      onDeleted: () {
        debugPrint('Input chip deleted: $label');
      },
      onSelected: (v) {
        debugPrint('Input chip selected: $label = $v');
      },
    ),
  );
}

// Helper: filter chip row with delete
Widget buildFilterChipRow(String label, bool isSelected, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    child: FilterChip(
      label: Text(label, style: TextStyle(fontSize: 13)),
      selected: isSelected,
      selectedColor: color,
      checkmarkColor: Color(0xFFFFFFFF),
      onSelected: (v) {
        debugPrint('Filter: $label = $v');
      },
    ),
  );
}

// Helper: chip size demo
Widget buildChipSizeDemo(
  String sizeLabel,
  double padding,
  double fontSize,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            sizeLabel,
            style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
          ),
        ),
        Chip(
          label: Text(
            'Sample Chip',
            style: TextStyle(fontSize: fontSize, color: Color(0xFFFFFFFF)),
          ),
          backgroundColor: color,
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding / 2,
          ),
          deleteIcon: Icon(
            Icons.close,
            size: fontSize + 2,
            color: Color(0xB3FFFFFF),
          ),
          onDeleted: () {
            debugPrint('Size $sizeLabel deleted');
          },
        ),
      ],
    ),
  );
}

// Helper: chip with custom delete icon
Widget buildCustomDeleteChip(
  String label,
  IconData icon,
  Color chipColor,
  Color iconColor,
) {
  return Container(
    margin: EdgeInsets.all(4),
    child: Chip(
      label: Text(
        label,
        style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
      ),
      backgroundColor: chipColor,
      deleteIcon: Icon(icon, size: 18, color: iconColor),
      onDeleted: () {
        debugPrint('Custom delete: $label');
      },
    ),
  );
}

// Helper: tag-style chip
Widget buildTagChip(String tag, Color color) {
  return Container(
    margin: EdgeInsets.all(3),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          tag,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 6),
        GestureDetector(
          onTap: () {
            debugPrint('Remove tag: $tag');
          },
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Color(0x33FFFFFF),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.close, size: 10, color: Color(0xFFFFFFFF)),
          ),
        ),
      ],
    ),
  );
}

// Helper: email-style chip
Widget buildEmailChip(String name, String email, Color avatarColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Chip(
      avatar: CircleAvatar(
        backgroundColor: avatarColor,
        child: Text(
          name.substring(0, 1),
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          Text(email, style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
        ],
      ),
      deleteIcon: Icon(Icons.cancel, size: 18, color: Color(0xFF757575)),
      onDeleted: () {
        debugPrint('Remove email: $email');
      },
      backgroundColor: Color(0xFFF5F5F5),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    ),
  );
}

// Helper: chip state display
Widget buildChipStateRow(
  String state,
  bool isEnabled,
  bool hasDeleteIcon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: isEnabled ? Color(0xFFF5F5F5) : Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            state,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isEnabled ? Color(0xFF424242) : Color(0xFFBDBDBD),
            ),
          ),
        ),
        if (hasDeleteIcon)
          Icon(
            Icons.cancel,
            size: 16,
            color: isEnabled ? color : Color(0xFFBDBDBD),
          ),
        SizedBox(width: 8),
        Text(
          isEnabled ? 'Enabled' : 'Disabled',
          style: TextStyle(
            fontSize: 11,
            color: isEnabled ? Color(0xFF4CAF50) : Color(0xFFBDBDBD),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== DeletableChipAttributes Deep Demo ===');
  debugPrint('Testing chips with delete functionality, styles, and states');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DeletableChipAttributes Deep Demo'),
        backgroundColor: Color(0xFF37474F),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: DeletableChipAttributes Overview
            buildSectionHeader('1. DeletableChipAttributes Interface'),
            buildDemoCard(
              'Properties defined by the DeletableChipAttributes mixin',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow(
                    'onDeleted',
                    'Callback when delete icon is tapped',
                  ),
                  buildInfoRow(
                    'deleteIcon',
                    'Custom icon widget for delete button',
                  ),
                  buildInfoRow('deleteIconColor', 'Color of the delete icon'),
                  buildInfoRow(
                    'deleteButtonTooltipMessage',
                    'Tooltip shown on long press',
                  ),
                  buildInfoRow(
                    'useDeleteButtonTooltip',
                    'Whether to show the tooltip',
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Implemented by: Chip, InputChip, FilterChip (selected only)',
                    style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                  ),
                ],
              ),
            ),
            Text(
              'Section 1: Overview displayed',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 2: Basic Deletable Chips
            buildSectionHeader('2. Basic Deletable Chips'),
            buildDemoCard(
              'Simple chips with delete icons',
              Wrap(
                children: [
                  buildDeletableChip(
                    'Flutter',
                    Color(0xFF1565C0),
                    Color(0xFFFFFFFF),
                    Color(0xB3FFFFFF),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                  buildDeletableChip(
                    'Dart',
                    Color(0xFF00695C),
                    Color(0xFFFFFFFF),
                    Color(0xB3FFFFFF),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                  buildDeletableChip(
                    'Firebase',
                    Color(0xFFE65100),
                    Color(0xFFFFFFFF),
                    Color(0xB3FFFFFF),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                  buildDeletableChip(
                    'Material',
                    Color(0xFF6A1B9A),
                    Color(0xFFFFFFFF),
                    Color(0xB3FFFFFF),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                  buildDeletableChip(
                    'Cupertino',
                    Color(0xFF37474F),
                    Color(0xFFFFFFFF),
                    Color(0xB3FFFFFF),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                ],
              ),
            ),
            Text(
              'Section 2: Basic chips rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 3: Chips with Avatars
            buildSectionHeader('3. Chips with Avatars and Delete'),
            buildDemoCard(
              'Chips with both avatar and delete icon',
              Wrap(
                children: [
                  buildDeletableChip(
                    'Alice',
                    Color(0xFFE3F2FD),
                    Color(0xFF1565C0),
                    Color(0xFF1565C0),
                    Icons.close,
                    true,
                    Icons.person,
                  ),
                  buildDeletableChip(
                    'Bob',
                    Color(0xFFE8F5E9),
                    Color(0xFF2E7D32),
                    Color(0xFF2E7D32),
                    Icons.close,
                    true,
                    Icons.person,
                  ),
                  buildDeletableChip(
                    'Carol',
                    Color(0xFFFCE4EC),
                    Color(0xFFC62828),
                    Color(0xFFC62828),
                    Icons.close,
                    true,
                    Icons.person,
                  ),
                  buildDeletableChip(
                    'David',
                    Color(0xFFF3E5F5),
                    Color(0xFF6A1B9A),
                    Color(0xFF6A1B9A),
                    Icons.close,
                    true,
                    Icons.person,
                  ),
                ],
              ),
            ),
            Text(
              'Section 3: Avatars + delete rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 4: Custom Delete Icons
            buildSectionHeader('4. Custom Delete Icons'),
            buildDemoCard(
              'Different delete icon styles',
              Wrap(
                children: [
                  buildCustomDeleteChip(
                    'Cancel icon',
                    Icons.cancel,
                    Color(0xFF1565C0),
                    Color(0xB3FFFFFF),
                  ),
                  buildCustomDeleteChip(
                    'Close icon',
                    Icons.close,
                    Color(0xFF2E7D32),
                    Color(0xB3FFFFFF),
                  ),
                  buildCustomDeleteChip(
                    'Remove circle',
                    Icons.remove_circle,
                    Color(0xFFC62828),
                    Color(0xB3FFFFFF),
                  ),
                  buildCustomDeleteChip(
                    'Delete outline',
                    Icons.delete_outline,
                    Color(0xFFE65100),
                    Color(0xB3FFFFFF),
                  ),
                  buildCustomDeleteChip(
                    'Clear icon',
                    Icons.clear,
                    Color(0xFF6A1B9A),
                    Color(0xB3FFFFFF),
                  ),
                  buildCustomDeleteChip(
                    'Backspace',
                    Icons.backspace,
                    Color(0xFF37474F),
                    Color(0xB3FFFFFF),
                  ),
                ],
              ),
            ),
            Text(
              'Section 4: Custom delete icons rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 5: InputChip with Delete
            buildSectionHeader('5. InputChip with Delete'),
            buildDemoCard(
              'InputChips respond to both selection and deletion',
              Wrap(
                children: [
                  buildInputChip(
                    'Python',
                    Color(0xFFF5F5F5),
                    Color(0xFF424242),
                    false,
                  ),
                  buildInputChip(
                    'JavaScript',
                    Color(0xFFF5F5F5),
                    Color(0xFF424242),
                    true,
                  ),
                  buildInputChip(
                    'Kotlin',
                    Color(0xFFF5F5F5),
                    Color(0xFF424242),
                    false,
                  ),
                  buildInputChip(
                    'Swift',
                    Color(0xFFF5F5F5),
                    Color(0xFF424242),
                    true,
                  ),
                  buildInputChip(
                    'Rust',
                    Color(0xFFF5F5F5),
                    Color(0xFF424242),
                    false,
                  ),
                ],
              ),
            ),
            Text(
              'Section 5: InputChip with delete rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 6: Filter Chips (selection only)
            buildSectionHeader('6. Filter Chips (No Delete)'),
            buildDemoCard(
              'FilterChips use selection, not deletion',
              Wrap(
                children: [
                  buildFilterChipRow('Small', false, Color(0xFFBBDEFB)),
                  buildFilterChipRow('Medium', true, Color(0xFFBBDEFB)),
                  buildFilterChipRow('Large', false, Color(0xFFBBDEFB)),
                  buildFilterChipRow('XL', true, Color(0xFFBBDEFB)),
                ],
              ),
            ),
            buildDemoCard(
              'Note: FilterChip does not implement DeletableChipAttributes',
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Color(0xFFFFCC80)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, size: 18, color: Color(0xFFE65100)),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'FilterChip uses onSelected callback, not onDeleted. Use InputChip or Chip for delete functionality.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFBF360C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Section 6: Filter chips rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 7: Tag Cloud with Delete
            buildSectionHeader('7. Tag Cloud Pattern'),
            buildDemoCard(
              'Removable tag cloud (custom chip pattern)',
              Wrap(
                children: [
                  buildTagChip('flutter', Color(0xFF1565C0)),
                  buildTagChip('dart', Color(0xFF00695C)),
                  buildTagChip('material-design', Color(0xFF6A1B9A)),
                  buildTagChip('responsive', Color(0xFFE65100)),
                  buildTagChip('cross-platform', Color(0xFFC62828)),
                  buildTagChip('open-source', Color(0xFF37474F)),
                  buildTagChip('mobile', Color(0xFF283593)),
                  buildTagChip('web', Color(0xFF00838F)),
                  buildTagChip('desktop', Color(0xFF4E342E)),
                ],
              ),
            ),
            Text(
              'Section 7: Tag cloud rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 8: Email-Style Chips
            buildSectionHeader('8. Email Recipient Chips'),
            buildDemoCard(
              'Deletable chips for email recipients',
              Column(
                children: [
                  buildEmailChip(
                    'Alice Johnson',
                    'alice@example.com',
                    Color(0xFF1565C0),
                  ),
                  buildEmailChip(
                    'Bob Smith',
                    'bob@example.com',
                    Color(0xFF2E7D32),
                  ),
                  buildEmailChip(
                    'Carol White',
                    'carol@example.com',
                    Color(0xFFC62828),
                  ),
                  buildEmailChip(
                    'David Brown',
                    'david@example.com',
                    Color(0xFF6A1B9A),
                  ),
                ],
              ),
            ),
            Text(
              'Section 8: Email chips rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 9: Chip Sizes
            buildSectionHeader('9. Chip Size Variations'),
            buildDemoCard(
              'Different padding and font sizes',
              Column(
                children: [
                  buildChipSizeDemo('Small', 4, 11, Color(0xFF37474F)),
                  buildChipSizeDemo('Medium', 8, 13, Color(0xFF546E7A)),
                  buildChipSizeDemo('Large', 12, 15, Color(0xFF78909C)),
                  buildChipSizeDemo('XL', 16, 17, Color(0xFF90A4AE)),
                ],
              ),
            ),
            Text(
              'Section 9: Chip sizes rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 10: Chip States
            buildSectionHeader('10. Chip Delete States'),
            buildDemoCard(
              'Various chip interaction states',
              Column(
                children: [
                  buildChipStateRow(
                    'Normal (deletable)',
                    true,
                    true,
                    Color(0xFF37474F),
                  ),
                  buildChipStateRow('Hovered', true, true, Color(0xFF1976D2)),
                  buildChipStateRow('Pressed', true, true, Color(0xFF0D47A1)),
                  buildChipStateRow(
                    'Selected + Deletable',
                    true,
                    true,
                    Color(0xFF4CAF50),
                  ),
                  buildChipStateRow('Disabled', false, true, Color(0xFFBDBDBD)),
                  buildChipStateRow(
                    'No delete icon',
                    true,
                    false,
                    Color(0xFF757575),
                  ),
                ],
              ),
            ),
            Text(
              'Section 10: Chip states rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 11: Color Themed Chip Sets
            buildSectionHeader('11. Themed Chip Collections'),
            buildDemoCard(
              'Blue theme chip set',
              Wrap(
                children: [
                  buildDeletableChip(
                    'Primary',
                    Color(0xFF1565C0),
                    Color(0xFFFFFFFF),
                    Color(0xB3FFFFFF),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                  buildDeletableChip(
                    'Light',
                    Color(0xFFBBDEFB),
                    Color(0xFF0D47A1),
                    Color(0xFF0D47A1),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                  buildDeletableChip(
                    'Outline',
                    Color(0xFFFFFFFF),
                    Color(0xFF1565C0),
                    Color(0xFF1565C0),
                    Icons.close,
                    false,
                    Icons.code,
                  ),
                ],
              ),
            ),
            buildDemoCard(
              'Green theme chip set',
              Wrap(
                children: [
                  buildDeletableChip(
                    'Primary',
                    Color(0xFF2E7D32),
                    Color(0xFFFFFFFF),
                    Color(0xB3FFFFFF),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                  buildDeletableChip(
                    'Light',
                    Color(0xFFC8E6C9),
                    Color(0xFF1B5E20),
                    Color(0xFF1B5E20),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                  buildDeletableChip(
                    'Outline',
                    Color(0xFFFFFFFF),
                    Color(0xFF2E7D32),
                    Color(0xFF2E7D32),
                    Icons.close,
                    false,
                    Icons.code,
                  ),
                ],
              ),
            ),
            buildDemoCard(
              'Red theme chip set',
              Wrap(
                children: [
                  buildDeletableChip(
                    'Primary',
                    Color(0xFFC62828),
                    Color(0xFFFFFFFF),
                    Color(0xB3FFFFFF),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                  buildDeletableChip(
                    'Light',
                    Color(0xFFFFCDD2),
                    Color(0xFFB71C1C),
                    Color(0xFFB71C1C),
                    Icons.cancel,
                    false,
                    Icons.code,
                  ),
                  buildDeletableChip(
                    'Outline',
                    Color(0xFFFFFFFF),
                    Color(0xFFC62828),
                    Color(0xFFC62828),
                    Icons.close,
                    false,
                    Icons.code,
                  ),
                ],
              ),
            ),
            Text(
              'Section 11: Themed chip sets rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Summary
            buildSectionHeader('Summary'),
            buildDemoCard(
              'DeletableChipAttributes Features Demonstrated',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('1', 'DeletableChipAttributes interface'),
                  buildInfoRow('2', 'Basic deletable chips'),
                  buildInfoRow('3', 'Chips with avatars + delete'),
                  buildInfoRow('4', 'Custom delete icon variations'),
                  buildInfoRow('5', 'InputChip with selection + delete'),
                  buildInfoRow('6', 'FilterChip (no delete support)'),
                  buildInfoRow('7', 'Tag cloud with removable tags'),
                  buildInfoRow('8', 'Email recipient chip pattern'),
                  buildInfoRow('9', 'Chip size variations'),
                  buildInfoRow('10', 'Chip interaction states'),
                  buildInfoRow('11', 'Themed chip collections'),
                ],
              ),
            ),
            Text(
              '=== DeletableChipAttributes Deep Demo Complete ===',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
