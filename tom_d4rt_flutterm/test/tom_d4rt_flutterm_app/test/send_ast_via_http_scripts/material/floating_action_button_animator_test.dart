// ignore_for_file: avoid_print
// D4rt test script: Tests FloatingActionButtonAnimator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FloatingActionButtonAnimator Visual Demo ===');
  print('Demonstrating FAB animation concepts and scaling behavior');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FloatingActionButtonAnimator Demo'),
        backgroundColor: Color(0xFF4A148C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('FloatingActionButtonAnimator Overview'),
            SizedBox(height: 8),
            _buildOverview(),
            SizedBox(height: 24),
            buildSectionHeader('Scaling Animator Concept'),
            SizedBox(height: 8),
            _buildScalingAnimator(),
            SizedBox(height: 24),
            buildSectionHeader('Scale Animation Phases'),
            SizedBox(height: 8),
            _buildScaleAnimationPhases(),
            SizedBox(height: 24),
            buildSectionHeader('Animation Timeline'),
            SizedBox(height: 8),
            _buildAnimationTimeline(),
            SizedBox(height: 24),
            buildSectionHeader('Scale Factor Progression'),
            SizedBox(height: 8),
            _buildScaleFactorProgression(),
            SizedBox(height: 24),
            buildSectionHeader('FAB Appearance During Animation'),
            SizedBox(height: 8),
            _buildFabAppearanceDuringAnimation(),
            SizedBox(height: 24),
            buildSectionHeader('Rotation vs Scaling Comparison'),
            SizedBox(height: 8),
            _buildRotationVsScaling(),
            SizedBox(height: 24),
            buildSectionHeader('Animator With Location Changes'),
            SizedBox(height: 8),
            _buildAnimatorWithLocationChanges(),
            SizedBox(height: 24),
            buildSectionHeader('Animation Curve Visualization'),
            SizedBox(height: 8),
            _buildAnimationCurve(),
            SizedBox(height: 24),
            buildSectionHeader('Custom Animator Architecture'),
            SizedBox(height: 8),
            _buildCustomAnimatorArchitecture(),
            SizedBox(height: 24),
            buildSectionHeader('Properties Reference'),
            SizedBox(height: 8),
            _buildPropertiesReference(),
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
      color: Color(0xFF4A148C),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
    child: Row(children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      SizedBox(width: 8),
      Expanded(child: Text(value, style: TextStyle(fontSize: 14, color: Colors.grey.shade700))),
    ]),
  );
}

Widget _buildOverview() {
  print('Building overview section');
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
        Text('FloatingActionButtonAnimator controls how the FAB animates when it '
            'moves between FloatingActionButtonLocations. The default scaling '
            'animator shrinks the FAB to zero, then grows it at the new position.',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFF4A148C),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 24),
                  ),
                  SizedBox(height: 4),
                  Text('Position A', style: TextStyle(fontSize: 9)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_forward, color: Color(0xFF9E9E9E)),
                  Text('animate', style: TextStyle(fontSize: 9, color: Color(0xFF9E9E9E))),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12, height: 12,
                    decoration: BoxDecoration(
                      color: Color(0xFF4A148C).withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Scale=0', style: TextStyle(fontSize: 9)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_forward, color: Color(0xFF9E9E9E)),
                  Text('animate', style: TextStyle(fontSize: 9, color: Color(0xFF9E9E9E))),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFF4A148C),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.edit, color: Colors.white, size: 24),
                  ),
                  SizedBox(height: 4),
                  Text('Position B', style: TextStyle(fontSize: 9)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('Class:', 'FloatingActionButtonAnimator (abstract)'),
        buildInfoCard('Default:', 'FloatingActionButtonAnimator.scaling'),
        buildInfoCard('Usage:', 'Set via ThemeData.floatingActionButtonAnimator'),
      ],
    ),
  );
}

