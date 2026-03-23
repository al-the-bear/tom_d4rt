// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// RenderCustomSingleChildLayoutBox Deep Demo
// Tests CustomSingleChildLayout with various SingleChildLayoutDelegate subclasses
// Demonstrates getConstraintsForChild, getPositionForChild, getSize, shouldRelayout

// Delegate that centers the child within the parent
class CenteringDelegate extends SingleChildLayoutDelegate {
  Size getSize(BoxConstraints constraints) {
    print('[CenteringDelegate] getSize called with constraints: $constraints');
    return Size(constraints.maxWidth, constraints.maxHeight);
  }

  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    print(
      '[CenteringDelegate] getConstraintsForChild: allowing child up to half parent',
    );
    return BoxConstraints(
      maxWidth: constraints.maxWidth * 0.5,
      maxHeight: constraints.maxHeight * 0.5,
    );
  }

  Offset getPositionForChild(Size size, Size childSize) {
    double dx = (size.width - childSize.width) / 2.0;
    double dy = (size.height - childSize.height) / 2.0;
    print(
      '[CenteringDelegate] getPositionForChild: parent=$size child=$childSize offset=($dx, $dy)',
    );
    return Offset(dx, dy);
  }

  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    print('[CenteringDelegate] shouldRelayout called');
    return false;
  }
}

// Delegate that positions child at a percentage offset from top-left
class PercentageOffsetDelegate extends SingleChildLayoutDelegate {
  double xPercent;
  double yPercent;

  PercentageOffsetDelegate(this.xPercent, this.yPercent) {
    print(
      '[PercentageOffsetDelegate] created with xPercent=$xPercent yPercent=$yPercent',
    );
  }

  Size getSize(BoxConstraints constraints) {
    print('[PercentageOffsetDelegate] getSize: using max constraints');
    return Size(constraints.maxWidth, constraints.maxHeight);
  }

  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxW = constraints.maxWidth * 0.4;
    double maxH = constraints.maxHeight * 0.4;
    print(
      '[PercentageOffsetDelegate] getConstraintsForChild: maxW=$maxW maxH=$maxH',
    );
    return BoxConstraints(maxWidth: maxW, maxHeight: maxH);
  }

  Offset getPositionForChild(Size size, Size childSize) {
    double dx = (size.width - childSize.width) * xPercent;
    double dy = (size.height - childSize.height) * yPercent;
    print(
      '[PercentageOffsetDelegate] getPositionForChild: placing at ($dx, $dy)',
    );
    return Offset(dx, dy);
  }

  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    if (oldDelegate is PercentageOffsetDelegate) {
      bool result =
          oldDelegate.xPercent != xPercent || oldDelegate.yPercent != yPercent;
      print('[PercentageOffsetDelegate] shouldRelayout: $result');
      return result;
    }
    return true;
  }
}

// Delegate that constrains child to a fraction of parent size
class FractionalConstraintDelegate extends SingleChildLayoutDelegate {
  double widthFraction;
  double heightFraction;

  FractionalConstraintDelegate(this.widthFraction, this.heightFraction) {
    print(
      '[FractionalConstraintDelegate] created: widthFraction=$widthFraction heightFraction=$heightFraction',
    );
  }

  Size getSize(BoxConstraints constraints) {
    print('[FractionalConstraintDelegate] getSize: full parent');
    return Size(constraints.maxWidth, constraints.maxHeight);
  }

  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double w = constraints.maxWidth * widthFraction;
    double h = constraints.maxHeight * heightFraction;
    print(
      '[FractionalConstraintDelegate] getConstraintsForChild: tight($w, $h)',
    );
    return BoxConstraints.tightFor(width: w, height: h);
  }

  Offset getPositionForChild(Size size, Size childSize) {
    double dx = (size.width - childSize.width) / 2.0;
    double dy = (size.height - childSize.height) / 2.0;
    print(
      '[FractionalConstraintDelegate] getPositionForChild: centered at ($dx, $dy)',
    );
    return Offset(dx, dy);
  }

  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    if (oldDelegate is FractionalConstraintDelegate) {
      bool result =
          oldDelegate.widthFraction != widthFraction ||
          oldDelegate.heightFraction != heightFraction;
      print('[FractionalConstraintDelegate] shouldRelayout: $result');
      return result;
    }
    return true;
  }
}

