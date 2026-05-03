// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of CupertinoTextSelectionToolbar.
//
// This script is hand-authored for the d4rt analyzer-free interpreter.  It is
// shipped over HTTP to a d4rt-driven Flutter test app where it must render
// meaningful varied visuals within the static-only sandbox (no setState, no
// AnimationController, no Tween.animate().value, no for-in over BridgedInstance).
//
// The focus is the iOS pill-shaped selection toolbar:
//   - CupertinoTextSelectionToolbar(anchorAbove, anchorBelow, children)
//   - CupertinoTextSelectionToolbarButton.text(...)
//   - CupertinoTextSelectionToolbarButton.buttonItem(...)
//   - CupertinoTextSelectionControls (the controls factory class)
//   - CupertinoAdaptiveTextSelectionToolbar (mentioned, compared)
//
// The toolbar widget is rendered live multiple times inside fixed-size Stacks
// with explicit anchor offsets, and small anchor markers (circles) overlay the
// background so the user can see how the anchor offset maps to toolbar layout.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

dynamic build(BuildContext context) {
  print('CupertinoTextSelectionToolbar deep visual demo starting');
  return CupertinoApp(
    title: 'CupertinoTextSelectionToolbar Demo',
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Selection Controls'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildIntroCard(),
            const SizedBox(height: 18),
            _buildAnchorAboveSection(),
            const SizedBox(height: 18),
            _buildAnchorBelowSection(),
            const SizedBox(height: 18),
            _buildButtonVariants(),
            const SizedBox(height: 18),
            _buildToolbarSurrogate(),
            const SizedBox(height: 18),
            _buildAnatomyDiagram(),
            const SizedBox(height: 18),
            _buildVsMaterialSection(),
            const SizedBox(height: 18),
            _buildControlsClassSection(),
            const SizedBox(height: 18),
            _buildAdaptiveToolbarSection(),
            const SizedBox(height: 18),
            _buildUsageGuide(),
            const SizedBox(height: 18),
            _buildFooter(),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 — Intro card.
// ---------------------------------------------------------------------------
Widget _buildIntroCard() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0A84FF),
          Color(0xFF5E5CE6),
          Color(0xFFBF5AF2),
        ],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x553A3A50),
          blurRadius: 22,
          offset: Offset(0, 12),
        ),
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0x66FFFFFF),
                  width: 1.2,
                ),
              ),
              child: const Icon(
                CupertinoIcons.text_cursor,
                color: Color(0xFFFFFFFF),
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'CupertinoTextSelectionToolbar',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'iOS-style pill toolbar that pops over selected text.',
                    style: TextStyle(
                      color: Color(0xCCFFFFFF),
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0x22FFFFFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0x33FFFFFF), width: 1),
          ),
          child: const Text(
            'Constructor highlights:\n'
            '  CupertinoTextSelectionToolbar({required Offset anchorAbove,\n'
            '                                 required Offset anchorBelow,\n'
            '                                 required List<Widget> children})\n'
            '  CupertinoTextSelectionToolbarButton.text({onPressed, text})\n'
            '  CupertinoTextSelectionToolbarButton.buttonItem({onPressed, buttonItem})',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 12,
              fontFamily: 'Menlo',
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _pillBadge('iOS pill shape'),
            _pillBadge('Auto position'),
            _pillBadge('Cut / Copy / Paste'),
            _pillBadge('Look Up · Share'),
            _pillBadge('Translate · Search'),
          ],
        ),
      ],
    ),
  );
}

Widget _pillBadge(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: const Color(0x66FFFFFF), width: 1),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Generic section header with gradient + icon.
// ---------------------------------------------------------------------------
Widget _sectionHeader({
  required String title,
  required String subtitle,
  required IconData icon,
  required List<Color> gradient,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: gradient,
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFFFFFFFF), size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xCCFFFFFF),
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Generic section frame (header on top, body below) with white card + shadow.
Widget _sectionFrame({
  required String title,
  required String subtitle,
  required IconData icon,
  required List<Color> gradient,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          title: title,
          subtitle: subtitle,
          icon: icon,
          gradient: gradient,
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: body,
        ),
      ],
    ),
  );
}

