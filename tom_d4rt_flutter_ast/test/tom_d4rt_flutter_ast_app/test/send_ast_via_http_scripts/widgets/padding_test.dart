// ignore_for_file: avoid_print
// D4rt test script: Tests Padding widget from package:flutter/widgets.dart
// Deep Demo: Hand-authored visual encyclopedia of the Padding widget.
//
// Padding inserts space around its child by an EdgeInsetsGeometry. It is one
// of the most-used widgets in the Flutter framework. This demo walks through
// every common construction style (all, only, symmetric, fromLTRB,
// EdgeInsetsDirectional), shows how it interacts with surrounding layout, and
// catalogs the most common footguns.
import 'package:flutter/material.dart';

// ============================================================================
// PALETTE
// ============================================================================
// Slate / mint / amber palette tuned for paper-feel diagrams.
const Color _slate900 = Color(0xFF0F172A);
const Color _slate800 = Color(0xFF1E293B);
const Color _slate700 = Color(0xFF334155);
const Color _slate600 = Color(0xFF475569);
const Color _slate500 = Color(0xFF64748B);
const Color _slate400 = Color(0xFF94A3B8);
const Color _slate300 = Color(0xFFCBD5E1);
const Color _slate200 = Color(0xFFE2E8F0);
const Color _slate100 = Color(0xFFF1F5F9);
const Color _slate50 = Color(0xFFF8FAFC);

const Color _mint700 = Color(0xFF0F766E);
const Color _mint600 = Color(0xFF0D9488);
const Color _mint500 = Color(0xFF14B8A6);
const Color _mint300 = Color(0xFF5EEAD4);
const Color _mint200 = Color(0xFF99F6E4);
const Color _mint100 = Color(0xFFCCFBF1);
const Color _mint50 = Color(0xFFF0FDFA);

const Color _amber700 = Color(0xFFB45309);
const Color _amber600 = Color(0xFFD97706);
const Color _amber500 = Color(0xFFF59E0B);
const Color _amber400 = Color(0xFFFBBF24);
const Color _amber300 = Color(0xFFFCD34D);
const Color _amber200 = Color(0xFFFDE68A);
const Color _amber50 = Color(0xFFFFFBEB);

const Color _indigo700 = Color(0xFF4338CA);
const Color _indigo500 = Color(0xFF6366F1);
const Color _indigo300 = Color(0xFFA5B4FC);
const Color _teal500 = Color(0xFF14B8A6);
const Color _rose500 = Color(0xFFF43F5E);
const Color _rose300 = Color(0xFFFDA4AF);
const Color _rose100 = Color(0xFFFFE4E6);

