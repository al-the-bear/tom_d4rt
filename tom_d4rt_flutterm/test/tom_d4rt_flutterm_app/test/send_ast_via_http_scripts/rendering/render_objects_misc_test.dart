// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: Miscellaneous render objects and sizing widgets
// Covers SizedBox, LimitedBox, ConstrainedBox, IntrinsicWidth,
// IntrinsicHeight, AspectRatio, UnconstrainedBox, OverflowBar,
// and RichText with multiple TextSpan styles.

import 'package:flutter/material.dart';

Widget _buildHeader(String title) {
  print('[render_objects_misc] Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFF00897B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Color(0x406A1B9A),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _buildSectionTitle(String title) {
  print('[render_objects_misc] Section: $title');
  return Padding(
    padding: EdgeInsets.only(top: 20, bottom: 10, left: 4),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A148C), Color(0xFF00695C)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: EdgeInsets.only(top: 8, bottom: 4, left: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF37474F),
      ),
    ),
  );
}

Widget _buildColoredBox(
  Color color,
  double width,
  double height,
  String label,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black26, width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(height: 4),
      Text(
        '${width.toInt()}x${height.toInt()}',
        style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
      ),
    ],
  );
}

Widget _buildSizedBoxSection() {
  print('[render_objects_misc] Building SizedBox section');
  // SizedBox with various explicit width/height combos
  Widget row1 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SizedBox(
        width: 60,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFE91E63),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '60x60',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
      SizedBox(
        width: 100,
        height: 40,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF9C27B0),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '100x40',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
      SizedBox(
        width: 40,
        height: 80,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF3F51B5),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '40x80',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
      SizedBox(
        width: 80,
        height: 80,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF009688),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '80x80',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
    ],
  );

  print('[render_objects_misc] SizedBox row 1 built with 4 variants');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('SizedBox - Explicit Sizes'),
      _buildLabel('Different width/height combinations'),
      SizedBox(height: 8),
      row1,
    ],
  );
}

Widget _buildSizedBoxFactorySection() {
  print('[render_objects_misc] Building SizedBox factory constructors');

  // SizedBox.expand
  Widget expandBox = Container(
    height: 70,
    padding: EdgeInsets.all(4),
    child: SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFF7043),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          'SizedBox.expand',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    ),
  );

  // SizedBox.shrink
  Widget shrinkRow = Row(
    children: [
      Text('Before ', style: TextStyle(fontSize: 12)),
      SizedBox.shrink(),
      Text(' After', style: TextStyle(fontSize: 12)),
      SizedBox(width: 12),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'SizedBox.shrink takes zero space',
          style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
        ),
      ),
    ],
  );

  // SizedBox.fromSize
  Widget fromSizeBox = SizedBox.fromSize(
    size: Size(120, 50),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF42A5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        'fromSize(120,50)',
        style: TextStyle(color: Colors.white, fontSize: 11),
      ),
    ),
  );

  // SizedBox.square
  Widget squareBox = SizedBox.square(
    dimension: 70,
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF66BB6A),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        'square(70)',
        style: TextStyle(color: Colors.white, fontSize: 11),
      ),
    ),
  );

  print(
    '[render_objects_misc] SizedBox factories: expand, shrink, fromSize, square',
  );
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('SizedBox Factory Constructors'),
      _buildLabel('SizedBox.expand - fills available space'),
      expandBox,
      SizedBox(height: 8),
      _buildLabel('SizedBox.shrink - occupies zero space'),
      Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: shrinkRow),
      SizedBox(height: 12),
      _buildLabel('SizedBox.fromSize and SizedBox.square'),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: [fromSizeBox, SizedBox(width: 16), squareBox]),
      ),
    ],
  );
}

