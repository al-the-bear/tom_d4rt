// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: SliverHitTestResult deep demo
// Visual demonstration of sliver hit-testing concepts and coordinate spaces
import 'package:flutter/material.dart';

// ============================================================
// HERO HEADER HELPERS
// ============================================================

Widget _buildHeroHeader() {
  return Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade900,
          Colors.indigo.shade700,
          Colors.deepPurple.shade600,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                Icons.touch_app,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SliverHitTestResult',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'extends HitTestResult',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                      color: Colors.amber.shade200,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            'A specialized HitTestResult that records hit-test entries in '
            'sliver coordinates (mainAxisPosition / crossAxisPosition). '
            'Render slivers append entries here while the framework walks '
            'a CustomScrollView searching for the deepest target under a '
            'pointer event. The result is the path that gesture events '
            'will traverse.',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildHeaderIconChip(Icons.layers, 'Slivers'),
            _buildHeaderIconChip(Icons.swap_horiz, 'Axis Offset'),
            _buildHeaderIconChip(Icons.transform, 'Transforms'),
            _buildHeaderIconChip(Icons.list_alt, 'Path'),
            _buildHeaderIconChip(Icons.gesture, 'Gestures'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildHeaderIconChip(IconData icon, String label) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Icon(icon, color: Colors.white, size: 22.0),
      ),
      SizedBox(height: 6.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.white.withValues(alpha: 0.9),
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

// ============================================================
// SECTION TITLE STRIP
// ============================================================

Widget _buildSectionTitle(
  String number,
  String title,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(top: 32.0, bottom: 12.0),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.95), color.withValues(alpha: 0.7)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Icon(icon, color: Colors.white, size: 24.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// COORDINATE SPACE COMPARISON
// ============================================================

Widget _buildCoordinateComparison() {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Two Coordinate Worlds',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'A pointer event must be translated as it walks the tree.',
          style: TextStyle(fontSize: 12.0, color: Colors.teal.shade700),
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildBoxSpaceCard()),
            SizedBox(width: 12.0),
            _buildArrowBetween(),
            SizedBox(width: 12.0),
            Expanded(child: _buildSliverSpaceCard()),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.teal.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  color: Colors.teal.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'BoxHitTestResult uses (x, y) in local pixels. '
                  'SliverHitTestResult uses (mainAxisPosition, '
                  'crossAxisPosition) measured in the scroll-axis frame. '
                  'A Viewport bridges between the two when descending '
                  'into its child slivers.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.teal.shade900,
                    height: 1.4,
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

Widget _buildBoxSpaceCard() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blue.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.crop_square, color: Colors.blue.shade700, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              'BoxHitTestResult',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 8.0,
                top: 4.0,
                child: Text('(0,0)',
                    style: TextStyle(
                        fontSize: 9.0,
                        fontFamily: 'monospace',
                        color: Colors.blue.shade800)),
              ),
              Positioned(
                right: 8.0,
                bottom: 4.0,
                child: Text('(w,h)',
                    style: TextStyle(
                        fontSize: 9.0,
                        fontFamily: 'monospace',
                        color: Colors.blue.shade800)),
              ),
              Positioned(
                left: 60.0,
                top: 30.0,
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withValues(alpha: 0.5),
                          blurRadius: 4.0)
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 76.0,
                top: 28.0,
                child: Text('pointer',
                    style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.red.shade800,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        _buildKeyValueRow('axes', 'x, y'),
        _buildKeyValueRow('units', 'logical pixels'),
        _buildKeyValueRow('origin', 'top-left of box'),
        _buildKeyValueRow('used by', 'RenderBox subtree'),
      ],
    ),
  );
}

