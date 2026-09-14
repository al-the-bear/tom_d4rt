// ignore_for_file: avoid_print
// Deep demo: PredictiveBackEvent — Android predictive back gesture data
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Jade / Mint
// ─────────────────────────────────────────────────────────────
const Color _pbJade = Color(0xFF00695C);
const Color _pbMint = Color(0xFFE0F2F1);
const Color _pbDeepTeal = Color(0xFF004D40);
const Color _pbMedTeal = Color(0xFF00897B);
const Color _pbLightTeal = Color(0xFFB2DFDB);
const Color _pbWhite = Color(0xFFFFFFFF);
const Color _pbGray = Color(0xFF546E7A);
const Color _pbDarkGray = Color(0xFF263238);
const Color _pbAccentAmber = Color(0xFFFF8F00);
const Color _pbAccentRed = Color(0xFFD32F2F);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _pbSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _pbWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _pbLightTeal, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _pbJade,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _pbWhite, fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _pbLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _pbDeepTeal, fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

Widget _pbBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _pbGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _pbChip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _pbInfoRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(key,
              style: const TextStyle(
                  color: _pbDeepTeal, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: _pbGray, fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _pbDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 1,
    color: _pbLightTeal.withValues(alpha: 0.6),
  );
}

// ─────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════');
  print('  PredictiveBackEvent — Deep Demo');
  print('  Android 14+ predictive back gesture data');
  print('═══════════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _pbMint,
      appBarTheme: const AppBarTheme(
        backgroundColor: _pbJade,
        foregroundColor: _pbWhite,
        elevation: 3,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('PredictiveBackEvent'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _buildBanner(),
            _buildWhatIsIt(),
            _buildAndroidPredictiveBackConcept(),
            _buildEventProperties(),
            _buildProgressVisualization(),
            _buildSwipeEdgeDetection(),
            _buildTouchCoordinateMapping(),
            _buildGesturePhases(),
            _buildPopScopeIntegration(),
            _buildAnimationDemo(),
            _buildPlatformComparison(),
            _buildSummary(),
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 1 — Banner
// ═══════════════════════════════════════════════════════════════
Widget _buildBanner() {
  print('[Section 1] Banner');
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_pbJade, _pbMedTeal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x4000695C), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.swipe_left, size: 52, color: _pbWhite),
        const SizedBox(height: 12),
        const Text('PredictiveBackEvent',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _pbWhite, fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _pbWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Android 14+ · Predictive Back Gesture · Preview',
            style: TextStyle(color: _pbWhite, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pbChip('services', _pbWhite),
            _pbChip('Android 14+', _pbWhite),
            _pbChip('GestureBack', _pbWhite),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 2 — What Is It?
// ═══════════════════════════════════════════════════════════════
Widget _buildWhatIsIt() {
  print('[Section 2] What is PredictiveBackEvent?');
  return _pbSection('What Is PredictiveBackEvent?', [
    _pbBody(
      'PredictiveBackEvent is a data class that carries information about '
      'an ongoing Android predictive back gesture. Starting with Android 14 '
      '(API 34), the system provides real-time data about the user\'s back '
      'swipe gesture so apps can animate a preview of what will happen.',
    ),
    _pbDivider(),
    _pbLabel('Why Predictive Back?'),
    _pbBody(
      'Traditionally, the Android back button was instant — tap and the '
      'previous screen appeared. With the new gesture navigation, users '
      'swipe from the edge of the screen. Predictive back lets the app '
      'show what will happen before the user commits to the gesture, '
      'creating a smoother, more intentional navigation experience.',
    ),
    _pbDivider(),
    _pbLabel('Timeline'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _pbMint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineItem('Android 10', 'Gesture navigation introduced (swipe from edge)',
              _pbGray),
          _buildTimelineItem('Android 12', 'Back gesture animation hints added',
              _pbGray),
          _buildTimelineItem('Android 13', 'Predictive back API preview (opt-in)',
              _pbMedTeal),
          _buildTimelineItem('Android 14', 'PredictiveBackEvent API finalized',
              _pbJade),
          _buildTimelineItem('Android 15+', 'Required for all apps targeting SDK 35+',
              _pbDeepTeal),
        ],
      ),
    ),
  ]);
}

Widget _buildTimelineItem(String version, String description, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(version,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(description,
              style: const TextStyle(color: _pbGray, fontSize: 11.5)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 3 — Android Predictive Back Concept
// ═══════════════════════════════════════════════════════════════
Widget _buildAndroidPredictiveBackConcept() {
  print('[Section 3] Android predictive back concept');
  return _pbSection('The Predictive Back Concept', [
    _pbBody(
      'Predictive back fundamentally changes how back navigation works. '
      'Instead of committing immediately, the user gets a preview:',
    ),
    _pbDivider(),
    // Before/After comparison
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _pbGray.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _pbGray.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                const Icon(Icons.arrow_back, size: 28, color: _pbGray),
                const SizedBox(height: 6),
                const Text('Traditional Back',
                    style: TextStyle(
                        color: _pbGray, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                _pbBody('Tap/swipe → instant action'),
                _pbBody('No preview of destination'),
                _pbBody('Cannot cancel mid-gesture'),
                _pbBody('Abrupt screen transition'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _pbJade.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _pbJade, width: 2),
            ),
            child: Column(
              children: [
                const Icon(Icons.swipe_left, size: 28, color: _pbJade),
                const SizedBox(height: 6),
                const Text('Predictive Back ★',
                    style: TextStyle(
                        color: _pbJade, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                _pbBody('Swipe → live preview animates'),
                _pbBody('Shows where you\'re going'),
                _pbBody('Release finger to cancel'),
                _pbBody('Smooth, intentional UX'),
              ],
            ),
          ),
        ),
      ],
    ),
    _pbDivider(),
    _pbLabel('What Gets Previewed'),
    _pbBody(
      '• Back to previous route → the previous page slides into view\n'
      '• Back to home → the home screen launcher preview appears\n'
      '• Back-to-nothing → system shows a home-screen preview\n'
      '• Nested navigation → the parent navigator\'s top route',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 4 — Event Properties
// ═══════════════════════════════════════════════════════════════
Widget _buildEventProperties() {
  print('[Section 4] PredictiveBackEvent properties');
  return _pbSection('Event Properties', [
    _pbBody(
      'PredictiveBackEvent provides real-time data about the active '
      'back gesture:',
    ),
    _pbDivider(),
    // Property cards
    _buildPropertyCard('touchOffset', 'Offset',
        'The (x, y) position of the finger on screen in logical pixels. '
        'Updates continuously as the user moves their finger.',
        Icons.touch_app, _pbJade),
    _buildPropertyCard('progress', 'double (0.0 → 1.0)',
        'How far the gesture has progressed. 0.0 = just started, '
        '1.0 = fully committed. Typically 0.3+ triggers the back action.',
        Icons.linear_scale, _pbMedTeal),
    _buildPropertyCard('swipeEdge', 'SwipeEdge (left | right)',
        'Which screen edge the swipe started from. Users can swipe '
        'from either edge to trigger back navigation.',
        Icons.swap_horiz, _pbAccentAmber),
    _pbDivider(),
    _pbLabel('SwipeEdge Enum'),
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _pbJade.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _pbJade.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                const Icon(Icons.arrow_forward, size: 24, color: _pbJade),
                const SizedBox(height: 4),
                const Text('SwipeEdge.left',
                    style: TextStyle(
                        color: _pbJade, fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _pbBody('Swipe from left edge\nRight-handed typical'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _pbAccentAmber.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _pbAccentAmber.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                const Icon(Icons.arrow_back, size: 24, color: _pbAccentAmber),
                const SizedBox(height: 4),
                const Text('SwipeEdge.right',
                    style: TextStyle(
                        color: _pbAccentAmber,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _pbBody('Swipe from right edge\nLeft-handed typical'),
              ],
            ),
          ),
        ),
      ],
    ),
  ]);
}

Widget _buildPropertyCard(
    String name, String type, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: TextStyle(
                          color: color, fontSize: 13, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  Text(type,
                      style: TextStyle(
                          color: color.withValues(alpha: 0.6), fontSize: 11)),
                ],
              ),
              const SizedBox(height: 4),
              Text(desc,
                  style: const TextStyle(color: _pbGray, fontSize: 11.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 5 — Progress Visualization
// ═══════════════════════════════════════════════════════════════
Widget _buildProgressVisualization() {
  print('[Section 5] Progress visualization');
  return _pbSection('Progress Visualization (0.0 → 1.0)', [
    _pbBody(
      'The progress field is a double ranging from 0.0 to 1.0 representing '
      'how far the back gesture has advanced:',
    ),
    _pbDivider(),
    // Progress bar stages
    _buildProgressStage(0.0, 'Gesture Start',
        'Finger just touched the edge. No visual change yet.', _pbLightTeal),
    _buildProgressStage(0.1, 'Initial Drag',
        'Slight shrink begins. App starts scaling down.', _pbMedTeal),
    _buildProgressStage(0.3, 'Threshold',
        'Enough drag to trigger back if released. Previous screen peeks through.',
        _pbJade),
    _buildProgressStage(0.6, 'Mid Gesture',
        'App is noticeably smaller. Destination clearly visible behind.',
        _pbDeepTeal),
    _buildProgressStage(1.0, 'Fully Committed',
        'Maximum drag reached. Back action will definitely execute.',
        _pbDarkGray),
    _pbDivider(),
    // Visual progress demo
    _pbLabel('Visual Effect at Different Progress Values'),
    SizedBox(
      height: 120,
      child: Row(
        children: [
          _buildMiniPhone(0.0, 'p=0.0'),
          const SizedBox(width: 4),
          _buildMiniPhone(0.15, 'p=0.15'),
          const SizedBox(width: 4),
          _buildMiniPhone(0.35, 'p=0.35'),
          const SizedBox(width: 4),
          _buildMiniPhone(0.6, 'p=0.6'),
          const SizedBox(width: 4),
          _buildMiniPhone(1.0, 'p=1.0'),
        ],
      ),
    ),
    _pbDivider(),
    _pbBody(
      'The progress value allows apps to create custom animations that '
      'map to the gesture\'s advancement. Common uses include scaling, '
      'opacity, translation, and corner radius changes.',
    ),
  ]);
}

Widget _buildProgressStage(
    double progress, String stage, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 46,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(progress.toStringAsFixed(1),
                style: TextStyle(
                    color: color, fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(stage,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _pbGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMiniPhone(double progress, String label) {
  final scale = 1.0 - (progress * 0.15);
  final cornerRadius = progress * 16;
  final opacity = 1.0 - (progress * 0.3);

  return Expanded(
    child: Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _pbDarkGray.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _pbDarkGray.withValues(alpha: 0.2)),
            ),
            child: Center(
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 36,
                  height: 64,
                  decoration: BoxDecoration(
                    color: _pbJade.withValues(alpha: opacity),
                    borderRadius: BorderRadius.circular(cornerRadius.clamp(2.0, 16.0)),
                    border: Border.all(color: _pbDeepTeal),
                  ),
                  child: Center(
                    child: Icon(Icons.article,
                        size: 16,
                        color: _pbWhite.withValues(alpha: opacity)),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(color: _pbGray, fontSize: 9)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 6 — Swipe Edge Detection
// ═══════════════════════════════════════════════════════════════
Widget _buildSwipeEdgeDetection() {
  print('[Section 6] Swipe edge detection');
  return _pbSection('Swipe Edge Detection', [
    _pbBody(
      'Android gesture navigation allows swiping from either screen edge. '
      'The swipeEdge field tells which edge the gesture originated from:',
    ),
    _pbDivider(),
    // Phone simulation showing both edges
    Container(
      height: 220,
      decoration: BoxDecoration(
        color: _pbDarkGray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _pbDarkGray, width: 3),
      ),
      child: Row(
        children: [
          // Left edge indicator
          Container(
            width: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _pbJade.withValues(alpha: 0.4),
                  _pbJade.withValues(alpha: 0.0),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                bottomLeft: Radius.circular(13),
              ),
            ),
            child: const Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text('LEFT EDGE',
                    style: TextStyle(
                        color: _pbWhite, fontSize: 9, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          // Screen content
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _pbWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.article, size: 36, color: _pbJade),
                  const SizedBox(height: 8),
                  const Text('App Content',
                      style: TextStyle(
                          color: _pbDarkGray,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_forward, size: 16,
                          color: _pbJade.withValues(alpha: 0.5)),
                      const SizedBox(width: 4),
                      const Text('Swipe inward from either edge',
                          style: TextStyle(color: _pbGray, fontSize: 11)),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_back, size: 16,
                          color: _pbAccentAmber.withValues(alpha: 0.5)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Right edge indicator
          Container(
            width: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _pbAccentAmber.withValues(alpha: 0.0),
                  _pbAccentAmber.withValues(alpha: 0.4),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(13),
                bottomRight: Radius.circular(13),
              ),
            ),
            child: const Center(
              child: RotatedBox(
                quarterTurns: 1,
                child: Text('RIGHT EDGE',
                    style: TextStyle(
                        color: _pbWhite, fontSize: 9, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    ),
    _pbDivider(),
    _pbLabel('Edge-Dependent Animation'),
    _pbBody(
      'The swipe edge affects the animation direction:\n\n'
      '• Left edge → app slides right, revealing destination\n'
      '• Right edge → app slides left, revealing destination\n\n'
      'Apps should mirror their animation based on swipeEdge '
      'to create a natural, directional preview.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 7 — Touch Coordinate Mapping
// ═══════════════════════════════════════════════════════════════
Widget _buildTouchCoordinateMapping() {
  print('[Section 7] Touch coordinate mapping');
  return _pbSection('Touch Coordinate Mapping', [
    _pbBody(
      'The touchOffset field provides the current finger position in logical '
      'pixels relative to the screen. This allows precise tracking:',
    ),
    _pbDivider(),
    // Coordinate diagram
    Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _pbLightTeal),
      ),
      child: Stack(
        children: [
          // Coordinate grid
          Positioned.fill(child: CustomPaint(painter: _CoordGridPainter())),
          // Origin label
          const Positioned(
            left: 4,
            top: 4,
            child: Text('(0, 0)',
                style: TextStyle(color: _pbGray, fontSize: 9)),
          ),
          // Touch path
          Positioned(
            left: 10,
            top: 80,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _pbJade,
                shape: BoxShape.circle,
                border: Border.all(color: _pbDeepTeal, width: 1.5),
              ),
            ),
          ),
          // Touch label
          const Positioned(
            left: 24,
            top: 76,
            child: Text('touchOffset\n= Offset(10, 80)',
                style: TextStyle(color: _pbJade, fontSize: 10, fontWeight: FontWeight.w600)),
          ),
          // Arrow showing drag direction
          Positioned(
            left: 14,
            top: 70,
            child: CustomPaint(
              size: const Size(100, 30),
              painter: _DragArrowPainter(),
            ),
          ),
          // Progress annotation
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _pbMedTeal.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('progress: 0.35',
                  style: TextStyle(color: _pbWhite, fontSize: 10, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    ),
    _pbDivider(),
    _pbLabel('Coordinate Details'),
    _pbInfoRow('Origin', 'Top-left corner of the screen (0, 0)'),
    _pbInfoRow('Units', 'Logical pixels (dp), not physical pixels'),
    _pbInfoRow('X range', '0 → screen width in logical pixels'),
    _pbInfoRow('Y range', '0 → screen height in logical pixels'),
    _pbInfoRow('Update rate', 'Every frame during the gesture (~60/120 Hz)'),
    _pbDivider(),
    _pbBody(
      'The touchOffset can be used for custom parallax effects, where '
      'different layers of the UI respond differently to the finger position.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 8 — Gesture Phases
// ═══════════════════════════════════════════════════════════════
Widget _buildGesturePhases() {
  print('[Section 8] Back gesture phases');

  Widget phase(int num, String name, String desc, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, size: 18, color: _pbWhite),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Phase $num: $name',
                    style: TextStyle(
                        color: color, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(color: _pbGray, fontSize: 11.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _pbSection('Gesture Phases', [
    _pbBody(
      'A predictive back gesture has distinct phases. Flutter receives '
      'PredictiveBackEvent callbacks during the active phase:',
    ),
    _pbDivider(),
    phase(1, 'Start', 'Finger touches screen edge. System recognizes back gesture intent. '
        'onBackStarted callback fires.',
        _pbLightTeal, Icons.play_arrow),
    Container(
      margin: const EdgeInsets.only(left: 18),
      height: 16,
      width: 2,
      color: _pbLightTeal,
    ),
    phase(2, 'Progress', 'Finger moves inward. PredictiveBackEvent stream fires continuously '
        'with updated progress, touchOffset, and swipeEdge.',
        _pbMedTeal, Icons.trending_flat),
    Container(
      margin: const EdgeInsets.only(left: 18),
      height: 16,
      width: 2,
      color: _pbLightTeal,
    ),
    phase(3, 'Decision Point', 'User either lifts finger (commit) or moves back to edge (cancel). '
        'This is the critical moment.',
        _pbJade, Icons.fork_right),
    Container(
      margin: const EdgeInsets.only(left: 18),
      height: 16,
      width: 2,
      color: _pbLightTeal,
    ),
    // Branch
    Row(
      children: [
        const SizedBox(width: 30),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF43A047).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF43A047).withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.check_circle, size: 20, color: Color(0xFF43A047)),
                const SizedBox(height: 4),
                const Text('Commit',
                    style: TextStyle(
                        color: Color(0xFF43A047),
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const Text('onBackInvoked fires\nBack action executes',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _pbGray, fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _pbAccentRed.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _pbAccentRed.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.cancel, size: 20, color: _pbAccentRed),
                const SizedBox(height: 4),
                const Text('Cancel',
                    style: TextStyle(
                        color: _pbAccentRed,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const Text('onBackCancelled fires\nApp returns to normal',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _pbGray, fontSize: 10)),
              ],
            ),
          ),
        ),
      ],
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 9 — PopScope Integration
// ═══════════════════════════════════════════════════════════════
Widget _buildPopScopeIntegration() {
  print('[Section 9] PopScope and route navigator integration');
  return _pbSection('PopScope & Navigator Integration', [
    _pbBody(
      'Flutter integrates predictive back with its navigation system through '
      'PopScope (replacing WillPopScope) and the Navigator:',
    ),
    _pbDivider(),
    _pbLabel('PopScope Widget'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _pbMint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pbBody('PopScope('),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _pbBody('canPop: false,  // prevents immediate pop'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _pbBody('onPopInvokedWithResult: (didPop, result) {'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: _pbBody('if (!didPop) {'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: _pbBody('// Show confirmation dialog'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: _pbBody('}'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _pbBody('},'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _pbBody('child: MyPage(),'),
          ),
          _pbBody(')'),
        ],
      ),
    ),
    _pbDivider(),
    _pbLabel('How PopScope Affects Predictive Back'),
    _pbInfoRow('canPop: true', 'System shows predictive back preview normally'),
    _pbInfoRow('canPop: false', 'System animation is suppressed; app handles back'),
    _pbInfoRow('Dynamic canPop', 'Can change based on form state, unsaved changes, etc.'),
    _pbDivider(),
    _pbBody(
      'When canPop is false, the PredictiveBackEvent stream still fires, '
      'but the system won\'t show a back-to-home preview. The app is '
      'expected to handle the gesture itself (e.g., show a "discard changes?" dialog).',
    ),
    _pbDivider(),
    _pbLabel('Navigator Route Stack'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _pbMint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildRouteStackItem('Route C (current)', _pbJade, true),
          _buildRouteStackItem('Route B', _pbMedTeal, false),
          _buildRouteStackItem('Route A (root)', _pbLightTeal, false),
        ],
      ),
    ),
    _pbBody(
      'When predictive back is active on Route C, the system peeks '
      'Route B behind it. If Route C is the only route, the system '
      'shows the home screen launcher preview.',
    ),
  ]);
}

Widget _buildRouteStackItem(String label, Color color, bool isCurrent) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: isCurrent ? 0.15 : 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color, width: isCurrent ? 2 : 1),
    ),
    child: Row(
      children: [
        Icon(isCurrent ? Icons.visibility : Icons.visibility_off,
            size: 14, color: color),
        const SizedBox(width: 8),
        Text(label,
            style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500)),
        if (isCurrent) ...[
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('TOP',
                style: TextStyle(
                    color: _pbWhite, fontSize: 9, fontWeight: FontWeight.w700)),
          ),
        ],
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 10 — Animation Demo
// ═══════════════════════════════════════════════════════════════
Widget _buildAnimationDemo() {
  print('[Section 10] Simulated predictive back animation');
  return _pbSection('Simulated Predictive Back Animation', [
    _pbBody(
      'Below is a visual simulation showing four stages of a predictive '
      'back gesture, from start to commit:',
    ),
    _pbDivider(),
    SizedBox(
      height: 180,
      child: Row(
        children: [
          _buildAnimStage('Start', 0.0),
          const SizedBox(width: 4),
          _buildAnimStage('Dragging', 0.25),
          const SizedBox(width: 4),
          _buildAnimStage('Threshold', 0.5),
          const SizedBox(width: 4),
          _buildAnimStage('Commit', 1.0),
        ],
      ),
    ),
    _pbDivider(),
    _pbLabel('Animation Properties Mapped to Progress'),
    _pbInfoRow('Scale', '1.0 → 0.85 (shrinks the app)'),
    _pbInfoRow('Corner radius', '0 → 16dp (rounds the corners)'),
    _pbInfoRow('Opacity', '1.0 → 0.7 (fades slightly)'),
    _pbInfoRow('X translation', '0 → ±48dp (shifts toward swipe edge)'),
    _pbInfoRow('Y translation', '0 → 8dp (slight downward shift)'),
    _pbDivider(),
    _pbBody(
      'These are the default system animations. Apps can override them with '
      'custom animations by listening to the PredictiveBackEvent stream '
      'and applying their own transforms.',
    ),
  ]);
}

Widget _buildAnimStage(String label, double progress) {
  final scale = 1.0 - (progress * 0.15);
  final cornerRadius = progress * 12;
  final xShift = progress * 12;

  return Expanded(
    child: Column(
      children: [
        Text(label,
            style: const TextStyle(
                color: _pbDeepTeal, fontSize: 10, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _pbDarkGray.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _pbLightTeal),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Destination preview behind
                if (progress > 0)
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _pbLightTeal.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Icon(Icons.home, size: 16,
                            color: _pbMedTeal.withValues(alpha: progress)),
                      ),
                    ),
                  ),
                // Current app
                Transform.translate(
                  offset: Offset(xShift, 0),
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 40,
                      height: 70,
                      decoration: BoxDecoration(
                        color: _pbJade.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(cornerRadius.clamp(2.0, 12.0)),
                        boxShadow: [
                          BoxShadow(
                            color: _pbDarkGray.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.article, size: 14, color: _pbWhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text('p=${progress.toStringAsFixed(1)}',
            style: const TextStyle(color: _pbGray, fontSize: 9)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 11 — Platform Comparison
// ═══════════════════════════════════════════════════════════════
Widget _buildPlatformComparison() {
  print('[Section 11] Platform comparison');

  Widget platCard(String name, IconData icon, Color color, List<String> points) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Text(name,
                style: TextStyle(
                    color: color, fontSize: 14, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 8),
          ...points.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: color, fontSize: 12)),
                    Expanded(
                      child: Text(p,
                          style: const TextStyle(color: _pbGray, fontSize: 11.5)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  return _pbSection('Platform Comparison', [
    _pbBody(
      'Back navigation and predictive gestures differ significantly '
      'across platforms:',
    ),
    _pbDivider(),
    platCard('Android 14+', Icons.android, _pbJade, [
      'Full PredictiveBackEvent API with progress, touchOffset, swipeEdge',
      'System provides back-to-home and back-to-previous previews',
      'Apps can implement custom back animations',
      'PopScope replaces WillPopScope for compatibility',
    ]),
    platCard('iOS', Icons.phone_iphone, _pbMedTeal, [
      'Swipe-from-left-edge pop gesture (since iOS 7)',
      'UINavigationController provides built-in interactive transition',
      'No explicit event data class — handled by UIKit gesture recognizer',
      'CupertinoPageRoute supports iOS-style back swipe natively',
    ]),
    platCard('Web', Icons.public, const Color(0xFF1565C0), [
      'Browser back button / keyboard shortcut',
      'No gesture-based back with preview',
      'Router/Navigator handles popstate events',
      'History API manages back/forward navigation',
    ]),
    platCard('Desktop', Icons.desktop_windows, _pbGray, [
      'No gesture back navigation (keyboard/mouse only)',
      'Alt+Left or Backspace may trigger back in some apps',
      'No predictive back concept',
      'PopScope still works for preventing accidental back',
    ]),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 12 — Summary
// ═══════════════════════════════════════════════════════════════
Widget _buildSummary() {
  print('[Section 12] Summary');
  print('PredictiveBackEvent deep demo complete.');
  return _pbSection('Summary', [
    _pbBody(
      'PredictiveBackEvent is the data carrier for Android 14+\'s predictive '
      'back gesture system. It enables apps to show users a real-time preview '
      'of where the back gesture will take them.',
    ),
    _pbDivider(),
    _pbLabel('Key Takeaways'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _pbJade.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pbBody('✦ Android 14+ API for back gesture preview data'),
          _pbBody('✦ Fields: progress (0→1), touchOffset, swipeEdge'),
          _pbBody('✦ Integrates with PopScope (replaces WillPopScope)'),
          _pbBody('✦ Enables custom back-navigation animations'),
          _pbBody('✦ Four gesture phases: start → progress → decision → commit/cancel'),
          _pbBody('✦ Works with Navigator route stack for automated previews'),
          _pbBody('✦ Required for apps targeting Android SDK 35+'),
          _pbBody('✦ No equivalent on iOS (uses UIKit interactive transitions instead)'),
        ],
      ),
    ),
    _pbDivider(),
    Wrap(
      children: [
        _pbChip('PredictiveBackEvent', _pbJade),
        _pbChip('Android 14+', _pbDeepTeal),
        _pbChip('PopScope', _pbMedTeal),
        _pbChip('SwipeEdge', _pbAccentAmber),
        _pbChip('Gesture Preview', _pbAccentRed),
      ],
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Custom painters
// ═══════════════════════════════════════════════════════════════
class _CoordGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _pbLightTeal.withValues(alpha: 0.4)
      ..strokeWidth = 0.5;

    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DragArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _pbJade.withValues(alpha: 0.5)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);

    // Arrowhead
    final arrowPaint = Paint()
      ..color = _pbJade.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;
    final arrowPath = Path()
      ..moveTo(size.width - 8, size.height / 2 - 4)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - 8, size.height / 2 + 4)
      ..close();
    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