Widget _buildLimitedBoxSection() {
  print('[render_objects_misc] Building LimitedBox section');

  // LimitedBox only applies when unconstrained, so we wrap in UnconstrainedBox
  Widget demo1 = UnconstrainedBox(
    child: LimitedBox(
      maxWidth: 150,
      maxHeight: 60,
      child: Container(
        color: Color(0xFFAB47BC),
        padding: EdgeInsets.all(8),
        child: Text(
          'maxW:150 maxH:60',
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    ),
  );

  Widget demo2 = UnconstrainedBox(
    child: LimitedBox(
      maxWidth: 200,
      maxHeight: 40,
      child: Container(
        color: Color(0xFF7E57C2),
        padding: EdgeInsets.all(8),
        child: Text(
          'maxW:200 maxH:40',
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    ),
  );

  Widget demo3 = UnconstrainedBox(
    child: LimitedBox(
      maxWidth: 100,
      maxHeight: 100,
      child: Container(
        color: Color(0xFF5C6BC0),
        padding: EdgeInsets.all(8),
        child: Text(
          '100x100',
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    ),
  );

  print('[render_objects_misc] LimitedBox demos built with 3 variations');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('LimitedBox - Max Constraints'),
      _buildLabel('LimitedBox limits size when unconstrained'),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [demo1, demo2],
      ),
      SizedBox(height: 8),
      Center(child: demo3),
    ],
  );
}

Widget _buildConstrainedBoxSection() {
  print('[render_objects_misc] Building ConstrainedBox section');

  Widget box1 = ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: 100,
      minHeight: 50,
      maxWidth: 200,
      maxHeight: 80,
    ),
    child: Container(
      color: Color(0xFFEF5350),
      alignment: Alignment.center,
      child: Text(
        'min100x50\nmax200x80',
        style: TextStyle(color: Colors.white, fontSize: 10),
        textAlign: TextAlign.center,
      ),
    ),
  );

  Widget box2 = ConstrainedBox(
    constraints: BoxConstraints.tightFor(width: 120, height: 60),
    child: Container(
      color: Color(0xFFFF7043),
      alignment: Alignment.center,
      child: Text(
        'tightFor\n120x60',
        style: TextStyle(color: Colors.white, fontSize: 10),
        textAlign: TextAlign.center,
      ),
    ),
  );

  Widget box3 = ConstrainedBox(
    constraints: BoxConstraints.expand(height: 50),
    child: Container(
      color: Color(0xFFFFCA28),
      alignment: Alignment.center,
      child: Text(
        'expand(h:50)',
        style: TextStyle(color: Colors.black87, fontSize: 11),
      ),
    ),
  );

  Widget box4 = ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: 0,
      maxWidth: double.infinity,
      minHeight: 30,
      maxHeight: 30,
    ),
    child: Container(
      color: Color(0xFF26A69A),
      alignment: Alignment.center,
      child: Text(
        'fixed height 30, flexible width',
        style: TextStyle(color: Colors.white, fontSize: 11),
      ),
    ),
  );

  print(
    '[render_objects_misc] ConstrainedBox demos built: minMax, tightFor, expand, fixed',
  );
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('ConstrainedBox - BoxConstraints'),
      _buildLabel('Various BoxConstraints configurations'),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [box1, box2],
      ),
      SizedBox(height: 10),
      _buildLabel('BoxConstraints.expand(height: 50)'),
      Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: box3),
      SizedBox(height: 10),
      _buildLabel('Fixed height, flexible width'),
      Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: box4),
    ],
  );
}

Widget _buildIntrinsicSection() {
  print(
    '[render_objects_misc] Building IntrinsicWidth / IntrinsicHeight section',
  );

  Widget intrinsicWidthDemo = IntrinsicWidth(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Color(0xFF1E88E5),
          padding: EdgeInsets.all(8),
          child: Text(
            'Short',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        SizedBox(height: 4),
        Container(
          color: Color(0xFF1565C0),
          padding: EdgeInsets.all(8),
          child: Text(
            'Medium length text',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        SizedBox(height: 4),
        Container(
          color: Color(0xFF0D47A1),
          padding: EdgeInsets.all(8),
          child: Text(
            'Longest text here determines width',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );

  Widget intrinsicHeightDemo = IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 50,
          color: Color(0xFF43A047),
          alignment: Alignment.center,
          child: Text('A', style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
        SizedBox(width: 4),
        Container(
          width: 50,
          color: Color(0xFF2E7D32),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'B\nTall',
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 4),
        Container(
          width: 50,
          color: Color(0xFF1B5E20),
          alignment: Alignment.center,
          child: Text('C', style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ],
    ),
  );

  print(
    '[render_objects_misc] IntrinsicWidth aligns children to widest; IntrinsicHeight to tallest',
  );
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('IntrinsicWidth & IntrinsicHeight'),
      _buildLabel('IntrinsicWidth - all children match widest'),
      SizedBox(height: 6),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: intrinsicWidthDemo,
      ),
      SizedBox(height: 16),
      _buildLabel('IntrinsicHeight - all children match tallest'),
      SizedBox(height: 6),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: intrinsicHeightDemo,
      ),
    ],
  );
}

Widget _buildAspectRatioSection() {
  print('[render_objects_misc] Building AspectRatio section');

  Widget ratioBox(double ratio, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          child: AspectRatio(
            aspectRatio: ratio,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
      ],
    );
  }

  print('[render_objects_misc] AspectRatio demos: 16/9, 4/3, 1/1, 3/2');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('AspectRatio - Fixed Ratios'),
      _buildLabel('Same width (120), different aspect ratios'),
      SizedBox(height: 8),
      Wrap(
        spacing: 16,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          ratioBox(16 / 9, '16:9', Color(0xFFD32F2F)),
          ratioBox(4 / 3, '4:3', Color(0xFF7B1FA2)),
          ratioBox(1 / 1, '1:1', Color(0xFF1976D2)),
          ratioBox(3 / 2, '3:2', Color(0xFF388E3C)),
        ],
      ),
    ],
  );
}

