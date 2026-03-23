// ignore_for_file: avoid_print
// D4rt test script: Tests PredictiveBackFullscreenPageTransitionsBuilder from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade700,
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

Widget buildInfoCard(String label, String content) {
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
            content,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildSubsectionTitle(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 12, bottom: 8),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget buildPredictiveBackOverviewSection() {
  print('Building predictive back overview section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.deepPurple.shade200, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.swipe_left_alt,
                color: Colors.deepPurple.shade700,
                size: 32,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Predictive Back Gesture',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Android 14+ Navigation Feature',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is Predictive Back?',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Predictive back is a gesture navigation feature introduced in Android 14 (API level 34) '
                'that allows users to preview the destination before completing a back navigation. '
                'As the user swipes from the edge of the screen, they see a preview of where they will '
                'go if they complete the gesture.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.5),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        buildSubsectionTitle('Key Concepts', Icons.lightbulb, Colors.amber.shade700),
        _buildConceptCard(
          'Gesture Preview',
          'Users see a visual preview of the previous screen as they swipe back',
          Icons.preview,
          Colors.green,
        ),
        _buildConceptCard(
          'Cancellable Navigation',
          'Users can cancel the back action by reversing their swipe gesture',
          Icons.cancel,
          Colors.orange,
        ),
        _buildConceptCard(
          'System Integration',
          'Works with system back button and gesture navigation',
          Icons.settings_system_daydream,
          Colors.blue,
        ),
        _buildConceptCard(
          'Progressive Animation',
          'Animation progress follows finger movement in real-time',
          Icons.animation,
          Colors.purple,
        ),
        SizedBox(height: 16),
        buildSubsectionTitle('Platform Requirements', Icons.android, Colors.green.shade700),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildRequirementRow('Minimum Android Version', 'Android 14 (API 34)'),
              _buildRequirementRow('Navigation Mode', 'Gesture Navigation'),
              _buildRequirementRow('Flutter Version', 'Flutter 3.16+'),
              _buildRequirementRow('AndroidManifest Flag', 'enableOnBackInvokedCallback=true'),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.amber.shade700, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'On devices without predictive back support, the builder falls back to standard page transitions.',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildConceptCard(String title, String description, IconData icon, MaterialColor color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color.shade700, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRequirementRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildPageTransitionsThemeSection() {
  print('Building PageTransitionsTheme section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.color_lens, color: Colors.indigo.shade700, size: 28),
            SizedBox(width: 12),
            Text(
              'PageTransitionsTheme Configuration',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Configure PredictiveBackFullscreenPageTransitionsBuilder in your theme to enable '
          'predictive back transitions for specific platforms.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        buildSubsectionTitle('Theme Setup Example', Icons.code, Colors.grey.shade700),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeLine('MaterialApp(', Colors.yellow.shade300),
              _buildCodeLine('  theme: ThemeData(', Colors.blue.shade300),
              _buildCodeLine('    pageTransitionsTheme: PageTransitionsTheme(', Colors.green.shade300),
              _buildCodeLine('      builders: {', Colors.cyan.shade300),
              _buildCodeLine('        TargetPlatform.android:', Colors.orange.shade300),
              _buildCodeLine('          PredictiveBackFullscreenPageTransitionsBuilder(),', Colors.pink.shade300),
              _buildCodeLine('        TargetPlatform.iOS:', Colors.orange.shade300),
              _buildCodeLine('          CupertinoPageTransitionsBuilder(),', Colors.pink.shade300),
              _buildCodeLine('      },', Colors.cyan.shade300),
              _buildCodeLine('    ),', Colors.green.shade300),
              _buildCodeLine('  ),', Colors.blue.shade300),
              _buildCodeLine(')', Colors.yellow.shade300),
            ],
          ),
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Platform Builder Mapping', Icons.devices, Colors.teal.shade700),
        _buildPlatformMappingCard(
          'Android',
          'PredictiveBackFullscreenPageTransitionsBuilder',
          Icons.android,
          Colors.green,
        ),
        _buildPlatformMappingCard(
          'iOS',
          'CupertinoPageTransitionsBuilder',
          Icons.apple,
          Colors.grey,
        ),
        _buildPlatformMappingCard(
          'Linux',
          'FadeUpwardsPageTransitionsBuilder',
          Icons.computer,
          Colors.orange,
        ),
        _buildPlatformMappingCard(
          'Windows',
          'ZoomPageTransitionsBuilder',
          Icons.desktop_windows,
          Colors.blue,
        ),
        _buildPlatformMappingCard(
          'macOS',
          'CupertinoPageTransitionsBuilder',
          Icons.laptop_mac,
          Colors.purple,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade100, Colors.purple.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PageTransitionsTheme Properties',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 8),
              buildInfoCard('builders', 'Map<TargetPlatform, PageTransitionsBuilder>'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeLine(String code, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: color,
      ),
    ),
  );
}

Widget _buildPlatformMappingCard(String platform, String builder, IconData icon, MaterialColor color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Icon(icon, color: color.shade700, size: 24),
        SizedBox(width: 12),
        Text(
          platform,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color.shade800,
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.shade300),
          ),
          child: Text(
            builder,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: color.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTransitionBuildersComparisonSection() {
  print('Building transition builders comparison section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.teal.shade700, size: 28),
            SizedBox(width: 12),
            Text(
              'Page Transition Builders Comparison',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Flutter provides several PageTransitionsBuilder implementations. Here is a comparison '
          'of available builders and their characteristics.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 20),
        _buildTransitionBuilderCard(
          'PredictiveBackFullscreenPageTransitionsBuilder',
          'Android predictive back gesture with fullscreen preview',
          'Swipe preview + Scale',
          'Android 14+',
          Colors.deepPurple,
          Icons.swipe_left,
          true,
        ),
        _buildTransitionBuilderCard(
          'FadeUpwardsPageTransitionsBuilder',
          'Page fades in while sliding up from the bottom',
          'Fade + Slide Up',
          'Android (default), Linux',
          Colors.blue,
          Icons.arrow_upward,
          false,
        ),
        _buildTransitionBuilderCard(
          'OpenUpwardsPageTransitionsBuilder',
          'Page slides up with an opening effect and fade',
          'Open + Slide Up',
          'Android (Material 2)',
          Colors.green,
          Icons.open_in_full,
          false,
        ),
        _buildTransitionBuilderCard(
          'ZoomPageTransitionsBuilder',
          'Page zooms in from the center with fade effect',
          'Zoom + Fade',
          'Windows, Android (Material 3)',
          Colors.orange,
          Icons.zoom_in,
          false,
        ),
        _buildTransitionBuilderCard(
          'CupertinoPageTransitionsBuilder',
          'iOS-style horizontal slide with parallax effect',
          'Horizontal Slide',
          'iOS, macOS',
          Colors.grey,
          Icons.chevron_right,
          false,
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Visual Comparison', Icons.visibility, Colors.purple.shade700),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _buildComparisonRow('Animation Type', ['Preview', 'Fade', 'Open', 'Zoom', 'Slide']),
              Divider(color: Colors.purple.shade200),
              _buildComparisonRow('Gesture Driven', ['Yes', 'No', 'No', 'No', 'Yes']),
              Divider(color: Colors.purple.shade200),
              _buildComparisonRow('Predictive', ['Yes', 'No', 'No', 'No', 'No']),
              Divider(color: Colors.purple.shade200),
              _buildComparisonRow('Duration (ms)', ['300', '300', '300', '300', '400']),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.tips_and_updates, color: Colors.teal.shade700, size: 22),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'PredictiveBackFullscreenPageTransitionsBuilder is the only builder that provides '
                  'real-time gesture preview feedback to users.',
                  style: TextStyle(fontSize: 12, color: Colors.teal.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTransitionBuilderCard(
  String name,
  String description,
  String animation,
  String platform,
  MaterialColor color,
  IconData icon,
  bool isPredictive,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: isPredictive ? color.shade500 : color.shade200,
        width: isPredictive ? 2 : 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color.shade700, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
            ),
            if (isPredictive)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'RECOMMENDED',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade800,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _buildBuilderTag('Animation', animation, color),
            SizedBox(width: 8),
            _buildBuilderTag('Platform', platform, Colors.grey),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBuilderTag(String label, String value, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontSize: 10, color: color.shade600),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color.shade800,
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(String label, List<String> values) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: values.map((v) => Text(
              v,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
            )).toList(),
          ),
        ),
      ],
    ),
  );
}

Widget buildNavigatorPushDemonstrationSection() {
  print('Building Navigator.push demonstration section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.navigation, color: Colors.blue.shade700, size: 28),
            SizedBox(width: 12),
            Text(
              'Navigator.push Demonstrations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'When PredictiveBackFullscreenPageTransitionsBuilder is configured in PageTransitionsTheme, '
          'all navigation operations using MaterialPageRoute will automatically use predictive back transitions.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Basic Navigation', Icons.arrow_forward, Colors.blue.shade700),
        _buildNavigationExample(
          'Simple Push',
          'Navigator.push with MaterialPageRoute',
          'Navigator.push(\n  context,\n  MaterialPageRoute(\n    builder: (ctx) => DetailsPage(),\n  ),\n);',
          Colors.blue,
        ),
        _buildNavigationExample(
          'Named Route',
          'Navigator.pushNamed with route registration',
          'Navigator.pushNamed(\n  context,\n  \'/details\',\n  arguments: myData,\n);',
          Colors.green,
        ),
        _buildNavigationExample(
          'Replace Route',
          'Navigator.pushReplacement for screen replacement',
          'Navigator.pushReplacement(\n  context,\n  MaterialPageRoute(\n    builder: (ctx) => NewPage(),\n  ),\n);',
          Colors.orange,
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Advanced Navigation', Icons.account_tree, Colors.purple.shade700),
        _buildNavigationExample(
          'Push and Remove Until',
          'Clear stack and push new route',
          'Navigator.pushAndRemoveUntil(\n  context,\n  MaterialPageRoute(\n    builder: (ctx) => HomePage(),\n  ),\n  (route) => false,\n);',
          Colors.purple,
        ),
        _buildNavigationExample(
          'Pop Until',
          'Pop routes until condition is met',
          'Navigator.popUntil(\n  context,\n  ModalRoute.withName(\'/home\'),\n);',
          Colors.teal,
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.cyan.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Predictive Back Behavior',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 10),
              _buildBehaviorItem(
                Icons.touch_app,
                'Gesture Start',
                'User begins swipe from screen edge',
              ),
              _buildBehaviorItem(
                Icons.preview,
                'Preview Display',
                'Previous screen becomes visible behind current',
              ),
              _buildBehaviorItem(
                Icons.transform,
                'Transform Animation',
                'Current screen scales and moves with gesture',
              ),
              _buildBehaviorItem(
                Icons.check_circle,
                'Completion',
                'Release triggers navigation or cancellation',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildNavigationExample(String title, String description, String code, MaterialColor color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9),
              topRight: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.code, color: color.shade700, size: 18),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  code,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Colors.green.shade300,
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

Widget _buildBehaviorItem(IconData icon, String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue.shade600, size: 18),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMaterialPageRouteCustomizationSection() {
  print('Building MaterialPageRoute customization section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.settings_applications, color: Colors.orange.shade700, size: 28),
            SizedBox(width: 12),
            Text(
              'MaterialPageRoute Customization',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'MaterialPageRoute provides various customization options that work alongside '
          'PredictiveBackFullscreenPageTransitionsBuilder.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Route Properties', Icons.tune, Colors.orange.shade700),
        _buildPropertyCard(
          'builder',
          'WidgetBuilder',
          'Required callback that builds the page widget',
          Colors.blue,
        ),
        _buildPropertyCard(
          'settings',
          'RouteSettings?',
          'Route configuration including name and arguments',
          Colors.green,
        ),
        _buildPropertyCard(
          'maintainState',
          'bool',
          'Whether to keep the state when route is inactive (default: true)',
          Colors.purple,
        ),
        _buildPropertyCard(
          'fullscreenDialog',
          'bool',
          'Whether the route is a fullscreen dialog (default: false)',
          Colors.teal,
        ),
        _buildPropertyCard(
          'allowSnapshotting',
          'bool',
          'Whether the route allows snapshotting for transitions',
          Colors.amber,
        ),
        _buildPropertyCard(
          'barrierDismissible',
          'bool',
          'Whether tapping the barrier dismisses the route',
          Colors.pink,
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Custom Route Example', Icons.code, Colors.grey.shade700),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeLine('MaterialPageRoute<void>(', Colors.yellow.shade300),
              _buildCodeLine('  builder: (BuildContext context) {', Colors.blue.shade300),
              _buildCodeLine('    return DetailsScreen(', Colors.green.shade300),
              _buildCodeLine('      itemId: itemId,', Colors.cyan.shade300),
              _buildCodeLine('    );', Colors.green.shade300),
              _buildCodeLine('  },', Colors.blue.shade300),
              _buildCodeLine('  settings: RouteSettings(', Colors.purple.shade300),
              _buildCodeLine('    name: \'/details\',', Colors.orange.shade300),
              _buildCodeLine('    arguments: {\'id\': itemId},', Colors.orange.shade300),
              _buildCodeLine('  ),', Colors.purple.shade300),
              _buildCodeLine('  maintainState: true,', Colors.pink.shade300),
              _buildCodeLine('  fullscreenDialog: false,', Colors.pink.shade300),
              _buildCodeLine(')', Colors.yellow.shade300),
            ],
          ),
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Fullscreen Dialog Mode', Icons.fullscreen, Colors.indigo.shade700),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When fullscreenDialog is true:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 10),
              _buildDialogBehaviorItem('AppBar shows close button instead of back arrow'),
              _buildDialogBehaviorItem('Transition animates from bottom on iOS'),
              _buildDialogBehaviorItem('Predictive back still works on Android 14+'),
              _buildDialogBehaviorItem('Route blocks gestures from underlying routes'),
            ],
          ),
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Route Transitions Override', Icons.swap_horiz, Colors.red.shade700),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Custom Transition with PageRouteBuilder',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'For complete control over transitions, use PageRouteBuilder instead of MaterialPageRoute:',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCodeLine('PageRouteBuilder<void>(', Colors.yellow.shade300),
                    _buildCodeLine('  pageBuilder: (ctx, anim, anim2) => MyPage(),', Colors.blue.shade300),
                    _buildCodeLine('  transitionsBuilder: (ctx, anim, anim2, child) {', Colors.green.shade300),
                    _buildCodeLine('    return FadeTransition(', Colors.cyan.shade300),
                    _buildCodeLine('      opacity: anim,', Colors.orange.shade300),
                    _buildCodeLine('      child: child,', Colors.orange.shade300),
                    _buildCodeLine('    );', Colors.cyan.shade300),
                    _buildCodeLine('  },', Colors.green.shade300),
                    _buildCodeLine(')', Colors.yellow.shade300),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyCard(String name, String type, String description, MaterialColor color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDialogBehaviorItem(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(Icons.check, color: Colors.indigo.shade600, size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.indigo.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildPredictiveBackAnimationSection() {
  print('Building predictive back animation details section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.animation, color: Colors.pink.shade700, size: 28),
            SizedBox(width: 12),
            Text(
              'Predictive Back Animation Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Understanding how the predictive back animation transforms the current and previous pages.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Transform Properties', Icons.transform, Colors.pink.shade700),
        _buildAnimationPropertyCard(
          'Scale',
          'Current page scales down as gesture progresses',
          '1.0 → 0.9',
          Colors.pink,
        ),
        _buildAnimationPropertyCard(
          'Translation X',
          'Page moves horizontally following finger',
          '0 → screen width',
          Colors.purple,
        ),
        _buildAnimationPropertyCard(
          'Opacity',
          'Subtle fade effect during transition',
          '1.0 → 0.8',
          Colors.indigo,
        ),
        _buildAnimationPropertyCard(
          'Corner Radius',
          'Corners round during the gesture',
          '0 → 16dp',
          Colors.blue,
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Animation Timeline', Icons.timeline, Colors.teal.shade700),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _buildTimelineStep(0, 'Idle', 'Page at normal position and scale'),
              _buildTimelineConnector(),
              _buildTimelineStep(1, 'Gesture Start', 'System detects back gesture'),
              _buildTimelineConnector(),
              _buildTimelineStep(2, 'Preview Active', 'Previous page visible, current transforms'),
              _buildTimelineConnector(),
              _buildTimelineStep(3, 'Release', 'Animation completes or reverses'),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info, color: Colors.cyan.shade700, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Animation Curves',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'The fullscreen predictive back uses linear interpolation during gesture tracking, '
                'but switches to easeOut when completing or cancelling the animation.',
                style: TextStyle(fontSize: 12, color: Colors.cyan.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnimationPropertyCard(
  String property,
  String description,
  String range,
  MaterialColor color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          padding: EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            property,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              SizedBox(height: 4),
              Text(
                'Range: $range',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: color.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimelineStep(int number, String title, String description) {
  return Row(
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.teal.shade600,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildTimelineConnector() {
  return Container(
    margin: EdgeInsets.only(left: 13),
    height: 20,
    width: 2,
    color: Colors.teal.shade300,
  );
}

Widget buildBackCompatibilitySection() {
  print('Building backward compatibility section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.history, color: Colors.amber.shade700, size: 28),
            SizedBox(width: 12),
            Text(
              'Backward Compatibility',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'PredictiveBackFullscreenPageTransitionsBuilder gracefully handles devices that do not '
          'support predictive back gestures.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 20),
        buildSubsectionTitle('Fallback Behavior', Icons.alt_route, Colors.amber.shade700),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _buildFallbackRow(
                'Android 14+ with Gesture Nav',
                'Full predictive back experience',
                Colors.green,
              ),
              Divider(color: Colors.amber.shade200),
              _buildFallbackRow(
                'Android 14+ with Button Nav',
                'Standard ZoomPageTransitionsBuilder',
                Colors.blue,
              ),
              Divider(color: Colors.amber.shade200),
              _buildFallbackRow(
                'Android < 14',
                'Standard ZoomPageTransitionsBuilder',
                Colors.orange,
              ),
              Divider(color: Colors.amber.shade200),
              _buildFallbackRow(
                'Other Platforms',
                'Platform-specific default transition',
                Colors.purple,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade700, size: 22),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'No code changes required - the builder automatically detects platform capabilities '
                  'and selects the appropriate transition.',
                  style: TextStyle(fontSize: 12, color: Colors.green.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFallbackRow(String platform, String behavior, MaterialColor color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            platform,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              behavior,
              style: TextStyle(fontSize: 11, color: color.shade800),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildBestPracticesSection() {
  print('Building best practices section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade300, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: Colors.green.shade700, size: 28),
            SizedBox(width: 12),
            Text(
              'Best Practices',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildPracticeCard(
          'Enable in AndroidManifest',
          'Set enableOnBackInvokedCallback to true in your AndroidManifest.xml '
          'to enable predictive back support.',
          Icons.android,
          Colors.green,
        ),
        _buildPracticeCard(
          'Use MaterialPageRoute',
          'Stick to MaterialPageRoute for consistent transitions. Custom routes '
          'may not integrate with predictive back.',
          Icons.route,
          Colors.blue,
        ),
        _buildPracticeCard(
          'Handle Back Callbacks',
          'Use PopScope widget to intercept back navigation when needed, ensuring '
          'compatibility with predictive back.',
          Icons.warning_amber,
          Colors.orange,
        ),
        _buildPracticeCard(
          'Test on Real Devices',
          'Emulators may not fully support predictive back. Test on Android 14+ '
          'devices with gesture navigation.',
          Icons.phone_android,
          Colors.purple,
        ),
        _buildPracticeCard(
          'Avoid Navigation Conflicts',
          'Ensure only one NavigatorState handles back gestures. Nested navigators '
          'can cause unexpected behavior.',
          Icons.layers,
          Colors.red,
        ),
      ],
    ),
  );
}

Widget _buildPracticeCard(String title, String description, IconData icon, MaterialColor color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color.shade700, size: 22),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMainContent() {
  print('Building main content for PredictiveBackFullscreenPageTransitionsBuilder demo');
  
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionHeader('Predictive Back Concept Overview'),
        buildPredictiveBackOverviewSection(),
        
        buildSectionHeader('PageTransitionsTheme Configuration'),
        buildPageTransitionsThemeSection(),
        
        buildSectionHeader('Transition Builders Comparison'),
        buildTransitionBuildersComparisonSection(),
        
        buildSectionHeader('Navigator.push Demonstrations'),
        buildNavigatorPushDemonstrationSection(),
        
        buildSectionHeader('MaterialPageRoute Customization'),
        buildMaterialPageRouteCustomizationSection(),
        
        buildSectionHeader('Animation Details'),
        buildPredictiveBackAnimationSection(),
        
        buildSectionHeader('Backward Compatibility'),
        buildBackCompatibilitySection(),
        
        buildSectionHeader('Best Practices'),
        buildBestPracticesSection(),
        
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade100, Colors.indigo.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                Icons.swipe_left_alt,
                color: Colors.deepPurple.shade700,
                size: 48,
              ),
              SizedBox(height: 12),
              Text(
                'PredictiveBackFullscreenPageTransitionsBuilder',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Bringing modern Android 14+ predictive back gestures to Flutter applications '
                'with fullscreen transition previews.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}

void main() {
  print('=== PredictiveBackFullscreenPageTransitionsBuilder Deep Demo ===');
  print('Testing page transition builder for Android predictive back gesture');
  
  runApp(
    MaterialApp(
      title: 'PredictiveBackFullscreenPageTransitionsBuilder Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey.shade200,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: PredictiveBackFullscreenPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Predictive Back Demo'),
          backgroundColor: Colors.deepPurple.shade700,
        ),
        body: buildMainContent(),
      ),
    ),
  );
}