Widget _buildSliverSpaceCard() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.purple.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.view_stream, color: Colors.purple.shade700, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              'SliverHitTestResult',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.purple.shade200),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 8.0,
                top: 4.0,
                child: Text('main=0',
                    style: TextStyle(
                        fontSize: 9.0,
                        fontFamily: 'monospace',
                        color: Colors.purple.shade800)),
              ),
              Positioned(
                left: 8.0,
                bottom: 4.0,
                child: Text('main=inf',
                    style: TextStyle(
                        fontSize: 9.0,
                        fontFamily: 'monospace',
                        color: Colors.purple.shade800)),
              ),
              Positioned(
                left: 0.0,
                top: 30.0,
                right: 0.0,
                child: Container(height: 1.0, color: Colors.purple.shade300),
              ),
              Positioned(
                top: 0.0,
                bottom: 0.0,
                left: 70.0,
                child: Container(width: 1.0, color: Colors.purple.shade300),
              ),
              Positioned(
                left: 64.0,
                top: 24.0,
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.deepOrange.withValues(alpha: 0.5),
                          blurRadius: 4.0)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        _buildKeyValueRow('axes', 'mainAxis, crossAxis'),
        _buildKeyValueRow('units', 'scroll pixels'),
        _buildKeyValueRow('origin', 'leading edge of sliver'),
        _buildKeyValueRow('used by', 'RenderSliver subtree'),
      ],
    ),
  );
}

Widget _buildKeyValueRow(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        SizedBox(
          width: 60.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildArrowBetween() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.compare_arrows, color: Colors.teal.shade600, size: 28.0),
      SizedBox(height: 4.0),
      Text(
        'translate',
        style: TextStyle(
          fontSize: 9.0,
          color: Colors.teal.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

// ============================================================
// LIVE CUSTOM SCROLL VIEW
// ============================================================

Widget _buildLiveCustomScrollView() {
  final listItems = <Widget>[];
  final itemColors = <MaterialColor>[
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.lime,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  for (var i = 0; i < itemColors.length; i++) {
    final c = itemColors[i];
    listItems.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: c.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: c.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c.shade400,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'SliverList entry #${i + 1}',
                style: TextStyle(
                  fontSize: 13.0,
                  color: c.shade900,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: c.shade400, size: 18.0),
          ],
        ),
      ),
    );
  }

  final gridItems = <Widget>[];
  for (var i = 0; i < 12; i++) {
    final hue = (i * 30) % 360;
    gridItems.add(
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              HSLColor.fromAHSL(1.0, hue.toDouble(), 0.5, 0.65).toColor(),
              HSLColor.fromAHSL(1.0, hue.toDouble(), 0.5, 0.45).toColor(),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        alignment: Alignment.center,
        child: Text(
          'G${i + 1}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.smartphone, color: Colors.grey.shade700, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              'Live CustomScrollView (a sliver host)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Each child sliver appends entries to a SliverHitTestResult '
          'while a hit walk descends.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 260.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 70.0,
                backgroundColor: Colors.indigo.shade600,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'SliverAppBar',
                    style: TextStyle(fontSize: 13.0, color: Colors.white),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo.shade400,
                          Colors.indigo.shade800,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(8.0),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.amber.shade400),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lightbulb_outline,
                            color: Colors.amber.shade800, size: 16.0),
                        SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            'SliverToBoxAdapter - escapes back to box space',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.amber.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(listItems),
              ),
              SliverPadding(
                padding: EdgeInsets.all(8.0),
                sliver: SliverGrid(
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                  ),
                  delegate: SliverChildListDelegate(gridItems),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey.shade200, Colors.grey.shade300],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flag_outlined,
                          color: Colors.grey.shade600, size: 24.0),
                      SizedBox(height: 6.0),
                      Text(
                        'SliverFillRemaining - terminal sliver',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        _buildSliverLegend(),
      ],
    ),
  );
}

Widget _buildSliverLegend() {
  return Wrap(
    spacing: 6.0,
    runSpacing: 6.0,
    children: [
      _buildLegendChip('SliverAppBar', Colors.indigo),
      _buildLegendChip('SliverPadding', Colors.amber),
      _buildLegendChip('SliverToBoxAdapter', Colors.orange),
      _buildLegendChip('SliverList', Colors.green),
      _buildLegendChip('SliverGrid', Colors.purple),
      _buildLegendChip('SliverFillRemaining', Colors.grey),
    ],
  );
}

