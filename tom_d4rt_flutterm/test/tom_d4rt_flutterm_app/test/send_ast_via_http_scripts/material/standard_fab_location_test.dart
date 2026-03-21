// D4rt test script: Tests StandardFabLocation - FAB position in Scaffold
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== StandardFabLocation Visual Demo ===');
  print('Demonstrating FAB positioning in Scaffold using StandardFabLocation');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('StandardFabLocation Demo'),
        backgroundColor: Color(0xFF6200EA),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('StandardFabLocation Overview'),
            SizedBox(height: 8),
            _buildOverview(),
            SizedBox(height: 24),
            buildSectionHeader('endFloat Position'),
            SizedBox(height: 8),
            _buildEndFloatSection(),
            SizedBox(height: 24),
            buildSectionHeader('centerFloat Position'),
            SizedBox(height: 8),
            _buildCenterFloatSection(),
            SizedBox(height: 24),
            buildSectionHeader('endDocked Position'),
            SizedBox(height: 8),
            _buildEndDockedSection(),
            SizedBox(height: 24),
            buildSectionHeader('centerDocked Position'),
            SizedBox(height: 8),
            _buildCenterDockedSection(),
            SizedBox(height: 24),
            buildSectionHeader('startFloat Position'),
            SizedBox(height: 8),
            _buildStartFloatSection(),
            SizedBox(height: 24),
            buildSectionHeader('startDocked Position'),
            SizedBox(height: 8),
            _buildStartDockedSection(),
            SizedBox(height: 24),
            buildSectionHeader('miniStartTop Position'),
            SizedBox(height: 8),
            _buildMiniStartTopSection(),
            SizedBox(height: 24),
            buildSectionHeader('endTop Position'),
            SizedBox(height: 8),
            _buildEndTopSection(),
            SizedBox(height: 24),
            buildSectionHeader('Custom Positioning with FloatingActionButtonLocation'),
            SizedBox(height: 8),
            _buildCustomPositioningSection(),
            SizedBox(height: 24),
            buildSectionHeader('All Standard Locations Grid'),
            SizedBox(height: 8),
            _buildAllLocationsGrid(),
            SizedBox(height: 24),
            buildSectionHeader('Scaffold Integration Patterns'),
            SizedBox(height: 8),
            _buildScaffoldIntegrationPatterns(),
            SizedBox(height: 24),
            buildSectionHeader('Comparison Table'),
            SizedBox(height: 8),
            _buildComparisonTable(),
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
      color: Color(0xFF6200EA),
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

Widget buildCodeSnippet(String code) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8),
    ),
    child: SelectableText(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFF80CBC4),
      ),
    ),
  );
}

Widget _buildOverview() {
  print('Building StandardFabLocation overview section');
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
        Text(
          'StandardFabLocation is the concrete implementation '
          'of FloatingActionButtonLocation that provides predefined positions for the FAB '
          'within a Scaffold. It handles positioning math, respects safe areas, '
          'and integrates with BottomAppBar notch calculations.',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 36,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF6200EA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                  ),
                  child: Center(
                    child: Text('AppBar', style: TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 40,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                  ),
                  child: Center(
                    child: Text('BottomNavigationBar', style: TextStyle(fontSize: 10)),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 4,
                right: 4,
                bottom: 44,
                child: Container(
                  color: Color(0xFFFAFAFA),
                  child: Center(
                    child: Text('Body', style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
                  ),
                ),
              ),
              _buildFabMarker(right: 16, bottom: 56, label: 'endFloat', color: Color(0xFFF44336)),
              _buildFabMarker(right: 16, bottom: 20, label: 'endDocked', color: Color(0xFFE91E63)),
              _buildFabMarker(left: 16, bottom: 56, label: 'startFloat', color: Color(0xFF2196F3)),
              _buildFabMarker(left: 16, top: 48, label: 'startTop', color: Color(0xFF00BCD4)),
              _buildFabMarker(right: 16, top: 48, label: 'endTop', color: Color(0xFF009688)),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Class:', 'StandardFabLocation extends FloatingActionButtonLocation'),
        buildInfoCard('Purpose:', 'Define where the FloatingActionButton appears in the Scaffold'),
        buildInfoCard('Integration:', 'Used via Scaffold.floatingActionButtonLocation property'),
        buildInfoCard('SafeArea:', 'Automatically accounts for system UI insets'),
      ],
    ),
  );
}

