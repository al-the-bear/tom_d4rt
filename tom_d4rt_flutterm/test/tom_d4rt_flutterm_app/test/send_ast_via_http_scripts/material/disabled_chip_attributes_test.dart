// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests disabled chip attributes from package:flutter/material.dart
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== DisabledChipAttributes Visual Demo ===');
  debugPrint(
    'Demonstrating chip states, enabled vs disabled, and attribute variations',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Disabled Chip Attributes Demo'),
        backgroundColor: Color(0xFF37474F),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Enabled vs Disabled Chips'),
            SizedBox(height: 8),
            _buildEnabledVsDisabled(),
            SizedBox(height: 24),
            _buildSectionHeader('Chip Types in Disabled State'),
            SizedBox(height: 8),
            _buildChipTypesDisabled(),
            SizedBox(height: 24),
            _buildSectionHeader('Disabled Color Mapping'),
            SizedBox(height: 8),
            _buildDisabledColorMapping(),
            SizedBox(height: 24),
            _buildSectionHeader('Opacity Levels'),
            SizedBox(height: 8),
            _buildOpacityLevels(),
            SizedBox(height: 24),
            _buildSectionHeader('Avatar in Disabled Chips'),
            SizedBox(height: 8),
            _buildAvatarDisabledChips(),
            SizedBox(height: 24),
            _buildSectionHeader('Delete Icon States'),
            SizedBox(height: 8),
            _buildDeleteIconStates(),
            SizedBox(height: 24),
            _buildSectionHeader('Label Text Styles'),
            SizedBox(height: 8),
            _buildLabelTextStyles(),
            SizedBox(height: 24),
            _buildSectionHeader('Border & Outline States'),
            SizedBox(height: 8),
            _buildBorderStates(),
            SizedBox(height: 24),
            _buildSectionHeader('Chip Sizing in Disabled State'),
            SizedBox(height: 8),
            _buildChipSizing(),
            SizedBox(height: 24),
            _buildSectionHeader('Attribute Property Table'),
            SizedBox(height: 8),
            _buildAttributeTable(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  debugPrint('Building section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF37474F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildEnabledVsDisabled() {
  debugPrint('Building enabled vs disabled comparison');
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF4CAF50), width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    'Enabled',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _buildChip(
                        'Filter',
                        Color(0xFF4CAF50),
                        Color(0xFFFFFFFF),
                        1.0,
                        true,
                      ),
                      _buildChip(
                        'Action',
                        Color(0xFF2196F3),
                        Color(0xFFFFFFFF),
                        1.0,
                        true,
                      ),
                      _buildChip(
                        'Input',
                        Color(0xFFFF9800),
                        Color(0xFFFFFFFF),
                        1.0,
                        true,
                      ),
                      _buildChip(
                        'Choice',
                        Color(0xFF9C27B0),
                        Color(0xFFFFFFFF),
                        1.0,
                        true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFBDBDBD), width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    'Disabled',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _buildChip(
                        'Filter',
                        Color(0xFFBDBDBD),
                        Color(0xFF757575),
                        0.38,
                        false,
                      ),
                      _buildChip(
                        'Action',
                        Color(0xFFBDBDBD),
                        Color(0xFF757575),
                        0.38,
                        false,
                      ),
                      _buildChip(
                        'Input',
                        Color(0xFFBDBDBD),
                        Color(0xFF757575),
                        0.38,
                        false,
                      ),
                      _buildChip(
                        'Choice',
                        Color(0xFFBDBDBD),
                        Color(0xFF757575),
                        0.38,
                        false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildChip(
  String label,
  Color bg,
  Color fg,
  double opacity,
  bool hasDelete,
) {
  return Opacity(
    opacity: opacity,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (hasDelete) ...[
            SizedBox(width: 4),
            Icon(Icons.close, size: 14, color: fg),
          ],
        ],
      ),
    ),
  );
}

