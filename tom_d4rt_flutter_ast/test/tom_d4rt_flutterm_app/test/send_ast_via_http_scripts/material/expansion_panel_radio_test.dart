// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExpansionPanelRadio from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ExpansionPanelRadio Visual Demo ===');
  print('Demonstrating ExpansionPanelRadio through ExpansionPanelList.radio');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('ExpansionPanelRadio Demo'),
        backgroundColor: Color(0xFF4A148C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Radio Expansion Behavior'),
            SizedBox(height: 8),
            _buildRadioExpansionBehavior(),
            SizedBox(height: 24),
            buildSectionHeader('Panel Header/Body Content'),
            SizedBox(height: 8),
            _buildHeaderBodyContent(),
            SizedBox(height: 24),
            buildSectionHeader('Radio vs Regular Expansion Panels'),
            SizedBox(height: 8),
            _buildRadioVsRegular(),
            SizedBox(height: 24),
            buildSectionHeader('Styled Panel Backgrounds'),
            SizedBox(height: 8),
            _buildStyledPanelBackgrounds(),
            SizedBox(height: 24),
            buildSectionHeader('Panel Icon Configurations'),
            SizedBox(height: 8),
            _buildPanelIconConfigs(),
            SizedBox(height: 24),
            buildSectionHeader('ExpansionPanelRadio Value System'),
            SizedBox(height: 8),
            _buildValueSystem(),
            SizedBox(height: 24),
            buildSectionHeader('Panel State Transitions'),
            SizedBox(height: 8),
            _buildStateTransitions(),
            SizedBox(height: 24),
            buildSectionHeader('Accordion Settings Pattern'),
            SizedBox(height: 8),
            _buildAccordionSettingsPattern(),
            SizedBox(height: 24),
            buildSectionHeader('Properties Reference'),
            SizedBox(height: 8),
            _buildPropertiesReference(),
            SizedBox(height: 24),
            buildSectionHeader('FAQ Accordion Demo'),
            SizedBox(height: 8),
            _buildFaqAccordionDemo(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

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

Widget _buildRadioExpansionBehavior() {
  print('Building radio expansion behavior');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Radio-Like Exclusive Expansion',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Text(
          'Only ONE panel can be expanded at a time',
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
        SizedBox(height: 16),
        _buildMockRadioPanel(
          'Panel A',
          'First panel content with detailed information about topic A.',
          true,
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 4),
        _buildMockRadioPanel(
          'Panel B',
          'Second panel content is hidden.',
          false,
          Color(0xFF4A148C),
        ),
        SizedBox(height: 4),
        _buildMockRadioPanel(
          'Panel C',
          'Third panel content is hidden.',
          false,
          Color(0xFF4A148C),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: Color(0xFF6A1B9A),
                size: 20,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Opening Panel B will automatically close Panel A',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF4A148C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMockRadioPanel(
  String header,
  String body,
  bool expanded,
  Color color,
) {
  List<Widget> children = [];
  children.add(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: expanded ? color.withValues(alpha: 0.08) : Color(0xFFFFFFFF),
        borderRadius: expanded
            ? BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )
            : BorderRadius.circular(8),
        border: Border.all(color: expanded ? color : Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Icon(
            expanded
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: expanded ? color : Color(0xFF9E9E9E),
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              header,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Icon(
            expanded ? Icons.expand_less : Icons.expand_more,
            color: color,
            size: 24,
          ),
        ],
      ),
    ),
  );

  if (expanded) {
    children.add(
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Text(
          body,
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
      ),
    );
  }

  return Column(children: children);
}

Widget _buildHeaderBodyContent() {
  print('Building header/body content');
  List<Widget> panels = [];

  panels.add(
    _buildContentPanel(
      'Text Header',
      'Simple text-based header',
      Icons.text_fields,
      Color(0xFF1565C0),
      'This panel demonstrates a plain text header with a text body. '
          'The header shows a title and the body displays paragraph content.',
      true,
    ),
  );
  panels.add(SizedBox(height: 8));
  panels.add(
    _buildContentPanel(
      'Rich Header',
      'Header with icon and subtitle',
      Icons.star,
      Color(0xFFE65100),
      'Rich headers can include leading icons, subtitles, and trailing widgets '
          'to provide more context about the panel content.',
      false,
    ),
  );
  panels.add(SizedBox(height: 8));
  panels.add(
    _buildContentPanel(
      'Image Header',
      'Header with thumbnail preview',
      Icons.image,
      Color(0xFF00897B),
      'Image-based headers show a thumbnail alongside the title, '
          'making them ideal for media galleries or product listings.',
      false,
    ),
  );
  panels.add(SizedBox(height: 8));
  panels.add(
    _buildContentPanel(
      'Action Header',
      'Header with action buttons',
      Icons.touch_app,
      Color(0xFF6A1B9A),
      'Action headers include interactive buttons like edit, delete, '
          'or share that work independently of the expand/collapse behavior.',
      false,
    ),
  );

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Different Header/Body Content Patterns',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 12),
        Column(children: panels),
      ],
    ),
  );
}

