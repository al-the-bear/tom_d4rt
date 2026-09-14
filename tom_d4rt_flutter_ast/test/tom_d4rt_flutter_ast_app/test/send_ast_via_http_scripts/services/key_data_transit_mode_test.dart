// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
//
// Deep visual demo for `KeyDataTransitMode` from `package:flutter/services.dart`.
//
// `KeyDataTransitMode` is a (now-deprecated) enum that describes how Flutter's
// engine forwards key events from the platform up into the framework.  The two
// values are:
//
//   * `KeyDataTransitMode.rawKeyData`
//       The engine sends *only* the legacy platform key message JSON over the
//       method channel.  The framework's `KeyEventManager` synthesises modern
//       `KeyEvent`s from that raw blob.  This was the original transport used
//       before the new `ui.KeyData` channel existed.
//
//   * `KeyDataTransitMode.keyDataThenRawKeyData`
//       The engine first publishes a `ui.KeyData` packet (modern path) and
//       *then* the legacy raw message.  `KeyEventManager` uses the `KeyData`
//       for `KeyMessage.events` and the raw data only for `KeyMessage.rawEvent`.
//       This is the path used on engines that already speak the new protocol.
//
// The enum is annotated `@Deprecated('No longer supported. Transit mode is
// always key data only. This feature was deprecated after v3.18.0-2.0.pre.')`
// because the engine now always uses key-data-only transit, but it is still
// exported from `package:flutter/services.dart` so this file imports it
// directly (the file-level `deprecated_member_use` ignore covers the warning).
//
// D4RT-LIMITATION (C44): the d4rt bridge generator filters out symbols
// annotated `@Deprecated` by design (`generateDeprecatedElements = false`),
// so `KeyDataTransitMode` is not exposed to interpreted scripts — every
// `KeyDataTransitMode.values` / type-annotation access raised "Undefined
// variable: KeyDataTransitMode" under d4rt. To preserve the visual demo
// without resurrecting deprecated symbols on the bridge surface, this
// script declares a private `_KeyDataTransitMode` enum that mirrors the
// SDK enum's shape (same value names: `rawKeyData`, `keyDataThenRawKeyData`)
// and exercises that local stand-in for the demo's typed lookups. All
// human-readable copy continues to mention `KeyDataTransitMode` by name so
// the demo still documents the (former) SDK API surface.
//
// This file is hand-authored static visual content.  There are no tests, no
// `main()`, and no animation tickers — every animation uses
// `AlwaysStoppedAnimation<double>` and `Duration.zero` so the layout is
// completely deterministic for the AST-roundtrip corpus.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Local stand-in for the deprecated `KeyDataTransitMode` enum that the
// bridge generator filters out (see D4RT-LIMITATION note above). Same
// value names and ordering as the SDK enum so all demo copy referencing
// `.name` / `.index` stays accurate.
enum _KeyDataTransitMode {
  rawKeyData,
  keyDataThenRawKeyData,
}

