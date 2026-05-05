// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
//                       KEY HELPER --- STEEL CYPRESS DEMO
// ============================================================================
//                                                                            .
//   Theme ............ "Steel Cypress" --- a brushed-steel surface           .
//                       resting against a sun-warmed cypress grove.          .
//   Subject .......... package:flutter/services.dart --- KeyHelper           .
//                       (internal Linux toolkit helper).  Because the        .
//                       symbol is library-private, we take the legitimate    .
//                       fallback the prompt allows: a deep tour of the       .
//                       _public_ surface KeyHelper exists to power ---       .
//                       LogicalKeyboardKey, PhysicalKeyboardKey,             .
//                       KeyboardKey and related mapping APIs.                .
//                                                                            .
//   Why the fallback . KeyHelper, GtkKeyHelper and GLFWKeyHelper are not     .
//                       exported.  They sit behind raw_keyboard_linux.dart   .
//                       and translate (keyCode, scanCode, modifiers, ...)    .
//                       triplets into the cross-platform keyboard tokens     .
//                       you actually use --- LogicalKeyboardKey.keyA,        .
//                       LogicalKeyboardKey.escape, PhysicalKeyboardKey.      .
//                       arrowUp, etc.                                        .
//                                                                            .
//   How to read it ... 1. Title banner with palette swatches.                .
//                       2. Resolution-pipeline anatomy.                      .
//                       3. Property anatomy.                                 .
//                       4. Logical key gallery (24+ rows).                   .
//                       5. Physical key gallery (12+ rows).                  .
//                       6. Synonym / collapse map.                           .
//                       7. 5x5 modifier matrix.                              .
//                       8. KeyEventResult / SingleActivator alignment.       .
//                       9. DO / AVOID rules.                                 .
//                      10. Five canonical recipes.                           .
//                      11. Glossary of 12+ terms.                            .
//                      12. Recap footer with palette echo.                   .
//                                                                            .
//   D4rt notes ....... build() runs once, returns a snapshot tree.  No       .
//                       StatefulWidget, no setState, no controllers, no      .
//                       Tween.animate.value.  No for-in loops over a         .
//                       BridgedInstance --- everything is hand-unrolled.     .
//                       Color.withValues(alpha: ...) replaces withOpacity.   .
//                       Real key references (LogicalKeyboardKey.keyA.       .
//                       keyLabel, PhysicalKeyboardKey.keyA.usbHidUsage,     .
//                       LogicalKeyboardKey.escape.debugName, ...) are       .
//                       embedded in Text widgets so the rendered tree       .
//                       shows live data, not hard-coded strings.            .
//                                                                            .
//   Style ............ Gentle, instructional, slightly poetic.  Each        .
//                       section is a card; each card has a heading, a       .
//                       prose lead, and a body.  The eye should be able     .
//                       to skim the headings and still learn the topic.     .
//                                                                            .
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Steel Cypress palette --- 12 hues, drawn from brushed steel and cypress.
// ---------------------------------------------------------------------------

const Color _bgDeep = Color(0xFF11161B); // graphite night
const Color _bgPanel = Color(0xFF1B232A); // tarnished gunmetal
const Color _bgCard = Color(0xFF243038); // cool zinc
const Color _bgInset = Color(0xFF2D3A44); // brushed pewter
const Color _accSteel = Color(0xFFB7C2CC); // polished steel
const Color _accCypress = Color(0xFF6B8E5A); // cypress needle
const Color _accMoss = Color(0xFF8FAE73); // sunlit moss
const Color _accAmber = Color(0xFFD9A24A); // brass amber
const Color _accCopper = Color(0xFFB87333); // copper rivet
const Color _accIvory = Color(0xFFE8E4D2); // weathered ivory
const Color _accCrimson = Color(0xFFB54B4B); // warning crimson
const Color _accSky = Color(0xFF6FA8C7); // overcast sky

// ---------------------------------------------------------------------------
// Tiny helpers.  Each returns a widget; no logic relies on identity, so the
// snapshot tree is fully deterministic.
// ---------------------------------------------------------------------------

Widget _swatch(Color c, String label) {
  return Container(
    width: 96,
    margin: const EdgeInsets.all(4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _accSteel.withValues(alpha: 0.3)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: _bgDeep,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '#${c.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
          style: const TextStyle(
            fontSize: 10,
            color: _bgDeep,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _sectionTitle(String index, String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _accCypress,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            index,
            style: const TextStyle(
              color: _accIvory,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _accIvory,
              fontWeight: FontWeight.w800,
              fontSize: 19,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child, Color? tint}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _bgCard,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: (tint ?? _accSteel).withValues(alpha: 0.35),
        width: 1.2,
      ),
    ),
    child: child,
  );
}

Widget _prose(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: _accIvory,
      fontSize: 13.5,
      height: 1.45,
    ),
  );
}

Widget _kvRow(String k, String v, {Color? accent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            k,
            style: TextStyle(
              color: accent ?? _accSteel,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: const TextStyle(
              color: _accIvory,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.all(3),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.6)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: 11.5,
      ),
    ),
  );
}

Widget _logicalKeyTile({
  required String name,
  required String keyId,
  required String debugName,
  required String keyLabel,
  Color? tint,
}) {
  final c = tint ?? _accSky;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bgInset,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.55)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: c),
          ),
          child: Text(
            keyLabel.isEmpty ? '\u00B7' : keyLabel,
            style: TextStyle(
              color: c,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: _accIvory,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              _kvRow('keyId', keyId),
              _kvRow('debugName', debugName),
              _kvRow('keyLabel', '"$keyLabel"'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _physicalKeyTile({
  required String name,
  required String usbHid,
  required String debugName,
  Color? tint,
}) {
  final c = tint ?? _accCopper;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bgInset,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.55)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: c),
          ),
          child: const Icon(
            Icons.keyboard,
            color: _accIvory,
            size: 28,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: _accIvory,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              _kvRow('usbHidUsage', usbHid),
              _kvRow('debugName', debugName),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _doRule(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _accCypress.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _accCypress.withValues(alpha: 0.6)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_outline, color: _accMoss, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _accIvory, fontSize: 12.5),
          ),
        ),
      ],
    ),
  );
}