Widget _paragraph(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF1C1C1E),
        fontSize: 13,
        height: 1.45,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Anchor marker — small circle with a thin crosshair, marking where the anchor
// offset would actually point.  Used in toolbar Stacks so the visual mapping
// from anchor to toolbar tip is obvious.
// ---------------------------------------------------------------------------
Widget _anchorMarker({Color color = const Color(0xFFFF3B30)}) {
  return Container(
    width: 22,
    height: 22,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      shape: BoxShape.circle,
      border: Border.all(color: color, width: 1.4),
    ),
    child: Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    ),
  );
}

Widget _anchorLabel(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: const Color(0xCC1C1C1E),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// A faint dashed rectangle to suggest the "selected text region" the toolbar
// is pointing at.  Built from solid container to keep the static sandbox happy.
Widget _selectedTextStub({required double width, required double height}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: const Color(0x330A84FF),
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: const Color(0xFF0A84FF), width: 1),
    ),
    alignment: Alignment.center,
    child: const Text(
      'selected text',
      style: TextStyle(
        color: Color(0xFF0A84FF),
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 — Anchor Above (toolbar appears above the selection).
// ---------------------------------------------------------------------------
Widget _buildAnchorAboveSection() {
  return _sectionFrame(
    title: '2 · anchorAbove — toolbar floats above selection',
    subtitle: 'When there is room above the selection, iOS prefers anchorAbove.',
    icon: CupertinoIcons.arrow_up_circle_fill,
    gradient: const <Color>[Color(0xFF0A84FF), Color(0xFF30D158)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paragraph(
          'CupertinoTextSelectionToolbar receives two anchor offsets.  '
          'anchorAbove is the preferred screen-space target above the selection; '
          'when the toolbar fits there it points downward at this offset.  '
          'Below we render four real CupertinoTextSelectionToolbar widgets in '
          'fixed-size Stacks with their anchorAbove placed at different positions.  '
          'A red dot marks where the anchorAbove offset actually lands.',
        ),
        _anchorAboveStack(
          label: 'Centered, short selection',
          anchorAbove: const Offset(160, 130),
          anchorBelow: const Offset(160, 170),
          buttons: <Widget>[
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Cut',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Copy',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Paste',
            ),
          ],
          selectionLeft: 130,
          selectionTop: 145,
          selectionWidth: 60,
          selectionHeight: 16,
        ),
        const SizedBox(height: 12),
        _anchorAboveStack(
          label: 'Wider menu, larger selection',
          anchorAbove: const Offset(170, 120),
          anchorBelow: const Offset(170, 175),
          buttons: <Widget>[
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Cut',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Copy',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Paste',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Look Up',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Share',
            ),
          ],
          selectionLeft: 110,
          selectionTop: 150,
          selectionWidth: 120,
          selectionHeight: 16,
        ),
        const SizedBox(height: 12),
        _anchorAboveStack(
          label: 'Anchor near left edge',
          anchorAbove: const Offset(60, 110),
          anchorBelow: const Offset(60, 165),
          buttons: <Widget>[
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Copy',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Select All',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Look Up',
            ),
          ],
          selectionLeft: 30,
          selectionTop: 138,
          selectionWidth: 70,
          selectionHeight: 16,
        ),
        const SizedBox(height: 12),
        _anchorAboveStack(
          label: 'Anchor near right edge',
          anchorAbove: const Offset(280, 105),
          anchorBelow: const Offset(280, 160),
          buttons: <Widget>[
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Cut',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Copy',
            ),
          ],
          selectionLeft: 250,
          selectionTop: 132,
          selectionWidth: 60,
          selectionHeight: 16,
        ),
      ],
    ),
  );
}