Widget _buildContentPanel(
  String title,
  String subtitle,
  IconData icon,
  Color color,
  String body,
  bool expanded,
) {
  List<Widget> widgets = [];

  widgets.add(
    Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: expanded ? color.withValues(alpha: 0.05) : Color(0xFFFFFFFF),
        borderRadius: expanded
            ? BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )
            : BorderRadius.circular(8),
        border: Border.all(color: expanded ? color : Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                ),
              ],
            ),
          ),
          Icon(
            expanded ? Icons.expand_less : Icons.expand_more,
            color: color,
            size: 24,
          ),
        ],
      ),
    ),
  );

  if (expanded) {
    widgets.add(
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Text(
          body,
          style: TextStyle(fontSize: 13, color: Color(0xFF616161), height: 1.5),
        ),
      ),
    );
  }

  return Column(children: widgets);
}

Widget _buildRadioVsRegular() {
  print('Building radio vs regular comparison');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFCC80)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF4CAF50), width: 2),
            ),
            child: Column(
              children: [
                Text(
                  'ExpansionPanelList',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'REGULAR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Color(0xFF757575),
                  ),
                ),
                SizedBox(height: 12),
                _buildMiniPanel(true, Color(0xFF4CAF50)),
                SizedBox(height: 4),
                _buildMiniPanel(true, Color(0xFF4CAF50)),
                SizedBox(height: 4),
                _buildMiniPanel(false, Color(0xFF4CAF50)),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Multiple panels can be open',
                    style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF6A1B9A), width: 2),
            ),
            child: Column(
              children: [
                Text(
                  'ExpansionPanelList.radio',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'RADIO',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Color(0xFF757575),
                  ),
                ),
                SizedBox(height: 12),
                _buildMiniPanel(true, Color(0xFF6A1B9A)),
                SizedBox(height: 4),
                _buildMiniPanel(false, Color(0xFF6A1B9A)),
                SizedBox(height: 4),
                _buildMiniPanel(false, Color(0xFF6A1B9A)),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Only ONE panel open at a time',
                    style: TextStyle(fontSize: 10, color: Color(0xFF4A148C)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMiniPanel(bool expanded, Color color) {
  return Container(
    height: expanded ? 40 : 24,
    decoration: BoxDecoration(
      color: expanded ? color.withValues(alpha: 0.12) : Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: expanded ? color : Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        SizedBox(width: 8),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: expanded ? color : Color(0xFFBDBDBD),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(child: SizedBox()),
        Icon(
          expanded ? Icons.expand_less : Icons.expand_more,
          size: 14,
          color: expanded ? color : Color(0xFFBDBDBD),
        ),
        SizedBox(width: 4),
      ],
    ),
  );
}

Widget _buildStyledPanelBackgrounds() {
  print('Building styled panel backgrounds');
  List<Widget> panels = [];

  panels.add(
    _buildStyledPanel(
      'Default White',
      Color(0xFFFFFFFF),
      Color(0xFFE0E0E0),
      Color(0xFF000000),
    ),
  );
  panels.add(SizedBox(height: 8));
  panels.add(
    _buildStyledPanel(
      'Light Blue',
      Color(0xFFE3F2FD),
      Color(0xFF90CAF9),
      Color(0xFF1565C0),
    ),
  );
  panels.add(SizedBox(height: 8));
  panels.add(
    _buildStyledPanel(
      'Light Purple',
      Color(0xFFF3E5F5),
      Color(0xFFCE93D8),
      Color(0xFF6A1B9A),
    ),
  );
  panels.add(SizedBox(height: 8));
  panels.add(
    _buildStyledPanel(
      'Light Green',
      Color(0xFFE8F5E9),
      Color(0xFFA5D6A7),
      Color(0xFF2E7D32),
    ),
  );
  panels.add(SizedBox(height: 8));
  panels.add(
    _buildStyledPanel(
      'Dark Surface',
      Color(0xFF263238),
      Color(0xFF455A64),
      Color(0xFFFFFFFF),
    ),
  );
  panels.add(SizedBox(height: 8));
  panels.add(
    _buildStyledPanel(
      'Warm Amber',
      Color(0xFFFFF8E1),
      Color(0xFFFFE082),
      Color(0xFFE65100),
    ),
  );

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
          'Panel background color variations',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Column(children: panels),
      ],
    ),
  );
}