// ---------------------------------------------------------------------------
// Public entry point.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'KeyDataTransitMode Deep Demo',
    home: Scaffold(
      backgroundColor: const Color(0xFFF4F2FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHero(),
              const SizedBox(height: 32.0),
              _buildAnatomyRouting(),
              const SizedBox(height: 32.0),
              _buildEnumValuesRow(),
              const SizedBox(height: 32.0),
              _buildRawKeyDataCard(),
              const SizedBox(height: 24.0),
              _buildKeyDataThenRawKeyDataCard(),
              const SizedBox(height: 32.0),
              _buildRecipeSection(),
              const SizedBox(height: 32.0),
              _buildPitfallsSection(),
              const SizedBox(height: 32.0),
              _buildComparisonTable(),
              const SizedBox(height: 32.0),
              _buildQuickReference(),
              const SizedBox(height: 32.0),
              _buildAsciiFooter(),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — Hero header
// ===========================================================================
Widget _buildHero() {
  // A static decorative animation; we use AlwaysStoppedAnimation so the
  // gradient pulse value is locked in for the AST snapshot.
  final Animation<double> pulse = const AlwaysStoppedAnimation<double>(0.65);

  return Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFF1E1B4B),
          const Color(0xFF4338CA),
          const Color(0xFF7C3AED),
        ],
        stops: const <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(24.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF4338CA).withValues(alpha: 0.45),
          blurRadius: 28.0,
          spreadRadius: 1.0,
          offset: const Offset(0.0, 14.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.20),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 88.0,
          height: 88.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.white.withValues(alpha: 0.30),
                Colors.white.withValues(alpha: 0.06),
              ],
            ),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.55),
              width: 1.5,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 12.0,
                offset: const Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: const <Widget>[
              Icon(Icons.keyboard_alt_outlined, size: 56.0, color: Colors.white),
              Positioned(
                right: 8.0,
                bottom: 6.0,
                child: Icon(Icons.alt_route, size: 22.0, color: Color(0xFFFDE68A)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 22.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'KeyDataTransitMode',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'How Flutter routes platform key events into the framework',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 14.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: <Widget>[
                  _heroChip('package:flutter/services.dart', Icons.inventory_2_outlined),
                  _heroChip('enum • 2 values', Icons.format_list_numbered),
                  _heroChip('deprecated', Icons.history_toggle_off, danger: true),
                  _heroChip('pulse=${pulse.value.toStringAsFixed(2)}', Icons.bolt),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _heroChip(String label, IconData icon, {bool danger = false}) {
  final Color base = danger ? const Color(0xFFFCA5A5) : Colors.white;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: base.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: base.withValues(alpha: 0.55), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14.0, color: base),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            color: base,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 2 — Anatomy of key event routing
// ===========================================================================
Widget _buildAnatomyRouting() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFFF8FAFC),
          const Color(0xFFE0E7FF),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: const Color(0xFFC7D2FE), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF6366F1).withValues(alpha: 0.12),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.account_tree_outlined, size: 22.0, color: Color(0xFF4338CA)),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of key event routing',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1B4B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'When you press a key, the engine has to decide *which* protocol it '
          'will use to forward the event to the framework.  KeyDataTransitMode '
          'names the two historically-supported answers.',
          style: TextStyle(fontSize: 12.5, color: Color(0xFF334155)),
        ),
        const SizedBox(height: 18.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _anatomyNode('Hardware', Icons.keyboard, const Color(0xFF1E40AF))),
            const SizedBox(width: 6.0),
            const _AnatomyArrow(label: 'OS event'),
            const SizedBox(width: 6.0),
            Expanded(child: _anatomyNode('Engine', Icons.memory, const Color(0xFF6D28D9))),
            const SizedBox(width: 6.0),
            const _AnatomyArrow(label: 'transit mode'),
            const SizedBox(width: 6.0),
            Expanded(child: _anatomyNode('KeyEventManager', Icons.settings_input_component, const Color(0xFFB45309))),
            const SizedBox(width: 6.0),
            const _AnatomyArrow(label: 'KeyMessage'),
            const SizedBox(width: 6.0),
            Expanded(child: _anatomyNode('Widgets', Icons.widgets_outlined, const Color(0xFF047857))),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: const Text(
            '• rawKeyData             ─ legacy: only the JSON method-channel "raw" message arrives.\n'
            '• keyDataThenRawKeyData  ─ modern: ui.KeyData arrives first, then the raw message follows.\n'
            'Both paths converge on KeyEventManager, which produces a single KeyMessage.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFF111827),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyNode(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.22),
        ],
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: color, size: 28.0),
        const SizedBox(height: 6.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    ),
  );
}

