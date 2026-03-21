// D4rt test script: Tests FlexibleSpaceBarSettings from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FlexibleSpaceBarSettings Visual Demo ===');
  print('Demonstrating FlexibleSpaceBarSettings parameters and expansion states');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FlexibleSpaceBarSettings Demo'),
        backgroundColor: Color(0xFF004D40),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('FlexibleSpaceBarSettings Overview'),
            SizedBox(height: 8),
            _buildOverview(),
            SizedBox(height: 24),
            buildSectionHeader('Parameters Breakdown'),
            SizedBox(height: 8),
            _buildParametersBreakdown(),
            SizedBox(height: 24),
            buildSectionHeader('Expansion States Visualization'),
            SizedBox(height: 8),
            _buildExpansionStates(),
            SizedBox(height: 24),
            buildSectionHeader('ToolbarOpacity Demonstration'),
            SizedBox(height: 8),
            _buildToolbarOpacity(),
            SizedBox(height: 24),
            buildSectionHeader('MinExtent and MaxExtent'),
            SizedBox(height: 8),
            _buildMinMaxExtent(),
            SizedBox(height: 24),
            buildSectionHeader('CurrentExtent Progression'),
            SizedBox(height: 8),
            _buildCurrentExtentProgression(),
            SizedBox(height: 24),
            buildSectionHeader('SliverAppBar + FlexibleSpaceBar'),
            SizedBox(height: 8),
            _buildSliverAppBarIntegration(),
            SizedBox(height: 24),
            buildSectionHeader('Collapse Ratio Calculation'),
            SizedBox(height: 8),
            _buildCollapseRatioCalculation(),
            SizedBox(height: 24),
            buildSectionHeader('Visual State Machine'),
            SizedBox(height: 8),
            _buildVisualStateMachine(),
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
      color: Color(0xFF004D40),
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
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80CBC4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FlexibleSpaceBarSettings is an InheritedWidget that communicates '
            'the current SliverAppBar expansion state to FlexibleSpaceBar children.',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 8, left: 8, right: 8, height: 70,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF004D40),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SliverAppBar', style: TextStyle(color: Colors.white, fontSize: 11)),
                      SizedBox(height: 4),
                      Text('FlexibleSpaceBarSettings', style: TextStyle(color: Color(0xFF80CBC4), fontSize: 9)),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 82, left: 8, right: 8,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFE0F7FA),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFF80DEEA)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Provides to FlexibleSpaceBar:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                      Text('- toolbarOpacity, minExtent, maxExtent', style: TextStyle(fontSize: 9)),
                      Text('- currentExtent, isScrolledUnder', style: TextStyle(fontSize: 9)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('Type:', 'InheritedWidget passed by SliverAppBar'),
        buildInfoCard('Purpose:', 'Communicate collapse state to FlexibleSpaceBar'),
      ],
    ),
  );
}

Widget _buildParametersBreakdown() {
  print('Building parameters breakdown');
  List<Widget> items = [];

  List<String> paramNames = ['toolbarOpacity', 'minExtent', 'maxExtent', 'currentExtent', 'isScrolledUnder'];
  List<String> paramTypes = ['double', 'double', 'double', 'double', 'bool'];
  List<String> paramDescriptions = [
    'Opacity of the toolbar area (0.0 to 1.0). Controls title visibility during collapse.',
    'Minimum height when fully collapsed. Usually kToolbarHeight + status bar.',
    'Maximum height when fully expanded. Set by SliverAppBar.expandedHeight.',
    'Current height during scrolling. Changes as user scrolls.',
    'Whether content is scrolled under the AppBar. Affects surface tint.',
  ];
  List<Color> paramColors = [
    Color(0xFF1565C0),
    Color(0xFFD32F2F),
    Color(0xFF2E7D32),
    Color(0xFFFF6F00),
    Color(0xFF6A1B9A),
  ];

  int i = 0;
  for (; i < 5; i = i + 1) {
    String paramName = paramNames[i];
    String paramType = paramTypes[i];
    String paramDesc = paramDescriptions[i];
    Color paramColor = paramColors[i];

    print('  Parameter: $paramName ($paramType)');

    items.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: paramColor.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: paramColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(paramType, style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
              SizedBox(width: 8),
              Text(paramName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: paramColor)),
            ],
          ),
          SizedBox(height: 6),
          Text(paramDesc, style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
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
      children: items,
    ),
  );
}

