// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of CupertinoPageRoute<T> and adjacent
// iOS routing primitives — horizontal slide, parallax, swipe-back gesture,
// fullscreenDialog vertical variant, buildPage/buildTransitions protocol.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ============================================================================
// PALETTE — canonical iOS system colors
// ============================================================================
const Color kIosBlue = Color(0xFF007AFF);
const Color kIosGreen = Color(0xFF34C759);
const Color kIosRed = Color(0xFFFF3B30);
const Color kIosOrange = Color(0xFFFF9500);
const Color kIosYellow = Color(0xFFFFCC00);
const Color kIosPurple = Color(0xFFAF52DE);
const Color kIosPink = Color(0xFFFF2D55);
const Color kIosTeal = Color(0xFF5AC8FA);
const Color kIosIndigo = Color(0xFF5856D6);

const Color kSysGray = Color(0xFF8E8E93);
const Color kSysGray2 = Color(0xFFAEAEB2);
const Color kSysGray3 = Color(0xFFC7C7CC);
const Color kSysGray4 = Color(0xFFD1D1D6);
const Color kSysGray5 = Color(0xFFE5E5EA);
const Color kSysGray6 = Color(0xFFF2F2F7);

const Color kHairline = Color(0xFFC6C6C8);
const Color kInkPrimary = Color(0xFF1C1C1E);
const Color kInkSecondary = Color(0xFF3C3C43);
const Color kPanelBg = Color(0xFFFFFFFF);
const Color kPageBg = Color(0xFFF2F2F7);

// ============================================================================
// MINI iPHONE FRAME — nested containers shaped like an iPhone with a notch
// ============================================================================
Widget miniPhone({
  required Widget screen,
  double width = 180,
  double height = 360,
  String? label,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: Color(0xFF2C2C2E), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              Positioned.fill(child: screen),
              // Notch
              Positioned(
                top: 0,
                left: width * 0.25,
                right: width * 0.25,
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              // Home indicator
              Positioned(
                bottom: 6,
                left: width * 0.35,
                right: width * 0.35,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xFF8E8E93),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      if (label != null) ...[
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: kInkSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ],
  );
}

// ============================================================================
// IOS-STYLE STATUS BAR + NAV BAR
// ============================================================================
Widget iosStatusBar() {
  return Container(
    height: 22,
    padding: EdgeInsets.symmetric(horizontal: 14),
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '9:41',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: kInkPrimary,
          ),
        ),
        Row(
          children: [
            Icon(CupertinoIcons.wifi, size: 10, color: kInkPrimary),
            SizedBox(width: 4),
            Container(
              width: 16,
              height: 8,
              decoration: BoxDecoration(
                border: Border.all(color: kInkPrimary, width: 0.8),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Container(color: kInkPrimary),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget iosNavBar({String? title, bool showBack = false, String backTitle = 'Back'}) {
  return Container(
    height: 36,
    padding: EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(color: kHairline, width: 0.5)),
    ),
    child: Row(
      children: [
        if (showBack)
          Row(
            children: [
              Icon(CupertinoIcons.chevron_left, size: 14, color: kIosBlue),
              Text(
                backTitle,
                style: TextStyle(fontSize: 11, color: kIosBlue),
              ),
            ],
          )
        else
          SizedBox(width: 40),
        Expanded(
          child: Center(
            child: Text(
              title ?? '',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: kInkPrimary,
              ),
            ),
          ),
        ),
        SizedBox(width: 40),
      ],
    ),
  );
}

// ============================================================================
// IOS PAGE CONTENT — a fake screen body with cells
// ============================================================================
Widget iosPageBody({required Color tint, required String name, required IconData icon}) {
  return Container(
    color: kPageBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 12),
        Center(
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: kInkPrimary,
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _miniCell('Profile', CupertinoIcons.person_fill, kIosBlue),
              Divider(height: 0.5, color: kHairline, indent: 32),
              _miniCell('Settings', CupertinoIcons.gear_solid, kSysGray),
              Divider(height: 0.5, color: kHairline, indent: 32),
              _miniCell('Notifications', CupertinoIcons.bell_fill, kIosRed),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _miniCell(String label, IconData icon, Color tint) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, size: 11, color: Colors.white),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 10, color: kInkPrimary),
          ),
        ),
        Icon(CupertinoIcons.chevron_right, size: 10, color: kSysGray2),
      ],
    ),
  );
}

// ============================================================================
// SECTION HEADER
// ============================================================================
Widget sectionHeader(String number, String title, String subtitle) {
  return Container(
    margin: EdgeInsets.only(top: 32, bottom: 12),
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kHairline, width: 0.5),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kIosBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kInkPrimary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: kInkSecondary),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget panel({required String title, required Widget child, Color? tint}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kHairline, width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: (tint ?? kIosBlue).withOpacity(0.08),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            border: Border(
              bottom: BorderSide(color: kHairline, width: 0.5),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: tint ?? kIosBlue,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(14), child: child),
      ],
    ),
  );
}

