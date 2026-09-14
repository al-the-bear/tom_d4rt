// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =============================================================================
//  OverlayPortal — A Hand-Authored Visual Deep Demo
// =============================================================================
//
//  This file replaces a previous tiny fixture with a long-form, fully static
//  visual gallery for Flutter's `OverlayPortal` widget. The page is designed
//  to look stunning even though nothing in it actually animates or reacts to
//  user input — the constrained sandbox in which this script runs forbids
//  stateful widgets, controllers, async work, and any ticker-driven animation.
//
//  Because of that, every "popped overlay" you see below is a *simulation*:
//  ordinary `Stack` + `Positioned` widgets dressed up to mimic what the user
//  would see if a real `OverlayPortalController` had been toggled to `show()`.
//  The prose throughout the page makes that distinction explicit so a reader
//  is never misled into thinking these renderings are live.
//
//  Sections (>= 8 required, this file ships 10):
//    1.  Hero / wordmark card — what OverlayPortal actually is.
//    2.  Anatomy diagram — anchor child, overlay child, ancestor Overlay.
//    3.  Simulated tooltip floating above an anchor button.
//    4.  Simulated dropdown menu pinned above a fake TextField.
//    5.  Floating action panel — emoji picker / chips shelf composite.
//    6.  Comparison table — OverlayPortal vs Overlay.insert vs showDialog.
//    7.  OverlayPortalController lifecycle table.
//    8.  Code listing card with realistic OverlayPortal usage.
//    9.  Pitfalls and gotchas — constraints, theme, hit-testing, focus.
//   10.  Footer with palette swatches and version metadata.
//
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
//  Palette — a cohesive, deep, slightly-violet documentation palette. Kept as
//  top-level constants so every section can pull from the same set without
//  redefining magic colours.
// -----------------------------------------------------------------------------

const Color _kBackgroundDeep = Color(0xFF0B0B1A);
const Color _kBackgroundMid = Color(0xFF141430);
const Color _kSurface = Color(0xFF1C1C3D);
const Color _kSurfaceRaised = Color(0xFF24244C);
const Color _kSurfaceHigher = Color(0xFF2E2E5C);

const Color _kBorder = Color(0xFF383866);
const Color _kBorderSoft = Color(0xFF2A2A55);

const Color _kAccentViolet = Color(0xFF9D7CFF);
const Color _kAccentCyan = Color(0xFF7CE0FF);
const Color _kAccentPink = Color(0xFFFF7CC0);
const Color _kAccentLime = Color(0xFFB6FF7C);
const Color _kAccentAmber = Color(0xFFFFC97C);
const Color _kAccentTeal = Color(0xFF7CFFD4);

const Color _kTextPrimary = Color(0xFFEDEDFF);
const Color _kTextSecondary = Color(0xFFB6B6E2);
const Color _kTextMuted = Color(0xFF8080AE);
const Color _kTextCode = Color(0xFFE0E0FF);

const String _kVersion = '0.10.0+overlayportal-static-demo';
const String _kSubject = 'Flutter widget · OverlayPortal';
const String _kAuthor = 'D4rt analyzer-free interpreter test corpus';

// -----------------------------------------------------------------------------
//  Build entry point — the only top-level function the harness invokes.
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'OverlayPortal — Visual Deep Demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kBackgroundDeep,
      primaryColor: _kAccentViolet,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: _kBackgroundDeep,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heroCard(),
            SizedBox(height: 36),
            _anatomyCard(),
            SizedBox(height: 36),
            _tooltipSimulationCard(),
            SizedBox(height: 36),
            _dropdownSimulationCard(),
            SizedBox(height: 36),
            _floatingPanelCard(),
            SizedBox(height: 36),
            _comparisonCard(),
            SizedBox(height: 36),
            _controllerLifecycleCard(),
            SizedBox(height: 36),
            _codeListingCard(),
            SizedBox(height: 36),
            _pitfallsCard(),
            SizedBox(height: 36),
            _footerCard(),
            SizedBox(height: 48),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
//  Reusable visual primitives — kept as top-level helpers so each section
//  composes from the same vocabulary instead of hand-rolling identical chrome.
// =============================================================================

Widget _sectionShell({
  required String tag,
  required String title,
  required String lede,
  required Widget child,
  Color accent = _kAccentViolet,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _kBorderSoft, width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 24,
          offset: Offset(0, 12),
        ),
        BoxShadow(
          color: accent.withValues(alpha: 0.06),
          blurRadius: 60,
          spreadRadius: 2,
          offset: Offset(0, 0),
        ),
      ],
    ),
    padding: EdgeInsets.fromLTRB(28, 24, 28, 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(tag: tag, title: title, accent: accent),
        SizedBox(height: 12),
        Text(
          lede,
          style: TextStyle(
            color: _kTextSecondary,
            fontSize: 14.5,
            height: 1.55,
          ),
        ),
        SizedBox(height: 22),
        child,
      ],
    ),
  );
}