dynamic build(BuildContext context) {
  print('Padding Deep Demo executing');

  // ==========================================================================
  // SECTION 1: Title banner
  // ==========================================================================
  print('=== Section 1: Title Banner ===');
  final titleBanner = _buildTitleBanner();

  // ==========================================================================
  // SECTION 2: Anatomy diagram
  // ==========================================================================
  print('=== Section 2: Anatomy Diagram ===');
  final anatomyDiagram = _buildAnatomyDiagram();

  // ==========================================================================
  // SECTION 3: EdgeInsets.all cards (0, 4, 8, 16, 24, 32, 48, 64)
  // ==========================================================================
  print('=== Section 3: EdgeInsets.all ===');
  final allValues = <double>[0.0, 4.0, 8.0, 16.0, 24.0, 32.0, 48.0, 64.0];
  final allCards = <Widget>[];
  for (final v in allValues) {
    print('  building EdgeInsets.all($v)');
    allCards.add(_buildAllCard(v));
  }

  // ==========================================================================
  // SECTION 4: EdgeInsets.only cards
  // ==========================================================================
  print('=== Section 4: EdgeInsets.only ===');
  final onlyCards = <Widget>[
    _buildOnlyCard(
      label: 'only(left: 32)',
      padding: EdgeInsets.only(left: 32.0),
      accent: _mint500,
    ),
    _buildOnlyCard(
      label: 'only(top: 32)',
      padding: EdgeInsets.only(top: 32.0),
      accent: _mint600,
    ),
    _buildOnlyCard(
      label: 'only(right: 32)',
      padding: EdgeInsets.only(right: 32.0),
      accent: _amber500,
    ),
    _buildOnlyCard(
      label: 'only(bottom: 32)',
      padding: EdgeInsets.only(bottom: 32.0),
      accent: _amber600,
    ),
  ];
  print('  built ${onlyCards.length} only-cards');

  // ==========================================================================
  // SECTION 5: EdgeInsets.symmetric cards
  // ==========================================================================
  print('=== Section 5: EdgeInsets.symmetric ===');
  final symmetricCards = <Widget>[
    _buildSymmetricCard(
      label: 'symmetric(horizontal: 24)',
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      accent: _mint500,
    ),
    _buildSymmetricCard(
      label: 'symmetric(vertical: 24)',
      padding: EdgeInsets.symmetric(vertical: 24.0),
      accent: _mint600,
    ),
    _buildSymmetricCard(
      label: 'symmetric(h: 24, v: 16)',
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      accent: _amber500,
    ),
    _buildSymmetricCard(
      label: 'asymmetric (h: 8, v: 32)',
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      accent: _amber600,
    ),
  ];
  print('  built ${symmetricCards.length} symmetric-cards');

  // ==========================================================================
  // SECTION 6: EdgeInsets.fromLTRB cards
  // ==========================================================================
  print('=== Section 6: EdgeInsets.fromLTRB ===');
  final ltrbCards = <Widget>[
    _buildLtrbCard(
      label: 'LTRB(4, 8, 16, 32)',
      padding: EdgeInsets.fromLTRB(4.0, 8.0, 16.0, 32.0),
      accent: _mint500,
    ),
    _buildLtrbCard(
      label: 'LTRB(32, 4, 4, 4)',
      padding: EdgeInsets.fromLTRB(32.0, 4.0, 4.0, 4.0),
      accent: _mint600,
    ),
    _buildLtrbCard(
      label: 'LTRB(0, 24, 0, 0)',
      padding: EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
      accent: _amber500,
    ),
    _buildLtrbCard(
      label: 'LTRB(16, 0, 16, 24)',
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
      accent: _amber600,
    ),
  ];
  print('  built ${ltrbCards.length} fromLTRB-cards');

  // ==========================================================================
  // SECTION 7: Directional padding (LTR vs RTL)
  // ==========================================================================
  print('=== Section 7: EdgeInsetsDirectional ===');
  final directionalRow = _buildDirectionalDemo();

  // ==========================================================================
  // SECTION 8: Padding vs Container side-by-side
  // ==========================================================================
  print('=== Section 8: Padding vs Container ===');
  final paddingVsContainer = _buildPaddingVsContainer();

  // ==========================================================================
  // SECTION 9: Real-world mocks
  // ==========================================================================
  print('=== Section 9: Real-World Mocks ===');
  final realWorldMocks = _buildRealWorldMocks();

  // ==========================================================================
  // SECTION 10: Layout impact (Column / Row / Stack / Center)
  // ==========================================================================
  print('=== Section 10: Layout Impact ===');
  final layoutImpact = _buildLayoutImpact();

  // ==========================================================================
  // SECTION 11: Footguns
  // ==========================================================================
  print('=== Section 11: Footguns ===');
  final footguns = <Widget>[
    _buildFootgunCard(
      number: 1,
      title: 'Negative insets assert',
      body:
          'EdgeInsets values must be non-negative. EdgeInsets.all(-4) trips an '
          'assertion in debug and produces undefined layout in release.',
      icon: Icons.warning_amber_rounded,
    ),
    _buildFootgunCard(
      number: 2,
      title: 'Padding without a child',
      body:
          'Padding(padding: EdgeInsets.all(16)) with no child renders a 0x0 '
          'box - the inset only applies *around* the child, so an absent child '
          'collapses to nothing.',
      icon: Icons.crop_square,
    ),
    _buildFootgunCard(
      number: 3,
      title: 'SafeArea is not Padding',
      body:
          'SafeArea adds dynamic insets driven by MediaQuery (notches, status '
          'bars). Use Padding for static insets and SafeArea for system intrusions.',
      icon: Icons.phone_iphone,
    ),
    _buildFootgunCard(
      number: 4,
      title: 'Intrinsic sizing surprises',
      body:
          'Padding propagates intrinsic dimensions: a Padding around a Text '
          'inflates the intrinsic width by left+right, which can change Row '
          'flex math unexpectedly.',
      icon: Icons.swap_horiz,
    ),
    _buildFootgunCard(
      number: 5,
      title: 'EdgeInsetsDirectional needs Directionality',
      body:
          'EdgeInsetsDirectional resolves start/end against ambient '
          'Directionality. Without one, the framework asserts. Wrap in '
          'Directionality(textDirection: TextDirection.ltr, ...) or use '
          'EdgeInsets directly.',
      icon: Icons.format_textdirection_l_to_r,
    ),
  ];
  print('  built ${footguns.length} footgun cards');

  // ==========================================================================
  // SECTION 12: Recap
  // ==========================================================================
  print('=== Section 12: Recap ===');
  final recap = _buildRecap();

  print('Padding Deep Demo completed successfully');

  // ==========================================================================
  // Final layout
  // ==========================================================================
  return Scaffold(
    backgroundColor: _slate50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Title
          titleBanner,
          SizedBox(height: 32.0),

          // 2. Anatomy
          _buildSectionHeader('1. Anatomy of Padding', Icons.architecture),
          SizedBox(height: 12.0),
          anatomyDiagram,
          SizedBox(height: 32.0),

          // 3. EdgeInsets.all
          _buildSectionHeader(
            '2. EdgeInsets.all - 8 uniform insets',
            Icons.crop_din,
          ),
          SizedBox(height: 12.0),
          _buildAllExplainer(),
          SizedBox(height: 16.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.center,
            children: allCards,
          ),
          SizedBox(height: 32.0),

          // 4. EdgeInsets.only
          _buildSectionHeader(
            '3. EdgeInsets.only - one side at a time',
            Icons.border_left,
          ),
          SizedBox(height: 12.0),
          _buildOnlyExplainer(),
          SizedBox(height: 16.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.center,
            children: onlyCards,
          ),
          SizedBox(height: 32.0),

          // 5. EdgeInsets.symmetric
          _buildSectionHeader(
            '4. EdgeInsets.symmetric - paired axes',
            Icons.swap_vert,
          ),
          SizedBox(height: 12.0),
          _buildSymmetricExplainer(),
          SizedBox(height: 16.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.center,
            children: symmetricCards,
          ),
          SizedBox(height: 32.0),

          // 6. EdgeInsets.fromLTRB
          _buildSectionHeader(
            '5. EdgeInsets.fromLTRB - explicit four-tuple',
            Icons.grid_4x4,
          ),
          SizedBox(height: 12.0),
          _buildLtrbExplainer(),
          SizedBox(height: 16.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.center,
            children: ltrbCards,
          ),
          SizedBox(height: 32.0),

          // 7. Directional
          _buildSectionHeader(
            '6. EdgeInsetsDirectional - LTR vs RTL',
            Icons.compare_arrows,
          ),
          SizedBox(height: 12.0),
          _buildDirectionalExplainer(),
          SizedBox(height: 16.0),
          directionalRow,
          SizedBox(height: 32.0),

          // 8. Padding vs Container
          _buildSectionHeader(
            '7. Padding vs Container(padding: ...)',
            Icons.compare,
          ),
          SizedBox(height: 12.0),
          paddingVsContainer,
          SizedBox(height: 32.0),

          // 9. Real-world mocks
          _buildSectionHeader(
            '8. Real-world UI mocks',
            Icons.dashboard_customize,
          ),
          SizedBox(height: 12.0),
          realWorldMocks,
          SizedBox(height: 32.0),

          // 10. Layout impact
          _buildSectionHeader('9. Layout impact', Icons.view_quilt),
          SizedBox(height: 12.0),
          layoutImpact,
          SizedBox(height: 32.0),

          // 11. Footguns
          _buildSectionHeader('10. Footguns', Icons.dangerous),
          SizedBox(height: 12.0),
          Column(children: footguns),
          SizedBox(height: 32.0),

          // 12. Recap
          _buildSectionHeader('11. Recap', Icons.flag),
          SizedBox(height: 12.0),
          recap,
          SizedBox(height: 40.0),
        ],
      ),
    ),
  );
}