Widget _buildFabMarker({double? left, double? right, double? top, double? bottom, String label = '', Color color = Colors.red}) {
  return Positioned(
    left: left,
    right: right,
    top: top,
    bottom: bottom,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: color.withAlpha(80), blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Center(child: Icon(Icons.add, color: Colors.white, size: 12)),
        ),
        SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 7, color: color, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _buildEndFloatSection() {
  print('Building endFloat section');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFEF9A9A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FloatingActionButtonLocation.endFloat is the default and most common '
          'FAB position. It places the FAB at the bottom trailing edge of the Scaffold, '
          'floating above any BottomNavigationBar or BottomAppBar.',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildMiniScaffold('endFloat', Alignment.bottomRight, Color(0xFFD32F2F), true)),
            SizedBox(width: 8),
            Expanded(child: _buildMiniScaffold('endFloat LTR', Alignment.bottomRight, Color(0xFFC62828), true)),
            SizedBox(width: 8),
            Expanded(child: _buildMiniScaffold('endFloat RTL', Alignment.bottomLeft, Color(0xFFB71C1C), true)),
          ],
        ),
        SizedBox(height: 12),
        buildCodeSnippet(
          'Scaffold(\n'
          '  floatingActionButton: FloatingActionButton(\n'
          '    onPressed: () {},\n'
          '    child: Icon(Icons.add),\n'
          '  ),\n'
          '  floatingActionButtonLocation:\n'
          '    FloatingActionButtonLocation.endFloat,\n'
          ')',
        ),
        SizedBox(height: 8),
        buildInfoCard('Position:', 'Bottom-right (LTR) or bottom-left (RTL)'),
        buildInfoCard('Y Offset:', '16dp above bottom bar'),
        buildInfoCard('X Offset:', '16dp from edge'),
        buildInfoCard('Use Case:', 'Primary action in most Material apps'),
      ],
    ),
  );
}

Widget _buildCenterFloatSection() {
  print('Building centerFloat section');
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
        Text(
          'FloatingActionButtonLocation.centerFloat positions the FAB at the '
          'horizontal center of the Scaffold, floating above the bottom bar. '
          'This creates a prominent central action point.',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildMiniScaffold('centerFloat', Alignment.bottomCenter, Color(0xFF2E7D32), true)),
            SizedBox(width: 8),
            Expanded(child: _buildMiniScaffold('With NavBar', Alignment.bottomCenter, Color(0xFF1B5E20), true)),
            SizedBox(width: 8),
            Expanded(child: _buildMiniScaffold('No Bottom', Alignment.bottomCenter, Color(0xFF388E3C), false)),
          ],
        ),
        SizedBox(height: 12),
        buildCodeSnippet(
          'Scaffold(\n'
          '  floatingActionButton: FloatingActionButton(\n'
          '    onPressed: () {},\n'
          '    child: Icon(Icons.edit),\n'
          '  ),\n'
          '  floatingActionButtonLocation:\n'
          '    FloatingActionButtonLocation.centerFloat,\n'
          '  bottomNavigationBar: BottomNavigationBar(...),\n'
          ')',
        ),
        SizedBox(height: 8),
        buildInfoCard('Position:', 'Bottom-center horizontally'),
        buildInfoCard('Prominence:', 'Maximum visual prominence'),
        buildInfoCard('Best For:', 'Single primary action patterns'),
        buildInfoCard('Contrast:', 'Symmetrical layout emphasis'),
      ],
    ),
  );
}