Widget _buildScalingAnimator() {
  print('Building scaling animator section');
  List<Widget> items = [];

  List<double> scales = [1.0, 0.75, 0.5, 0.25, 0.0, 0.25, 0.5, 0.75, 1.0];
  List<String> labels = ['Start', '', '', '', 'Mid', '', '', '', 'End'];

  int i = 0;
  for (; i < 9; i = i + 1) {
    double scale = scales[i];
    String label = labels[i];
    double size = 40 * scale;
    double minSize = 4.0;
    double displaySize = size > minSize ? size : minSize;

    items.add(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 44, height: 44,
          child: Center(
            child: Container(
              width: displaySize, height: displaySize,
              decoration: BoxDecoration(
                color: Color(0xFF4A148C).withOpacity(scale > 0.01 ? 1.0 : 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        SizedBox(height: 2),
        Text('${(scale * 100).toStringAsFixed(0)}%', style: TextStyle(fontSize: 8)),
        Text(label, style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: Color(0xFF4A148C))),
      ],
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB39DDB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The scaling animator shrinks the FAB to 0 at the old position, '
            'then grows it from 0 at the new position.',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items,
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('Phase 1:', 'Scale from 1.0 to 0.0 (shrink at old location)'),
        buildInfoCard('Phase 2:', 'Scale from 0.0 to 1.0 (grow at new location)'),
      ],
    ),
  );
}

Widget _buildScaleAnimationPhases() {
  print('Building scale animation phases');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Two distinct phases during a location transition:',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF1565C0), width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xFF1565C0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('Phase 1: Exit', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 8),
                  Text('0% -> 40% of total duration', style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                ],
              ),
              SizedBox(height: 8),
              Text('FAB scales down from full size to zero at the OLD position',
                  style: TextStyle(fontSize: 12, color: Color(0xFF424242))),
              SizedBox(height: 4),
              Row(
                children: [
                  _buildPhaseCircle(40, Color(0xFF1565C0)),
                  SizedBox(width: 4),
                  _buildPhaseCircle(30, Color(0xFF1565C0)),
                  SizedBox(width: 4),
                  _buildPhaseCircle(20, Color(0xFF1565C0)),
                  SizedBox(width: 4),
                  _buildPhaseCircle(10, Color(0xFF1565C0)),
                  SizedBox(width: 4),
                  _buildPhaseCircle(4, Color(0xFF1565C0)),
                  SizedBox(width: 8),
                  Text('disappears', style: TextStyle(fontSize: 10, color: Color(0xFF1565C0))),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF2E7D32), width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('Phase 2: Enter', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 8),
                  Text('60% -> 100% of total duration', style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                ],
              ),
              SizedBox(height: 8),
              Text('FAB scales up from zero to full size at the NEW position',
                  style: TextStyle(fontSize: 12, color: Color(0xFF424242))),
              SizedBox(height: 4),
              Row(
                children: [
                  _buildPhaseCircle(4, Color(0xFF2E7D32)),
                  SizedBox(width: 4),
                  _buildPhaseCircle(10, Color(0xFF2E7D32)),
                  SizedBox(width: 4),
                  _buildPhaseCircle(20, Color(0xFF2E7D32)),
                  SizedBox(width: 4),
                  _buildPhaseCircle(30, Color(0xFF2E7D32)),
                  SizedBox(width: 4),
                  _buildPhaseCircle(40, Color(0xFF2E7D32)),
                  SizedBox(width: 8),
                  Text('fully visible', style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32))),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('40%-60% gap = both FABs invisible (transition window)',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFE65100))),
        ),
      ],
    ),
  );
}

Widget _buildPhaseCircle(double size, Color color) {
  return Container(
    width: size, height: size,
    decoration: BoxDecoration(
      color: color.withOpacity(0.6),
      shape: BoxShape.circle,
    ),
  );
}