Widget _anchorAboveStack({
  required String label,
  required Offset anchorAbove,
  required Offset anchorBelow,
  required List<Widget> buttons,
  required double selectionLeft,
  required double selectionTop,
  required double selectionWidth,
  required double selectionHeight,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF2F2F7),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD1D1D6), width: 1),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF0A84FF),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1C1C1E),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              'anchorAbove ${anchorAbove.dx.toStringAsFixed(0)},${anchorAbove.dy.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Color(0xFF8E8E93),
                fontSize: 10,
                fontFamily: 'Menlo',
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 220,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xFFFFFFFF), Color(0xFFE5E5EA)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned(
                left: selectionLeft,
                top: selectionTop,
                child: _selectedTextStub(
                  width: selectionWidth,
                  height: selectionHeight,
                ),
              ),
              Positioned(
                left: anchorAbove.dx - 11,
                top: anchorAbove.dy - 11,
                child: _anchorMarker(),
              ),
              Positioned(
                left: anchorAbove.dx + 14,
                top: anchorAbove.dy - 8,
                child: _anchorLabel('anchorAbove'),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: CupertinoTextSelectionToolbar(
                  anchorAbove: anchorAbove,
                  anchorBelow: anchorBelow,
                  children: buttons,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 — Anchor Below (toolbar drops below the selection).
// ---------------------------------------------------------------------------
Widget _buildAnchorBelowSection() {
  return _sectionFrame(
    title: '3 · anchorBelow — toolbar drops below selection',
    subtitle: 'When there is no room above (e.g. status bar), the toolbar uses anchorBelow.',
    icon: CupertinoIcons.arrow_down_circle_fill,
    gradient: const <Color>[Color(0xFFFF9500), Color(0xFFFF3B30)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paragraph(
          'anchorBelow is the fallback target placed underneath the selection.  '
          'When anchorAbove is too close to the top of the screen and the toolbar '
          'would clip, Flutter switches to anchorBelow and points the toolbar tip '
          'upward.  In a real app the framework picks one of the two; here we '
          'force the picture by giving each toolbar an anchorAbove that is too '
          'close to the top of its Stack so the toolbar uses anchorBelow.',
        ),
        _anchorBelowStack(
          label: 'Selection near top of viewport',
          anchorAbove: const Offset(160, 4),
          anchorBelow: const Offset(160, 60),
          buttons: <Widget>[
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Cut',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Copy',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Paste',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Select All',
            ),
          ],
          selectionLeft: 130,
          selectionTop: 30,
          selectionWidth: 60,
          selectionHeight: 16,
        ),
        const SizedBox(height: 12),
        _anchorBelowStack(
          label: 'Long menu pinned to the top',
          anchorAbove: const Offset(170, 2),
          anchorBelow: const Offset(170, 50),
          buttons: <Widget>[
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Cut',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Copy',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Paste',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Look Up',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Share',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Translate',
            ),
          ],
          selectionLeft: 100,
          selectionTop: 30,
          selectionWidth: 140,
          selectionHeight: 16,
        ),
        const SizedBox(height: 12),
        _anchorBelowStack(
          label: 'Tiny menu, single item',
          anchorAbove: const Offset(80, 2),
          anchorBelow: const Offset(80, 60),
          buttons: <Widget>[
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Copy',
            ),
          ],
          selectionLeft: 60,
          selectionTop: 30,
          selectionWidth: 40,
          selectionHeight: 16,
        ),
      ],
    ),
  );
}

