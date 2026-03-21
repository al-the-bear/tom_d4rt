// D4rt test script: Tests MenuAcceleratorLabel from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
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

Widget buildOverview() {
  print('Building MenuAcceleratorLabel overview');
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
            Icon(Icons.text_fields, color: Colors.teal.shade700, size: 28),
            SizedBox(width: 12),
            Text(
              'MenuAcceleratorLabel',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'A widget that displays a label with an underlined accelerator character. '
          'It parses labels like "&File" to display "File" with the "F" underlined, '
          'indicating the keyboard accelerator for menu navigation.',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        buildInfoCard('Type', 'StatelessWidget'),
        buildInfoCard('Purpose', 'Display accelerator hints in menu items'),
        buildInfoCard('Syntax', 'Use & before the accelerator character'),
        buildInfoCard('Example', '"&File" -> "F̲ile" (F underlined)'),
      ],
    ),
  );
}

Widget buildBasicAcceleratorLabel(String label, String description) {
  print('Building basic accelerator label: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: MenuAcceleratorLabel(label),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Label: "$label"',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildAcceleratorComparison() {
  print('Building accelerator comparison grid');
  List<Map<String, String>> labels = [
    {'label': '&File', 'desc': 'First character underlined'},
    {'label': 'E&dit', 'desc': 'Second character underlined'},
    {'label': 'Vie&w', 'desc': 'Fourth character underlined'},
    {'label': '&New', 'desc': 'N is the accelerator'},
    {'label': '&Open', 'desc': 'O is the accelerator'},
    {'label': '&Save', 'desc': 'S is the accelerator'},
    {'label': 'Save &As', 'desc': 'A is the accelerator'},
    {'label': '&Quit', 'desc': 'Q is the accelerator'},
  ];

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
          'Accelerator Position Examples',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'The & character marks which letter becomes the accelerator',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: labels.map((item) {
            return Container(
              width: 180,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MenuAcceleratorLabel(item['label']!),
                  SizedBox(height: 6),
                  Text(
                    item['desc']!,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget buildMenuItemContext() {
  print('Building menu item context demo');
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
          'Labels in Menu Item Context',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'How accelerator labels appear in typical menu structures',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              _buildSimulatedMenuItem(
                Icons.insert_drive_file,
                '&New',
                'Ctrl+N',
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              _buildSimulatedMenuItem(Icons.folder_open, '&Open', 'Ctrl+O'),
              Divider(height: 1, color: Colors.grey.shade300),
              _buildSimulatedMenuItem(Icons.save, '&Save', 'Ctrl+S'),
              Divider(height: 1, color: Colors.grey.shade300),
              _buildSimulatedMenuItem(
                Icons.save_as,
                'Save &As...',
                'Ctrl+Shift+S',
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              _buildSimulatedMenuItem(Icons.print, '&Print', 'Ctrl+P'),
              Divider(height: 1, color: Colors.grey.shade300),
              _buildSimulatedMenuItem(Icons.exit_to_app, 'E&xit', 'Alt+F4'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSimulatedMenuItem(IconData icon, String label, String shortcut) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade700),
        SizedBox(width: 12),
        Expanded(child: MenuAcceleratorLabel(label)),
        Text(
          shortcut,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget buildStyledLabels() {
  print('Building styled accelerator labels');
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
          'Styled Accelerator Labels',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Labels with different text styling applied',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        _buildStyledLabel('&Bold Text', Colors.blue, FontWeight.bold, 16),
        SizedBox(height: 8),
        _buildStyledLabel(
          '&Italic Style',
          Colors.purple,
          FontWeight.normal,
          16,
          isItalic: true,
        ),
        SizedBox(height: 8),
        _buildStyledLabel('&Large Font', Colors.teal, FontWeight.w500, 20),
        SizedBox(height: 8),
        _buildStyledLabel('&Small Font', Colors.orange, FontWeight.w400, 12),
        SizedBox(height: 8),
        _buildStyledLabel('&Red Color', Colors.red, FontWeight.w500, 14),
        SizedBox(height: 8),
        _buildStyledLabel('&Green Color', Colors.green, FontWeight.w500, 14),
      ],
    ),
  );
}

Widget _buildStyledLabel(
  String label,
  Color color,
  FontWeight fontWeight,
  double fontSize, {
  bool isItalic = false,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        DefaultTextStyle(
          style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
            fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          ),
          child: MenuAcceleratorLabel(label),
        ),
        Spacer(),
        Text(
          'color: $color',
          style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
        ),
      ],
    ),
  );
}

Widget buildParsingDemonstration() {
  print('Building accelerator parsing demo');
  List<Map<String, String>> examples = [
    {'input': '&File', 'output': 'File', 'note': 'F is underlined'},
    {'input': 'E&dit', 'output': 'Edit', 'note': 'd is underlined'},
    {
      'input': '&&Ampersand',
      'output': '&Ampersand',
      'note': '&& displays literal &',
    },
    {
      'input': 'No Accelerator',
      'output': 'No Accelerator',
      'note': 'No & means no underline',
    },
    {'input': 'End&', 'output': 'End', 'note': 'Trailing & is ignored'},
    {'input': '&', 'output': '', 'note': 'Just & produces empty'},
  ];

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
          'Accelerator Parsing Rules',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'How different input patterns are parsed and displayed',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Table(
          border: TableBorder.all(color: Colors.grey.shade300, width: 1),
          columnWidths: {
            0: FlexColumnWidth(1.5),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.teal.shade100),
              children: [
                _buildTableCell('Input', isHeader: true),
                _buildTableCell('Rendered', isHeader: true),
                _buildTableCell('Note', isHeader: true),
              ],
            ),
            ...examples.map((ex) {
              return TableRow(
                children: [
                  _buildTableCell(ex['input']!, isCode: true),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: MenuAcceleratorLabel(ex['input']!),
                  ),
                  _buildTableCell(ex['note']!),
                ],
              );
            }),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTableCell(
  String text, {
  bool isHeader = false,
  bool isCode = false,
}) {
  return Container(
    padding: EdgeInsets.all(8),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 13,
        fontFamily: isCode ? 'monospace' : null,
        color: isHeader ? Colors.teal.shade900 : Colors.grey.shade700,
      ),
    ),
  );
}

Widget buildRowLayouts() {
  print('Building row layout examples');
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
          'Labels in Row Layouts',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Accelerator labels arranged in different row configurations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Text(
          'Horizontal Menu Bar Style:',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuBarItem('&File'),
              _buildMenuBarItem('&Edit'),
              _buildMenuBarItem('&View'),
              _buildMenuBarItem('&Help'),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Spaced Row Layout:',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSpacedItem('&Copy', Icons.copy),
            _buildSpacedItem('&Paste', Icons.paste),
            _buildSpacedItem('C&ut', Icons.cut),
            _buildSpacedItem('&Delete', Icons.delete),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Icon + Label Row:',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _buildIconLabelItem(Icons.home, '&Home'),
            SizedBox(width: 16),
            _buildIconLabelItem(Icons.settings, '&Settings'),
            SizedBox(width: 16),
            _buildIconLabelItem(Icons.help, '&Help'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildMenuBarItem(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: MenuAcceleratorLabel(label),
  );
}

Widget _buildSpacedItem(String label, IconData icon) {
  return Column(
    children: [
      Icon(icon, color: Colors.teal.shade600, size: 24),
      SizedBox(height: 4),
      MenuAcceleratorLabel(label),
    ],
  );
}

Widget _buildIconLabelItem(IconData icon, String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.teal.shade700),
        SizedBox(width: 8),
        MenuAcceleratorLabel(label),
      ],
    ),
  );
}

Widget buildUnderlineStyles() {
  print('Building custom underline style examples');
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
          'Underline Style Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different visual styles for accelerator emphasis',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        _buildUnderlineExample('Standard Underline', '&Standard'),
        SizedBox(height: 12),
        _buildUnderlineExample(
          'In Bold Context',
          '&Bold Example',
          isBold: true,
        ),
        SizedBox(height: 12),
        _buildUnderlineExample('Large Text', '&Large', fontSize: 22),
        SizedBox(height: 12),
        _buildUnderlineExample(
          'Colored Text',
          '&Colored',
          textColor: Colors.purple,
        ),
        SizedBox(height: 12),
        _buildUnderlineExample(
          'With Background',
          '&Background',
          bgColor: Colors.amber.shade100,
        ),
      ],
    ),
  );
}

