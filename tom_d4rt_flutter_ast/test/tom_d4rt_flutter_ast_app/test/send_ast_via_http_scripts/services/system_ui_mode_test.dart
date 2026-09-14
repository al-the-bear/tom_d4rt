// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Visual deep demo of the Flutter SystemUiMode enum.
//
// This script renders a static, hand-authored visual catalogue describing
// what each SystemUiMode value does, when to use it, and how Android and
// iOS treat the system chrome differently. No SystemChrome APIs are
// actually called -- the device frames here are purely illustrative.
//
// SystemUiMode values (from package:flutter/services.dart):
//   * leanBack         - chrome hidden, any tap re-shows it (sticky-off)
//   * immersive        - chrome hidden, edge swipe re-shows it
//   * immersiveSticky  - chrome hidden, edge swipe peeks then hides again
//   * edgeToEdge       - app draws under the chrome (transparent overlays)
//   * manual           - developer specifies which overlays are visible
//
// Reference enum location is bridges file
//   tom_d4rt_flutter_ast/lib/src/bridges/services_bridges.b.dart
// where the BridgedEnumDefinition for SystemUiMode is registered for the
// d4rt interpreter.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('SystemUiMode Deep Demo executing');
  print('Enum values count: ${SystemUiMode.values.length}');
  for (final mode in SystemUiMode.values) {
    print('  SystemUiMode.${mode.name} (index=${mode.index})');
  }
  print('NOTE: this demo never calls SystemChrome.setEnabledSystemUIMode');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');

  final hero = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0F2027),
          Color(0xFF203A43),
          Color(0xFF2C5364),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Color(0xFF2C5364).withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
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
                gradient: LinearGradient(
                  colors: [Colors.cyanAccent, Colors.tealAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: 0.5),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.smartphone,
                size: 40.0,
                color: Color(0xFF0F2027),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SystemUiMode',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'How your Flutter app shares the screen with system chrome',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.cyanAccent.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  size: 16.0, color: Colors.cyanAccent),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Set with: SystemChrome.setEnabledSystemUIMode(SystemUiMode.x)',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            for (final mode in SystemUiMode.values)
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.tealAccent.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  mode.name,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.tealAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of system UI cross-section
  // ============================================================
  print('=== Section 2: Anatomy cross-section ===');

  final anatomy = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.18),
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
            Icon(Icons.architecture, color: Colors.orange.shade800),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a phone screen',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Cross-section diagram of a stylised phone.
        Center(
          child: Container(
            width: 260.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(28.0),
              border: Border.all(color: Colors.grey.shade800, width: 4.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 14.0,
                  offset: Offset(0.0, 8.0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Status bar zone
                _labelledZone(
                  'STATUS BAR',
                  Color(0xFF263238),
                  '08:42  •  battery / wifi / time',
                  height: 26.0,
                ),
                // App canvas zone
                Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF1565C0),
                        Color(0xFF0D47A1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'YOUR FLUTTER APP\n(canvas)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                // Navigation bar zone
                _labelledZone(
                  'NAV BAR',
                  Color(0xFF37474F),
                  'back  •  home  •  recents',
                  height: 26.0,
                ),
                // Gesture handle
                _labelledZone(
                  'GESTURE HANDLE',
                  Color(0xFF455A64),
                  'thin pill on iOS / modern Android',
                  height: 18.0,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bulletLine(
                'Top overlay',
                'SystemUiOverlay.top -- the status bar.',
                Icons.vertical_align_top,
                Colors.deepOrange,
              ),
              _bulletLine(
                'Bottom overlay',
                'SystemUiOverlay.bottom -- nav bar / gesture pill.',
                Icons.vertical_align_bottom,
                Colors.indigo,
              ),
              _bulletLine(
                'Cutouts',
                'Notch / camera holes are part of the safe area.',
                Icons.crop_square,
                Colors.brown,
              ),
              _bulletLine(
                'Gestures',
                'Swipe-from-edge interactions can re-reveal hidden chrome.',
                Icons.swipe,
                Colors.teal,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  final modeCards = <Widget>[];

  modeCards.add(_buildModeCard(
    mode: SystemUiMode.leanBack,
    title: 'leanBack',
    accent: Color(0xFF7E57C2),
    secondary: Color(0xFFB39DDB),
    icon: Icons.weekend,
    behaviour:
        'Hides both status bar and navigation bar. ANY tap anywhere on '
        'the screen restores them; you cannot dismiss them again without '
        'switching modes.',
    gesture:
        'Single tap (anywhere) -> chrome returns. The first tap is consumed '
        'by the system, so your app does not receive that touch event.',
    useCase:
        'Passive viewing where the user is not expected to interact much: '
        'kiosk slideshows, ambient dashboards, idle screensavers.',
    statusVisible: false,
    navVisible: false,
    chromeStripe: 'TAP ANYWHERE -> CHROME REAPPEARS',
  ));

  modeCards.add(_buildModeCard(
    mode: SystemUiMode.immersive,
    title: 'immersive',
    accent: Color(0xFF26A69A),
    secondary: Color(0xFF80CBC4),
    icon: Icons.fullscreen,
    behaviour:
        'Hides status and nav bars. To reveal them again the user must '
        'swipe from a screen edge. The chrome stays visible until the '
        'user taps somewhere else or after a short timeout.',
    gesture:
        'Swipe from top edge -> status bar. Swipe from bottom edge -> '
        'navigation bar. The first interaction reveals chrome but does '
        'not pass to the app.',
    useCase:
        'Reading apps, comic viewers, photo galleries: cases where the '
        'user benefits from full screen but occasionally needs system '
        'controls.',
    statusVisible: false,
    navVisible: false,
    chromeStripe: 'SWIPE FROM EDGE -> CHROME PEEKS IN',
  ));

  modeCards.add(_buildModeCard(
    mode: SystemUiMode.immersiveSticky,
    title: 'immersiveSticky',
    accent: Color(0xFFEF5350),
    secondary: Color(0xFFFFAB91),
    icon: Icons.layers_clear,
    behaviour:
        'Like immersive, but a swipe-from-edge briefly shows a '
        'semi-transparent overlay that fades back automatically. The '
        'app keeps receiving touch events the whole time.',
    gesture:
        'Swipe from edge -> chrome flashes in semi-transparently, then '
        'auto-hides. Useful when input must not be interrupted by an '
        'accidental edge swipe.',
    useCase:
        'Games, drawing apps, video editors: anything where the user '
        'is constantly touching near the edges and you do not want the '
        'system bars to steal focus.',
    statusVisible: false,
    navVisible: false,
    chromeStripe: 'SWIPE -> CHROME PEEKS, THEN AUTO-HIDES',
  ));

  modeCards.add(_buildModeCard(
    mode: SystemUiMode.edgeToEdge,
    title: 'edgeToEdge',
    accent: Color(0xFF42A5F5),
    secondary: Color(0xFF90CAF9),
    icon: Icons.aspect_ratio,
    behaviour:
        'Status bar AND nav bar remain visible but become transparent '
        '(or translucent), and your app draws underneath them. You are '
        'responsible for using SafeArea / MediaQuery padding so content '
        'is not occluded.',
    gesture:
        'Normal system gestures still work. Critically, Android 15+ '
        'enforces edgeToEdge by default for apps targeting SDK 35.',
    useCase:
        'Modern Material 3 / iOS-style designs, hero images that bleed '
        'to the edges, immersive map screens with translucent app bars.',
    statusVisible: true,
    navVisible: true,
    chromeStripe: 'CHROME TRANSPARENT -- APP DRAWS UNDER',
  ));

  modeCards.add(_buildModeCard(
    mode: SystemUiMode.manual,
    title: 'manual',
    accent: Color(0xFFFFB300),
    secondary: Color(0xFFFFE082),
    icon: Icons.tune,
    behaviour:
        'Caller specifies precisely which overlays should be visible '
        'via the `overlays` parameter (a List<SystemUiOverlay>). Useful '
        'when you want, for example, only the status bar visible.',
    gesture:
        'No automatic show/hide. The user can still pull down the system '
        'shade as the OS allows.',
    useCase:
        'Specialised dashboards or media controls where you want fine '
        'control: hide nav bar but keep clock visible during a video.',
    statusVisible: true,
    navVisible: false,
    chromeStripe: 'EXACTLY THE OVERLAYS YOU LISTED',
  ));

  // ============================================================
  // SECTION 4: Side-by-side comparison panel
  // ============================================================
  print('=== Section 4: Side-by-side comparison ===');

  final comparison = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare, color: Colors.blue.shade900),
            SizedBox(width: 8.0),
            Text(
              'Side-by-side comparison',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Five mock device frames stacked vertically, each in its own '
          'SystemUiMode. Imagine the same app being launched in each.',
          style: TextStyle(fontSize: 12.0, color: Colors.blue.shade800),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          alignment: WrapAlignment.center,
          children: [
            _miniFrame('leanBack', Color(0xFF7E57C2),
                statusVisible: false, navVisible: false),
            _miniFrame('immersive', Color(0xFF26A69A),
                statusVisible: false, navVisible: false),
            _miniFrame('immersiveSticky', Color(0xFFEF5350),
                statusVisible: false, navVisible: false, sticky: true),
            _miniFrame('edgeToEdge', Color(0xFF42A5F5),
                statusVisible: true, navVisible: true, transparent: true),
            _miniFrame('manual', Color(0xFFFFB300),
                statusVisible: true, navVisible: false),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Visible chrome is shown solid; hidden chrome is shown as a '
            'dashed silhouette; transparent chrome (edgeToEdge) is '
            'overlaid in faint white.',
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.blue.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Recipes -- real-world use cases
  // ============================================================
  print('=== Section 5: Real-world recipes ===');

  final recipes = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF1F8E9), Color(0xFFC5E1A5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.lightGreen.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.lightGreen.withValues(alpha: 0.25),
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
            Icon(Icons.restaurant_menu, color: Colors.green.shade900),
            SizedBox(width: 8.0),
            Text(
              'Recipes: which mode for which feature?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recipeCard(
          icon: Icons.movie,
          colour: Colors.deepPurple,
          scenario: 'Video player in landscape',
          recommended: 'SystemUiMode.immersiveSticky',
          reasoning:
              'Users tap to play/pause and slide a scrubber near the '
              'screen edges. Sticky immersive prevents accidental edge '
              'swipes from popping up the navigation bar over the film.',
          alternative:
              'Fall back to immersive if you want explicit chrome reveal.',
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          icon: Icons.brush,
          colour: Colors.pink,
          scenario: 'Drawing / sketching app',
          recommended: 'SystemUiMode.immersiveSticky',
          reasoning:
              'A pen stroke must never be interrupted. Sticky immersive '
              'gives the user feedback that chrome is reachable, but '
              'auto-hides it so the next stroke does not get eaten.',
          alternative:
              'Use manual with no overlays during the stroke and reveal '
              'on undo/redo.',
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          icon: Icons.photo,
          colour: Colors.indigo,
          scenario: 'Photo viewer / gallery detail',
          recommended: 'SystemUiMode.edgeToEdge',
          reasoning:
              'You want hero images to fill the entire screen including '
              'beneath the status bar -- but the user still needs the '
              'clock and nav bar. Use SafeArea around captions and '
              'controls.',
          alternative:
              'leanBack for a slideshow that should reveal chrome on '
              'casual tap.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Edge-to-edge guidance
  // ============================================================
  print('=== Section 6: Edge-to-edge guidance ===');

  final edgeGuidance = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.pink.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.pink.shade900),
            SizedBox(width: 8.0),
            Text(
              'Edge-to-edge guidance',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _calloutPoint(
          'Always wrap interactive content in SafeArea',
          'Without it your buttons can land under the camera notch or '
          'behind the gesture pill. SafeArea consults MediaQuery and '
          'applies padding equal to the unsafe insets.',
          Icons.shield,
          Colors.pink.shade700,
        ),
        _calloutPoint(
          'Notch / cutout handling',
          'Use MediaQuery.of(context).padding.top to align AppBars '
          'manually if you cannot use SafeArea. iOS Dynamic Island and '
          'Android camera holes are reported here.',
          Icons.electrical_services,
          Colors.pink.shade700,
        ),
        _calloutPoint(
          'Background colour matters',
          'A transparent status bar shows whatever your app draws under '
          'it, including gradients. Pick colours that contrast with '
          'system icons to stay readable.',
          Icons.format_color_fill,
          Colors.pink.shade700,
        ),
        _calloutPoint(
          'Android 15+ default',
          'Apps targeting Android SDK 35+ are forced edge-to-edge '
          'whether you opt in or not. Plan SafeArea coverage.',
          Icons.android,
          Colors.pink.shade700,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Pitfalls
  // ============================================================
  print('=== Section 7: Pitfalls ===');

  final pitfalls = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dangerous, color: Colors.red.shade900),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls and gotchas',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallRow(
          'leanBack steals first tap',
          'Users may tap a button that does nothing because the tap '
          'was consumed re-showing system chrome. Avoid leanBack on '
          'highly-interactive screens.',
        ),
        _pitfallRow(
          'iOS does not honour leanBack / immersive',
          'These modes are no-ops on iOS. Use a layout-driven approach '
          '(prefersStatusBarHidden) for cross-platform full-screen.',
        ),
        _pitfallRow(
          'manual without overlays = both hidden',
          'Calling setEnabledSystemUIMode(SystemUiMode.manual) with an '
          'empty overlay list is the same as immersive. Always pass '
          'overlays explicitly when using manual.',
        ),
        _pitfallRow(
          'Forgetting to restore on exit',
          'Always restore SystemUiMode.edgeToEdge (or your default) '
          'when leaving an immersive screen, otherwise other parts of '
          'the app inherit the immersive state.',
        ),
        _pitfallRow(
          'Letterboxing on edgeToEdge',
          'If you do not paint behind the chrome (e.g. solid colour '
          'AppBar), edgeToEdge looks the same as opaque chrome -- '
          'extend Scaffold.body under the AppBar with extendBodyBehindAppBar.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Behaviour matrix
  // ============================================================
  print('=== Section 8: Behaviour matrix ===');

  final matrix = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepPurple.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Behaviour matrix (Android focus)',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Row(
            children: [
              _matrixHeader('Mode', 110.0),
              _matrixHeader('Status', 60.0),
              _matrixHeader('Nav', 60.0),
              _matrixHeader('Reveal', 100.0),
              _matrixHeader('iOS?', 60.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _matrixRow('leanBack', false, false, 'tap anywhere', 'no'),
        _matrixRow('immersive', false, false, 'edge swipe', 'partial'),
        _matrixRow('immersiveSticky', false, false, 'edge swipe peek',
            'partial'),
        _matrixRow('edgeToEdge', true, true, 'always visible', 'yes'),
        _matrixRow('manual', true, false, 'developer-driven', 'yes'),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footer
  // ============================================================
  print('=== Section 9: Footer ===');

  final footer = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1B1B1B), Color(0xFF2E2E2E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
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
        Text(
          'File reference',
          style: TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '+----------------------------------------------------------+\n'
          '|  test/.../services/system_ui_mode_test.dart              |\n'
          '|  - Subject: SystemUiMode (package:flutter/services.dart) |\n'
          '|  - Bridge:  lib/src/bridges/services_bridges.b.dart      |\n'
          '|  - Static visual catalogue, no SystemChrome calls.       |\n'
          '+----------------------------------------------------------+',
          style: TextStyle(
            color: Colors.greenAccent,
            fontFamily: 'monospace',
            fontSize: 11.0,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Reminder: this script never invokes '
          'SystemChrome.setEnabledSystemUIMode -- the device frames are '
          'illustrative only.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  print('SystemUiMode Deep Demo completed successfully');

  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        _sectionHeader('1. Anatomy of system UI', Icons.architecture,
            Colors.orange.shade800),
        anatomy,
        _sectionHeader('2. Per-value catalogue', Icons.collections_bookmark,
            Colors.deepPurple.shade700),
        ...modeCards,
        _sectionHeader('3. Side-by-side comparison', Icons.compare,
            Colors.blue.shade800),
        comparison,
        _sectionHeader('4. Recipes', Icons.menu_book,
            Colors.green.shade800),
        recipes,
        _sectionHeader('5. Edge-to-edge guidance', Icons.warning,
            Colors.pink.shade800),
        edgeGuidance,
        _sectionHeader('6. Pitfalls', Icons.report_problem,
            Colors.red.shade800),
        pitfalls,
        _sectionHeader('7. Behaviour matrix', Icons.grid_on,
            Colors.deepPurple.shade800),
        matrix,
        footer,
      ],
    ),
  );
}

// ------------------------------------------------------------
// Helpers
// ------------------------------------------------------------

Widget _sectionHeader(String text, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 6.0),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _labelledZone(
  String label,
  Color colour,
  String detail, {
  required double height,
}) {
  return Container(
    height: height,
    color: colour,
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            detail,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 9.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bulletLine(
  String label,
  String body,
  IconData icon,
  Color colour,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: colour, size: 16.0),
        SizedBox(width: 8.0),
        SizedBox(
          width: 92.0,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colour,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          child: Text(
            body,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.brown.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildModeCard({
  required SystemUiMode mode,
  required String title,
  required Color accent,
  required Color secondary,
  required IconData icon,
  required String behaviour,
  required String gesture,
  required String useCase,
  required bool statusVisible,
  required bool navVisible,
  required String chromeStripe,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          secondary.withValues(alpha: 0.25),
          accent.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.22),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: secondary.withValues(alpha: 0.18),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.45),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 26.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SystemUiMode.$title',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                  ),
                  Text(
                    'index ${mode.index} -- value ${mode.toString()}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: accent),
              ),
              child: Text(
                statusVisible && navVisible
                    ? 'CHROME ON'
                    : (!statusVisible && !navVisible
                        ? 'CHROME OFF'
                        : 'PARTIAL'),
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Body: device mock + descriptive blocks
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mockDevice(
              accent: accent,
              statusVisible: statusVisible,
              navVisible: navVisible,
              transparent: title == 'edgeToEdge',
              sticky: title == 'immersiveSticky',
              caption: title.toUpperCase(),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoBlock(
                    'Behaviour',
                    behaviour,
                    Icons.settings_input_component,
                    accent,
                  ),
                  SizedBox(height: 8.0),
                  _infoBlock(
                    'Gestures',
                    gesture,
                    Icons.swipe,
                    accent,
                  ),
                  SizedBox(height: 8.0),
                  _infoBlock(
                    'Recommended use',
                    useCase,
                    Icons.lightbulb,
                    accent,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Stripe
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              chromeStripe,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
                fontSize: 11.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _mockDevice({
  required Color accent,
  required bool statusVisible,
  required bool navVisible,
  bool transparent = false,
  bool sticky = false,
  required String caption,
}) {
  return Container(
    width: 130.0,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.grey.shade800, width: 3.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(17.0),
      child: Column(
        children: [
          // Status bar
          _chromeStrip(
            visible: statusVisible,
            transparent: transparent,
            label: 'STATUS',
            colour: Color(0xFF263238),
            height: 16.0,
          ),
          // App canvas
          Container(
            height: 120.0,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accent.withValues(alpha: 0.85), accent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.apps, color: Colors.white70, size: 28.0),
                    SizedBox(height: 4.0),
                    Text(
                      caption,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                    if (sticky) ...[
                      SizedBox(height: 4.0),
                      Text(
                        'sticky overlay',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 8.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          // Nav bar
          _chromeStrip(
            visible: navVisible,
            transparent: transparent,
            label: 'NAV',
            colour: Color(0xFF37474F),
            height: 16.0,
          ),
          // Gesture handle row
          Container(
            height: 8.0,
            width: double.infinity,
            color: Colors.black,
            alignment: Alignment.center,
            child: Container(
              width: 36.0,
              height: 3.0,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _chromeStrip({
  required bool visible,
  required bool transparent,
  required String label,
  required Color colour,
  required double height,
}) {
  if (visible && !transparent) {
    return Container(
      height: height,
      width: double.infinity,
      color: colour,
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 8.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
  if (visible && transparent) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        border: Border(
          bottom: BorderSide(color: Colors.white24, width: 1.0),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '$label (transparent)',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 8.0,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
  // hidden
  return Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border(
        bottom: BorderSide(
          color: Colors.white24,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      '$label hidden',
      style: TextStyle(
        color: Colors.white24,
        fontSize: 8.0,
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.lineThrough,
      ),
    ),
  );
}

Widget _infoBlock(
  String title,
  String body,
  IconData icon,
  Color accent,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14.0, color: accent),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: accent,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _miniFrame(
  String label,
  Color accent, {
  required bool statusVisible,
  required bool navVisible,
  bool transparent = false,
  bool sticky = false,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _mockDevice(
        accent: accent,
        statusVisible: statusVisible,
        navVisible: navVisible,
        transparent: transparent,
        sticky: sticky,
        caption: label.toUpperCase(),
      ),
      SizedBox(height: 6.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
      ),
    ],
  );
}

Widget _recipeCard({
  required IconData icon,
  required Color colour,
  required String scenario,
  required String recommended,
  required String reasoning,
  required String alternative,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: colour.withValues(alpha: 0.5), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: colour.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: colour,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, size: 18.0, color: Colors.white),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                scenario,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: colour,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: colour.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Recommended: $recommended',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: colour,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          reasoning,
          style: TextStyle(fontSize: 12.0, color: Colors.black87),
        ),
        SizedBox(height: 4.0),
        Text(
          'Alt: $alternative',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _calloutPoint(
  String title,
  String body,
  IconData icon,
  Color colour,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: colour.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, size: 14.0, color: colour),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: colour,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallRow(String title, String body) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.error, color: Colors.red.shade700, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.red.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _matrixHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.deepPurple.shade900,
      ),
    ),
  );
}

Widget _matrixRow(
  String mode,
  bool status,
  bool nav,
  String reveal,
  String ios,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2.0),
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            mode,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800,
            ),
          ),
        ),
        SizedBox(
          width: 60.0,
          child: Center(
            child: Icon(
              status ? Icons.check_circle : Icons.cancel,
              color: status ? Colors.green : Colors.red.shade300,
              size: 16.0,
            ),
          ),
        ),
        SizedBox(
          width: 60.0,
          child: Center(
            child: Icon(
              nav ? Icons.check_circle : Icons.cancel,
              color: nav ? Colors.green : Colors.red.shade300,
              size: 16.0,
            ),
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Text(
            reveal,
            style: TextStyle(fontSize: 10.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 60.0,
          child: Text(
            ios,
            style: TextStyle(fontSize: 10.0, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