Widget _anchorBelowStack({
  required String label,
  required Offset anchorAbove,
  required Offset anchorBelow,
  required List<Widget> buttons,
  required double selectionLeft,
  required double selectionTop,
  required double selectionWidth,
  required double selectionHeight,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8F0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFFD9B3), width: 1),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFFF9500),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1C1C1E),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              'anchorBelow ${anchorBelow.dx.toStringAsFixed(0)},${anchorBelow.dy.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Color(0xFF8E8E93),
                fontSize: 10,
                fontFamily: 'Menlo',
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 220,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xFFFFFFFF), Color(0xFFFFE9D2)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // Status-bar shadow at the top so it's clear there is no room above.
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Color(0x55000000),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'status bar (no room above)',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: selectionLeft,
                top: selectionTop,
                child: _selectedTextStub(
                  width: selectionWidth,
                  height: selectionHeight,
                ),
              ),
              Positioned(
                left: anchorBelow.dx - 11,
                top: anchorBelow.dy - 11,
                child: _anchorMarker(color: const Color(0xFFFF9500)),
              ),
              Positioned(
                left: anchorBelow.dx + 14,
                top: anchorBelow.dy - 8,
                child: _anchorLabel('anchorBelow'),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: CupertinoTextSelectionToolbar(
                  anchorAbove: anchorAbove,
                  anchorBelow: anchorBelow,
                  children: buttons,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 — Button variants (.text and .buttonItem).
// ---------------------------------------------------------------------------
Widget _buildButtonVariants() {
  return _sectionFrame(
    title: '4 · CupertinoTextSelectionToolbarButton variants',
    subtitle: '.text(...) for plain labels and .buttonItem(...) for ContextMenuButtonItem-driven menus.',
    icon: CupertinoIcons.square_grid_2x2_fill,
    gradient: const <Color>[Color(0xFF5E5CE6), Color(0xFF0A84FF)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paragraph(
          'Each child of the toolbar is normally a CupertinoTextSelectionToolbarButton.  '
          'Use .text() for the simple "label only" case (Cut, Copy, Paste, Select All).  '
          'Use .buttonItem() when you already have a ContextMenuButtonItem from the framework — '
          'for example the items returned by EditableTextState.contextMenuButtonItems — and you '
          'want the toolbar to derive its label automatically from the item type.  '
          'The default constructor accepts an arbitrary child, useful when you need an icon.',
        ),
        const SizedBox(height: 6),
        _variantRow(
          'CupertinoTextSelectionToolbarButton.text — standard labels',
          <Widget>[
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Cut',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Copy',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Paste',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Select All',
            ),
          ],
          const Offset(160, 130),
          const Offset(160, 170),
        ),
        const SizedBox(height: 12),
        _variantRow(
          'CupertinoTextSelectionToolbarButton.text — contextual labels',
          <Widget>[
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Look Up',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Translate',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Search',
            ),
            CupertinoTextSelectionToolbarButton.text(
              onPressed: () {},
              text: 'Share',
            ),
          ],
          const Offset(160, 130),
          const Offset(160, 170),
        ),
        const SizedBox(height: 12),
        _variantRow(
          'CupertinoTextSelectionToolbarButton.buttonItem — derived labels',
          <Widget>[
            CupertinoTextSelectionToolbarButton.buttonItem(
              buttonItem: ContextMenuButtonItem(
                onPressed: () {},
                type: ContextMenuButtonType.cut,
              ),
            ),
            CupertinoTextSelectionToolbarButton.buttonItem(
              buttonItem: ContextMenuButtonItem(
                onPressed: () {},
                type: ContextMenuButtonType.copy,
              ),
            ),
            CupertinoTextSelectionToolbarButton.buttonItem(
              buttonItem: ContextMenuButtonItem(
                onPressed: () {},
                type: ContextMenuButtonType.paste,
              ),
            ),
            CupertinoTextSelectionToolbarButton.buttonItem(
              buttonItem: ContextMenuButtonItem(
                onPressed: () {},
                type: ContextMenuButtonType.selectAll,
              ),
            ),
          ],
          const Offset(170, 130),
          const Offset(170, 170),
        ),
        const SizedBox(height: 12),
        _variantRow(
          'CupertinoTextSelectionToolbarButton — custom child (icons)',
          <Widget>[
            CupertinoTextSelectionToolbarButton(
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.scissors,
                size: 17,
                color: Color(0xFFFFFFFF),
              ),
            ),
            CupertinoTextSelectionToolbarButton(
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.doc_on_doc,
                size: 17,
                color: Color(0xFFFFFFFF),
              ),
            ),
            CupertinoTextSelectionToolbarButton(
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.doc_on_clipboard,
                size: 17,
                color: Color(0xFFFFFFFF),
              ),
            ),
            CupertinoTextSelectionToolbarButton(
              onPressed: () {},
              child: const Icon(
                Icons.translate,
                size: 17,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
          const Offset(170, 130),
          const Offset(170, 170),
        ),
      ],
    ),
  );
}