Widget kv(String k, String v, {Color? valueColor}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            k,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: TextStyle(
              fontSize: 12,
              color: valueColor ?? kInkPrimary,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HORIZONTAL SLIDE SNAPSHOT — phone showing the iOS push transition at time t
// ============================================================================
Widget horizontalSlideSnapshot(double t, {String label = ''}) {
  // Outgoing page slides left and darkens (parallax). Incoming page slides in from right.
  final outgoingX = -0.3 * t; // fraction of width
  final incomingX = 1.0 - t;
  final outgoingDim = 0.4 * t;

  return miniPhone(
    label: label,
    screen: Stack(
      children: [
        // Outgoing page (parallax)
        Positioned(
          left: 168 * outgoingX,
          top: 0,
          bottom: 0,
          width: 168,
          child: Stack(
            children: [
              Column(
                children: [
                  iosStatusBar(),
                  iosNavBar(title: 'Home'),
                  Expanded(
                    child: iosPageBody(
                      tint: kIosBlue,
                      name: 'Home',
                      icon: CupertinoIcons.house_fill,
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(outgoingDim)),
              ),
            ],
          ),
        ),
        // Incoming page (sliding in)
        Positioned(
          left: 168 * incomingX,
          top: 0,
          bottom: 0,
          width: 168,
          child: Column(
            children: [
              iosStatusBar(),
              iosNavBar(title: 'Detail', showBack: true, backTitle: 'Home'),
              Expanded(
                child: iosPageBody(
                  tint: kIosPurple,
                  name: 'Detail',
                  icon: CupertinoIcons.doc_text_fill,
                ),
              ),
            ],
          ),
        ),
        // Shadow on left edge of incoming page
        Positioned(
          left: 168 * incomingX - 4,
          top: 0,
          bottom: 0,
          width: 6,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.black.withOpacity(0.18 * t),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// VERTICAL (FULLSCREEN DIALOG) SLIDE SNAPSHOT
// ============================================================================
Widget verticalSlideSnapshot(double t, {String label = ''}) {
  final incomingY = 1.0 - t;
  return miniPhone(
    label: label,
    screen: Stack(
      children: [
        // Background (presenting) page — stays put
        Column(
          children: [
            iosStatusBar(),
            iosNavBar(title: 'Home'),
            Expanded(
              child: iosPageBody(
                tint: kIosBlue,
                name: 'Home',
                icon: CupertinoIcons.house_fill,
              ),
            ),
          ],
        ),
        // Modal sliding up from bottom
        Positioned(
          left: 0,
          right: 0,
          top: 336 * incomingY,
          height: 336,
          child: Column(
            children: [
              iosStatusBar(),
              Container(
                height: 36,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: kHairline, width: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cancel',
                      style: TextStyle(fontSize: 11, color: kIosBlue),
                    ),
                    Text(
                      'New Item',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: kInkPrimary,
                      ),
                    ),
                    Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 11,
                        color: kIosBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: iosPageBody(
                  tint: kIosGreen,
                  name: 'New',
                  icon: CupertinoIcons.add_circled_solid,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// BACK-SWIPE SNAPSHOT — user drags right with finger from left edge
// ============================================================================
Widget backSwipeSnapshot(double dragFraction, {String label = '', bool showFinger = true}) {
  // dragFraction 0 = no swipe, 1 = fully dragged off-screen
  final currentX = dragFraction; // current page slides right
  final previousX = -0.3 * (1.0 - dragFraction); // previous page slides back in from parallax position

  return miniPhone(
    label: label,
    screen: Stack(
      children: [
        // Previous page (revealed)
        Positioned(
          left: 168 * previousX,
          top: 0,
          bottom: 0,
          width: 168,
          child: Column(
            children: [
              iosStatusBar(),
              iosNavBar(title: 'Home'),
              Expanded(
                child: iosPageBody(
                  tint: kIosBlue,
                  name: 'Home',
                  icon: CupertinoIcons.house_fill,
                ),
              ),
            ],
          ),
        ),
        // Current page (being dragged right)
        Positioned(
          left: 168 * currentX,
          top: 0,
          bottom: 0,
          width: 168,
          child: Column(
            children: [
              iosStatusBar(),
              iosNavBar(title: 'Detail', showBack: true, backTitle: 'Home'),
              Expanded(
                child: iosPageBody(
                  tint: kIosPurple,
                  name: 'Detail',
                  icon: CupertinoIcons.doc_text_fill,
                ),
              ),
            ],
          ),
        ),
        // Finger indicator
        if (showFinger && dragFraction > 0.0 && dragFraction < 1.0)
          Positioned(
            left: (168 * dragFraction) + 8,
            top: 160,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                border: Border.all(color: kIosBlue, width: 2),
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// BUILD FUNCTION — entry point
// ============================================================================
dynamic build(BuildContext context) {
  print('CupertinoPageRoute<T> deep visual demo executing');

  // --------------------------------------------------------------------------
  // Specimen routes — construct, probe properties
  // --------------------------------------------------------------------------
  final routeSpecimens = <Map<String, dynamic>>[];

  try {
    final r1 = CupertinoPageRoute<dynamic>(
      builder: (ctx) => Center(child: Text('Home')),
      settings: RouteSettings(name: '/home'),
      title: 'Home',
      maintainState: true,
      fullscreenDialog: false,
      allowSnapshotting: true,
    );
    routeSpecimens.add({
      'label': 'home (default push)',
      'name': r1.settings.name ?? '(null)',
      'title': r1.title ?? '(null)',
      'maintainState': r1.maintainState.toString(),
      'fullscreenDialog': r1.fullscreenDialog.toString(),
      'allowSnapshotting': r1.allowSnapshotting.toString(),
      'opaque': r1.opaque.toString(),
      'barrierDismissible': r1.barrierDismissible.toString(),
    });
  } catch (e) {
    routeSpecimens.add({'label': 'home (default push)', 'error': e.toString()});
  }

  try {
    final r2 = CupertinoPageRoute<bool>(
      builder: (ctx) => Center(child: Text('Confirm')),
      settings: RouteSettings(name: '/confirm'),
      title: 'Confirm',
      maintainState: false,
      fullscreenDialog: true,
      allowSnapshotting: false,
    );
    routeSpecimens.add({
      'label': 'confirm (fullscreenDialog, T=bool)',
      'name': r2.settings.name ?? '(null)',
      'title': r2.title ?? '(null)',
      'maintainState': r2.maintainState.toString(),
      'fullscreenDialog': r2.fullscreenDialog.toString(),
      'allowSnapshotting': r2.allowSnapshotting.toString(),
      'opaque': r2.opaque.toString(),
      'barrierDismissible': r2.barrierDismissible.toString(),
    });
  } catch (e) {
    routeSpecimens.add({'label': 'confirm (fullscreenDialog, T=bool)', 'error': e.toString()});
  }

  try {
    final r3 = CupertinoPageRoute<String>(
      builder: (ctx) => Center(child: Text('Pick')),
      title: 'Picker',
    );
    routeSpecimens.add({
      'label': 'picker (T=String)',
      'name': r3.settings.name ?? '(null)',
      'title': r3.title ?? '(null)',
      'maintainState': r3.maintainState.toString(),
      'fullscreenDialog': r3.fullscreenDialog.toString(),
      'allowSnapshotting': r3.allowSnapshotting.toString(),
      'opaque': r3.opaque.toString(),
      'barrierDismissible': r3.barrierDismissible.toString(),
    });
  } catch (e) {
    routeSpecimens.add({'label': 'picker (T=String)', 'error': e.toString()});
  }

  try {
    final r4 = CupertinoPageRoute<int>(
      builder: (ctx) => Center(child: Text('No title')),
    );
    routeSpecimens.add({
      'label': 'no-title (T=int)',
      'name': r4.settings.name ?? '(null)',
      'title': r4.title ?? '(null)',
      'maintainState': r4.maintainState.toString(),
      'fullscreenDialog': r4.fullscreenDialog.toString(),
      'allowSnapshotting': r4.allowSnapshotting.toString(),
      'opaque': r4.opaque.toString(),
      'barrierDismissible': r4.barrierDismissible.toString(),
    });
  } catch (e) {
    routeSpecimens.add({'label': 'no-title (T=int)', 'error': e.toString()});
  }

  print('Built ${routeSpecimens.length} CupertinoPageRoute specimens');

  // --------------------------------------------------------------------------
  // Build the showcase page
  // --------------------------------------------------------------------------
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: kSysGray6,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeroHeader(),
            sectionHeader(
              '01',
              'Concept Overview',
              'How CupertinoPageRoute differs from MaterialPageRoute',
            ),
            _buildConceptOverview(),
            sectionHeader(
              '02',
              'Class Hierarchy',
              'Route → OverlayRoute → TransitionRoute → ModalRoute → PageRoute → CupertinoPageRoute',
            ),
            _buildClassHierarchy(),
            sectionHeader(
              '03',
              'Constructor Anatomy',
              'Every parameter, what it controls',
            ),
            _buildConstructorAnatomy(),
            sectionHeader(
              '04',
              'Live Specimens',
              'Real CupertinoPageRoute instances with property tables',
            ),
            _buildLiveSpecimens(routeSpecimens),
            sectionHeader(
              '05',
              'Horizontal Slide Strip',
              'CupertinoPageTransition: incoming from right, outgoing parallaxes left',
            ),
            _buildHorizontalSlideStrip(),
            sectionHeader(
              '06',
              'Vertical Slide Strip (fullscreenDialog)',
              'CupertinoFullscreenDialogTransition: modal slides up from bottom',
            ),
            _buildVerticalSlideStrip(),
            sectionHeader(
              '07',
              'Back-Swipe Gesture',
              'Drag from left edge — page follows finger, releases past threshold pops',
            ),
            _buildBackSwipeDemo(),
            sectionHeader(
              '08',
              'Transition Classes — Side by Side',
              'CupertinoPageTransition vs CupertinoFullscreenDialogTransition',
            ),
            _buildTransitionClassCompare(),
            sectionHeader(
              '09',
              'buildPage / buildTransitions Protocol',
              'How PageRoute delegates building to its subclass methods',
            ),
            _buildProtocolDiagram(),
            sectionHeader(
              '10',
              'Title Property Demo',
              'How CupertinoPageRoute.title surfaces in the iOS back chevron',
            ),
            _buildTitleDemo(),
            sectionHeader(
              '11',
              'T Return Type Demo',
              'CupertinoPageRoute<String>, <bool>, <MyResult> — typed pop values',
            ),
            _buildReturnTypeDemo(),
            sectionHeader(
              '12',
              'Recipe Cards',
              'Common navigation patterns with CupertinoPageRoute',
            ),
            _buildRecipeCards(),
            sectionHeader(
              '13',
              'CupertinoPageRoute vs MaterialPageRoute',
              'Same job, different motion language',
            ),
            _buildCupertinoVsMaterial(),
            sectionHeader(
              '14',
              'iOS Route Family',
              'Page / ModalPopup / Sheet / Dialog routes side by side',
            ),
            _buildRouteFamilyTable(),
            sectionHeader(
              '15',
              'Pitfalls & Gotchas',
              'What surprises iOS developers most',
            ),
            _buildPitfalls(),
            sectionHeader('16', 'Glossary', 'Key terms in one place'),
            _buildGlossary(),
            sectionHeader('17', 'Epilogue', 'The shape of iOS navigation'),
            _buildEpilogue(),
            SizedBox(height: 48),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// HERO HEADER
// ============================================================================
Widget _buildHeroHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 28),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kIosBlue, kIosIndigo],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: kIosBlue.withOpacity(0.3),
          blurRadius: 24,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
          ),
          child: Icon(
            CupertinoIcons.arrow_right_circle_fill,
            color: Colors.white,
            size: 44,
          ),
        ),
        SizedBox(width: 22),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CupertinoPageRoute<T>',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'The iOS horizontal slide',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.92),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Modal route with iOS-style transitions: horizontal slide for default push, vertical slide for fullscreenDialog, and interactive back-swipe gesture.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1 — CONCEPT OVERVIEW
// ============================================================================
Widget _buildConceptOverview() {
  return Column(
    children: [
      panel(
        title: 'Three things make a route "Cupertino"',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bullet(
              'Horizontal slide',
              'New page slides in from the right; previous page parallaxes left by ~30% and darkens. Reversed on pop.',
              kIosBlue,
            ),
            _bullet(
              'Back-swipe gesture',
              'A drag starting from the left edge of the screen interactively pops the route. Past a threshold, the gesture controller animates to completion.',
              kIosGreen,
            ),
            _bullet(
              'Vertical slide for fullscreenDialog',
              'When fullscreenDialog: true, the route slides up from the bottom and the swipe-back gesture is disabled — it behaves like a modal sheet.',
              kIosOrange,
            ),
          ],
        ),
      ),
      panel(
        title: 'Compare with MaterialPageRoute',
        tint: kIosPurple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kv('Material default', 'Fade-through (Material 3) or fade-up (legacy). No edge gesture.'),
            kv('Cupertino default', 'Horizontal slide + parallax + iOS shadow. Edge swipe to pop.'),
            kv('Material modal', 'showModalBottomSheet, showDialog — separate APIs.'),
            kv('Cupertino modal', 'Same CupertinoPageRoute with fullscreenDialog: true.'),
            kv('Adaptivity', 'PageRouteBuilder + adaptive transitions can switch per platform.'),
          ],
        ),
      ),
    ],
  );
}

Widget _bullet(String title, String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(top: 6, right: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: kInkPrimary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                text,
                style: TextStyle(fontSize: 12, color: kInkSecondary, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 — CLASS HIERARCHY
// ============================================================================
Widget _buildClassHierarchy() {
  final levels = <Map<String, String>>[
    {'name': 'Route<T>', 'role': 'abstract — entry in Navigator stack, knows isCurrent/isActive/popped'},
    {'name': 'OverlayRoute<T>', 'role': 'abstract — manages OverlayEntries inserted into Overlay'},
    {'name': 'TransitionRoute<T>', 'role': 'abstract — owns AnimationController, transitionDuration, animation'},
    {'name': 'ModalRoute<T>', 'role': 'abstract — barrier, focus traps, secondaryAnimation, buildPage, buildTransitions'},
    {'name': 'PageRoute<T>', 'role': 'abstract — opaque, full-screen, fullscreenDialog flag'},
    {'name': 'CupertinoPageRoute<T>', 'role': 'concrete — iOS slide + edge swipe gesture via CupertinoRouteTransitionMixin'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      panel(
        title: 'Inheritance ladder',
        child: Column(
          children: [
            for (var i = 0; i < levels.length; i++)
              _hierarchyRow(
                depth: i,
                name: levels[i]['name']!,
                role: levels[i]['role']!,
                isLeaf: i == levels.length - 1,
              ),
          ],
        ),
      ),
      panel(
        title: 'CupertinoRouteTransitionMixin',
        tint: kIosTeal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Most of the iOS-specific behavior actually lives in this mixin, not in CupertinoPageRoute itself. The mixin provides:',
              style: TextStyle(fontSize: 12, color: kInkSecondary, height: 1.45),
            ),
            SizedBox(height: 8),
            kv('title', 'getter for the optional title used in back chevrons'),
            kv('buildContent', 'abstract — returns the page body (builder runs here)'),
            kv('buildPage', 'wraps content in a CupertinoPageScaffold-friendly host'),
            kv('buildTransitions', 'returns CupertinoPageTransition wrapping the child'),
            kv('isPopGestureEnabled', 'static — gates the back-swipe gesture'),
            kv('startPopGesture', 'static — wires the gesture into the controller'),
          ],
        ),
      ),
      panel(
        title: 'Why this matters',
        tint: kIosOrange,
        child: Text(
          'Anything you can do by composing CupertinoPageRoute, you can also do by mixing CupertinoRouteTransitionMixin into a custom Route<T>. This is how packages like sliver_tools and modal_bottom_sheet provide iOS-flavored custom routes without subclassing CupertinoPageRoute directly.',
          style: TextStyle(fontSize: 12, color: kInkSecondary, height: 1.45),
        ),
      ),
    ],
  );
}

Widget _hierarchyRow({
  required int depth,
  required String name,
  required String role,
  bool isLeaf = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: depth * 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isLeaf ? kIosBlue : kSysGray6,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isLeaf ? kIosBlue : kSysGray3,
              width: 0.5,
            ),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: isLeaf ? Colors.white : kInkPrimary,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              role,
              style: TextStyle(fontSize: 11, color: kInkSecondary, height: 1.35),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 — CONSTRUCTOR ANATOMY
// ============================================================================
Widget _buildConstructorAnatomy() {
  final params = <Map<String, dynamic>>[
    {
      'name': 'builder',
      'type': 'WidgetBuilder',
      'required': true,
      'desc': 'Function that produces the page widget for this route. Runs each time the route is inserted into the navigator.',
      'color': kIosBlue,
    },
    {
      'name': 'settings',
      'type': 'RouteSettings?',
      'required': false,
      'desc': 'Carries the route name and optional arguments. Used by named navigation, restoration, and observers.',
      'color': kIosTeal,
    },
    {
      'name': 'title',
      'type': 'String?',
      'required': false,
      'desc': 'iOS-only metadata. Surfaces as the previous-page label on the next page\'s back chevron.',
      'color': kIosPurple,
    },
    {
      'name': 'maintainState',
      'type': 'bool (default true)',
      'required': false,
      'desc': 'If false, the route\'s page widget is unmounted when it\'s not the topmost. State is lost. Use for memory savings on heavy pages.',
      'color': kIosOrange,
    },
    {
      'name': 'fullscreenDialog',
      'type': 'bool (default false)',
      'required': false,
      'desc': 'Switches to the vertical (slide-up) modal transition. Disables back-swipe. Use for new-item / settings modals.',
      'color': kIosRed,
    },
    {
      'name': 'allowSnapshotting',
      'type': 'bool (default true)',
      'required': false,
      'desc': 'If true, the previous page may be snapshotted (rasterized) during the transition for performance. Disable when the previous page is animating.',
      'color': kIosGreen,
    },
    {
      'name': 'requestFocus',
      'type': 'bool? (default null)',
      'required': false,
      'desc': 'Whether focus should move into this route when pushed. Inherits from theme when null.',
      'color': kIosPink,
    },
    {
      'name': 'barrierDismissible',
      'type': 'bool (default false on PageRoute)',
      'required': false,
      'desc': 'Always false for CupertinoPageRoute. Inherited from PageRoute but not surfaced — page routes are opaque and have no barrier.',
      'color': kIosIndigo,
    },
  ];

  return Column(
    children: [
      for (final p in params)
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kHairline, width: 0.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 56,
                decoration: BoxDecoration(
                  color: p['color'] as Color,
                  borderRadius: BorderRadius.circular(2),
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
                          p['name'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                            color: kInkPrimary,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: (p['color'] as Color).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            p['type'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: p['color'] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        if (p['required'] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: kIosRed,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'required',
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      p['desc'] as String,
                      style: TextStyle(fontSize: 11, color: kInkSecondary, height: 1.45),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

// ============================================================================
// SECTION 4 — LIVE SPECIMENS
// ============================================================================
Widget _buildLiveSpecimens(List<Map<String, dynamic>> specimens) {
  return Column(
    children: [
      for (final s in specimens)
        panel(
          title: s['label'] as String,
          tint: kIosBlue,
          child: s.containsKey('error')
              ? Text(
                  'Construction error: ${s['error']}',
                  style: TextStyle(fontSize: 12, color: kIosRed),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    kv('settings.name', s['name'] as String),
                    kv('title', s['title'] as String),
                    kv('maintainState', s['maintainState'] as String),
                    kv('fullscreenDialog', s['fullscreenDialog'] as String),
                    kv('allowSnapshotting', s['allowSnapshotting'] as String),
                    kv('opaque', s['opaque'] as String),
                    kv('barrierDismissible', s['barrierDismissible'] as String),
                  ],
                ),
        ),
    ],
  );
}

// ============================================================================
// SECTION 5 — HORIZONTAL SLIDE STRIP
// ============================================================================
Widget _buildHorizontalSlideStrip() {
  final ts = [0.0, 0.25, 0.5, 0.75, 1.0];
  return Column(
    children: [
      panel(
        title: 'Push transition — 5 frames at t = 0.0 / 0.25 / 0.5 / 0.75 / 1.0',
        child: Column(
          children: [
            Text(
              'Incoming page (purple "Detail") slides in from the right. Outgoing page (blue "Home") parallaxes left by 30% and darkens.',
              style: TextStyle(fontSize: 12, color: kInkSecondary, height: 1.4),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final t in ts) ...[
                    horizontalSlideSnapshot(t, label: 't = ${t.toStringAsFixed(2)}'),
                    SizedBox(width: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      panel(
        title: 'What\'s actually animating',
        tint: kIosPurple,
        child: Column(
          children: [
            kv('Incoming Offset', 'Tween(begin: Offset(1.0, 0), end: Offset.zero)'),
            kv('Outgoing Offset', 'Tween(begin: Offset.zero, end: Offset(-0.3, 0)) — parallax'),
            kv('Outgoing dim', 'overlay fades 0.0 → 0.4 opacity'),
            kv('Curve', 'Curves.linearToEaseOut (push) / Curves.easeInToLinear (pop)'),
            kv('Duration', '~400 ms by default'),
            kv('Shadow', 'iOS gradient shadow on the leading edge of incoming page'),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 6 — VERTICAL SLIDE STRIP
// ============================================================================
Widget _buildVerticalSlideStrip() {
  final ts = [0.0, 0.25, 0.5, 0.75, 1.0];
  return Column(
    children: [
      panel(
        title: 'fullscreenDialog: true — vertical slide up',
        tint: kIosOrange,
        child: Column(
          children: [
            Text(
              'A modal "New Item" form slides up from the bottom. The presenting page stays put (no parallax). Top bar shows Cancel / Title / Done.',
              style: TextStyle(fontSize: 12, color: kInkSecondary, height: 1.4),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final t in ts) ...[
                    verticalSlideSnapshot(t, label: 't = ${t.toStringAsFixed(2)}'),
                    SizedBox(width: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      panel(
        title: 'CupertinoFullscreenDialogTransition',
        tint: kIosOrange,
        child: Column(
          children: [
            kv('Tween', 'Tween(begin: Offset(0, 1.0), end: Offset.zero)'),
            kv('Curve', 'Curves.linearToEaseOut'),
            kv('Reverse curve', 'Curves.easeInToLinear'),
            kv('Swipe-back', 'Disabled — the modal can only be dismissed via Cancel/Done or a downward gesture if you wire one'),
            kv('Use cases', 'New item, settings, sign-in flows, anything that interrupts the user\'s task'),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 7 — BACK-SWIPE DEMO
// ============================================================================
Widget _buildBackSwipeDemo() {
  final fractions = [0.0, 0.2, 0.45, 0.7, 1.0];
  return Column(
    children: [
      panel(
        title: 'Back-swipe gesture — 5 frames of an interactive pop',
        tint: kIosGreen,
        child: Column(
          children: [
            Text(
              'User touches the left edge of the screen and drags right. The current page follows the finger; the previous page slides in from its parallax position. Past ~50% the gesture commits — releasing earlier snaps back.',
              style: TextStyle(fontSize: 12, color: kInkSecondary, height: 1.4),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final f in fractions) ...[
                    backSwipeSnapshot(
                      f,
                      label: f == 0.0
                          ? 'edge touched'
                          : f == 1.0
                              ? 'pop completes'
                              : 'drag ${(f * 100).toInt()}%',
                    ),
                    SizedBox(width: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      panel(
        title: '_CupertinoBackGestureController — the machinery',
        tint: kIosGreen,
        child: Column(
          children: [
            kv('Detector', 'HorizontalDragGestureRecognizer attached to a strip on the left edge'),
            kv('On start', 'CupertinoPageRoute installs a _CupertinoBackGestureController, pausing the AnimationController'),
            kv('On update', 'animation.value -= dx / width (drives the transition manually)'),
            kv('On end (commit)', 'velocity or position past threshold → animateBack to 0 → pop()'),
            kv('On end (cancel)', 'animateForward back to 1 → route stays'),
            kv('Disabled when', 'fullscreenDialog: true OR willHandlePopInternally OR isFirst route OR canPop is false'),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 8 — TRANSITION CLASS COMPARE
// ============================================================================
Widget _buildTransitionClassCompare() {
  return Column(
    children: [
      panel(
        title: 'Side-by-side at t = 0.5',
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  horizontalSlideSnapshot(0.5),
                  SizedBox(height: 10),
                  Text(
                    'CupertinoPageTransition',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: kIosBlue,
                    ),
                  ),
                  Text(
                    'horizontal slide + parallax',
                    style: TextStyle(fontSize: 10, color: kInkSecondary),
                  ),
                ],
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                children: [
                  verticalSlideSnapshot(0.5),
                  SizedBox(height: 10),
                  Text(
                    'CupertinoFullscreenDialogTransition',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: kIosOrange,
                    ),
                  ),
                  Text(
                    'vertical slide up, no parallax',
                    style: TextStyle(fontSize: 10, color: kInkSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      panel(
        title: 'Constructor signatures',
        tint: kIosTeal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _codeBlock(
              'CupertinoPageTransition({\n'
              '  required Animation<double> primaryRouteAnimation,\n'
              '  required Animation<double> secondaryRouteAnimation,\n'
              '  required Widget child,\n'
              '  required bool linearTransition,\n'
              '})',
            ),
            SizedBox(height: 10),
            _codeBlock(
              'CupertinoFullscreenDialogTransition({\n'
              '  required Animation<double> primaryRouteAnimation,\n'
              '  required Animation<double> secondaryRouteAnimation,\n'
              '  required Widget child,\n'
              '  required bool linearTransition,\n'
              '})',
            ),
            SizedBox(height: 10),
            Text(
              'Both accept a primary animation (this route\'s progress) and a secondary animation (a later push that\'s pushing this route away). linearTransition is set to true while the back-swipe gesture is active so the user feels direct manipulation.',
              style: TextStyle(fontSize: 11, color: kInkSecondary, height: 1.45),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kInkPrimary,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontSize: 10,
        fontFamily: 'monospace',
        color: Color(0xFFE5E5EA),
        height: 1.5,
      ),
    ),
  );
}

// ============================================================================
// SECTION 9 — PROTOCOL DIAGRAM
// ============================================================================
Widget _buildProtocolDiagram() {
  return Column(
    children: [
      panel(
        title: 'How a CupertinoPageRoute renders itself',
        tint: kIosIndigo,
        child: Column(
          children: [
            _protocolStep(1, 'Navigator inserts route', 'Navigator pushes the route, calls install(), createOverlayEntries(), then drives animation 0 → 1.'),
            _protocolStep(2, 'ModalRoute.buildPage()', 'PageRoute overrides this and (via CupertinoRouteTransitionMixin) calls builder(context). The builder produces your page widget.'),
            _protocolStep(3, 'ModalRoute.buildTransitions()', 'CupertinoRouteTransitionMixin overrides this to return CupertinoPageTransition (or CupertinoFullscreenDialogTransition if fullscreenDialog).'),
            _protocolStep(4, 'Overlay paints the result', 'Stack of OverlayEntries: barrier (none for opaque routes), then page wrapped in transitions, ordered front-to-back by insertion.'),
            _protocolStep(5, 'On pop', 'Animation drives 1 → 0, buildTransitions runs at every frame, didPop returns true once at end.'),
          ],
        ),
      ),
      panel(
        title: 'Pseudocode of buildTransitions',
        tint: kIosIndigo,
        child: _codeBlock(
          '// inside CupertinoRouteTransitionMixin\n'
          'Widget buildTransitions(\n'
          '  BuildContext context,\n'
          '  Animation<double> animation,\n'
          '  Animation<double> secondaryAnimation,\n'
          '  Widget child,\n'
          ') {\n'
          '  if (fullscreenDialog) {\n'
          '    return CupertinoFullscreenDialogTransition(\n'
          '      primaryRouteAnimation: animation,\n'
          '      secondaryRouteAnimation: secondaryAnimation,\n'
          '      child: child,\n'
          '      linearTransition: _isPopGestureInProgress,\n'
          '    );\n'
          '  }\n'
          '  return CupertinoPageTransition(\n'
          '    primaryRouteAnimation: animation,\n'
          '    secondaryRouteAnimation: secondaryAnimation,\n'
          '    child: _CupertinoBackGestureDetector(\n'
          '      enabledCallback: () => isPopGestureEnabled,\n'
          '      onStartPopGesture: () => startPopGesture(this),\n'
          '      child: child,\n'
          '    ),\n'
          '    linearTransition: _isPopGestureInProgress,\n'
          '  );\n'
          '}',
        ),
      ),
    ],
  );
}

Widget _protocolStep(int n, String title, String desc) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kSysGray6,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kIosIndigo,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$n',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: kInkPrimary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(fontSize: 11, color: kInkSecondary, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10 — TITLE DEMO
// ============================================================================
Widget _buildTitleDemo() {
  return Column(
    children: [
      panel(
        title: 'How title surfaces in the iOS back chevron',
        tint: kIosPurple,
        child: Column(
          children: [
            Text(
              'When route A pushes route B with title: "Home", route B\'s back chevron reads "Home". When title is null, the chevron shows just the < glyph.',
              style: TextStyle(fontSize: 12, color: kInkSecondary, height: 1.4),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _titleVariant('Home', 'Home')),
                SizedBox(width: 10),
                Expanded(child: _titleVariant('Settings', 'Settings')),
                SizedBox(width: 10),
                Expanded(child: _titleVariant('null', null)),
              ],
            ),
          ],
        ),
      ),
      panel(
        title: 'The previousTitle inheritance chain',
        tint: kIosPurple,
        child: Text(
          'CupertinoNavigationBar reads CupertinoRouteTransitionMixin.previousTitleOf(context) to find the previous route\'s title. This is why setting title on route A surfaces on route B\'s nav bar, not on A\'s own.',
          style: TextStyle(fontSize: 12, color: kInkSecondary, height: 1.4),
        ),
      ),
    ],
  );
}

Widget _titleVariant(String label, String? title) {
  return Column(
    children: [
      Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kHairline, width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(CupertinoIcons.chevron_left, size: 14, color: kIosBlue),
                SizedBox(width: 2),
                Expanded(
                  child: Text(
                    title ?? '',
                    style: TextStyle(fontSize: 11, color: kIosBlue),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              'Detail',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: kInkPrimary,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 6),
      Text(
        'title: $label',
        style: TextStyle(fontSize: 10, color: kInkSecondary, fontFamily: 'monospace'),
      ),
    ],
  );
}

// ============================================================================
// SECTION 11 — RETURN TYPE DEMO
// ============================================================================
Widget _buildReturnTypeDemo() {
  final types = <Map<String, dynamic>>[
    {
      'type': 'CupertinoPageRoute<String>',
      'returns': 'A picked string from a picker page',
      'example': 'final pick = await Navigator.push<String>(\n'
          '  context,\n'
          '  CupertinoPageRoute<String>(\n'
          '    builder: (_) => CountryPickerPage(),\n'
          '  ),\n'
          ');\n'
          '// pick is String? — null if user popped without selection',
      'color': kIosBlue,
    },
    {
      'type': 'CupertinoPageRoute<bool>',
      'returns': 'Confirmation result from a yes/no flow',
      'example': 'final confirmed = await Navigator.push<bool>(\n'
          '  context,\n'
          '  CupertinoPageRoute<bool>(\n'
          '    fullscreenDialog: true,\n'
          '    builder: (_) => DeleteConfirmPage(),\n'
          '  ),\n'
          ');\n'
          '// confirmed is bool? — null if user back-swipe-cancelled',
      'color': kIosOrange,
    },
    {
      'type': 'CupertinoPageRoute<MyResult>',
      'returns': 'A typed value object from an editor',
      'example': 'class MyResult { final String title; final int count; ... }\n'
          'final result = await Navigator.push<MyResult>(\n'
          '  context,\n'
          '  CupertinoPageRoute<MyResult>(\n'
          '    builder: (_) => EditorPage(),\n'
          '  ),\n'
          ');',
      'color': kIosPurple,
    },
    {
      'type': 'CupertinoPageRoute<void>',
      'returns': 'Fire-and-forget — no pop value needed',
      'example': 'Navigator.push<void>(\n'
          '  context,\n'
          '  CupertinoPageRoute<void>(\n'
          '    builder: (_) => AboutPage(),\n'
          '  ),\n'
          ');',
      'color': kIosGreen,
    },
  ];

  return Column(
    children: [
      for (final t in types)
        panel(
          title: t['type'] as String,
          tint: t['color'] as Color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t['returns'] as String,
                style: TextStyle(fontSize: 12, color: kInkPrimary, height: 1.4),
              ),
              SizedBox(height: 10),
              _codeBlock(t['example'] as String),
            ],
          ),
        ),
    ],
  );
}

// ============================================================================
// SECTION 12 — RECIPE CARDS
// ============================================================================
Widget _buildRecipeCards() {
  final recipes = <Map<String, dynamic>>[
    {
      'icon': CupertinoIcons.arrow_right,
      'tint': kIosBlue,
      'title': 'Basic push',
      'desc': 'Standard horizontal slide to a new page.',
      'code': 'Navigator.push(\n'
          '  context,\n'
          '  CupertinoPageRoute(\n'
          '    builder: (_) => DetailPage(),\n'
          '  ),\n'
          ');',
    },
    {
      'icon': CupertinoIcons.arrow_2_circlepath,
      'tint': kIosTeal,
      'title': 'Push and await result',
      'desc': 'Await the pop value with generic type parameter.',
      'code': 'final result = await Navigator.push<String>(\n'
          '  context,\n'
          '  CupertinoPageRoute<String>(\n'
          '    builder: (_) => PickerPage(),\n'
          '  ),\n'
          ');\n'
          'if (result != null) handlePick(result);',
    },
    {
      'icon': CupertinoIcons.arrow_up,
      'tint': kIosOrange,
      'title': 'fullscreenDialog modal',
      'desc': 'Vertical slide-up, no swipe-back, Cancel/Done navbar.',
      'code': 'Navigator.push(\n'
          '  context,\n'
          '  CupertinoPageRoute(\n'
          '    fullscreenDialog: true,\n'
          '    builder: (_) => NewItemForm(),\n'
          '  ),\n'
          ');',
    },
    {
      'icon': CupertinoIcons.arrow_left_right,
      'tint': kIosPurple,
      'title': 'Replace current route',
      'desc': 'Swap top route — used after sign-in to remove the login page.',
      'code': 'Navigator.pushReplacement(\n'
          '  context,\n'
          '  CupertinoPageRoute(\n'
          '    builder: (_) => HomePage(),\n'
          '  ),\n'
          ');',
    },
    {
      'icon': CupertinoIcons.delete_simple,
      'tint': kIosRed,
      'title': 'pushAndRemoveUntil',
      'desc': 'Clear navigation history up to a predicate (e.g. back to root).',
      'code': 'Navigator.pushAndRemoveUntil(\n'
          '  context,\n'
          '  CupertinoPageRoute(\n'
          '    builder: (_) => DashboardPage(),\n'
          '  ),\n'
          '  (route) => false, // clear all\n'
          ');',
    },
    {
      'icon': CupertinoIcons.return_icon,
      'tint': kIosGreen,
      'title': 'Pop with result',
      'desc': 'Return a value to whoever awaited the push.',
      'code': '// inside the pushed page\n'
          'CupertinoButton(\n'
          '  onPressed: () => Navigator.pop(\n'
          '    context,\n'
          '    "selected value",\n'
          '  ),\n'
          '  child: Text("Done"),\n'
          ');',
    },
  ];

  return Column(
    children: [
      for (final r in recipes)
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kHairline, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: (r['tint'] as Color).withOpacity(0.14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      r['icon'] as IconData,
                      size: 18,
                      color: r['tint'] as Color,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          r['title'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: kInkPrimary,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          r['desc'] as String,
                          style: TextStyle(fontSize: 11, color: kInkSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _codeBlock(r['code'] as String),
            ],
          ),
        ),
    ],
  );
}

// ============================================================================
// SECTION 13 — CUPERTINO VS MATERIAL CAMEO
// ============================================================================
Widget _buildCupertinoVsMaterial() {
  return Column(
    children: [
      panel(
        title: 'Same destination, different motion',
        tint: kIosPink,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  horizontalSlideSnapshot(0.5),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: kIosBlue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'CupertinoPageRoute',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'horizontal slide,\nedge-swipe to pop',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: kInkSecondary),
                  ),
                ],
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                children: [
                  _materialSnapshot(0.5),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: kIosPurple,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'MaterialPageRoute',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'fade through,\nno edge gesture',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: kInkSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      panel(
        title: 'Behavioral differences',
        tint: kIosPink,
        child: Column(
          children: [
            _twoColRow('Edge swipe back', 'YES — built-in', 'NO — Android uses system back gesture instead'),
            _twoColRow('Transition curve', 'linearToEaseOut / easeInToLinear', 'fastOutSlowIn'),
            _twoColRow('Outgoing motion', 'Parallax (-30% slide + darken)', 'Stays put, fades'),
            _twoColRow('Modal variant', 'fullscreenDialog: true → vertical slide', 'Use ModalBottomSheet / showDialog'),
            _twoColRow('title parameter', 'Surfaces on next page\'s back chevron', 'No equivalent — back button is just an arrow'),
            _twoColRow('Default platform', 'iOS / macOS', 'Android / Linux / Windows'),
          ],
        ),
      ),
    ],
  );
}

Widget _materialSnapshot(double t) {
  // A simple Material-style fade transition snapshot
  return miniPhone(
    screen: Stack(
      children: [
        // Outgoing page — stays put, fades
        Positioned.fill(
          child: Opacity(
            opacity: 1.0 - t,
            child: Column(
              children: [
                Container(
                  height: 40,
                  color: kIosPurple,
                  alignment: Alignment.center,
                  child: Text(
                    'Home',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: kSysGray6,
                    child: Center(
                      child: Icon(Icons.home, color: kIosPurple, size: 40),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Incoming page — fades up
        Positioned.fill(
          child: Opacity(
            opacity: t,
            child: Transform.translate(
              offset: Offset(0, 20 * (1.0 - t)),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    color: kIosTeal,
                    alignment: Alignment.center,
                    child: Text(
                      'Detail',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: kSysGray6,
                      child: Center(
                        child: Icon(Icons.article, color: kIosTeal, size: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _twoColRow(String key, String left, String right) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: kSysGray5, width: 0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: kInkPrimary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            left,
            style: TextStyle(fontSize: 11, color: kIosBlue),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            right,
            style: TextStyle(fontSize: 11, color: kIosPurple),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 14 — ROUTE FAMILY TABLE
// ============================================================================
Widget _buildRouteFamilyTable() {
  final rows = <List<String>>[
    ['Route', 'Transition', 'Gesture', 'Barrier', 'Use case'],
    [
      'CupertinoPageRoute',
      'horizontal slide + parallax',
      'edge swipe back',
      'opaque (none)',
      'Standard push navigation',
    ],
    [
      'CupertinoPageRoute (fullscreenDialog)',
      'vertical slide up',
      'none',
      'opaque (none)',
      'Modal forms, settings',
    ],
    [
      'CupertinoModalPopupRoute',
      'fade + scale up from center',
      'tap barrier to dismiss',
      'translucent',
      'Action sheets',
    ],
    [
      'CupertinoSheetRoute',
      'vertical slide with rounded top',
      'drag down to dismiss',
      'stack-darken',
      'iOS 13+ sheet-style modals',
    ],
    [
      'CupertinoDialogRoute',
      'fade + scale 1.3 → 1.0',
      'tap barrier (if dismissible)',
      'blur + translucent',
      'Alert dialogs',
    ],
    [
      'showCupertinoSheet helper',
      'wraps CupertinoSheetRoute',
      'drag down',
      'stack-darken',
      'Imperative sheet API',
    ],
  ];

  return panel(
    title: 'iOS routes side by side',
    tint: kIosIndigo,
    child: Column(
      children: [
        for (var i = 0; i < rows.length; i++)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            decoration: BoxDecoration(
              color: i == 0
                  ? kIosIndigo.withOpacity(0.08)
                  : (i % 2 == 0 ? kSysGray6 : Colors.white),
              border: Border(
                bottom: BorderSide(color: kHairline, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                for (var c = 0; c < rows[i].length; c++)
                  Expanded(
                    flex: c == 0 ? 3 : 2,
                    child: Text(
                      rows[i][c],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: i == 0 ? FontWeight.w800 : FontWeight.w500,
                        color: i == 0 ? kIosIndigo : kInkPrimary,
                        height: 1.3,
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

// ============================================================================
// SECTION 15 — PITFALLS
// ============================================================================
Widget _buildPitfalls() {
  final pitfalls = <Map<String, String>>[
    {
      'title': 'fullscreenDialog disables swipe-back',
      'body': 'Once you set fullscreenDialog: true, the edge-swipe gesture is unavailable. The user must use the Cancel button you provide. Some apps wire a vertical drag-down to dismiss, but you have to add that yourself.',
    },
    {
      'title': 'title surfaces on the next page, not this one',
      'body': 'CupertinoPageRoute.title shows up as the previous-page label in the next page\'s back chevron. If you want a title on this page, use CupertinoNavigationBar.middle in your page widget.',
    },
    {
      'title': 'builder runs each time the route inserts',
      'body': 'Side effects inside builder (network calls, DateTime.now) re-run on every push. Move stateful work into the page widget\'s State or pass values via constructor.',
    },
    {
      'title': 'maintainState: false drops the page when not topmost',
      'body': 'Setting maintainState: false unmounts the page widget when it\'s not on top of the stack. Scroll positions, TextField contents, and animations are all lost. Use only for memory-heavy pages with no transient state.',
    },
    {
      'title': 'Swipe-back can interfere with horizontal scroll',
      'body': 'A ListView with horizontal scrolling near the left edge will conflict with the back-swipe gesture. The gesture arena resolves in favor of the swipe-back, so your scroll may not start. Use a HorizontalDragGestureRecognizer or DragStartBehavior to mediate.',
    },
    {
      'title': 'allowSnapshotting can hide animations on the previous page',
      'body': 'When true, the previous page may be rasterized to a single snapshot during the transition. If that page has live animations (CircularProgressIndicator, marquee), they appear frozen. Set allowSnapshotting: false in that case.',
    },
    {
      'title': 'CupertinoPageRoute on Android looks "wrong"',
      'body': 'iOS slide transition on Android feels off because Android users expect fade-through. Use Platform.isIOS to switch, or use Theme.of(context).pageTransitionsTheme.builders[TargetPlatform.iOS] for adaptive behavior.',
    },
    {
      'title': 'Popping with no result loses type info',
      'body': 'Navigator.pop(context) returns null to the awaiting push. If you typed it as CupertinoPageRoute<String>, the awaited value is String? — always nullable. Plan for the null case explicitly.',
    },
  ];

  return Column(
    children: [
      for (final p in pitfalls)
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kIosOrange.withOpacity(0.4), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                size: 18,
                color: kIosOrange,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['title']!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: kInkPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      p['body']!,
                      style: TextStyle(fontSize: 11, color: kInkSecondary, height: 1.45),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

// ============================================================================
// SECTION 16 — GLOSSARY
// ============================================================================
Widget _buildGlossary() {
  final terms = <Map<String, String>>[
    {'term': 'Route<T>', 'def': 'An entry in a Navigator stack. Knows how to show and hide itself. The generic T is the type of the value returned by pop.'},
    {'term': 'ModalRoute', 'def': 'A Route that blocks input to lower routes via a barrier. Provides buildPage and buildTransitions.'},
    {'term': 'PageRoute', 'def': 'A ModalRoute that fills the screen and is opaque (no see-through barrier).'},
    {'term': 'CupertinoPageRoute', 'def': 'PageRoute with iOS-style transitions and back-swipe gesture.'},
    {'term': 'CupertinoRouteTransitionMixin', 'def': 'Mixin that contributes iOS transitions to any Route<T>.'},
    {'term': 'CupertinoPageTransition', 'def': 'Widget that animates the horizontal slide + parallax shadow.'},
    {'term': 'CupertinoFullscreenDialogTransition', 'def': 'Widget that animates the vertical slide-up modal.'},
    {'term': 'primaryRouteAnimation', 'def': 'Drives this route\'s own enter/exit (0 → 1 on push, 1 → 0 on pop).'},
    {'term': 'secondaryRouteAnimation', 'def': 'Drives this route\'s reaction to a later push that\'s pushing it deeper.'},
    {'term': 'fullscreenDialog', 'def': 'Constructor flag — true for modal vertical-slide, false for horizontal push.'},
    {'term': 'allowSnapshotting', 'def': 'Whether the previous page may be rasterized during the transition.'},
    {'term': 'maintainState', 'def': 'Whether the page widget stays mounted when not topmost.'},
    {'term': 'back-swipe gesture', 'def': 'The iOS edge-drag that interactively pops a route.'},
    {'term': 'parallax', 'def': 'The outgoing page sliding only ~30% of the way to give a sense of depth.'},
    {'term': 'linearTransition', 'def': 'A flag that disables the easing curve while the user is driving the animation directly (during back-swipe).'},
  ];

  return Column(
    children: [
      for (final t in terms)
        Container(
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kHairline, width: 0.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 160,
                child: Text(
                  t['term']!,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: kIosBlue,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  t['def']!,
                  style: TextStyle(fontSize: 11, color: kInkSecondary, height: 1.4),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

// ============================================================================
// SECTION 17 — EPILOGUE
// ============================================================================
Widget _buildEpilogue() {
  return Container(
    padding: EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kIosBlue.withOpacity(0.12), kIosIndigo.withOpacity(0.12)],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kIosBlue.withOpacity(0.3), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.sparkles, color: kIosBlue, size: 22),
            SizedBox(width: 10),
            Text(
              'The shape of iOS navigation',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: kIosBlue,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'CupertinoPageRoute<T> is the most-used non-leaf class in iOS-flavored Flutter apps. Every detail — the parallax, the back-swipe, the title surfacing on the next page, the vertical fullscreenDialog variant — is calibrated to make a Flutter app feel native on iOS.',
          style: TextStyle(fontSize: 12.5, color: kInkPrimary, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          'Under the hood, it\'s a thin shell over CupertinoRouteTransitionMixin and CupertinoPageTransition. Understanding those primitives lets you build custom routes that feel just as iOS-native — sheets, popovers, custom modals — by mixing the same mixin into your own Route<T> subclasses.',
          style: TextStyle(fontSize: 12.5, color: kInkPrimary, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          'The constructor is small. The behavior is huge. That ratio — minimal surface area, maximal motion fidelity — is what makes the Cupertino library worth studying as a model for platform-faithful framework design.',
          style: TextStyle(fontSize: 12.5, color: kInkPrimary, height: 1.5),
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: kIosBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.checkmark_seal_fill, color: Colors.white, size: 14),
              SizedBox(width: 6),
              Text(
                'CupertinoPageRoute<T> — deep visual demo complete',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