Widget _buildStyledPanel(String label, Color bg, Color border, Color text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: border),
    ),
    child: Row(
      children: [
        Icon(
          Icons.radio_button_checked,
          color: text.withValues(alpha: 0.7),
          size: 18,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: text,
            ),
          ),
        ),
        Icon(Icons.expand_more, color: text.withValues(alpha: 0.7), size: 22),
      ],
    ),
  );
}

Widget _buildPanelIconConfigs() {
  print('Building panel icon configurations');
  List<Widget> icons = [];

  icons.add(
    _buildIconConfigRow(
      'Default Arrow',
      Icons.expand_more,
      Icons.expand_less,
      Color(0xFF757575),
    ),
  );
  icons.add(SizedBox(height: 6));
  icons.add(
    _buildIconConfigRow(
      'Chevron',
      Icons.keyboard_arrow_down,
      Icons.keyboard_arrow_up,
      Color(0xFF1565C0),
    ),
  );
  icons.add(SizedBox(height: 6));
  icons.add(
    _buildIconConfigRow(
      'Add/Remove',
      Icons.add,
      Icons.remove,
      Color(0xFF00897B),
    ),
  );
  icons.add(SizedBox(height: 6));
  icons.add(
    _buildIconConfigRow(
      'Plus/Minus Circle',
      Icons.add_circle_outline,
      Icons.remove_circle_outline,
      Color(0xFFE65100),
    ),
  );
  icons.add(SizedBox(height: 6));
  icons.add(
    _buildIconConfigRow(
      'Arrow Drop',
      Icons.arrow_drop_down,
      Icons.arrow_drop_up,
      Color(0xFF6A1B9A),
    ),
  );

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80CBC4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Different trailing icon styles for panels',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Column(children: icons),
      ],
    ),
  );
}