Widget _buildUnderlineExample(
  String title,
  String label, {
  bool isBold = false,
  double fontSize = 14,
  Color textColor = Colors.black87,
  Color bgColor = Colors.transparent,
}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bgColor == Colors.transparent ? Colors.grey.shade50 : bgColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(width: 16),
        Spacer(),
        DefaultTextStyle(
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: textColor,
          ),
          child: MenuAcceleratorLabel(label),
        ),
      ],
    ),
  );
}

Widget buildAcceleratorGrid() {
  print('Building accelerator grid showcase');
  List<String> items = [
    '&Apple',
    '&Banana',
    '&Cherry',
    '&Date',
    '&Elderberry',
    '&Fig',
    '&Grape',
    '&Honeydew',
    '&Imbe',
    '&Jackfruit',
    '&Kiwi',
    '&Lemon',
  ];

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
          'Grid of Accelerator Examples',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'A collection of labels demonstrating different accelerator positions',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: MenuAcceleratorLabel(item),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        Text(
          'Mid-word Accelerators:',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['C&opy', 'Pa&ste', 'Cu&t', 'Sele&ct All', 'Un&do', 'Re&do']
              .map((item) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: MenuAcceleratorLabel(item),
                );
              })
              .toList(),
        ),
      ],
    ),
  );
}

