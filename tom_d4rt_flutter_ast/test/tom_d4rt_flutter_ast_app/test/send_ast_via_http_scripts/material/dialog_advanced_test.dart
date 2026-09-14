// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

// =============================================================================
//  M A T E R I A L   D I A L O G   F A M I L Y   ::   V I S U A L   D E E P
//  D E M O   ::   A D V A N C E D   /   C O M P O S I T I O N   M O D E
// =============================================================================
//
//  This file is a long-form, hand-authored visual reference for Flutter's
//  Material Dialog widgets. It does NOT call showDialog() - all dialogs are
//  rendered as STATIC SNAPSHOTS, inline in the page, by wrapping Dialog
//  widgets in Material frames with a fake "Barrier" backdrop drawn behind
//  them. This lets us page through the entire dialog vocabulary without any
//  routing, async, controllers, timers, streams or state.
//
//  Topics covered:
//    01. Hero banner with a stylized dialog mock
//    02. Anatomy of the bare Dialog widget
//    03. AlertDialog snapshot (title + content + actions)
//    04. SimpleDialog snapshot (option list)
//    05. Dialog.fullscreen variant
//    06. insetPadding visual comparison grid
//    07. surfaceTintColor swatch grid
//    08. shape variants (rounded, beveled, cut, stadium, custom)
//    09. The modal Barrier explainer
//    10. showDialog<T>() control flow diagram
//    11. RTL / LTR flip comparison
//    12. Scrollable AlertDialog content
//    13. Accessibility callouts
//    14. Common pitfalls
//    15. Decision matrix
//    16. Footer
//
//  Single import:
import 'package:flutter/material.dart';

// =============================================================================
//  S E C T I O N   00  ::  TOKENS, COLOURS, AND SHARED CONSTANTS
// =============================================================================
//
//  We keep all "design tokens" at the top of the file so they can be reused
//  across every section without repetition. Because we cannot use
//  prefer_const_constructors (it's in the file-level ignore), we still write
//  these as compile-time constants where we can; the rest are computed.

const Color _kInk = Color(0xFF101521);
const Color _kInkSoft = Color(0xFF2C3344);
const Color _kInkMuted = Color(0xFF5A6276);
const Color _kPaper = Color(0xFFFAF9F6);
const Color _kPaperWarm = Color(0xFFF1ECE2);
const Color _kBorder = Color(0xFFD7D2C7);
const Color _kAccent = Color(0xFF3A6EA5);
const Color _kAccentDeep = Color(0xFF22456B);
const Color _kAccentSoft = Color(0xFFCBD9EA);
const Color _kWarn = Color(0xFFB45F2A);
const Color _kWarnSoft = Color(0xFFF2D9C4);
const Color _kErr = Color(0xFFA0303C);
const Color _kErrSoft = Color(0xFFEFC9CE);
const Color _kOk = Color(0xFF4F7A4F);
const Color _kOkSoft = Color(0xFFD3E2D1);
const Color _kViolet = Color(0xFF735A8E);
const Color _kVioletSoft = Color(0xFFE2D8EE);
const Color _kBarrier = Color(0xFF000000);

// Shared text styles. They are written as plain `TextStyle(...)` constructors
// because we need them in many places and want to avoid repeating the same
// fontSize / fontWeight / colour combination over and over.

TextStyle _styleTitle({Color color = _kInk, double size = 28}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.4,
    height: 1.15,
  );
}

TextStyle _styleSubtitle({Color color = _kInkSoft, double size = 16}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.3,
  );
}

TextStyle _styleBody({Color color = _kInkSoft, double size = 14}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );
}

TextStyle _styleMono({Color color = _kInk, double size = 12}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w500,
    fontFamily: 'monospace',
    height: 1.4,
  );
}

TextStyle _styleCaption({Color color = _kInkMuted, double size = 11}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
  );
}

// =============================================================================
//  E N T R Y   P O I N T
// =============================================================================
//
//  The visual harness is a single MaterialApp that owns one Scaffold with one
//  ListView of section cards. Every card is a self-contained illustration.

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Material Dialog :: Advanced Visual Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _kPaper,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kAccent,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    ),
    home: const _DialogDeepDemoPage(),
  );
}

// =============================================================================
//  P A G E   S H E L L
// =============================================================================

class _DialogDeepDemoPage extends StatelessWidget {
  const _DialogDeepDemoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: ListView(
            children: [
              _section01HeroBanner(),
              _gap(28),
              _section02DialogAnatomy(),
              _gap(28),
              _section03AlertDialogSnapshot(),
              _gap(28),
              _section04SimpleDialogSnapshot(),
              _gap(28),
              _section05FullscreenDialog(),
              _gap(28),
              _section06InsetPaddingGrid(),
              _gap(28),
              _section07SurfaceTintSwatches(),
              _gap(28),
              _section08ShapeVariants(),
              _gap(28),
              _section09BarrierExplainer(),
              _gap(28),
              _section10ShowDialogFlow(),
              _gap(28),
              _section11RtlLtrFlip(),
              _gap(28),
              _section12ScrollableContent(),
              _gap(28),
              _section13Accessibility(),
              _gap(28),
              _section14Pitfalls(),
              _gap(28),
              _section15DecisionMatrix(),
              _gap(28),
              _section16Footer(),
              _gap(48),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _gap(double size) {
  return SizedBox(height: size);
}

// =============================================================================
//  S H A R E D   C A R D   F R A M E
// =============================================================================
//
//  Every section is rendered inside a "card" that has a numbered header, a
//  short tagline, and a body. We define one helper to keep visual rhythm.

Widget _sectionCard({
  required String number,
  required String title,
  required String subtitle,
  required Widget body,
  Color tint = _kAccentSoft,
  Color stripe = _kAccent,
}) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kBorder, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: _kInk.withValues(alpha: 0.07),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Numbered stripe at the top.
          Container(
            color: stripe,
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: tint,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: stripe, width: 1.4),
                  ),
                  child: Text(
                    number,
                    style: _styleTitle(color: stripe, size: 18),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: _styleTitle(size: 22)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: _styleBody()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            child: Divider(color: _kBorder, height: 1),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 22),
            child: body,
          ),
        ],
      ),
    ),
  );
}

