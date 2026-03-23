// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: RenderOffstage / Offstage widget
// Tests Offstage with offstage true/false, space collapse behavior,
// comparison with Visibility, Opacity, SizedBox.shrink, state retention,
// layout effects in Column/Row, SliverOffstage, and practical patterns.

import 'package:flutter/material.dart';

Widget _buildHeader(String title, String subtitle) {
  print('Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF37474F), Color(0xFF546E7A), Color(0xFF78909C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x4037474F),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Color(0xCCFFFFFF)),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(IconData icon, String title) {
  print('Building section: $title');
  return Padding(
    padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0x1A37474F),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Color(0xFF37474F), size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCard(Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF616161),
      ),
    ),
  );
}

Widget _buildColorBox(Color color, double width, double height, String label) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0x33000000), width: 1),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildInfoBanner(String text, Color bgColor) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, size: 18, color: Color(0xFF37474F)),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Color(0xFF37474F)),
          ),
        ),
      ],
    ),
  );
}

// Section 1: Offstage true vs false comparison
Widget _buildOnOffComparison() {
  print('Section 1: Offstage true vs false comparison');

  Widget offstageDemo(String label, bool isOffstage, Color color) {
    print('  Offstage demo: $label, offstage=$isOffstage');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFBDBDBD), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Before',
                style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
              ),
              Offstage(
                offstage: isOffstage,
                child: _buildColorBox(
                  color,
                  120,
                  50,
                  isOffstage ? 'Hidden' : 'Visible',
                ),
              ),
              Text(
                'After',
                style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        offstageDemo(
          'offstage: false (child visible, takes space)',
          false,
          Color(0xFF4CAF50),
        ),
        offstageDemo(
          'offstage: true (child hidden, zero space)',
          true,
          Color(0xFFF44336),
        ),
        offstageDemo(
          'offstage: false (blue box shown)',
          false,
          Color(0xFF2196F3),
        ),
        offstageDemo(
          'offstage: true (orange box hidden)',
          true,
          Color(0xFFFF9800),
        ),
      ],
    ),
  );
}