// Delegate that positions child like a floating tooltip near an anchor point
class TooltipPositionDelegate extends SingleChildLayoutDelegate {
  double anchorX;
  double anchorY;
  double tooltipOffset;

  TooltipPositionDelegate(this.anchorX, this.anchorY, this.tooltipOffset) {
    print(
      '[TooltipPositionDelegate] created: anchor=($anchorX, $anchorY) offset=$tooltipOffset',
    );
  }

  Size getSize(BoxConstraints constraints) {
    print('[TooltipPositionDelegate] getSize: full parent area');
    return Size(constraints.maxWidth, constraints.maxHeight);
  }

  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxW = constraints.maxWidth * 0.6;
    double maxH = 80.0;
    print(
      '[TooltipPositionDelegate] getConstraintsForChild: maxW=$maxW maxH=$maxH',
    );
    return BoxConstraints(maxWidth: maxW, maxHeight: maxH);
  }

  Offset getPositionForChild(Size size, Size childSize) {
    double dx = anchorX - (childSize.width / 2.0);
    double dy = anchorY - childSize.height - tooltipOffset;
    // Clamp to parent bounds
    if (dx < 0) dx = 0;
    if (dx + childSize.width > size.width) dx = size.width - childSize.width;
    if (dy < 0) {
      dy = anchorY + tooltipOffset;
    }
    print(
      '[TooltipPositionDelegate] getPositionForChild: tooltip at ($dx, $dy)',
    );
    return Offset(dx, dy);
  }

  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    if (oldDelegate is TooltipPositionDelegate) {
      bool result =
          oldDelegate.anchorX != anchorX ||
          oldDelegate.anchorY != anchorY ||
          oldDelegate.tooltipOffset != tooltipOffset;
      print('[TooltipPositionDelegate] shouldRelayout: $result');
      return result;
    }
    return true;
  }
}

// Delegate that positions child at bottom-right corner with padding
class BottomRightDelegate extends SingleChildLayoutDelegate {
  double padding;

  BottomRightDelegate(this.padding) {
    print('[BottomRightDelegate] created with padding=$padding');
  }

  Size getSize(BoxConstraints constraints) {
    print('[BottomRightDelegate] getSize');
    return Size(constraints.maxWidth, constraints.maxHeight);
  }

  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxW = constraints.maxWidth * 0.3;
    double maxH = constraints.maxHeight * 0.3;
    print(
      '[BottomRightDelegate] getConstraintsForChild: maxW=$maxW maxH=$maxH',
    );
    return BoxConstraints(maxWidth: maxW, maxHeight: maxH);
  }

  Offset getPositionForChild(Size size, Size childSize) {
    double dx = size.width - childSize.width - padding;
    double dy = size.height - childSize.height - padding;
    print('[BottomRightDelegate] getPositionForChild: ($dx, $dy)');
    return Offset(dx, dy);
  }

  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    if (oldDelegate is BottomRightDelegate) {
      return oldDelegate.padding != padding;
    }
    return true;
  }
}

// Delegate that creates a diagonal positioning from top-left to bottom-right
class DiagonalDelegate extends SingleChildLayoutDelegate {
  double progress;

  DiagonalDelegate(this.progress) {
    print('[DiagonalDelegate] created with progress=$progress');
  }

  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, constraints.maxHeight);
  }

  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double side = constraints.maxWidth * 0.25;
    print('[DiagonalDelegate] getConstraintsForChild: square side=$side');
    return BoxConstraints.tightFor(width: side, height: side);
  }

  Offset getPositionForChild(Size size, Size childSize) {
    double maxDx = size.width - childSize.width;
    double maxDy = size.height - childSize.height;
    double dx = maxDx * progress;
    double dy = maxDy * progress;
    print(
      '[DiagonalDelegate] getPositionForChild: progress=$progress pos=($dx, $dy)',
    );
    return Offset(dx, dy);
  }

  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    if (oldDelegate is DiagonalDelegate) {
      return oldDelegate.progress != progress;
    }
    return true;
  }
}