Widget _buildExpansionStates() {
  print('Building expansion states visualization');
  List<Widget> states = [];

  List<String> stateLabels = ['Fully Expanded', 'Partially Collapsed', 'Mostly Collapsed', 'Fully Collapsed'];
  List<double> extentFractions = [1.0, 0.7, 0.3, 0.0];
  List<Color> stateColors = [Color(0xFF2E7D32), Color(0xFF1565C0), Color(0xFFFF6F00), Color(0xFFD32F2F)];

  int i = 0;
  for (; i < 4; i = i + 1) {
    String stateLabel = stateLabels[i];
    double fraction = extentFractions[i];
    Color stateColor = stateColors[i];
    double barHeight = 30 + (70 * fraction);
    double opacity = 1.0 - fraction;

    print('  State: $stateLabel, fraction: $fraction');

    states.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 80, height: 120,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0xFFBDBDBD)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0, left: 0, right: 0, height: barHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: stateColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text('${(barHeight).toStringAsFixed(0)}px',
                          style: TextStyle(color: Colors.white, fontSize: 8)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4, left: 4,
                  child: Text('Body', style: TextStyle(fontSize: 7, color: Color(0xFF9E9E9E))),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stateLabel, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: stateColor)),
                SizedBox(height: 4),
                Text('extent: ${(fraction * 100).toStringAsFixed(0)}% of max',
                    style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                Text('toolbarOpacity: ${opacity.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                SizedBox(height: 4),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: fraction > 0.01 ? fraction : 0.02,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: stateColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
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
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Visual representation of SliverAppBar at different scroll positions',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: states),
      ],
    ),
  );
}

Widget _buildToolbarOpacity() {
  print('Building toolbar opacity demonstration');
  List<Widget> items = [];

  List<double> opacities = [1.0, 0.8, 0.6, 0.4, 0.2, 0.0];

  int i = 0;
  for (; i < 6; i = i + 1) {
    double opacityVal = opacities[i];
    print('  Toolbar opacity: $opacityVal');

    items.add(Container(
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
            width: 120, height: 32,
            decoration: BoxDecoration(
              color: Color(0xFF004D40),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Opacity(
                opacity: opacityVal,
                child: Text('Toolbar Title', style: TextStyle(color: Colors.white, fontSize: 11)),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('opacity: ${opacityVal.toStringAsFixed(1)}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Text('${(opacityVal * 100).toStringAsFixed(0)}% visible',
                    style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
              ],
            ),
          ),
          Container(
            width: 40, height: 16,
            decoration: BoxDecoration(
              color: Color(0xFF004D40).withOpacity(opacityVal),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
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
        Text('toolbarOpacity controls the visibility of the toolbar title and actions',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('Range:', '0.0 (invisible) to 1.0 (fully visible)'),
        buildInfoCard('Transition:', 'Fades in as FlexibleSpaceBar collapses'),
      ],
    ),
  );
}

Widget _buildMinMaxExtent() {
  print('Building minExtent and maxExtent section');
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
        Text('minExtent and maxExtent define the collapse range',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 8, left: 16, right: 16,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF004D40).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFF004D40), width: 2),
                  ),
                  child: Center(child: Text('maxExtent: 200.0', style: TextStyle(fontSize: 12, color: Color(0xFF004D40)))),
                ),
              ),
              Positioned(
                top: 96, left: 16, right: 16,
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFFD32F2F).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFD32F2F), width: 2),
                  ),
                  child: Center(child: Text('minExtent: 80.0', style: TextStyle(fontSize: 11, color: Color(0xFFD32F2F)))),
                ),
              ),
              Positioned(
                top: 140, left: 16, right: 16,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Scroll range = maxExtent - minExtent',
                          style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFFE65100))),
                      Text('= 200 - 80 = 120px of collapse',
                          style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFFE65100))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('minExtent:', 'kToolbarHeight + statusBarHeight (typically 80)'),
        buildInfoCard('maxExtent:', 'SliverAppBar.expandedHeight value'),
        buildInfoCard('Collapse Range:', 'maxExtent - minExtent = scrollable distance'),
      ],
    ),
  );
}