Widget _buildEndDockedSection() {
  print('Building endDocked section');
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
        Text(
          'FloatingActionButtonLocation.endDocked embeds the FAB into the '
          'BottomAppBar at the trailing edge. This requires a BottomAppBar with '
          'a notch shape configured to accommodate the FAB.',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildDockedScaffold('endDocked', Alignment.bottomRight, Color(0xFFE65100))),
            SizedBox(width: 8),
            Expanded(child: _buildDockedScaffold('With Notch', Alignment.bottomRight, Color(0xFFF57C00))),
          ],
        ),
        SizedBox(height: 12),
        buildCodeSnippet(
          'Scaffold(\n'
          '  floatingActionButton: FloatingActionButton(\n'
          '    onPressed: () {},\n'
          '    child: Icon(Icons.navigation),\n'
          '  ),\n'
          '  floatingActionButtonLocation:\n'
          '    FloatingActionButtonLocation.endDocked,\n'
          '  bottomNavigationBar: BottomAppBar(\n'
          '    shape: CircularNotchedRectangle(),\n'
          '    child: Row(children: [/*icons*/]),\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 8),
        buildInfoCard('Position:', 'Trailing edge, embedded in BottomAppBar'),
        buildInfoCard('Notch:', 'Requires CircularNotchedRectangle or AutomaticNotchedShape'),
        buildInfoCard('Y Position:', 'Straddles the top edge of BottomAppBar'),
        buildInfoCard('Integration:', 'Natural part of bottom navigation'),
      ],
    ),
  );
}

Widget _buildCenterDockedSection() {
  print('Building centerDocked section');
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
          'FloatingActionButtonLocation.centerDocked centers the FAB '
          'horizontally within the BottomAppBar notch. This is one of the most '
          'visually distinctive FAB placements in Material Design.',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildDockedScaffold('centerDocked', Alignment.bottomCenter, Color(0xFF7B1FA2))),
            SizedBox(width: 8),
            Expanded(child: _buildDockedScaffold('Notched', Alignment.bottomCenter, Color(0xFF6A1B9A))),
          ],
        ),
        SizedBox(height: 12),
        buildCodeSnippet(
          'Scaffold(\n'
          '  floatingActionButton: FloatingActionButton(\n'
          '    onPressed: () {},\n'
          '    child: Icon(Icons.add),\n'
          '  ),\n'
          '  floatingActionButtonLocation:\n'
          '    FloatingActionButtonLocation.centerDocked,\n'
          '  bottomNavigationBar: BottomAppBar(\n'
          '    shape: CircularNotchedRectangle(),\n'
          '    notchMargin: 8.0,\n'
          '    child: Row(\n'
          '      mainAxisAlignment: MainAxisAlignment.spaceAround,\n'
          '      children: [/*icons*/],\n'
          '    ),\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 8),
        buildInfoCard('Position:', 'Horizontally centered in BottomAppBar'),
        buildInfoCard('Visual Effect:', 'Most prominent docked position'),
        buildInfoCard('notchMargin:', 'Controls gap between FAB and notch'),
        buildInfoCard('Common Use:', 'Primary navigation action with bottom bar'),
      ],
    ),
  );
}

Widget _buildStartFloatSection() {
  print('Building startFloat section');
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
          'FloatingActionButtonLocation.startFloat places the FAB at the '
          'leading edge (left in LTR, right in RTL), floating above the bottom bar. '
          'This is less common but useful for specific UI patterns.',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildMiniScaffold('startFloat', Alignment.bottomLeft, Color(0xFF1565C0), true)),
            SizedBox(width: 8),
            Expanded(child: _buildMiniScaffold('LTR Layout', Alignment.bottomLeft, Color(0xFF0D47A1), true)),
            SizedBox(width: 8),
            Expanded(child: _buildMiniScaffold('RTL Layout', Alignment.bottomRight, Color(0xFF1976D2), true)),
          ],
        ),
        SizedBox(height: 12),
        buildCodeSnippet(
          'Scaffold(\n'
          '  floatingActionButton: FloatingActionButton(\n'
          '    onPressed: () {},\n'
          '    child: Icon(Icons.menu),\n'
          '  ),\n'
          '  floatingActionButtonLocation:\n'
          '    FloatingActionButtonLocation.startFloat,\n'
          ')',
        ),
        SizedBox(height: 8),
        buildInfoCard('Position:', 'Leading edge (left in LTR)'),
        buildInfoCard('RTL Support:', 'Automatically mirrors to right side'),
        buildInfoCard('Use Case:', 'Secondary actions or left-oriented layouts'),
        buildInfoCard('Spacing:', 'Standard 16dp from edge and bottom'),
      ],
    ),
  );
}

