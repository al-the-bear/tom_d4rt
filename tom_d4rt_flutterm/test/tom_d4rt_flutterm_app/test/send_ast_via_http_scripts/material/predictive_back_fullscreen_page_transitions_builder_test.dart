// D4rt test script: Tests PredictiveBackFullscreenPageTransitionsBuilder from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
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

Widget buildOverviewSection() {
  print('Building overview section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swipe_left, color: Colors.indigo.shade700, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'PredictiveBackFullscreenPageTransitionsBuilder',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'A specialized PageTransitionsBuilder that provides fullscreen predictive back gesture transitions for page routes.',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Features:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              _buildFeatureItem('Fullscreen gesture-based navigation'),
              _buildFeatureItem('Predictive back support for Android 14+'),
              _buildFeatureItem('Smooth animated transitions'),
              _buildFeatureItem('Integrates with PageRoute system'),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Class Type', 'PageTransitionsBuilder'),
        buildInfoCard('Package', 'flutter/material.dart'),
        buildInfoCard('Platform', 'Android 14+ (API 34+)'),
      ],
    ),
  );
}

Widget _buildFeatureItem(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green.shade600, size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildBuildTransitionsSection() {
  print('Building buildTransitions section');
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
        Text(
          'buildTransitions Method',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Widget buildTransitions<T>(',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.green.shade300,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'PageRoute<T> route,',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.blue.shade300,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'BuildContext context,',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.blue.shade300,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Animation<double> animation,',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.blue.shade300,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Animation<double> secondaryAnimation,',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.blue.shade300,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Widget child,',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.blue.shade300,
                  ),
                ),
              ),
              Text(
                ')',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.green.shade300,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildParameterCard(
          'route',
          'PageRoute<T>',
          'The page route that owns this transition',
          Colors.blue,
        ),
        _buildParameterCard(
          'context',
          'BuildContext',
          'Build context for localization and theme',
          Colors.purple,
        ),
        _buildParameterCard(
          'animation',
          'Animation<double>',
          'Primary animation driving the transition',
          Colors.orange,
        ),
        _buildParameterCard(
          'secondaryAnimation',
          'Animation<double>',
          'Animation when another route is pushed on top',
          Colors.teal,
        ),
        _buildParameterCard(
          'child',
          'Widget',
          'The page content being transitioned',
          Colors.pink,
        ),
      ],
    ),
  );
}

