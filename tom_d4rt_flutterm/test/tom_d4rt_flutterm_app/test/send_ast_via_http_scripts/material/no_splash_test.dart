// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// NoSplash Demo - Ink factory that produces no splash effect
// D4rt compatible: no const, no assert(), no late, no ///

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'NoSplash Demo',
    theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
    home: NoSplashDemoPage(),
  );
}

class NoSplashDemoPage extends StatefulWidget {
  NoSplashDemoPage({Key? key}) : super(key: key);

  @override
  State<NoSplashDemoPage> createState() => _NoSplashDemoPageState();
}

class _NoSplashDemoPageState extends State<NoSplashDemoPage>
    with SingleTickerProviderStateMixin {
  int _selectedSection = 0;
  int _tapCount = 0;
  bool _showSplash = true;
  bool _highlightEnabled = true;
  Color _highlightColor = Colors.blue.withOpacity(0.2);
  List<String> _tapLog = [];

  List<String> _sections = [
    '1. Overview of NoSplash',
    '2. InkWell with NoSplash.splashFactory',
    '3. Comparison: InkSplash vs NoSplash',
    '4. Buttons using NoSplash',
    '5. ListTile with no splash',
    '6. NoSplash in Theme.splashFactory',
    '7. Card with tappable NoSplash',
    '8. Grid of buttons with/without splash',
    '9. NoSplash with highlight color only',
    '10. Interactive demonstration',
  ];

  void _logTap(String source) {
    setState(() {
      _tapCount++;
      _tapLog.add('[$_tapCount] Tapped: $source');
      if (_tapLog.length > 10) {
        _tapLog.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoSplash Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _tapCount = 0;
                _tapLog.clear();
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'NoSplash Sections',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap count: $_tapCount',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ..._buildDrawerItems(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: _buildCurrentSection(),
      ),
    );
  }

  List<Widget> _buildDrawerItems() {
    List<Widget> items = [];
    for (int i = 0; i < _sections.length; i++) {
      items.add(
        ListTile(
          leading: CircleAvatar(
            backgroundColor: _selectedSection == i ? Colors.blue : Colors.grey,
            child: Text('${i + 1}', style: TextStyle(color: Colors.white)),
          ),
          title: Text(_sections[i]),
          selected: _selectedSection == i,
          onTap: () {
            setState(() {
              _selectedSection = i;
            });
            Navigator.pop(context);
          },
        ),
      );
    }
    return items;
  }

  Widget _buildCurrentSection() {
    switch (_selectedSection) {
      case 0:
        return _buildOverviewSection();
      case 1:
        return _buildInkWellNoSplashSection();
      case 2:
        return _buildComparisonSection();
      case 3:
        return _buildButtonsSection();
      case 4:
        return _buildListTileSection();
      case 5:
        return _buildThemeSplashFactorySection();
      case 6:
        return _buildCardSection();
      case 7:
        return _buildGridSection();
      case 8:
        return _buildHighlightOnlySection();
      case 9:
        return _buildInteractiveSection();
      default:
        return _buildOverviewSection();
    }
  }

  // Section 1: Overview of NoSplash
  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('1. Overview of NoSplash'),
        _buildInfoCard(
          'What is NoSplash?',
          'NoSplash is a special InteractiveInkFeatureFactory that produces '
              'no visual splash effect when users tap on widgets. It is useful '
              'when you want touch feedback without the ripple animation.',
        ),
        SizedBox(height: 16),
        _buildInfoCard(
          'Key Properties',
          '• NoSplash.splashFactory - Factory that creates no splash\n'
              '• Can be used with InkWell, InkResponse, buttons\n'
              '• Can be set globally via ThemeData.splashFactory\n'
              '• Highlight effect can still be shown separately',
        ),
        SizedBox(height: 16),
        _buildInfoCard(
          'When to Use',
          '• Custom touch animations\n'
              '• Cleaner UI without ripple effects\n'
              '• Performance optimization on complex widgets\n'
              '• iOS-style interfaces without Material ripples',
        ),
        SizedBox(height: 24),
        Text(
          'Basic Example:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.blue.withOpacity(0.1),
            onTap: () => _logTap('Overview InkWell'),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.touch_app, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(child: Text('Tap me - uses NoSplash.splashFactory')),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildTapLogWidget(),
      ],
    );
  }

  // Section 2: InkWell with NoSplash.splashFactory
  Widget _buildInkWellNoSplashSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('2. InkWell with NoSplash.splashFactory'),
        Text(
          'InkWell can use NoSplash.splashFactory to disable the ripple effect:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        _buildLabeledExample(
          'No Splash InkWell',
          Material(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              borderRadius: BorderRadius.circular(8),
              onTap: () => _logTap('No Splash InkWell'),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'InkWell with NoSplash',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledExample(
          'With Highlight Color',
          Material(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.green.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              onTap: () => _logTap('Highlight InkWell'),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'NoSplash with Highlight',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledExample(
          'With Focus and Hover Colors',
          Material(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.purple.withOpacity(0.2),
              hoverColor: Colors.purple.withOpacity(0.1),
              focusColor: Colors.purple.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              onTap: () => _logTap('Focus/Hover InkWell'),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'NoSplash with Focus/Hover',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLabeledExample(
          'InkWell with Custom Shape',
          Material(
            color: Colors.orange.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              highlightColor: Colors.orange.withOpacity(0.3),
              onTap: () => _logTap('Custom Shape InkWell'),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Custom Border Radius',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildTapLogWidget(),
      ],
    );
  }

  // Section 3: Comparison - InkSplash vs NoSplash
  Widget _buildComparisonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('3. Comparison: InkSplash vs NoSplash'),
        Text(
          'Compare the visual difference between normal splash and no splash:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Default InkSplash',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Material(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => _logTap('Default Splash'),
                      child: Container(
                        height: 100,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.water_drop, color: Colors.blue),
                            SizedBox(height: 4),
                            Text('Tap me'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'NoSplash',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Material(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      borderRadius: BorderRadius.circular(12),
                      highlightColor: Colors.red.withOpacity(0.2),
                      onTap: () => _logTap('No Splash'),
                      child: Container(
                        height: 100,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.block, color: Colors.red),
                            SizedBox(height: 4),
                            Text('Tap me'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        _buildInfoCard(
          'Visual Differences',
          '• InkSplash: Shows ripple animation from tap point\n'
              '• NoSplash: No ripple, only highlight color change\n'
              '• Both respond to onTap callbacks\n'
              '• NoSplash can appear more subtle/clean',
        ),
        SizedBox(height: 16),
        Text(
          'Side-by-side list comparison:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _buildComparisonList(),
        SizedBox(height: 16),
        _buildTapLogWidget(),
      ],
    );
  }

  Widget _buildComparisonList() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () => _logTap('List Item - Normal'),
              child: ListTile(
                leading: Icon(Icons.waves, color: Colors.blue),
                title: Text('Normal Splash'),
                subtitle: Text('Default ripple effect'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          Divider(height: 1),
          Material(
            color: Colors.white,
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.grey.withOpacity(0.1),
              onTap: () => _logTap('List Item - NoSplash'),
              child: ListTile(
                leading: Icon(Icons.do_not_disturb, color: Colors.red),
                title: Text('No Splash'),
                subtitle: Text('Clean tap without ripple'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Section 4: Buttons using NoSplash
  Widget _buildButtonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('4. Buttons using NoSplash'),
        Text(
          'Apply NoSplash to various button types using ButtonStyle:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        _buildLabeledExample(
          'ElevatedButton with NoSplash',
          ElevatedButton(
            style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: WidgetStateProperty.all(Colors.blue),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            onPressed: () => _logTap('ElevatedButton NoSplash'),
            child: Text('Elevated - No Splash'),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledExample(
          'TextButton with NoSplash',
          TextButton(
            style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.blue.withOpacity(0.1);
                }
                return null;
              }),
            ),
            onPressed: () => _logTap('TextButton NoSplash'),
            child: Text('Text Button - No Splash'),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledExample(
          'OutlinedButton with NoSplash',
          OutlinedButton(
            style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              side: WidgetStateProperty.all(
                BorderSide(color: Colors.green, width: 2),
              ),
            ),
            onPressed: () => _logTap('OutlinedButton NoSplash'),
            child: Text('Outlined - No Splash'),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledExample(
          'IconButton with NoSplash',
          Material(
            color: Colors.transparent,
            child: IconButton(
              style: ButtonStyle(splashFactory: NoSplash.splashFactory),
              icon: Icon(Icons.favorite, color: Colors.red, size: 32),
              onPressed: () => _logTap('IconButton NoSplash'),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabeledExample(
          'FilledButton with NoSplash',
          FilledButton(
            style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: WidgetStateProperty.all(Colors.purple),
            ),
            onPressed: () => _logTap('FilledButton NoSplash'),
            child: Text('Filled - No Splash'),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Button Row Comparison:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => _logTap('Normal Elevated'),
              child: Text('Normal'),
            ),
            ElevatedButton(
              style: ButtonStyle(splashFactory: NoSplash.splashFactory),
              onPressed: () => _logTap('NoSplash Elevated'),
              child: Text('NoSplash'),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildTapLogWidget(),
      ],
    );
  }

  // Section 5: ListTile with no splash
  Widget _buildListTileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('5. ListTile with no splash'),
        Text(
          'ListTiles can disable splash using Theme or InkWell wrapper:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Using Theme.splashFactory:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Theme(
          data: Theme.of(
            context,
          ).copyWith(splashFactory: NoSplash.splashFactory),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text('User Profile'),
                  subtitle: Text('Themed with NoSplash'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _logTap('ListTile Profile'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.settings, color: Colors.white),
                  ),
                  title: Text('Settings'),
                  subtitle: Text('Also themed with NoSplash'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _logTap('ListTile Settings'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.notifications, color: Colors.white),
                  ),
                  title: Text('Notifications'),
                  subtitle: Text('No ripple effect'),
                  trailing: Switch(value: true, onChanged: (v) {}),
                  onTap: () => _logTap('ListTile Notifications'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Using InkWell wrapper:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Card(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.purple.withOpacity(0.1),
              onTap: () => _logTap('Wrapped ListTile'),
              child: ListTile(
                leading: Icon(Icons.star, color: Colors.amber),
                title: Text('Favorites'),
                subtitle: Text('Wrapped in InkWell with NoSplash'),
                trailing: Badge(label: Text('5'), child: Icon(Icons.bookmark)),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildTapLogWidget(),
      ],
    );
  }

  // Section 6: NoSplash in Theme.splashFactory
  Widget _buildThemeSplashFactorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('6. NoSplash in Theme.splashFactory'),
        Text(
          'Set NoSplash globally using ThemeData.splashFactory:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        _buildInfoCard(
          'Global Configuration',
          'ThemeData(\n'
              '  splashFactory: NoSplash.splashFactory,\n'
              '  // All descendants inherit NoSplash\n'
              ')',
        ),
        SizedBox(height: 16),
        Text(
          'Themed Container Demo:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Theme(
          data: ThemeData(
            splashFactory: NoSplash.splashFactory,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
          ),
          child: Builder(
            builder: (themedContext) {
              return Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'All widgets below inherit NoSplash:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade800,
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _logTap('Themed ElevatedButton'),
                      child: Text('Elevated Button'),
                    ),
                    SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () => _logTap('Themed OutlinedButton'),
                      child: Text('Outlined Button'),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () => _logTap('Themed TextButton'),
                      child: Text('Text Button'),
                    ),
                    SizedBox(height: 8),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => _logTap('Themed InkWell'),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('InkWell in themed container'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Selectively Override:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Theme(
          data: ThemeData(splashFactory: NoSplash.splashFactory),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _logTap('NoSplash (themed)'),
                  child: Text('NoSplash'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(splashFactory: InkRipple.splashFactory),
                  onPressed: () => _logTap('Splash (overridden)'),
                  child: Text('With Splash'),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildTapLogWidget(),
      ],
    );
  }

  // Section 7: Card with tappable NoSplash content
  Widget _buildCardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('7. Card with tappable NoSplash'),
        Text(
          'Cards with NoSplash for clean touch interactions:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        _buildTappableCard(
          'Simple Card',
          'A card with NoSplash touch handling',
          Icons.touch_app,
          Colors.blue,
        ),
        SizedBox(height: 12),
        _buildTappableCard(
          'Settings Card',
          'Configure application preferences',
          Icons.settings,
          Colors.grey,
        ),
        SizedBox(height: 12),
        _buildTappableCard(
          'Analytics Card',
          'View your usage statistics',
          Icons.analytics,
          Colors.purple,
        ),
        SizedBox(height: 12),
        _buildExpandableCard(),
        SizedBox(height: 16),
        _buildTapLogWidget(),
      ],
    );
  }

  Widget _buildTappableCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          onTap: () => _logTap('Card: $title'),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableCard() {
    return Card(
      elevation: 2,
      child: Theme(
        data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
        child: ExpansionTile(
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.expand_more, color: Colors.amber.shade700),
          ),
          title: Text('Expandable Card'),
          subtitle: Text('Tap to expand - no splash'),
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'This ExpansionTile uses NoSplash through the Theme. '
                'The expand/collapse animation works normally, but there '
                'is no ripple effect on tap.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section 8: Grid of buttons with/without splash
  Widget _buildGridSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('8. Grid of buttons with/without splash'),
        Text(
          'Compare splash vs no splash in a grid layout:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'With Normal Splash:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _buildButtonGrid(withSplash: true),
        SizedBox(height: 24),
        Text('With NoSplash:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _buildButtonGrid(withSplash: false),
        SizedBox(height: 16),
        _buildTapLogWidget(),
      ],
    );
  }

  Widget _buildButtonGrid({required bool withSplash}) {
    List<Map<String, dynamic>> items = [
      {'icon': Icons.home, 'label': 'Home', 'color': Colors.blue},
      {'icon': Icons.search, 'label': 'Search', 'color': Colors.green},
      {'icon': Icons.favorite, 'label': 'Favorites', 'color': Colors.red},
      {'icon': Icons.settings, 'label': 'Settings', 'color': Colors.grey},
      {'icon': Icons.person, 'label': 'Profile', 'color': Colors.purple},
      {'icon': Icons.notifications, 'label': 'Alerts', 'color': Colors.orange},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return Material(
          color: (item['color'] as Color).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            splashFactory: withSplash
                ? InkRipple.splashFactory
                : NoSplash.splashFactory,
            highlightColor: (item['color'] as Color).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            onTap: () => _logTap(
              '${withSplash ? "Splash" : "NoSplash"} ${item['label']}',
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color,
                  size: 32,
                ),
                SizedBox(height: 8),
                Text(
                  item['label'] as String,
                  style: TextStyle(fontSize: 12, color: item['color'] as Color),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Section 9: NoSplash with highlight color only
  Widget _buildHighlightOnlySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('9. NoSplash with highlight color only'),
        Text(
          'Using NoSplash with various highlight colors for subtle feedback:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        _buildHighlightDemo('Blue Highlight', Colors.blue),
        SizedBox(height: 12),
        _buildHighlightDemo('Green Highlight', Colors.green),
        SizedBox(height: 12),
        _buildHighlightDemo('Orange Highlight', Colors.orange),
        SizedBox(height: 12),
        _buildHighlightDemo('Purple Highlight', Colors.purple),
        SizedBox(height: 24),
        Text(
          'Highlight Opacity Variations:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildOpacityDemo('10%', 0.1)),
            SizedBox(width: 8),
            Expanded(child: _buildOpacityDemo('20%', 0.2)),
            SizedBox(width: 8),
            Expanded(child: _buildOpacityDemo('30%', 0.3)),
            SizedBox(width: 8),
            Expanded(child: _buildOpacityDemo('40%', 0.4)),
          ],
        ),
        SizedBox(height: 16),
        _buildTapLogWidget(),
      ],
    );
  }

  Widget _buildHighlightDemo(String label, Color color) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        onTap: () => _logTap(label),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              SizedBox(width: 12),
              Text(label, style: TextStyle(fontSize: 16)),
              Spacer(),
              Text('Tap to see', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOpacityDemo(String label, double opacity) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.blue.withOpacity(opacity),
        borderRadius: BorderRadius.circular(8),
        onTap: () => _logTap('Opacity $label'),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24),
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  // Section 10: Interactive demonstration
  Widget _buildInteractiveSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('10. Interactive demonstration'),
        Text(
          'Toggle settings to see NoSplash behavior in action:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Enable Splash'),
                  subtitle: Text(
                    _showSplash ? 'Normal ripple effect' : 'NoSplash active',
                  ),
                  value: _showSplash,
                  onChanged: (value) {
                    setState(() {
                      _showSplash = value;
                    });
                  },
                ),
                Divider(),
                SwitchListTile(
                  title: Text('Enable Highlight'),
                  subtitle: Text(
                    _highlightEnabled
                        ? 'Highlight color visible'
                        : 'No highlight',
                  ),
                  value: _highlightEnabled,
                  onChanged: (value) {
                    setState(() {
                      _highlightEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Text('Color Picker:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildColorOption(Colors.blue),
            _buildColorOption(Colors.red),
            _buildColorOption(Colors.green),
            _buildColorOption(Colors.purple),
            _buildColorOption(Colors.orange),
            _buildColorOption(Colors.teal),
          ],
        ),
        SizedBox(height: 24),
        Text('Test Area:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              splashFactory: _showSplash
                  ? InkRipple.splashFactory
                  : NoSplash.splashFactory,
              highlightColor: _highlightEnabled
                  ? _highlightColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              onTap: () => _logTap('Test Area'),
              child: Container(
                height: 150,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _showSplash ? Icons.water_drop : Icons.block,
                      size: 48,
                      color: _showSplash ? Colors.blue : Colors.red,
                    ),
                    SizedBox(height: 12),
                    Text(
                      _showSplash ? 'Splash Enabled' : 'NoSplash Active',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tap anywhere in this area',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Interactive Button Row:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  splashFactory: _showSplash
                      ? InkRipple.splashFactory
                      : NoSplash.splashFactory,
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                icon: Icon(Icons.add),
                label: Text('Add'),
                onPressed: () => _logTap('Add Button'),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  splashFactory: _showSplash
                      ? InkRipple.splashFactory
                      : NoSplash.splashFactory,
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                onPressed: () => _logTap('Delete Button'),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildTapLogWidget(),
        SizedBox(height: 16),
        Center(
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.grey),
            ),
            icon: Icon(Icons.refresh),
            label: Text('Reset All'),
            onPressed: () {
              setState(() {
                _tapCount = 0;
                _tapLog.clear();
                _showSplash = true;
                _highlightEnabled = true;
                _highlightColor = Colors.blue.withOpacity(0.2);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildColorOption(Color color) {
    bool isSelected = _highlightColor.value == color.withOpacity(0.2).value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _highlightColor = color.withOpacity(0.2);
        });
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: isSelected ? Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }

  // Helper widgets
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 3,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade900,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledExample(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildTapLogWidget() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history, size: 18, color: Colors.grey.shade600),
              SizedBox(width: 8),
              Text(
                'Tap Log (Total: $_tapCount)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          if (_tapLog.isEmpty)
            Text(
              'No taps yet...',
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _tapLog
                  .map(
                    (log) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        log,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