Widget _buildChipTypesDisabled() {
  debugPrint('Building chip types in disabled state');
  List<Map<String, dynamic>> chipTypes = [
    {
      'label': 'InputChip',
      'icon': Icons.input,
      'desc': 'Represents complex entity (person, place)',
    },
    {
      'label': 'FilterChip',
      'icon': Icons.filter_list,
      'desc': 'Filters content in a set',
    },
    {
      'label': 'ChoiceChip',
      'icon': Icons.check_circle,
      'desc': 'Single selection from set',
    },
    {
      'label': 'ActionChip',
      'icon': Icons.flash_on,
      'desc': 'Triggers an action',
    },
  ];
  return Column(
    children: chipTypes.map((ct) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                ct['icon'] as IconData,
                color: Color(0xFF9E9E9E),
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ct['label'] as String,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    ct['desc'] as String,
                    style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF37474F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Enabled',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10),
                  ),
                ),
                SizedBox(height: 4),
                Opacity(
                  opacity: 0.38,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFBDBDBD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Disabled',
                      style: TextStyle(color: Color(0xFF757575), fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildDisabledColorMapping() {
  debugPrint('Building disabled color mapping');
  List<Map<String, dynamic>> mappings = [
    {
      'prop': 'backgroundColor',
      'enabled': Color(0xFF4CAF50),
      'disabled': Color(0xFFBDBDBD),
      'enabledLabel': '#4CAF50',
      'disabledLabel': '#BDBDBD',
    },
    {
      'prop': 'labelColor',
      'enabled': Color(0xFFFFFFFF),
      'disabled': Color(0xFF9E9E9E),
      'enabledLabel': '#FFFFFF',
      'disabledLabel': '#9E9E9E',
    },
    {
      'prop': 'deleteIconColor',
      'enabled': Color(0xFFFFFFFF),
      'disabled': Color(0xFFBDBDBD),
      'enabledLabel': '#FFFFFF',
      'disabledLabel': '#BDBDBD',
    },
    {
      'prop': 'shadowColor',
      'enabled': Color(0x66000000),
      'disabled': Color(0x00000000),
      'enabledLabel': '40% black',
      'disabledLabel': 'transparent',
    },
    {
      'prop': 'borderColor',
      'enabled': Color(0xFF4CAF50),
      'disabled': Color(0xFFE0E0E0),
      'enabledLabel': '#4CAF50',
      'disabledLabel': '#E0E0E0',
    },
  ];
  return Column(
    children: mappings.map((m) {
      return Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                m['prop'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: m['enabled'] as Color,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xFFE0E0E0)),
              ),
            ),
            SizedBox(width: 4),
            SizedBox(
              width: 65,
              child: Text(
                m['enabledLabel'] as String,
                style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
              ),
            ),
            Icon(Icons.arrow_forward, size: 14, color: Color(0xFFBDBDBD)),
            SizedBox(width: 4),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: m['disabled'] as Color,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xFFE0E0E0)),
              ),
            ),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                m['disabledLabel'] as String,
                style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildOpacityLevels() {
  debugPrint('Building opacity levels');
  List<double> opacities = [1.0, 0.87, 0.60, 0.38, 0.12, 0.05];
  return Column(
    children: [
      Row(
        children: opacities.map((o) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: [
                  Opacity(
                    opacity: o,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF37474F),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Chip',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${(o * 100).toInt()}%',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                  Text(
                    o == 0.38 ? '(disabled)' : (o == 1.0 ? '(enabled)' : ''),
                    style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF37474F), size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Material Design uses 38% opacity as the standard disabled state. Some components use isEnabled flag instead of opacity.',
                style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildAvatarDisabledChips() {
  debugPrint('Building avatar disabled chips');
  List<Map<String, dynamic>> avatarChips = [
    {
      'label': 'John Doe',
      'avatar': 'J',
      'enabled': true,
      'color': Color(0xFF4CAF50),
    },
    {
      'label': 'Jane Smith',
      'avatar': 'J',
      'enabled': true,
      'color': Color(0xFF2196F3),
    },
    {
      'label': 'Bob Wilson',
      'avatar': 'B',
      'enabled': false,
      'color': Color(0xFFBDBDBD),
    },
    {
      'label': 'Alice Brown',
      'avatar': 'A',
      'enabled': false,
      'color': Color(0xFFBDBDBD),
    },
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: avatarChips.map((ac) {
      bool enabled = ac['enabled'] as bool;
      return Opacity(
        opacity: enabled ? 1.0 : 0.38,
        child: Container(
          padding: EdgeInsets.fromLTRB(4, 4, 12, 4),
          decoration: BoxDecoration(
            color: enabled
                ? (ac['color'] as Color).withValues(alpha: 0.1)
                : Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: enabled ? ac['color'] as Color : Color(0xFFBDBDBD),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: ac['color'] as Color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    ac['avatar'] as String,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                ac['label'] as String,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: enabled ? Color(0xFF212121) : Color(0xFF757575),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildDeleteIconStates() {
  debugPrint('Building delete icon states');
  return Row(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF37474F), width: 2),
          ),
          child: Column(
            children: [
              Text(
                'Enabled Delete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF37474F),
                ),
              ),
              SizedBox(height: 12),
              _buildDeleteChip(
                'Tag One',
                Color(0xFF37474F),
                Color(0xFFFFFFFF),
                true,
              ),
              SizedBox(height: 6),
              _buildDeleteChip(
                'Tag Two',
                Color(0xFF2196F3),
                Color(0xFFFFFFFF),
                true,
              ),
              SizedBox(height: 6),
              _buildDeleteChip(
                'Tag Three',
                Color(0xFF4CAF50),
                Color(0xFFFFFFFF),
                true,
              ),
              SizedBox(height: 12),
              Text(
                'Delete icon is interactive',
                style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFBDBDBD), width: 2),
          ),
          child: Column(
            children: [
              Text(
                'Disabled Delete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF9E9E9E),
                ),
              ),
              SizedBox(height: 12),
              Opacity(
                opacity: 0.38,
                child: _buildDeleteChip(
                  'Tag One',
                  Color(0xFFBDBDBD),
                  Color(0xFF757575),
                  false,
                ),
              ),
              SizedBox(height: 6),
              Opacity(
                opacity: 0.38,
                child: _buildDeleteChip(
                  'Tag Two',
                  Color(0xFFBDBDBD),
                  Color(0xFF757575),
                  false,
                ),
              ),
              SizedBox(height: 6),
              Opacity(
                opacity: 0.38,
                child: _buildDeleteChip(
                  'Tag Three',
                  Color(0xFFBDBDBD),
                  Color(0xFF757575),
                  false,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Delete icon is non-interactive',
                style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildDeleteChip(String label, Color bg, Color fg, bool enabled) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(color: fg, fontSize: 12)),
        SizedBox(width: 6),
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: fg.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.close, size: 12, color: fg),
        ),
      ],
    ),
  );
}

Widget _buildLabelTextStyles() {
  debugPrint('Building label text styles');
  List<Map<String, dynamic>> textStyles = [
    {
      'label': 'Enabled Default',
      'color': Color(0xFF212121),
      'weight': FontWeight.w500,
      'opacity': 1.0,
    },
    {
      'label': 'Enabled Bold',
      'color': Color(0xFF1565C0),
      'weight': FontWeight.bold,
      'opacity': 1.0,
    },
    {
      'label': 'Disabled Default',
      'color': Color(0xFF9E9E9E),
      'weight': FontWeight.w500,
      'opacity': 0.38,
    },
    {
      'label': 'Disabled Faded',
      'color': Color(0xFFBDBDBD),
      'weight': FontWeight.w400,
      'opacity': 0.38,
    },
  ];
  return Column(
    children: textStyles.map((ts) {
      return Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                ts['label'] as String,
                style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
              ),
            ),
            Expanded(
              child: Opacity(
                opacity: ts['opacity'] as double,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Sample Chip',
                    style: TextStyle(
                      color: ts['color'] as Color,
                      fontWeight: ts['weight'] as FontWeight,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildBorderStates() {
  debugPrint('Building border states');
  List<Map<String, dynamic>> borders = [
    {
      'label': 'Enabled Solid',
      'color': Color(0xFF37474F),
      'width': 2.0,
      'opacity': 1.0,
    },
    {
      'label': 'Enabled Thin',
      'color': Color(0xFF37474F),
      'width': 1.0,
      'opacity': 1.0,
    },
    {
      'label': 'Disabled Solid',
      'color': Color(0xFFBDBDBD),
      'width': 2.0,
      'opacity': 0.38,
    },
    {
      'label': 'Disabled Thin',
      'color': Color(0xFFE0E0E0),
      'width': 1.0,
      'opacity': 0.38,
    },
    {
      'label': 'No Border',
      'color': Color(0x00000000),
      'width': 0.0,
      'opacity': 1.0,
    },
  ];
  return Row(
    children: borders.map((b) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          child: Column(
            children: [
              Opacity(
                opacity: b['opacity'] as double,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                    border: (b['width'] as double) > 0
                        ? Border.all(
                            color: b['color'] as Color,
                            width: b['width'] as double,
                          )
                        : null,
                  ),
                  child: Center(
                    child: Text('Chip', style: TextStyle(fontSize: 11)),
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                b['label'] as String,
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildChipSizing() {
  debugPrint('Building chip sizing');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Disabled chips maintain the same dimensions as enabled chips:',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Text(
              'Enabled:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            SizedBox(width: 12),
            Container(
              padding: EdgeInsets.fromLTRB(4, 4, 12, 4),
              decoration: BoxDecoration(
                color: Color(0xFF37474F),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Color(0xFF78909C),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Chip Label',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.close, size: 14, color: Color(0xFFFFFFFF)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Disabled:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            SizedBox(width: 8),
            Opacity(
              opacity: 0.38,
              child: Container(
                padding: EdgeInsets.fromLTRB(4, 4, 12, 4),
                decoration: BoxDecoration(
                  color: Color(0xFFBDBDBD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Color(0xFF9E9E9E),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          'A',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Chip Label',
                      style: TextStyle(color: Color(0xFF757575), fontSize: 12),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.close, size: 14, color: Color(0xFF757575)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Height: 32dp  |  Min padding: 4dp  |  Avatar: 24dp',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF546E7A),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAttributeTable() {
  debugPrint('Building attribute property table');
  List<Map<String, String>> attrs = [
    {
      'attr': 'isEnabled',
      'type': 'bool',
      'desc': 'Whether the chip is interactive',
    },
    {
      'attr': 'disabledColor',
      'type': 'Color?',
      'desc': 'Background color when disabled',
    },
    {
      'attr': 'onDeleted',
      'type': 'VoidCallback?',
      'desc': 'Null when disabled (non-interactive)',
    },
    {
      'attr': 'onSelected',
      'type': 'ValueChanged?',
      'desc': 'Null when disabled (non-interactive)',
    },
    {
      'attr': 'onPressed',
      'type': 'VoidCallback?',
      'desc': 'Null when disabled (non-interactive)',
    },
    {
      'attr': 'shape',
      'type': 'OutlinedBorder?',
      'desc': 'Chip shape (same when disabled)',
    },
    {
      'attr': 'labelStyle',
      'type': 'TextStyle?',
      'desc': 'May change color when disabled',
    },
    {'attr': 'elevation', 'type': 'double?', 'desc': 'Usually 0 when disabled'},
  ];
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF37474F),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Attribute',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Type',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Description',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...attrs.asMap().entries.map((entry) {
          bool alt = entry.key % 2 == 0;
          Map<String, String> a = entry.value;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: alt ? Color(0xFFF5F5F5) : Color(0xFFFFFFFF),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    a['attr']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    a['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    a['desc']!,
                    style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
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