class _AnatomyArrow extends StatelessWidget {
  const _AnatomyArrow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(Icons.east, size: 22.0, color: Color(0xFF6B7280)),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9.5,
            color: Color(0xFF6B7280),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// SECTION 3 — Enum values overview row
// ===========================================================================
Widget _buildEnumValuesRow() {
  // Iterate the actual enum so that if the SDK adds a value the demo notices.
  final List<_KeyDataTransitMode> values = _KeyDataTransitMode.values;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const _SectionHeader(
        index: 3,
        title: 'Enum values at a glance',
        icon: Icons.list_alt,
        color: Color(0xFF0F766E),
      ),
      const SizedBox(height: 12.0),
      Row(
        children: <Widget>[
          Expanded(
            child: _enumValueTile(
              mode: values.firstWhere(
                (_KeyDataTransitMode m) => m.name == 'rawKeyData',
                orElse: () => _KeyDataTransitMode.values.first,
              ),
              accent: const Color(0xFFB91C1C),
              accentSoft: const Color(0xFFFEE2E2),
              icon: Icons.code,
              tagline: 'legacy raw method-channel only',
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: _enumValueTile(
              mode: values.firstWhere(
                (_KeyDataTransitMode m) => m.name == 'keyDataThenRawKeyData',
                orElse: () => _KeyDataTransitMode.values.last,
              ),
              accent: const Color(0xFF1D4ED8),
              accentSoft: const Color(0xFFDBEAFE),
              icon: Icons.swap_calls,
              tagline: 'ui.KeyData first, raw message second',
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _enumValueTile({
  required _KeyDataTransitMode mode,
  required Color accent,
  required Color accentSoft,
  required IconData icon,
  required String tagline,
}) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Colors.white, accentSoft],
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: accent, size: 22.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                mode.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: Text(
                'index ${mode.index}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          tagline,
          style: const TextStyle(fontSize: 12.0, color: Color(0xFF374151)),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 — Per-value deep dive: rawKeyData
// ===========================================================================
Widget _buildRawKeyDataCard() {
  final _KeyDataTransitMode mode = _KeyDataTransitMode.values.firstWhere(
    (_KeyDataTransitMode m) => m.name == 'rawKeyData',
    orElse: () => _KeyDataTransitMode.values.first,
  );
  const Color accent = Color(0xFFB91C1C);
  const Color soft = Color(0xFFFEE2E2);

  return _PerValueCard(
    mode: mode,
    accent: accent,
    soft: soft,
    headerIcon: Icons.code,
    title: 'Legacy: rawKeyData',
    description:
        'Engines that have not adopted the ui.KeyData protocol send only the '
        'platform "raw" key message JSON over the keyboard method channel.  '
        'The framework reconstructs modern KeyEvents from that blob.',
    flowDiagram: const _FlowDiagramRaw(),
    bulletPoints: const <String>[
      'Engine emits exactly one signal: SystemChannels.keyEvent.send(rawJson).',
      'KeyEventManager.handleRawKeyMessage() is the single entry point.',
      'KeyMessage.events is *synthesised* from the raw RawKeyEvent listener.',
      'KeyMessage.rawEvent is the original RawKeyEvent built from the JSON.',
      'Used historically; still legal, but the engine no longer chooses it.',
    ],
    snippet:
        '// Pseudo-flow when transit mode is rawKeyData:\n'
        '// (1) platform pushes JSON over the method channel\n'
        '// (2) KeyEventManager.handleRawKeyMessage(json) is invoked\n'
        '// (3) RawKeyboard converts JSON -> RawKeyEvent\n'
        '// (4) KeyEventManager listens to RawKeyboard and synthesises KeyEvents\n'
        '// (5) HardwareKeyboard.handleKeyEvent dispatches each KeyEvent\n'
        '// (6) A KeyMessage(events: [...], rawEvent: rkey) is delivered',
  );
}

// ===========================================================================
// SECTION 5 — Per-value deep dive: keyDataThenRawKeyData
// ===========================================================================
Widget _buildKeyDataThenRawKeyDataCard() {
  final _KeyDataTransitMode mode = _KeyDataTransitMode.values.firstWhere(
    (_KeyDataTransitMode m) => m.name == 'keyDataThenRawKeyData',
    orElse: () => _KeyDataTransitMode.values.last,
  );
  const Color accent = Color(0xFF1D4ED8);
  const Color soft = Color(0xFFDBEAFE);

  return _PerValueCard(
    mode: mode,
    accent: accent,
    soft: soft,
    headerIcon: Icons.swap_calls,
    title: 'Modern: keyDataThenRawKeyData',
    description:
        'Modern engines first push a ui.KeyData packet, then follow up with '
        'the legacy raw message.  KeyEventManager uses the KeyData for '
        'KeyMessage.events and the raw payload for KeyMessage.rawEvent — best '
        'of both worlds for backwards-compatible listeners.',
    flowDiagram: const _FlowDiagramModern(),
    bulletPoints: const <String>[
      'Engine emits ui.KeyData first via PlatformDispatcher.onKeyData.',
      'KeyEventManager.handleKeyData() accumulates the typed KeyEvent.',
      'A trailing 0/0 sentinel KeyData announces transit-mode inference.',
      'The legacy raw JSON arrives next; it populates KeyMessage.rawEvent.',
      'Listeners on RawKeyboard still fire — code stays backwards compatible.',
    ],
    snippet:
        '// Pseudo-flow when transit mode is keyDataThenRawKeyData:\n'
        '// (1) engine sends ui.KeyData(timestamp, type, physical, logical, ...)\n'
        '// (2) KeyEventManager.handleKeyData(kd) builds KeyEvent and stashes it\n'
        '// (3) engine then sends the legacy JSON over the method channel\n'
        '// (4) RawKeyboard converts JSON -> RawKeyEvent (for KeyMessage.rawEvent)\n'
        '// (5) KeyMessage(events: [...stashed], rawEvent: rkey) is delivered\n'
        '// (6) Both HardwareKeyboard and RawKeyboard listeners are satisfied',
  );
}

class _PerValueCard extends StatelessWidget {
  const _PerValueCard({
    required this.mode,
    required this.accent,
    required this.soft,
    required this.headerIcon,
    required this.title,
    required this.description,
    required this.flowDiagram,
    required this.bulletPoints,
    required this.snippet,
  });

  final _KeyDataTransitMode mode;
  final Color accent;
  final Color soft;
  final IconData headerIcon;
  final String title;
  final String description;
  final Widget flowDiagram;
  final List<String> bulletPoints;
  final String snippet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Colors.white, soft],
        ),
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.16),
            blurRadius: 18.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      accent.withValues(alpha: 0.18),
                      accent.withValues(alpha: 0.40),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: accent.withValues(alpha: 0.30),
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Icon(headerIcon, color: accent, size: 24.0),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'KeyDataTransitMode.${mode.name}  •  index=${mode.index}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: accent.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13.0,
              color: Color(0xFF1F2937),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18.0),
          flowDiagram,
          const SizedBox(height: 18.0),
          ...bulletPoints.map((String b) => _bullet(b, accent)),
          const SizedBox(height: 16.0),
          _CodeBlock(snippet: snippet, accent: accent),
        ],
      ),
    );
  }
}