Widget _buildCurrentExtentProgression() {
  print('Building currentExtent progression');
  List<Widget> items = [];

  double minExtent = 80.0;
  double maxExtent = 200.0;
  int steps = 8;

  int i = 0;
  for (; i < steps; i = i + 1) {
    double fraction = i / (steps - 1);
    double currentExtent = maxExtent - ((maxExtent - minExtent) * fraction);
    double collapseRatio = (maxExtent - currentExtent) / (maxExtent - minExtent);
    Color barColor = Color.lerp(Color(0xFF2E7D32), Color(0xFFD32F2F), fraction) ?? Color(0xFF2E7D32);

    print('  CurrentExtent step $i: ${currentExtent.toStringAsFixed(1)}');

    items.add(Container(
      margin: EdgeInsets.only(bottom: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text('${currentExtent.toStringAsFixed(0)}px',
                style: TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Container(
              height: 14,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(7),
              ),
              child: FractionallySizedBox(
                widthFactor: currentExtent / maxExtent,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 55,
            child: Text('${(collapseRatio * 100).toStringAsFixed(0)}% collapsed',
                style: TextStyle(fontSize: 8, color: Color(0xFF616161))),
          ),
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
        Text('currentExtent changes as the user scrolls: max -> min',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 4),
        Text('minExtent: ${minExtent.toStringAsFixed(0)}, maxExtent: ${maxExtent.toStringAsFixed(0)}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF004D40))),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('Collapse Ratio:', '(maxExtent - currentExtent) / (maxExtent - minExtent)'),
      ],
    ),
  );
}

Widget _buildSliverAppBarIntegration() {
  print('Building SliverAppBar integration diagram');
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
        Text('How SliverAppBar creates FlexibleSpaceBarSettings',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWidgetTreeRow(0, 'CustomScrollView', Color(0xFF37474F)),
              _buildWidgetTreeRow(1, 'SliverAppBar', Color(0xFF1565C0)),
              _buildWidgetTreeRow(2, 'FlexibleSpaceBarSettings', Color(0xFF00695C)),
              _buildWidgetTreeRow(3, 'FlexibleSpaceBar', Color(0xFFD32F2F)),
              _buildWidgetTreeRow(4, 'title: Text(...)', Color(0xFF757575)),
              _buildWidgetTreeRow(4, 'background: Image(...)', Color(0xFF757575)),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('SliverAppBar wraps its flexibleSpace with FlexibleSpaceBarSettings, '
                    'passing current scroll metrics so FlexibleSpaceBar can animate.\n'
                    'FlexibleSpaceBar reads these settings using '
                    'context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>().',
                    style: TextStyle(fontSize: 11, color: Color(0xFF2E7D32))),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('SliverAppBar:', 'Creates FlexibleSpaceBarSettings on each build'),
        buildInfoCard('FlexibleSpaceBar:', 'Reads settings to drive title parallax + opacity'),
      ],
    ),
  );
}

Widget _buildWidgetTreeRow(int indent, String label, Color color) {
  double leftPad = indent * 20.0;
  return Padding(
    padding: EdgeInsets.only(left: leftPad, bottom: 4),
    child: Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

Widget _buildCollapseRatioCalculation() {
  print('Building collapse ratio calculation');
  List<Widget> items = [];

  double minEx = 80.0;
  double maxEx = 200.0;
  List<double> currentExamples = [200.0, 170.0, 140.0, 110.0, 80.0];

  int i = 0;
  for (; i < 5; i = i + 1) {
    double current = currentExamples[i];
    double ratio = (maxEx - current) / (maxEx - minEx);
    double toolOpacity = ratio;

    print('  Collapse ratio for current=${current.toStringAsFixed(0)}: ${ratio.toStringAsFixed(2)}');

    items.add(Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text('cur: ${current.toStringAsFixed(0)}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ratio = (200 - ${current.toStringAsFixed(0)}) / (200 - 80) = ${ratio.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: Color(0xFF424242))),
                SizedBox(height: 2),
                Text('toolbarOpacity: ${toolOpacity.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 10, color: Color(0xFF004D40))),
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
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFE082)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('collapseRatio = (maxExtent - currentExtent) / (maxExtent - minExtent)',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFE65100))),
        SizedBox(height: 4),
        Text('minExtent: ${minEx.toStringAsFixed(0)}, maxExtent: ${maxEx.toStringAsFixed(0)}',
            style: TextStyle(fontSize: 12, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget _buildVisualStateMachine() {
  print('Building visual state machine');
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
        Text('State transitions as user scrolls down',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        _buildStateBox('EXPANDED', 'currentExtent == maxExtent', 'Background visible, title at bottom', Color(0xFF2E7D32)),
        SizedBox(height: 4),
        Center(child: Icon(Icons.arrow_downward, color: Color(0xFF9E9E9E), size: 20)),
        SizedBox(height: 4),
        _buildStateBox('SCROLLING', 'minExtent < currentExtent < maxExtent', 'Background fading, title moving up', Color(0xFF1565C0)),
        SizedBox(height: 4),
        Center(child: Icon(Icons.arrow_downward, color: Color(0xFF9E9E9E), size: 20)),
        SizedBox(height: 4),
        _buildStateBox('COLLAPSED', 'currentExtent == minExtent', 'Background hidden, title in toolbar', Color(0xFFD32F2F)),
        SizedBox(height: 12),
        buildInfoCard('Title Movement:', 'Parallax from bottom to toolbar position'),
        buildInfoCard('Background:', 'Opacity decreases from 1.0 to 0.0 during collapse'),
      ],
    ),
  );
}

Widget _buildStateBox(String stateName, String condition, String description, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 2),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(stateName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(condition, style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: color)),
              SizedBox(height: 2),
              Text(description, style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
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

  items.add(buildInfoCard('toolbarOpacity:', 'double - 0.0 to 1.0, toolbar content opacity'));
  items.add(buildInfoCard('minExtent:', 'double - minimum height (collapsed state)'));
  items.add(buildInfoCard('maxExtent:', 'double - maximum height (expanded state)'));
  items.add(buildInfoCard('currentExtent:', 'double - current height during scroll'));
  items.add(buildInfoCard('isScrolledUnder:', 'bool - content scrolled beneath AppBar'));
  items.add(buildInfoCard('hasLeading:', 'bool - whether leading widget is present'));
  items.add(SizedBox(height: 12));
  items.add(Text('Usage in FlexibleSpaceBar:',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF004D40))));
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
        Text('FlexibleSpaceBarSettings(', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF004D40))),
        Text('  toolbarOpacity: 0.8,', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  minExtent: 80.0,', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  maxExtent: 200.0,', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  currentExtent: 160.0,', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  child: FlexibleSpaceBar(...),', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text(')', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF004D40))),
      ],
    ),
  ));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80CBC4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    ),
  );
}