Widget _sectionHeader({
  required String tag,
  required String title,
  required Color accent,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: accent.withValues(alpha: 0.45), width: 1),
        ),
        child: Text(
          tag,
          style: TextStyle(
            color: accent,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
      ),
      SizedBox(width: 14),
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            color: _kTextPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
        ),
      ),
    ],
  );
}

Widget _label({required String text, required Color color, double size = 11}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.7,
      ),
    ),
  );
}

Widget _bodyParagraph(String text, {double topGap = 8}) {
  return Padding(
    padding: EdgeInsets.only(top: topGap),
    child: Text(
      text,
      style: TextStyle(
        color: _kTextSecondary,
        fontSize: 14,
        height: 1.6,
      ),
    ),
  );
}

Widget _dividerLine() {
  return Container(
    height: 1,
    margin: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _kBorderSoft.withValues(alpha: 0.0),
          _kBorder.withValues(alpha: 0.9),
          _kBorderSoft.withValues(alpha: 0.0),
        ],
      ),
    ),
  );
}

// =============================================================================
//  Section 1 — Hero / wordmark card
// =============================================================================

Widget _heroCard() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _kAccentViolet.withValues(alpha: 0.32),
          _kAccentCyan.withValues(alpha: 0.18),
          _kSurface,
        ],
      ),
      borderRadius: BorderRadius.circular(28),
      border: Border.all(color: _kBorder, width: 1),
      boxShadow: [
        BoxShadow(
          color: _kAccentViolet.withValues(alpha: 0.20),
          blurRadius: 60,
          spreadRadius: 4,
          offset: Offset(0, 18),
        ),
      ],
    ),
    padding: EdgeInsets.fromLTRB(32, 30, 32, 34),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _label(text: 'WIDGET · ANATOMY', color: _kAccentCyan),
            SizedBox(width: 10),
            _label(text: 'STATIC DEMO', color: _kAccentPink),
            SizedBox(width: 10),
            _label(text: 'NO RUNTIME I/O', color: _kAccentAmber),
          ],
        ),
        SizedBox(height: 18),
        Text(
          'OverlayPortal',
          style: TextStyle(
            color: _kTextPrimary,
            fontSize: 56,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.6,
            height: 1.0,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'A leaf-level escape hatch into the ancestor Overlay',
          style: TextStyle(
            color: _kAccentViolet,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 22),
        Text(
          'OverlayPortal lets a deep-tree widget mount a second child into the '
          'nearest ancestor Overlay without you holding an OverlayEntry, '
          'without you calling Overlay.of(context).insert, and without losing '
          'the InheritedWidget context of the call site. The widget owns the '
          'lifetime of its overlay child, and an OverlayPortalController '
          'flips it on or off the way a Visibility widget would — except the '
          'painted result lands above every other route content.',
          style: TextStyle(
            color: _kTextSecondary,
            fontSize: 15.5,
            height: 1.7,
          ),
        ),
        SizedBox(height: 22),
        Container(
          padding: EdgeInsets.fromLTRB(18, 14, 18, 14),
          decoration: BoxDecoration(
            color: _kBackgroundDeep.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kBorderSoft, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 18, color: _kAccentCyan),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Heads-up: every "popped" overlay on this page is a static '
                  'simulation built from Stack + Positioned. The sandbox '
                  'forbids OverlayPortalController.show()/hide() at runtime, '
                  'so the visuals you see below show what the user would see '
                  'after a controller toggle, not the live thing.',
                  style: TextStyle(
                    color: _kTextSecondary,
                    fontSize: 13,
                    height: 1.55,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18),
        Row(
          children: [
            _statChip('Repaints scoped', _kAccentLime),
            SizedBox(width: 10),
            _statChip('No global keys', _kAccentTeal),
            SizedBox(width: 10),
            _statChip('Theme-stable', _kAccentAmber),
            SizedBox(width: 10),
            _statChip('Route-aware', _kAccentPink),
          ],
        ),
      ],
    ),
  );
}

Widget _statChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 7),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  Section 2 — Anatomy diagram
// =============================================================================

Widget _anatomyCard() {
  return _sectionShell(
    tag: 'SECTION 02 · ANATOMY',
    title: 'Where the overlay child actually lives',
    lede:
        'OverlayPortal looks like a single widget at your call site, but it '
        'reaches up the element tree to find the nearest Overlay and adopts '
        'a second subtree there. The diagram below labels the three '
        'co-operating parts of the picture.',
    accent: _kAccentCyan,
    child: _anatomyDiagram(),
  );
}