Widget buildMenuWithAccelerators() {
  print('Building full menu with accelerator labels');
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
          'Complete Menu Demo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'A typical application menu structure with accelerator labels',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildMenuColumn('File', _fileMenuItems())),
            SizedBox(width: 16),
            Expanded(child: _buildMenuColumn('Edit', _editMenuItems())),
            SizedBox(width: 16),
            Expanded(child: _buildMenuColumn('View', _viewMenuItems())),
          ],
        ),
      ],
    ),
  );
}

List<Map<String, dynamic>> _fileMenuItems() {
  return [
    {'label': '&New', 'icon': Icons.note_add, 'shortcut': 'Ctrl+N'},
    {'label': '&Open', 'icon': Icons.folder_open, 'shortcut': 'Ctrl+O'},
    {'label': '&Save', 'icon': Icons.save, 'shortcut': 'Ctrl+S'},
    {'label': 'Save &As...', 'icon': Icons.save_as, 'shortcut': 'Ctrl+Shift+S'},
    {'label': '&Print', 'icon': Icons.print, 'shortcut': 'Ctrl+P'},
    {'label': 'E&xit', 'icon': Icons.exit_to_app, 'shortcut': 'Alt+F4'},
  ];
}

List<Map<String, dynamic>> _editMenuItems() {
  return [
    {'label': '&Undo', 'icon': Icons.undo, 'shortcut': 'Ctrl+Z'},
    {'label': '&Redo', 'icon': Icons.redo, 'shortcut': 'Ctrl+Y'},
    {'label': 'Cu&t', 'icon': Icons.cut, 'shortcut': 'Ctrl+X'},
    {'label': '&Copy', 'icon': Icons.copy, 'shortcut': 'Ctrl+C'},
    {'label': '&Paste', 'icon': Icons.paste, 'shortcut': 'Ctrl+V'},
    {'label': '&Find', 'icon': Icons.search, 'shortcut': 'Ctrl+F'},
  ];
}

List<Map<String, dynamic>> _viewMenuItems() {
  return [
    {'label': '&Zoom In', 'icon': Icons.zoom_in, 'shortcut': 'Ctrl++'},
    {'label': 'Zoom &Out', 'icon': Icons.zoom_out, 'shortcut': 'Ctrl+-'},
    {'label': '&Full Screen', 'icon': Icons.fullscreen, 'shortcut': 'F11'},
    {'label': '&Status Bar', 'icon': Icons.view_sidebar, 'shortcut': ''},
    {'label': '&Toolbar', 'icon': Icons.view_compact, 'shortcut': ''},
    {'label': 'Si&debar', 'icon': Icons.view_sidebar, 'shortcut': 'Ctrl+B'},
  ];
}