Widget _bullet(String text, Color accent) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 5.0, right: 8.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[accent, accent.withValues(alpha: 0.45)],
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF111827),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.snippet, required this.accent});

  final String snippet;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF111827),
            const Color(0xFF1F2937),
          ],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.30),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Text(
        snippet,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: Color(0xFFE5E7EB),
          height: 1.5,
        ),
      ),
    );
  }
}

class _FlowDiagramRaw extends StatelessWidget {
  const _FlowDiagramRaw();

  @override
  Widget build(BuildContext context) {
    return _FlowFrame(
      title: 'Single-channel flow',
      accent: const Color(0xFFB91C1C),
      steps: const <_FlowStep>[
        _FlowStep('OS keypress', Icons.keyboard, Color(0xFF1F2937)),
        _FlowStep('Method channel\nraw JSON', Icons.cable, Color(0xFFB91C1C)),
        _FlowStep('RawKeyboard\nconverts', Icons.transform, Color(0xFFB45309)),
        _FlowStep('KeyEventManager\nsynthesises', Icons.auto_fix_high, Color(0xFF6D28D9)),
        _FlowStep('KeyMessage', Icons.markunread, Color(0xFF047857)),
      ],
    );
  }
}

class _FlowDiagramModern extends StatelessWidget {
  const _FlowDiagramModern();