Widget _buildLegendChip(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.shade50,
      border: Border.all(color: color.shade300),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: color.shade500,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            color: color.shade900,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HIT-TRAIL VISUALIZATION
// ============================================================

Widget _buildHitTrailVisualization() {
  final entries = <Map<String, Object>>[
    <String, Object>{
      'label': 'RenderViewport',
      'detail': 'Box-space wrapper. Calls hitTestChildren on slivers.',
      'method': 'hitTestChildren()',
      'color': Colors.blue,
      'icon': Icons.crop_landscape,
    },
    <String, Object>{
      'label': 'RenderSliverPadding',
      'detail': 'Adjusts the axis-offset before delegating downward.',
      'method': 'addWithAxisOffset(...)',
      'color': Colors.amber,
      'icon': Icons.padding,
    },
    <String, Object>{
      'label': 'RenderSliverList',
      'detail': 'Iterates visible children, computes child main offset.',
      'method': 'addWithAxisOffset(...)',
      'color': Colors.green,
      'icon': Icons.list,
    },
    <String, Object>{
      'label': 'RenderSliverToBoxAdapter',
      'detail': 'Bridge: re-enters box coordinates for the wrapped child.',
      'method': 'BoxHitTestResult.wrap(this)',
      'color': Colors.deepOrange,
      'icon': Icons.swap_calls,
    },
    <String, Object>{
      'label': 'RenderParagraph',
      'detail': 'Box leaf. Records a final BoxHitTestEntry.',
      'method': 'add(BoxHitTestEntry)',
      'color': Colors.purple,
      'icon': Icons.text_fields,
    },
  ];

  final cards = <Widget>[];
  for (var i = 0; i < entries.length; i++) {
    final e = entries[i];
    final color = e['color'] as MaterialColor;
    cards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.0,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: color.shade500,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.4),
                          blurRadius: 4.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (i < entries.length - 1)
                    Container(
                      width: 2.0,
                      height: 32.0,
                      color: color.shade200,
                    ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.shade50, color.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: color.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(e['icon'] as IconData,
                            color: color.shade800, size: 16.0),
                        SizedBox(width: 6.0),
                        Text(
                          e['label'] as String,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: color.shade900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      e['detail'] as String,
                      style: TextStyle(
                        fontSize: 11.0,
                        color: color.shade900,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        e['method'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.0,
                          color: Colors.greenAccent.shade100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Colors.indigo.shade700, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              'Hit-test trail (push order)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Each level appends an entry. Order matters for gesture dispatch.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        ...cards,
      ],
    ),
  );
}

// ============================================================
// SLIVER <-> BOX TRANSITION
// ============================================================

Widget _buildTransitionPanel() {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepOrange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.12),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.swap_horiz,
                color: Colors.deepOrange.shade800, size: 22.0),
            SizedBox(width: 6.0),
            Text(
              'Where coordinates change hands',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildSpaceBlock(
                title: 'Box space',
                subtitle: 'Pointer at (px, py)',
                icon: Icons.crop_square,
                color: Colors.blue,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                children: [
                  Icon(Icons.arrow_forward,
                      color: Colors.deepOrange, size: 26.0),
                  Text(
                    'Viewport',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.deepOrange.shade900,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildSpaceBlock(
                title: 'Sliver space',
                subtitle: '(mainAxis, crossAxis)',
                icon: Icons.view_stream,
                color: Colors.purple,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                children: [
                  Icon(Icons.arrow_forward,
                      color: Colors.deepOrange, size: 26.0),
                  Text(
                    'BoxAdapter',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.deepOrange.shade900,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildSpaceBlock(
                title: 'Box space',
                subtitle: 'Re-entered for leaf',
                icon: Icons.crop_square,
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.deepOrange.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletLine(
                'A SliverHitTestEntry remembers the main/cross position '
                'where it succeeded; the framework wraps it back into '
                'global box coords for gesture delivery.',
              ),
              _buildBulletLine(
                'BoxHitTestResult.wrap(SliverHitTestResult) pushes a '
                'transform that converts box-space results recorded '
                'inside a sliver back into the surrounding box space.',
              ),
              _buildBulletLine(
                'Each transition adds an HitTestEntry node so that '
                'gesture recognizers can replay the same trail.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSpaceBlock({
  required String title,
  required String subtitle,
  required IconData icon,
  required MaterialColor color,
}) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade300, width: 1.5),
    ),
    child: Column(
      children: [
        Icon(icon, color: color.shade700, size: 26.0),
        SizedBox(height: 4.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.0,
            color: color.shade800,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _buildBulletLine(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.0, right: 6.0),
          child: Icon(Icons.fiber_manual_record,
              color: Colors.deepOrange.shade400, size: 8.0),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepOrange.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// API SURFACE MATRIX
// ============================================================

Widget _buildApiMatrix() {
  final apis = <Map<String, Object>>[
    <String, Object>{
      'name': 'addWithAxisOffset',
      'sig': 'void addWithAxisOffset({...})',
      'desc': 'Records an entry while shifting the main-axis position. '
          'Used by parent slivers when descending into a child whose '
          'leading edge is offset within the sliver.',
      'icon': Icons.swap_vert,
      'color': Colors.indigo,
    },
    <String, Object>{
      'name': 'add',
      'sig': 'void add(HitTestEntry entry)',
      'desc': 'Inherited from HitTestResult. Appends a hit entry into '
          'the path list in the order of recording.',
      'icon': Icons.add_circle_outline,
      'color': Colors.green,
    },
    <String, Object>{
      'name': 'path',
      'sig': 'Iterable<HitTestEntry> get path',
      'desc': 'Inherited iterable representing the recorded path of '
          'hits, walked later by gesture dispatch and routing.',
      'icon': Icons.alt_route,
      'color': Colors.teal,
    },
    <String, Object>{
      'name': 'pushTransform',
      'sig': 'void pushTransform(Matrix4 transform)',
      'desc': 'Inherited helper to push a coordinate transform on the '
          'internal stack while a sub-walk happens.',
      'icon': Icons.transform,
      'color': Colors.purple,
    },
    <String, Object>{
      'name': 'pushOffset',
      'sig': 'void pushOffset(Offset offset)',
      'desc': 'Inherited convenience for translation-only transforms; '
          'less work than a full matrix push.',
      'icon': Icons.open_with,
      'color': Colors.deepOrange,
    },
    <String, Object>{
      'name': 'popTransform',
      'sig': 'void popTransform()',
      'desc': 'Pairs with push* to restore the previous coordinate '
          'frame after the child sub-walk finishes.',
      'icon': Icons.replay,
      'color': Colors.brown,
    },
    <String, Object>{
      'name': 'wrap ctor',
      'sig': 'SliverHitTestResult.wrap(HitTestResult)',
      'desc': 'Creates a SliverHitTestResult that shares its path with '
          'an existing HitTestResult; commonly used at the box->sliver '
          'boundary inside a Viewport.',
      'icon': Icons.compare,
      'color': Colors.blueGrey,
    },
    <String, Object>{
      'name': 'lastTransform',
      'sig': 'Matrix4? get lastTransform',
      'desc': 'Inherited. Most recent transform on the stack. Used by '
          'sliver walkers to map a position into local frame.',
      'icon': Icons.layers,
      'color': Colors.cyan,
    },
  ];

  final cards = <Widget>[];
  for (var i = 0; i < apis.length; i++) {
    cards.add(_buildApiCard(apis[i]));
  }

  return Wrap(
    spacing: 10.0,
    runSpacing: 10.0,
    children: cards,
  );
}

Widget _buildApiCard(Map<String, Object> api) {
  final color = api['color'] as MaterialColor;
  return Container(
    width: 230.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(api['icon'] as IconData,
                  color: color.shade800, size: 18.0),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                api['name'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            api['sig'] as String,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.tealAccent.shade100,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          api['desc'] as String,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade800,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// PITFALLS PANEL
// ============================================================

Widget _buildPitfallsPanel() {
  final pitfalls = <Map<String, Object>>[
    <String, Object>{
      'icon': Icons.warning_amber,
      'title': 'Custom slivers forgetting axis offset',
      'desc': 'A custom RenderSliver with a moving child must call '
          'addWithAxisOffset, not add directly, or the recorded path '
          'will be off by the child leading offset.',
    },
    <String, Object>{
      'icon': Icons.layers_clear,
      'title': 'Pinned headers overlapping list items',
      'desc': 'Pinned SliverPersistentHeaders can sit visually over '
          'list items. Only one wins the hit walk - the one whose '
          'paint order is on top, which is determined by the sliver '
          'order in CustomScrollView.slivers.',
    },
    <String, Object>{
      'icon': Icons.pageview,
      'title': 'Paged scroll viewports',
      'desc': 'PageView and similar paged surfaces have their own '
          'sliver coordinate quirks per page. Each page maintains '
          'its own SliverHitTestResult walk.',
    },
    <String, Object>{
      'icon': Icons.lock_clock,
      'title': 'Floating SliverAppBar timing',
      'desc': 'A floating SliverAppBar that animates back into view '
          'must accept hits during the animation; if its scrollOffset '
          'is not accounted for, taps fall through.',
    },
    <String, Object>{
      'icon': Icons.swap_horizontal_circle,
      'title': 'Reversed scroll directions',
      'desc': 'AxisDirection.up reverses the main-axis offset semantics. '
          'Manually adding entries without honouring the axis direction '
          'will hit the wrong child.',
    },
  ];

  final rows = <Widget>[];
  for (var i = 0; i < pitfalls.length; i++) {
    rows.add(_buildPitfallRow(pitfalls[i]));
  }

  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade100, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.report_problem,
                color: Colors.amber.shade800, size: 22.0),
            SizedBox(width: 6.0),
            Text(
              'When this matters',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...rows,
      ],
    ),
  );
}

Widget _buildPitfallRow(Map<String, Object> p) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(p['icon'] as IconData,
              color: Colors.orange.shade900, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p['title'] as String,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade900,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                p['desc'] as String,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.brown.shade900,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// CODE BLOCK PANEL
// ============================================================

Widget _buildCodePanel() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.black, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                color: Color(0xFFFF5F57),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.0),
            Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                color: Color(0xFFFEBC2E),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.0),
            Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                color: Color(0xFF28C840),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              'rendering/sliver_my_custom.dart',
              style: TextStyle(
                color: Colors.grey.shade300,
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// A simplified custom RenderSliver hit-test pattern.\n'
          'class RenderMyCustomSliver extends RenderSliver {\n'
          '  RenderBox? _child;\n'
          '\n'
          '  @override\n'
          '  bool hitTestChildren(\n'
          '    SliverHitTestResult result, {\n'
          '    required double mainAxisPosition,\n'
          '    required double crossAxisPosition,\n'
          '  }) {\n'
          '    final child = _child;\n'
          '    if (child == null) return false;\n'
          '    return result.addWithAxisOffset(\n'
          '      mainAxisPosition: mainAxisPosition,\n'
          '      crossAxisPosition: crossAxisPosition,\n'
          '      mainAxisOffset: 0.0,\n'
          '      crossAxisOffset: 0.0,\n'
          '      paintOffset: const Offset(0.0, 0.0),\n'
          '      hitTest: (BoxHitTestResult r, Offset transformed) {\n'
          '        return child.hitTest(r, position: transformed);\n'
          '      },\n'
          '    );\n'
          '  }\n'
          '}',
          Colors.lightBlueAccent,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// Wrapping pattern at the box -> sliver boundary.\n'
          'final SliverHitTestResult wrapped =\n'
          '    SliverHitTestResult.wrap(boxResult);\n'
          'final bool hit = sliver.hitTest(\n'
          '  wrapped,\n'
          '  mainAxisPosition: localMain,\n'
          '  crossAxisPosition: localCross,\n'
          ');\n'
          '// Entries pushed into wrapped also flow into boxResult.',
          Colors.greenAccent,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// Inspecting the path after the walk completes.\n'
          'for (final HitTestEntry entry in result.path) {\n'
          '  if (entry is SliverHitTestEntry) {\n'
          '    print("sliver entry at main/cross");\n'
          '  } else if (entry is BoxHitTestEntry) {\n'
          '    print("box entry at local position");\n'
          '  }\n'
          '}',
          Colors.amberAccent,
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade800),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

// ============================================================
// API NUMERICAL EXAMPLE PANEL
// ============================================================

Widget _buildAxisOffsetExamples() {
  final examples = <Map<String, double>>[
    <String, double>{
      'main': 120.0,
      'cross': 30.0,
      'offset': 50.0,
      'localMain': 70.0,
    },
    <String, double>{
      'main': 480.5,
      'cross': 100.0,
      'offset': 240.5,
      'localMain': 240.0,
    },
    <String, double>{
      'main': 32.0,
      'cross': 12.0,
      'offset': 0.0,
      'localMain': 32.0,
    },
    <String, double>{
      'main': 905.0,
      'cross': 200.0,
      'offset': 800.0,
      'localMain': 105.0,
    },
  ];

  final rows = <Widget>[];
  for (var i = 0; i < examples.length; i++) {
    final e = examples[i];
    final main = e['main']!;
    final cross = e['cross']!;
    final offset = e['offset']!;
    final local = e['localMain']!;
    rows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.cyan.shade50 : Colors.cyan.shade100,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.cyan.shade300),
        ),
        child: Row(
          children: [
            _buildAxisCell('parent.main',
                main.toStringAsFixed(1), Colors.indigo),
            _buildOpCell('-'),
            _buildAxisCell('child.offset',
                offset.toStringAsFixed(1), Colors.deepOrange),
            _buildOpCell('='),
            _buildAxisCell('child.main',
                local.toStringAsFixed(1), Colors.green),
            _buildOpCell('|'),
            _buildAxisCell('cross', cross.toStringAsFixed(1), Colors.purple),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.cyan.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calculate, color: Colors.cyan.shade800, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              'addWithAxisOffset numerical examples',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'How a parent sliver translates a hit position into its child frame.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.cyan.shade800,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 10.0),
        ...rows,
      ],
    ),
  );
}

Widget _buildAxisCell(String label, String value, MaterialColor color) {
  return Expanded(
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9.0,
            color: color.shade700,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 2.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: color.shade300),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color.shade900,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOpCell(String op) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      op,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.grey.shade700,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// ============================================================
// SEE-ALSO FOOTER
// ============================================================

Widget _buildSeeAlsoFooter() {
  final related = <Map<String, Object>>[
    <String, Object>{
      'title': 'HitTestResult',
      'role': 'Base class - generic accumulator for hit entries',
      'icon': Icons.inventory_2,
      'color': Colors.blueGrey,
    },
    <String, Object>{
      'title': 'BoxHitTestResult',
      'role': 'Box-coord sibling - used by RenderBox subtree',
      'icon': Icons.crop_square,
      'color': Colors.blue,
    },
    <String, Object>{
      'title': 'SliverHitTestEntry',
      'role': 'Recorded entry: target + main/cross position',
      'icon': Icons.bookmark_border,
      'color': Colors.purple,
    },
    <String, Object>{
      'title': 'RenderSliver.hitTest',
      'role': 'Entry point for sliver hit-walks',
      'icon': Icons.touch_app,
      'color': Colors.indigo,
    },
    <String, Object>{
      'title': 'RenderViewport',
      'role': 'Box-to-sliver bridge in scroll surfaces',
      'icon': Icons.crop_landscape,
      'color': Colors.teal,
    },
    <String, Object>{
      'title': 'CustomScrollView',
      'role': 'Public widget that hosts a list of slivers',
      'icon': Icons.smartphone,
      'color': Colors.deepOrange,
    },
  ];

  final cards = <Widget>[];
  for (var i = 0; i < related.length; i++) {
    final r = related[i];
    final color = r['color'] as MaterialColor;
    cards.add(
      Container(
        width: 220.0,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.shade50, color.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade300),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(r['icon'] as IconData,
                  color: color.shade900, size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r['title'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade900,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    r['role'] as String,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: color.shade800,
                      height: 1.3,
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

  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.grey.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.blueGrey.shade800, size: 22.0),
            SizedBox(width: 6.0),
            Text(
              'See also',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Related types in the rendering / gesture pipeline',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.blueGrey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: cards,
        ),
      ],
    ),
  );
}

// ============================================================
// DECORATIVE ICON BUTTON STRIP
// ============================================================

Widget _buildIconButtonStrip() {
  final icons = <IconData>[
    Icons.touch_app,
    Icons.gesture,
    Icons.swipe,
    Icons.swipe_up,
    Icons.swipe_down,
    Icons.tap_and_play,
    Icons.mouse,
    Icons.center_focus_weak,
  ];
  final buttons = <Widget>[];
  for (var i = 0; i < icons.length; i++) {
    buttons.add(
      IconButton(
        onPressed: null,
        icon: Icon(icons[i]),
        color: Colors.indigo.shade400,
        iconSize: 20.0,
      ),
    );
  }
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [Colors.indigo.shade50, Colors.white],
        center: Alignment.center,
        radius: 1.4,
      ),
      borderRadius: BorderRadius.circular(40.0),
      border: Border.all(color: Colors.indigo.shade100),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: buttons,
    ),
  );
}

// ============================================================
// FACT TILES STRIP
// ============================================================

Widget _buildFactStrip() {
  final facts = <Map<String, Object>>[
    <String, Object>{
      'icon': Icons.bolt,
      'value': 'O(depth)',
      'caption': 'walk cost',
      'color': Colors.amber,
    },
    <String, Object>{
      'icon': Icons.list,
      'value': 'List<HitTestEntry>',
      'caption': 'underlying path',
      'color': Colors.green,
    },
    <String, Object>{
      'icon': Icons.history_edu,
      'value': 'records-only',
      'caption': 'no rendering work',
      'color': Colors.blue,
    },
    <String, Object>{
      'icon': Icons.timer,
      'value': 'per-frame',
      'caption': 'rebuilt each pointer',
      'color': Colors.purple,
    },
  ];
  final tiles = <Widget>[];
  for (var i = 0; i < facts.length; i++) {
    final f = facts[i];
    final color = f['color'] as MaterialColor;
    tiles.add(
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.shade100, color.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: color.shade300),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.18),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(f['icon'] as IconData, color: color.shade800, size: 22.0),
              SizedBox(height: 4.0),
              Text(
                f['value'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                f['caption'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9.5,
                  color: color.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return Row(children: tiles);
}

// ============================================================
// RICHTEXT NARRATIVE PANEL
// ============================================================

Widget _buildRichNarrative() {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_stories,
                color: Colors.deepPurple.shade700, size: 22.0),
            SizedBox(width: 6.0),
            Text(
              'A short story of one tap',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.deepPurple.shade900,
              height: 1.5,
            ),
            children: <InlineSpan>[
              const TextSpan(
                text: 'A finger lands on the screen. The framework asks the ',
              ),
              TextSpan(
                text: 'RenderView',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: ' to walk the tree, building a ',
              ),
              TextSpan(
                text: 'BoxHitTestResult',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: ' as it goes. When the walk reaches a ',
              ),
              TextSpan(
                text: 'RenderViewport',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.teal.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: ', it spawns a ',
              ),
              TextSpan(
                text: 'SliverHitTestResult.wrap',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.purple.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: ' so child slivers can record entries in their own '
                    'main/cross frame. Eventually, a ',
              ),
              TextSpan(
                text: 'SliverToBoxAdapter',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.orange.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: ' inverts the bridge to walk one of its box-space '
                    'children, and a leaf RenderObject completes the trail. '
                    'Gesture recognizers later replay this exact path.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// LIFECYCLE PHASES PANEL
// ============================================================

Widget _buildLifecyclePhases() {
  final phases = <Map<String, Object>>[
    <String, Object>{
      'phase': 'Construct',
      'detail': 'A fresh SliverHitTestResult is created (or wrapped from a '
          'BoxHitTestResult) at the box->sliver boundary.',
      'color': Colors.lightBlue,
      'icon': Icons.create_new_folder,
    },
    <String, Object>{
      'phase': 'Walk down',
      'detail': 'Each sliver receives the result and may push transforms / '
          'axis offsets, then descend into children.',
      'color': Colors.lightGreen,
      'icon': Icons.south,
    },
    <String, Object>{
      'phase': 'Append',
      'detail': 'A leaf records a SliverHitTestEntry (or BoxHitTestEntry '
          'when re-entering box space). The path grows.',
      'color': Colors.amber,
      'icon': Icons.note_add,
    },
    <String, Object>{
      'phase': 'Walk up',
      'detail': 'Each level pops its transform / offset before returning to '
          'its caller, restoring the prior coordinate frame.',
      'color': Colors.deepOrange,
      'icon': Icons.north,
    },
    <String, Object>{
      'phase': 'Dispatch',
      'detail': 'Once back at the top, the gesture system replays path in '
          'order to deliver the pointer event.',
      'color': Colors.deepPurple,
      'icon': Icons.send,
    },
  ];

  final tiles = <Widget>[];
  for (var i = 0; i < phases.length; i++) {
    final p = phases[i];
    final color = p['color'] as MaterialColor;
    tiles.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.shade100, color.shade50],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: color.shade400,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(p['icon'] as IconData,
                  color: Colors.white, size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}. ${p['phase']}',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade900,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    p['detail'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: color.shade900,
                      height: 1.35,
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

  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Colors.indigo, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              'Lifecycle of a SliverHitTestResult',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ...tiles,
      ],
    ),
  );
}

// ============================================================
// MAIN BUILD
// ============================================================

dynamic build(BuildContext context) {
  print('SliverHitTestResult Deep Demo executing');
  print('=== building hero header ===');
  final hero = _buildHeroHeader();
  print('=== building icon button strip ===');
  final iconStrip = _buildIconButtonStrip();
  print('=== building fact strip ===');
  final facts = _buildFactStrip();
  print('=== building coordinate comparison ===');
  final coords = _buildCoordinateComparison();
  print('=== building live custom scroll view ===');
  final liveScroll = _buildLiveCustomScrollView();
  print('=== building hit-trail visualization ===');
  final trail = _buildHitTrailVisualization();
  print('=== building transition panel ===');
  final transition = _buildTransitionPanel();
  print('=== building axis-offset numerical examples ===');
  final axisExamples = _buildAxisOffsetExamples();
  print('=== building API matrix ===');
  final apiMatrix = _buildApiMatrix();
  print('=== building pitfalls ===');
  final pitfalls = _buildPitfallsPanel();
  print('=== building code panel ===');
  final code = _buildCodePanel();
  print('=== building lifecycle phases ===');
  final lifecycle = _buildLifecyclePhases();
  print('=== building rich narrative ===');
  final narrative = _buildRichNarrative();
  print('=== building see also footer ===');
  final footer = _buildSeeAlsoFooter();
  print('=== composing layout ===');

  final body = SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        hero,
        SizedBox(height: 16.0),
        iconStrip,
        SizedBox(height: 16.0),
        facts,
        _buildSectionTitle(
          '1',
          'Coordinate spaces compared',
          Icons.swap_horiz,
          Colors.teal,
        ),
        coords,
        _buildSectionTitle(
          '2',
          'Live CustomScrollView',
          Icons.smartphone,
          Colors.indigo,
        ),
        liveScroll,
        _buildSectionTitle(
          '3',
          'Hit-test trail order',
          Icons.timeline,
          Colors.green,
        ),
        trail,
        _buildSectionTitle(
          '4',
          'Sliver and Box transition',
          Icons.compare_arrows,
          Colors.deepOrange,
        ),
        transition,
        _buildSectionTitle(
          '5',
          'Numerical axis-offset translation',
          Icons.calculate,
          Colors.cyan,
        ),
        axisExamples,
        _buildSectionTitle(
          '6',
          'API surface',
          Icons.api,
          Colors.purple,
        ),
        apiMatrix,
        _buildSectionTitle(
          '7',
          'Pitfalls and edge cases',
          Icons.warning_amber,
          Colors.amber,
        ),
        pitfalls,
        _buildSectionTitle(
          '8',
          'Framework-style code patterns',
          Icons.code,
          Colors.blueGrey,
        ),
        code,
        _buildSectionTitle(
          '9',
          'Lifecycle of a hit walk',
          Icons.cyclone,
          Colors.lightBlue,
        ),
        lifecycle,
        _buildSectionTitle(
          '10',
          'A short narrative',
          Icons.auto_stories,
          Colors.deepPurple,
        ),
        narrative,
        _buildSectionTitle(
          '11',
          'See also',
          Icons.menu_book,
          Colors.blueGrey,
        ),
        footer,
        SizedBox(height: 24.0),
        Container(
          padding: EdgeInsets.all(12.0),
          alignment: Alignment.center,
          child: Text(
            'End of SliverHitTestResult deep demo',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  print('SliverHitTestResult Deep Demo completed successfully');

  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    appBar: AppBar(
      title: const Text('SliverHitTestResult'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
    ),
    body: body,
  );
}