// Helper: a labelled "callout" pill.
Widget _calloutPill({
  required String label,
  Color color = _kAccent,
  IconData icon = Icons.info_outline,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

// Helper: an inline code chip.
Widget _codeChip(String text, {Color color = _kAccentDeep}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1),
    ),
    child: Text(
      text,
      style: _styleMono(color: color, size: 11),
    ),
  );
}

// Helper: bullet line.
Widget _bullet(String text, {Color dot = _kAccent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 7,
          height: 7,
          margin: const EdgeInsets.only(top: 6, right: 9),
          decoration: BoxDecoration(
            color: dot,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(text, style: _styleBody(size: 13)),
        ),
      ],
    ),
  );
}

// Helper: a "barrier backdrop" frame that wraps a snapshot dialog. This is
// what gives every dialog snapshot the sense of being modal: the backdrop
// is darkened, the dialog floats on top.
Widget _barrierFrame({
  required Widget dialog,
  Alignment alignment = Alignment.center,
  Color barrierColor = _kBarrier,
  double barrierAlpha = 0.45,
  double minHeight = 320,
  EdgeInsets padding = const EdgeInsets.all(20),
  Color sceneColor = const Color(0xFFE8E2D5),
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Container(
      constraints: BoxConstraints(minHeight: minHeight),
      decoration: BoxDecoration(
        color: sceneColor,
        border: Border.all(color: _kBorder, width: 1.2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          // Fake page content underneath the barrier.
          Positioned.fill(child: _fakePageContent()),
          // Barrier overlay.
          Positioned.fill(
            child: ColoredBox(
              color: barrierColor.withValues(alpha: barrierAlpha),
            ),
          ),
          // Centred dialog snapshot.
          Padding(
            padding: padding,
            child: Align(
              alignment: alignment,
              child: dialog,
            ),
          ),
        ],
      ),
    ),
  );
}