Widget _buildStartDockedSection() {
  print('Building startDocked section');
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
        Text(
          'FloatingActionButtonLocation.startDocked embeds the FAB at the '
          'leading edge of the BottomAppBar, creating a notched appearance '
          'on the left side (in LTR layouts).',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildDockedScaffold('startDocked', Alignment.bottomLeft, Color(0xFF00838F))),
            SizedBox(width: 8),
            Expanded(child: _buildDockedScaffold('Leading', Alignment.bottomLeft, Color(0xFF006064))),
          ],
        ),
        SizedBox(height: 12),
        buildCodeSnippet(
          'Scaffold(\n'
          '  floatingActionButton: FloatingActionButton(\n'
          '    onPressed: () {},\n'
          '    child: Icon(Icons.arrow_back),\n'
          '  ),\n'
          '  floatingActionButtonLocation:\n'
          '    FloatingActionButtonLocation.startDocked,\n'
          '  bottomNavigationBar: BottomAppBar(\n'
          '    shape: CircularNotchedRectangle(),\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 8),
        buildInfoCard('Position:', 'Leading edge, docked in BottomAppBar'),
        buildInfoCard('Notch Location:', 'Left side in LTR, right in RTL'),
        buildInfoCard('Less Common:', 'Primarily for specialized layouts'),
        buildInfoCard('Mirroring:', 'Respects text directionality'),
      ],
    ),
  );
}

Widget _buildMiniStartTopSection() {
  print('Building miniStartTop section');
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
        Text(
          'FloatingActionButtonLocation.miniStartTop positions a mini-sized FAB '
          'at the top leading corner, below the AppBar. This is designed for '
          'compact secondary actions at the top of the screen.',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTopScaffold('miniStartTop', Alignment.topLeft, Color(0xFFC2185B), true)),
            SizedBox(width: 8),
            Expanded(child: _buildTopScaffold('Mini FAB', Alignment.topLeft, Color(0xFFAD1457), true)),
          ],
        ),
        SizedBox(height: 12),
        buildCodeSnippet(
          'Scaffold(\n'
          '  floatingActionButton: FloatingActionButton.small(\n'
          '    onPressed: () {},\n'
          '    child: Icon(Icons.filter_list),\n'
          '  ),\n'
          '  floatingActionButtonLocation:\n'
          '    FloatingActionButtonLocation.miniStartTop,\n'
          '  appBar: AppBar(title: Text("Title")),\n'
          ')',
        ),
        SizedBox(height: 8),
        buildInfoCard('Position:', 'Top-left, below AppBar'),
        buildInfoCard('Size Hint:', 'Optimized for mini FAB (40dp)'),
        buildInfoCard('Offset:', 'Adjusted for mini FAB dimensions'),
        buildInfoCard('Use Case:', 'Filters, quick settings, secondary actions'),
      ],
    ),
  );
}

Widget _buildEndTopSection() {
  print('Building endTop section');
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
        Text(
          'FloatingActionButtonLocation.endTop positions the FAB at the top '
          'trailing corner, just below the AppBar. This is useful for prominent '
          'actions that need to be at the top of the content area.',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTopScaffold('endTop', Alignment.topRight, Color(0xFF3F51B5), false)),
            SizedBox(width: 8),
            Expanded(child: _buildTopScaffold('With AppBar', Alignment.topRight, Color(0xFF303F9F), false)),
          ],
        ),
        SizedBox(height: 12),
        buildCodeSnippet(
          'Scaffold(\n'
          '  floatingActionButton: FloatingActionButton(\n'
          '    onPressed: () {},\n'
          '    child: Icon(Icons.share),\n'
          '  ),\n'
          '  floatingActionButtonLocation:\n'
          '    FloatingActionButtonLocation.endTop,\n'
          '  appBar: AppBar(\n'
          '    title: Text("Title"),\n'
          '  ),\n'
          '  body: ListView(...),\n'
          ')',
        ),
        SizedBox(height: 8),
        buildInfoCard('Position:', 'Top-right, below AppBar'),
        buildInfoCard('Visibility:', 'Accessible without scrolling'),
        buildInfoCard('Pattern:', 'Share, settings, or persistent actions'),
        buildInfoCard('Clearance:', '16dp from AppBar bottom and edge'),
      ],
    ),
  );
}