Widget _buildIconConfigRow(
  String label,
  IconData collapsed,
  IconData expanded,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        Expanded(child: SizedBox()),
        Column(
          children: [
            Icon(collapsed, size: 28, color: color),
            Text(
              'collapsed',
              style: TextStyle(fontSize: 9, color: Color(0xFF9E9E9E)),
            ),
          ],
        ),
        SizedBox(width: 16),
        Column(
          children: [
            Icon(expanded, size: 28, color: color),
            Text(
              'expanded',
              style: TextStyle(fontSize: 9, color: Color(0xFF9E9E9E)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildValueSystem() {
  print('Building value system');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFD1C4E9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Each ExpansionPanelRadio has a unique value',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildValueRow('panel_0', 'General', true, Color(0xFF6A1B9A)),
        SizedBox(height: 6),
        _buildValueRow('panel_1', 'Account', false, Color(0xFF4A148C)),
        SizedBox(height: 6),
        _buildValueRow('panel_2', 'Privacy', false, Color(0xFF4A148C)),
        SizedBox(height: 6),
        _buildValueRow('panel_3', 'About', false, Color(0xFF4A148C)),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFD1C4E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How it works:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 4),
              Text(
                '1. Each panel gets a unique value (any Object)',
                style: TextStyle(fontSize: 12, color: Color(0xFF311B92)),
              ),
              Text(
                '2. ExpansionPanelList.radio tracks the initialOpenPanelValue',
                style: TextStyle(fontSize: 12, color: Color(0xFF311B92)),
              ),
              Text(
                '3. Tapping a panel sets it as active, closing others',
                style: TextStyle(fontSize: 12, color: Color(0xFF311B92)),
              ),
              Text(
                '4. Only the panel matching active value is expanded',
                style: TextStyle(fontSize: 12, color: Color(0xFF311B92)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildValueRow(String value, String label, bool active, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: active ? color.withValues(alpha: 0.1) : Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: active ? color : Color(0xFFE0E0E0),
        width: active ? 2 : 1,
      ),
    ),
    child: Row(
      children: [
        Icon(
          active ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: active ? color : Color(0xFFBDBDBD),
          size: 20,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Text(
            'value: "$value"',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Color(0xFF616161),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateTransitions() {
  print('Building state transitions');
  List<Widget> steps = [];

  steps.add(
    _buildTransitionStep(
      '1',
      'All panels collapsed initially',
      Icons.view_agenda,
      Color(0xFF757575),
    ),
  );
  steps.add(_buildTransitionArrow());
  steps.add(
    _buildTransitionStep(
      '2',
      'User taps Panel A header',
      Icons.touch_app,
      Color(0xFF1565C0),
    ),
  );
  steps.add(_buildTransitionArrow());
  steps.add(
    _buildTransitionStep(
      '3',
      'Panel A expands (others stay closed)',
      Icons.open_in_full,
      Color(0xFF00897B),
    ),
  );
  steps.add(_buildTransitionArrow());
  steps.add(
    _buildTransitionStep(
      '4',
      'User taps Panel B header',
      Icons.touch_app,
      Color(0xFFE65100),
    ),
  );
  steps.add(_buildTransitionArrow());
  steps.add(
    _buildTransitionStep(
      '5',
      'Panel A closes, Panel B opens',
      Icons.swap_vert,
      Color(0xFF6A1B9A),
    ),
  );
  steps.add(_buildTransitionArrow());
  steps.add(
    _buildTransitionStep(
      '6',
      'expansionCallback fires with index',
      Icons.notifications_active,
      Color(0xFFC62828),
    ),
  );

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFE082)),
    ),
    child: Column(children: steps),
  );
}

Widget _buildTransitionStep(
  String number,
  String label,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 2),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Icon(icon, color: color, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTransitionArrow() {
  return SizedBox(
    height: 24,
    child: Center(
      child: Icon(Icons.arrow_downward, color: Color(0xFF9E9E9E), size: 18),
    ),
  );
}

Widget _buildAccordionSettingsPattern() {
  print('Building accordion settings pattern');
  List<Widget> settings = [];

  settings.add(
    _buildSettingsGroup(
      'Display',
      Icons.display_settings,
      Color(0xFF1565C0),
      true,
      [
        'Brightness: Auto',
        'Font Size: Medium',
        'Theme: Material 3',
        'Animations: Enabled',
      ],
    ),
  );
  settings.add(SizedBox(height: 4));
  settings.add(
    _buildSettingsGroup('Sound', Icons.volume_up, Color(0xFF00897B), false, []),
  );
  settings.add(SizedBox(height: 4));
  settings.add(
    _buildSettingsGroup('Network', Icons.wifi, Color(0xFFE65100), false, []),
  );
  settings.add(SizedBox(height: 4));
  settings.add(
    _buildSettingsGroup('Storage', Icons.storage, Color(0xFF6A1B9A), false, []),
  );

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings page using radio expansion panels',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Column(children: settings),
      ],
    ),
  );
}

Widget _buildSettingsGroup(
  String title,
  IconData icon,
  Color color,
  bool expanded,
  List<String> items,
) {
  List<Widget> children = [];

  children.add(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: expanded ? color.withValues(alpha: 0.06) : Color(0xFFFFFFFF),
        borderRadius: expanded
            ? BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )
            : BorderRadius.circular(8),
        border: Border.all(color: expanded ? color : Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Icon(
            expanded ? Icons.expand_less : Icons.expand_more,
            color: color,
            size: 22,
          ),
        ],
      ),
    ),
  );

  if (expanded) {
    List<Widget> settingRows = [];
    int i = 0;
    for (i = 0; i < items.length; i = i + 1) {
      settingRows.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(Icons.chevron_right, size: 16, color: Color(0xFF9E9E9E)),
              SizedBox(width: 8),
              Text(
                items[i],
                style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
              ),
            ],
          ),
        ),
      );
    }
    children.add(
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: settingRows,
        ),
      ),
    );
  }

  return Column(children: children);
}