// Decorative fake page content (used as the layer beneath the modal barrier).
Widget _fakePageContent() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fake app bar.
        Container(
          height: 32,
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(Icons.menu, color: Colors.white.withValues(alpha: 0.95), size: 16),
              const SizedBox(width: 8),
              Container(
                width: 90,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Spacer(),
              Icon(Icons.search, color: Colors.white.withValues(alpha: 0.95), size: 16),
              const SizedBox(width: 6),
              Icon(Icons.more_vert, color: Colors.white.withValues(alpha: 0.95), size: 16),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Fake list rows.
        for (int i = 0; i < 5; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: _kAccentSoft,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 9,
                        width: 160.0 + ((i * 12) % 80),
                        decoration: BoxDecoration(
                          color: _kInkMuted.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 7,
                        width: 100.0 + ((i * 17) % 60),
                        decoration: BoxDecoration(
                          color: _kInkMuted.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const Spacer(),
        // Fake bottom action bar.
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.home_outlined, size: 16, color: _kInkMuted),
              Icon(Icons.search, size: 16, color: _kInkMuted),
              Icon(Icons.add_circle_outline, size: 16, color: _kAccent),
              Icon(Icons.notifications_none, size: 16, color: _kInkMuted),
              Icon(Icons.person_outline, size: 16, color: _kInkMuted),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  S E C T I O N   01  ::  HERO BANNER
// =============================================================================

Widget _section01HeroBanner() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(22),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _kAccentDeep,
            _kAccent,
            _kViolet.withValues(alpha: 0.8),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(32, 30, 32, 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: title block.
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    'MATERIAL :: DIALOG FAMILY :: ADVANCED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      letterSpacing: 1.6,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Dialogs in Composition Mode',
                  style: _styleTitle(color: Colors.white, size: 36),
                ),
                const SizedBox(height: 8),
                Text(
                  'A static, scrollable atlas of Dialog, AlertDialog, '
                  'SimpleDialog, fullscreen Dialog, the Barrier, and the '
                  'showDialog<T>() lifecycle - rendered inline as snapshots, '
                  'no interactivity required.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 15,
                    height: 1.45,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _heroChip('Dialog'),
                    _heroChip('AlertDialog'),
                    _heroChip('SimpleDialog'),
                    _heroChip('Dialog.fullscreen'),
                    _heroChip('showDialog<T>()'),
                    _heroChip('Barrier'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Right: stylised dialog mock.
          Expanded(
            flex: 4,
            child: AspectRatio(
              aspectRatio: 1.05,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Halo ring.
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.35),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Stylised "barrier".
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1.2,
                      ),
                    ),
                    margin: const EdgeInsets.all(14),
                  ),
                  // Stylised dialog card.
                  FractionallySizedBox(
                    widthFactor: 0.78,
                    heightFactor: 0.62,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 30,
                            offset: const Offset(0, 14),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 12,
                            width: 100,
                            decoration: BoxDecoration(
                              color: _kAccent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: _kInkMuted.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 8,
                            width: 140,
                            decoration: BoxDecoration(
                              color: _kInkMuted.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 22,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: _kAccent),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                height: 22,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: _kAccent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// =============================================================================
//  S E C T I O N   02  ::  ANATOMY OF Dialog
// =============================================================================

Widget _section02DialogAnatomy() {
  return _sectionCard(
    number: '02',
    title: 'Anatomy of the bare Dialog widget',
    subtitle:
        'Dialog is the lowest-level shell in the family. It is a Material '
        'surface that floats over the route below; everything visible inside '
        'is up to you.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: annotated mock.
        Expanded(
          flex: 5,
          child: _barrierFrame(
            minHeight: 360,
            dialog: _annotatedBareDialog(),
          ),
        ),
        const SizedBox(width: 18),
        // Right: prop bullets.
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Key parameters', style: _styleSubtitle()),
              const SizedBox(height: 8),
              _bullet('child - the only visual content. Dialog itself draws '
                  'no title, no actions, nothing.'),
              _bullet('backgroundColor - surface fill. Defaults to '
                  'ColorScheme.surface in M3.'),
              _bullet('elevation - shadow depth. M3 default is 6.'),
              _bullet('shadowColor / surfaceTintColor - control the cast '
                  'shadow tint and the M3 elevation tint overlay.'),
              _bullet('shape - any ShapeBorder; defaults to a 28dp '
                  'RoundedRectangleBorder in M3.'),
              _bullet('insetPadding - distance from the screen edges. '
                  'Default is EdgeInsets.symmetric(horizontal:40, '
                  'vertical:24).'),
              _bullet('alignment - where the dialog sits inside the inset. '
                  'Default is Alignment.center.'),
              _bullet('clipBehavior - whether the child gets clipped to the '
                  'shape; defaults to Clip.none.'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _calloutPill(
                    label: 'NO ROUTE LOGIC',
                    color: _kViolet,
                    icon: Icons.layers_outlined,
                  ),
                  _calloutPill(
                    label: 'M3 TINT-AWARE',
                    color: _kAccent,
                    icon: Icons.palette_outlined,
                  ),
                  _calloutPill(
                    label: 'BYO CONTENT',
                    color: _kWarn,
                    icon: Icons.build_outlined,
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

// A bare Dialog snapshot with floating annotation labels.
Widget _annotatedBareDialog() {
  return Stack(
    children: [
      // The Dialog itself.
      Center(
        child: Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: _kAccent,
          elevation: 8,
          insetPadding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: 240,
            height: 170,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bare Dialog', style: _styleTitle(size: 18)),
                  const SizedBox(height: 4),
                  Text(
                    'Just a surface. The shell.',
                    style: _styleBody(),
                  ),
                  const Spacer(),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: _kAccentSoft.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _kAccent.withValues(alpha: 0.6),
                        style: BorderStyle.solid,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '<your child here>',
                      style: _styleMono(color: _kAccentDeep),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // Annotation labels.
      Positioned(
        top: 12,
        left: 8,
        child: _annoTag('insetPadding', _kViolet),
      ),
      Positioned(
        bottom: 12,
        right: 8,
        child: _annoTag('shape: rounded 20', _kAccent),
      ),
      Positioned(
        top: 60,
        right: 6,
        child: _annoTag('surfaceTintColor', _kWarn),
      ),
      Positioned(
        bottom: 60,
        left: 6,
        child: _annoTag('child: SizedBox', _kOk),
      ),
    ],
  );
}

Widget _annoTag(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color, width: 1.4),
    ),
    child: Text(
      label,
      style: _styleMono(color: color, size: 10.5),
    ),
  );
}

// =============================================================================
//  S E C T I O N   03  ::  AlertDialog SNAPSHOT
// =============================================================================

Widget _section03AlertDialogSnapshot() {
  return _sectionCard(
    number: '03',
    title: 'AlertDialog :: title + content + actions',
    subtitle:
        'AlertDialog is the canonical confirmation/warn surface. It composes '
        'icon, title, content and actions into a vertical stack with built-in '
        'spacing and material tokens.',
    stripe: _kErr,
    tint: _kErrSoft,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _barrierFrame(
            minHeight: 380,
            dialog: AlertDialog(
              icon: Icon(Icons.warning_amber_rounded, color: _kErr, size: 32),
              iconColor: _kErr,
              title: const Text('Discard your draft?'),
              titleTextStyle: _styleTitle(size: 20),
              content: Text(
                'This action cannot be undone. The 412 unsaved changes will '
                'be permanently removed and any open collaborators will lose '
                'their pending edits.',
                style: _styleBody(size: 13),
              ),
              actionsAlignment: MainAxisAlignment.end,
              actions: [
                TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(foregroundColor: _kInkMuted),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(foregroundColor: _kErr),
                  child: const Text('Discard'),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.white,
              elevation: 8,
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Slot order (top to bottom)', style: _styleSubtitle()),
              const SizedBox(height: 8),
              _slotRow('1', 'icon', 'optional, sits above the title'),
              _slotRow('2', 'title', 'usually a single short sentence'),
              _slotRow('3', 'content', 'longer prose, can be scrollable'),
              _slotRow('4', 'actions', 'a Row of TextButtons by convention'),
              const SizedBox(height: 14),
              Text('Spacing knobs', style: _styleSubtitle()),
              const SizedBox(height: 8),
              _bullet('iconPadding / titlePadding / contentPadding / '
                  'actionsPadding'),
              _bullet('actionsAlignment - MainAxisAlignment for the action row.'),
              _bullet('actionsOverflowDirection / actionsOverflowButtonSpacing - '
                  'when the action row wraps to OverflowBar.'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _slotRow(String n, String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kErr,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            n,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 10),
        _codeChip(name, color: _kErr),
        const SizedBox(width: 8),
        Expanded(
          child: Text(desc, style: _styleBody(size: 12.5)),
        ),
      ],
    ),
  );
}

// =============================================================================
//  S E C T I O N   04  ::  SimpleDialog SNAPSHOT
// =============================================================================

Widget _section04SimpleDialogSnapshot() {
  return _sectionCard(
    number: '04',
    title: 'SimpleDialog :: a list of options',
    subtitle:
        'SimpleDialog is the picker surface: a title plus a vertical list of '
        'SimpleDialogOption rows. Use it when the user must pick one option '
        'and you do not need a free-form content area.',
    stripe: _kViolet,
    tint: _kVioletSoft,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _barrierFrame(
            minHeight: 420,
            dialog: SimpleDialog(
              title: Text(
                'Select your time zone',
                style: _styleTitle(size: 18),
              ),
              titlePadding:
                  const EdgeInsets.fromLTRB(20, 20, 20, 8),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              children: [
                _zoneRow('Pacific Standard Time', 'UTC -08:00', _kAccent),
                _zoneRow('Mountain Standard Time', 'UTC -07:00', _kViolet),
                _zoneRow('Central European Time', 'UTC +01:00', _kOk,
                    selected: true),
                _zoneRow('Indian Standard Time', 'UTC +05:30', _kWarn),
                _zoneRow('Japan Standard Time', 'UTC +09:00', _kErr),
              ],
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('When to use', style: _styleSubtitle()),
              const SizedBox(height: 8),
              _bullet('A short, finite list of mutually exclusive options.'),
              _bullet('No free-form input or rich content area needed.'),
              _bullet('Selection should immediately resolve the dialog.'),
              const SizedBox(height: 14),
              Text('Anti-patterns', style: _styleSubtitle()),
              const SizedBox(height: 8),
              _bullet('Long, scrollable lists - prefer a dedicated picker '
                  'route or BottomSheet.', dot: _kErr),
              _bullet('Two-step flows - SimpleDialog has no built-in '
                  'OK/Cancel; selection is the commit.', dot: _kErr),
              const SizedBox(height: 14),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _codeChip('SimpleDialogOption'),
                  _codeChip('children: <SimpleDialogOption>'),
                  _codeChip('Navigator.pop<T>(context, value)'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _zoneRow(String name, String offset, Color tone, {bool selected = false}) {
  return SimpleDialogOption(
    onPressed: null,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: tone.withValues(alpha: 0.4)),
          ),
          child: Icon(Icons.public, size: 14, color: tone),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: _styleSubtitle(size: 13)),
              const SizedBox(height: 2),
              Text(offset, style: _styleBody(size: 11.5)),
            ],
          ),
        ),
        if (selected)
          Icon(Icons.check_circle, size: 18, color: _kOk)
        else
          Icon(Icons.radio_button_unchecked,
              size: 18, color: _kInkMuted.withValues(alpha: 0.6)),
      ],
    ),
  );
}

// =============================================================================
//  S E C T I O N   05  ::  Dialog.fullscreen
// =============================================================================

Widget _section05FullscreenDialog() {
  return _sectionCard(
    number: '05',
    title: 'Dialog.fullscreen :: takeover surface',
    subtitle:
        'Dialog.fullscreen ignores insetPadding entirely and fills the route. '
        'Use it for forms, multi-step flows or anything that needs more real '
        'estate than a normal dialog allows.',
    stripe: _kOk,
    tint: _kOkSoft,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              height: 380,
              decoration: BoxDecoration(
                color: _kPaperWarm,
                border: Border.all(color: _kBorder),
                borderRadius: BorderRadius.circular(14),
              ),
              child: _fakeFullscreenDialog(),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Why fullscreen?', style: _styleSubtitle()),
              const SizedBox(height: 8),
              _bullet('You need to host an entire form, not just a confirm '
                  'prompt.'),
              _bullet('You want a CLOSE button (X) in an AppBar instead of '
                  'OK/Cancel buttons.'),
              _bullet('The screen is small (phones in portrait) and a '
                  'centred dialog would feel cramped.'),
              const SizedBox(height: 14),
              Text('Differences from Dialog', style: _styleSubtitle()),
              const SizedBox(height: 8),
              _bullet('No barrier - the route covers the previous screen '
                  'fully.'),
              _bullet('No insetPadding / shape - it is the route.'),
              _bullet('Typical pattern: Scaffold + AppBar(leading: close, '
                  'actions: [Save])'),
              const SizedBox(height: 12),
              _calloutPill(
                label: 'NAV PATTERN: Navigator.pop()',
                color: _kOk,
                icon: Icons.arrow_back,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _fakeFullscreenDialog() {
  return Column(
    children: [
      // Fake AppBar.
      Container(
        height: 44,
        color: _kAccentDeep,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(Icons.close, size: 20, color: Colors.white),
            const SizedBox(width: 14),
            Text(
              'Edit profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'SAVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
      // Fake form body.
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fakeField('Display name', 'Alexis Q.'),
              const SizedBox(height: 14),
              _fakeField('Email', 'alexis@example.com'),
              const SizedBox(height: 14),
              _fakeField('Phone', '+49 30 123 456 78'),
              const SizedBox(height: 14),
              _fakeField('Bio', 'Building tools for Tom AI.'),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: _kInkMuted),
                  const SizedBox(width: 6),
                  Text(
                    'Changes are saved when you tap SAVE.',
                    style: _styleCaption(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _fakeField(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: _styleCaption(color: _kInkSoft)),
      const SizedBox(height: 4),
      Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kBorder),
        ),
        child: Text(value, style: _styleBody(size: 13)),
      ),
    ],
  );
}

// =============================================================================
//  S E C T I O N   06  ::  insetPadding GRID
// =============================================================================

Widget _section06InsetPaddingGrid() {
  return _sectionCard(
    number: '06',
    title: 'insetPadding :: how far from the edges?',
    subtitle:
        'insetPadding is the outer breathing room. It is independent of the '
        'dialog\'s own internal padding. Below: the same Dialog rendered '
        'with four common inset values.',
    stripe: _kWarn,
    tint: _kWarnSoft,
    body: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _insetCell(
                'EdgeInsets.all(8)',
                'tight - phone-portrait modal feel',
                const EdgeInsets.all(8),
                _kAccent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _insetCell(
                'symmetric(h:40, v:24)',
                'M3 default',
                const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                _kViolet,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _insetCell(
                'EdgeInsets.all(64)',
                'wide - tablet feel',
                const EdgeInsets.all(64),
                _kOk,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _insetCell(
                'fromLTRB(80,40,40,40)',
                'asymmetric - rare; intentional',
                const EdgeInsets.fromLTRB(80, 40, 40, 40),
                _kErr,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _calloutPill(
              label: 'CLAMPS WIDTH',
              color: _kInkSoft,
              icon: Icons.swap_horiz,
            ),
            _calloutPill(
              label: 'IGNORED IN .fullscreen',
              color: _kWarn,
              icon: Icons.warning_amber_outlined,
            ),
            _calloutPill(
              label: 'PER-EDGE CONTROL',
              color: _kAccent,
              icon: Icons.straighten,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _insetCell(String label, String desc, EdgeInsets inset, Color tone) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _codeChip(label, color: tone),
      const SizedBox(height: 4),
      Text(desc, style: _styleBody(size: 12)),
      const SizedBox(height: 8),
      ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E2D5),
            border: Border.all(color: _kBorder, width: 1.2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: _fakePageContent()),
              Positioned.fill(
                child: ColoredBox(
                  color: _kBarrier.withValues(alpha: 0.4),
                ),
              ),
              Positioned.fill(child: _insetGhost(inset, tone)),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _insetGhost(EdgeInsets inset, Color tone) {
  return Container(
    padding: inset,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone, width: 1.6),
        boxShadow: [
          BoxShadow(
            color: tone.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: _kInkMuted.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: _kInkMuted.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
//  S E C T I O N   07  ::  surfaceTintColor SWATCHES
// =============================================================================

Widget _section07SurfaceTintSwatches() {
  return _sectionCard(
    number: '07',
    title: 'surfaceTintColor :: M3 elevation tint',
    subtitle:
        'In Material 3, elevated surfaces get a subtle tint colour blended '
        'into their background. surfaceTintColor controls that blend on the '
        'Dialog itself - here are five common picks.',
    stripe: _kAccentDeep,
    tint: _kAccentSoft,
    body: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _tintSwatch('primary', _kAccent),
        _tintSwatch('tertiary', _kViolet),
        _tintSwatch('error', _kErr),
        _tintSwatch('warn', _kWarn),
        _tintSwatch('success', _kOk),
        _tintSwatch('transparent', Colors.transparent, label: 'no tint'),
      ],
    ),
  );
}

Widget _tintSwatch(String name, Color color, {String? label}) {
  return Container(
    width: 200,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _kBorder),
              ),
            ),
            const SizedBox(width: 8),
            Text(name, style: _styleSubtitle(size: 13)),
          ],
        ),
        const SizedBox(height: 8),
        // Mini dialog preview at elevation 1, 6, 12 for this tint.
        Row(
          children: [
            _miniTinted(color, 1),
            const SizedBox(width: 6),
            _miniTinted(color, 6),
            const SizedBox(width: 6),
            _miniTinted(color, 12),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('e1', style: _styleCaption()),
            Text('e6', style: _styleCaption()),
            Text('e12', style: _styleCaption()),
          ],
        ),
        if (label != null) ...[
          const SizedBox(height: 6),
          Text(label, style: _styleCaption(color: _kInkMuted)),
        ],
      ],
    ),
  );
}

Widget _miniTinted(Color color, double elevation) {
  // Simulate the M3 tint blend: alpha grows with elevation.
  final double alpha = (elevation / 24).clamp(0.0, 1.0).toDouble();
  return Expanded(
    child: Container(
      height: 38,
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          color.withValues(alpha: alpha * 0.9),
          Colors.white,
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kBorder),
      ),
    ),
  );
}

// =============================================================================
//  S E C T I O N   08  ::  shape VARIANTS
// =============================================================================

Widget _section08ShapeVariants() {
  return _sectionCard(
    number: '08',
    title: 'shape :: from rounded to ridiculous',
    subtitle:
        'shape accepts any ShapeBorder. The standard picks are '
        'RoundedRectangleBorder, BeveledRectangleBorder, ContinuousRectangle, '
        'StadiumBorder and any custom ShapeBorder you implement.',
    stripe: _kViolet,
    tint: _kVioletSoft,
    body: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _shapeCell('rounded :: r=4',
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        _shapeCell('rounded :: r=20',
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        _shapeCell('rounded :: r=28 (M3 default)',
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
        _shapeCell('beveled :: r=12',
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(12))),
        _shapeCell('continuous :: r=18',
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(18))),
        _shapeCell('stadium', const StadiumBorder()),
        _shapeCell(
          'asymmetric corners',
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
        _shapeCell(
          'rounded + outline',
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: _kViolet, width: 2),
          ),
        ),
      ],
    ),
  );
}

Widget _shapeCell(String label, ShapeBorder shape) {
  return SizedBox(
    width: 180,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _codeChip(label, color: _kViolet),
        const SizedBox(height: 6),
        Container(
          height: 110,
          decoration: BoxDecoration(
            color: _kPaperWarm,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kBorder),
          ),
          padding: const EdgeInsets.all(12),
          child: Material(
            color: Colors.white,
            shape: shape,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 8,
                    width: 80,
                    decoration: BoxDecoration(
                      color: _kViolet,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: _kInkMuted.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: _kInkMuted.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(3),
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

// =============================================================================
//  S E C T I O N   09  ::  THE BARRIER EXPLAINER
// =============================================================================

Widget _section09BarrierExplainer() {
  return _sectionCard(
    number: '09',
    title: 'The Barrier :: an entire layer that exists just to be tapped',
    subtitle:
        'When you call showDialog<T>(), Flutter inserts an extra modal route. '
        'That route paints a translucent "barrier" between the previous '
        'screen and your dialog. The barrier owns dismiss-on-tap and '
        'a11y-block semantics.',
    stripe: _kInkSoft,
    tint: const Color(0xFFDDDDD7),
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _barrierStackDiagram(),
        ),
        const SizedBox(width: 18),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Barrier parameters', style: _styleSubtitle()),
              const SizedBox(height: 8),
              _bullet('barrierColor - default Colors.black54.'),
              _bullet('barrierDismissible - tap-on-barrier closes the route. '
                  'Default true.'),
              _bullet('barrierLabel - announced by screen readers. Required '
                  'when barrierDismissible is true.'),
              _bullet('useSafeArea - whether the dialog avoids the system '
                  'cut-outs. Default true.'),
              _bullet('useRootNavigator - which Navigator hosts the route.'),
              const SizedBox(height: 12),
              _calloutPill(
                label: 'BARRIER IS A WIDGET',
                color: _kInk,
                icon: Icons.layers_outlined,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _barrierStackDiagram() {
  return Container(
    height: 320,
    decoration: BoxDecoration(
      color: _kPaperWarm,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kBorder),
    ),
    child: Stack(
      children: [
        // Layer 1: previous route.
        Positioned(
          left: 14,
          top: 14,
          right: 70,
          bottom: 70,
          child: _stackLayer('Previous route', _kAccent),
        ),
        // Layer 2: barrier.
        Positioned(
          left: 34,
          top: 34,
          right: 50,
          bottom: 50,
          child: _stackLayer(
            'Modal barrier (tap to dismiss)',
            _kInk.withValues(alpha: 0.7),
            dashed: true,
            labelColor: Colors.white,
          ),
        ),
        // Layer 3: dialog.
        Positioned(
          left: 60,
          top: 60,
          right: 30,
          bottom: 30,
          child: _stackLayer('Dialog', Colors.white,
              labelColor: _kInk, accent: _kAccent),
        ),
        // Floating arrows.
        Positioned(
          left: 8,
          top: 4,
          child: _annoTag('Stack order : bottom -> top', _kInkSoft),
        ),
        Positioned(
          right: 8,
          bottom: 4,
          child: _annoTag('top wins hit-tests', _kErr),
        ),
      ],
    ),
  );
}

Widget _stackLayer(
  String label,
  Color color, {
  bool dashed = false,
  Color labelColor = _kInk,
  Color? accent,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: accent ?? _kBorder,
        width: dashed ? 1.5 : 1.2,
        style: BorderStyle.solid,
      ),
      boxShadow: [
        BoxShadow(
          color: _kInk.withValues(alpha: 0.12),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(10),
    child: Align(
      alignment: Alignment.topLeft,
      child: Text(
        label,
        style: TextStyle(
          color: labelColor,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}

// =============================================================================
//  S E C T I O N   10  ::  showDialog<T>() FLOW DIAGRAM
// =============================================================================

Widget _section10ShowDialogFlow() {
  return _sectionCard(
    number: '10',
    title: 'showDialog<T>() :: the lifecycle, drawn out',
    subtitle:
        'The function returns Future<T?>. T is whatever Navigator.pop is '
        'called with. Below: the call sequence as a left-to-right pipeline.',
    stripe: _kAccent,
    tint: _kAccentSoft,
    body: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _flowBox('Call site', 'showDialog<bool>(...)', _kAccent),
            _flowArrow(),
            _flowBox('Route push', 'DialogRoute<T> on Navigator', _kViolet),
            _flowArrow(),
            _flowBox('Barrier paint', 'ModalBarrier inserted', _kInkSoft),
            _flowArrow(),
            _flowBox('Builder runs', 'returns Dialog widget', _kOk),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _flowBox('User taps action', 'onPressed callback', _kWarn),
            _flowArrow(),
            _flowBox('Navigator.pop<T>(value)', 'completes future', _kErr),
            _flowArrow(),
            _flowBox('Future<T?> resolves', 'caller awaits result', _kAccent),
            _flowArrow(),
            _flowBox('Cleanup', 'route disposed; barrier removed', _kViolet),
          ],
        ),
        const SizedBox(height: 16),
        _calloutPill(
          label: 'REMEMBER :: T? CAN BE NULL ON BARRIER DISMISS',
          color: _kErr,
          icon: Icons.warning_amber_outlined,
        ),
      ],
    ),
  );
}

Widget _flowBox(String title, String code, Color tone) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: tone,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(code, style: _styleMono(size: 10.5)),
        ],
      ),
    ),
  );
}

Widget _flowArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Icon(Icons.east, size: 18, color: _kInkSoft),
  );
}

// =============================================================================
//  S E C T I O N   11  ::  RTL / LTR FLIP
// =============================================================================

Widget _section11RtlLtrFlip() {
  return _sectionCard(
    number: '11',
    title: 'RTL / LTR :: how dialogs flip',
    subtitle:
        'AlertDialog uses logical edges, so titles, content and the actions '
        'row mirror cleanly when textDirection is RTL. The shape and '
        'insetPadding stay the same; only directional layout flips.',
    stripe: _kWarn,
    tint: _kWarnSoft,
    body: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _calloutPill(
                label: 'TextDirection.ltr',
                color: _kAccent,
                icon: Icons.format_textdirection_l_to_r,
              ),
              const SizedBox(height: 8),
              Directionality(
                textDirection: TextDirection.ltr,
                child: _barrierFrame(
                  minHeight: 280,
                  dialog: _flipDialog('Move file?', 'Cancel', 'Move',
                      'The file will be moved to the Archive folder.'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _calloutPill(
                label: 'TextDirection.rtl',
                color: _kErr,
                icon: Icons.format_textdirection_r_to_l,
              ),
              const SizedBox(height: 8),
              Directionality(
                textDirection: TextDirection.rtl,
                child: _barrierFrame(
                  minHeight: 280,
                  dialog: _flipDialog('نقل الملف؟', 'إلغاء', 'نقل',
                      'سيتم نقل الملف إلى مجلد الأرشيف.'),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flipDialog(String title, String cancel, String confirm, String body) {
  return AlertDialog(
    title: Text(title, style: _styleTitle(size: 18)),
    content: Text(body, style: _styleBody(size: 13)),
    actions: [
      TextButton(onPressed: null, child: Text(cancel)),
      TextButton(onPressed: null, child: Text(confirm)),
    ],
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}

// =============================================================================
//  S E C T I O N   12  ::  SCROLLABLE ALERT CONTENT
// =============================================================================

Widget _section12ScrollableContent() {
  return _sectionCard(
    number: '12',
    title: 'Scrollable AlertDialog content',
    subtitle:
        'AlertDialog\'s content area can hold a SingleChildScrollView. The '
        'title and actions remain pinned; only the content scrolls. Useful '
        'for long terms-of-service style copy.',
    stripe: _kOk,
    tint: _kOkSoft,
    body: _barrierFrame(
      minHeight: 460,
      dialog: AlertDialog(
        title: Row(
          children: [
            Icon(Icons.description_outlined, color: _kAccent, size: 22),
            const SizedBox(width: 8),
            Text('Terms of Service', style: _styleTitle(size: 18)),
          ],
        ),
        content: SizedBox(
          width: 380,
          height: 220,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 1; i <= 8; i++) ...[
                    Text('Article $i', style: _styleSubtitle(size: 13)),
                    const SizedBox(height: 4),
                    Text(
                      'This article describes obligation $i, in long-form '
                      'detail, including subclauses, definitions, and the '
                      'list of edge cases that the legal team insisted we '
                      'enumerate. Please read carefully before proceeding. '
                      'The provisions herein are governed by the laws of '
                      'an unnamed jurisdiction and apply equally to all '
                      'parties unless explicitly waived in writing.',
                      style: _styleBody(size: 12.5),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: null, child: Text('Decline')),
          TextButton(
            onPressed: null,
            style: TextButton.styleFrom(foregroundColor: _kOk),
            child: Text('Accept'),
          ),
        ],
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}

// =============================================================================
//  S E C T I O N   13  ::  ACCESSIBILITY CALLOUTS
// =============================================================================

Widget _section13Accessibility() {
  return _sectionCard(
    number: '13',
    title: 'Accessibility callouts',
    subtitle:
        'Dialogs are a high-trust surface: focus traps the user, screen '
        'readers announce them as modal. There are five things you must get '
        'right.',
    stripe: _kAccent,
    tint: _kAccentSoft,
    body: Column(
      children: [
        _a11yRow('1', 'barrierLabel set when dismissible',
            'Screen readers announce a name for the dismissable region.'),
        _a11yRow('2', 'Use semantic title widget',
            'Wrap title in Text - AlertDialog applies title-role semantics.'),
        _a11yRow('3', 'Action buttons are real Buttons',
            'Use TextButton/FilledButton, not InkWell on Text.'),
        _a11yRow('4', 'Avoid colour-only meaning',
            'Pair red/green action buttons with explicit verbs.'),
        _a11yRow('5', 'Respect MediaQuery.textScalerOf(context)',
            'AlertDialog already scrolls long content; do not lock heights.'),
      ],
    ),
  );
}

Widget _a11yRow(String n, String title, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: _kAccent),
          ),
          child: Text(
            n,
            style: TextStyle(
              color: _kAccent,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _styleSubtitle(size: 13.5)),
              const SizedBox(height: 2),
              Text(desc, style: _styleBody(size: 12.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  S E C T I O N   14  ::  COMMON PITFALLS
// =============================================================================

Widget _section14Pitfalls() {
  return _sectionCard(
    number: '14',
    title: 'Pitfalls :: things that bite real codebases',
    subtitle:
        'A field guide to the dialog footguns that come up in code review.',
    stripe: _kErr,
    tint: _kErrSoft,
    body: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _pitfallCard(
          'Using context after pop',
          'After awaiting showDialog, the BuildContext may be deactivated. '
              'Capture state first or guard with `if (mounted) ...`.',
          Icons.bug_report_outlined,
        ),
        _pitfallCard(
          'Type parameter mismatch',
          'showDialog<bool>() with Navigator.pop(context, "yes") returns '
              'null because the type does not match.',
          Icons.error_outline,
        ),
        _pitfallCard(
          'Tap-through barrier',
          'Setting barrierColor: Colors.transparent does NOT disable taps; '
              'the barrier is still there. Use barrierDismissible: false to '
              'prevent dismiss.',
          Icons.touch_app_outlined,
        ),
        _pitfallCard(
          'Locked dialog height',
          'Forcing SizedBox(height: 600) on AlertDialog content breaks '
              'scaling on small devices and large textScaler.',
          Icons.height_outlined,
        ),
        _pitfallCard(
          'Stacked dialogs',
          'Calling showDialog inside another dialog\'s onPressed makes nested '
              'modals; navigation back can be confusing.',
          Icons.layers_clear_outlined,
        ),
        _pitfallCard(
          'Forgetting useRootNavigator',
          'Inside a nested Navigator (tab views), the dialog may end up '
              'inside that tab\'s stack instead of the app root.',
          Icons.account_tree_outlined,
        ),
      ],
    ),
  );
}

Widget _pitfallCard(String title, String body, IconData icon) {
  return SizedBox(
    width: 260,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kErr.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kErr.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _kErr, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(title, style: _styleSubtitle(size: 13.5, color: _kErr)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(body, style: _styleBody(size: 12)),
        ],
      ),
    ),
  );
}

// =============================================================================
//  S E C T I O N   15  ::  DECISION MATRIX
// =============================================================================

Widget _section15DecisionMatrix() {
  return _sectionCard(
    number: '15',
    title: 'Decision matrix :: which dialog to reach for',
    subtitle:
        'A quick lookup table. Pick a row, follow the recommended widget.',
    stripe: _kInkSoft,
    tint: const Color(0xFFE8E2D5),
    body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: [
          _matrixHeader(),
          _matrixRow('Confirm a destructive action',
              'AlertDialog', 'icon + title + content + 2 actions', _kErr),
          _matrixRow('Pick one of 2-6 options',
              'SimpleDialog', 'option list', _kViolet),
          _matrixRow('Show a long form',
              'Dialog.fullscreen', 'AppBar with close+save', _kOk),
          _matrixRow('Show transient progress',
              'Dialog (custom)', 'centered card with spinner mock', _kAccent),
          _matrixRow('Custom popover with image + content',
              'Dialog (custom)', 'compose any child', _kAccent),
          _matrixRow('About-this-app screen',
              'AboutDialog', 'pre-built; uses Dialog under the hood', _kWarn),
          _matrixRow('Date or time selection',
              'showDatePicker / showTimePicker', 'specialized dialogs', _kViolet),
        ],
      ),
    ),
  );
}

Widget _matrixHeader() {
  return Container(
    decoration: BoxDecoration(
      color: _kInkSoft,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: [
        Expanded(flex: 4, child: Text('Use case', style: _matrixHeaderText())),
        Expanded(flex: 3, child: Text('Widget', style: _matrixHeaderText())),
        Expanded(flex: 4, child: Text('Note', style: _matrixHeaderText())),
      ],
    ),
  );
}

TextStyle _matrixHeaderText() {
  return TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.6,
  );
}

Widget _matrixRow(String useCase, String widget, String note, Color tone) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: _kBorder),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Text(useCase, style: _styleBody(size: 13, color: _kInk)),
        ),
        Expanded(
          flex: 3,
          child: _codeChip(widget, color: tone),
        ),
        Expanded(
          flex: 4,
          child: Text(note, style: _styleBody(size: 12)),
        ),
      ],
    ),
  );
}

// =============================================================================
//  S E C T I O N   16  ::  FOOTER
// =============================================================================

Widget _section16Footer() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kAccent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(Icons.menu_book_outlined,
              color: Colors.white, size: 30),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'End of the Dialog atlas.',
                style: _styleTitle(color: Colors.white, size: 20),
              ),
              const SizedBox(height: 4),
              Text(
                'Sixteen sections, four widgets, one barrier - and zero '
                'showDialog calls in this entire file. All snapshots are '
                'rendered inline, no async required. Use this file as a '
                'visual reference when reviewing or designing modal flows.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _footerTag('Dialog'),
                  _footerTag('AlertDialog'),
                  _footerTag('SimpleDialog'),
                  _footerTag('Dialog.fullscreen'),
                  _footerTag('Barrier'),
                  _footerTag('insetPadding'),
                  _footerTag('shape'),
                  _footerTag('surfaceTintColor'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _footerTag(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// =============================================================================
//  E N D   O F   F I L E
// =============================================================================