Widget _buildParameterCard(
  String name,
  String type,
  String description,
  MaterialColor color,
) {
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
        Text(
          type,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildPageRouteIntegrationSection() {
  print('Building page route integration section');
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
        Text(
          'Page Route Integration',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          'The builder integrates with MaterialPageRoute and other PageRoute implementations:',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        _buildIntegrationStep(
          1,
          'Configure PageTransitionsTheme',
          'Set up the theme in MaterialApp',
          Icons.settings,
          Colors.blue,
        ),
        _buildIntegrationStep(
          2,
          'Use MaterialPageRoute',
          'Routes automatically use the configured builder',
          Icons.route,
          Colors.green,
        ),
        _buildIntegrationStep(
          3,
          'Handle Back Gesture',
          'System detects predictive back gestures',
          Icons.swipe_left,
          Colors.orange,
        ),
        _buildIntegrationStep(
          4,
          'Animate Transition',
          'Builder creates smooth fullscreen animation',
          Icons.animation,
          Colors.purple,
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
              Icon(Icons.info_outline, color: Colors.amber.shade700, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'PageTransitionsBuilder is used by PageTransitionsTheme within ThemeData',
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

Widget _buildIntegrationStep(
  int step,
  String title,
  String description,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.shade100,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Icon(icon, color: color.shade600, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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

Widget buildAnimationConceptsSection() {
  print('Building animation concepts section');
  List<String> conceptNames = [
    'Animation Controller',
    'Tween Animation',
    'Curved Animation',
    'Animation Status',
  ];
  List<String> conceptDescriptions = [
    'Manages the animation lifecycle and timing',
    'Interpolates between begin and end values',
    'Applies easing curves to animations',
    'Tracks forward, reverse, completed states',
  ];
  List<IconData> conceptIcons = [
    Icons.play_circle_filled,
    Icons.transform,
    Icons.show_chart,
    Icons.info,
  ];
  List<MaterialColor> conceptColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  List<Widget> conceptCards = [];
  int i = 0;
  for (i = 0; i < conceptNames.length; i = i + 1) {
    conceptCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: conceptColors[i].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: conceptColors[i].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: conceptColors[i].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                conceptIcons[i],
                color: conceptColors[i].shade700,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conceptNames[i],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: conceptColors[i].shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    conceptDescriptions[i],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
        Text(
          'Animation Concepts',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Core concepts used in page transitions',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: conceptCards),
      ],
    ),
  );
}

Widget buildFullscreenTransitionsSection() {
  print('Building fullscreen transitions section');
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
        Text(
          'Fullscreen Transitions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildTransitionPhaseCard('Initial', 0.0, Colors.red),
            SizedBox(width: 8),
            _buildTransitionPhaseCard('Mid', 0.5, Colors.orange),
            SizedBox(width: 8),
            _buildTransitionPhaseCard('Final', 1.0, Colors.green),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Transition Characteristics:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        _buildCharacteristicRow(
          'Coverage',
          'Full screen area',
          Icons.fullscreen,
        ),
        _buildCharacteristicRow(
          'Direction',
          'Horizontal swipe',
          Icons.swap_horiz,
        ),
        _buildCharacteristicRow(
          'Animation',
          'Smooth easing',
          Icons.trending_up,
        ),
        _buildCharacteristicRow('Gesture', 'Edge-triggered', Icons.touch_app),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade100, Colors.purple.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(Icons.swipe, size: 32, color: Colors.indigo.shade700),
              SizedBox(height: 8),
              Text(
                'Fullscreen Predictive Back',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Provides visual feedback during back gesture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTransitionPhaseCard(
  String label,
  double progress,
  MaterialColor color,
) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: color.shade800,
            ),
          ),
          SizedBox(height: 4),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: color.shade700,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCharacteristicRow(String label, String value, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.indigo.shade400),
        SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget buildPredictiveBackGestureSection() {
  print('Building predictive back gesture section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.gesture, color: Colors.green.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'Predictive Back Gesture',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Android 14 introduced predictive back gestures, allowing users to preview the previous screen during a back swipe.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        _buildGestureStage(
          'Start',
          'User begins edge swipe',
          Icons.touch_app,
          1,
        ),
        _buildGestureStage(
          'Preview',
          'Previous screen becomes visible',
          Icons.visibility,
          2,
        ),
        _buildGestureStage(
          'Commit',
          'User completes the gesture',
          Icons.check_circle,
          3,
        ),
        _buildGestureStage(
          'Cancel',
          'User cancels mid-gesture',
          Icons.cancel,
          4,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'System Requirements:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.android, color: Colors.green.shade700, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Android 14+ (API 34)',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.settings, color: Colors.green.shade700, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Gesture navigation enabled',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.code, color: Colors.green.shade700, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'enablePredictiveBack: true in manifest',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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

Widget _buildGestureStage(
  String title,
  String description,
  IconData icon,
  int number,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.green.shade700,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Icon(icon, color: Colors.green.shade500, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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

Widget buildComparisonSection() {
  print('Building comparison section');
  List<String> builderNames = [
    'PredictiveBackFullscreen',
    'FadeForwards',
    'Cupertino',
    'Zoom',
    'Open Upwards',
  ];
  List<String> builderDescriptions = [
    'Edge swipe with fullscreen preview',
    'Fade + slide up animation',
    'iOS-style horizontal slide',
    'Zoom in/out effect',
    'Slide up from bottom',
  ];
  List<String> builderPlatforms = [
    'Android 14+',
    'Android/Linux',
    'iOS/macOS',
    'Android 10+',
    'Android',
  ];
  List<MaterialColor> builderColors = [
    Colors.indigo,
    Colors.blue,
    Colors.grey,
    Colors.orange,
    Colors.purple,
  ];

  List<Widget> comparisonCards = [];
  int i = 0;
  for (i = 0; i < builderNames.length; i = i + 1) {
    bool isHighlighted = i == 0;
    comparisonCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isHighlighted ? Colors.indigo.shade50 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isHighlighted
                ? Colors.indigo.shade400
                : Colors.grey.shade300,
            width: isHighlighted ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 40,
              decoration: BoxDecoration(
                color: builderColors[i],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        builderNames[i],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: builderColors[i].shade800,
                        ),
                      ),
                      if (isHighlighted)
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Current',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    builderDescriptions[i],
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: builderColors[i].shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                builderPlatforms[i],
                style: TextStyle(
                  fontSize: 10,
                  color: builderColors[i].shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        Text(
          'Comparison with Other Builders',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different page transition styles available in Flutter',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: comparisonCards),
      ],
    ),
  );
}

Widget buildPlatformConsiderationsSection() {
  print('Building platform considerations section');
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
        Text(
          'Platform Considerations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _buildPlatformCard('Android 14+', Icons.android, Colors.green, [
          'Full predictive back support',
          'Native gesture integration',
          'Fullscreen preview',
        ], true),
        SizedBox(height: 8),
        _buildPlatformCard('Android < 14', Icons.android, Colors.orange, [
          'Falls back to standard transition',
          'No gesture preview',
          'Uses system back',
        ], false),
        SizedBox(height: 8),
        _buildPlatformCard('iOS / macOS', Icons.apple, Colors.grey, [
          'Not applicable',
          'Use CupertinoPageTransitionsBuilder',
          'Native swipe-back',
        ], false),
        SizedBox(height: 8),
        _buildPlatformCard('Web / Desktop', Icons.computer, Colors.blue, [
          'Standard transitions apply',
          'No gesture support',
          'Button/keyboard navigation',
        ], false),
      ],
    ),
  );
}

Widget _buildPlatformCard(
  String platform,
  IconData icon,
  MaterialColor color,
  List<String> features,
  bool isRecommended,
) {
  List<Widget> featureWidgets = [];
  int i = 0;
  for (i = 0; i < features.length; i = i + 1) {
    featureWidgets.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Icon(
              isRecommended ? Icons.check : Icons.remove,
              size: 14,
              color: isRecommended ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 6),
            Text(
              features[i],
              style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isRecommended ? color.shade400 : color.shade200,
        width: isRecommended ? 2 : 1,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color.shade700, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    platform,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: color.shade800,
                    ),
                  ),
                  if (isRecommended)
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Recommended',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 6),
              Column(children: featureWidgets),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildAnimationCurvesSection() {
  print('Building animation curves section');
  List<String> curveNames = [
    'easeInOut',
    'easeIn',
    'easeOut',
    'linear',
    'decelerate',
    'fastOutSlowIn',
  ];
  List<String> curveDescriptions = [
    'Smooth acceleration and deceleration',
    'Starts slow, accelerates',
    'Starts fast, decelerates',
    'Constant speed throughout',
    'Quick start, gradual stop',
    'Material Design standard curve',
  ];
  List<MaterialColor> curveColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.teal,
  ];

  List<Widget> curveCards = [];
  int i = 0;
  for (i = 0; i < curveNames.length; i = i + 1) {
    curveCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: curveColors[i].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                color: curveColors[i].shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: CustomPaint(painter: _CurvePainter(curveColors[i])),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curveNames[i],
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: curveColors[i].shade800,
                    ),
                  ),
                  Text(
                    curveDescriptions[i],
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
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
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Curves',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Common curves used in page transitions',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: curveCards),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.blue.shade700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Predictive back uses easeOut for natural feel during swipe',
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _CurvePainter extends CustomPainter {
  _CurvePainter(this.color);
  MaterialColor color;

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color.shade400
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.1, size.width, 0);
    canvas.drawPath(path, paint);
  }

  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Widget buildInteractiveShowcaseSection() {
  print('Building interactive showcase section');
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
        Text(
          'Interactive Transition Showcase',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _buildTransitionDemo(
          'Forward Navigation',
          'Page A',
          'Page B',
          Icons.arrow_forward,
          Colors.blue,
        ),
        SizedBox(height: 16),
        _buildTransitionDemo(
          'Predictive Back',
          'Page B',
          'Page A',
          Icons.swipe_left,
          Colors.green,
        ),
        SizedBox(height: 16),
        _buildGestureVisualization(),
        SizedBox(height: 16),
        _buildTransitionTimeline(),
      ],
    ),
  );
}

Widget _buildTransitionDemo(
  String title,
  String fromPage,
  String toPage,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color.shade700, size: 20),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: color.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article, color: color.shade400, size: 24),
                  SizedBox(height: 4),
                  Text(
                    fromPage,
                    style: TextStyle(fontSize: 10, color: color.shade600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Icon(Icons.arrow_forward, color: color.shade400),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Transition',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: color.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 70,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.shade500, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: color.shade200,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article, color: color.shade700, size: 24),
                  SizedBox(height: 4),
                  Text(
                    toPage,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: color.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildGestureVisualization() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gesture Progress',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.purple.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.touch_app, color: Colors.purple.shade400, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.65,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              '65%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.purple.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGestureLabel('Start', Icons.arrow_back, Colors.purple),
            _buildGestureLabel('Threshold', Icons.commit, Colors.orange),
            _buildGestureLabel('Complete', Icons.check, Colors.green),
          ],
        ),
      ],
    ),
  );
}