Widget _buildUnconstrainedBoxSection() {
  print('[render_objects_misc] Building UnconstrainedBox section');

  Widget unconstrained = UnconstrainedBox(
    child: Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFF8D6E63),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        'UnconstrainedBox child (250x50)',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );

  Widget unconstrainedH = UnconstrainedBox(
    constrainedAxis: Axis.horizontal,
    child: Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF6D4C41),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        'constrainedAxis: horizontal',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );

  Widget unconstrainedV = UnconstrainedBox(
    constrainedAxis: Axis.vertical,
    child: Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFF5D4037),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        'constrainedAxis: vertical',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );

  print(
    '[render_objects_misc] UnconstrainedBox: fully free, horizontal, vertical',
  );
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('UnconstrainedBox'),
      _buildLabel('Removes parent constraints from child'),
      SizedBox(height: 8),
      unconstrained,
      SizedBox(height: 8),
      unconstrainedH,
      SizedBox(height: 8),
      unconstrainedV,
    ],
  );
}

Widget _buildOverflowBarSection() {
  print('[render_objects_misc] Building OverflowBar section');

  Widget makeButton(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget bar1 = OverflowBar(
    spacing: 8,
    overflowSpacing: 6,
    overflowAlignment: OverflowBarAlignment.end,
    children: [
      makeButton('Cancel', Color(0xFF757575)),
      makeButton('Save Draft', Color(0xFF1976D2)),
      makeButton('Submit', Color(0xFF388E3C)),
    ],
  );

  Widget bar2 = OverflowBar(
    spacing: 8,
    overflowSpacing: 6,
    overflowAlignment: OverflowBarAlignment.center,
    children: [
      makeButton('Option A', Color(0xFFE64A19)),
      makeButton('Option B', Color(0xFF7B1FA2)),
      makeButton('Option C', Color(0xFF00838F)),
      makeButton('Option D', Color(0xFF558B2F)),
      makeButton('Option E', Color(0xFFC62828)),
    ],
  );

  print('[render_objects_misc] OverflowBar with 3 and 5 buttons');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('OverflowBar - Adaptive Layout'),
      _buildLabel('Horizontal when space allows, vertical overflow otherwise'),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: bar1,
      ),
      SizedBox(height: 12),
      _buildLabel('More buttons trigger overflow behavior'),
      SizedBox(height: 4),
      Container(
        width: 200,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: bar2,
      ),
    ],
  );
}