  @override
  Widget build(BuildContext context) {
    return _FlowFrame(
      title: 'Two-channel flow',
      accent: const Color(0xFF1D4ED8),
      steps: const <_FlowStep>[
        _FlowStep('OS keypress', Icons.keyboard, Color(0xFF1F2937)),
        _FlowStep('ui.KeyData\nfirst', Icons.flash_on, Color(0xFF1D4ED8)),
        _FlowStep('Raw JSON\nsecond', Icons.cable, Color(0xFFB91C1C)),
        _FlowStep('KeyEventManager\nzips them', Icons.merge_type, Color(0xFF6D28D9)),
        _FlowStep('KeyMessage', Icons.markunread, Color(0xFF047857)),
      ],
    );
  }
}

class _FlowStep {
  const _FlowStep(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

class _FlowFrame extends StatelessWidget {
  const _FlowFrame({required this.title, required this.accent, required this.steps});

  final String title;
  final Color accent;
  final List<_FlowStep> steps;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowChildren = <Widget>[];
    for (int i = 0; i < steps.length; i++) {
      rowChildren.add(Expanded(child: _stepNode(steps[i])));
      if (i != steps.length - 1) {
        rowChildren.add(_arrow());
      }
    }
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: accent.withValues(alpha: 0.30), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.10),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: accent,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: rowChildren),
        ],
      ),
    );
  }

  Widget _stepNode(_FlowStep step) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: step.color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: step.color.withValues(alpha: 0.45), width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(step.icon, color: step.color, size: 22.0),
          const SizedBox(height: 6.0),
          Text(
            step.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
              color: step.color,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(Icons.arrow_forward_ios, size: 12.0, color: Color(0xFF9CA3AF)),
    );
  }
}

// ===========================================================================
// SECTION 6 — Recipes for keyboard handling
// ===========================================================================
Widget _buildRecipeSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const _SectionHeader(
        index: 6,
        title: 'Recipes — handling keys without caring about transit',
        icon: Icons.menu_book_outlined,
        color: Color(0xFF7C2D12),
      ),
      const SizedBox(height: 12.0),
      _recipeCard(
        recipeNumber: 1,
        title: 'Use HardwareKeyboard for modern key tracking',
        accent: const Color(0xFF1D4ED8),
        soft: const Color(0xFFEFF6FF),
        icon: Icons.keyboard_double_arrow_right,
        body: 'HardwareKeyboard offers a transit-mode-agnostic API. It exposes '
            'logicalKeysPressed, physicalKeysPressed, and a typed onKey stream.',
        snippet:
            'final HardwareKeyboard kb = HardwareKeyboard.instance;\n'
            'kb.addHandler((KeyEvent event) {\n'
            '  // Same shape regardless of KeyDataTransitMode.\n'
            '  return false; // not handled\n'
            '});',
      ),
      const SizedBox(height: 14.0),
      _recipeCard(
        recipeNumber: 2,
        title: 'Use Focus + KeyEvent for widget-local handling',
        accent: const Color(0xFF047857),
        soft: const Color(0xFFECFDF5),
        icon: Icons.center_focus_strong,
        body: 'Inside widgets, prefer Focus or KeyboardListener over RawKeyboard. '
            'They forward the same KeyEvent objects no matter which transit '
            'mode the engine chose.',
        snippet:
            'Focus(\n'
            '  onKeyEvent: (FocusNode node, KeyEvent event) {\n'
            '    if (event is KeyDownEvent &&\n'
            '        event.logicalKey == LogicalKeyboardKey.escape) {\n'
            '      return KeyEventResult.handled;\n'
            '    }\n'
            '    return KeyEventResult.ignored;\n'
            '  },\n'
            '  child: child,\n'
            ');',
      ),
      const SizedBox(height: 14.0),
      _recipeCard(
        recipeNumber: 3,
        title: 'Drop the legacy RawKeyboard when migrating',
        accent: const Color(0xFFB45309),
        soft: const Color(0xFFFFF7ED),
        icon: Icons.delete_sweep_outlined,
        body: 'RawKeyboard.instance still works for back-compat, but its API is '
            'tied to the legacy raw transit path.  Switch to HardwareKeyboard.',
        snippet:
            '// ❌ Old: tied to raw transit details.\n'
            '// RawKeyboard.instance.addListener(_onRaw);\n'
            '\n'
            '// ✅ New: works for both transit modes.\n'
            'HardwareKeyboard.instance.addHandler(_onKey);',
      ),
    ],
  );
}