Widget _buildMenuColumn(String title, List<Map<String, dynamic>> items) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.teal.shade600,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        ...items.map((item) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                Icon(
                  item['icon'] as IconData,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 8),
                Expanded(child: MenuAcceleratorLabel(item['label'] as String)),
                if ((item['shortcut'] as String).isNotEmpty)
                  Text(
                    item['shortcut'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                      fontFamily: 'monospace',
                    ),
                  ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

Widget buildColoredAccelerators() {
  print('Building colored accelerator showcase');
  List<Map<String, dynamic>> coloredLabels = [
    {'label': '&Red Action', 'color': Colors.red},
    {'label': '&Blue Action', 'color': Colors.blue},
    {'label': '&Green Action', 'color': Colors.green},
    {'label': '&Orange Action', 'color': Colors.orange},
    {'label': '&Purple Action', 'color': Colors.purple},
    {'label': '&Teal Action', 'color': Colors.teal},
  ];

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
          'Colored Accelerator Labels',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Labels with different color schemes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(
          children: coloredLabels.map((item) {
            Color color = item['color'] as Color;
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withAlpha(80)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 12),
                  DefaultTextStyle(
                    style: TextStyle(color: color, fontSize: 14),
                    child: MenuAcceleratorLabel(item['label'] as String),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('MenuAcceleratorLabel deep demo starting');

  List<Widget> sections = [];

  sections.add(buildSectionHeader('1. Overview of MenuAcceleratorLabel'));
  sections.add(buildOverview());

  sections.add(buildSectionHeader('2. Basic Accelerator Labels'));
  sections.add(
    buildBasicAcceleratorLabel(
      '&File',
      'The ampersand before F marks it as the accelerator - F will be underlined',
    ),
  );
  sections.add(
    buildBasicAcceleratorLabel(
      'E&dit',
      'Placing & in the middle underlines the following character (d)',
    ),
  );
  sections.add(
    buildBasicAcceleratorLabel(
      '&Help',
      'Common menu item with H as the accelerator key',
    ),
  );

  sections.add(buildSectionHeader('3. Multiple Label Positions'));
  sections.add(buildAcceleratorComparison());

  sections.add(buildSectionHeader('4. Labels in Menu Context'));
  sections.add(buildMenuItemContext());

  sections.add(buildSectionHeader('5. Label Styling'));
  sections.add(buildStyledLabels());

  sections.add(buildSectionHeader('6. Accelerator Parsing'));
  sections.add(buildParsingDemonstration());

  sections.add(buildSectionHeader('7. Row Layouts'));
  sections.add(buildRowLayouts());

  sections.add(buildSectionHeader('8. Underline Variations'));
  sections.add(buildUnderlineStyles());

  sections.add(buildSectionHeader('9. Accelerator Grid'));
  sections.add(buildAcceleratorGrid());

  sections.add(buildSectionHeader('10. Complete Menu Demo'));
  sections.add(buildMenuWithAccelerators());

  sections.add(buildSectionHeader('11. Colored Labels'));
  sections.add(buildColoredAccelerators());

  sections.add(buildSectionHeader('12. Usage Tips'));
  sections.add(
    buildInfoCard(
      'Tip 1',
      'Use & before the character you want as the accelerator key',
    ),
  );
  sections.add(
    buildInfoCard('Tip 2', 'Use && to display a literal ampersand character'),
  );
  sections.add(
    buildInfoCard(
      'Tip 3',
      'The accelerator character is typically underlined in the UI',
    ),
  );
  sections.add(
    buildInfoCard(
      'Tip 4',
      'Choose accelerator keys that are unique within the menu',
    ),
  );
  sections.add(
    buildInfoCard(
      'Tip 5',
      'Common patterns: &File, &Edit, &View, &Help for main menus',
    ),
  );

  sections.add(SizedBox(height: 32));

  Widget result = Scaffold(
    appBar: AppBar(
      title: Text('MenuAcceleratorLabel Demo'),
      backgroundColor: Colors.teal.shade700,
      foregroundColor: Colors.white,
    ),
    body: Container(
      color: Colors.grey.shade200,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: sections,
        ),
      ),
    ),
  );

  print('MenuAcceleratorLabel deep demo completed');
  return result;
}