Widget _buildRichTextSection() {
  print('[render_objects_misc] Building RichText section');

  Widget richDemo = RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 14, color: Color(0xFF212121), height: 1.6),
      children: [
        TextSpan(
          text: 'RichText ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        TextSpan(text: 'allows '),
        TextSpan(
          text: 'multiple ',
          style: TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: 'styles ',
          style: TextStyle(
            color: Color(0xFF1976D2),
            fontStyle: FontStyle.italic,
          ),
        ),
        TextSpan(text: 'in a '),
        TextSpan(
          text: 'single ',
          style: TextStyle(
            decoration: TextDecoration.underline,
            decorationColor: Color(0xFF388E3C),
            color: Color(0xFF388E3C),
          ),
        ),
        TextSpan(text: 'paragraph. '),
        TextSpan(text: 'You can mix '),
        TextSpan(
          text: 'bold',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        TextSpan(text: ', '),
        TextSpan(
          text: 'italic',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        TextSpan(text: ', '),
        TextSpan(
          text: 'colored',
          style: TextStyle(
            color: Color(0xFFFF6F00),
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(text: ', and '),
        TextSpan(
          text: 'sized',
          style: TextStyle(fontSize: 20, color: Color(0xFF7B1FA2)),
        ),
        TextSpan(text: ' text freely.'),
      ],
    ),
  );

  Widget richDemo2 = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: TextStyle(fontSize: 13, color: Color(0xFF455A64), height: 1.5),
      children: [
        TextSpan(text: 'Status: '),
        TextSpan(
          text: 'ACTIVE',
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        TextSpan(text: '  |  Priority: '),
        TextSpan(
          text: 'HIGH',
          style: TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        TextSpan(text: '  |  Updated: '),
        TextSpan(
          text: '2026-03-23',
          style: TextStyle(
            color: Color(0xFF1565C0),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  print('[render_objects_misc] RichText demos built with mixed styles');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('RichText - Multiple TextSpan Styles'),
      _buildLabel('Mixed formatting in a single text widget'),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: richDemo,
      ),
      SizedBox(height: 12),
      _buildLabel('Status bar style with RichText'),
      SizedBox(height: 4),
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: Color(0xFFECEFF1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: richDemo2,
      ),
    ],
  );
}

Widget _buildSummarySection() {
  print('[render_objects_misc] Building summary section');

  List<Map<String, String>> items = [
    {
      'widget': 'SizedBox',
      'desc': 'Fixed width/height or expand/shrink/square',
    },
    {'widget': 'LimitedBox', 'desc': 'Limits size only when unconstrained'},
    {'widget': 'ConstrainedBox', 'desc': 'Applies BoxConstraints to child'},
    {'widget': 'IntrinsicWidth', 'desc': 'Sizes children to widest intrinsic'},
    {
      'widget': 'IntrinsicHeight',
      'desc': 'Sizes children to tallest intrinsic',
    },
    {'widget': 'AspectRatio', 'desc': 'Maintains width/height ratio'},
    {'widget': 'UnconstrainedBox', 'desc': 'Removes parent constraints'},
    {'widget': 'OverflowBar', 'desc': 'Adaptive horizontal/vertical layout'},
    {'widget': 'RichText', 'desc': 'Multiple TextSpan styles in one widget'},
  ];

  List<Widget> rows = [];
  for (int i = 0; i < items.length; i++) {
    Map<String, String> item = items[i];
    Color bgColor = i % 2 == 0 ? Color(0xFFF5F5F5) : Colors.white;
    rows.add(
      Container(
        color: bgColor,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 130,
              child: Text(
                item['widget']!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF4A148C),
                ),
              ),
            ),
            Expanded(
              child: Text(
                item['desc']!,
                style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print(
    '[render_objects_misc] Summary table built with ${items.length} entries',
  );
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('Summary - Misc Render Objects'),
      SizedBox(height: 6),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(children: rows),
      ),
    ],
  );
}

dynamic build(BuildContext context) {
  print('[render_objects_misc] ========================================');
  print('[render_objects_misc] Starting miscellaneous render objects demo');
  print('[render_objects_misc] ========================================');
  print('[render_objects_misc] Topics: SizedBox, LimitedBox, ConstrainedBox');
  print('[render_objects_misc] Topics: IntrinsicWidth/Height, AspectRatio');
  print(
    '[render_objects_misc] Topics: UnconstrainedBox, OverflowBar, RichText',
  );

  Widget content = SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('Misc Render Objects Demo'),
        SizedBox(height: 6),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Exploring sizing, constraining, and layout utility widgets',
            style: TextStyle(fontSize: 13, color: Color(0xFF78909C)),
          ),
        ),
        SizedBox(height: 16),
        _buildSizedBoxSection(),
        SizedBox(height: 20),
        _buildSizedBoxFactorySection(),
        SizedBox(height: 20),
        _buildLimitedBoxSection(),
        SizedBox(height: 20),
        _buildConstrainedBoxSection(),
        SizedBox(height: 20),
        _buildIntrinsicSection(),
        SizedBox(height: 20),
        _buildAspectRatioSection(),
        SizedBox(height: 20),
        _buildUnconstrainedBoxSection(),
        SizedBox(height: 20),
        _buildOverflowBarSection(),
        SizedBox(height: 20),
        _buildRichTextSection(),
        SizedBox(height: 20),
        _buildSummarySection(),
        SizedBox(height: 32),
        Center(
          child: Text(
            'End of Misc Render Objects Demo',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFBDBDBD),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );

  print('[render_objects_misc] All sections assembled');
  print('[render_objects_misc] Returning SingleChildScrollView');
  return content;
}