Widget _variantRow(
  String label,
  List<Widget> buttons,
  Offset anchorAbove,
  Offset anchorBelow,
) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF2F2F7),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD1D1D6), width: 1),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1C1C1E),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 220,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xFFFFFFFF), Color(0xFFE5E5EA)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned(
                left: anchorAbove.dx - 60,
                top: anchorAbove.dy + 18,
                child: _selectedTextStub(width: 120, height: 16),
              ),
              Positioned(
                left: anchorAbove.dx - 11,
                top: anchorAbove.dy - 11,
                child: _anchorMarker(),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: CupertinoTextSelectionToolbar(
                  anchorAbove: anchorAbove,
                  anchorBelow: anchorBelow,
                  children: buttons,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 — A "surrogate" pill drawn from primitives, side by side with the
// real CupertinoTextSelectionToolbar, so the user can compare visuals.
// ---------------------------------------------------------------------------
Widget _buildToolbarSurrogate() {
  return _sectionFrame(
    title: '5 · Real toolbar vs hand-drawn surrogate',
    subtitle: 'Visual cross-check — the real widget on the left, a primitive surrogate on the right.',
    icon: CupertinoIcons.rectangle_split_3x1_fill,
    gradient: const <Color>[Color(0xFFBF5AF2), Color(0xFF5E5CE6)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paragraph(
          'The left panel renders an actual CupertinoTextSelectionToolbar.  '
          'The right panel approximates the same look with a Container, dividers and '
          'CupertinoButton — useful when you want a custom toolbar without bringing '
          'in TextSelectionControls plumbing.',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _surrogateLeft()),
            const SizedBox(width: 10),
            Expanded(child: _surrogateRight()),
          ],
        ),
      ],
    ),
  );
}

Widget _surrogateLeft() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF2F2F7),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD1D1D6), width: 1),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Real CupertinoTextSelectionToolbar',
          style: TextStyle(
            color: Color(0xFF1C1C1E),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 220,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 150,
                child: _selectedTextStub(width: 80, height: 16),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: CupertinoTextSelectionToolbar(
                  anchorAbove: const Offset(90, 130),
                  anchorBelow: const Offset(90, 175),
                  children: <Widget>[
                    CupertinoTextSelectionToolbarButton.text(
                      onPressed: () {},
                      text: 'Cut',
                    ),
                    CupertinoTextSelectionToolbarButton.text(
                      onPressed: () {},
                      text: 'Copy',
                    ),
                    CupertinoTextSelectionToolbarButton.text(
                      onPressed: () {},
                      text: 'Paste',
                    ),
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

Widget _surrogateRight() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF2F2F7),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD1D1D6), width: 1),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Hand-drawn surrogate',
          style: TextStyle(
            color: Color(0xFF1C1C1E),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 220,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 150,
                child: _selectedTextStub(width: 80, height: 16),
              ),
              Positioned(
                left: 16,
                top: 100,
                child: _surrogatePill(),
              ),
              Positioned(
                left: 86,
                top: 134,
                child: _surrogateArrowDown(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _surrogatePill() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xEE2C2C2E),
      borderRadius: BorderRadius.circular(8),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _surrogateButton('Cut'),
        _surrogateDivider(),
        _surrogateButton('Copy'),
        _surrogateDivider(),
        _surrogateButton('Paste'),
      ],
    ),
  );
}

