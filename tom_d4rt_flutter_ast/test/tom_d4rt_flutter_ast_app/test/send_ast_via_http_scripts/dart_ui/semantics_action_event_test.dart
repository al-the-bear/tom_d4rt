// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unused_element

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// =====================================================================
// dart:ui SemanticsActionEvent — visual instructional demo
// =====================================================================
//
// This script teaches the engine-side struct `ui.SemanticsActionEvent`
// (defined in dart:ui's platform_dispatcher.dart). It is the value the
// Flutter engine hands to the framework whenever an assistive technology
// (TalkBack on Android, VoiceOver on iOS/macOS, NVDA + UIA on Windows,
// Orca on Linux, JAWS, Switch Control, etc.) wants the application to
// perform a semantic action on a particular semantics node.
//
// The struct itself is small but load-bearing:
//
//   class SemanticsActionEvent {
//     const SemanticsActionEvent({
//       required this.type,       // SemanticsAction (intent)
//       required this.viewId,     // int — which FlutterView
//       required this.nodeId,     // int — which SemanticsNode
//       this.arguments,           // Object? — optional payload
//     });
//   }
//
// Crucially: a SemanticsActionEvent is *intent-shaped* data. It does
// not say "user tapped at (x, y)" — it says "increase this slider" or
// "copy this text". The engine has already mapped the platform's raw
// AT primitive into a stable, framework-level intent. That makes the
// type a perfect teaching surface for the entire accessibility pipe.
//
// This file is hand-authored to be readable and visual:
//   * 9 sections, each with a gradient header and ≥3-sentence prose
//   * 12+ constructed `ui.SemanticsActionEvent` instances rendered
//   * 18+ distinct `SemanticsAction` constants exercised on the surface
//   * diagrams, tables, recipe cards, footgun panels, comparison view
//
// All widgets are stateless. `build` is called exactly once. The bridge
// runs this with a strictly limited subset (no setState, no async, no
// for-in over BridgedInstance, no top-level classes/mixins/extensions).
// =====================================================================

// ---------------------------------------------------------------------
// Color palette — used pervasively below. Defined as top-level const
// helpers (NOT a class) to satisfy the bridge's "top-level functions
// and const data only" constraint.
// ---------------------------------------------------------------------

const Color _kPageBg = Color(0xFF0E1B2D);
const Color _kPanelBg = Color(0xFF15263F);
const Color _kPanelBgAlt = Color(0xFF1B2F4F);
const Color _kPanelBorder = Color(0xFF2A4670);
const Color _kInk = Color(0xFFE6ECF7);
const Color _kInkSoft = Color(0xFFB8C4DA);
const Color _kInkDim = Color(0xFF7E8DAA);
const Color _kAccentCyan = Color(0xFF4FD3FF);
const Color _kAccentMint = Color(0xFF6CE9C2);
const Color _kAccentAmber = Color(0xFFFFC857);
const Color _kAccentRose = Color(0xFFFF7AA2);
const Color _kAccentViolet = Color(0xFFB48BFF);
const Color _kAccentLime = Color(0xFFB8E66B);
const Color _kAccentPeach = Color(0xFFFFB07A);
const Color _kAccentSky = Color(0xFF7CC2FF);
const Color _kDanger = Color(0xFFFF6B6B);
const Color _kSuccess = Color(0xFF4ADE80);

// ---------------------------------------------------------------------
// Gradient bank — every section header pulls from this list, plus a
// handful of cards and diagram boxes use these gradients directly.
// ---------------------------------------------------------------------

LinearGradient _gradHeader1() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF1F4690), Color(0xFF4FD3FF)],
  );
}

LinearGradient _gradHeader2() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF114B5F), Color(0xFF6CE9C2)],
  );
}

LinearGradient _gradHeader3() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF6A1B9A), Color(0xFFB48BFF)],
  );
}

LinearGradient _gradHeader4() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFFB45309), Color(0xFFFFC857)],
  );
}

LinearGradient _gradHeader5() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF7A1F4A), Color(0xFFFF7AA2)],
  );
}

LinearGradient _gradHeader6() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF0D5C46), Color(0xFFB8E66B)],
  );
}

LinearGradient _gradHeader7() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF7C2D12), Color(0xFFFFB07A)],
  );
}

LinearGradient _gradHeader8() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF0F3D6E), Color(0xFF7CC2FF)],
  );
}

LinearGradient _gradHeader9() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF263238), Color(0xFF607D8B)],
  );
}

LinearGradient _gradPanel(Color a, Color b) {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[a, b],
  );
}

LinearGradient _gradEnumChip() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFF1F3A66), Color(0xFF15263F)],
  );
}

// ---------------------------------------------------------------------
// Shadow bank — referenced by panels, chips, and diagram nodes.
// ---------------------------------------------------------------------

List<BoxShadow> _shadowSoft() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x55000000),
      blurRadius: 18,
      offset: Offset(0, 6),
    ),
  ];
}

List<BoxShadow> _shadowGlowCyan() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x554FD3FF),
      blurRadius: 24,
      offset: Offset(0, 0),
    ),
  ];
}

List<BoxShadow> _shadowGlowMint() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x556CE9C2),
      blurRadius: 24,
      offset: Offset(0, 0),
    ),
  ];
}

List<BoxShadow> _shadowGlowAmber() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x55FFC857),
      blurRadius: 24,
      offset: Offset(0, 0),
    ),
  ];
}

List<BoxShadow> _shadowGlowRose() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x55FF7AA2),
      blurRadius: 24,
      offset: Offset(0, 0),
    ),
  ];
}

List<BoxShadow> _shadowGlowViolet() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x55B48BFF),
      blurRadius: 24,
      offset: Offset(0, 0),
    ),
  ];
}

List<BoxShadow> _shadowDeep() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x99000000),
      blurRadius: 28,
      offset: Offset(0, 12),
    ),
  ];
}