Widget _avoidRule(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _accCrimson.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _accCrimson.withValues(alpha: 0.6)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.error_outline, color: _accCrimson, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _accIvory, fontSize: 12.5),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String title, String code) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _bgDeep,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _accAmber.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _accAmber,
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          code,
          style: const TextStyle(
            color: _accIvory,
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _glossaryEntry(String term, String def) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            term,
            style: const TextStyle(
              color: _accAmber,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            def,
            style: const TextStyle(
              color: _accIvory,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _matrixCell(String text, {Color? color, bool header = false}) {
  return Container(
    width: 78,
    height: 44,
    alignment: Alignment.center,
    margin: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: header
          ? _accCypress.withValues(alpha: 0.6)
          : (color ?? _bgInset).withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: _accSteel.withValues(alpha: 0.4)),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: header ? _accIvory : _accIvory,
        fontWeight: header ? FontWeight.w800 : FontWeight.w500,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// build() --- the single entrypoint d4rt invokes.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // -------------------------------------------------------------------------
  // Narrative print stream.  These run before the widget tree is built so
  // the d4rt console reads like a guided tour.
  // -------------------------------------------------------------------------
  print('============================================================');
  print('  STEEL CYPRESS --- KeyHelper deep demo');
  print('============================================================');
  print('Subject ........ KeyHelper (internal, Linux toolkit bridge)');
  print('Fallback ....... LogicalKeyboardKey + PhysicalKeyboardKey tour');
  print('Theme .......... Steel Cypress (12 hue palette)');
  print('Sections ....... 12 (banner, anatomy, gallery, recipes, ...)');
  print('Live readouts .. 30+ real key accessor reads embedded in tree');
  print('------------------------------------------------------------');
  print('Pipeline:  raw event --> KeyHelper --> LogicalKeyboardKey');
  print('           raw event --> scanCode  --> PhysicalKeyboardKey');
  print('Synonyms:  shiftLeft + shiftRight --> shift');
  print('           controlLeft + controlRight --> control');
  print('           altLeft + altRight --> alt');
  print('           metaLeft + metaRight --> meta');
  print('Property:  identifier  -- stable id for the key on this app run');
  print('Property:  keyId       -- 64-bit Flutter logical key code');
  print('Property:  keyLabel    -- printable label, may be empty');
  print('Property:  debugName   -- developer-facing pretty name');
  print('Property:  usbHidUsage -- 32-bit USB HID code (physical)');
  print('============================================================');

  // -------------------------------------------------------------------------
  // Live readouts.  These are the >=30 real accessor reads.  Pulling them
  // up here keeps the Text() callsites tidy and guarantees the d4rt tree
  // captures the actual values, not hard-coded literals.
  // -------------------------------------------------------------------------

  final String labelKeyA = LogicalKeyboardKey.keyA.keyLabel;
  final String labelKeyB = LogicalKeyboardKey.keyB.keyLabel;
  final String labelKeyC = LogicalKeyboardKey.keyC.keyLabel;
  final String labelKeyZ = LogicalKeyboardKey.keyZ.keyLabel;
  final String labelDigit0 = LogicalKeyboardKey.digit0.keyLabel;
  final String labelDigit1 = LogicalKeyboardKey.digit1.keyLabel;
  final String labelEnter = LogicalKeyboardKey.enter.keyLabel;
  final String labelEscape = LogicalKeyboardKey.escape.keyLabel;
  final String labelSpace = LogicalKeyboardKey.space.keyLabel;
  final String labelTab = LogicalKeyboardKey.tab.keyLabel;
  final String labelBackspace = LogicalKeyboardKey.backspace.keyLabel;
  final String labelArrowUp = LogicalKeyboardKey.arrowUp.keyLabel;
  final String labelArrowDown = LogicalKeyboardKey.arrowDown.keyLabel;
  final String labelArrowLeft = LogicalKeyboardKey.arrowLeft.keyLabel;
  final String labelArrowRight = LogicalKeyboardKey.arrowRight.keyLabel;
  final String labelF1 = LogicalKeyboardKey.f1.keyLabel;
  final String labelF2 = LogicalKeyboardKey.f2.keyLabel;
  final String labelF3 = LogicalKeyboardKey.f3.keyLabel;
  final String labelF4 = LogicalKeyboardKey.f4.keyLabel;
  final String labelNumLock = LogicalKeyboardKey.numLock.keyLabel;
  final String labelShiftLeft = LogicalKeyboardKey.shiftLeft.keyLabel;
  final String labelShiftRight = LogicalKeyboardKey.shiftRight.keyLabel;
  final String labelControlLeft = LogicalKeyboardKey.controlLeft.keyLabel;
  final String labelControlRight = LogicalKeyboardKey.controlRight.keyLabel;
  final String labelAltLeft = LogicalKeyboardKey.altLeft.keyLabel;
  final String labelAltRight = LogicalKeyboardKey.altRight.keyLabel;
  final String labelMetaLeft = LogicalKeyboardKey.metaLeft.keyLabel;
  final String labelMetaRight = LogicalKeyboardKey.metaRight.keyLabel;
  final String labelHome = LogicalKeyboardKey.home.keyLabel;
  final String labelEnd = LogicalKeyboardKey.end.keyLabel;

  final String dnKeyA = LogicalKeyboardKey.keyA.debugName ?? '?';
  final String dnEnter = LogicalKeyboardKey.enter.debugName ?? '?';
  final String dnEscape = LogicalKeyboardKey.escape.debugName ?? '?';
  final String dnArrowUp = LogicalKeyboardKey.arrowUp.debugName ?? '?';
  final String dnSpace = LogicalKeyboardKey.space.debugName ?? '?';
  final String dnTab = LogicalKeyboardKey.tab.debugName ?? '?';
  final String dnBackspace = LogicalKeyboardKey.backspace.debugName ?? '?';
  final String dnNumLock = LogicalKeyboardKey.numLock.debugName ?? '?';
  final String dnShiftLeft = LogicalKeyboardKey.shiftLeft.debugName ?? '?';
  final String dnControlLeft = LogicalKeyboardKey.controlLeft.debugName ?? '?';
  final String dnAltLeft = LogicalKeyboardKey.altLeft.debugName ?? '?';
  final String dnMetaLeft = LogicalKeyboardKey.metaLeft.debugName ?? '?';
  final String dnF1 = LogicalKeyboardKey.f1.debugName ?? '?';
  final String dnF2 = LogicalKeyboardKey.f2.debugName ?? '?';

  final String idKeyA = LogicalKeyboardKey.keyA.keyId.toString();
  final String idKeyZ = LogicalKeyboardKey.keyZ.keyId.toString();
  final String idEnter = LogicalKeyboardKey.enter.keyId.toString();
  final String idEscape = LogicalKeyboardKey.escape.keyId.toString();
  final String idArrowUp = LogicalKeyboardKey.arrowUp.keyId.toString();
  final String idArrowDown = LogicalKeyboardKey.arrowDown.keyId.toString();
  final String idArrowLeft = LogicalKeyboardKey.arrowLeft.keyId.toString();
  final String idArrowRight = LogicalKeyboardKey.arrowRight.keyId.toString();
  final String idSpace = LogicalKeyboardKey.space.keyId.toString();
  final String idTab = LogicalKeyboardKey.tab.keyId.toString();
  final String idBackspace = LogicalKeyboardKey.backspace.keyId.toString();
  final String idNumLock = LogicalKeyboardKey.numLock.keyId.toString();
  final String idShiftLeft = LogicalKeyboardKey.shiftLeft.keyId.toString();
  final String idShiftRight = LogicalKeyboardKey.shiftRight.keyId.toString();
  final String idControlLeft = LogicalKeyboardKey.controlLeft.keyId.toString();
  final String idControlRight =
      LogicalKeyboardKey.controlRight.keyId.toString();
  final String idAltLeft = LogicalKeyboardKey.altLeft.keyId.toString();
  final String idAltRight = LogicalKeyboardKey.altRight.keyId.toString();
  final String idMetaLeft = LogicalKeyboardKey.metaLeft.keyId.toString();
  final String idMetaRight = LogicalKeyboardKey.metaRight.keyId.toString();
  final String idF1 = LogicalKeyboardKey.f1.keyId.toString();
  final String idF2 = LogicalKeyboardKey.f2.keyId.toString();
  final String idF3 = LogicalKeyboardKey.f3.keyId.toString();
  final String idF4 = LogicalKeyboardKey.f4.keyId.toString();

  final String hidKeyA = PhysicalKeyboardKey.keyA.usbHidUsage.toString();
  final String hidKeyB = PhysicalKeyboardKey.keyB.usbHidUsage.toString();
  final String hidKeyC = PhysicalKeyboardKey.keyC.usbHidUsage.toString();
  final String hidEnter = PhysicalKeyboardKey.enter.usbHidUsage.toString();
  final String hidEscape = PhysicalKeyboardKey.escape.usbHidUsage.toString();
  final String hidSpace = PhysicalKeyboardKey.space.usbHidUsage.toString();
  final String hidTab = PhysicalKeyboardKey.tab.usbHidUsage.toString();
  final String hidArrowUp = PhysicalKeyboardKey.arrowUp.usbHidUsage.toString();
  final String hidArrowDown =
      PhysicalKeyboardKey.arrowDown.usbHidUsage.toString();
  final String hidShiftLeft =
      PhysicalKeyboardKey.shiftLeft.usbHidUsage.toString();
  final String hidControlLeft =
      PhysicalKeyboardKey.controlLeft.usbHidUsage.toString();
  final String hidAltLeft = PhysicalKeyboardKey.altLeft.usbHidUsage.toString();
  final String hidMetaLeft =
      PhysicalKeyboardKey.metaLeft.usbHidUsage.toString();

  final String pdnKeyA = PhysicalKeyboardKey.keyA.debugName ?? '?';
  final String pdnEnter = PhysicalKeyboardKey.enter.debugName ?? '?';
  final String pdnEscape = PhysicalKeyboardKey.escape.debugName ?? '?';
  final String pdnArrowUp = PhysicalKeyboardKey.arrowUp.debugName ?? '?';
  final String pdnShiftLeft = PhysicalKeyboardKey.shiftLeft.debugName ?? '?';
  final String pdnSpace = PhysicalKeyboardKey.space.debugName ?? '?';
  final String pdnTab = PhysicalKeyboardKey.tab.debugName ?? '?';

  print('Live readouts captured.  Sample:');
  print('  LogicalKeyboardKey.keyA.keyLabel        = "$labelKeyA"');
  print('  LogicalKeyboardKey.keyA.keyId           = $idKeyA');
  print('  LogicalKeyboardKey.keyA.debugName       = "$dnKeyA"');
  print('  LogicalKeyboardKey.escape.keyLabel      = "$labelEscape"');
  print('  LogicalKeyboardKey.enter.keyId          = $idEnter');
  print('  LogicalKeyboardKey.arrowUp.debugName    = "$dnArrowUp"');
  print('  LogicalKeyboardKey.shiftLeft.keyId      = $idShiftLeft');
  print('  PhysicalKeyboardKey.keyA.usbHidUsage    = $hidKeyA');
  print('  PhysicalKeyboardKey.enter.usbHidUsage   = $hidEnter');
  print('  PhysicalKeyboardKey.shiftLeft.debugName = "$pdnShiftLeft"');
  print('Tree assembly starting...');

  // -------------------------------------------------------------------------
  // Tree assembly.
  // -------------------------------------------------------------------------

  return Scaffold(
    backgroundColor: _bgDeep,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -----------------------------------------------------------------
          // 1. Title banner with palette swatches.
          // -----------------------------------------------------------------
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_bgPanel, _bgCard, _bgInset],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _accCypress.withValues(alpha: 0.6),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'STEEL CYPRESS',
                  style: TextStyle(
                    color: _accAmber,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'KeyHelper --- Keyboard key bridging in depth',
                  style: TextStyle(
                    color: _accIvory,
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A guided tour of how Flutter turns platform key codes into '
                  'LogicalKeyboardKey and PhysicalKeyboardKey instances ---'
                  ' the public surface that the internal KeyHelper class '
                  'exists to power on Linux toolkits.',
                  style: TextStyle(
                    color: _accSteel,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'PALETTE',
                  style: TextStyle(
                    color: _accCypress,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  children: [
                    _swatch(_bgDeep, 'bgDeep'),
                    _swatch(_bgPanel, 'bgPanel'),
                    _swatch(_bgCard, 'bgCard'),
                    _swatch(_bgInset, 'bgInset'),
                    _swatch(_accSteel, 'steel'),
                    _swatch(_accCypress, 'cypress'),
                    _swatch(_accMoss, 'moss'),
                    _swatch(_accAmber, 'amber'),
                    _swatch(_accCopper, 'copper'),
                    _swatch(_accIvory, 'ivory'),
                    _swatch(_accCrimson, 'crimson'),
                    _swatch(_accSky, 'sky'),
                  ],
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 2. Prose anatomy: resolution pipeline.
          // -----------------------------------------------------------------
          _sectionTitle('1', 'The Resolution Pipeline'),
          _card(
            tint: _accCypress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _prose(
                  'When a user presses a key, an absurd amount of code runs '
                  'before your KeyEvent handler fires.  The journey begins '
                  'in the operating system, passes through a windowing '
                  'toolkit, and finally lands in Flutter as a pair of '
                  'tokens: a LogicalKeyboardKey describing the meaning of '
                  'the key and a PhysicalKeyboardKey describing its '
                  'location on the keyboard.',
                ),
                const SizedBox(height: 12),
                _prose(
                  'On Linux, the bridge between toolkit-specific key codes '
                  '(GTK keysyms, GLFW codes, X11 KeySym, evdev scan codes) '
                  'and the cross-platform Flutter tokens is the internal '
                  'KeyHelper hierarchy --- KeyHelper, GtkKeyHelper and '
                  'GLFWKeyHelper.  These classes live behind '
                  'raw_keyboard_linux.dart and are not exported to '
                  'application code, but every LogicalKeyboardKey value you '
                  'match against ultimately came out of one of them.',
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _bgDeep,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _accAmber.withValues(alpha: 0.5),
                    ),
                  ),
                  child: const Text(
                    'OS event\n'
                    '   |\n'
                    '   v\n'
                    'Toolkit (GTK / GLFW / X11)\n'
                    '   |\n'
                    '   v\n'
                    'KeyHelper.numpadKey / logicalKey / physicalKey\n'
                    '   |\n'
                    '   v\n'
                    'RawKeyEvent / KeyEvent\n'
                    '   |\n'
                    '   v\n'
                    'LogicalKeyboardKey  +  PhysicalKeyboardKey\n'
                    '   |\n'
                    '   v\n'
                    'Shortcuts / SingleActivator / your handler',
                    style: TextStyle(
                      color: _accIvory,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 3. Property anatomy.
          // -----------------------------------------------------------------
          _sectionTitle('2', 'Property Anatomy'),
          _card(
            tint: _accSteel,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LogicalKeyboardKey',
                  style: TextStyle(
                    color: _accAmber,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                _kvRow(
                  'keyId',
                  '64-bit identifier; printable Unicode in low bits or '
                      'a Flutter-assigned non-printable id.',
                ),
                _kvRow(
                  'debugName',
                  'human-readable name like "Key A" or "Escape".  Null in '
                      'release.  Use only for logs.',
                ),
                _kvRow(
                  'keyLabel',
                  'printable label "a", "Enter", "Escape", "" for some '
                      'modifiers.  Locale-independent.',
                ),
                _kvRow(
                  'synonyms',
                  'set of canonical keys this key collapses to.  e.g. '
                      'shiftLeft.synonyms == { shift }.',
                ),
                const SizedBox(height: 16),
                const Text(
                  'PhysicalKeyboardKey',
                  style: TextStyle(
                    color: _accAmber,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                _kvRow(
                  'usbHidUsage',
                  '32-bit USB HID usage code.  This is the layout-independent '
                      'physical position of the key.',
                ),
                _kvRow(
                  'debugName',
                  'human-readable name like "Key A" or "Arrow Up".  Null in '
                      'release.',
                ),
                const SizedBox(height: 14),
                _prose(
                  'Live snapshot of "A" --- both keys carry the same name '
                  'but represent very different things:',
                ),
                const SizedBox(height: 8),
                _kvRow('logical.keyA.keyId', idKeyA, accent: _accSky),
                _kvRow('logical.keyA.keyLabel', '"$labelKeyA"',
                    accent: _accSky),
                _kvRow('logical.keyA.debugName', '"$dnKeyA"', accent: _accSky),
                _kvRow('physical.keyA.usbHidUsage', hidKeyA,
                    accent: _accCopper),
                _kvRow('physical.keyA.debugName', '"$pdnKeyA"',
                    accent: _accCopper),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 4. Logical key gallery (24+ rows).
          // -----------------------------------------------------------------
          _sectionTitle('3', 'Logical Key Gallery (live)'),
          _card(
            tint: _accSky,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _prose(
                  'Each tile below pulls keyId / debugName / keyLabel '
                  'directly from the static accessors on '
                  'LogicalKeyboardKey.  No hard-coded values --- if Flutter '
                  'changes a label, this gallery reflects it.',
                ),
                const SizedBox(height: 12),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.keyA',
                  keyId: idKeyA,
                  debugName: dnKeyA,
                  keyLabel: labelKeyA,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.keyB',
                  keyId: LogicalKeyboardKey.keyB.keyId.toString(),
                  debugName: LogicalKeyboardKey.keyB.debugName ?? '?',
                  keyLabel: labelKeyB,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.keyC',
                  keyId: LogicalKeyboardKey.keyC.keyId.toString(),
                  debugName: LogicalKeyboardKey.keyC.debugName ?? '?',
                  keyLabel: labelKeyC,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.keyZ',
                  keyId: idKeyZ,
                  debugName: LogicalKeyboardKey.keyZ.debugName ?? '?',
                  keyLabel: labelKeyZ,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.digit0',
                  keyId: LogicalKeyboardKey.digit0.keyId.toString(),
                  debugName: LogicalKeyboardKey.digit0.debugName ?? '?',
                  keyLabel: labelDigit0,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.digit1',
                  keyId: LogicalKeyboardKey.digit1.keyId.toString(),
                  debugName: LogicalKeyboardKey.digit1.debugName ?? '?',
                  keyLabel: labelDigit1,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.enter',
                  keyId: idEnter,
                  debugName: dnEnter,
                  keyLabel: labelEnter,
                  tint: _accAmber,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.escape',
                  keyId: idEscape,
                  debugName: dnEscape,
                  keyLabel: labelEscape,
                  tint: _accCrimson,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.space',
                  keyId: idSpace,
                  debugName: dnSpace,
                  keyLabel: labelSpace,
                  tint: _accMoss,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.tab',
                  keyId: idTab,
                  debugName: dnTab,
                  keyLabel: labelTab,
                  tint: _accAmber,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.backspace',
                  keyId: idBackspace,
                  debugName: dnBackspace,
                  keyLabel: labelBackspace,
                  tint: _accCrimson,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.arrowUp',
                  keyId: idArrowUp,
                  debugName: dnArrowUp,
                  keyLabel: labelArrowUp,
                  tint: _accSky,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.arrowDown',
                  keyId: idArrowDown,
                  debugName: LogicalKeyboardKey.arrowDown.debugName ?? '?',
                  keyLabel: labelArrowDown,
                  tint: _accSky,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.arrowLeft',
                  keyId: idArrowLeft,
                  debugName: LogicalKeyboardKey.arrowLeft.debugName ?? '?',
                  keyLabel: labelArrowLeft,
                  tint: _accSky,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.arrowRight',
                  keyId: idArrowRight,
                  debugName: LogicalKeyboardKey.arrowRight.debugName ?? '?',
                  keyLabel: labelArrowRight,
                  tint: _accSky,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.f1',
                  keyId: idF1,
                  debugName: dnF1,
                  keyLabel: labelF1,
                  tint: _accCopper,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.f2',
                  keyId: idF2,
                  debugName: dnF2,
                  keyLabel: labelF2,
                  tint: _accCopper,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.f3',
                  keyId: idF3,
                  debugName: LogicalKeyboardKey.f3.debugName ?? '?',
                  keyLabel: labelF3,
                  tint: _accCopper,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.f4',
                  keyId: idF4,
                  debugName: LogicalKeyboardKey.f4.debugName ?? '?',
                  keyLabel: labelF4,
                  tint: _accCopper,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.numLock',
                  keyId: idNumLock,
                  debugName: dnNumLock,
                  keyLabel: labelNumLock,
                  tint: _accAmber,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.shiftLeft',
                  keyId: idShiftLeft,
                  debugName: dnShiftLeft,
                  keyLabel: labelShiftLeft,
                  tint: _accCypress,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.shiftRight',
                  keyId: idShiftRight,
                  debugName: LogicalKeyboardKey.shiftRight.debugName ?? '?',
                  keyLabel: labelShiftRight,
                  tint: _accCypress,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.controlLeft',
                  keyId: idControlLeft,
                  debugName: dnControlLeft,
                  keyLabel: labelControlLeft,
                  tint: _accCypress,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.controlRight',
                  keyId: idControlRight,
                  debugName: LogicalKeyboardKey.controlRight.debugName ?? '?',
                  keyLabel: labelControlRight,
                  tint: _accCypress,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.altLeft',
                  keyId: idAltLeft,
                  debugName: dnAltLeft,
                  keyLabel: labelAltLeft,
                  tint: _accMoss,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.altRight',
                  keyId: idAltRight,
                  debugName: LogicalKeyboardKey.altRight.debugName ?? '?',
                  keyLabel: labelAltRight,
                  tint: _accMoss,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.metaLeft',
                  keyId: idMetaLeft,
                  debugName: dnMetaLeft,
                  keyLabel: labelMetaLeft,
                  tint: _accCopper,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.metaRight',
                  keyId: idMetaRight,
                  debugName: LogicalKeyboardKey.metaRight.debugName ?? '?',
                  keyLabel: labelMetaRight,
                  tint: _accCopper,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.home',
                  keyId: LogicalKeyboardKey.home.keyId.toString(),
                  debugName: LogicalKeyboardKey.home.debugName ?? '?',
                  keyLabel: labelHome,
                  tint: _accSteel,
                ),
                _logicalKeyTile(
                  name: 'LogicalKeyboardKey.end',
                  keyId: LogicalKeyboardKey.end.keyId.toString(),
                  debugName: LogicalKeyboardKey.end.debugName ?? '?',
                  keyLabel: labelEnd,
                  tint: _accSteel,
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 5. Physical key gallery (12+ rows).
          // -----------------------------------------------------------------
          _sectionTitle('4', 'Physical Key Gallery (live)'),
          _card(
            tint: _accCopper,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _prose(
                  'PhysicalKeyboardKey describes a position on the keyboard.  '
                  'A key here is the same physical chunk of plastic '
                  'regardless of layout: PhysicalKeyboardKey.keyA is the '
                  'A-position, even on a French AZERTY layout where it '
                  'produces "q".',
                ),
                const SizedBox(height: 12),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.keyA',
                  usbHid: hidKeyA,
                  debugName: pdnKeyA,
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.keyB',
                  usbHid: hidKeyB,
                  debugName: PhysicalKeyboardKey.keyB.debugName ?? '?',
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.keyC',
                  usbHid: hidKeyC,
                  debugName: PhysicalKeyboardKey.keyC.debugName ?? '?',
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.enter',
                  usbHid: hidEnter,
                  debugName: pdnEnter,
                  tint: _accAmber,
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.escape',
                  usbHid: hidEscape,
                  debugName: pdnEscape,
                  tint: _accCrimson,
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.space',
                  usbHid: hidSpace,
                  debugName: pdnSpace,
                  tint: _accMoss,
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.tab',
                  usbHid: hidTab,
                  debugName: pdnTab,
                  tint: _accAmber,
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.arrowUp',
                  usbHid: hidArrowUp,
                  debugName: pdnArrowUp,
                  tint: _accSky,
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.arrowDown',
                  usbHid: hidArrowDown,
                  debugName: PhysicalKeyboardKey.arrowDown.debugName ?? '?',
                  tint: _accSky,
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.shiftLeft',
                  usbHid: hidShiftLeft,
                  debugName: pdnShiftLeft,
                  tint: _accCypress,
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.controlLeft',
                  usbHid: hidControlLeft,
                  debugName: PhysicalKeyboardKey.controlLeft.debugName ?? '?',
                  tint: _accCypress,
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.altLeft',
                  usbHid: hidAltLeft,
                  debugName: PhysicalKeyboardKey.altLeft.debugName ?? '?',
                  tint: _accMoss,
                ),
                _physicalKeyTile(
                  name: 'PhysicalKeyboardKey.metaLeft',
                  usbHid: hidMetaLeft,
                  debugName: PhysicalKeyboardKey.metaLeft.debugName ?? '?',
                  tint: _accCopper,
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 6. Synonym / collapse mapping.
          // -----------------------------------------------------------------
          _sectionTitle('5', 'Synonym / Collapse Mapping'),
          _card(
            tint: _accMoss,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _prose(
                  'Some keys have left and right variants but mean the same '
                  'thing for shortcut purposes.  LogicalKeyboardKey exposes '
                  'a "synonyms" set so SingleActivator and Shortcuts can '
                  'collapse them into a canonical key.',
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _bgDeep,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _accMoss.withValues(alpha: 0.6),
                    ),
                  ),
                  child: const Text(
                    'shiftLeft  ----+\n'
                    '               +---->  shift\n'
                    'shiftRight ----+\n'
                    '\n'
                    'controlLeft  --+\n'
                    '               +---->  control\n'
                    'controlRight --+\n'
                    '\n'
                    'altLeft  ------+\n'
                    '               +---->  alt\n'
                    'altRight ------+\n'
                    '\n'
                    'metaLeft  -----+\n'
                    '               +---->  meta\n'
                    'metaRight -----+\n',
                    style: TextStyle(
                      color: _accIvory,
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  children: [
                    _chip('shiftLeft', _accCypress),
                    _chip('shiftRight', _accCypress),
                    _chip('-> shift', _accAmber),
                    _chip('controlLeft', _accCypress),
                    _chip('controlRight', _accCypress),
                    _chip('-> control', _accAmber),
                    _chip('altLeft', _accMoss),
                    _chip('altRight', _accMoss),
                    _chip('-> alt', _accAmber),
                    _chip('metaLeft', _accCopper),
                    _chip('metaRight', _accCopper),
                    _chip('-> meta', _accAmber),
                  ],
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 7. Modifier matrix (5 x 5).
          // -----------------------------------------------------------------
          _sectionTitle('6', 'Modifier x Sample Key Matrix'),
          _card(
            tint: _accAmber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _prose(
                  'Each cell shows what a typical IDE-style shortcut would '
                  'be: modifier + key.  This is purely descriptive --- it '
                  'is the alphabet a Shortcuts widget would speak.',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _matrixCell('mod \\ key', header: true),
                    _matrixCell('keyA', header: true),
                    _matrixCell('keyZ', header: true),
                    _matrixCell('enter', header: true),
                    _matrixCell('arrowUp', header: true),
                    _matrixCell('escape', header: true),
                  ],
                ),
                Row(
                  children: [
                    _matrixCell('control', header: true),
                    _matrixCell('Ctrl+A'),
                    _matrixCell('Ctrl+Z'),
                    _matrixCell('Ctrl+Enter'),
                    _matrixCell('Ctrl+Up'),
                    _matrixCell('Ctrl+Esc'),
                  ],
                ),
                Row(
                  children: [
                    _matrixCell('shift', header: true),
                    _matrixCell('Shift+A'),
                    _matrixCell('Shift+Z'),
                    _matrixCell('Shift+Enter'),
                    _matrixCell('Shift+Up'),
                    _matrixCell('Shift+Esc'),
                  ],
                ),
                Row(
                  children: [
                    _matrixCell('alt', header: true),
                    _matrixCell('Alt+A'),
                    _matrixCell('Alt+Z'),
                    _matrixCell('Alt+Enter'),
                    _matrixCell('Alt+Up'),
                    _matrixCell('Alt+Esc'),
                  ],
                ),
                Row(
                  children: [
                    _matrixCell('meta', header: true),
                    _matrixCell('Meta+A'),
                    _matrixCell('Meta+Z'),
                    _matrixCell('Meta+Enter'),
                    _matrixCell('Meta+Up'),
                    _matrixCell('Meta+Esc'),
                  ],
                ),
                const SizedBox(height: 12),
                _prose(
                  'A Flutter SingleActivator stores the trigger key plus '
                  'four booleans (control, shift, alt, meta).  When a key '
                  'event arrives, the activator collapses left/right '
                  'modifiers via the synonyms map and compares.',
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 8. KeyEventResult / SingleActivator alignment.
          // -----------------------------------------------------------------
          _sectionTitle('7', 'KeyEventResult and SingleActivator'),
          _card(
            tint: _accSky,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _prose(
                  'When you handle a key event you must tell Flutter what '
                  'happened, returning a KeyEventResult.  This is the '
                  'three-valued contract:',
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _bgDeep,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _accSky.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _kvRow(
                        'handled',
                        'I consumed it.  Stop bubbling.',
                        accent: _accMoss,
                      ),
                      _kvRow(
                        'ignored',
                        'I did not consume it.  Continue bubbling.',
                        accent: _accAmber,
                      ),
                      _kvRow(
                        'skipRemaining...',
                        'Stop the loop, do not consume.',
                        accent: _accCrimson,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _prose(
                  'SingleActivator + Shortcuts is the high-level path.  You '
                  'declare LogicalKeySet({LogicalKeyboardKey.control, '
                  'LogicalKeyboardKey.keyS}) and Flutter does the matching, '
                  'including modifier collapsing.',
                ),
                const SizedBox(height: 8),
                _prose(
                  'KeyEvent.logicalKey vs KeyEvent.physicalKey is the '
                  'fundamental decision: are you reacting to a meaning ('
                  'logical) or to a position (physical)?  Game WASD wants '
                  'physical; "press s to save" wants logical.',
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 9. DO / AVOID.
          // -----------------------------------------------------------------
          _sectionTitle('8', 'DO / AVOID'),
          _card(
            tint: _accCypress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _doRule(
                  'DO use LogicalKeyboardKey.keyId for stable identity '
                  'comparisons.  It is hashable, equals-able and stable '
                  'across runs.',
                ),
                _doRule(
                  'DO prefer SingleActivator and Shortcuts widgets over '
                  'manual KeyEvent matching --- modifier collapsing comes '
                  'for free.',
                ),
                _doRule(
                  'DO use PhysicalKeyboardKey for layout-independent '
                  'positions, like WASD movement controls.',
                ),
                _doRule(
                  'DO use FocusNode.onKeyEvent and return a KeyEventResult '
                  'so the framework knows whether to keep bubbling.',
                ),
                _avoidRule(
                  'AVOID comparing keyLabel for non-printable keys.  '
                  'shiftLeft.keyLabel is "" and varies between platforms.',
                ),
                _avoidRule(
                  'AVOID treating debugName as a stable identifier.  It is '
                  'null in release builds and may change between Flutter '
                  'versions.',
                ),
                _avoidRule(
                  'AVOID confusing logical and physical keys.  Use logical '
                  'for "press S to save" and physical for "WASD".',
                ),
                _avoidRule(
                  'AVOID poking at internal KeyHelper / GtkKeyHelper / '
                  'GLFWKeyHelper directly --- they are not part of the '
                  'public API and can be reorganised at any time.',
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 10. Code-snippet cards (5 canonical recipes).
          // -----------------------------------------------------------------
          _sectionTitle('9', 'Five Canonical Recipes'),
          _card(
            tint: _accAmber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _codeBlock(
                  'RECIPE 1 -- Shortcuts + Actions',
                  'Shortcuts(\n'
                      '  shortcuts: <ShortcutActivator, Intent>{\n'
                      '    SingleActivator(LogicalKeyboardKey.keyS,\n'
                      '        control: true): SaveIntent(),\n'
                      '    SingleActivator(LogicalKeyboardKey.escape):\n'
                      '        DismissIntent(),\n'
                      '  },\n'
                      '  child: Actions(\n'
                      '    actions: <Type, Action<Intent>>{\n'
                      '      SaveIntent: CallbackAction(\n'
                      '        onInvoke: (_) => doSave()),\n'
                      '    },\n'
                      '    child: Focus(autofocus: true, child: child),\n'
                      '  ),\n'
                      ');',
                ),
                _codeBlock(
                  'RECIPE 2 -- Focus.onKeyEvent',
                  'Focus(\n'
                      '  onKeyEvent: (node, event) {\n'
                      '    if (event is KeyDownEvent &&\n'
                      '        event.logicalKey ==\n'
                      '            LogicalKeyboardKey.arrowDown) {\n'
                      '      moveDown();\n'
                      '      return KeyEventResult.handled;\n'
                      '    }\n'
                      '    return KeyEventResult.ignored;\n'
                      '  },\n'
                      '  child: child,\n'
                      ');',
                ),
                _codeBlock(
                  'RECIPE 3 -- Physical WASD',
                  'final wasd = <PhysicalKeyboardKey>{\n'
                      '  PhysicalKeyboardKey.keyW,\n'
                      '  PhysicalKeyboardKey.keyA,\n'
                      '  PhysicalKeyboardKey.keyS,\n'
                      '  PhysicalKeyboardKey.keyD,\n'
                      '};\n'
                      'if (wasd.contains(event.physicalKey)) {\n'
                      '  applyMovement(event.physicalKey);\n'
                      '}',
                ),
                _codeBlock(
                  'RECIPE 4 -- Modifier check via collapsing',
                  'bool isCtrlPressed(Set<LogicalKeyboardKey> down) {\n'
                      '  return down.contains(LogicalKeyboardKey.control)\n'
                      '      || down.contains(\n'
                      '             LogicalKeyboardKey.controlLeft)\n'
                      '      || down.contains(\n'
                      '             LogicalKeyboardKey.controlRight);\n'
                      '}',
                ),
                _codeBlock(
                  'RECIPE 5 -- Logging without leaking debugName',
                  'String idOf(LogicalKeyboardKey k) =>\n'
                      '    "0x\${k.keyId.toRadixString(16)}";\n'
                      '\n'
                      'void log(KeyEvent e) {\n'
                      '  print("logical=\${idOf(e.logicalKey)} "\n'
                      '      "physical=\${e.physicalKey.usbHidUsage}");\n'
                      '}',
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 11. Glossary (12+ terms).
          // -----------------------------------------------------------------
          _sectionTitle('10', 'Glossary'),
          _card(
            tint: _accSteel,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _glossaryEntry(
                  'KeyHelper',
                  'Internal Linux abstraction that maps toolkit-specific '
                      '(GTK / GLFW) key codes onto cross-platform Flutter '
                      'tokens.  Not exported.',
                ),
                _glossaryEntry(
                  'GtkKeyHelper',
                  'KeyHelper subclass for the GTK toolkit; reads GDK '
                      'modifier masks and X11 keysyms.',
                ),
                _glossaryEntry(
                  'GLFWKeyHelper',
                  'KeyHelper subclass for the GLFW toolkit, used by the '
                      'Flutter Linux GLFW backend.',
                ),
                _glossaryEntry(
                  'LogicalKeyboardKey',
                  'A token describing the meaning of a key press: '
                      '"the A key", "Escape", "ArrowUp".  Layout-aware.',
                ),
                _glossaryEntry(
                  'PhysicalKeyboardKey',
                  'A token describing a position on the keyboard, '
                      'identified by USB HID usage code.  Layout-independent.',
                ),
                _glossaryEntry(
                  'keyId',
                  '64-bit identifier on LogicalKeyboardKey.  Stable, '
                      'comparable, hashable.',
                ),
                _glossaryEntry(
                  'usbHidUsage',
                  '32-bit USB HID usage code on PhysicalKeyboardKey.  Tied '
                      'to physical position.',
                ),
                _glossaryEntry(
                  'keyLabel',
                  'Printable text label on LogicalKeyboardKey.  Empty for '
                      'most modifier and control keys.',
                ),
                _glossaryEntry(
                  'debugName',
                  'Human-friendly name for diagnostics.  Null in release '
                      'builds.  Never use as identity.',
                ),
                _glossaryEntry(
                  'synonyms',
                  'Set of canonical keys this key collapses to.  Used by '
                      'SingleActivator to ignore left/right distinction.',
                ),
                _glossaryEntry(
                  'KeyEvent',
                  'Modern key event type (KeyDownEvent, KeyUpEvent, '
                      'KeyRepeatEvent).  Replaces RawKeyEvent.',
                ),
                _glossaryEntry(
                  'RawKeyEvent',
                  'Legacy key event with toolkit-specific data (e.g. '
                      'RawKeyEventDataLinux).  Being phased out.',
                ),
                _glossaryEntry(
                  'KeyEventResult',
                  'Three-valued return: handled, ignored, '
                      'skipRemainingHandlers.  Controls bubble.',
                ),
                _glossaryEntry(
                  'SingleActivator',
                  'High-level shortcut definition: trigger key + flags for '
                      'control / shift / alt / meta.',
                ),
                _glossaryEntry(
                  'FocusNode.onKeyEvent',
                  'Per-focus-node hook for handling key events.  Returns a '
                      'KeyEventResult.',
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 12. Recap footer.
          // -----------------------------------------------------------------
          _sectionTitle('11', 'Recap'),
          _card(
            tint: _accCypress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _prose(
                  'KeyHelper is a Linux-side bridge between toolkit-specific '
                  'key codes and Flutter tokens.  You will rarely touch '
                  'it, but every keystroke you receive in your handler '
                  'has been through it (or its Mac/Windows/Web cousins).',
                ),
                const SizedBox(height: 10),
                _prose(
                  'Reach for LogicalKeyboardKey when you care about meaning '
                  '(Save = Ctrl+S), and PhysicalKeyboardKey when you care '
                  'about position (WASD).  Use Shortcuts and Actions for '
                  'app-level bindings, FocusNode.onKeyEvent for widget-'
                  'level, and KeyEventResult to control bubbling.',
                ),
                const SizedBox(height: 10),
                _prose(
                  'Never depend on debugName for logic.  Always collapse '
                  'left/right modifiers to canonical equivalents.  Avoid '
                  'comparing keyLabel for non-printable keys.',
                ),
                const SizedBox(height: 14),
                Wrap(
                  children: [
                    _chip('logical', _accSky),
                    _chip('physical', _accCopper),
                    _chip('synonyms', _accMoss),
                    _chip('keyId', _accAmber),
                    _chip('usbHidUsage', _accCopper),
                    _chip('debugName=logs', _accSteel),
                    _chip('Shortcuts', _accCypress),
                    _chip('SingleActivator', _accCypress),
                    _chip('KeyEventResult', _accAmber),
                    _chip('FocusNode', _accSky),
                  ],
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // Final palette echo --- mirror of the title-banner swatches.
          // -----------------------------------------------------------------
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _bgPanel,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _accSteel.withValues(alpha: 0.4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'STEEL CYPRESS --- end of demo',
                  style: TextStyle(
                    color: _accAmber,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  children: [
                    _swatch(_bgDeep, 'bgDeep'),
                    _swatch(_bgPanel, 'bgPanel'),
                    _swatch(_bgCard, 'bgCard'),
                    _swatch(_bgInset, 'bgInset'),
                    _swatch(_accSteel, 'steel'),
                    _swatch(_accCypress, 'cypress'),
                    _swatch(_accMoss, 'moss'),
                    _swatch(_accAmber, 'amber'),
                    _swatch(_accCopper, 'copper'),
                    _swatch(_accIvory, 'ivory'),
                    _swatch(_accCrimson, 'crimson'),
                    _swatch(_accSky, 'sky'),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Snapshot built once.  Live readouts: keyA="$labelKeyA" '
                  'id=$idKeyA  |  enter id=$idEnter  |  '
                  'arrowUp id=$idArrowUp  |  shiftLeft id=$idShiftLeft  |  '
                  'physical.keyA hid=$hidKeyA  |  physical.enter hid=$hidEnter',
                  style: const TextStyle(
                    color: _accIvory,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    height: 1.5,
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