Widget _buildCustomPositioningSection() {
  print('Building custom positioning section');
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
        Text(
          'Custom FAB positioning can be achieved by extending '
          'FloatingActionButtonLocation and overriding the getOffset method. '
          'This allows for precise pixel-perfect positioning.',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12),
        _buildCustomPositionDiagram(),
        SizedBox(height: 12),
        buildCodeSnippet(
          'class CustomFabLocation extends FloatingActionButtonLocation {\n'
          '  \n'
          '  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {\n'
          '    double fabX = scaffoldGeometry.scaffoldSize.width / 2 - 28;\n'
          '    double fabY = scaffoldGeometry.scaffoldSize.height * 0.3;\n'
          '    return Offset(fabX, fabY);\n'
          '  }\n'
          '\n'
          '  String toString() => "CustomFabLocation";\n'
          '}\n'
          '\n'
          '// Usage\n'
          'Scaffold(\n'
          '  floatingActionButton: FloatingActionButton(\n'
          '    onPressed: () {},\n'
          '  ),\n'
          '  floatingActionButtonLocation: CustomFabLocation(),\n'
          ')',
        ),
        SizedBox(height: 12),
        buildInfoCard('ScaffoldPrelayoutGeometry:', 'Provides scaffold dimensions and constraints'),
        buildInfoCard('getOffset:', 'Returns the top-left corner position of the FAB'),
        buildInfoCard('Considerations:', 'Account for FAB size (56dp default) and safe areas'),
        SizedBox(height: 12),
        Text('Available geometry properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _buildGeometryPropertyList(),
      ],
    ),
  );
}