// Section 2: Space collapse demonstration
Widget _buildSpaceCollapseSection() {
  print('Section 2: Offstage content takes zero space');

  Widget collapseDemo(String label, bool offstageMiddle) {
    print('  Space collapse demo: $label, middle offstage=$offstageMiddle');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              _buildColorBox(Color(0xFF66BB6A), 200, 30, 'Top item'),
              SizedBox(height: 4),
              Offstage(
                offstage: offstageMiddle,
                child: Column(
                  children: [
                    _buildColorBox(
                      Color(0xFFEF5350),
                      200,
                      60,
                      'Middle item (offstaged)',
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
              _buildColorBox(Color(0xFF42A5F5), 200, 30, 'Bottom item'),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        collapseDemo('All visible - middle occupies space', false),
        collapseDemo('Middle offstage - top and bottom touch', true),
        _buildLabel('Notice how bottom moves up when middle is offstage'),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(6),
          child: Row(
            children: [
              _buildColorBox(Color(0xFF7E57C2), 60, 60, 'A'),
              SizedBox(width: 4),
              Offstage(
                offstage: true,
                child: _buildColorBox(Color(0xFFEF5350), 60, 60, 'B'),
              ),
              _buildColorBox(Color(0xFF26A69A), 60, 60, 'C'),
              SizedBox(width: 4),
              _buildColorBox(Color(0xFFFFA726), 60, 60, 'D'),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Row above: B is offstage, so A and C are adjacent',
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 3: Offstage vs Visibility comparison
Widget _buildOffstageVsVisibility() {
  print('Section 3: Offstage vs Visibility comparison');

  Widget comparisonPair(String approach, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(approach),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              _buildColorBox(Color(0xFF81C784), 180, 24, 'Above'),
              SizedBox(height: 4),
              child,
              SizedBox(height: 4),
              _buildColorBox(Color(0xFF64B5F6), 180, 24, 'Below'),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  print('  Comparing Offstage(offstage:true) vs Visibility(visible:false)');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        comparisonPair(
          'Offstage(offstage: true) - takes ZERO space',
          Offstage(
            offstage: true,
            child: _buildColorBox(Color(0xFFE53935), 180, 50, 'Offstaged'),
          ),
        ),
        comparisonPair(
          'Visibility(visible: false) - STILL takes space',
          Visibility(
            visible: false,
            child: _buildColorBox(Color(0xFFE53935), 180, 50, 'Invisible'),
          ),
        ),
        comparisonPair(
          'Visibility(visible: false, maintainSize: false) - also collapses',
          Visibility(
            visible: false,
            maintainSize: false,
            maintainAnimation: false,
            maintainState: false,
            child: _buildColorBox(Color(0xFFE53935), 180, 50, 'Gone'),
          ),
        ),
        Text(
          'Offstage always collapses. Visibility has fine-grained control.',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF757575),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// Section 4: Offstage vs Opacity(opacity: 0) comparison
Widget _buildOffstageVsOpacity() {
  print('Section 4: Offstage vs Opacity(opacity: 0)');

  Widget opacityCompare(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFCE93D8)),
          ),
          padding: EdgeInsets.all(6),
          child: Row(
            children: [
              _buildColorBox(Color(0xFF8E24AA), 50, 50, 'L'),
              SizedBox(width: 4),
              child,
              SizedBox(width: 4),
              _buildColorBox(Color(0xFF8E24AA), 50, 50, 'R'),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  print('  Opacity(0) keeps space, Offstage removes it');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        opacityCompare(
          'Normal visible box between L and R',
          _buildColorBox(Color(0xFFFF7043), 80, 50, 'M'),
        ),
        opacityCompare(
          'Opacity(opacity: 0) - invisible but occupies space',
          Opacity(
            opacity: 0.0,
            child: _buildColorBox(Color(0xFFFF7043), 80, 50, 'M'),
          ),
        ),
        opacityCompare(
          'Offstage(offstage: true) - invisible AND no space',
          Offstage(
            offstage: true,
            child: _buildColorBox(Color(0xFFFF7043), 80, 50, 'M'),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Opacity(0): still takes space, still receives hit tests.\n'
            'Offstage: no space, no painting, no hit testing.',
            style: TextStyle(fontSize: 11, color: Color(0xFFE65100)),
          ),
        ),
      ],
    ),
  );
}

// Section 5: Offstage vs SizedBox.shrink comparison
Widget _buildOffstageVsSizedBoxShrink() {
  print('Section 5: Offstage vs replacing with SizedBox.shrink()');

  Widget replacementDemo(String label, Widget middle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFA5D6A7)),
          ),
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              _buildColorBox(Color(0xFF388E3C), 160, 28, 'First'),
              SizedBox(height: 4),
              middle,
              SizedBox(height: 4),
              _buildColorBox(Color(0xFF388E3C), 160, 28, 'Last'),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  print('  SizedBox.shrink also collapses but destroys the widget');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        replacementDemo(
          'Content present (visible)',
          _buildColorBox(Color(0xFFFF5722), 160, 50, 'Content'),
        ),
        replacementDemo(
          'Offstage(offstage: true) - hidden but widget exists',
          Offstage(
            offstage: true,
            child: _buildColorBox(Color(0xFFFF5722), 160, 50, 'Content'),
          ),
        ),
        replacementDemo(
          'SizedBox.shrink() - widget replaced entirely',
          SizedBox.shrink(),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key difference:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Offstage keeps the child widget alive (preserves state).\n'
                'SizedBox.shrink replaces it entirely (state lost).\n'
                'Both produce zero visual space.',
                style: TextStyle(fontSize: 11, color: Color(0xFF1976D2)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 6: State maintenance while offstage
Widget _buildStateMaintenance() {
  print('Section 6: Offstage children maintain state');

  print('  Demonstrating offstage content retaining subtree identity');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Offstaged content subtree still exists in element tree'),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFFE082)),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Below: StatefulWidget inside Offstage(offstage: true)',
                style: TextStyle(fontSize: 12, color: Color(0xFFF57F17)),
              ),
              SizedBox(height: 6),
              Offstage(
                offstage: true,
                child: Column(
                  children: [
                    // This TextField state is preserved even when offstage
                    SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'I am offstage but alive',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    // AnimatedContainer still in the tree
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 100,
                      height: 100,
                      color: Color(0xFFFF9800),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Text(
                'TextField and AnimatedContainer above are offstage.',
                style: TextStyle(fontSize: 11, color: Color(0xFFF9A825)),
              ),
              Text(
                'They consume zero space but their State objects persist.',
                style: TextStyle(fontSize: 11, color: Color(0xFFF9A825)),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('Offstage still participates in semantics'),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Offstage(
                offstage: true,
                child: Semantics(
                  label: 'Hidden button for screen readers',
                  child: ElevatedButton(
                    onPressed: () {
                      print('Offstage button pressed (semantics only)');
                    },
                    child: Text('Semantic Button'),
                  ),
                ),
              ),
              Text(
                'An offstage ElevatedButton above still provides\n'
                'semantics for accessibility tools (unlike Visibility).',
                style: TextStyle(fontSize: 11, color: Color(0xFF6A1B9A)),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('Multiple stateful children offstage'),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Offstage(
                offstage: true,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.timer),
                      title: Text('Timer widget'),
                      subtitle: Text('State preserved'),
                    ),
                    LinearProgressIndicator(value: 0.7),
                    CircularProgressIndicator(value: 0.5),
                    Slider(value: 0.3, onChanged: (v) {}),
                  ],
                ),
              ),
              Text(
                'ListTile, progress indicators, and Slider are all\n'
                'in the tree above but offstage. Zero visual space.',
                style: TextStyle(fontSize: 11, color: Color(0xFF00695C)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 7: Offstage in Column and Row layouts
Widget _buildColumnRowLayouts() {
  print('Section 7: Offstage in Column/Row layouts showing space collapse');

  Widget layoutBox(Color color, String label, double w, double h) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  print('  Column layout with some offstage children');
  print('  Row layout with offstage children');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Column with item 2 and 4 offstage'),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              layoutBox(Color(0xFF1E88E5), '1', 200, 30),
              SizedBox(height: 4),
              Offstage(
                offstage: true,
                child: layoutBox(Color(0xFFE53935), '2 (offstage)', 200, 30),
              ),
              layoutBox(Color(0xFF43A047), '3', 200, 30),
              SizedBox(height: 4),
              Offstage(
                offstage: true,
                child: layoutBox(Color(0xFFFB8C00), '4 (offstage)', 200, 30),
              ),
              layoutBox(Color(0xFF8E24AA), '5', 200, 30),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Items 2 and 4 are offstage: Column shows only 1, 3, 5',
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
        ),
        SizedBox(height: 16),
        _buildLabel('Row with item B offstage'),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              layoutBox(Color(0xFF1E88E5), 'A', 50, 50),
              SizedBox(width: 4),
              Offstage(
                offstage: true,
                child: Row(
                  children: [
                    layoutBox(Color(0xFFE53935), 'B', 50, 50),
                    SizedBox(width: 4),
                  ],
                ),
              ),
              layoutBox(Color(0xFF43A047), 'C', 50, 50),
              SizedBox(width: 4),
              layoutBox(Color(0xFF8E24AA), 'D', 50, 50),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Item B offstage: Row renders A, C, D without gap for B',
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
        ),
        SizedBox(height: 16),
        _buildLabel('Wrap with some offstage children'),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(6),
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              layoutBox(Color(0xFF0288D1), 'W1', 60, 40),
              Offstage(
                offstage: true,
                child: layoutBox(Color(0xFFD32F2F), 'W2', 60, 40),
              ),
              layoutBox(Color(0xFF388E3C), 'W3', 60, 40),
              layoutBox(Color(0xFFF57C00), 'W4', 60, 40),
              Offstage(
                offstage: true,
                child: layoutBox(Color(0xFF7B1FA2), 'W5', 60, 40),
              ),
              layoutBox(Color(0xFF00796B), 'W6', 60, 40),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Wrap: W2 and W5 are offstage, flow adjusts accordingly',
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 8: SliverOffstage for sliver contexts
Widget _buildSliverOffstageSection() {
  print('Section 8: SliverOffstage for sliver contexts');

  print('  Building a CustomScrollView with SliverOffstage items');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('SliverOffstage hides slivers without space'),
        SizedBox(
          height: 220,
          child: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 40,
                  color: Color(0xFF1E88E5),
                  alignment: Alignment.center,
                  child: Text(
                    'Sliver 1 (visible)',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              SliverOffstage(
                offstage: true,
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: 60,
                    color: Color(0xFFE53935),
                    alignment: Alignment.center,
                    child: Text(
                      'Sliver 2 (offstage)',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 40,
                  color: Color(0xFF43A047),
                  alignment: Alignment.center,
                  child: Text(
                    'Sliver 3 (visible)',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              SliverOffstage(
                offstage: false,
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: 40,
                    color: Color(0xFFFB8C00),
                    alignment: Alignment.center,
                    child: Text(
                      'Sliver 4 (offstage=false)',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
              SliverOffstage(
                offstage: true,
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      height: 30,
                      color: Color(0xFF7B1FA2),
                      child: Text(
                        'Hidden list A',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      height: 30,
                      color: Color(0xFF6A1B9A),
                      child: Text(
                        'Hidden list B',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ]),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 40,
                  color: Color(0xFF00695C),
                  alignment: Alignment.center,
                  child: Text(
                    'Sliver 6 (visible, after hidden list)',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Sliver 2 and the hidden SliverList take no scroll extent.',
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 9: Practical patterns
Widget _buildPracticalPatterns() {
  print('Section 9: Practical patterns with Offstage');

  print('  Pattern: preloading content');
  print('  Pattern: conditional form sections');
  print('  Pattern: tab-like switching');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Pattern: Preloading heavy content'),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preload a complex widget offstage for instant reveal:',
                style: TextStyle(fontSize: 12, color: Color(0xFF283593)),
              ),
              SizedBox(height: 6),
              // Simulating preloaded image/chart that is not yet shown
              Offstage(
                offstage: true,
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color(0xFF3F51B5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bar_chart, size: 40, color: Colors.white),
                      Text(
                        'Heavy Chart Widget',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'A chart widget is preloaded above (offstage).\n'
                'When needed, flip offstage to false for instant display.',
                style: TextStyle(fontSize: 11, color: Color(0xFF3949AB)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildLabel('Pattern: Conditional form sections'),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping address (always shown):',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '123 Main Street, City',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Billing address (offstage if same as shipping):',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Offstage(
                offstage: true,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Different billing address',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter billing address',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Billing section hidden but state preserved.\n'
                'User toggle reveals it without rebuilding.',
                style: TextStyle(fontSize: 11, color: Color(0xFF558B2F)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildLabel('Pattern: Tab-like switching with Offstage'),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Multiple pages stacked with Offstage (IndexedStack pattern):',
                style: TextStyle(fontSize: 12, color: Color(0xFFC62828)),
              ),
              SizedBox(height: 6),
              Stack(
                children: [
                  // Page 0: visible (selected)
                  Offstage(
                    offstage: false,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFFE91E63),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Page 0 - Active',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Page 1: offstage
                  Offstage(
                    offstage: true,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      color: Color(0xFF2196F3),
                      alignment: Alignment.center,
                      child: Text(
                        'Page 1 - Offstage',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // Page 2: offstage
                  Offstage(
                    offstage: true,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      color: Color(0xFF4CAF50),
                      alignment: Alignment.center,
                      child: Text(
                        'Page 2 - Offstage',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'This is how IndexedStack works internally.\n'
                'All pages stay alive; only one is onstage.',
                style: TextStyle(fontSize: 11, color: Color(0xFFAD1457)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 10: Debug logging and introspection
Widget _buildDebugLoggingSection() {
  print('Section 10: Debug logging and introspection');

  print('  Offstage.of(context) returns whether ancestor is offstage');
  print('  RenderOffstage.offstage property controls painting');
  print('  RenderOffstage.performLayout uses zero size when offstage');
  print('  Offstage wraps RenderOffstage in the render tree');

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Offstage under the hood'),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RenderOffstage internals:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF37474F),
                ),
              ),
              SizedBox(height: 6),
              Text(
                '- offstage=true: size = Size.zero',
                style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
              ),
              Text(
                '- offstage=true: paint() is a no-op',
                style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
              ),
              Text(
                '- offstage=true: hitTest() returns false',
                style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
              ),
              Text(
                '- offstage=false: behaves like normal RenderBox',
                style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
              ),
              Text(
                '- Always lays out child (to maintain state)',
                style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
              ),
              Text(
                '- Semantics still active even when offstage',
                style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('Summary comparison table'),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Table(
            border: TableBorder.all(color: Color(0xFFBDBDBD), width: 0.5),
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: Color(0xFF37474F)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'Technique',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'Space',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'State',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'Semantics',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Offstage', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('None', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Kept', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Yes', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Visibility', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Config', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Config', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Config', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Opacity(0)', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Kept', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Kept', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Yes', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'SizedBox.shrink',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('None', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Lost', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('No', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('if(false)', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('None', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('Lost', style: TextStyle(fontSize: 10)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('No', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== RenderOffstage / Offstage Deep Demo ===');
  print('Offstage: hides child, takes zero space, preserves state');
  print('SliverOffstage: same for sliver contexts');
  print('Unlike Visibility, Offstage always collapses space');
  print('Unlike Opacity(0), Offstage does not participate in layout');
  print('Unlike SizedBox.shrink(), Offstage preserves widget state');
  print('Building all 10 demo sections...');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          'RenderOffstage Deep Demo',
          'Offstage / SliverOffstage - hide widgets with zero space',
        ),

        // Section 1
        _buildSectionTitle(Icons.compare_arrows, '1. Offstage: true vs false'),
        _buildInfoBanner(
          'Offstage(offstage: true) hides the child and takes zero space. '
          'Offstage(offstage: false) shows the child normally.',
          Color(0xFFE8F5E9),
        ),
        _buildOnOffComparison(),

        // Section 2
        _buildSectionTitle(Icons.compress, '2. Space Collapse Behavior'),
        _buildInfoBanner(
          'When offstage, surrounding widgets collapse as if the child does not exist.',
          Color(0xFFE3F2FD),
        ),
        _buildSpaceCollapseSection(),

        // Section 3
        _buildSectionTitle(Icons.visibility_off, '3. Offstage vs Visibility'),
        _buildInfoBanner(
          'Visibility has fine-grained control (maintainSize, maintainState, maintainAnimation). '
          'Offstage always collapses space and always keeps state.',
          Color(0xFFFCE4EC),
        ),
        _buildOffstageVsVisibility(),

        // Section 4
        _buildSectionTitle(Icons.opacity, '4. Offstage vs Opacity(0)'),
        _buildInfoBanner(
          'Opacity(0) makes the child invisible but it still occupies space and receives hit tests. '
          'Offstage removes both.',
          Color(0xFFF3E5F5),
        ),
        _buildOffstageVsOpacity(),

        // Section 5
        _buildSectionTitle(Icons.swap_horiz, '5. Offstage vs SizedBox.shrink'),
        _buildInfoBanner(
          'SizedBox.shrink replaces the widget entirely (state lost). '
          'Offstage hides it while preserving the widget subtree.',
          Color(0xFFE8EAF6),
        ),
        _buildOffstageVsSizedBoxShrink(),

        // Section 6
        _buildSectionTitle(Icons.memory, '6. State Maintenance'),
        _buildInfoBanner(
          'Offstage children still exist in the element tree. '
          'StatefulWidget State objects, animations, and semantics all persist.',
          Color(0xFFFFF8E1),
        ),
        _buildStateMaintenance(),

        // Section 7
        _buildSectionTitle(Icons.view_column, '7. Column / Row Layouts'),
        _buildInfoBanner(
          'Offstage within Column, Row, and Wrap causes layout space to collapse completely.',
          Color(0xFFE0F7FA),
        ),
        _buildColumnRowLayouts(),

        // Section 8
        _buildSectionTitle(Icons.view_list, '8. SliverOffstage'),
        _buildInfoBanner(
          'SliverOffstage hides slivers so they consume zero scroll extent.',
          Color(0xFFF1F8E9),
        ),
        _buildSliverOffstageSection(),

        // Section 9
        _buildSectionTitle(Icons.build_circle, '9. Practical Patterns'),
        _buildInfoBanner(
          'Preloading content, conditional form sections, and tab-like switching with Offstage.',
          Color(0xFFFFF3E0),
        ),
        _buildPracticalPatterns(),

        // Section 10
        _buildSectionTitle(Icons.bug_report, '10. Debug Info & Comparison'),
        _buildInfoBanner(
          'RenderOffstage implementation details and technique comparison table.',
          Color(0xFFECEFF1),
        ),
        _buildDebugLoggingSection(),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of RenderOffstage Deep Demo',
            style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}