Widget _buildGestureLabel(String label, IconData icon, MaterialColor color) {
  return Column(
    children: [
      Icon(icon, color: color.shade500, size: 18),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 10, color: color.shade700)),
    ],
  );
}

Widget _buildTransitionTimeline() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transition Timeline',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildTimelinePoint('0ms', 'Start', true),
            Expanded(child: Container(height: 2, color: Colors.teal.shade300)),
            _buildTimelinePoint('150ms', 'Mid', true),
            Expanded(child: Container(height: 2, color: Colors.teal.shade300)),
            _buildTimelinePoint('300ms', 'End', true),
          ],
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            'Default transition duration: 300ms',
            style: TextStyle(fontSize: 11, color: Colors.teal.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimelinePoint(String time, String label, bool active) {
  return Column(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: active ? Colors.teal.shade500 : Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(height: 4),
      Text(
        time,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: Colors.teal.shade700,
        ),
      ),
      Text(label, style: TextStyle(fontSize: 8, color: Colors.teal.shade500)),
    ],
  );
}

dynamic build(BuildContext context) {
  print(
    'PredictiveBackFullscreenPageTransitionsBuilder deep demo test executing',
  );

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionHeader('1. Overview'),
        buildOverviewSection(),
        buildSectionHeader('2. BuildTransitions Method'),
        buildBuildTransitionsSection(),
        buildSectionHeader('3. Page Route Integration'),
        buildPageRouteIntegrationSection(),
        buildSectionHeader('4. Animation Concepts'),
        buildAnimationConceptsSection(),
        buildSectionHeader('5. Fullscreen Transitions'),
        buildFullscreenTransitionsSection(),
        buildSectionHeader('6. Predictive Back Gesture'),
        buildPredictiveBackGestureSection(),
        buildSectionHeader('7. Comparison with Other Builders'),
        buildComparisonSection(),
        buildSectionHeader('8. Platform Considerations'),
        buildPlatformConsiderationsSection(),
        buildSectionHeader('9. Animation Curves'),
        buildAnimationCurvesSection(),
        buildSectionHeader('10. Interactive Showcase'),
        buildInteractiveShowcaseSection(),
        SizedBox(height: 32),
        Center(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Column(
              children: [
                Icon(Icons.swipe_left, color: Colors.indigo.shade700, size: 32),
                SizedBox(height: 8),
                Text(
                  'PredictiveBackFullscreenPageTransitionsBuilder',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.indigo.shade800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Deep Demo Test Complete',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