Widget _buildCustomPositionDiagram() {
  return Container(
    height: 140,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPainter(),
          ),
        ),
        Center(
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Color(0xFFFF9800),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.white, size: 18),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Color(0xFF424242),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('Custom Position', style: TextStyle(color: Colors.white, fontSize: 9)),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Color(0xFF757575),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('getOffset(geometry)', style: TextStyle(color: Colors.white, fontSize: 8)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildGeometryPropertyList() {
  List<Map<String, String>> properties = [
    {'name': 'scaffoldSize', 'desc': 'Total size of the scaffold'},
    {'name': 'bottomSheetSize', 'desc': 'Size of the bottom sheet if present'},
    {'name': 'contentBottom', 'desc': 'Y position of content area bottom'},
    {'name': 'contentTop', 'desc': 'Y position below AppBar'},
    {'name': 'floatingActionButtonSize', 'desc': 'Size of the FAB'},
    {'name': 'minInsets', 'desc': 'Minimum padding for safe areas'},
    {'name': 'snackBarSize', 'desc': 'Size of SnackBar if showing'},
  ];

  List<Widget> rows = [];
  int idx = 0;
  for (idx = 0; idx < properties.length; idx = idx + 1) {
    Map<String, String> prop = properties[idx];
    rows.add(
      Container(
        margin: EdgeInsets.only(bottom: 4),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Container(
              width: 140,
              child: Text(
                prop['name'] ?? '',
                style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFE65100)),
              ),
            ),
            Expanded(
              child: Text(
                prop['desc'] ?? '',
                style: TextStyle(fontSize: 11, color: Color(0xFF424242)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Column(children: rows);
}

Widget _buildAllLocationsGrid() {
  print('Building all locations grid');
  List<Map<String, dynamic>> locations = [
    {'name': 'endFloat', 'align': Alignment.bottomRight, 'color': Color(0xFFF44336), 'docked': false},
    {'name': 'centerFloat', 'align': Alignment.bottomCenter, 'color': Color(0xFF4CAF50), 'docked': false},
    {'name': 'startFloat', 'align': Alignment.bottomLeft, 'color': Color(0xFF2196F3), 'docked': false},
    {'name': 'endDocked', 'align': Alignment.bottomRight, 'color': Color(0xFFFF9800), 'docked': true},
    {'name': 'centerDocked', 'align': Alignment.bottomCenter, 'color': Color(0xFF9C27B0), 'docked': true},
    {'name': 'startDocked', 'align': Alignment.bottomLeft, 'color': Color(0xFF00BCD4), 'docked': true},
    {'name': 'endTop', 'align': Alignment.topRight, 'color': Color(0xFF795548), 'docked': false},
    {'name': 'centerTop', 'align': Alignment.topCenter, 'color': Color(0xFF607D8B), 'docked': false},
    {'name': 'startTop', 'align': Alignment.topLeft, 'color': Color(0xFF009688), 'docked': false},
    {'name': 'miniStartTop', 'align': Alignment.topLeft, 'color': Color(0xFFE91E63), 'docked': false},
    {'name': 'miniEndTop', 'align': Alignment.topRight, 'color': Color(0xFF673AB7), 'docked': false},
    {'name': 'miniCenterTop', 'align': Alignment.topCenter, 'color': Color(0xFF3F51B5), 'docked': false},
  ];

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.85,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            Map<String, dynamic> loc = locations[index];
            String name = loc['name'] as String;
            Alignment align = loc['align'] as Alignment;
            Color color = loc['color'] as Color;
            bool docked = loc['docked'] as bool;
            return _buildGridLocationItem(name, align, color, docked);
          },
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem('Float', Color(0xFF4CAF50)),
            SizedBox(width: 16),
            _buildLegendItem('Docked', Color(0xFFFF9800)),
            SizedBox(width: 16),
            _buildLegendItem('Top', Color(0xFF9E9E9E)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildGridLocationItem(String name, Alignment alignment, Color color, bool docked) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 14,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF546E7A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
          ),
        ),
        if (docked)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 12,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
          ),
        Positioned.fill(
          child: Align(
            alignment: alignment,
            child: Padding(
              padding: EdgeInsets.all(docked ? 6 : 4),
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: docked ? 14 : 2,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              name,
              style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold, color: color),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLegendItem(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
    ],
  );
}

Widget _buildScaffoldIntegrationPatterns() {
  print('Building scaffold integration patterns');
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
        Text(
          'StandardFabLocation integrates with various Scaffold components to provide '
          'consistent FAB positioning across different app configurations.',
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
        SizedBox(height: 16),
        _buildPatternRow('BottomNavigationBar', 'Float above the NavBar', Color(0xFF2E7D32)),
        SizedBox(height: 8),
        _buildPatternRow('BottomAppBar', 'Dock into notch or float', Color(0xFF1B5E20)),
        SizedBox(height: 8),
        _buildPatternRow('BottomSheet', 'Adjust for persistent sheet', Color(0xFF388E3C)),
        SizedBox(height: 8),
        _buildPatternRow('SnackBar', 'Move up when SnackBar shows', Color(0xFF43A047)),
        SizedBox(height: 8),
        _buildPatternRow('Keyboard', 'Adjust for soft keyboard', Color(0xFF4CAF50)),
        SizedBox(height: 16),
        buildCodeSnippet(
          '// Full integration example\n'
          'Scaffold(\n'
          '  appBar: AppBar(...),\n'
          '  body: ListView(...),\n'
          '  floatingActionButton: FloatingActionButton(...),\n'
          '  floatingActionButtonLocation:\n'
          '    FloatingActionButtonLocation.centerDocked,\n'
          '  bottomNavigationBar: BottomAppBar(\n'
          '    shape: CircularNotchedRectangle(),\n'
          '    notchMargin: 8,\n'
          '    child: ...\n'
          '  ),\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _buildPatternRow(String title, String description, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
              Text(description, style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonTable() {
  print('Building comparison table');
  List<Map<String, String>> comparisons = [
    {'location': 'endFloat', 'x': 'Trailing', 'y': 'Above bottom', 'use': 'Default primary action'},
    {'location': 'centerFloat', 'x': 'Center', 'y': 'Above bottom', 'use': 'Prominent central action'},
    {'location': 'startFloat', 'x': 'Leading', 'y': 'Above bottom', 'use': 'Left-side actions'},
    {'location': 'endDocked', 'x': 'Trailing', 'y': 'In BottomAppBar', 'use': 'Integrated with nav'},
    {'location': 'centerDocked', 'x': 'Center', 'y': 'In BottomAppBar', 'use': 'Central nav action'},
    {'location': 'startDocked', 'x': 'Leading', 'y': 'In BottomAppBar', 'use': 'Left-docked action'},
    {'location': 'endTop', 'x': 'Trailing', 'y': 'Below AppBar', 'use': 'Top persistent action'},
    {'location': 'miniStartTop', 'x': 'Leading', 'y': 'Below AppBar', 'use': 'Mini filter/settings'},
  ];

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
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Color(0xFF424242),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text('Location', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
              Expanded(flex: 1, child: Text('X Pos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
              Expanded(flex: 1, child: Text('Y Pos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
              Expanded(flex: 2, child: Text('Use Case', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
            ],
          ),
        ),
        SizedBox(height: 4),
        Column(
          children: _buildTableRows(comparisons),
        ),
      ],
    ),
  );
}

List<Widget> _buildTableRows(List<Map<String, String>> data) {
  List<Widget> rows = [];
  int i = 0;
  for (i = 0; i < data.length; i = i + 1) {
    Map<String, String> row = data[i];
    Color bgColor = i % 2 == 0 ? Color(0xFFFFFFFF) : Color(0xFFFAFAFA);
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                row['location'] ?? '',
                style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF6200EA)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(row['x'] ?? '', style: TextStyle(fontSize: 10)),
            ),
            Expanded(
              flex: 1,
              child: Text(row['y'] ?? '', style: TextStyle(fontSize: 10)),
            ),
            Expanded(
              flex: 2,
              child: Text(row['use'] ?? '', style: TextStyle(fontSize: 10)),
            ),
          ],
        ),
      ),
    );
  }
  return rows;
}

Widget _buildMiniScaffold(String label, Alignment fabAlign, Color fabColor, bool hasBottomBar) {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF546E7A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
          ),
        ),
        if (hasBottomBar)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 14,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
          ),
        Positioned.fill(
          top: 18,
          bottom: hasBottomBar ? 16 : 2,
          left: 2,
          right: 2,
          child: Align(
            alignment: fabAlign,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: fabColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 10),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: hasBottomBar ? 16 : 2,
          left: 0,
          right: 0,
          child: Center(
            child: Text(label, style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: fabColor)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDockedScaffold(String label, Alignment fabAlign, Color fabColor) {
  double leftOffset = 0;
  double rightOffset = 0;

  if (fabAlign == Alignment.bottomLeft) {
    leftOffset = 8;
  } else if (fabAlign == Alignment.bottomRight) {
    rightOffset = 8;
  }

  return Container(
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF546E7A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 18,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: fabAlign == Alignment.bottomLeft ? leftOffset : null,
          right: fabAlign == Alignment.bottomRight ? rightOffset : null,
          child: Align(
            alignment: fabAlign,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: fabColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 12),
            ),
          ),
        ),
        if (fabAlign == Alignment.bottomCenter)
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: fabColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 12),
              ),
            ),
          ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Center(
            child: Text(label, style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: fabColor)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTopScaffold(String label, Alignment fabAlign, Color fabColor, bool isMini) {
  double fabSize = isMini ? 14.0 : 18.0;

  return Container(
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 20,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF546E7A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
          ),
        ),
        Positioned(
          top: 24,
          left: fabAlign == Alignment.topLeft ? 6 : null,
          right: fabAlign == Alignment.topRight ? 6 : null,
          child: fabAlign == Alignment.topCenter
              ? Container()
              : Container(
                  width: fabSize,
                  height: fabSize,
                  decoration: BoxDecoration(
                    color: fabColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: fabSize * 0.6),
                ),
        ),
        if (fabAlign == Alignment.topCenter)
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: fabSize,
                height: fabSize,
                decoration: BoxDecoration(
                  color: fabColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: fabSize * 0.6),
              ),
            ),
          ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Center(
            child: Text(label, style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: fabColor)),
          ),
        ),
      ],
    ),
  );
}

class _GridPainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    Paint gridPaint = Paint()
      ..color = Color(0xFFE0E0E0)
      ..strokeWidth = 0.5;

    double spacing = 20.0;

    double x = 0;
    for (x = 0; x <= size.width; x = x + spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    double y = 0;
    for (y = 0; y <= size.height; y = y + spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