Widget _buildHeader() {
  print(
    '[Header] Building gradient header for RenderCustomSingleChildLayoutBox demo',
  );
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF4A148C), Color(0xFF880E4F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 12.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RenderCustomSingleChildLayoutBox',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Deep demo of CustomSingleChildLayout and SingleChildLayoutDelegate',
          style: TextStyle(fontSize: 14.0, color: Color(0xCCFFFFFF)),
        ),
        SizedBox(height: 4.0),
        Text(
          'Covers: getConstraintsForChild, getPositionForChild, getSize, shouldRelayout',
          style: TextStyle(fontSize: 12.0, color: Color(0x99FFFFFF)),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, String subtitle) {
  print('[SectionTitle] Building: $title');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 20.0, bottom: 12.0),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF283593), Color(0xFF5C6BC0)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.0, color: Color(0xBBFFFFFF)),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String label, String description) {
  print('[InfoCard] $label');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
      ],
    ),
  );
}

Widget _buildCustomLayoutSection(
  String label,
  SingleChildLayoutDelegate delegate,
  Widget child,
  double height,
) {
  print('[CustomLayoutSection] Building section: $label with height=$height');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF283593),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(color: Color(0xFFFAFAFA)),
          child: CustomSingleChildLayout(delegate: delegate, child: child),
        ),
      ],
    ),
  );
}

Widget _buildSection1CenteringDelegate() {
  print('[Section1] CenteringDelegate - child centered in parent');
  Widget child = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF1565C0)]),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 6.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Text(
      'Centered Child\n(half parent size)',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  return _buildCustomLayoutSection(
    'CenteringDelegate - Child centered within parent, constrained to 50% size',
    CenteringDelegate(),
    child,
    200.0,
  );
}

Widget _buildSection2PercentageOffsets() {
  print('[Section2] PercentageOffsetDelegate - various offset positions');
  List<Map<String, dynamic>> configs = [
    {
      'x': 0.0,
      'y': 0.0,
      'label': 'Top-Left (0%, 0%)',
      'color': Color(0xFFEF5350),
    },
    {
      'x': 1.0,
      'y': 0.0,
      'label': 'Top-Right (100%, 0%)',
      'color': Color(0xFF66BB6A),
    },
    {
      'x': 0.5,
      'y': 0.5,
      'label': 'Center (50%, 50%)',
      'color': Color(0xFFAB47BC),
    },
    {
      'x': 0.25,
      'y': 0.75,
      'label': 'Low-Left (25%, 75%)',
      'color': Color(0xFFFF7043),
    },
  ];

  List<Widget> items = [];
  for (int i = 0; i < configs.length; i++) {
    Map<String, dynamic> cfg = configs[i];
    double xPct = cfg['x'];
    double yPct = cfg['y'];
    String label = cfg['label'];
    Color color = cfg['color'];
    print('[Section2] Creating percentage offset: $label');
    Widget child = Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    items.add(
      _buildCustomLayoutSection(
        'PercentageOffsetDelegate: $label',
        PercentageOffsetDelegate(xPct, yPct),
        child,
        150.0,
      ),
    );
  }
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
}

Widget _buildSection3FractionalConstraints() {
  print('[Section3] FractionalConstraintDelegate - constraining child sizes');
  List<Map<String, dynamic>> fractions = [
    {'w': 0.8, 'h': 0.8, 'label': '80% x 80%'},
    {'w': 0.5, 'h': 0.3, 'label': '50% x 30%'},
    {'w': 0.3, 'h': 0.9, 'label': '30% x 90%'},
  ];

  List<Widget> items = [];
  for (int i = 0; i < fractions.length; i++) {
    Map<String, dynamic> frac = fractions[i];
    double wf = frac['w'];
    double hf = frac['h'];
    String label = frac['label'];
    print('[Section3] FractionalConstraint: $label');
    Widget child = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF26A69A), Color(0xFF00695C)],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          'Fraction: $label',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    items.add(
      _buildCustomLayoutSection(
        'FractionalConstraintDelegate: child tight to $label of parent',
        FractionalConstraintDelegate(wf, hf),
        child,
        160.0,
      ),
    );
  }
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
}

