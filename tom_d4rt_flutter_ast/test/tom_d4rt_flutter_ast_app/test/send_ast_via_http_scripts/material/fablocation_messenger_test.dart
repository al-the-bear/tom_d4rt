// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for FloatingActionButtonLocation
// and ScaffoldMessenger family
// Explores every named FAB location, FAB animator types, SnackBar and
// MaterialBanner constructors, theming, and FAB + bottom-sheet/bottom-bar
// coexistence patterns. Purely descriptive — no messenger queue is exercised.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Tiny helpers used across the sections. Kept local — no top-level state.
// ---------------------------------------------------------------------------

Widget _sectionTitle(String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 13, color: Color(0xFF455A64)),
        ),
      ],
    ),
  );
}

Widget _explainCard(String heading, String body) {
  return Card(
    elevation: 1,
    margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
    color: const Color(0xFFF3F6FF),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            heading,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF283593),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(fontSize: 12, color: Color(0xFF37474F)),
          ),
        ],
      ),
    ),
  );
}

Widget _labelChip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.18),
      border: Border.all(color: color, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

// A miniature "scaffold preview" used by the FAB location grid. We don't
// render a real Scaffold for each cell — we draw a stylised representation
// so that we can show the FAB exactly where the named location would land.
Widget _miniScaffold({
  required String name,
  required FloatingActionButtonLocation location,
  required Color fabColor,
  bool withBottomBar = true,
  bool withBottomSheet = false,
}) {
  // Map known locations into (alignmentX, alignmentY, docked, top).
  // Indexed for clarity; this mirrors how the real layout solver picks an
  // alignment from an immutable description of the location.
  double ax = 1.0;
  double ay = 1.0;
  bool docked = false;
  bool top = false;
  bool contained = false;
  bool mini = false;

  if (location == FloatingActionButtonLocation.endFloat) {
    ax = 1.0; ay = 1.0;
  } else if (location == FloatingActionButtonLocation.centerFloat) {
    ax = 0.0; ay = 1.0;
  } else if (location == FloatingActionButtonLocation.startFloat) {
    ax = -1.0; ay = 1.0;
  } else if (location == FloatingActionButtonLocation.endDocked) {
    ax = 1.0; ay = 1.0; docked = true;
  } else if (location == FloatingActionButtonLocation.centerDocked) {
    ax = 0.0; ay = 1.0; docked = true;
  } else if (location == FloatingActionButtonLocation.startDocked) {
    ax = -1.0; ay = 1.0; docked = true;
  } else if (location == FloatingActionButtonLocation.endTop) {
    ax = 1.0; ay = -1.0; top = true;
  } else if (location == FloatingActionButtonLocation.centerTop) {
    ax = 0.0; ay = -1.0; top = true;
  } else if (location == FloatingActionButtonLocation.startTop) {
    ax = -1.0; ay = -1.0; top = true;
  } else if (location == FloatingActionButtonLocation.endContained) {
    ax = 1.0; ay = 1.0; contained = true;
  } else if (location == FloatingActionButtonLocation.miniEndFloat) {
    ax = 1.0; ay = 1.0; mini = true;
  } else if (location == FloatingActionButtonLocation.miniCenterFloat) {
    ax = 0.0; ay = 1.0; mini = true;
  } else if (location == FloatingActionButtonLocation.miniStartFloat) {
    ax = -1.0; ay = 1.0; mini = true;
  } else if (location == FloatingActionButtonLocation.miniEndDocked) {
    ax = 1.0; ay = 1.0; docked = true; mini = true;
  } else if (location == FloatingActionButtonLocation.miniCenterDocked) {
    ax = 0.0; ay = 1.0; docked = true; mini = true;
  } else if (location == FloatingActionButtonLocation.miniStartDocked) {
    ax = -1.0; ay = 1.0; docked = true; mini = true;
  } else if (location == FloatingActionButtonLocation.miniEndTop) {
    ax = 1.0; ay = -1.0; top = true; mini = true;
  } else if (location == FloatingActionButtonLocation.miniCenterTop) {
    ax = 0.0; ay = -1.0; top = true; mini = true;
  } else if (location == FloatingActionButtonLocation.miniStartTop) {
    ax = -1.0; ay = -1.0; top = true; mini = true;
  }

  final double fabSize = mini ? 28 : 38;
  final double fabOverlap = docked ? fabSize / 2 : 0;

  return Container(
    margin: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: const Color(0xFFE3E7F1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Faux AppBar
        Container(
          height: 22,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            color: Color(0xFF3949AB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Body with FAB overlay
        SizedBox(
          height: 110,
          child: Stack(
            children: <Widget>[
              // Body content placeholder
              Positioned.fill(
                child: Container(
                  color: const Color(0xFFFAFAFA),
                  alignment: Alignment.center,
                  child: Text(
                    contained
                        ? 'contained'
                        : (top ? 'top' : (docked ? 'docked' : 'floating')),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF78909C),
                    ),
                  ),
                ),
              ),
              // Optional bottom sheet preview
              if (withBottomSheet)
                Positioned(
                  left: 8,
                  right: 8,
                  bottom: 22,
                  child: Container(
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE0B2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'bottom sheet',
                      style: TextStyle(fontSize: 9),
                    ),
                  ),
                ),
              // FAB representation
              Align(
                alignment: Alignment(ax, ay),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: ay > 0 ? (withBottomBar ? 16 : 4) + fabOverlap : 0,
                    top: ay < 0 ? 2 : 0,
                    left: 6,
                    right: 6,
                  ),
                  child: Container(
                    width: fabSize,
                    height: fabSize,
                    decoration: BoxDecoration(
                      color: fabColor,
                      shape: BoxShape.circle,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      mini ? Icons.add : Icons.add_circle,
                      color: Colors.white,
                      size: mini ? 16 : 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Faux bottom navigation bar
        if (withBottomBar)
          Container(
            height: 22,
            decoration: const BoxDecoration(
              color: Color(0xFFCFD8DC),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'BottomNavigationBar',
              style: TextStyle(fontSize: 9, color: Color(0xFF263238)),
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: every named FloatingActionButtonLocation laid out as a grid
// ---------------------------------------------------------------------------
Widget _buildLocationGrid() {
  print('[section 1] FAB location grid: 20 named locations');

  // Indexed lookup of every named location with its display label and the
  // accent colour used in the mini scaffold. Hand-authored to keep order
  // intentional rather than a templated loop.
  final List<List<dynamic>> entries = <List<dynamic>>[
    <dynamic>[
      'endFloat',
      FloatingActionButtonLocation.endFloat,
      const Color(0xFFE53935),
    ],
    <dynamic>[
      'centerFloat',
      FloatingActionButtonLocation.centerFloat,
      const Color(0xFFD81B60),
    ],
    <dynamic>[
      'startFloat',
      FloatingActionButtonLocation.startFloat,
      const Color(0xFF8E24AA),
    ],
    <dynamic>[
      'endDocked',
      FloatingActionButtonLocation.endDocked,
      const Color(0xFF5E35B1),
    ],
    <dynamic>[
      'centerDocked',
      FloatingActionButtonLocation.centerDocked,
      const Color(0xFF3949AB),
    ],
    <dynamic>[
      'startDocked',
      FloatingActionButtonLocation.startDocked,
      const Color(0xFF1E88E5),
    ],
    <dynamic>[
      'endTop',
      FloatingActionButtonLocation.endTop,
      const Color(0xFF039BE5),
    ],
    <dynamic>[
      'centerTop',
      FloatingActionButtonLocation.centerTop,
      const Color(0xFF00ACC1),
    ],
    <dynamic>[
      'startTop',
      FloatingActionButtonLocation.startTop,
      const Color(0xFF00897B),
    ],
    <dynamic>[
      'endContained',
      FloatingActionButtonLocation.endContained,
      const Color(0xFF43A047),
    ],
    <dynamic>[
      'miniEndFloat',
      FloatingActionButtonLocation.miniEndFloat,
      const Color(0xFF7CB342),
    ],
    <dynamic>[
      'miniCenterFloat',
      FloatingActionButtonLocation.miniCenterFloat,
      const Color(0xFFC0CA33),
    ],
    <dynamic>[
      'miniStartFloat',
      FloatingActionButtonLocation.miniStartFloat,
      const Color(0xFFFDD835),
    ],
    <dynamic>[
      'miniEndDocked',
      FloatingActionButtonLocation.miniEndDocked,
      const Color(0xFFFFB300),
    ],
    <dynamic>[
      'miniCenterDocked',
      FloatingActionButtonLocation.miniCenterDocked,
      const Color(0xFFFB8C00),
    ],
    <dynamic>[
      'miniStartDocked',
      FloatingActionButtonLocation.miniStartDocked,
      const Color(0xFFF4511E),
    ],
    <dynamic>[
      'miniEndTop',
      FloatingActionButtonLocation.miniEndTop,
      const Color(0xFF6D4C41),
    ],
    <dynamic>[
      'miniCenterTop',
      FloatingActionButtonLocation.miniCenterTop,
      const Color(0xFF757575),
    ],
    <dynamic>[
      'miniStartTop',
      FloatingActionButtonLocation.miniStartTop,
      const Color(0xFF546E7A),
    ],
  ];

  // Build a 3-wide grid using composed Rows. We use indexed iteration so
  // we don't iterate a bridged list with for-in.
  final List<Widget> rows = <Widget>[];
  const int cols = 3;
  for (var i = 0; i < entries.length; i += cols) {
    final List<Widget> rowChildren = <Widget>[];
    for (var j = 0; j < cols; j++) {
      final int k = i + j;
      if (k < entries.length) {
        final dynamic name = entries[k][0];
        final dynamic loc = entries[k][1];
        final dynamic col = entries[k][2];
        rowChildren.add(
          Expanded(
            child: _miniScaffold(
              name: name as String,
              location: loc as FloatingActionButtonLocation,
              fabColor: col as Color,
              withBottomBar: true,
            ),
          ),
        );
      } else {
        rowChildren.add(const Expanded(child: SizedBox()));
      }
    }
    rows.add(Row(children: rowChildren));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(
        '1. FloatingActionButtonLocation Catalog',
        'Every named location from the Material library, rendered with a stylised scaffold preview.',
      ),
      _explainCard(
        'How locations are named',
        'Locations follow the pattern <horizontal><vertical>. Horizontal is one of start/center/end; vertical is one of float/docked/top, with the special endContained for embedded contexts. Mini variants use the mini FAB size.',
      ),
      ...rows,
      _explainCard(
        'Docked vs Float',
        'Docked locations sit on the seam between the body and the BottomAppBar (or BottomNavigationBar) so the FAB notch lines up. Float locations stay above the bar. Top variants sit beside the AppBar.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: FloatingActionButtonAnimator catalog
// ---------------------------------------------------------------------------
Widget _buildAnimatorCatalog() {
  print('[section 2] FAB animator catalog');

  // Snapshot a single t value to render a representative scale/rotation
  // without ever needing a controller.
  const double t = 0.65;
  final Animation<double> snapshot = const AlwaysStoppedAnimation<double>(t);

  // Show the canonical scaling and rotation transform values that
  // FloatingActionButtonAnimator.scaling would compute. We use a Tween
  // and .transform(t) — never .animate(...).value.
  final double scaleValue =
      Tween<double>(begin: 0.0, end: 1.0).transform(snapshot.value);
  final double rotateValue =
      Tween<double>(begin: -0.125, end: 0.0).transform(snapshot.value);

  Widget cell(String label, Widget child, String subtitle) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFB0BEC5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Center(child: child),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget animatedFab(double scale, double rotateTurns, Color color) {
    return Transform.rotate(
      angle: rotateTurns * 6.2831853,
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  // Reference both static animators so the interpreter exercises lookups.
  final FloatingActionButtonAnimator scaling =
      FloatingActionButtonAnimator.scaling;
  final FloatingActionButtonAnimator noAnimation =
      FloatingActionButtonAnimator.noAnimation;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(
        '2. FloatingActionButtonAnimator',
        'Two built-in animators decide how the FAB enters, exits, and moves between locations.',
      ),
      _explainCard(
        'Built-in animators',
        'FloatingActionButtonAnimator.scaling combines a scale-up and a slight rotation. FloatingActionButtonAnimator.noAnimation skips animation entirely — useful for accessibility or tests.',
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            cell(
              'scaling (t=$t)',
              animatedFab(scaleValue, rotateValue, const Color(0xFF1E88E5)),
              'scale=${scaleValue.toStringAsFixed(2)}, rot=${rotateValue.toStringAsFixed(3)} turns',
            ),
            cell(
              'scaling (t=0.0)',
              animatedFab(0.0, -0.125, const Color(0xFFAB47BC)),
              'Hidden at the start of the entry animation.',
            ),
            cell(
              'scaling (t=1.0)',
              animatedFab(1.0, 0.0, const Color(0xFF26A69A)),
              'Fully visible at rest.',
            ),
            cell(
              'noAnimation',
              animatedFab(1.0, 0.0, const Color(0xFFEF5350)),
              'Instant swap; t is irrelevant.',
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: 8,
          runSpacing: 4,
          children: <Widget>[
            _labelChip(
              'scaling.runtimeType = ${scaling.runtimeType}',
              const Color(0xFF1565C0),
            ),
            _labelChip(
              'noAnimation.runtimeType = ${noAnimation.runtimeType}',
              const Color(0xFF6A1B9A),
            ),
            _labelChip('t snapshot = $t', const Color(0xFF2E7D32)),
          ],
        ),
      ),
      _explainCard(
        'Custom animators',
        'You can subclass FloatingActionButtonAnimator to inject your own scale/rotation/offset interpolations. Scaffold drives them with the current location-change progress.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: SnackBar gallery — every behavior + action variant
// ---------------------------------------------------------------------------
Widget _buildSnackBarGallery() {
  print('[section 3] SnackBar gallery');

  // Build SnackBar widgets inline. We DO NOT call showSnackBar — instead we
  // wrap each SnackBar in a Material box so it renders as part of the demo.

  Widget inlineSnack(SnackBar snack, String tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              tag,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF455A64),
              ),
            ),
          ),
          // SnackBar is a Widget; we can place it directly inside a Material
          // ancestor. We wrap with a Card so the demo treats it as a tile.
          Material(
            elevation: 0,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: snack,
            ),
          ),
        ],
      ),
    );
  }

  // 3a. Default SnackBar with a single action.
  final SnackBar snackBasic = SnackBar(
    content: const Text('File saved to your library.'),
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: () {},
      textColor: const Color(0xFFFFC107),
    ),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color(0xFF323232),
    behavior: SnackBarBehavior.fixed,
    showCloseIcon: false,
  );

  // 3b. Floating SnackBar with rounded corners and margin — Material 3 style.
  final SnackBar snackFloating = SnackBar(
    content: const Text('Connected. Syncing in progress.'),
    action: SnackBarAction(
      label: 'DETAILS',
      onPressed: () {},
      textColor: Colors.white,
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xFF1565C0),
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    showCloseIcon: true,
    closeIconColor: Colors.white,
  );

  // 3c. SnackBar with width override.
  final SnackBar snackWidthed = SnackBar(
    content: const Text('Custom width SnackBar (400px).'),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xFF6A1B9A),
    width: 400.0,
    duration: const Duration(seconds: 6),
  );

  // 3d. SnackBar with rich content row.
  final SnackBar snackRich = SnackBar(
    content: Row(
      children: <Widget>[
        const Icon(Icons.warning_amber, color: Colors.amberAccent),
        const SizedBox(width: 12),
        const Expanded(
          child: Text('Battery low. Plug in to continue offline sync.'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.amber.shade700,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            '12%',
            style: TextStyle(fontSize: 11, color: Colors.black),
          ),
        ),
      ],
    ),
    backgroundColor: const Color(0xFF263238),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 8),
    showCloseIcon: true,
  );

  // 3e. SnackBar with a destructive action.
  final SnackBar snackDestructive = SnackBar(
    content: const Text('Project archived.'),
    action: SnackBarAction(
      label: 'RESTORE',
      onPressed: () {},
      textColor: const Color(0xFFFF5252),
      disabledTextColor: Colors.grey,
    ),
    backgroundColor: const Color(0xFF212121),
    behavior: SnackBarBehavior.fixed,
  );

  // 3f. Long-duration informational SnackBar with no action.
  final SnackBar snackInfo = SnackBar(
    content: const Text(
      'Offline mode is enabled. Changes will be uploaded when you reconnect.',
    ),
    duration: const Duration(seconds: 12),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xFF00695C),
    margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(
        '3. SnackBar Gallery',
        'A spread of SnackBar configurations — built inline, never queued, so we exercise constructors without a live messenger.',
      ),
      _explainCard(
        'SnackBar anatomy',
        'A SnackBar takes a content Widget, an optional SnackBarAction, a SnackBarBehavior (fixed or floating), a duration, and styling such as backgroundColor, shape, margin, padding, width and elevation.',
      ),
      inlineSnack(snackBasic, 'Basic + UNDO action'),
      inlineSnack(snackFloating, 'Floating + close icon (M3)'),
      inlineSnack(snackWidthed, 'Floating + width override'),
      inlineSnack(snackRich, 'Rich Row content'),
      inlineSnack(snackDestructive, 'Destructive action color'),
      inlineSnack(snackInfo, 'Long-duration informational'),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: SnackBarBehavior comparison + ScaffoldMessengerState reference
// ---------------------------------------------------------------------------
Widget _buildBehaviorComparison() {
  print('[section 4] SnackBarBehavior comparison');

  Widget behaviorCard(String name, String description, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.08),
        border: Border.all(color: tint, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: tint,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(description, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Indexed iteration over a local list with primitive values.
  final List<List<dynamic>> behaviors = <List<dynamic>>[
    <dynamic>[
      'SnackBarBehavior.fixed',
      SnackBarBehavior.fixed,
      'Snaps to the bottom of the Scaffold body. The FAB lifts above it; the BottomNavigationBar stays put. No margin or width is honored.',
      const Color(0xFF1565C0),
    ],
    <dynamic>[
      'SnackBarBehavior.floating',
      SnackBarBehavior.floating,
      'Floats above the BottomNavigationBar with margin/width respected. Pairs nicely with rounded corners and elevation. Stacks above the FAB.',
      const Color(0xFFD81B60),
    ],
  ];

  final List<Widget> cards = <Widget>[];
  for (var i = 0; i < behaviors.length; i++) {
    cards.add(
      behaviorCard(
        behaviors[i][0] as String,
        behaviors[i][2] as String,
        behaviors[i][3] as Color,
      ),
    );
  }

  // Messenger reference card (no live messenger used).
  final ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? noController =
      null;

  Widget messengerReference() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF263238),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'ScaffoldMessengerState API surface (descriptive)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < 6; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                <String>[
                  'showSnackBar(SnackBar) -> Controller<SnackBar, SnackBarClosedReason>',
                  'hideCurrentSnackBar({reason: SnackBarClosedReason.hide})',
                  'removeCurrentSnackBar({reason: SnackBarClosedReason.remove})',
                  'clearSnackBars() — drops the entire queue',
                  'showMaterialBanner(MaterialBanner) -> Controller<…, MaterialBannerClosedReason>',
                  'hideCurrentMaterialBanner(), removeCurrentMaterialBanner(), clearMaterialBanners()',
                ][i],
                style: const TextStyle(
                  color: Color(0xFFB0BEC5),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          const SizedBox(height: 8),
          Text(
            'demo controller binding (not invoked at runtime): '
            '${noController == null ? 'null — purely descriptive' : 'bound'}',
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget closedReasonRow() {
    // Enumerate SnackBarClosedReason and MaterialBannerClosedReason.
    final List<SnackBarClosedReason> reasons = <SnackBarClosedReason>[
      SnackBarClosedReason.action,
      SnackBarClosedReason.dismiss,
      SnackBarClosedReason.swipe,
      SnackBarClosedReason.hide,
      SnackBarClosedReason.remove,
      SnackBarClosedReason.timeout,
    ];
    final List<Widget> chips = <Widget>[];
    for (var i = 0; i < reasons.length; i++) {
      chips.add(
        _labelChip(
          reasons[i].toString().split('.').last,
          const Color(0xFF455A64),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'SnackBarClosedReason values',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Wrap(spacing: 6, runSpacing: 4, children: chips),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(
        '4. SnackBarBehavior vs ScaffoldMessenger',
        'How the two SnackBarBehavior values change positioning, plus the messenger API the demo deliberately does NOT trigger.',
      ),
      ...cards,
      messengerReference(),
      closedReasonRow(),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: MaterialBanner gallery
// ---------------------------------------------------------------------------
Widget _buildMaterialBannerGallery() {
  print('[section 5] MaterialBanner gallery');

  Widget inlineBanner(MaterialBanner banner, String tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              tag,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF455A64),
              ),
            ),
          ),
          Material(
            elevation: 0,
            color: Colors.transparent,
            child: banner,
          ),
        ],
      ),
    );
  }

  // 5a. Update available banner.
  final MaterialBanner bannerUpdate = MaterialBanner(
    content: const Text('A new version of the app is available.'),
    leading: const CircleAvatar(
      backgroundColor: Color(0xFF1976D2),
      child: Icon(Icons.system_update, color: Colors.white),
    ),
    backgroundColor: const Color(0xFFE3F2FD),
    contentTextStyle: const TextStyle(
      color: Color(0xFF0D47A1),
      fontWeight: FontWeight.w600,
    ),
    actions: <Widget>[
      TextButton(onPressed: () {}, child: const Text('LATER')),
      TextButton(onPressed: () {}, child: const Text('UPDATE NOW')),
    ],
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  // 5b. Critical warning banner.
  final MaterialBanner bannerWarning = MaterialBanner(
    content: const Text(
      'Your subscription expires in 3 days. Renew to avoid losing access.',
    ),
    leading: const Icon(Icons.warning, color: Colors.deepOrange),
    backgroundColor: const Color(0xFFFFF3E0),
    forceActionsBelow: true,
    actions: <Widget>[
      TextButton(onPressed: () {}, child: const Text('RENEW')),
      TextButton(onPressed: () {}, child: const Text('DISMISS')),
    ],
  );

  // 5c. Offline indicator banner.
  final MaterialBanner bannerOffline = MaterialBanner(
    content: const Text("You're offline. Changes will sync when reconnected."),
    leading: const Icon(Icons.cloud_off, color: Color(0xFF455A64)),
    backgroundColor: const Color(0xFFECEFF1),
    actions: <Widget>[
      TextButton(onPressed: () {}, child: const Text('RETRY')),
    ],
    dividerColor: const Color(0xFF90A4AE),
  );

  // 5d. Marketing/announcement banner with rich content.
  final MaterialBanner bannerAnnouncement = MaterialBanner(
    content: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF8E24AA),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'NEW',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text('Try the redesigned dashboard with custom widgets.'),
        ),
      ],
    ),
    leading: const Icon(Icons.campaign, color: Color(0xFF8E24AA)),
    backgroundColor: const Color(0xFFF3E5F5),
    actions: <Widget>[
      TextButton(onPressed: () {}, child: const Text('EXPLORE')),
    ],
  );

  // Enumerate the closed-reason values for material banners as well.
  final List<MaterialBannerClosedReason> closedReasons =
      <MaterialBannerClosedReason>[
    MaterialBannerClosedReason.dismiss,
    MaterialBannerClosedReason.swipe,
    MaterialBannerClosedReason.hide,
    MaterialBannerClosedReason.remove,
  ];

  final List<Widget> reasonChips = <Widget>[];
  for (var i = 0; i < closedReasons.length; i++) {
    reasonChips.add(
      _labelChip(
        closedReasons[i].toString().split('.').last,
        const Color(0xFF6A1B9A),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(
        '5. MaterialBanner Gallery',
        'MaterialBanner is shown via ScaffoldMessenger like SnackBar, but is sticky and lives at the top of the body.',
      ),
      _explainCard(
        'When to use MaterialBanner',
        'Use a banner for persistent, lower-priority information that the user should acknowledge — outages, subscription notices, update prompts. SnackBars are transient; banners stay until dismissed.',
      ),
      inlineBanner(bannerUpdate, 'Update available'),
      inlineBanner(bannerWarning, 'Critical warning (forceActionsBelow)'),
      inlineBanner(bannerOffline, 'Offline indicator'),
      inlineBanner(bannerAnnouncement, 'Announcement with rich content'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'MaterialBannerClosedReason values',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Wrap(spacing: 6, runSpacing: 4, children: reasonChips),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: FloatingActionButton shape/colour catalog (constructors)
// ---------------------------------------------------------------------------
Widget _buildFabCatalog() {
  print('[section 6] FAB constructor catalog');

  Widget cell(String label, Widget fab, String detail) {
    return Container(
      width: 180,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCFD8DC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 70, child: Center(child: fab)),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            detail,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  final FloatingActionButton fabRegular = FloatingActionButton(
    onPressed: () {},
    backgroundColor: const Color(0xFF1E88E5),
    foregroundColor: Colors.white,
    tooltip: 'Compose',
    child: const Icon(Icons.edit),
  );

  final FloatingActionButton fabSmall = FloatingActionButton.small(
    onPressed: () {},
    backgroundColor: const Color(0xFFD81B60),
    child: const Icon(Icons.favorite),
    tooltip: 'Like',
  );

  final FloatingActionButton fabLarge = FloatingActionButton.large(
    onPressed: () {},
    backgroundColor: const Color(0xFF6A1B9A),
    foregroundColor: Colors.white,
    child: const Icon(Icons.send),
  );

  final FloatingActionButton fabExtended = FloatingActionButton.extended(
    onPressed: () {},
    backgroundColor: const Color(0xFF00897B),
    foregroundColor: Colors.white,
    icon: const Icon(Icons.cloud_upload),
    label: const Text('Upload'),
  );

  final FloatingActionButton fabHero = FloatingActionButton(
    onPressed: () {},
    backgroundColor: const Color(0xFFFFA000),
    heroTag: 'fab_hero_explicit',
    elevation: 8,
    highlightElevation: 14,
    child: const Icon(Icons.bolt),
  );

  final FloatingActionButton fabShaped = FloatingActionButton(
    onPressed: () {},
    backgroundColor: const Color(0xFF455A64),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: const Icon(Icons.dashboard),
  );

  final FloatingActionButton fabMini = FloatingActionButton(
    onPressed: () {},
    mini: true,
    backgroundColor: const Color(0xFF388E3C),
    child: const Icon(Icons.check),
  );

  final FloatingActionButton fabDisabled = FloatingActionButton(
    onPressed: null,
    backgroundColor: Colors.grey.shade400,
    child: const Icon(Icons.lock, color: Colors.white70),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(
        '6. FloatingActionButton Constructor Catalog',
        'Regular, small, large, extended, mini, themed and disabled variants — paired with the location grid above.',
      ),
      _explainCard(
        'Picking a FAB size',
        'Use the default for primary actions, .small inside compact contexts, .large for hero-style screens, and .extended when the action benefits from a label. mini is a legacy compact form mostly replaced by .small in Material 3.',
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Wrap(
          children: <Widget>[
            cell('regular', fabRegular, 'standard 56dp circular'),
            cell('small', fabSmall, '40dp from .small constructor'),
            cell('large', fabLarge, '96dp from .large constructor'),
            cell('extended', fabExtended, 'pill with icon + label'),
            cell('with heroTag', fabHero, 'explicit heroTag and elevation'),
            cell('custom shape', fabShaped, 'RoundedRectangleBorder shape'),
            cell('mini', fabMini, 'legacy 40dp via mini:true'),
            cell('disabled', fabDisabled, 'onPressed null disables ripple'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: Scaffold layout reference card (FAB + bottom-bar + sheet)
// ---------------------------------------------------------------------------
Widget _buildLayoutReference() {
  print('[section 7] Scaffold layout reference');

  Widget row(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170,
            child: Text(
              left,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF263238),
              ),
            ),
          ),
          Expanded(
            child: Text(
              right,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF37474F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Coexistence preview: a stylised Scaffold body with an active bottom sheet
  // and a docked FAB, side-by-side with a notched BottomAppBar.
  Widget preview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 260,
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB0BEC5)),
      ),
      child: Stack(
        children: <Widget>[
          // AppBar strip
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF1A237E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Text(
                'AppBar',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          // Body content placeholder
          Positioned.fill(
            top: 36,
            bottom: 100,
            child: Container(
              color: const Color(0xFFFAFAFA),
              alignment: Alignment.center,
              child: const Text(
                'Scrollable body',
                style: TextStyle(color: Color(0xFF607D8B), fontSize: 13),
              ),
            ),
          ),
          // Persistent bottom sheet just above the bottom bar
          Positioned(
            left: 12,
            right: 12,
            bottom: 50,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: const <Widget>[
                  Icon(Icons.music_note, color: Color(0xFF455A64)),
                  SizedBox(width: 10),
                  Text('Persistent bottom sheet'),
                ],
              ),
            ),
          ),
          // Notched bottom bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFCFD8DC),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: const <Widget>[
                  Icon(Icons.home, color: Color(0xFF455A64)),
                  SizedBox(width: 18),
                  Icon(Icons.search, color: Color(0xFF455A64)),
                  Spacer(),
                  Icon(Icons.account_circle, color: Color(0xFF455A64)),
                ],
              ),
            ),
          ),
          // Docked FAB straddling the bar
          Positioned(
            right: 24,
            bottom: 26,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFEF6C00),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(
        '7. Scaffold Coexistence Reference',
        'How FAB locations interact with BottomNavigationBar, BottomAppBar, and persistent bottom sheets.',
      ),
      _explainCard(
        'Layout precedence',
        'Scaffold passes the FAB position to the FloatingActionButtonAnimator each frame. The location resolves an Offset based on the current viewport size, the bottom bar height, any visible SnackBar, and the bottom sheet metrics.',
      ),
      preview(),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFB0BEC5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Resolution rules',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            row('FAB + SnackBar fixed',
                'FAB lifts to clear the SnackBar height.'),
            row('FAB + SnackBar floating',
                'SnackBar floats above the FAB; FAB stays put.'),
            row('FAB + BottomNavigationBar',
                'endFloat sits above the bar; endDocked overlaps the seam.'),
            row('FAB + BottomAppBar (notched)',
                'centerDocked is canonical so the notch lines up.'),
            row('FAB + persistent bottom sheet',
                'FAB lifts above the sheet automatically.'),
            row('FAB + extendBody:true',
                'Body extends behind the bar; FAB position unaffected.'),
            row('FAB + extendBodyBehindAppBar:true',
                '*Top FAB variants overlap the AppBar gradient.'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: Theming — SnackBarThemeData and MaterialBannerThemeData
// ---------------------------------------------------------------------------
Widget _buildThemingSection() {
  print('[section 8] Theming with SnackBarThemeData');

  // Build three SnackBarThemeData instances illustrating different visual
  // languages. We do not apply them via Theme — we render the parameters in a
  // visual card so the test driver can inspect them.

  final SnackBarThemeData themeNeutral = SnackBarThemeData(
    backgroundColor: const Color(0xFF323232),
    contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
    actionTextColor: const Color(0xFFFFC107),
    behavior: SnackBarBehavior.fixed,
    elevation: 6,
    shape: const RoundedRectangleBorder(),
    showCloseIcon: false,
  );

  final SnackBarThemeData themeBranded = SnackBarThemeData(
    backgroundColor: const Color(0xFF1565C0),
    contentTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    actionTextColor: const Color(0xFFFFEB3B),
    disabledActionTextColor: const Color(0xFF90CAF9),
    behavior: SnackBarBehavior.floating,
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    showCloseIcon: true,
    closeIconColor: Colors.white,
    insetPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
  );

  final SnackBarThemeData themeDark = SnackBarThemeData(
    backgroundColor: const Color(0xFF0D1117),
    contentTextStyle: const TextStyle(
      color: Color(0xFFE6EDF3),
      fontSize: 13,
      fontFamily: 'monospace',
    ),
    actionTextColor: const Color(0xFF58A6FF),
    behavior: SnackBarBehavior.floating,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
      side: const BorderSide(color: Color(0xFF30363D)),
    ),
  );

  final MaterialBannerThemeData bannerTheme = MaterialBannerThemeData(
    backgroundColor: const Color(0xFFFFF8E1),
    contentTextStyle: const TextStyle(
      color: Color(0xFF6D4C41),
      fontSize: 13,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    dividerColor: const Color(0xFFD7CCC8),
    elevation: 1,
  );

  Widget themeCard(String label, SnackBarThemeData t, String narration) {
    final Color bg = t.backgroundColor ?? Colors.black;
    final TextStyle contentStyle =
        t.contentTextStyle ?? const TextStyle(color: Colors.white);
    final Color actionColor = t.actionTextColor ?? Colors.amber;
    final BorderRadius radius = t.shape is RoundedRectangleBorder
        ? ((t.shape as RoundedRectangleBorder).borderRadius
            as BorderRadius)
        : BorderRadius.zero;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCFD8DC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF263238),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            narration,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 10),
          // Visual mock of a SnackBar styled by the theme.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: radius,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: t.elevation ?? 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('Themed SnackBar content', style: contentStyle),
                ),
                Text(
                  'ACTION',
                  style: TextStyle(
                    color: actionColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: <Widget>[
              _labelChip(
                'behavior=${t.behavior}',
                const Color(0xFF1565C0),
              ),
              _labelChip(
                'elevation=${t.elevation}',
                const Color(0xFF6A1B9A),
              ),
              _labelChip(
                'showClose=${t.showCloseIcon}',
                const Color(0xFF2E7D32),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bannerThemePreview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCFD8DC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'MaterialBannerThemeData',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF263238),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Customize background, padding and content text style for every'
            ' MaterialBanner inside the theme scope.',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 10),
          Container(
            padding: bannerTheme.padding as EdgeInsetsGeometry,
            decoration: BoxDecoration(
              color: bannerTheme.backgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: bannerTheme.dividerColor ?? Colors.grey,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.info_outline, color: Color(0xFF6D4C41)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Themed banner content using MaterialBannerThemeData.',
                    style: bannerTheme.contentTextStyle,
                  ),
                ),
                Text(
                  'OK',
                  style: TextStyle(
                    color: bannerTheme.contentTextStyle?.color,
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

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(
        '8. Theming SnackBars and MaterialBanners',
        'SnackBarThemeData and MaterialBannerThemeData centralise styling. The mock previews here render the theme parameters verbatim.',
      ),
      themeCard(
        'Neutral (default-ish)',
        themeNeutral,
        'Dark grey background, amber action — close to the Material 2 default.',
      ),
      themeCard(
        'Branded floating',
        themeBranded,
        'Brand-blue background, yellow action label, generous rounding.',
      ),
      themeCard(
        'Dark monospace',
        themeDark,
        'GitHub-style palette with a monospace content style for developer tools.',
      ),
      bannerThemePreview(),
      _explainCard(
        'Where themes apply',
        'Place SnackBarThemeData inside ThemeData.snackBarTheme. ScaffoldMessenger resolves the effective theme from the nearest Theme, so wrapping a sub-tree with a different Theme is a viable way to scope styling.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Quick-reference summary card
// ---------------------------------------------------------------------------
Widget _buildSummary() {
  print('[section 9] Summary');

  final List<List<String>> rows = <List<String>>[
    <String>['FAB locations (named)', '20 named values'],
    <String>['FAB animators', 'scaling, noAnimation'],
    <String>['SnackBarBehavior', 'fixed, floating'],
    <String>['SnackBarClosedReason',
        'action, dismiss, swipe, hide, remove, timeout'],
    <String>['MaterialBannerClosedReason',
        'dismiss, swipe, hide, remove'],
    <String>['Messenger entry points',
        'showSnackBar, hideCurrentSnackBar, removeCurrentSnackBar, clearSnackBars'],
    <String>['Banner entry points',
        'showMaterialBanner, hideCurrentMaterialBanner, removeCurrentMaterialBanner, clearMaterialBanners'],
    <String>['Theming', 'SnackBarThemeData + MaterialBannerThemeData'],
  ];

  final List<Widget> rowWidgets = <Widget>[];
  for (var i = 0; i < rows.length; i++) {
    rowWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Text(
                rows[i][0],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
            Expanded(
              child: Text(
                rows[i][1],
                style: const TextStyle(fontSize: 12, color: Color(0xFF263238)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(
        '9. Quick-reference Summary',
        'Everything exercised by this demo at a glance.',
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F6FF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC5CAE9)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowWidgets,
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// build entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('=== fablocation_messenger_test: starting deep visual demo ===');

  // Eagerly evaluate each section in its own local so we can log between them.
  final Widget s1 = _buildLocationGrid();
  print('section 1 built');
  final Widget s2 = _buildAnimatorCatalog();
  print('section 2 built');
  final Widget s3 = _buildSnackBarGallery();
  print('section 3 built');
  final Widget s4 = _buildBehaviorComparison();
  print('section 4 built');
  final Widget s5 = _buildMaterialBannerGallery();
  print('section 5 built');
  final Widget s6 = _buildFabCatalog();
  print('section 6 built');
  final Widget s7 = _buildLayoutReference();
  print('section 7 built');
  final Widget s8 = _buildThemingSection();
  print('section 8 built');
  final Widget s9 = _buildSummary();
  print('section 9 built');

  // A title header pinned at the top of the scrolling demo.
  final Widget header = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1A237E), Color(0xFF3949AB)],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'FAB Location & ScaffoldMessenger',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Hand-authored visual catalog for the d4rt interpreter test corpus. '
          'No async, no setState, no live messenger calls — every widget is '
          'constructed statically.',
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    ),
  );

  final Widget footer = Padding(
    padding: const EdgeInsets.fromLTRB(16, 32, 16, 48),
    child: Row(
      children: <Widget>[
        const Icon(Icons.flag, color: Color(0xFF1A237E)),
        const SizedBox(width: 10),
        Expanded(
          child: const Text(
            'End of demo. All sections built without invoking ScaffoldMessenger.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A237E),
            ),
          ),
        ),
      ],
    ),
  );

  print('=== fablocation_messenger_test: assembling root ListView ===');

  return Directionality(
    textDirection: TextDirection.ltr,
    child: Material(
      color: const Color(0xFFFAFAFA),
      child: ListView(
        children: <Widget>[
          header,
          s1,
          s2,
          s3,
          s4,
          s5,
          s6,
          s7,
          s8,
          s9,
          footer,
        ],
      ),
    ),
  );
}
