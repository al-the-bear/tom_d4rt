// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep visual demo: TapGestureRecognizer from package:flutter/gestures.dart
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---- Unique palette: "Cobalt Tap" ----
  const Color cBg = Color(0xFF0A1530);
  const Color cSurface = Color(0xFF132149);
  const Color cSurfaceAlt = Color(0xFF1B2C5E);
  const Color cBorder = Color(0xFF2C4485);
  const Color cText = Color(0xFFE6ECFF);
  const Color cMuted = Color(0xFF98A8D6);
  const Color cAccent = Color(0xFF66E0FF); // primary tap (cobalt cyan)
  const Color cSecondary = Color(0xFFFFB454); // secondary tap (amber)
  const Color cTertiary = Color(0xFFB48BFF); // tertiary tap (violet)
  const Color cWarn = Color(0xFFFF6B8A); // cancel
  const Color cOk = Color(0xFF7DFFB0); // accept

  // ---- Construct recognizer in try/catch (live-construction panel) ----
  String constructionState = 'unknown';
  String runtimeLabel = 'unknown';
  bool primaryNullBefore = true;
  bool primaryNullAfter = true;
  bool secondaryNullAfter = true;
  bool tertiaryNullAfter = true;
  String constructionError = '';
  try {
    final TapGestureRecognizer rec = TapGestureRecognizer();
    runtimeLabel = rec.runtimeType.toString();
    primaryNullBefore = rec.onTap == null;
    rec.onTap = () {
      print('demo onTap');
    };
    rec.onTapDown = (TapDownDetails d) {
      print('demo onTapDown @ ${d.globalPosition}');
    };
    rec.onTapUp = (TapUpDetails d) {
      print('demo onTapUp @ ${d.globalPosition}');
    };
    rec.onSecondaryTap = () {
      print('demo onSecondaryTap');
    };
    rec.onTertiaryTapDown = (TapDownDetails d) {
      print('demo onTertiaryTapDown @ ${d.globalPosition}');
    };
    primaryNullAfter = rec.onTap == null;
    secondaryNullAfter = rec.onSecondaryTap == null;
    tertiaryNullAfter = rec.onTertiaryTapDown == null;
    constructionState = 'ok';
    rec.dispose();
  } catch (e) {
    constructionState = 'failed';
    constructionError = e.toString();
  }

  // ---- Helpers for repeated pieces ----
  Widget chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget sectionTitle(String label, IconData icon, Color tint) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 24, 4, 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: tint.withValues(alpha: 0.55)),
            ),
            child: Icon(icon, color: tint, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              color: cText,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget card({required Widget child, Color? edge}) {
    final Color e = edge ?? cBorder;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: e.withValues(alpha: 0.7)),
      ),
      child: child,
    );
  }

  Widget kv(String k, String v, {Color color = cText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              k,
              style: const TextStyle(color: cMuted, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // Section 1: HERO HEADER
  // =====================================================================
  final Widget hero = Container(
    padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF132149), Color(0xFF1B2C5E), Color(0xFF0A1530)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: cAccent.withValues(alpha: 0.45), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cAccent.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: cAccent.withValues(alpha: 0.6)),
              ),
              child: const Icon(Icons.touch_app, color: cAccent, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'TapGestureRecognizer',
                    style: TextStyle(
                      color: cText,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'package:flutter/gestures.dart  ·  recognizes taps from primary, secondary and tertiary buttons',
                    style: TextStyle(color: cMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            chip('PrimaryPointerGestureRecognizer', cAccent),
            chip('OneSequenceGestureRecognizer', cSecondary),
            chip('GestureRecognizer', cTertiary),
            chip('Disposable', cMuted),
            chip('arena participant', cOk),
          ],
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 2: LIFECYCLE STATE-MACHINE DIAGRAM
  // =====================================================================
  Widget lifecycleNode(String label, Color color, {bool terminal = false}) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: terminal ? 0.95 : 0.6),
          width: terminal ? 2 : 1,
        ),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget arrow(String label, {Color color = cMuted}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(color: color, fontSize: 10),
          ),
          Container(width: 28, height: 2, color: color.withValues(alpha: 0.6)),
        ],
      ),
    );
  }

  final Widget lifecycle = card(
    edge: cAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lifecycle state machine',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'PointerDown sequence is admitted into the gesture arena. The recognizer wins or yields based on slop and timeout.',
          style: TextStyle(color: cMuted, fontSize: 11),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              lifecycleNode('PointerDown', cMuted),
              arrow('admit', color: cAccent),
              lifecycleNode('Tracking', cAccent),
              arrow('within slop\n+ timeout', color: cAccent),
              lifecycleNode('TapDown fired', cAccent, terminal: true),
              arrow('PointerUp', color: cOk),
              lifecycleNode('Tap+TapUp', cOk, terminal: true),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              lifecycleNode('Tracking', cAccent),
              arrow('moves > kTouchSlop', color: cWarn),
              lifecycleNode('TapCancel', cWarn, terminal: true),
              arrow('held > kPressTimeout', color: cWarn),
              lifecycleNode('yields → long press', cWarn, terminal: true),
            ],
          ),
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 3: CALLBACK GALLERY
  // =====================================================================
  final List<List<String>> callbacks = [
    [
      'onTapDown',
      'TapDownDetails',
      'cAccent',
      'Pointer first contact admitted as tap candidate.',
      'after kPressTimeout fraction',
    ],
    [
      'onTapUp',
      'TapUpDetails',
      'cAccent',
      'Pointer release while still recognized as tap.',
      'paired with onTap',
    ],
    [
      'onTap',
      'VoidCallback',
      'cAccent',
      'High-level "a tap occurred" notification.',
      'fires immediately before onTapUp',
    ],
    [
      'onTapCancel',
      'GestureTapCancelCallback',
      'cWarn',
      'Recognizer rejected the candidate (slop/timeout/arena loss).',
      'no Up/Tap fires after this',
    ],
    [
      'onSecondaryTapDown',
      'TapDownDetails',
      'cSecondary',
      'Right-button (secondary) press detected.',
      'desktop / stylus barrel',
    ],
    [
      'onSecondaryTapUp',
      'TapUpDetails',
      'cSecondary',
      'Right-button release within slop.',
      'paired with onSecondaryTap',
    ],
    [
      'onSecondaryTap',
      'VoidCallback',
      'cSecondary',
      'Convenience high-level secondary tap event.',
      'fires before onSecondaryTapUp',
    ],
    [
      'onSecondaryTapCancel',
      'GestureTapCancelCallback',
      'cSecondary',
      'Secondary candidate rejected.',
      'rare on touch devices',
    ],
    [
      'onTertiaryTapDown',
      'TapDownDetails',
      'cTertiary',
      'Middle-button press detected.',
      'common on mice',
    ],
    [
      'onTertiaryTapUp',
      'TapUpDetails',
      'cTertiary',
      'Middle-button release within slop.',
      'no high-level onTertiaryTap',
    ],
    [
      'onTertiaryTapCancel',
      'GestureTapCancelCallback',
      'cTertiary',
      'Middle-button candidate rejected.',
      'often during drags',
    ],
  ];

  Color colorFor(String key) {
    if (key == 'cAccent') return cAccent;
    if (key == 'cSecondary') return cSecondary;
    if (key == 'cTertiary') return cTertiary;
    if (key == 'cWarn') return cWarn;
    return cMuted;
  }

  final List<Widget> callbackCards = [];
  for (int i = 0; i < callbacks.length; i++) {
    final List<String> row = callbacks[i];
    final String name = row[0];
    final String type = row[1];
    final Color tint = colorFor(row[2]);
    final String desc = row[3];
    final String timing = row[4];
    callbackCards.add(
      Container(
        width: 290,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cSurfaceAlt,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tint.withValues(alpha: 0.55)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: tint,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: tint,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              type,
              style: const TextStyle(
                color: cMuted,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: const TextStyle(color: cText, fontSize: 12, height: 1.3),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 12,
                  color: tint.withValues(alpha: 0.8),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    timing,
                    style: TextStyle(color: tint, fontSize: 10.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Widget callbackGallery = card(
    edge: cAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Callbacks (primary / secondary / tertiary)',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Eleven settable callbacks; high-level (onTap / onSecondaryTap) fires before its paired *Up event.',
          style: TextStyle(color: cMuted, fontSize: 11),
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 10, runSpacing: 10, children: callbackCards),
      ],
    ),
  );

  // =====================================================================
  // Section 4: DETAILS TYPES REFERENCE
  // =====================================================================
  Widget fieldRow(String fieldName, String typeName, String note) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              fieldName,
              style: const TextStyle(
                color: cAccent,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              typeName,
              style: const TextStyle(
                color: cSecondary,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(color: cText, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  final Widget detailsTypes = card(
    edge: cSecondary,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Details types',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TapDownDetails',
                style: TextStyle(
                  color: cAccent,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              fieldRow('globalPosition', 'Offset', 'Position in global coords.'),
              fieldRow('localPosition', 'Offset?', 'Position relative to box.'),
              fieldRow('kind', 'PointerDeviceKind', 'touch / mouse / stylus / trackpad.'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TapUpDetails',
                style: TextStyle(
                  color: cAccent,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              fieldRow('globalPosition', 'Offset', 'Release position (global).'),
              fieldRow('localPosition', 'Offset?', 'Release position (local).'),
              fieldRow('kind', 'PointerDeviceKind', 'Inherited from PointerEvent.'),
            ],
          ),
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 5: BUTTON-TYPES PANEL
  // =====================================================================
  Widget buttonRow(String label, Color color, String mask, String fires) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 130,
            child: Text(
              mask,
              style: const TextStyle(
                color: cMuted,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              fires,
              style: const TextStyle(color: cText, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  final Widget buttons = card(
    edge: cTertiary,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mouse buttons → callback channel',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        buttonRow(
          'Primary',
          cAccent,
          'kPrimaryButton',
          'onTapDown / onTapUp / onTap / onTapCancel',
        ),
        buttonRow(
          'Secondary',
          cSecondary,
          'kSecondaryButton',
          'onSecondaryTapDown/Up/Tap/Cancel',
        ),
        buttonRow(
          'Tertiary',
          cTertiary,
          'kTertiaryButton',
          'onTertiaryTapDown/Up/Cancel (no high-level Tap)',
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cTertiary.withValues(alpha: 0.45)),
          ),
          child: const Text(
            'Touch devices have no button concept; touches are always treated as primary.',
            style: TextStyle(color: cTertiary, fontSize: 11),
          ),
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 6: ARENA INTERPLAY
  // =====================================================================
  Widget arenaActor(String name, String wins, String loses, Color color) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cSurfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle, color: cOk, size: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  wins,
                  style: const TextStyle(color: cText, fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.cancel, color: cWarn, size: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  loses,
                  style: const TextStyle(color: cMuted, fontSize: 11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final Widget arena = card(
    edge: cOk,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Arena interplay',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Each pointer enters a GestureArena; recognizers compete and the surviving one accepts the pointer.',
          style: TextStyle(color: cMuted, fontSize: 11),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            arenaActor(
              'TapGestureRecognizer',
              'pointer up within slop & before kPressTimeout',
              'pointer drifts > kTouchSlop or held too long',
              cAccent,
            ),
            arenaActor(
              'LongPressGestureRecognizer',
              'pointer held > kLongPressTimeout',
              'pointer released early or tap fires first',
              cSecondary,
            ),
            arenaActor(
              'PanGestureRecognizer',
              'pointer moves > kTouchSlop',
              'pointer stays still',
              cTertiary,
            ),
            arenaActor(
              'DoubleTapGestureRecognizer',
              'second tap within kDoubleTapTimeout',
              'tap stands alone',
              cWarn,
            ),
          ],
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 7: CODE CARD (RawGestureDetector registration)
  // =====================================================================
  const String codeSnippet = '''RawGestureDetector(
  gestures: <Type, GestureRecognizerFactory>{
    TapGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
      () => TapGestureRecognizer(),
      (TapGestureRecognizer instance) {
        instance
          ..onTapDown = (TapDownDetails d) => log('down @ \${d.globalPosition}')
          ..onTapUp   = (TapUpDetails d)   => log('up   @ \${d.globalPosition}')
          ..onTap     = ()                 => log('tap')
          ..onTapCancel = ()               => log('cancel')
          ..onSecondaryTap = ()            => log('secondary')
          ..onTertiaryTapDown = (d)        => log('tertiary down');
      },
    ),
  },
  child: Container(width: 200, height: 60, color: Colors.indigo),
);''';

  final Widget codeCard = card(
    edge: cAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RawGestureDetector registration',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cBorder),
          ),
          child: const Text(
            codeSnippet,
            style: TextStyle(
              color: cText,
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 8: LIVE-CONSTRUCTION PANEL
  // =====================================================================
  final Color constructionEdge = constructionState == 'ok' ? cOk : cWarn;
  final Widget construction = card(
    edge: constructionEdge,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              constructionState == 'ok' ? Icons.bolt : Icons.error_outline,
              color: constructionEdge,
              size: 18,
            ),
            const SizedBox(width: 8),
            const Text(
              'Live construction probe',
              style: TextStyle(
                color: cText,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        kv('state', constructionState, color: constructionEdge),
        kv('runtimeType', runtimeLabel),
        kv('onTap before set', primaryNullBefore ? 'null' : 'non-null'),
        kv(
          'onTap after set',
          primaryNullAfter ? 'null' : 'non-null',
          color: primaryNullAfter ? cWarn : cOk,
        ),
        kv(
          'onSecondaryTap',
          secondaryNullAfter ? 'null' : 'non-null',
          color: secondaryNullAfter ? cWarn : cOk,
        ),
        kv(
          'onTertiaryTapDown',
          tertiaryNullAfter ? 'null' : 'non-null',
          color: tertiaryNullAfter ? cWarn : cOk,
        ),
        if (constructionError.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cWarn.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cWarn.withValues(alpha: 0.6)),
              ),
              child: Text(
                constructionError,
                style: const TextStyle(
                  color: cWarn,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ),
          ),
      ],
    ),
  );

  // =====================================================================
  // Section 9: CONSTANTS REFERENCE TABLE
  // =====================================================================
  Widget constantRow(String name, String value, String purpose) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: cBorder, width: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              name,
              style: const TextStyle(
                color: cAccent,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              value,
              style: const TextStyle(
                color: cSecondary,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              purpose,
              style: const TextStyle(color: cText, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  final Widget constants = card(
    edge: cSecondary,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Timing & slop constants',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        constantRow(
          'kPressTimeout',
          '100 ms',
          'Window after pointer-down within which onTapDown is fired.',
        ),
        constantRow(
          'kTouchSlop',
          '18.0 px',
          'Movement budget before tap is converted to drag.',
        ),
        constantRow(
          'kHoverTapTimeout',
          '150 ms',
          'Window for tap-from-hover (mouse) on PointerHover→Down→Up.',
        ),
        constantRow(
          'kHoverTapSlop',
          '20.0 px',
          'Slop for hover-tap; mouse pointers tolerate slightly more drift.',
        ),
        constantRow(
          'kLongPressTimeout',
          '500 ms',
          'Threshold where long-press recognizer wins instead.',
        ),
        constantRow(
          'kDoubleTapTimeout',
          '300 ms',
          'Window during which a second tap forms a double-tap.',
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 10: EDGE CASES
  // =====================================================================
  Widget edge(IconData icon, Color color, String title, String body) {
    return Container(
      width: 290,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cSurfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(color: cText, fontSize: 11.5, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget edgeCases = card(
    edge: cWarn,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edge cases',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            edge(
              Icons.swap_horiz,
              cWarn,
              'Drift past slop',
              'Pointer travels > kTouchSlop → onTapCancel; pan recognizer takes over.',
            ),
            edge(
              Icons.replay,
              cSecondary,
              'Double-down',
              'A second pointer arrives mid-track; the recognizer ignores it (PrimaryPointer logic).',
            ),
            edge(
              Icons.alt_route,
              cTertiary,
              'Cross-pointer button switch',
              'Same finger cannot change button mask mid-sequence; mask is locked at admit.',
            ),
            edge(
              Icons.timer_off,
              cWarn,
              'Held past long-press',
              'Recognizer yields; long-press wins arena and tap suppressed.',
            ),
            edge(
              Icons.do_not_touch,
              cMuted,
              'Disposed mid-sequence',
              'Calling dispose() while tracking nulls callbacks; no further events emitted.',
            ),
            edge(
              Icons.mouse,
              cSecondary,
              'Trackpad gestures',
              'Reported as kind=PointerDeviceKind.trackpad in Tap*Details.',
            ),
          ],
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 11: GestureDetector vs TapGestureRecognizer
  // =====================================================================
  Widget compareCol(String header, Color color, List<String> bullets) {
    final List<Widget> items = [];
    for (int i = 0; i < bullets.length; i++) {
      items.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.fiber_manual_record, color: color, size: 8),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  bullets[i],
                  style: const TextStyle(color: cText, fontSize: 12, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cSurfaceAlt,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.55)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            ...items,
          ],
        ),
      ),
    );
  }

  final Widget compare = card(
    edge: cTertiary,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'GestureDetector vs raw TapGestureRecognizer',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            compareCol('GestureDetector', cAccent, const [
              'High-level wrapper around several recognizers.',
              'Auto wires/disposes recognizers via internal state.',
              'Use for app-level tap, long-press, drag, scale, double-tap.',
              'Forces participation in default arena rules.',
            ]),
            const SizedBox(width: 10),
            compareCol('RawGestureDetector + Recognizer', cTertiary, const [
              'Pick exactly which recognizers participate.',
              'Custom factory/handler hooks for sharing instances.',
              'Required when extending Selectable / TextField semantics.',
              'You manage dispose() lifecycle manually.',
            ]),
          ],
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 12: SUMMARY METRICS STRIP (uses dart:math + dart:ui)
  // =====================================================================
  // Compute a few numeric facts so dart:math + dart:ui aren't unused.
  final double slopRadiusPx = math.sqrt(18.0 * 18.0); // == kTouchSlop
  final double pressTimeoutSec = 100.0 / 1000.0;
  final ui.Offset sampleOrigin = const ui.Offset(0, 0);
  final String sampleOriginText =
      '(${sampleOrigin.dx.toStringAsFixed(1)}, ${sampleOrigin.dy.toStringAsFixed(1)})';
  final double angleRad = math.pi / 4;

  Widget metric(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: cSurfaceAlt,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.55)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: color, fontSize: 10.5, letterSpacing: 0.4),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: cText,
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget metrics = card(
    edge: cAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Numeric summary',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            metric(
              'slop radius',
              '${slopRadiusPx.toStringAsFixed(1)} px',
              cAccent,
            ),
            const SizedBox(width: 8),
            metric(
              'press timeout',
              '${pressTimeoutSec.toStringAsFixed(2)} s',
              cSecondary,
            ),
            const SizedBox(width: 8),
            metric('sample origin', sampleOriginText, cTertiary),
            const SizedBox(width: 8),
            metric(
              'arena fan-out',
              '${(angleRad * 180 / math.pi).toStringAsFixed(0)}°',
              cOk,
            ),
          ],
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 13: TIMING DIAGRAM (per-callback timeline)
  // =====================================================================
  Widget timelineRow(
    String label,
    Color color,
    List<bool> ticks,
    String legend,
  ) {
    final List<Widget> cells = [];
    for (int i = 0; i < ticks.length; i++) {
      final bool active = ticks[i];
      cells.add(
        Container(
          width: 22,
          height: 22,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: active ? color.withValues(alpha: 0.85) : cBg,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: active ? color : cBorder,
              width: active ? 1.4 : 0.8,
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          ...cells,
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              legend,
              style: const TextStyle(color: cMuted, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  final Widget timelineLegendRow = Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 8),
    child: Row(
      children: [
        const SizedBox(width: 130),
        for (int i = 0; i < 8; i++)
          SizedBox(
            width: 26,
            child: Text(
              't${i + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: cMuted, fontSize: 10),
            ),
          ),
      ],
    ),
  );

  final Widget timeline = card(
    edge: cAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Per-callback timeline (8 ticks across one tap)',
          style: TextStyle(
            color: cText,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        timelineLegendRow,
        timelineRow(
          'PointerDown',
          cMuted,
          const [true, false, false, false, false, false, false, false],
          'arrival in arena',
        ),
        timelineRow(
          'onTapDown',
          cAccent,
          const [false, true, false, false, false, false, false, false],
          'after arena admit',
        ),
        timelineRow(
          'PointerMove',
          cMuted,
          const [false, false, true, true, false, false, false, false],
          'small drift inside slop',
        ),
        timelineRow(
          'PointerUp',
          cOk,
          const [false, false, false, false, false, true, false, false],
          'release inside window',
        ),
        timelineRow(
          'onTap',
          cAccent,
          const [false, false, false, false, false, false, true, false],
          'high-level fires first',
        ),
        timelineRow(
          'onTapUp',
          cAccent,
          const [false, false, false, false, false, false, false, true],
          'paired Up details',
        ),
      ],
    ),
  );

  // =====================================================================
  // Section 14: FOOTER
  // =====================================================================
  final Widget footer = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cSurface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cBorder),
    ),
    child: Row(
      children: [
        const Icon(Icons.info_outline, color: cMuted, size: 16),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'TapGestureRecognizer probe complete · runtime=$runtimeLabel · construction=$constructionState · '
            'see RawGestureDetector for fine-grained registration',
            style: const TextStyle(color: cMuted, fontSize: 11.5),
          ),
        ),
      ],
    ),
  );

  // =====================================================================
  // Final Scaffold
  // =====================================================================
  return Scaffold(
    backgroundColor: cBg,
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          hero,
          sectionTitle('Lifecycle', Icons.timeline, cAccent),
          lifecycle,
          sectionTitle('Callbacks', Icons.tune, cAccent),
          callbackGallery,
          sectionTitle('Details types', Icons.info, cSecondary),
          detailsTypes,
          sectionTitle('Button channels', Icons.mouse, cTertiary),
          buttons,
          sectionTitle('Arena interplay', Icons.account_tree, cOk),
          arena,
          sectionTitle('Wire-up', Icons.code, cAccent),
          codeCard,
          sectionTitle('Live probe', Icons.bolt, cOk),
          construction,
          sectionTitle('Constants', Icons.straighten, cSecondary),
          constants,
          sectionTitle('Edge cases', Icons.warning_amber, cWarn),
          edgeCases,
          sectionTitle('Detector vs raw', Icons.compare_arrows, cTertiary),
          compare,
          sectionTitle('Summary', Icons.calculate, cAccent),
          metrics,
          sectionTitle('Timeline', Icons.show_chart, cAccent),
          timeline,
          const SizedBox(height: 18),
          footer,
        ],
      ),
    ),
  );
}