// ============================================================================
// HELPER: Section header
// ============================================================================
Widget _buildSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_mint500, _mint700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: _mint500.withValues(alpha: 0.35),
                blurRadius: 8.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: _slate900,
              letterSpacing: -0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Title banner
// ============================================================================
Widget _buildTitleBanner() {
  return Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slate900, _slate700, _mint700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: _mint500.withValues(alpha: 0.2),
          blurRadius: 32.0,
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
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.space_bar_rounded,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Padding',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1.2,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/widgets.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                      color: _mint200,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Padding({Key? key, required EdgeInsetsGeometry padding, '
            'Widget? child})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: _mint100,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'A widget that insets its child by the given padding. '
          'The most-used layout primitive in Flutter.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.85),
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Anatomy diagram - labelled inset overlay
// ============================================================================
Widget _buildAnatomyDiagram() {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slate50, _slate100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _slate300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Padding inserts space on each side of its child.',
          style: TextStyle(
            fontSize: 13.0,
            color: _slate600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        // Outer "Padding widget" frame
        Container(
          width: 320.0,
          decoration: BoxDecoration(
            border: Border.all(color: _amber500, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // The inset region (drawn as an inner rectangle).
              Padding(
                padding: EdgeInsets.fromLTRB(40.0, 24.0, 32.0, 36.0),
                child: Container(
                  height: 96.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_mint300, _mint500],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: _mint500.withValues(alpha: 0.3),
                        blurRadius: 8.0,
                        offset: Offset(0.0, 3.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'child',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              // Side labels (positioned absolutely).
              Positioned(
                left: 4.0,
                top: 60.0,
                child: _buildAnatomyLabel('left: 40', _amber700),
              ),
              Positioned(
                left: 130.0,
                top: 4.0,
                child: _buildAnatomyLabel('top: 24', _amber700),
              ),
              Positioned(
                right: 4.0,
                top: 60.0,
                child: _buildAnatomyLabel('right: 32', _amber700),
              ),
              Positioned(
                left: 130.0,
                bottom: 4.0,
                child: _buildAnatomyLabel('bottom: 36', _amber700),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: _slate900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Padding(padding: EdgeInsets.fromLTRB(40, 24, 32, 36), '
            'child: ...)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _mint200,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendDot(_amber500, 'Padding frame'),
            SizedBox(width: 16.0),
            _buildLegendDot(_mint500, 'Child'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAnatomyLabel(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w700,
        color: color,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildLegendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12.0,
        height: 12.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
      SizedBox(width: 6.0),
      Text(label, style: TextStyle(fontSize: 11.0, color: _slate700)),
    ],
  );
}

// ============================================================================
// HELPER: Section 3 - EdgeInsets.all explainer + cards
// ============================================================================
Widget _buildAllExplainer() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _mint50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _mint200, width: 1.0),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, size: 18.0, color: _mint700),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'EdgeInsets.all(x) applies the same inset to all four sides. '
            'Each card visualises the inset growing from 0 to 64 logical px.',
            style: TextStyle(fontSize: 12.5, color: _slate700, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAllCard(double inset) {
  // Pick a hue band based on inset size: small => mint, large => amber.
  final Color accent =
      inset <= 8.0 ? _mint500 : (inset <= 24.0 ? _mint600 : _amber600);
  final Color accentLight =
      inset <= 8.0 ? _mint100 : (inset <= 24.0 ? _mint200 : _amber200);

  return Container(
    width: 168.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header strip
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accentLight, accent.withValues(alpha: 0.2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Text(
            'all(${inset.toStringAsFixed(0)})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        // Visual: outer frame contains a Padding around a coloured square
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Container(
            height: 110.0,
            decoration: BoxDecoration(
              color: _slate100,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _slate300, width: 1.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(inset),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accent, accent.withValues(alpha: 0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
          child: Text(
            'inset = ${inset.toStringAsFixed(0)} px',
            style: TextStyle(
              fontSize: 11.0,
              color: _slate600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Section 4 - EdgeInsets.only
// ============================================================================
Widget _buildOnlyExplainer() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _amber50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _amber200, width: 1.0),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, size: 18.0, color: _amber700),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'EdgeInsets.only(left, top, right, bottom) lets you target a '
            'single side. Unspecified sides default to 0.',
            style: TextStyle(fontSize: 12.5, color: _slate700, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOnlyCard({
  required String label,
  required EdgeInsets padding,
  required Color accent,
}) {
  return Container(
    width: 200.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            height: 110.0,
            decoration: BoxDecoration(
              color: _slate100,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _slate300, width: 1.0),
            ),
            child: Padding(
              padding: padding,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accent, accent.withValues(alpha: 0.65)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 10.0),
          child: Text(
            'L=${padding.left.toStringAsFixed(0)}  '
            'T=${padding.top.toStringAsFixed(0)}  '
            'R=${padding.right.toStringAsFixed(0)}  '
            'B=${padding.bottom.toStringAsFixed(0)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: _slate500,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Section 5 - EdgeInsets.symmetric
// ============================================================================
Widget _buildSymmetricExplainer() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _mint50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _mint200, width: 1.0),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, size: 18.0, color: _mint700),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'EdgeInsets.symmetric(horizontal: x, vertical: y) is shorthand for '
            'fromLTRB(x, y, x, y).',
            style: TextStyle(fontSize: 12.5, color: _slate700, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSymmetricCard({
  required String label,
  required EdgeInsets padding,
  required Color accent,
}) {
  return Container(
    width: 200.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent.withValues(alpha: 0.18), accent.withValues(alpha: 0.08)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            height: 110.0,
            decoration: BoxDecoration(
              color: _slate100,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _slate300, width: 1.0),
            ),
            child: Padding(
              padding: padding,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accent, accent.withValues(alpha: 0.65)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Section 6 - EdgeInsets.fromLTRB
// ============================================================================
Widget _buildLtrbExplainer() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _amber50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _amber200, width: 1.0),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, size: 18.0, color: _amber700),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'EdgeInsets.fromLTRB(left, top, right, bottom) gives you all four '
            'sides positionally - useful for asymmetric layouts.',
            style: TextStyle(fontSize: 12.5, color: _slate700, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLtrbCard({
  required String label,
  required EdgeInsets padding,
  required Color accent,
}) {
  return Container(
    width: 200.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            height: 110.0,
            decoration: BoxDecoration(
              color: _slate100,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _slate300, width: 1.0),
            ),
            child: Padding(
              padding: padding,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accent, accent.withValues(alpha: 0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Section 7 - directional padding (LTR vs RTL)
// ============================================================================
Widget _buildDirectionalExplainer() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _slate100,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _slate300, width: 1.0),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, size: 18.0, color: _slate700),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'EdgeInsetsDirectional.only(start: 32, end: 4) resolves start/end '
            'against the ambient Directionality. Same inset, mirrored layout.',
            style: TextStyle(fontSize: 12.5, color: _slate700, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDirectionalDemo() {
  final inset = EdgeInsetsDirectional.only(
    start: 32.0,
    top: 8.0,
    end: 4.0,
    bottom: 8.0,
  );
  return Row(
    children: [
      Expanded(
        child: _buildDirectionalCard(
          label: 'LTR',
          subtitle: 'TextDirection.ltr',
          direction: TextDirection.ltr,
          inset: inset,
          accent: _mint600,
        ),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: _buildDirectionalCard(
          label: 'RTL',
          subtitle: 'TextDirection.rtl',
          direction: TextDirection.rtl,
          inset: inset,
          accent: _amber600,
        ),
      ),
    ],
  );
}

Widget _buildDirectionalCard({
  required String label,
  required String subtitle,
  required TextDirection direction,
  required EdgeInsetsDirectional inset,
  required Color accent,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent, accent.withValues(alpha: 0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Row(
            children: [
              Icon(
                direction == TextDirection.ltr
                    ? Icons.format_textdirection_l_to_r
                    : Icons.format_textdirection_r_to_l,
                color: Colors.white,
                size: 18.0,
              ),
              SizedBox(width: 8.0),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Directionality(
            textDirection: direction,
            child: Container(
              height: 110.0,
              decoration: BoxDecoration(
                color: _slate100,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _slate300, width: 1.0),
              ),
              child: Padding(
                padding: inset,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accent, accent.withValues(alpha: 0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 10.0),
          child: Text(
            'start: 32, end: 4 (mirrors with text direction)',
            style: TextStyle(fontSize: 10.5, color: _slate500),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Section 8 - Padding vs Container
// ============================================================================
Widget _buildPaddingVsContainer() {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slate50, _slate100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _slate200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildComparisonColumn(
                title: 'Padding',
                subtitle: 'Lean, single responsibility',
                accent: _mint600,
                content: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_mint500, _mint700],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'child',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                code: 'Padding(\n'
                    '  padding: EdgeInsets.all(20),\n'
                    '  child: ...,\n'
                    ')',
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _buildComparisonColumn(
                title: 'Container(padding: ...)',
                subtitle: 'Wraps a Padding underneath',
                accent: _amber600,
                content: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_amber500, _amber700],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'child',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                code: 'Container(\n'
                    '  padding: EdgeInsets.all(20),\n'
                    '  child: ...,\n'
                    ')',
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _slate900,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: _amber400, size: 18.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Both render identically. Container.padding internally '
                  'composes a Padding widget. Prefer Padding when you need '
                  'nothing else from Container.',
                  style: TextStyle(
                    color: _slate100,
                    fontSize: 12.0,
                    height: 1.45,
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

Widget _buildComparisonColumn({
  required String title,
  required String subtitle,
  required Color accent,
  required Widget content,
  required String code,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _slate200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: accent,
              fontSize: 14.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            subtitle,
            style: TextStyle(fontSize: 11.0, color: _slate500),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: _slate100,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _slate300, width: 1.0),
            ),
            child: content,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _slate900,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: _mint200,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Section 9 - Real-world UI mocks
// ============================================================================
Widget _buildRealWorldMocks() {
  return Column(
    children: [
      _buildSearchBarMock(),
      SizedBox(height: 12.0),
      _buildArticleCardMock(),
      SizedBox(height: 12.0),
      _buildListTileMock(),
      SizedBox(height: 12.0),
      _buildButtonMock(),
    ],
  );
}

Widget _buildSearchBarMock() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 6.0),
          child: Text(
            'Search bar - Padding around TextField',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: _slate800,
              fontSize: 13.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(14.0, 6.0, 14.0, 14.0),
          child: Container(
            decoration: BoxDecoration(
              color: _slate100,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: _slate300, width: 1.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              child: Row(
                children: [
                  Icon(Icons.search, color: _slate500, size: 18.0),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Search components...',
                      style: TextStyle(color: _slate500, fontSize: 13.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.tune,
                      color: _slate500,
                      size: 18.0,
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

Widget _buildArticleCardMock() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.08),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category chip
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: _mint100,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'LAYOUT',
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  color: _mint700,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
          // Title
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Mastering Padding in Flutter',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: _slate900,
                height: 1.2,
              ),
            ),
          ),
          // Body
          Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              'Padding is the simplest way to push pixels around. It wraps a '
              'single child and inflates its layout by the configured insets.',
              style: TextStyle(
                fontSize: 13.0,
                color: _slate600,
                height: 1.45,
              ),
            ),
          ),
          // Actions row
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: _buildPillAction(
                    icon: Icons.bookmark_border,
                    label: 'Save',
                    accent: _mint700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: _buildPillAction(
                    icon: Icons.share,
                    label: 'Share',
                    accent: _amber700,
                  ),
                ),
                _buildPillAction(
                  icon: Icons.thumb_up_alt_outlined,
                  label: 'Like',
                  accent: _slate700,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPillAction({
  required IconData icon,
  required String label,
  required Color accent,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13.0, color: accent),
        SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: accent,
          ),
        ),
      ],
    ),
  );
}

Widget _buildListTileMock() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          // Leading icon with its own padding
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _mint100,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(Icons.padding, color: _mint700, size: 22.0),
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List tile shell',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _slate900,
                    fontSize: 14.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Text(
                    'symmetric(h: 16, v: 12) outer + nested paddings',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: _slate500,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.chevron_right, color: _slate400, size: 22.0),
          ),
        ],
      ),
    ),
  );
}

Widget _buildButtonMock() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
    ),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Button with internal padding',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: _slate800,
              fontSize: 13.0,
            ),
          ),
          SizedBox(height: 12.0),
          Row(
            children: [
              // Primary
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_mint500, _mint700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: _mint500.withValues(alpha: 0.4),
                      blurRadius: 8.0,
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, color: Colors.white, size: 16.0),
                      SizedBox(width: 6.0),
                      Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              // Secondary
              Container(
                decoration: BoxDecoration(
                  color: _slate100,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _slate300, width: 1.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: _slate700,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// HELPER: Section 10 - layout impact
// ============================================================================
Widget _buildLayoutImpact() {
  return Column(
    children: [
      _buildLayoutMiniCard(
        title: 'Padding inside Column',
        description:
            'Each child grows vertically by top + bottom padding.',
        accent: _mint600,
        demo: Container(
          height: 100.0,
          decoration: BoxDecoration(
            color: _slate100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _slate300, width: 1.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _buildBadge('A', _mint500),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: _buildBadge('B', _mint600),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 12.0),
      _buildLayoutMiniCard(
        title: 'Padding inside Row',
        description:
            'Each child grows horizontally by left + right padding.',
        accent: _amber600,
        demo: Container(
          height: 70.0,
          decoration: BoxDecoration(
            color: _slate100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _slate300, width: 1.0),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _buildBadge('A', _amber500),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: _buildBadge('B', _amber600),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: _buildBadge('C', _amber700),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 12.0),
      _buildLayoutMiniCard(
        title: 'Padding inside Stack',
        description:
            'Padding works as any other widget in a Stack child slot.',
        accent: _indigo500,
        demo: Container(
          height: 110.0,
          decoration: BoxDecoration(
            color: _slate100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _slate300, width: 1.0),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _indigo300.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _indigo500,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(44.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _indigo700,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 12.0),
      _buildLayoutMiniCard(
        title: 'Padding inside Center',
        description:
            'Center sizes itself to its child; Padding inflates the child first.',
        accent: _teal500,
        demo: Container(
          height: 110.0,
          decoration: BoxDecoration(
            color: _slate100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _slate300, width: 1.0),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                width: 60.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: _teal500,
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 12.0),
      _buildLayoutMiniCard(
        title: 'Nested Paddings stack',
        description:
            'Two Paddings around the same child sum their insets - useful '
            'when composing a list-tile shell with extra inner spacing.',
        accent: _rose500,
        demo: Container(
          height: 110.0,
          decoration: BoxDecoration(
            color: _slate100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _slate300, width: 1.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: _rose100,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _rose300,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _rose500,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildBadge(String label, Color color) {
  return Container(
    width: 32.0,
    height: 32.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 13.0,
        ),
      ),
    ),
  );
}

Widget _buildLayoutMiniCard({
  required String title,
  required String description,
  required Color accent,
  required Widget demo,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _slate900,
                    fontSize: 14.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0, bottom: 10.0),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: _slate600,
                      height: 1.4,
                    ),
                  ),
                ),
                demo,
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// HELPER: Section 11 - Footguns
// ============================================================================
Widget _buildFootgunCard({
  required int number,
  required String title,
  required String body,
  required IconData icon,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_amber50, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _amber300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _amber500.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_amber500, _amber700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: Colors.white, size: 18.0),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: _amber700,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '#$number',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: _slate900,
                          fontSize: 13.5,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Text(
                    body,
                    style: TextStyle(
                      color: _slate700,
                      fontSize: 12.0,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// HELPER: Section 12 - Recap
// ============================================================================
Widget _buildRecap() {
  final lines = <String>[
    'Padding insets a single child by an EdgeInsetsGeometry.',
    'Use EdgeInsets.all for uniform insets, .only for one side.',
    '.symmetric(horizontal/vertical) is the most common shorthand.',
    '.fromLTRB is positional - use it for asymmetric layouts.',
    'EdgeInsetsDirectional needs a Directionality ancestor.',
    'Container(padding: ...) wraps a Padding under the hood.',
    'No child means no rendered area - 0x0 box.',
    'Negative insets assert in debug; keep values >= 0.',
    'Padding propagates intrinsic dimensions; mind Row flex math.',
    'Prefer Padding over Container when only spacing is needed.',
  ];

  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_indigo700, _indigo500, _teal500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: _indigo500.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: _teal500.withValues(alpha: 0.25),
          blurRadius: 24.0,
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
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.summarize_rounded,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              'Padding in 10 takeaways',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        for (int i = 0; i < lines.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: _indigo700,
                        fontWeight: FontWeight.w800,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      lines[i],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        height: 1.4,
                      ),
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