Widget _anatomyDiagram() {
  return Container(
    height: 360,
    decoration: BoxDecoration(
      color: _kBackgroundMid,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kBorderSoft),
    ),
    padding: EdgeInsets.fromLTRB(22, 22, 22, 22),
    child: Stack(
      children: [
        // Ambient accent glow.
        Positioned(
          top: -40,
          right: -40,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  _kAccentCyan.withValues(alpha: 0.24),
                  _kAccentCyan.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        // Ancestor Overlay frame.
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _kAccentCyan.withValues(alpha: 0.5),
                width: 1.4,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        Positioned(
          left: 14,
          top: 8,
          child: _label(text: 'ancestor Overlay', color: _kAccentCyan),
        ),
        // Anchor child block.
        Positioned(
          left: 30,
          bottom: 30,
          child: Container(
            width: 220,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSurfaceRaised,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccentViolet, width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label(text: 'anchor child', color: _kAccentViolet, size: 10),
                SizedBox(height: 8),
                Text(
                  'OverlayPortal(\n  child: <here>,\n  ...,\n)',
                  style: TextStyle(
                    color: _kTextCode,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Floating overlay child block.
        Positioned(
          right: 30,
          top: 60,
          child: Container(
            width: 240,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSurfaceHigher,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccentPink, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: _kAccentPink.withValues(alpha: 0.25),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label(text: 'overlay child', color: _kAccentPink, size: 10),
                SizedBox(height: 8),
                Text(
                  'overlayChildBuilder:\n  (ctx) => Positioned(\n    ...\n  )',
                  style: TextStyle(
                    color: _kTextCode,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Connector line drawing.
        Positioned.fill(
          child: CustomPaint(
            painter: _AnatomyConnectorPainter(),
          ),
        ),
        // Connector caption.
        Positioned(
          left: 0,
          right: 0,
          top: 168,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _kBackgroundDeep,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kBorderSoft),
              ),
              child: Text(
                'controller.show() lifts the overlayChild into the ancestor Overlay',
                style: TextStyle(
                  color: _kTextSecondary,
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _AnatomyConnectorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = _kAccentPink.withValues(alpha: 0.6)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    final Path path = Path();
    final double startX = 250;
    final double startY = size.height - 90;
    final double endX = size.width - 270;
    final double endY = 110;
    path.moveTo(startX, startY);
    path.cubicTo(
      startX + 80, startY - 20,
      endX - 60, endY + 60,
      endX, endY,
    );
    canvas.drawPath(path, p);
    // Arrow head at end
    final Paint head = Paint()..color = _kAccentPink;
    final Path arrow = Path();
    arrow.moveTo(endX, endY);
    arrow.lineTo(endX - 8, endY - 4);
    arrow.lineTo(endX - 8, endY + 4);
    arrow.close();
    canvas.drawPath(arrow, head);
  }

  @override
  bool shouldRepaint(covariant _AnatomyConnectorPainter oldDelegate) => false;
}

// =============================================================================
//  Section 3 — Simulated tooltip
// =============================================================================

Widget _tooltipSimulationCard() {
  return _sectionShell(
    tag: 'SECTION 03 · TOOLTIP',
    title: 'A tooltip "popping" above its anchor button',
    lede:
        'A real OverlayPortal tooltip would mount a Positioned bubble into '
        'the surrounding Overlay above its anchor when controller.show() is '
        'called. Below is the would-be visual, statically composed.',
    accent: _kAccentPink,
    child: _tooltipScene(),
  );
}

Widget _tooltipScene() {
  return Container(
    height: 280,
    decoration: BoxDecoration(
      color: _kBackgroundMid,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kBorderSoft),
    ),
    padding: EdgeInsets.all(22),
    child: Stack(
      children: [
        // Fake page content beneath.
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 14,
                width: 220,
                decoration: BoxDecoration(
                  color: _kSurfaceRaised,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 10,
                width: 380,
                decoration: BoxDecoration(
                  color: _kSurfaceRaised.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 10,
                width: 320,
                decoration: BoxDecoration(
                  color: _kSurfaceRaised.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 18),
              Container(
                height: 10,
                width: 280,
                decoration: BoxDecoration(
                  color: _kSurfaceRaised.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
        // Anchor button.
        Positioned(
          left: 60,
          bottom: 40,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kAccentViolet, _kAccentPink],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: _kAccentViolet.withValues(alpha: 0.45),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.help_outline, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  'What is OverlayPortal?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Floating tooltip bubble.
        Positioned(
          left: 38,
          bottom: 110,
          child: _TooltipBubble(),
        ),
      ],
    ),
  );
}

class _TooltipBubble extends StatelessWidget {
  const _TooltipBubble();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TooltipTailPainter(),
      child: Container(
        width: 290,
        padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
        decoration: BoxDecoration(
          color: _kSurfaceHigher,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kAccentPink.withValues(alpha: 0.6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 22,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _label(text: 'TOOLTIP', color: _kAccentPink, size: 9),
                SizedBox(width: 8),
                Text(
                  'overlayChildBuilder',
                  style: TextStyle(
                    color: _kTextMuted,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'A widget that hosts a second child inside the nearest '
              'ancestor Overlay, controlled by an '
              'OverlayPortalController.',
              style: TextStyle(
                color: _kTextPrimary,
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TooltipTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()..color = _kSurfaceHigher;
    final Path path = Path()
      ..moveTo(40, size.height)
      ..lineTo(50, size.height + 10)
      ..lineTo(60, size.height)
      ..close();
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant _TooltipTailPainter oldDelegate) => false;
}

// =============================================================================
//  Section 4 — Simulated dropdown menu
// =============================================================================

Widget _dropdownSimulationCard() {
  return _sectionShell(
    tag: 'SECTION 04 · DROPDOWN',
    title: 'A dropdown anchored to a TextField',
    lede:
        'OverlayPortal is the canonical primitive for autocomplete-style '
        'dropdowns: the menu sits in the Overlay so it can paint above '
        'sibling routes, but it is built from the field\'s own context so '
        'Theme and DefaultTextStyle inherit naturally.',
    accent: _kAccentAmber,
    child: _dropdownScene(),
  );
}

Widget _dropdownScene() {
  return Container(
    decoration: BoxDecoration(
      color: _kBackgroundMid,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kBorderSoft),
    ),
    padding: EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Fake form field.
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _kSurfaceRaised,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kAccentAmber.withValues(alpha: 0.6)),
          ),
          child: Row(
            children: [
              Icon(Icons.search, size: 18, color: _kAccentAmber),
              SizedBox(width: 10),
              Text(
                'over',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 14,
                  fontFamily: 'monospace',
                ),
              ),
              Container(
                width: 2,
                height: 16,
                margin: EdgeInsets.only(left: 2),
                color: _kAccentAmber,
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down,
                  size: 18, color: _kTextMuted),
            ],
          ),
        ),
        // Dropdown menu (simulated overlay child).
        Container(
          margin: EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: _kSurfaceHigher,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 24,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            children: [
              _dropdownItem('OverlayPortal', 'widget', _kAccentViolet, true),
              _dropdownDivider(),
              _dropdownItem('OverlayPortalController', 'class', _kAccentCyan,
                  false),
              _dropdownDivider(),
              _dropdownItem('OverlayEntry', 'class', _kAccentPink, false),
              _dropdownDivider(),
              _dropdownItem(
                  'Overlay.of(context)', 'static method', _kAccentLime, false),
              _dropdownDivider(),
              _dropdownItem(
                  'showDialog(...)', 'function', _kAccentAmber, false),
            ],
          ),
        ),
        SizedBox(height: 14),
        Text(
          'Selected: OverlayPortal — typing "over" filters the simulated menu.',
          style: TextStyle(
            color: _kTextMuted,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _dropdownItem(
  String name,
  String kind,
  Color accent,
  bool selected,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: selected
          ? accent.withValues(alpha: 0.15)
          : Colors.transparent,
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
        ),
        SizedBox(width: 12),
        Text(
          name,
          style: TextStyle(
            color: _kTextPrimary,
            fontSize: 14,
            fontFamily: 'monospace',
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        SizedBox(width: 10),
        _label(text: kind, color: accent, size: 9),
        Spacer(),
        if (selected)
          Icon(Icons.check, size: 16, color: accent)
        else
          Icon(Icons.north_east, size: 14, color: _kTextMuted),
      ],
    ),
  );
}

Widget _dropdownDivider() {
  return Container(height: 1, color: _kBorderSoft.withValues(alpha: 0.6));
}

// =============================================================================
//  Section 5 — Floating action panel (emoji picker / chips shelf)
// =============================================================================

Widget _floatingPanelCard() {
  return _sectionShell(
    tag: 'SECTION 05 · FLOATING PANEL',
    title: 'A composite reaction picker, hosted as overlay child',
    lede:
        'OverlayPortal happily hosts non-trivial composites: this one '
        'simulates a reaction shelf that would float above a chat bubble. '
        'Note how the same Theme tokens flow through: a real implementation '
        'would not need a builder workaround, because the overlayChildBuilder '
        'inherits the call site\'s context.',
    accent: _kAccentLime,
    child: _floatingPanelScene(),
  );
}

Widget _floatingPanelScene() {
  return Container(
    height: 320,
    decoration: BoxDecoration(
      color: _kBackgroundMid,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kBorderSoft),
    ),
    padding: EdgeInsets.all(22),
    child: Stack(
      children: [
        // Fake chat thread underneath.
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _chatBubble('Did you push the OverlayPortal demo?', false),
              SizedBox(height: 10),
              _chatBubble('Yes — analyzer-clean, 1200ish lines.', true),
              SizedBox(height: 10),
              _chatBubble('Nice. The reaction picker will be the big one.',
                  false),
            ],
          ),
        ),
        // Floating reaction shelf — simulated overlay child.
        Positioned(
          right: 24,
          top: 80,
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 10, 12, 12),
            decoration: BoxDecoration(
              color: _kSurfaceHigher,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _kAccentLime.withValues(alpha: 0.55)),
              boxShadow: [
                BoxShadow(
                  color: _kAccentLime.withValues(alpha: 0.25),
                  blurRadius: 30,
                  offset: Offset(0, 14),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _label(text: 'OVERLAY CHILD', color: _kAccentLime, size: 9),
                    SizedBox(width: 8),
                    Text(
                      'reactions',
                      style: TextStyle(
                        color: _kTextMuted,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    _reactionChip('👍'),
                    _reactionChip('🎉'),
                    _reactionChip('🔥'),
                    _reactionChip('🧠'),
                    _reactionChip('🚀'),
                    _reactionChip('💜'),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  height: 1,
                  color: _kBorderSoft,
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _categoryChip('Smileys', _kAccentAmber),
                    _categoryChip('People', _kAccentCyan),
                    _categoryChip('Tech', _kAccentViolet),
                    _categoryChip('Animals', _kAccentPink),
                    _categoryChip('Food', _kAccentTeal),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _chatBubble(String text, bool fromMe) {
  return Align(
    alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      constraints: BoxConstraints(maxWidth: 260),
      decoration: BoxDecoration(
        color: fromMe
            ? _kAccentViolet.withValues(alpha: 0.85)
            : _kSurfaceRaised,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft:
              fromMe ? Radius.circular(12) : Radius.circular(2),
          bottomRight:
              fromMe ? Radius.circular(2) : Radius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fromMe ? Colors.white : _kTextPrimary,
          fontSize: 13,
          height: 1.4,
        ),
      ),
    ),
  );
}

Widget _reactionChip(String emoji) {
  return Container(
    margin: EdgeInsets.only(right: 6),
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: _kSurfaceRaised,
      shape: BoxShape.circle,
      border: Border.all(color: _kBorderSoft),
    ),
    alignment: Alignment.center,
    child: Text(emoji, style: TextStyle(fontSize: 18)),
  );
}

Widget _categoryChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// =============================================================================
//  Section 6 — Comparison table
// =============================================================================

Widget _comparisonCard() {
  return _sectionShell(
    tag: 'SECTION 06 · COMPARISON',
    title: 'OverlayPortal vs Overlay.insert vs showDialog',
    lede:
        'Three idiomatic ways to paint above the route exist and they trade '
        'off differently. The table compares lifetime ownership, context '
        'inheritance, route stack interaction, and the canonical use case '
        'each was built for.',
    accent: _kAccentTeal,
    child: _comparisonTable(),
  );
}

Widget _comparisonTable() {
  return Container(
    decoration: BoxDecoration(
      color: _kBackgroundMid,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kBorderSoft),
    ),
    child: Column(
      children: [
        _comparisonHeaderRow(),
        _comparisonRow(
          aspect: 'Lifetime owned by',
          portal: 'the widget itself',
          insert: 'the caller (OverlayEntry)',
          dialog: 'the route stack',
        ),
        _comparisonRow(
          aspect: 'Inherited context',
          portal: 'call-site context',
          insert: 'Overlay\'s context',
          dialog: 'a fresh Navigator route',
        ),
        _comparisonRow(
          aspect: 'Route awareness',
          portal: 'pops with route',
          insert: 'manual',
          dialog: 'Navigator pop pops it',
        ),
        _comparisonRow(
          aspect: 'Best for',
          portal: 'tooltips, popovers, autocomplete',
          insert: 'long-lived chrome',
          dialog: 'modal flows',
        ),
        _comparisonRow(
          aspect: 'Repaint scope',
          portal: 'isolated',
          insert: 'isolated',
          dialog: 'isolated + barrier',
        ),
        _comparisonRow(
          aspect: 'Hit-testable behind',
          portal: 'yes',
          insert: 'yes',
          dialog: 'no — barrier blocks',
        ),
        _comparisonRow(
          aspect: 'Multiple at once',
          portal: 'yes (one per portal)',
          insert: 'yes (stack of entries)',
          dialog: 'discouraged',
        ),
        _comparisonRow(
          aspect: 'Lines of glue',
          portal: 'low',
          insert: 'medium',
          dialog: 'medium',
          isLast: true,
        ),
      ],
    ),
  );
}

Widget _comparisonHeaderRow() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: _kSurfaceRaised,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(13),
        topRight: Radius.circular(13),
      ),
      border: Border(bottom: BorderSide(color: _kBorder)),
    ),
    child: Row(
      children: [
        Expanded(flex: 3, child: _comparisonHeaderCell('Aspect', _kTextMuted)),
        Expanded(
            flex: 3,
            child: _comparisonHeaderCell('OverlayPortal', _kAccentViolet)),
        Expanded(
            flex: 3,
            child: _comparisonHeaderCell('Overlay.insert', _kAccentCyan)),
        Expanded(
            flex: 3,
            child: _comparisonHeaderCell('showDialog', _kAccentPink)),
      ],
    ),
  );
}

Widget _comparisonHeaderCell(String label, Color color) {
  return Text(
    label,
    style: TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.1,
    ),
  );
}

Widget _comparisonRow({
  required String aspect,
  required String portal,
  required String insert,
  required String dialog,
  bool isLast = false,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: isLast
          ? null
          : Border(
              bottom:
                  BorderSide(color: _kBorderSoft.withValues(alpha: 0.6)),
            ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            aspect,
            style: TextStyle(
              color: _kTextSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            portal,
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            insert,
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            dialog,
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  Section 7 — OverlayPortalController lifecycle table
// =============================================================================

Widget _controllerLifecycleCard() {
  // Construct (but never .show() / .hide()) a real controller purely for
  // illustration — its existence at this point in time, and the value of
  // isShowing right after construction, are accurate even in the sandbox.
  final OverlayPortalController illustrativeController =
      OverlayPortalController(debugLabel: 'docs/illustrative');
  final bool initialIsShowing = illustrativeController.isShowing;

  return _sectionShell(
    tag: 'SECTION 07 · LIFECYCLE',
    title: 'OverlayPortalController in five states',
    lede:
        'OverlayPortalController is a thin handle: construct it once, hand it '
        'to your OverlayPortal, then call show() or hide() — or read '
        'isShowing — from your own state object. The table below renders '
        'each transition statically; the widget cannot toggle live here.',
    accent: _kAccentViolet,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _kBackgroundMid,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Row(
            children: [
              Icon(Icons.science_outlined,
                  size: 16, color: _kAccentViolet),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Constructed for the demo: '
                  'OverlayPortalController(debugLabel: "docs/illustrative") · '
                  'initial isShowing = $initialIsShowing',
                  style: TextStyle(
                    color: _kTextSecondary,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _lifecycleTable(),
      ],
    ),
  );
}

Widget _lifecycleTable() {
  return Container(
    decoration: BoxDecoration(
      color: _kBackgroundMid,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kBorderSoft),
    ),
    child: Column(
      children: [
        _lifecycleHeader(),
        _lifecycleRow(
          step: '01',
          state: 'constructed',
          colour: _kAccentTeal,
          isShowing: 'false',
          notes: 'No overlay child mounted yet.',
        ),
        _lifecycleRow(
          step: '02',
          state: 'attached to OverlayPortal',
          colour: _kAccentCyan,
          isShowing: 'false',
          notes: 'Widget builds; only the anchor child paints.',
        ),
        _lifecycleRow(
          step: '03',
          state: 'show() called',
          colour: _kAccentLime,
          isShowing: 'true',
          notes: 'overlayChildBuilder is invoked; child mounted in Overlay.',
        ),
        _lifecycleRow(
          step: '04',
          state: 'rebuild while showing',
          colour: _kAccentAmber,
          isShowing: 'true',
          notes: 'The overlay child rebuilds from the call-site context.',
        ),
        _lifecycleRow(
          step: '05',
          state: 'hide() called',
          colour: _kAccentPink,
          isShowing: 'false',
          notes: 'Overlay child unmounted; anchor stays.',
        ),
        _lifecycleRow(
          step: '06',
          state: 'controller disposed implicitly',
          colour: _kAccentViolet,
          isShowing: 'n/a',
          notes:
              'When the OverlayPortal element unmounts, its controller is '
              'detached and any showing overlay is removed.',
          isLast: true,
        ),
      ],
    ),
  );
}

Widget _lifecycleHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: _kSurfaceRaised,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(13),
        topRight: Radius.circular(13),
      ),
      border: Border(bottom: BorderSide(color: _kBorder)),
    ),
    child: Row(
      children: [
        SizedBox(
            width: 50,
            child: Text('#',
                style: TextStyle(
                    color: _kTextMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w800))),
        Expanded(
          flex: 3,
          child: Text('state',
              style: TextStyle(
                  color: _kTextMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1)),
        ),
        SizedBox(
          width: 110,
          child: Text('isShowing',
              style: TextStyle(
                  color: _kTextMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1)),
        ),
        Expanded(
          flex: 5,
          child: Text('notes',
              style: TextStyle(
                  color: _kTextMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1)),
        ),
      ],
    ),
  );
}

Widget _lifecycleRow({
  required String step,
  required String state,
  required Color colour,
  required String isShowing,
  required String notes,
  bool isLast = false,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: isLast
          ? null
          : Border(
              bottom:
                  BorderSide(color: _kBorderSoft.withValues(alpha: 0.6)),
            ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: colour.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: colour.withValues(alpha: 0.5)),
            ),
            alignment: Alignment.center,
            child: Text(
              step,
              style: TextStyle(
                color: colour,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Text(
            state,
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            isShowing,
            style: TextStyle(
              color: isShowing == 'true' ? _kAccentLime : _kTextMuted,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            notes,
            style: TextStyle(
              color: _kTextSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  Section 8 — Code listing card
// =============================================================================

Widget _codeListingCard() {
  return _sectionShell(
    tag: 'SECTION 08 · CODE',
    title: 'Realistic OverlayPortal usage, in print',
    lede:
        'A canonical pattern: a stateful widget owns the controller, the '
        'OverlayPortal sits next to whatever the user clicks, and the '
        'overlayChildBuilder returns a Positioned bubble. Reproduced as a '
        'static SelectableText so the snippet is copy-pastable.',
    accent: _kAccentCyan,
    child: _codeBlock(_kCodeListing),
  );
}

const String _kCodeListing = '''
class _SearchField extends StatefulWidget {
  const _SearchField();
  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final OverlayPortalController _menu = OverlayPortalController(
    debugLabel: 'search/autocomplete',
  );
  final FocusNode _focus = FocusNode();
  final LayerLink _link = LayerLink();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (_focus.hasFocus) {
        _menu.show();
      } else {
        _menu.hide();
      }
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _menu,
        overlayChildBuilder: (BuildContext context) {
          return Positioned(
            width: 320,
            child: CompositedTransformFollower(
              link: _link,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              offset: const Offset(0, 6),
              showWhenUnlinked: false,
              child: const Material(
                elevation: 8,
                child: _SuggestionsList(),
              ),
            ),
          );
        },
        child: TextField(
          focusNode: _focus,
          onChanged: (s) => setState(() => _query = s),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Search the docs',
          ),
        ),
      ),
    );
  }
}
''';

Widget _codeBlock(String code) {
  return Container(
    decoration: BoxDecoration(
      color: _kBackgroundDeep,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kBorderSoft),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    ),
    padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
            ),
            border: Border(bottom: BorderSide(color: _kBorderSoft)),
          ),
          child: Row(
            children: [
              _windowDot(Color(0xFFFF6E6E)),
              SizedBox(width: 6),
              _windowDot(Color(0xFFFFC97C)),
              SizedBox(width: 6),
              _windowDot(Color(0xFFB6FF7C)),
              SizedBox(width: 14),
              Text(
                'search_field.dart',
                style: TextStyle(
                  color: _kTextSecondary,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Spacer(),
              _label(text: 'OVERLAYPORTAL', color: _kAccentCyan, size: 9),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(18, 14, 18, 0),
          child: SelectableText(
            code,
            style: TextStyle(
              color: _kTextCode,
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _windowDot(Color colour) {
  return Container(
    width: 11,
    height: 11,
    decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
  );
}

// =============================================================================
//  Section 9 — Pitfalls and gotchas
// =============================================================================

Widget _pitfallsCard() {
  return _sectionShell(
    tag: 'SECTION 09 · PITFALLS',
    title: 'Things that look like bugs but are actually contracts',
    lede:
        'OverlayPortal does the right thing in places where developers '
        'reasonably expect surprises. Five of the most common confusions '
        'follow — each pitfall, what to do about it, and a one-line summary.',
    accent: _kAccentAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pitfallTile(
          icon: Icons.crop_square,
          title: 'Constraints arrive unbounded',
          body:
              'The overlayChildBuilder is rendered as the child of the '
              'Overlay\'s Stack. The constraints handed to your widget are '
              'effectively the screen, not your anchor\'s rect. Wrap in '
              'Positioned (or align with CompositedTransformFollower) to '
              'pin the floating content to the right place.',
          accent: _kAccentAmber,
        ),
        _pitfallTile(
          icon: Icons.palette_outlined,
          title: 'Theme.of works because the builder uses your context',
          body:
              'Unlike a raw OverlayEntry — whose builder runs with the '
              'Overlay\'s context, where your DefaultTextStyle and Theme '
              'don\'t live — OverlayPortal\'s overlayChildBuilder receives '
              'the context of your call site. Inherited widgets just work.',
          accent: _kAccentTeal,
        ),
        _pitfallTile(
          icon: Icons.touch_app_outlined,
          title: 'Hit testing punches through to siblings',
          body:
              'There is no implicit barrier. If you want a tap outside the '
              'overlay child to dismiss it, wrap that child in a '
              'GestureDetector with translucent behaviour, or pair the '
              'OverlayPortal with a TapRegion.',
          accent: _kAccentPink,
        ),
        _pitfallTile(
          icon: Icons.center_focus_strong_outlined,
          title: 'Focus traversal stays in your subtree',
          body:
              'Because the overlay child is logically still your descendant, '
              'focus moves through it the way you\'d expect from a Material '
              'menu — DialogRoute-style focus traps are not provided. Use '
              'FocusScope deliberately if you want to trap.',
          accent: _kAccentViolet,
        ),
        _pitfallTile(
          icon: Icons.layers_outlined,
          title: 'Multiple portals stack in show-order',
          body:
              'Two OverlayPortals over the same Overlay paint in the order '
              'they last became visible. If you need an explicit z-order, '
              'use one Overlay and several OverlayEntries instead — that\'s '
              'one of the few cases where Overlay.of(context).insert is '
              'still preferable.',
          accent: _kAccentCyan,
          isLast: true,
        ),
      ],
    ),
  );
}

Widget _pitfallTile({
  required IconData icon,
  required String title,
  required String body,
  required Color accent,
  bool isLast = false,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: isLast ? 0 : 12),
    padding: EdgeInsets.fromLTRB(16, 14, 18, 14),
    decoration: BoxDecoration(
      color: _kBackgroundMid,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kBorderSoft),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accent.withValues(alpha: 0.4)),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: accent, size: 20),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6),
              Text(
                body,
                style: TextStyle(
                  color: _kTextSecondary,
                  fontSize: 13,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  Section 10 — Footer with palette swatches and metadata
// =============================================================================

Widget _footerCard() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _kSurface,
          _kSurfaceRaised,
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _kBorderSoft),
    ),
    padding: EdgeInsets.fromLTRB(28, 22, 28, 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _label(text: 'FOOTER', color: _kAccentViolet),
            SizedBox(width: 10),
            Text(
              'Palette · Metadata',
              style: TextStyle(
                color: _kTextPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _swatch('background.deep', _kBackgroundDeep),
            _swatch('background.mid', _kBackgroundMid),
            _swatch('surface', _kSurface),
            _swatch('surface.raised', _kSurfaceRaised),
            _swatch('surface.higher', _kSurfaceHigher),
            _swatch('accent.violet', _kAccentViolet),
            _swatch('accent.cyan', _kAccentCyan),
            _swatch('accent.pink', _kAccentPink),
            _swatch('accent.lime', _kAccentLime),
            _swatch('accent.amber', _kAccentAmber),
            _swatch('accent.teal', _kAccentTeal),
          ],
        ),
        _dividerLine(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _metaLine('subject', _kSubject),
                  _metaLine('version', _kVersion),
                  _metaLine('author', _kAuthor),
                  _metaLine('runtime', 'analyzer-free interpreter'),
                  _metaLine('mutability', 'static — no setState'),
                ],
              ),
            ),
            Container(
              width: 220,
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kBackgroundDeep,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kBorderSoft),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TL;DR',
                    style: TextStyle(
                      color: _kAccentLime,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Use OverlayPortal for tooltips, popovers, and '
                    'autocomplete dropdowns. Reach for Overlay.insert '
                    'when an entry must outlive its anchor. Reach for '
                    'showDialog when the user needs to be modally '
                    'gated.',
                    style: TextStyle(
                      color: _kTextSecondary,
                      fontSize: 12,
                      height: 1.5,
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

Widget _swatch(String name, Color colour) {
  return Container(
    width: 130,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _kBackgroundDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kBorderSoft),
    ),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _kBorder),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              color: _kTextSecondary,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _metaLine(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            key,
            style: TextStyle(
              color: _kTextMuted,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}