Widget _buildSection4TooltipPositioning() {
  print(
    '[Section4] TooltipPositionDelegate - floating tooltip-like positioning',
  );
  Widget tooltipChild = Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Color(0xFF37474F),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x60000000),
          blurRadius: 8.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Tooltip Content',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Positioned above anchor point with clamping',
          style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 11.0),
        ),
      ],
    ),
  );

  List<Widget> tooltipExamples = [];

  // Tooltip near center
  print('[Section4] Tooltip anchored at center');
  tooltipExamples.add(
    _buildCustomLayoutSection(
      'TooltipPositionDelegate: anchor=(180, 150) offset=10',
      TooltipPositionDelegate(180.0, 150.0, 10.0),
      tooltipChild,
      200.0,
    ),
  );

  // Tooltip near top edge (should flip below)
  print('[Section4] Tooltip anchored near top edge');
  Widget topTooltip = Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Color(0xFFD32F2F),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      'Flipped Below (near top edge)',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  tooltipExamples.add(
    _buildCustomLayoutSection(
      'TooltipPositionDelegate: anchor=(150, 20) - flips below when no space above',
      TooltipPositionDelegate(150.0, 20.0, 8.0),
      topTooltip,
      180.0,
    ),
  );

  // Tooltip near right edge (should clamp)
  print('[Section4] Tooltip anchored near right edge');
  Widget rightTooltip = Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Color(0xFF7B1FA2),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      'Clamped to right edge',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  tooltipExamples.add(
    _buildCustomLayoutSection(
      'TooltipPositionDelegate: anchor=(350, 120) - clamped to bounds',
      TooltipPositionDelegate(350.0, 120.0, 10.0),
      rightTooltip,
      180.0,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: tooltipExamples,
  );
}

Widget _buildSection5BottomRight() {
  print(
    '[Section5] BottomRightDelegate - positions child at bottom-right with padding',
  );
  Widget child = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFF6F00),
      borderRadius: BorderRadius.circular(24.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Icon(Icons.add, color: Colors.white, size: 28.0),
  );

  return _buildCustomLayoutSection(
    'BottomRightDelegate: FAB-like positioning at bottom-right with 16px padding',
    BottomRightDelegate(16.0),
    child,
    200.0,
  );
}

Widget _buildSection6DiagonalLayout() {
  print('[Section6] DiagonalDelegate - child moves along diagonal');
  List<double> progressValues = [0.0, 0.33, 0.66, 1.0];
  List<Color> colors = [
    Color(0xFFF44336),
    Color(0xFFFF9800),
    Color(0xFF4CAF50),
    Color(0xFF2196F3),
  ];
  List<Widget> items = [];

  for (int i = 0; i < progressValues.length; i++) {
    double p = progressValues[i];
    Color c = colors[i];
    print('[Section6] Diagonal progress=$p');
    Widget child = Container(
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x30000000),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '${(p * 100).toInt()}%',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    items.add(
      _buildCustomLayoutSection(
        'DiagonalDelegate: progress=${p.toStringAsFixed(2)}',
        DiagonalDelegate(p),
        child,
        140.0,
      ),
    );
  }
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
}