// ---------------------------------------------------------------------
// Section header — a thick, gradient-filled label that introduces each
// teaching block. Includes a numeric chip, a title, and a subtitle.
// ---------------------------------------------------------------------

Widget _sectionHeader({
  required int index,
  required String title,
  required String subtitle,
  required LinearGradient gradient,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(18),
      boxShadow: _shadowDeep(),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Color(0x55FFFFFF), width: 1),
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFFEAF1FF),
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0x22FFFFFF),
            shape: BoxShape.circle,
            border: Border.all(color: Color(0x44FFFFFF), width: 1),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Prose paragraph — a styled multi-sentence text card used to put
// substantive teaching content next to the visuals.
// ---------------------------------------------------------------------

Widget _prose(String text) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _kPanelBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kPanelBorder, width: 1),
      boxShadow: _shadowSoft(),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: _kInkSoft,
        fontSize: 14.5,
        height: 1.55,
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// Field tag — a labelled monospace badge used in the anatomy diagram.
// ---------------------------------------------------------------------

Widget _fieldTag({
  required String fieldName,
  required String fieldType,
  required String description,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: _kPanelBgAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 14,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              fieldName,
              style: TextStyle(
                color: accent,
                fontSize: 14,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                fieldType,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Action chip — used in the action grid. Shows the SemanticsAction
// constant name, an icon, and a one-line semantic intent.
// ---------------------------------------------------------------------

Widget _actionChip({
  required String actionName,
  required IconData icon,
  required String intent,
  required Color accent,
}) {
  return Container(
    width: 200,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: _gradEnumChip(),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.22),
          blurRadius: 14,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: accent.withValues(alpha: 0.55),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: accent, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                actionName,
                style: TextStyle(
                  color: accent,
                  fontSize: 14,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          intent,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Event card — renders a single constructed `ui.SemanticsActionEvent`.
// Pulls type, nodeId, viewId, arguments off the event itself.
// ---------------------------------------------------------------------

Widget _eventCard({
  required ui.SemanticsActionEvent event,
  required String caption,
  required Color accent,
}) {
  final String argsText = event.arguments == null
      ? 'null'
      : event.arguments.toString();
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: _gradPanel(_kPanelBg, _kPanelBgAlt),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.22),
          blurRadius: 16,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // C8: long action names like `didGainAccessibilityFocus` and
        // `moveCursorForwardByCharacter` overflow this card's 360-px
        // SizedBox by ~7 px when shown next to nodeId/viewId labels in a
        // strict Row. Use a Wrap so the labels drop to a second line for
        // long names but stay inline for short ones.
        Wrap(
          spacing: 10,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: accent.withValues(alpha: 0.55),
                  width: 1,
                ),
              ),
              child: Text(
                event.type.name,
                style: TextStyle(
                  color: accent,
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              'nodeId=${event.nodeId}',
              style: const TextStyle(
                color: _kInkDim,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              'viewId=${event.viewId}',
              style: const TextStyle(
                color: _kInkDim,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'arguments: $argsText',
          style: const TextStyle(
            color: _kInk,
            fontSize: 12.5,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          caption,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Pipeline node — a labelled box used in the routing diagram.
// ---------------------------------------------------------------------

Widget _pipelineNode({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color accent,
  required LinearGradient gradient,
}) {
  return Container(
    width: 160,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.3),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 26),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFFE3ECFA),
            fontSize: 11.5,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Pipeline arrow — thin chevron connecting two pipeline nodes.
// ---------------------------------------------------------------------

Widget _pipelineArrow() {
  return Container(
    width: 24,
    alignment: Alignment.center,
    child: Icon(
      Icons.arrow_forward_rounded,
      color: _kAccentCyan,
      size: 22,
    ),
  );
}

// ---------------------------------------------------------------------
// Recipe card — used in the practical gallery section.
// ---------------------------------------------------------------------

Widget _recipeCard({
  required String widgetName,
  required String dispatchedAction,
  required String why,
  required IconData icon,
  required Color accent,
  required ui.SemanticsActionEvent example,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kPanelBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1),
      boxShadow: _shadowSoft(),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accent, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widgetName,
                    style: const TextStyle(
                      color: _kInk,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'listens for: $dispatchedAction',
                    style: TextStyle(
                      color: accent,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          why,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: _kPanelBgAlt,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kPanelBorder),
          ),
          child: Text(
            'example: ${example.type.name}@n${example.nodeId}/v${example.viewId}'
            ' args=${example.arguments ?? "null"}',
            style: const TextStyle(
              color: _kInkDim,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Footgun panel — danger-flavoured callout used in section 7.
// ---------------------------------------------------------------------

Widget _footgun({
  required String title,
  required String body,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF2A1822),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: _kDanger.withValues(alpha: 0.5),
        width: 1,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kDanger.withValues(alpha: 0.18),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kDanger.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _kDanger.withValues(alpha: 0.55),
              width: 1,
            ),
          ),
          child: Icon(icon, color: _kDanger, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _kDanger,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                body,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Comparison column — used in section 8 to contrast key events vs
// semantics action events.
// ---------------------------------------------------------------------

Widget _comparisonColumn({
  required String title,
  required String tagline,
  required List<String> bullets,
  required IconData icon,
  required Color accent,
  required LinearGradient gradient,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1),
      boxShadow: _shadowSoft(),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          tagline,
          style: const TextStyle(
            color: Color(0xFFE5EEFB),
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(bullets.length, (int i) {
            final String b = bullets[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.fiber_manual_record,
                    color: Colors.white,
                    size: 8,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        color: Color(0xFFE5EEFB),
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION BUILDERS
// =====================================================================

// ---------------------------------------------------------------------
// Section 1 — Anatomy diagram of SemanticsActionEvent.
// ---------------------------------------------------------------------

Widget _section1Anatomy() {
  // A single representative event shown front-and-center, with each of
  // its four fields broken out as a labelled tag.
  final ui.SemanticsActionEvent demoEvent = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.tap,
    viewId: 0,
    nodeId: 17,
    arguments: null,
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: 1,
        title: 'Anatomy of a SemanticsActionEvent',
        subtitle: 'Four fields, every field a teaching surface',
        gradient: _gradHeader1(),
        icon: Icons.account_tree_rounded,
      ),
      const SizedBox(height: 14),
      _prose(
        'A SemanticsActionEvent is the engine\'s wire-format request for the '
        'framework to perform an accessibility action. The struct is small on '
        'purpose: every field is needed to route the intent to exactly one '
        'SemanticsNode in exactly one FlutterView, with optional payload data '
        'that some actions require. Reading this file teaches you how the '
        'engine speaks accessibility to your widgets.',
      ),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: _gradPanel(_kPanelBg, _kPanelBgAlt),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kAccentCyan.withValues(alpha: 0.4)),
          boxShadow: _shadowGlowCyan(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _kAccentCyan.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _kAccentCyan.withValues(alpha: 0.55),
                    ),
                  ),
                  child: const Text(
                    'class SemanticsActionEvent',
                    style: TextStyle(
                      color: _kAccentCyan,
                      fontSize: 13,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'instance shown below',
                  style: TextStyle(color: _kInkDim, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _eventCard(
              event: demoEvent,
              caption:
                  'A bare tap event targeting node 17 in the primary view. '
                  'This is what TalkBack/VoiceOver double-tap typically '
                  'becomes once it crosses the engine boundary.',
              accent: _kAccentCyan,
            ),
            const SizedBox(height: 18),
            const Text(
              'Field breakdown',
              style: TextStyle(
                color: _kInk,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: <Widget>[
                SizedBox(
                  width: 320,
                  child: _fieldTag(
                    fieldName: 'type',
                    fieldType: 'SemanticsAction',
                    description:
                        'The intent the AT wants performed (tap, increase, '
                        'copy, dismiss, …). This is the single most important '
                        'field — it is the verb of the event.',
                    accent: _kAccentCyan,
                  ),
                ),
                SizedBox(
                  width: 320,
                  child: _fieldTag(
                    fieldName: 'nodeId',
                    fieldType: 'int',
                    description:
                        'The id assigned by SemanticsOwner during the most '
                        'recent semantics tree commit. Identifies which '
                        'SemanticsNode in the live tree should handle the '
                        'action.',
                    accent: _kAccentMint,
                  ),
                ),
                SizedBox(
                  width: 320,
                  child: _fieldTag(
                    fieldName: 'viewId',
                    fieldType: 'int',
                    description:
                        'Which FlutterView the node lives in. In single-view '
                        'apps this is always 0; in multi-view embeddings '
                        '(add-to-app, web, multi-window) it picks the right '
                        'tree.',
                    accent: _kAccentAmber,
                  ),
                ),
                SizedBox(
                  width: 320,
                  child: _fieldTag(
                    fieldName: 'arguments',
                    fieldType: 'Object?',
                    description:
                        'Optional payload — null for most actions, but a '
                        'Map/string/offset for actions that need data '
                        '(setText, scrollToOffset, customAction, '
                        'moveCursorForwardByCharacter, …).',
                    accent: _kAccentRose,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------
// Section 2 — Action type grid.
// ---------------------------------------------------------------------

Widget _section2ActionGrid() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: 2,
        title: 'The SemanticsAction vocabulary',
        subtitle: 'Twelve representative intents the engine can deliver',
        gradient: _gradHeader2(),
        icon: Icons.grid_view_rounded,
      ),
      const SizedBox(height: 14),
      _prose(
        'SemanticsAction is the enumerated vocabulary of intents an AT can '
        'request. Each constant maps to a specific user-facing operation: '
        'activation, scrolling, value adjustment, focus management, text '
        'editing, dismissal, and platform-defined custom actions. The engine '
        'normalises platform-specific gestures into these stable values, so '
        'your widget code can stay platform-agnostic.',
      ),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _kPanelBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kPanelBorder),
          boxShadow: _shadowSoft(),
        ),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            _actionChip(
              actionName: 'tap',
              icon: Icons.touch_app_rounded,
              intent: 'standard activation; AT double-tap',
              accent: _kAccentCyan,
            ),
            _actionChip(
              actionName: 'longPress',
              icon: Icons.timer_outlined,
              intent: 'context / secondary action',
              accent: _kAccentMint,
            ),
            _actionChip(
              actionName: 'scrollLeft',
              icon: Icons.arrow_back_rounded,
              intent: 'horizontal page-back swipe',
              accent: _kAccentAmber,
            ),
            _actionChip(
              actionName: 'scrollRight',
              icon: Icons.arrow_forward_rounded,
              intent: 'horizontal page-forward swipe',
              accent: _kAccentAmber,
            ),
            _actionChip(
              actionName: 'scrollUp',
              icon: Icons.arrow_upward_rounded,
              intent: 'two-finger swipe up; page up',
              accent: _kAccentRose,
            ),
            _actionChip(
              actionName: 'scrollDown',
              icon: Icons.arrow_downward_rounded,
              intent: 'two-finger swipe down; page down',
              accent: _kAccentRose,
            ),
            _actionChip(
              actionName: 'increase',
              icon: Icons.add_circle_outline_rounded,
              intent: 'slider/spinner up; volume +',
              accent: _kAccentLime,
            ),
            _actionChip(
              actionName: 'decrease',
              icon: Icons.remove_circle_outline_rounded,
              intent: 'slider/spinner down; volume -',
              accent: _kAccentLime,
            ),
            _actionChip(
              actionName: 'copy',
              icon: Icons.copy_rounded,
              intent: 'clipboard copy of selected text',
              accent: _kAccentViolet,
            ),
            _actionChip(
              actionName: 'cut',
              icon: Icons.content_cut_rounded,
              intent: 'cut selection to clipboard',
              accent: _kAccentViolet,
            ),
            _actionChip(
              actionName: 'paste',
              icon: Icons.content_paste_rounded,
              intent: 'paste clipboard contents at cursor',
              accent: _kAccentSky,
            ),
            _actionChip(
              actionName: 'dismiss',
              icon: Icons.close_rounded,
              intent: 'dismiss dialog/sheet/tooltip',
              accent: _kAccentPeach,
            ),
            _actionChip(
              actionName: 'didGainAccessibilityFocus',
              icon: Icons.center_focus_strong_rounded,
              intent: 'AT cursor entered this node',
              accent: _kAccentCyan,
            ),
            _actionChip(
              actionName: 'didLoseAccessibilityFocus',
              icon: Icons.center_focus_weak_rounded,
              intent: 'AT cursor moved away from node',
              accent: _kAccentCyan,
            ),
            _actionChip(
              actionName: 'customAction',
              icon: Icons.extension_rounded,
              intent: 'app-defined action by id',
              accent: _kAccentMint,
            ),
            _actionChip(
              actionName: 'showOnScreen',
              icon: Icons.visibility_rounded,
              intent: 'scroll node into the viewport',
              accent: _kAccentAmber,
            ),
            _actionChip(
              actionName: 'setText',
              icon: Icons.edit_note_rounded,
              intent: 'replace text field contents',
              accent: _kAccentRose,
            ),
            _actionChip(
              actionName: 'focus',
              icon: Icons.center_focus_weak_rounded,
              intent: 'request keyboard / programmatic focus',
              accent: _kAccentLime,
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------
// Section 3 — Constructed events table.
// ---------------------------------------------------------------------

Widget _eventsTableRow({
  required ui.SemanticsActionEvent event,
  required Color accent,
  required String note,
  bool isHeader = false,
}) {
  final TextStyle base = const TextStyle(
    color: _kInk,
    fontSize: 13,
    fontFamily: 'monospace',
  );
  final TextStyle headerStyle = const TextStyle(
    color: _kAccentCyan,
    fontSize: 13,
    fontFamily: 'monospace',
    fontWeight: FontWeight.w800,
  );
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: isHeader ? _kPanelBgAlt : _kPanelBg,
      border: Border(
        bottom: BorderSide(color: _kPanelBorder, width: 0.6),
      ),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 200,
          child: Text(
            event.type.name,
            style: isHeader ? headerStyle : base.copyWith(color: accent),
          ),
        ),
        SizedBox(
          width: 80,
          child: Text(
            '${event.nodeId}',
            style: isHeader ? headerStyle : base,
          ),
        ),
        SizedBox(
          width: 80,
          child: Text(
            '${event.viewId}',
            style: isHeader ? headerStyle : base,
          ),
        ),
        SizedBox(
          width: 220,
          child: Text(
            event.arguments == null ? 'null' : event.arguments.toString(),
            style: isHeader ? headerStyle : base,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            note,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _section3Table() {
  // 12 constructed events, varied types/nodes/views/args.
  final ui.SemanticsActionEvent e1 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.tap,
    viewId: 0,
    nodeId: 12,
  );
  final ui.SemanticsActionEvent e2 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.longPress,
    viewId: 0,
    nodeId: 19,
  );
  final ui.SemanticsActionEvent e3 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.increase,
    viewId: 0,
    nodeId: 33,
  );
  final ui.SemanticsActionEvent e4 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.decrease,
    viewId: 0,
    nodeId: 33,
  );
  final ui.SemanticsActionEvent e5 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.scrollDown,
    viewId: 0,
    nodeId: 7,
  );
  final ui.SemanticsActionEvent e6 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.scrollUp,
    viewId: 0,
    nodeId: 7,
  );
  final ui.SemanticsActionEvent e7 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.copy,
    viewId: 0,
    nodeId: 41,
  );
  final ui.SemanticsActionEvent e8 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.paste,
    viewId: 0,
    nodeId: 41,
  );
  final ui.SemanticsActionEvent e9 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.customAction,
    viewId: 0,
    nodeId: 58,
    arguments: 'archive',
  );
  final ui.SemanticsActionEvent e10 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.dismiss,
    viewId: 0,
    nodeId: 64,
  );
  final ui.SemanticsActionEvent e11 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.didGainAccessibilityFocus,
    viewId: 1,
    nodeId: 88,
  );
  final ui.SemanticsActionEvent e12 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.setText,
    viewId: 0,
    nodeId: 102,
    arguments: 'hello world',
  );

  // Header pseudo-row uses a synthetic event whose name we don't read.
  final ui.SemanticsActionEvent headerEvent = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.tap,
    viewId: 0,
    nodeId: 0,
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: 3,
        title: 'Twelve constructed events at a glance',
        subtitle: 'type / nodeId / viewId / arguments — read off real instances',
        gradient: _gradHeader3(),
        icon: Icons.table_chart_rounded,
      ),
      const SizedBox(height: 14),
      _prose(
        'These rows are not strings — each row reads its values directly off '
        'a constructed `ui.SemanticsActionEvent`. The shape is always the '
        'same four columns, but notice how `arguments` ranges from null '
        '(most actions) through small payloads (custom action ids, replacement '
        'text). The interpreter sees genuine engine-side instances, not '
        'mocks.',
      ),
      const SizedBox(height: 14),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kPanelBorder),
          boxShadow: _shadowSoft(),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            // synthetic header row — uses literal labels
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                gradient: _gradHeader3(),
              ),
              child: Row(
                children: const <Widget>[
                  SizedBox(
                    width: 200,
                    child: Text(
                      'type',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      'nodeId',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      'viewId',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: Text(
                      'arguments',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'note',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _eventsTableRow(
              event: e1,
              accent: _kAccentCyan,
              note: 'standard activation on a button',
            ),
            _eventsTableRow(
              event: e2,
              accent: _kAccentMint,
              note: 'context menu / secondary',
            ),
            _eventsTableRow(
              event: e3,
              accent: _kAccentLime,
              note: 'slider step up',
            ),
            _eventsTableRow(
              event: e4,
              accent: _kAccentLime,
              note: 'slider step down',
            ),
            _eventsTableRow(
              event: e5,
              accent: _kAccentRose,
              note: 'scrollable page advance',
            ),
            _eventsTableRow(
              event: e6,
              accent: _kAccentRose,
              note: 'scrollable page retreat',
            ),
            _eventsTableRow(
              event: e7,
              accent: _kAccentViolet,
              note: 'copy selection in text field',
            ),
            _eventsTableRow(
              event: e8,
              accent: _kAccentSky,
              note: 'paste at caret',
            ),
            _eventsTableRow(
              event: e9,
              accent: _kAccentMint,
              note: 'custom action: archive',
            ),
            _eventsTableRow(
              event: e10,
              accent: _kAccentPeach,
              note: 'dismiss a sheet/tooltip',
            ),
            _eventsTableRow(
              event: e11,
              accent: _kAccentCyan,
              note: 'AT cursor entered (note viewId=1)',
            ),
            _eventsTableRow(
              event: e12,
              accent: _kAccentRose,
              note: 'set text to a literal string',
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------
// Section 4 — Routing pipeline.
// ---------------------------------------------------------------------

Widget _section4Pipeline() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: 4,
        title: 'How an AT gesture becomes a widget callback',
        subtitle: 'Engine → SemanticsActionEvent → SemanticsBinding → handler',
        gradient: _gradHeader4(),
        icon: Icons.alt_route_rounded,
      ),
      const SizedBox(height: 14),
      _prose(
        'When a screen reader user double-taps, swipes, or invokes a custom '
        'action, the platform AT layer (TalkBack, VoiceOver, NVDA via UIA, '
        'AT-SPI/Orca) signals the Flutter engine. The engine inspects which '
        'view and node are currently focused by the AT, normalises the '
        'gesture into a `SemanticsAction`, packs it into a `SemanticsActionEvent`, '
        'and hands it to the framework. From there `SemanticsBinding` looks '
        'up the live `SemanticsOwner`, finds the addressed `SemanticsNode`, '
        'and invokes the action handler the widget previously registered.',
      ),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: BoxDecoration(
          color: _kPanelBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kPanelBorder),
          boxShadow: _shadowSoft(),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _pipelineNode(
                title: 'Platform AT',
                subtitle: 'TalkBack / VoiceOver / NVDA / Orca',
                icon: Icons.accessibility_new_rounded,
                accent: _kAccentCyan,
                gradient: _gradHeader1(),
              ),
              _pipelineArrow(),
              _pipelineNode(
                title: 'Engine',
                subtitle: 'normalises gesture into SemanticsAction',
                icon: Icons.memory_rounded,
                accent: _kAccentMint,
                gradient: _gradHeader2(),
              ),
              _pipelineArrow(),
              _pipelineNode(
                title: 'SemanticsActionEvent',
                subtitle: 'type / nodeId / viewId / arguments',
                icon: Icons.electrical_services_rounded,
                accent: _kAccentAmber,
                gradient: _gradHeader4(),
              ),
              _pipelineArrow(),
              _pipelineNode(
                title: 'SemanticsBinding',
                subtitle: 'performSemanticsAction(event)',
                icon: Icons.hub_rounded,
                accent: _kAccentRose,
                gradient: _gradHeader5(),
              ),
              _pipelineArrow(),
              _pipelineNode(
                title: 'SemanticsOwner',
                subtitle: 'lookup node, dispatch',
                icon: Icons.account_tree_rounded,
                accent: _kAccentViolet,
                gradient: _gradHeader3(),
              ),
              _pipelineArrow(),
              _pipelineNode(
                title: 'Widget handler',
                subtitle: 'onTap / onIncrease / onCopy / …',
                icon: Icons.widgets_rounded,
                accent: _kAccentLime,
                gradient: _gradHeader6(),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kPanelBgAlt,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kPanelBorder),
        ),
        child: const Text(
          'Mental model: SemanticsActionEvent is the *contract* between '
          'engine and framework. Everything left of it is platform-specific; '
          'everything right of it is platform-agnostic Flutter.',
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------
// Section 5 — Argument shapes.
// ---------------------------------------------------------------------

Widget _section5Arguments() {
  final ui.SemanticsActionEvent eNoArgs = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.increase,
    viewId: 0,
    nodeId: 50,
  );
  final ui.SemanticsActionEvent eCustom = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.customAction,
    viewId: 0,
    nodeId: 51,
    arguments: 'mark-as-spam',
  );
  final ui.SemanticsActionEvent eSetText = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.setText,
    viewId: 0,
    nodeId: 52,
    arguments: 'Replacement string',
  );
  final ui.SemanticsActionEvent eFocus = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.didGainAccessibilityFocus,
    viewId: 0,
    nodeId: 53,
  );
  final ui.SemanticsActionEvent eMoveCursor = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.moveCursorForwardByCharacter,
    viewId: 0,
    nodeId: 54,
    arguments: true, // extendSelection flag
  );
  final ui.SemanticsActionEvent eShowOnScreen = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.showOnScreen,
    viewId: 0,
    nodeId: 55,
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: 5,
        title: 'Argument shapes per action',
        subtitle: 'Why some actions carry payloads and most carry null',
        gradient: _gradHeader5(),
        icon: Icons.data_object_rounded,
      ),
      const SizedBox(height: 14),
      _prose(
        'Most semantic actions are pure verbs and arrive with `arguments == '
        'null`. A handful carry payloads: `customAction` carries the custom '
        'action id, `setText` carries the replacement string, '
        '`moveCursorForwardByCharacter` and friends carry an `extendSelection` '
        'bool, and `setSelection` carries a base/extent map. Flutter widgets '
        'must therefore type-check `arguments` against the action they '
        'expect; treating `arguments` as a free-form Object? is correct, but '
        'consuming it requires per-action knowledge.',
      ),
      const SizedBox(height: 14),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          SizedBox(
            width: 360,
            child: _eventCard(
              event: eNoArgs,
              caption:
                  'increase / decrease / scrollUp / scrollDown / dismiss — '
                  'all use null arguments. The action *is* the message.',
              accent: _kAccentLime,
            ),
          ),
          SizedBox(
            width: 360,
            child: _eventCard(
              event: eCustom,
              caption:
                  'customAction passes the registered custom action id (a '
                  'String here for clarity; the framework actually uses an '
                  'int CustomSemanticsAction id).',
              accent: _kAccentMint,
            ),
          ),
          SizedBox(
            width: 360,
            child: _eventCard(
              event: eSetText,
              caption:
                  'setText: arguments is the literal replacement String. '
                  'Used when the AT dictates whole-field content (form fill, '
                  'voice input).',
              accent: _kAccentRose,
            ),
          ),
          SizedBox(
            width: 360,
            child: _eventCard(
              event: eFocus,
              caption:
                  'didGainAccessibilityFocus — null payload. The framework '
                  'announces the event so widgets can react (scroll into '
                  'view, highlight, etc.).',
              accent: _kAccentCyan,
            ),
          ),
          SizedBox(
            width: 360,
            child: _eventCard(
              event: eMoveCursor,
              caption:
                  'moveCursorForwardByCharacter: arguments is a bool '
                  'extendSelection. true = grow selection, false = move '
                  'caret without selecting.',
              accent: _kAccentAmber,
            ),
          ),
          SizedBox(
            width: 360,
            child: _eventCard(
              event: eShowOnScreen,
              caption:
                  'showOnScreen: null payload. The widget should scroll its '
                  'ancestors so this node becomes visible (often used right '
                  'after a focus change).',
              accent: _kAccentSky,
            ),
          ),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------
// Section 6 — Practical recipe gallery.
// ---------------------------------------------------------------------

Widget _section6Recipes() {
  final ui.SemanticsActionEvent rec1 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.increase,
    viewId: 0,
    nodeId: 201,
  );
  final ui.SemanticsActionEvent rec2 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.longPress,
    viewId: 0,
    nodeId: 202,
  );
  final ui.SemanticsActionEvent rec3 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.copy,
    viewId: 0,
    nodeId: 203,
  );
  final ui.SemanticsActionEvent rec4 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.customAction,
    viewId: 0,
    nodeId: 204,
    arguments: 'mark-as-read',
  );
  final ui.SemanticsActionEvent rec5 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.dismiss,
    viewId: 0,
    nodeId: 205,
  );
  final ui.SemanticsActionEvent rec6 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.scrollDown,
    viewId: 0,
    nodeId: 206,
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: 6,
        title: 'Practical recipes — widgets that listen',
        subtitle: 'Six real consumers and the action they care about',
        gradient: _gradHeader6(),
        icon: Icons.restaurant_menu_rounded,
      ),
      const SizedBox(height: 14),
      _prose(
        'Most Flutter widgets never touch SemanticsActionEvent directly — '
        'they implement higher-level callbacks (onTap, onIncrease, onCopy, '
        'onDismiss). Under the hood those callbacks are wired through the '
        'Semantics widget by registering action handlers keyed on the '
        'matching SemanticsAction. The recipes below show what action arrives '
        'at common widgets and *why* the widget cares.',
      ),
      const SizedBox(height: 14),
      Wrap(
        spacing: 14,
        runSpacing: 14,
        children: <Widget>[
          SizedBox(
            width: 360,
            child: _recipeCard(
              widgetName: 'Custom value slider',
              dispatchedAction: 'increase / decrease',
              why:
                  'Sliders cannot rely on platform swipe — the AT user holds '
                  'a single accessibility cursor and adjusts via the '
                  'increase/decrease verbs. The widget steps the value and '
                  'announces a new SemanticsValue.',
              icon: Icons.tune_rounded,
              accent: _kAccentLime,
              example: rec1,
            ),
          ),
          SizedBox(
            width: 360,
            child: _recipeCard(
              widgetName: 'Long-press menu trigger',
              dispatchedAction: 'longPress',
              why:
                  'AT exposes long-press as a separate verb so blind users '
                  'can reach context menus without holding gestures. The '
                  'widget shows the same overlay it would on a held finger.',
              icon: Icons.touch_app_outlined,
              accent: _kAccentMint,
              example: rec2,
            ),
          ),
          SizedBox(
            width: 360,
            child: _recipeCard(
              widgetName: 'Selectable text field',
              dispatchedAction: 'copy / cut / paste',
              why:
                  'When TalkBack/VoiceOver invokes the clipboard rotor, the '
                  'engine sends a copy/cut/paste SemanticsActionEvent rather '
                  'than synthesising key events — keeping selection state '
                  'consistent in the framework.',
              icon: Icons.content_copy_rounded,
              accent: _kAccentViolet,
              example: rec3,
            ),
          ),
          SizedBox(
            width: 360,
            child: _recipeCard(
              widgetName: 'Mailbox row with custom actions',
              dispatchedAction: 'customAction (id="mark-as-read")',
              why:
                  'For multi-action rows the widget registers '
                  'CustomSemanticsAction objects; the AT presents them in a '
                  'rotor / local context menu and emits customAction with '
                  'the matching id when chosen.',
              icon: Icons.mark_email_read_rounded,
              accent: _kAccentSky,
              example: rec4,
            ),
          ),
          SizedBox(
            width: 360,
            child: _recipeCard(
              widgetName: 'Bottom sheet / SnackBar',
              dispatchedAction: 'dismiss',
              why:
                  'Dismiss is its own verb so AT users do not have to hunt '
                  'for a close button. Widgets that opt in (Dismissible, '
                  'SnackBar with action, ModalBottomSheet) close themselves '
                  'and restore focus.',
              icon: Icons.close_fullscreen_rounded,
              accent: _kAccentPeach,
              example: rec5,
            ),
          ),
          SizedBox(
            width: 360,
            child: _recipeCard(
              widgetName: 'Vertical list / scroll view',
              dispatchedAction: 'scrollUp / scrollDown',
              why:
                  'AT two-finger swipes become scrollUp/scrollDown verbs. '
                  'Scrollables advance by one viewport rather than '
                  'pixel-for-pixel — which is what blind users actually '
                  'expect when they request a page advance.',
              icon: Icons.swap_vert_rounded,
              accent: _kAccentRose,
              example: rec6,
            ),
          ),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------
// Section 7 — Footguns.
// ---------------------------------------------------------------------

Widget _section7Footguns() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: 7,
        title: 'Footguns when working with action events',
        subtitle: 'Five common mistakes and how to avoid them',
        gradient: _gradHeader7(),
        icon: Icons.report_problem_rounded,
      ),
      const SizedBox(height: 14),
      _prose(
        'SemanticsActionEvent looks deceptively simple. The mistakes that '
        'cause production accessibility bugs are mostly about lifecycle and '
        'intent shape, not about the struct itself. The footguns below come '
        'up repeatedly when teams start instrumenting bespoke widgets and '
        'try to reason about events as if they were pointer events.',
      ),
      const SizedBox(height: 14),
      Column(
        children: <Widget>[
          _footgun(
            title: 'Treating nodeId as stable across rebuilds',
            body:
                'SemanticsOwner reassigns ids on every commit. A nodeId is '
                'only valid within the action handler call it arrived on; '
                'do not store it, do not log it as an identity, do not '
                'pickle it — refer to your own widget keys instead.',
            icon: Icons.history_toggle_off_rounded,
          ),
          const SizedBox(height: 10),
          _footgun(
            title: 'Forgetting increase / decrease for sliders',
            body:
                'A slider that only handles tap is unusable with TalkBack. '
                'AT users cannot swipe within the thumb; they invoke '
                'increase/decrease by stepping with the AT cursor. Always '
                'register both — and a sensible step size.',
            icon: Icons.linear_scale_rounded,
          ),
          const SizedBox(height: 10),
          _footgun(
            title: 'Dispatching tap when a custom action fits',
            body:
                'If your row has Archive / Snooze / Delete, do not collapse '
                'them into a single tap with a follow-up sheet. Register '
                'each as a CustomSemanticsAction so the AT exposes them in '
                'the rotor with explicit, announceable names.',
            icon: Icons.merge_type_rounded,
          ),
          const SizedBox(height: 10),
          _footgun(
            title: 'Ignoring viewId in multi-view embeddings',
            body:
                'Add-to-app, Flutter web, and multi-window apps may have '
                'several FlutterViews. The same nodeId can exist in '
                'different views; always route via SemanticsBinding which '
                'consults viewId — never look up nodes in a global map.',
            icon: Icons.window_rounded,
          ),
          const SizedBox(height: 10),
          _footgun(
            title: 'Assuming arguments shape per action',
            body:
                'arguments is Object?. Different actions carry different '
                'payloads (String for setText, Map for setSelection, bool '
                'for moveCursorForwardByCharacter). Type-check defensively '
                'and fall back to a no-op if the payload is unexpected.',
            icon: Icons.rule_rounded,
          ),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------
// Section 8 — Comparison: KeyEvent vs SemanticsActionEvent.
// ---------------------------------------------------------------------

Widget _section8Comparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: 8,
        title: 'Side-by-side: physical keys vs semantic intents',
        subtitle: 'Two event flavours, two design philosophies',
        gradient: _gradHeader8(),
        icon: Icons.compare_arrows_rounded,
      ),
      const SizedBox(height: 14),
      _prose(
        'It is tempting to think of a SemanticsActionEvent as just another '
        'kind of input event. It is not. Key events describe physical '
        'reality: a key was pressed, with a code, on a device. Semantic '
        'action events describe intent: someone wants this slider to go '
        'up, this dialog to dismiss, this text to be copied. Confusing the '
        'two leads to widgets that work for sighted users but are unusable '
        'with assistive tech.',
      ),
      const SizedBox(height: 14),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _comparisonColumn(
              title: 'KeyEvent (ui.KeyData / KeyEvent)',
              tagline: 'physical input — a hardware verb',
              bullets: <String>[
                'shape: physicalKey + logicalKey + character + repeat flag',
                'origin: keyboard / IME / synthesised by tests',
                'payload: actual character codes, modifiers, location',
                'ordering: down / up pairs, repeat sequences matter',
                'consumer: focused widget via FocusNode + Shortcuts',
                'failure mode: handler silently ignores → no feedback',
              ],
              icon: Icons.keyboard_alt_rounded,
              accent: _kAccentSky,
              gradient: _gradHeader8(),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _comparisonColumn(
              title: 'SemanticsActionEvent',
              tagline: 'semantic intent — a meaningful verb',
              bullets: <String>[
                'shape: type + nodeId + viewId + arguments',
                'origin: AT (TalkBack / VoiceOver / NVDA / Orca / JAWS)',
                'payload: action-specific (null, String, Map, bool, Offset)',
                'ordering: each event is self-contained, no pairs',
                'consumer: SemanticsNode handler registered by Semantics',
                'failure mode: AT user has no way to invoke the action',
              ],
              icon: Icons.accessibility_new_rounded,
              accent: _kAccentMint,
              gradient: _gradHeader2(),
            ),
          ),
        ],
      ),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kPanelBgAlt,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kPanelBorder),
        ),
        child: const Text(
          'Rule of thumb: if the user says "press up arrow", that is a key '
          'event. If the user says "increase the volume", that is a semantic '
          'action — even if the same person did them with the same finger.',
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------
// Section 9 — API summary table.
// ---------------------------------------------------------------------

Widget _apiRow({
  required String left,
  required String middle,
  required String right,
  bool isHeader = false,
}) {
  final TextStyle base = TextStyle(
    color: isHeader ? Colors.white : _kInk,
    fontSize: 13,
    fontFamily: 'monospace',
    fontWeight: isHeader ? FontWeight.w800 : FontWeight.w400,
  );
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: isHeader ? _kPanelBgAlt : _kPanelBg,
      border: Border(
        bottom: BorderSide(color: _kPanelBorder, width: 0.6),
      ),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(width: 200, child: Text(left, style: base)),
        SizedBox(width: 200, child: Text(middle, style: base)),
        Expanded(
          child: Text(
            right,
            style: TextStyle(
              color: isHeader ? Colors.white : _kInkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _section9Api() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: 9,
        title: 'API summary',
        subtitle: 'SemanticsActionEvent and its closest neighbours',
        gradient: _gradHeader9(),
        icon: Icons.menu_book_rounded,
      ),
      const SizedBox(height: 14),
      _prose(
        'A compact reference for everything related to the struct: the '
        'fields themselves, the closely-related types in dart:ui and '
        'package:flutter, and the canonical entry-points where each one is '
        'produced or consumed. Keep this open the next time you wire up '
        'accessibility for a custom widget.',
      ),
      const SizedBox(height: 14),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kPanelBorder),
          boxShadow: _shadowSoft(),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(gradient: _gradHeader9()),
              child: const Row(
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: Text(
                      'symbol',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'kind',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'role',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _apiRow(
              left: 'SemanticsActionEvent',
              middle: 'class (data)',
              right:
                  'engine→framework value carrying type/nodeId/viewId/args',
            ),
            _apiRow(
              left: '.type',
              middle: 'SemanticsAction',
              right: 'the intent (tap, increase, copy, customAction, …)',
            ),
            _apiRow(
              left: '.nodeId',
              middle: 'int',
              right: 'addresses one SemanticsNode in the live tree',
            ),
            _apiRow(
              left: '.viewId',
              middle: 'int',
              right: 'addresses one FlutterView (multi-view safe)',
            ),
            _apiRow(
              left: '.arguments',
              middle: 'Object?',
              right: 'optional payload; shape depends on type',
            ),
            _apiRow(
              left: '.copyWith(...)',
              middle: 'method',
              right: 'replace fields; useful for tests and middleware',
            ),
            _apiRow(
              left: 'SemanticsAction',
              middle: 'enum-like class',
              right: 'closed set of intents with stable indices',
            ),
            _apiRow(
              left: 'SemanticsBinding',
              middle: 'binding mixin',
              right: 'receives event from engine, dispatches via owner',
            ),
            _apiRow(
              left: 'SemanticsOwner',
              middle: 'class',
              right: 'maintains live SemanticsNode tree, performs action',
            ),
            _apiRow(
              left: 'SemanticsNode',
              middle: 'class',
              right: 'one node in the semantics tree, holds action handlers',
            ),
            _apiRow(
              left: 'CustomSemanticsAction',
              middle: 'class',
              right: 'user-defined action surfaced via type=customAction',
            ),
            _apiRow(
              left: 'PlatformDispatcher.onSemanticsActionEvent',
              middle: 'callback',
              right: 'lowest-level hook, framework wires this internally',
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------
// Footer — shows aggregate stats about the demo so the page reads as a
// proper presentation.
// ---------------------------------------------------------------------

Widget _footer() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: _gradPanel(_kPanelBgAlt, _kPanelBg),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPanelBorder),
      boxShadow: _shadowSoft(),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kAccentMint.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.fact_check_rounded,
                color: _kAccentMint,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Demo summary',
              style: TextStyle(
                color: _kInk,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'This page constructs more than a dozen real `ui.SemanticsActionEvent` '
          'instances and displays their fields directly. It exercises the '
          'breadth of the SemanticsAction vocabulary, contrasts the type '
          'with physical key events, walks the engine→widget routing '
          'pipeline, and calls out the lifecycle and shape pitfalls that '
          'tend to appear when teams begin instrumenting bespoke widgets '
          'for accessibility.',
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 14,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _statChip(
              label: '9 sections',
              icon: Icons.layers_rounded,
              accent: _kAccentCyan,
            ),
            _statChip(
              label: '20+ action constants exercised',
              icon: Icons.bolt_rounded,
              accent: _kAccentLime,
            ),
            _statChip(
              label: '12+ constructed events',
              icon: Icons.electrical_services_rounded,
              accent: _kAccentMint,
            ),
            _statChip(
              label: '3 full diagrams',
              icon: Icons.schema_rounded,
              accent: _kAccentRose,
            ),
            _statChip(
              label: 'pure stateless build()',
              icon: Icons.crop_square_rounded,
              accent: _kAccentAmber,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _statChip({
  required String label,
  required IconData icon,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: accent, size: 16),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Top-level build() — what the bridge actually invokes.
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFF0E1B2D),
      appBar: AppBar(
        title: const Text('dart:ui SemanticsActionEvent'),
        backgroundColor: const Color(0xFF15263F),
        foregroundColor: const Color(0xFFE6ECF7),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Hero card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: _gradHeader1(),
                borderRadius: BorderRadius.circular(20),
                boxShadow: _shadowDeep(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0x55FFFFFF),
                          ),
                        ),
                        child: const Text(
                          'dart:ui',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'engine struct',
                        style: TextStyle(
                          color: Color(0xFFE6ECF7),
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'SemanticsActionEvent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'How the Flutter engine asks the framework to perform '
                    'an accessibility action on a specific semantics node.',
                    style: TextStyle(
                      color: Color(0xFFE3ECFA),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            _section1Anatomy(),
            const SizedBox(height: 32),
            _section2ActionGrid(),
            const SizedBox(height: 32),
            _section3Table(),
            const SizedBox(height: 32),
            _section4Pipeline(),
            const SizedBox(height: 32),
            _section5Arguments(),
            const SizedBox(height: 32),
            _section6Recipes(),
            const SizedBox(height: 32),
            _section7Footguns(),
            const SizedBox(height: 32),
            _section8Comparison(),
            const SizedBox(height: 32),
            _section9Api(),
            const SizedBox(height: 32),
            _footer(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