Widget _surrogateButton(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _surrogateDivider() {
  return Container(
    width: 1,
    height: 20,
    color: const Color(0x33FFFFFF),
  );
}

Widget _surrogateArrowDown() {
  return Container(
    width: 12,
    height: 8,
    alignment: Alignment.center,
    child: const Icon(
      CupertinoIcons.arrowtriangle_down_fill,
      color: Color(0xEE2C2C2E),
      size: 14,
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 — Anatomy diagram of the iOS pill toolbar.
// ---------------------------------------------------------------------------
Widget _buildAnatomyDiagram() {
  return _sectionFrame(
    title: '6 · Anatomy of the pill toolbar',
    subtitle: 'Pill body, divider strokes, button regions and arrow tip.',
    icon: CupertinoIcons.book_solid,
    gradient: const <Color>[Color(0xFF30D158), Color(0xFF0A84FF)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paragraph(
          'The pill consists of a rounded dark surface, equally-sized button regions '
          'separated by 1-pixel dividers, and a small triangular arrow that points to '
          'the anchor.  CupertinoTextSelectionToolbar handles all of this internally — '
          'the diagram below labels the parts you can recognise visually.',
        ),
        SizedBox(
          height: 260,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xFFF2F2F7), Color(0xFFE5E5EA)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 60,
                child: _surrogatePill(),
              ),
              Positioned(
                left: 100,
                top: 94,
                child: _surrogateArrowDown(),
              ),
              Positioned(
                left: 80,
                top: 130,
                child: _selectedTextStub(width: 80, height: 16),
              ),
              // Labels.
              Positioned(
                right: 16,
                top: 64,
                child: _annotationLabel(
                  '1. Pill body — rounded, dark, blurred shadow',
                  const Color(0xFF0A84FF),
                ),
              ),
              Positioned(
                right: 16,
                top: 94,
                child: _annotationLabel(
                  '2. Button region — equal padding, white text',
                  const Color(0xFF30D158),
                ),
              ),
              Positioned(
                right: 16,
                top: 124,
                child: _annotationLabel(
                  '3. Divider — 1px, 20% white over pill',
                  const Color(0xFFFF9500),
                ),
              ),
              Positioned(
                right: 16,
                top: 154,
                child: _annotationLabel(
                  '4. Arrow tip — points to anchor offset',
                  const Color(0xFFFF3B30),
                ),
              ),
              Positioned(
                right: 16,
                top: 184,
                child: _annotationLabel(
                  '5. Selection — what the toolbar refers to',
                  const Color(0xFFBF5AF2),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _annotationLabel(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF1C1C1E),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 — Cupertino vs Material side-by-side.
// ---------------------------------------------------------------------------
Widget _buildVsMaterialSection() {
  return _sectionFrame(
    title: '7 · Cupertino vs Material toolbar',
    subtitle: 'Same selection actions, two different design languages.',
    icon: CupertinoIcons.rectangle_on_rectangle,
    gradient: const <Color>[Color(0xFF64D2FF), Color(0xFFBF5AF2)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paragraph(
          'CupertinoTextSelectionToolbar produces a dark pill with a small triangular '
          'arrow that points at a specific Offset.  The Material equivalent — '
          'TextSelectionToolbar — produces a light flat card with text-styled buttons, '
          'no arrow, and overflow chevrons when there are too many actions to fit.  '
          'Use CupertinoAdaptiveTextSelectionToolbar to pick the right one per platform.',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _vsCupertinoTile()),
            const SizedBox(width: 10),
            Expanded(child: _vsMaterialTile()),
          ],
        ),
      ],
    ),
  );
}

Widget _vsCupertinoTile() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Color(0xFFFFFFFF), Color(0xFFEAEAF0)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD1D1D6), width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              CupertinoIcons.device_phone_portrait,
              size: 14,
              color: Color(0xFF0A84FF),
            ),
            const SizedBox(width: 4),
            const Text(
              'Cupertino (iOS)',
              style: TextStyle(
                color: Color(0xFF0A84FF),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 150,
                child: _selectedTextStub(width: 90, height: 16),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: CupertinoTextSelectionToolbar(
                  anchorAbove: const Offset(90, 130),
                  anchorBelow: const Offset(90, 175),
                  children: <Widget>[
                    CupertinoTextSelectionToolbarButton.text(
                      onPressed: () {},
                      text: 'Cut',
                    ),
                    CupertinoTextSelectionToolbarButton.text(
                      onPressed: () {},
                      text: 'Copy',
                    ),
                    CupertinoTextSelectionToolbarButton.text(
                      onPressed: () {},
                      text: 'Paste',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Pill, dark surface, arrow tip.\nButtons separated by thin dividers.',
          style: TextStyle(
            color: Color(0xFF1C1C1E),
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _vsMaterialTile() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Color(0xFFFFFFFF), Color(0xFFE5F2FF)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFB3D7FF), width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.android,
              size: 14,
              color: Color(0xFF34A853),
            ),
            const SizedBox(width: 4),
            const Text(
              'Material (Android)',
              style: TextStyle(
                color: Color(0xFF34A853),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 150,
                child: _selectedTextStub(width: 90, height: 16),
              ),
              Positioned(
                left: 24,
                top: 100,
                child: _materialSurrogate(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Light card, no arrow tip.\nLabels rendered in uppercase Material style.',
          style: TextStyle(
            color: Color(0xFF1C1C1E),
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _materialSurrogate() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _materialButton('CUT'),
        _materialButton('COPY'),
        _materialButton('PASTE'),
      ],
    ),
  );
}

Widget _materialButton(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFF1976D2),
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 — CupertinoTextSelectionControls factory class.
// ---------------------------------------------------------------------------
Widget _buildControlsClassSection() {
  return _sectionFrame(
    title: '8 · CupertinoTextSelectionControls — the factory',
    subtitle: 'The TextSelectionControls subclass that builds the iOS toolbar and handles.',
    icon: CupertinoIcons.gear_alt_fill,
    gradient: const <Color>[Color(0xFFFF9F0A), Color(0xFFFF3B30)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paragraph(
          'CupertinoTextSelectionControls is the TextSelectionControls implementation that '
          'a CupertinoTextField uses by default.  It is the object that decides — given the '
          'current selection — which CupertinoTextSelectionToolbar to construct, what handle '
          'shape to draw, and where the anchor offsets should fall.  Most apps interact with '
          'it through the cupertinoTextSelectionControls top-level singleton, but the class '
          'itself can be subclassed for a custom toolbar.',
        ),
        _bulletRow(
          'buildToolbar(...)',
          'Returns a CupertinoTextSelectionToolbar configured for the current selection.',
        ),
        _bulletRow(
          'buildHandle(...)',
          'Renders the small teardrop selection handles in the iOS-blue tint.',
        ),
        _bulletRow(
          'getHandleAnchor(...)',
          'Position of the anchor relative to the handle — pivots its rotation.',
        ),
        _bulletRow(
          'getHandleSize(...)',
          'Returns Size(22, 22) by default — the touch-friendly handle bounds.',
        ),
        _bulletRow(
          'cupertinoTextSelectionControls (singleton)',
          'Process-wide instance used by every CupertinoTextField unless overridden.',
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFFFB74D), width: 1),
          ),
          child: const Text(
            'Replace with: selectionControls: cupertinoTextSelectionControls\n'
            'on a Material EditableText to get the iOS-styled toolbar in a\n'
            'Material app.  Inverse works with materialTextSelectionControls.',
            style: TextStyle(
              color: Color(0xFF7A4F01),
              fontSize: 11,
              fontFamily: 'Menlo',
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bulletRow(String head, String tail) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 4, right: 8),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFFFF9500),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color(0xFF1C1C1E),
                fontSize: 12,
                height: 1.4,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '$head — ',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(text: tail),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 — CupertinoAdaptiveTextSelectionToolbar.
// ---------------------------------------------------------------------------
Widget _buildAdaptiveToolbarSection() {
  return _sectionFrame(
    title: '9 · CupertinoAdaptiveTextSelectionToolbar',
    subtitle: 'Picks the right toolbar style for the current platform.',
    icon: CupertinoIcons.device_laptop,
    gradient: const <Color>[Color(0xFF5856D6), Color(0xFFAF52DE)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paragraph(
          'CupertinoAdaptiveTextSelectionToolbar is a thin wrapper that detects the current '
          'TargetPlatform and builds either CupertinoTextSelectionToolbar (iOS / macOS) or '
          'TextSelectionToolbar (Android / others).  Its constructors mirror the underlying '
          'toolbar signatures: editable / editableText / selectable / buttonItems / default.',
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: _adaptiveCard(
                'iOS / macOS',
                'CupertinoTextSelectionToolbar (pill, dark, arrow)',
                const Color(0xFF0A84FF),
                CupertinoIcons.device_phone_portrait,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _adaptiveCard(
                'Android / Linux / Web',
                'TextSelectionToolbar (light card, no arrow)',
                const Color(0xFF34A853),
                Icons.android,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFE9E5FE), Color(0xFFD7C9FF)],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFAF52DE), width: 1),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Text(
            'CupertinoAdaptiveTextSelectionToolbar.editableText(\n'
            '  editableTextState: yourEditableTextState,\n'
            ')\n\n'
            'is the one-liner most apps want — it grabs the contextMenuButtonItems\n'
            'from the EditableText and produces the right toolbar for the platform.',
            style: TextStyle(
              color: Color(0xFF3F2A6E),
              fontSize: 11,
              fontFamily: 'Menlo',
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _adaptiveCard(
  String title,
  String body,
  Color tint,
  IconData icon,
) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tint.withOpacity(0.4), width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: tint, size: 16),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: tint,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(
            color: Color(0xFF1C1C1E),
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 — Usage guide / cheat sheet.
// ---------------------------------------------------------------------------
Widget _buildUsageGuide() {
  return _sectionFrame(
    title: '10 · Usage cheat sheet',
    subtitle: 'When to use which class.',
    icon: CupertinoIcons.book_circle_fill,
    gradient: const <Color>[Color(0xFF30D158), Color(0xFFFFD60A)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paragraph(
          'This cheat sheet collects the rules of thumb for picking the right class.  '
          'In practice most code only uses CupertinoAdaptiveTextSelectionToolbar.editableText '
          'and lets Flutter resolve everything; the lower-level classes become relevant when '
          'you build a custom selection experience.',
        ),
        _cheatRow(
          'CupertinoTextSelectionToolbar',
          'You want to build the pill yourself with custom children, anchored at specific offsets.',
          const Color(0xFF0A84FF),
        ),
        _cheatRow(
          'CupertinoTextSelectionToolbarButton.text',
          'Single label, no platform-specific localisation logic needed.',
          const Color(0xFF30D158),
        ),
        _cheatRow(
          'CupertinoTextSelectionToolbarButton.buttonItem',
          'You already have ContextMenuButtonItem objects (e.g. from EditableText).',
          const Color(0xFFFF9500),
        ),
        _cheatRow(
          'CupertinoTextSelectionControls',
          'You are subclassing TextSelectionControls or assigning a custom controls singleton.',
          const Color(0xFFFF3B30),
        ),
        _cheatRow(
          'CupertinoAdaptiveTextSelectionToolbar',
          'You want the right toolbar style automatically per platform — usually the right answer.',
          const Color(0xFFBF5AF2),
        ),
        _cheatRow(
          'cupertinoTextSelectionControls (singleton)',
          'Override selectionControls on a Material text field to use iOS-style controls.',
          const Color(0xFF5E5CE6),
        ),
      ],
    ),
  );
}

Widget _cheatRow(String name, String description, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.4), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 3, right: 8),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  color: Color(0xFF1C1C1E),
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Footer.
// ---------------------------------------------------------------------------
Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[Color(0xFF1C1C1E), Color(0xFF3A3A3C)],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        const Icon(
          CupertinoIcons.checkmark_seal_fill,
          color: Color(0xFF30D158),
          size: 22,
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Demo rendered live by d4rt — every CupertinoTextSelectionToolbar above is a real Flutter widget instance.',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