Widget _recipeCard({
  required int recipeNumber,
  required String title,
  required Color accent,
  required Color soft,
  required IconData icon,
  required String body,
  required String snippet,
}) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Colors.white, soft],
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.14),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 32.0,
              height: 32.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$recipeNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Icon(icon, color: accent, size: 20.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          body,
          style: const TextStyle(fontSize: 12.5, color: Color(0xFF1F2937), height: 1.45),
        ),
        const SizedBox(height: 12.0),
        _CodeBlock(snippet: snippet, accent: accent),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 7 — Pitfalls
// ===========================================================================
Widget _buildPitfallsSection() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFFFFF1F2),
          const Color(0xFFFFE4E6),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: const Color(0xFFFCA5A5), width: 1.3),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFFB91C1C).withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.warning_amber_rounded, color: Color(0xFFB91C1C), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & gotchas',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF7F1D1D),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfallRow(
          'Do not branch on KeyDataTransitMode in production code.',
          'KeyEventManager picks the mode automatically — your handlers must '
          'work the same in both worlds.',
        ),
        _pitfallRow(
          'rawKeyData implies that ui.KeyData will never arrive.',
          'If you write a custom KeyEventManager subclass, do not call '
          'handleKeyData when the inferred mode is rawKeyData.',
        ),
        _pitfallRow(
          'keyDataThenRawKeyData expects a 0/0 sentinel KeyData.',
          'The empty sentinel marks transit-mode inference; treat it as a '
          'no-op rather than a real key.',
        ),
        _pitfallRow(
          'Both modes still produce KeyMessage.rawEvent.',
          'Migrating off RawKeyboard listeners is recommended, but rawEvent '
          'remains populated for backwards compatibility.',
        ),
        _pitfallRow(
          'KeyDataTransitMode itself is deprecated.',
          'New engines always use key-data transit; treat the enum as historical '
          'documentation, not a runtime knob.',
        ),
      ],
    ),
  );
}