Widget _buildSection7ComparisonWithAlign() {
  print('[Section7] Comparison with Align and FractionallySizedBox');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFFFCC80), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comparison: CustomSingleChildLayout vs Align vs FractionallySizedBox',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        SizedBox(height: 12.0),
        // Align example
        Text(
          '1. Align - Simple alignment only:',
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4.0),
        Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Align(
            alignment: Alignment(0.5, -0.5),
            child: Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFF1976D2),
              child: Text(
                'Align(0.5, -0.5)',
                style: TextStyle(color: Colors.white, fontSize: 11.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // FractionallySizedBox example
        Text(
          '2. FractionallySizedBox - Fraction sizing only:',
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4.0),
        Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.5,
            alignment: Alignment.center,
            child: Container(
              color: Color(0xFF388E3C),
              child: Center(
                child: Text(
                  '60% x 50%',
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // CustomSingleChildLayout example
        Text(
          '3. CustomSingleChildLayout - Full control:',
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4.0),
        Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: CustomSingleChildLayout(
            delegate: PercentageOffsetDelegate(0.7, 0.3),
            child: Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFF7B1FA2),
              child: Text(
                'Custom (70%, 30%)',
                style: TextStyle(color: Colors.white, fontSize: 11.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        _buildInfoCard(
          'Key Differences',
          'Align: only alignment, no constraint control.\n'
              'FractionallySizedBox: fraction sizing + alignment, no arbitrary positioning.\n'
              'CustomSingleChildLayout: full control over constraints, positioning, and parent size.',
        ),
      ],
    ),
  );
}

Widget _buildSection8ShouldRelayout() {
  print('[Section8] shouldRelayout behavior demonstration');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF9FA8DA), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'shouldRelayout Behavior',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF283593),
          ),
        ),
        SizedBox(height: 8.0),
        _buildInfoCard(
          'CenteringDelegate',
          'Always returns false - no mutable state, layout never changes.',
        ),
        _buildInfoCard(
          'PercentageOffsetDelegate',
          'Compares xPercent and yPercent - only relayouts when percentages change.',
        ),
        _buildInfoCard(
          'FractionalConstraintDelegate',
          'Compares widthFraction and heightFraction - relayouts when fractions differ.',
        ),
        _buildInfoCard(
          'TooltipPositionDelegate',
          'Compares anchorX, anchorY, and tooltipOffset - relayouts when anchor moves.',
        ),
        _buildInfoCard(
          'DiagonalDelegate',
          'Compares progress value - only relayouts when progress changes.',
        ),
        SizedBox(height: 8.0),
        Text(
          'Best practice: compare all mutable fields in shouldRelayout to avoid unnecessary layout passes.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF455A64),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _buildDelegateApiSummary() {
  print('[ApiSummary] Building delegate API method summary');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF80DEEA), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SingleChildLayoutDelegate API Summary',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006064),
          ),
        ),
        SizedBox(height: 12.0),
        _buildInfoCard(
          'getSize(BoxConstraints constraints) -> Size',
          'Determines the size of the parent. Defaults to constraints.biggest. '
              'Override to set a specific size for the layout area.',
        ),
        _buildInfoCard(
          'getConstraintsForChild(BoxConstraints constraints) -> BoxConstraints',
          'Returns the constraints to apply to the child. Can restrict, loosen, or tighten '
              'the constraints from the parent. Called before getPositionForChild.',
        ),
        _buildInfoCard(
          'getPositionForChild(Size size, Size childSize) -> Offset',
          'Returns the offset at which to paint the child. size = parent size from getSize, '
              'childSize = child size after applying getConstraintsForChild.',
        ),
        _buildInfoCard(
          'shouldRelayout(covariant oldDelegate) -> bool',
          'Returns true if layout needs to be recomputed. Compare mutable fields with '
              'the old delegate. Returning false avoids expensive layout recalculations.',
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('[build] Starting RenderCustomSingleChildLayoutBox deep demo');
  print('[build] CustomSingleChildLayout uses SingleChildLayoutDelegate');
  print(
    '[build] The render object RenderCustomSingleChildLayoutBox handles layout',
  );

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),

        _buildSectionTitle(
          '1. CenteringDelegate',
          'Centers the child and constrains to 50% of parent dimensions',
        ),
        _buildSection1CenteringDelegate(),

        _buildSectionTitle(
          '2. Percentage Offset Positioning',
          'PercentageOffsetDelegate places child at fractional positions',
        ),
        _buildSection2PercentageOffsets(),

        _buildSectionTitle(
          '3. Fractional Constraint Sizing',
          'FractionalConstraintDelegate constrains child to a fraction of parent',
        ),
        _buildSection3FractionalConstraints(),

        _buildSectionTitle(
          '4. Floating Tooltip Positioning',
          'TooltipPositionDelegate positions child like a tooltip near an anchor',
        ),
        _buildSection4TooltipPositioning(),

        _buildSectionTitle(
          '5. Bottom-Right FAB Positioning',
          'BottomRightDelegate places child at bottom-right with padding',
        ),
        _buildSection5BottomRight(),

        _buildSectionTitle(
          '6. Diagonal Progress Layout',
          'DiagonalDelegate moves child along top-left to bottom-right diagonal',
        ),
        _buildSection6DiagonalLayout(),

        _buildSectionTitle(
          '7. Comparison with Align and FractionallySizedBox',
          'When to use CustomSingleChildLayout vs simpler alternatives',
        ),
        _buildSection7ComparisonWithAlign(),

        _buildSectionTitle(
          '8. shouldRelayout Behavior',
          'How each delegate decides whether to trigger re-layout',
        ),
        _buildSection8ShouldRelayout(),

        _buildSectionTitle(
          '9. Delegate API Summary',
          'All methods of SingleChildLayoutDelegate and their roles',
        ),
        _buildDelegateApiSummary(),

        SizedBox(height: 24.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'End of RenderCustomSingleChildLayoutBox Deep Demo\n'
            '6 custom delegates demonstrated | 9 visual sections | Full delegate API coverage',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Color(0xFF546E7A)),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    ),
  );
}