Widget _buildAnimationTimeline() {
  print('Building animation timeline');
  List<Widget> items = [];

  List<double> times = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  List<String> phases = ['Exit', 'Exit', 'Exit', 'Exit', 'Exit', 'Gap', 'Enter', 'Enter', 'Enter', 'Enter', 'Enter'];
  List<Color> phaseColors = [
    Color(0xFF1565C0), Color(0xFF1565C0), Color(0xFF1565C0), Color(0xFF1565C0), Color(0xFF1565C0),
    Color(0xFF757575),
    Color(0xFF2E7D32), Color(0xFF2E7D32), Color(0xFF2E7D32), Color(0xFF2E7D32), Color(0xFF2E7D32),
  ];

  int i = 0;
  for (; i < 11; i = i + 1) {
    double t = times[i];
    String phase = phases[i];
    Color phaseColor = phaseColors[i];

    print('  Timeline t=${t.toStringAsFixed(1)}: $phase');

    items.add(Container(
      margin: EdgeInsets.only(bottom: 2),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: phaseColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: phaseColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text('t=${t.toStringAsFixed(1)}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: phaseColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(phase, style: TextStyle(color: Colors.white, fontSize: 9)),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                widthFactor: t,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: phaseColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFA5D6A7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Animation timeline from t=0.0 to t=1.0 (200ms default)',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget _buildScaleFactorProgression() {
  print('Building scale factor progression');
  List<Widget> items = [];

  int steps = 10;
  int i = 0;
  for (; i <= steps; i = i + 1) {
    double t = i / steps;
    double scale = 0.0;
    String location = '';
    if (t <= 0.4) {
      scale = 1.0 - (t / 0.4);
      location = 'old position';
    } else if (t < 0.6) {
      scale = 0.0;
      location = 'hidden';
    } else {
      scale = (t - 0.6) / 0.4;
      location = 'new position';
    }

    double barWidth = scale;
    Color barColor = t <= 0.4 ? Color(0xFF1565C0) : (t < 0.6 ? Color(0xFF757575) : Color(0xFF2E7D32));

    items.add(Container(
      margin: EdgeInsets.only(bottom: 3),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text('${(t * 100).toStringAsFixed(0)}%',
                style: TextStyle(fontFamily: 'monospace', fontSize: 9, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 4),
          Expanded(
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(6),
              ),
              child: FractionallySizedBox(
                widthFactor: barWidth > 0.02 ? barWidth : 0.02,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 40,
            child: Text('${scale.toStringAsFixed(2)}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
          ),
          SizedBox(width: 4),
          SizedBox(
            width: 70,
            child: Text(location, style: TextStyle(fontSize: 8, color: Color(0xFF757575))),
          ),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFF48FB1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scale factor at each animation step (exit 0-40%, gap 40-60%, enter 60-100%)',
            style: TextStyle(fontSize: 12, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget _buildFabAppearanceDuringAnimation() {
  print('Building FAB appearance during animation');
  List<Widget> items = [];

  List<double> scaleValues = [1.0, 0.6, 0.2, 0.0, 0.0, 0.2, 0.6, 1.0];
  List<String> momentLabels = ['t=0.0', 't=0.15', 't=0.35', 't=0.4', 't=0.6', 't=0.65', 't=0.85', 't=1.0'];
  List<String> descriptions = [
    'Full size at old position',
    'Shrinking at old position',
    'Nearly gone at old position',
    'Hidden (exit complete)',
    'Hidden (enter starts)',
    'Growing at new position',
    'Expanding at new position',
    'Full size at new position',
  ];

  int i = 0;
  for (; i < 8; i = i + 1) {
    double s = scaleValues[i];
    String momentLabel = momentLabels[i];
    String desc = descriptions[i];
    double displaySize = 48.0 * s;
    double minDisp = 4.0;
    double effectiveSize = displaySize > minDisp ? displaySize : minDisp;
    double effectiveOpacity = s > 0.01 ? 1.0 : 0.15;

    print('  FAB at $momentLabel: scale=$s');

    items.add(Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 56, height: 56,
            child: Center(
              child: Container(
                width: effectiveSize, height: effectiveSize,
                decoration: BoxDecoration(
                  color: Color(0xFF4A148C).withOpacity(effectiveOpacity),
                  shape: BoxShape.circle,
                ),
                child: s > 0.4 ? Center(child: Icon(Icons.add, color: Colors.white, size: effectiveSize * 0.5)) : SizedBox(),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(momentLabel, style: TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
                Text('scale: ${s.toStringAsFixed(1)}', style: TextStyle(fontSize: 10, color: Color(0xFF616161))),
                Text(desc, style: TextStyle(fontSize: 10, color: Color(0xFF424242))),
              ],
            ),
          ),
        ],
      ),
    ));
  }

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
        Text('How the FAB looks at each moment during the transition',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget _buildRotationVsScaling() {
  print('Building rotation vs scaling comparison');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE0F7FA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80DEEA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The default animator uses scaling. Custom animators can use rotation.',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF4A148C), width: 2),
                ),
                child: Column(
                  children: [
                    Text('Scaling (Default)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF4A148C))),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPhaseCircle(36, Color(0xFF4A148C)),
                        _buildPhaseCircle(24, Color(0xFF4A148C)),
                        _buildPhaseCircle(12, Color(0xFF4A148C)),
                        _buildPhaseCircle(4, Color(0xFF4A148C)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Size changes\nNo rotation', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Color(0xFF616161))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFE65100), width: 2),
                ),
                child: Column(
                  children: [
                    Text('Rotation (Custom)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFFE65100))),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Transform.rotate(angle: 0.0, child: Icon(Icons.add, color: Color(0xFFE65100), size: 28)),
                        Transform.rotate(angle: 0.8, child: Icon(Icons.add, color: Color(0xFFE65100), size: 28)),
                        Transform.rotate(angle: 1.6, child: Icon(Icons.add, color: Color(0xFFE65100), size: 28)),
                        Transform.rotate(angle: 2.4, child: Icon(Icons.add, color: Color(0xFFE65100), size: 28)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Size stays same\nIcon rotates', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Color(0xFF616161))),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        buildInfoCard('Default:', 'FloatingActionButtonAnimator.scaling'),
        buildInfoCard('Custom:', 'Extend FloatingActionButtonAnimator, override getScaleAnimation/getRotationAnimation'),
      ],
    ),
  );
}

Widget _buildAnimatorWithLocationChanges() {
  print('Building animator with location changes');
  List<Widget> rows = [];

  List<String> fromLocs = ['endFloat', 'endFloat', 'centerFloat', 'endDocked', 'centerDocked'];
  List<String> toLocs = ['centerFloat', 'endDocked', 'centerDocked', 'endFloat', 'startFloat'];
  List<String> moveDescs = ['Horizontal (ends to center)', 'Vertical (float to dock)', 'Combined move', 'Vertical (dock to float)', 'Large horizontal move'];

  int i = 0;
  for (; i < 5; i = i + 1) {
    String fromLoc = fromLocs[i];
    String toLoc = toLocs[i];
    String moveDesc = moveDescs[i];

    print('  Location change: $fromLoc -> $toLoc');

    rows.add(Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Color(0xFF1565C0),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(fromLoc, style: TextStyle(color: Colors.white, fontSize: 9)),
          ),
          SizedBox(width: 4),
          Icon(Icons.arrow_forward, size: 14, color: Color(0xFF9E9E9E)),
          SizedBox(width: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(toLoc, style: TextStyle(color: Colors.white, fontSize: 9)),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(moveDesc, style: TextStyle(fontSize: 10, color: Color(0xFF616161)))),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFA5D6A7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Animator triggers on location changes (scale down + up)',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: rows),
        SizedBox(height: 8),
        buildInfoCard('Note:', 'Same animation plays regardless of distance between locations'),
      ],
    ),
  );
}

Widget _buildAnimationCurve() {
  print('Building animation curve visualization');
  List<Widget> items = [];

  int totalSteps = 16;
  int i = 0;
  for (; i < totalSteps; i = i + 1) {
    double t = i / (totalSteps - 1);
    double scale = 0.0;
    if (t <= 0.4) {
      scale = 1.0 - (t / 0.4);
    } else if (t < 0.6) {
      scale = 0.0;
    } else {
      scale = (t - 0.6) / 0.4;
    }

    double barHeight = 60.0 * scale;
    double minBar = 2.0;
    double effectiveBar = barHeight > minBar ? barHeight : minBar;
    Color col = t <= 0.4 ? Color(0xFF1565C0) : (t < 0.6 ? Color(0xFF757575) : Color(0xFF2E7D32));

    items.add(Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 10, height: effectiveBar,
            decoration: BoxDecoration(
              color: col,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 2),
          Text('${(t * 100).toStringAsFixed(0)}', style: TextStyle(fontSize: 6)),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFCC80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scale value over time (bar chart visualization)',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Container(
          height: 90,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: items,
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('t=0.0', style: TextStyle(fontSize: 9)),
            Text('Exit phase', style: TextStyle(fontSize: 9, color: Color(0xFF1565C0))),
            Text('Gap', style: TextStyle(fontSize: 9, color: Color(0xFF757575))),
            Text('Enter phase', style: TextStyle(fontSize: 9, color: Color(0xFF2E7D32))),
            Text('t=1.0', style: TextStyle(fontSize: 9)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCustomAnimatorArchitecture() {
  print('Building custom animator architecture');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Methods to override when creating a custom animator:',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        _buildMethodCard('getScaleAnimation', 'Animation<double>',
            'Controls the scale transform applied to the FAB', Color(0xFF1565C0)),
        SizedBox(height: 6),
        _buildMethodCard('getRotationAnimation', 'Animation<double>',
            'Controls the rotation transform applied to the FAB', Color(0xFF2E7D32)),
        SizedBox(height: 6),
        _buildMethodCard('getOffset', 'Offset',
            'Returns the position offset during animation', Color(0xFF4A148C)),
        SizedBox(height: 6),
        _buildMethodCard('getAnimationRestart', 'AnimationController',
            'Controls when the entrance animation replays', Color(0xFFE65100)),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ThemeData(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('  floatingActionButtonTheme:', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('    FloatingActionButtonThemeData(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('      // Animator set via ThemeData', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF757575))),
              Text('    ),', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text(')', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMethodCard(String name, String returnType, String description, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.05),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(returnType, style: TextStyle(color: Colors.white, fontSize: 8)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: color)),
              Text(description, style: TextStyle(fontSize: 10, color: Color(0xFF616161))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertiesReference() {
  print('Building properties reference');
  List<Widget> items = [];

  items.add(buildInfoCard('scaling:', 'Static constant - the default scaling animator'));
  items.add(buildInfoCard('getScaleAnimation:', 'Returns scale animation (0.0 to 1.0)'));
  items.add(buildInfoCard('getRotationAnimation:', 'Returns rotation animation (radians)'));
  items.add(buildInfoCard('getOffset:', 'Returns positional offset during transition'));
  items.add(buildInfoCard('getAnimationRestart:', 'Controls entrance animation replay'));
  items.add(SizedBox(height: 12));
  items.add(Text('Usage in Scaffold:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF4A148C))));
  items.add(SizedBox(height: 8));
  items.add(Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('// Default behavior (no custom animator needed):',
            style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF757575))),
        Text('Scaffold(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  floatingActionButton: FloatingActionButton(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('    onPressed: () {},', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('    child: Icon(Icons.add),', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  ),', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  floatingActionButtonLocation:', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('    FloatingActionButtonLocation.endFloat,', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  // Animator is from ThemeData', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF757575))),
        Text(')', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
      ],
    ),
  ));
  items.add(SizedBox(height: 8));
  items.add(buildInfoCard('Duration:', 'Default animation duration is 200ms'));
  items.add(buildInfoCard('Trigger:', 'Changing floatingActionButtonLocation triggers animation'));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    ),
  );
}