Widget _pitfallRow(String headline, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFFCA5A5).withValues(alpha: 0.6)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 1.0, right: 8.0),
            child: Icon(Icons.error_outline, size: 18.0, color: Color(0xFFB91C1C)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  headline,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7F1D1D),
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  body,
                  style: const TextStyle(fontSize: 11.5, color: Color(0xFF374151), height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 8 — Comparison table
// ===========================================================================
Widget _buildComparisonTable() {
  final List<_KeyDataTransitMode> values = _KeyDataTransitMode.values;

  final List<List<String>> rows = <List<String>>[
    <String>['Channel(s) used', 'Method channel only', 'ui.KeyData + method channel'],
    <String>['KeyMessage.events', 'Synthesised from RawKeyEvent', 'Built from ui.KeyData'],
    <String>['KeyMessage.rawEvent', 'Built from JSON', 'Built from JSON'],
    <String>['Order of arrival', '— single signal —', 'KeyData first, raw second'],
    <String>['Engine support', 'Legacy engines', 'Modern engines'],
    <String>['Inferred when', 'handleRawKeyMessage runs first', 'handleKeyData runs first'],
    <String>['Sentinel needed?', 'No', 'Yes (0/0 KeyData)'],
    <String>['Recommended for new code?', 'No (use HardwareKeyboard)', 'No (use HardwareKeyboard)'],
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const _SectionHeader(
        index: 8,
        title: 'Comparison table',
        icon: Icons.table_chart_outlined,
        color: Color(0xFF334155),
      ),
      const SizedBox(height: 12.0),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            // Header row.
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    const Color(0xFF1E293B),
                    const Color(0xFF334155),
                  ],
                ),
              ),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'Aspect',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      values.first.name,
                      style: const TextStyle(
                        color: Color(0xFFFCA5A5),
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      values.last.name,
                      style: const TextStyle(
                        color: Color(0xFF93C5FD),
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < rows.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: i.isEven ? const Color(0xFFF8FAFC) : Colors.white,
                  border: const Border(
                    bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                        rows[i][0],
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        rows[i][1],
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF7F1D1D),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        rows[i][2],
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
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

// ===========================================================================
// SECTION 9 — Quick reference
// ===========================================================================
Widget _buildQuickReference() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFFECFEFF),
          const Color(0xFFCFFAFE),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: const Color(0xFF22D3EE), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0891B2).withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.bookmarks_outlined, color: Color(0xFF0E7490), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF155E75),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _quickRow('Library', 'package:flutter/services.dart'),
        _quickRow('Source path', 'src/services/hardware_keyboard.dart'),
        _quickRow('Kind', 'enum (deprecated)'),
        _quickRow('Values', _KeyDataTransitMode.values.map((_KeyDataTransitMode m) => m.name).join(', ')),
        _quickRow('Used by', 'KeyEventManager._transitMode'),
        _quickRow('Dispatched on', 'HardwareKeyboard, RawKeyboard, KeyMessage'),
        _quickRow('Replacement', 'HardwareKeyboard / Focus.onKeyEvent'),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFF67E8F9)),
          ),
          child: const Text(
            '"No longer supported. Transit mode is always key data only. '
            'This feature was deprecated after v3.18.0-2.0.pre."',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 11.5,
              color: Color(0xFF155E75),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _quickRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0E7490),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFF111827),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10 — ASCII footer
// ===========================================================================
Widget _buildAsciiFooter() {
  const String ascii =
      '+--------------------------------------------------------------+\n'
      '|  KeyDataTransitMode — engine -> framework key event routing  |\n'
      '+--------------------------------------------------------------+\n'
      '|                                                              |\n'
      '|   rawKeyData               keyDataThenRawKeyData             |\n'
      '|   ───────────              ──────────────────────            |\n'
      '|   [JSON only] ──┐          [ui.KeyData] ──┐                  |\n'
      '|                 │                          │                 |\n'
      '|                 ▼                          ▼                 |\n'
      '|         RawKeyboard ──► KeyEventManager ◄── method channel   |\n'
      '|                                  │                           |\n'
      '|                                  ▼                           |\n'
      '|                            KeyMessage(events, rawEvent)      |\n'
      '|                                                              |\n'
      '+--------------------------------------------------------------+\n'
      '|   deprecated after v3.18.0-2.0.pre — modern engines pick it  |\n'
      '+--------------------------------------------------------------+';

  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          const Color(0xFF0F172A),
          const Color(0xFF111827),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF475569), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.40),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        ascii,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          color: Color(0xFFCBD5E1),
          height: 1.35,
        ),
      ),
    ),
  );
}

// ===========================================================================
// Shared helpers
// ===========================================================================
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.icon,
    required this.color,
  });

  final int index;
  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 30.0,
          height: 30.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[color, color.withValues(alpha: 0.55)],
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.30),
                blurRadius: 6.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 13.0,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Icon(icon, color: color, size: 20.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