Widget _buildPropertiesReference() {
  print('Building properties reference');
  List<Widget> rows = [];
  rows.add(
    _buildPropRow(
      'value',
      'Object',
      'Unique identifier for this radio panel',
      Color(0xFF1565C0),
    ),
  );
  rows.add(
    _buildPropRow(
      'headerBuilder',
      'ExpansionPanelHeaderBuilder',
      'Builds the panel header widget',
      Color(0xFF00897B),
    ),
  );
  rows.add(
    _buildPropRow(
      'body',
      'Widget',
      'Content shown when expanded',
      Color(0xFFE65100),
    ),
  );
  rows.add(
    _buildPropRow(
      'canTapOnHeader',
      'bool',
      'Whether header tap toggles expansion',
      Color(0xFF6A1B9A),
    ),
  );
  rows.add(
    _buildPropRow(
      'backgroundColor',
      'Color',
      'Panel background color',
      Color(0xFFC62828),
    ),
  );
  rows.add(
    _buildPropRow(
      'initialOpenPanelValue',
      'Object',
      'Initial expanded panel value (list)',
      Color(0xFF283593),
    ),
  );
  rows.add(
    _buildPropRow(
      'expansionCallback',
      'Function',
      'Callback when a panel is toggled',
      Color(0xFF00695C),
    ),
  );

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Property',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'Type',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
        Divider(color: Color(0xFFBDBDBD)),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildPropRow(String name, String type, String desc, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFF616161),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            desc,
            style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFaqAccordionDemo() {
  print('Building FAQ accordion demo');
  List<Widget> faqs = [];

  faqs.add(
    _buildFaqItem(
      'What is ExpansionPanelRadio?',
      'ExpansionPanelRadio is a specialized expansion panel that works with '
          'ExpansionPanelList.radio to ensure only one panel is expanded at a time. '
          'It requires a unique value to identify itself.',
      true,
      Color(0xFF6A1B9A),
    ),
  );
  faqs.add(SizedBox(height: 4));
  faqs.add(
    _buildFaqItem(
      'How does radio behavior differ?',
      'Unlike regular ExpansionPanel, radio panels automatically close when another opens.',
      false,
      Color(0xFF4A148C),
    ),
  );
  faqs.add(SizedBox(height: 4));
  faqs.add(
    _buildFaqItem(
      'Can I customize the expand icon?',
      'Yes! Use the trailing widget in headerBuilder to customize the expand/collapse icon.',
      false,
      Color(0xFF4A148C),
    ),
  );
  faqs.add(SizedBox(height: 4));
  faqs.add(
    _buildFaqItem(
      'What types of values can I use?',
      'Any Object can be used as a value. Strings, integers, and enums are common choices.',
      false,
      Color(0xFF4A148C),
    ),
  );
  faqs.add(SizedBox(height: 4));
  faqs.add(
    _buildFaqItem(
      'Is animation built in?',
      'Yes, the expand/collapse animation is handled automatically by the framework.',
      false,
      Color(0xFF4A148C),
    ),
  );

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.help, color: Color(0xFF6A1B9A), size: 24),
            SizedBox(width: 8),
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF4A148C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: faqs),
      ],
    ),
  );
}

Widget _buildFaqItem(
  String question,
  String answer,
  bool expanded,
  Color color,
) {
  List<Widget> widgets = [];

  widgets.add(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: expanded ? color.withValues(alpha: 0.08) : Color(0xFFFFFFFF),
        borderRadius: expanded
            ? BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )
            : BorderRadius.circular(8),
        border: Border.all(color: expanded ? color : Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Icon(Icons.help_outline, color: color, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              question,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          Icon(
            expanded ? Icons.expand_less : Icons.expand_more,
            color: color,
            size: 22,
          ),
        ],
      ),
    ),
  );

  if (expanded) {
    widgets.add(
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lightbulb_outline, color: Color(0xFFFFB300), size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF616161),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: widgets);
}
