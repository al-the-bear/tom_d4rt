// Deep visual demo for KeyEvent / KeyDownEvent / KeyUpEvent / KeyRepeatEvent / LogicalKeyboardKey / PhysicalKeyboardKey.
// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "IDE Keyboard Reference",
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFF0E1117),
      fontFamily: "RobotoMono",
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFF0E1117),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _HeroSection(),
              SizedBox(height: 20),
              _IntroSection(),
              SizedBox(height: 20),
              _EventTypeMatrixSection(),
              SizedBox(height: 20),
              _ShortcutGallerySection(),
              SizedBox(height: 20),
              _ModifierPanelSection(),
              SizedBox(height: 20),
              _PhysicalVsLogicalSection(),
              SizedBox(height: 20),
              _RepeatHandlingSection(),
              SizedBox(height: 20),
              _FocusTraversalSection(),
              SizedBox(height: 20),
              _AccessibilityNotesSection(),
              SizedBox(height: 20),
              _CheatSheetSection(),
              SizedBox(height: 20),
              _FooterSection(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// HERO SECTION — top banner introducing the keyboard reference.
// =============================================================================
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final space = LogicalKeyboardKey.space;
    final enter = LogicalKeyboardKey.enter;
    final escape = LogicalKeyboardKey.escape;
    final tab = LogicalKeyboardKey.tab;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A237E),
            Color(0xFF311B92),
            Color(0xFF4A148C),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.35),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 1.2,
                  ),
                ),
                child: const Icon(
                  Icons.keyboard_alt_outlined,
                  size: 42,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Flutter KeyEvent Reference",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: Colors.white.withValues(alpha: 0.98),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "package:flutter/services.dart // Hardware keyboard event model",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.greenAccent.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.bolt,
                      color: Colors.greenAccent,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Row(
              children: [
                _HeroStat(
                  label: "space.keyId",
                  value: "0x${space.keyId.toRadixString(16)}",
                  accent: Colors.cyanAccent,
                ),
                const SizedBox(width: 24),
                _HeroStat(
                  label: "enter.keyLabel",
                  value: '"${enter.keyLabel}"',
                  accent: Colors.amberAccent,
                ),
                const SizedBox(width: 24),
                _HeroStat(
                  label: "escape.debugName",
                  value: escape.debugName ?? "Escape",
                  accent: Colors.pinkAccent,
                ),
                const SizedBox(width: 24),
                _HeroStat(
                  label: "tab.runtimeType",
                  value: tab.runtimeType.toString(),
                  accent: Colors.lightGreenAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;

  const _HeroStat({
    required this.label,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.55),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: accent,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// INTRO SECTION — explanation card.
// =============================================================================
class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "About this reference",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "v3.27+",
                  style: TextStyle(
                    color: Colors.indigoAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Flutter exposes a unified hardware keyboard event model through the KeyEvent class hierarchy. This reference card walks through the three concrete event subtypes, the modifier handling rules, and the distinction between logical and physical key identifiers.",
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.white.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              _IntroPill(
                icon: Icons.layers_outlined,
                label: "KeyEvent",
                color: Colors.cyanAccent,
              ),
              SizedBox(width: 10),
              _IntroPill(
                icon: Icons.arrow_downward,
                label: "KeyDownEvent",
                color: Colors.greenAccent,
              ),
              SizedBox(width: 10),
              _IntroPill(
                icon: Icons.arrow_upward,
                label: "KeyUpEvent",
                color: Colors.orangeAccent,
              ),
              SizedBox(width: 10),
              _IntroPill(
                icon: Icons.repeat,
                label: "KeyRepeatEvent",
                color: Colors.pinkAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IntroPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _IntroPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
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
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// EVENT TYPE MATRIX — KeyDownEvent vs KeyUpEvent vs KeyRepeatEvent comparison.
// =============================================================================
class _EventTypeMatrixSection extends StatelessWidget {
  const _EventTypeMatrixSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1B5E20),
            Color(0xFF0D3D14),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.greenAccent.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 8),
            child: Row(
              children: [
                const Icon(
                  Icons.compare_arrows,
                  color: Colors.greenAccent,
                  size: 22,
                ),
                const SizedBox(width: 10),
                const Text(
                  "Event Type Matrix",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  "KeyEvent subclasses",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const _EventMatrixHeader(),
          const _EventMatrixRow(
            attribute: "Fired when",
            down: "Key is first pressed",
            up: "Key is released",
            repeat: "Key is held past initial delay",
          ),
          const _EventMatrixRow(
            attribute: "character",
            down: "Resolved (e.g. \"a\")",
            up: "null",
            repeat: "Resolved (e.g. \"a\")",
          ),
          const _EventMatrixRow(
            attribute: "synthesized",
            down: "false typically",
            up: "false typically",
            repeat: "false typically",
          ),
          const _EventMatrixRow(
            attribute: "logicalKey",
            down: "LogicalKeyboardKey",
            up: "LogicalKeyboardKey",
            repeat: "LogicalKeyboardKey",
          ),
          const _EventMatrixRow(
            attribute: "physicalKey",
            down: "PhysicalKeyboardKey",
            up: "PhysicalKeyboardKey",
            repeat: "PhysicalKeyboardKey",
          ),
          const _EventMatrixRow(
            attribute: "Typical use",
            down: "Shortcut triggering",
            up: "Release-driven UI",
            repeat: "Auto-repeat text input",
          ),
          const _EventMatrixRow(
            attribute: "Subclass of",
            down: "KeyEvent",
            up: "KeyEvent",
            repeat: "KeyEvent",
            isLast: true,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.32),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.greenAccent.withValues(alpha: 0.18),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.greenAccent,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'All three subtypes share a "timeStamp" Duration relative to engine start. They are dispatched through HardwareKeyboard.instance and surfaced to widgets via Focus / KeyboardListener / Shortcuts.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.78),
                        fontSize: 12.5,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventMatrixHeader extends StatelessWidget {
  const _EventMatrixHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        border: Border(
          bottom: BorderSide(
            color: Colors.greenAccent.withValues(alpha: 0.25),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Attribute",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.55),
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "KeyDownEvent",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.greenAccent.withValues(alpha: 0.9),
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "KeyUpEvent",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.orangeAccent.withValues(alpha: 0.9),
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "KeyRepeatEvent",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.pinkAccent.withValues(alpha: 0.9),
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventMatrixRow extends StatelessWidget {
  final String attribute;
  final String down;
  final String up;
  final String repeat;
  final bool isLast;

  const _EventMatrixRow({
    required this.attribute,
    required this.down,
    required this.up,
    required this.repeat,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.05),
                  width: 1,
                ),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              attribute,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.white.withValues(alpha: 0.85),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              down,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              up,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              repeat,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SHORTCUT GALLERY — visual key glyphs and common IDE shortcuts.
// =============================================================================
class _ShortcutGallerySection extends StatelessWidget {
  const _ShortcutGallerySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF263238),
            Color(0xFF1A2327),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.cyanAccent.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.dashboard_customize_outlined,
                color: Colors.cyanAccent,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                "Shortcut Gallery",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "12 BINDINGS",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: const [
              _ShortcutCard(
                action: "Save",
                keys: ["Ctrl", "S"],
                color: Color(0xFF00BCD4),
                icon: Icons.save_outlined,
              ),
              _ShortcutCard(
                action: "Command Palette",
                keys: ["Cmd", "Shift", "P"],
                color: Color(0xFFE91E63),
                icon: Icons.terminal_outlined,
              ),
              _ShortcutCard(
                action: "Toggle DevTools",
                keys: ["F12"],
                color: Color(0xFFFFC107),
                icon: Icons.bug_report_outlined,
              ),
              _ShortcutCard(
                action: "Find in Files",
                keys: ["Ctrl", "Shift", "F"],
                color: Color(0xFF8BC34A),
                icon: Icons.search,
              ),
              _ShortcutCard(
                action: "Go to Definition",
                keys: ["F12"],
                color: Color(0xFF9C27B0),
                icon: Icons.gps_fixed,
              ),
              _ShortcutCard(
                action: "Rename Symbol",
                keys: ["F2"],
                color: Color(0xFF03A9F4),
                icon: Icons.drive_file_rename_outline,
              ),
              _ShortcutCard(
                action: "Run / Continue",
                keys: ["F5"],
                color: Color(0xFF4CAF50),
                icon: Icons.play_arrow,
              ),
              _ShortcutCard(
                action: "Step Over",
                keys: ["F10"],
                color: Color(0xFFFF5722),
                icon: Icons.skip_next,
              ),
              _ShortcutCard(
                action: "Comment Line",
                keys: ["Ctrl", "/"],
                color: Color(0xFF607D8B),
                icon: Icons.comment_outlined,
              ),
              _ShortcutCard(
                action: "Format Document",
                keys: ["Alt", "Shift", "F"],
                color: Color(0xFF795548),
                icon: Icons.format_align_left,
              ),
              _ShortcutCard(
                action: "Toggle Sidebar",
                keys: ["Ctrl", "B"],
                color: Color(0xFF673AB7),
                icon: Icons.view_sidebar_outlined,
              ),
              _ShortcutCard(
                action: "Quit Application",
                keys: ["Cmd", "Q"],
                color: Color(0xFFF44336),
                icon: Icons.power_settings_new,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  final String action;
  final List<String> keys;
  final Color color;
  final IconData icon;

  const _ShortcutCard({
    required this.action,
    required this.keys,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  action,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: _buildKeyGlyphs(keys, color),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildKeyGlyphs(List<String> keys, Color color) {
    final widgets = <Widget>[];
    for (var i = 0; i < keys.length; i++) {
      widgets.add(_KeyGlyph(label: keys[i], color: color));
      if (i < keys.length - 1) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              "+",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    }
    return widgets;
  }
}

class _KeyGlyph extends StatelessWidget {
  final String label;
  final Color color;

  const _KeyGlyph({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            offset: const Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =============================================================================
// MODIFIER PANEL — Ctrl/Shift/Alt/Meta with logical key references.
// =============================================================================
class _ModifierPanelSection extends StatelessWidget {
  const _ModifierPanelSection();

  @override
  Widget build(BuildContext context) {
    final shiftLeft = LogicalKeyboardKey.shiftLeft;
    final shiftRight = LogicalKeyboardKey.shiftRight;
    final controlLeft = LogicalKeyboardKey.controlLeft;
    final controlRight = LogicalKeyboardKey.controlRight;
    final altLeft = LogicalKeyboardKey.altLeft;
    final altRight = LogicalKeyboardKey.altRight;
    final metaLeft = LogicalKeyboardKey.metaLeft;
    final metaRight = LogicalKeyboardKey.metaRight;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3E2723),
            Color(0xFF4E342E),
            Color(0xFF5D4037),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.orangeAccent.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.tune,
                color: Colors.orangeAccent,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                "Modifier Key Matrix",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                "left / right discrimination",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _ModifierRow(
            family: "Shift",
            color: Colors.amberAccent,
            leftKey: shiftLeft,
            rightKey: shiftRight,
            commonUse: "Capitalization, selection extension",
          ),
          const SizedBox(height: 10),
          _ModifierRow(
            family: "Control",
            color: Colors.cyanAccent,
            leftKey: controlLeft,
            rightKey: controlRight,
            commonUse: "Primary shortcut modifier on Windows/Linux",
          ),
          const SizedBox(height: 10),
          _ModifierRow(
            family: "Alt / Option",
            color: Colors.greenAccent,
            leftKey: altLeft,
            rightKey: altRight,
            commonUse: "Menu activation, word-level navigation",
          ),
          const SizedBox(height: 10),
          _ModifierRow(
            family: "Meta / Cmd / Win",
            color: Colors.pinkAccent,
            leftKey: metaLeft,
            rightKey: metaRight,
            commonUse: "Primary shortcut modifier on macOS",
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.orangeAccent.withValues(alpha: 0.18),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.orangeAccent,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Use HardwareKeyboard.instance.logicalKeysPressed.contains(...) to query the modifier state at any time. For example, isMetaPressed checks both metaLeft and metaRight transparently.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.78),
                      fontSize: 12.5,
                      height: 1.5,
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
}

class _ModifierRow extends StatelessWidget {
  final String family;
  final Color color;
  final LogicalKeyboardKey leftKey;
  final LogicalKeyboardKey rightKey;
  final String commonUse;

  const _ModifierRow({
    required this.family,
    required this.color,
    required this.leftKey,
    required this.rightKey,
    required this.commonUse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  family,
                  style: TextStyle(
                    color: color,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  commonUse,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 10.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _ModifierKeyCell(
                    label: leftKey.debugName ?? "left",
                    keyId: leftKey.keyId,
                    color: color,
                    side: "L",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ModifierKeyCell(
                    label: rightKey.debugName ?? "right",
                    keyId: rightKey.keyId,
                    color: color,
                    side: "R",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModifierKeyCell extends StatelessWidget {
  final String label;
  final int keyId;
  final Color color;
  final String side;

  const _ModifierKeyCell({
    required this.label,
    required this.keyId,
    required this.color,
    required this.side,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withValues(alpha: 0.6)),
            ),
            alignment: Alignment.center,
            child: Text(
              side,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "0x${keyId.toRadixString(16)}",
                  style: TextStyle(
                    color: color.withValues(alpha: 0.85),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// PHYSICAL VS LOGICAL — disambiguation panel with paired comparison rows.
// =============================================================================
class _PhysicalVsLogicalSection extends StatelessWidget {
  const _PhysicalVsLogicalSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0D47A1),
            Color(0xFF01579B),
            Color(0xFF006064),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.compare,
                color: Colors.lightBlueAccent,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                "Physical vs Logical",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "key identity",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _IdentityPanel(
                  title: "PhysicalKeyboardKey",
                  subtitle: "Where the key is on the board",
                  color: Colors.lightBlueAccent,
                  icon: Icons.keyboard_outlined,
                  bullets: const [
                    "USB HID usage code (stable per OS)",
                    "Independent of layout (QWERTY / AZERTY / Dvorak)",
                    "Identifies the physical location of a switch",
                    "Useful for game-style WASD bindings",
                    "Compare with PhysicalKeyboardKey.keyA",
                  ],
                  examples: const [
                    _IdentityRow(
                      label: "keyW",
                      value: "PhysicalKeyboardKey.keyW",
                    ),
                    _IdentityRow(
                      label: "arrowLeft",
                      value: "PhysicalKeyboardKey.arrowLeft",
                    ),
                    _IdentityRow(
                      label: "f1",
                      value: "PhysicalKeyboardKey.f1",
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _IdentityPanel(
                  title: "LogicalKeyboardKey",
                  subtitle: "What the key represents",
                  color: Colors.cyanAccent,
                  icon: Icons.translate,
                  bullets: const [
                    "Layout-aware mapping after OS translation",
                    "Reflects active keyboard layout / locale",
                    "Has a keyLabel for printable keys",
                    "Used by Shortcuts / Intent system",
                    "Compare with LogicalKeyboardKey.keyA",
                  ],
                  examples: const [
                    _IdentityRow(
                      label: "keyW",
                      value: "LogicalKeyboardKey.keyW",
                    ),
                    _IdentityRow(
                      label: "arrowLeft",
                      value: "LogicalKeyboardKey.arrowLeft",
                    ),
                    _IdentityRow(
                      label: "f1",
                      value: "LogicalKeyboardKey.f1",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.cyanAccent,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Rule of thumb",
                      style: TextStyle(
                        color: Colors.cyanAccent.withValues(alpha: 0.95),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Use PhysicalKeyboardKey for "this key, regardless of label" (game movement, position-based bindings). Use LogicalKeyboardKey for "this character / function" (text shortcuts, IDE actions, semantic intent).',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 12.5,
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
}

class _IdentityPanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final List<String> bullets;
  final List<_IdentityRow> examples;

  const _IdentityPanel({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.bullets,
    required this.examples,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.fiber_manual_record,
                    size: 7,
                    color: color.withValues(alpha: 0.8),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 1,
            color: color.withValues(alpha: 0.18),
          ),
          const SizedBox(height: 10),
          ...examples.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        e.label,
                        style: TextStyle(
                          color: color,
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        e.value,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.78),
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _IdentityRow {
  final String label;
  final String value;
  const _IdentityRow({required this.label, required this.value});
}

// =============================================================================
// REPEAT HANDLING — visualization of repeat event lifecycle.
// =============================================================================
class _RepeatHandlingSection extends StatelessWidget {
  const _RepeatHandlingSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF880E4F),
            Color(0xFFAD1457),
            Color(0xFF6A1B9A),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.repeat,
                color: Colors.pinkAccent,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                "Repeat Event Lifecycle",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                "OS auto-repeat semantics",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: const [
                _TimelineEntry(
                  time: "t=0ms",
                  label: "Key pressed",
                  event: "KeyDownEvent",
                  detail: "character resolved, modifiers latched",
                  color: Colors.greenAccent,
                  isFirst: true,
                ),
                _TimelineEntry(
                  time: "t=500ms",
                  label: "Initial delay elapsed",
                  event: "KeyRepeatEvent",
                  detail: "first auto-repeat fires (OS-tuned)",
                  color: Colors.pinkAccent,
                ),
                _TimelineEntry(
                  time: "t=530ms",
                  label: "Repeat cycle",
                  event: "KeyRepeatEvent",
                  detail: "subsequent repeats at ~30ms cadence",
                  color: Colors.pinkAccent,
                ),
                _TimelineEntry(
                  time: "t=560ms",
                  label: "Repeat cycle",
                  event: "KeyRepeatEvent",
                  detail: "continues while held",
                  color: Colors.pinkAccent,
                ),
                _TimelineEntry(
                  time: "t=820ms",
                  label: "Key released",
                  event: "KeyUpEvent",
                  detail: "character is null, modifiers cleared",
                  color: Colors.orangeAccent,
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _RepeatNoteCard(
                  title: "Debounce text input",
                  icon: Icons.edit_outlined,
                  body: "TextField treats KeyDownEvent and KeyRepeatEvent identically for character insertion.",
                  color: Colors.amberAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RepeatNoteCard(
                  title: "Ignore for shortcuts",
                  icon: Icons.shortcut,
                  body: "Shortcut dispatch typically ignores KeyRepeatEvent to avoid re-triggering commands.",
                  color: Colors.cyanAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RepeatNoteCard(
                  title: "Game-loop polling",
                  icon: Icons.sports_esports,
                  body: "Games typically poll HardwareKeyboard.logicalKeysPressed instead of reacting to repeats.",
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  final String time;
  final String label;
  final String event;
  final String detail;
  final Color color;
  final bool isFirst;
  final bool isLast;

  const _TimelineEntry({
    required this.time,
    required this.label,
    required this.event,
    required this.detail,
    required this.color,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 11.5,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 2,
                height: 6,
                color: isFirst ? Colors.transparent : color.withValues(alpha: 0.4),
              ),
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.3),
                  border: Border.all(color: color, width: 2),
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: isLast ? Colors.transparent : color.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: color.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          event,
                          style: TextStyle(
                            color: color,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    detail,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RepeatNoteCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String body;
  final Color color;

  const _RepeatNoteCard({
    required this.title,
    required this.icon,
    required this.body,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// FOCUS TRAVERSAL — overview of Tab / Shift-Tab / directional traversal.
// =============================================================================
class _FocusTraversalSection extends StatelessWidget {
  const _FocusTraversalSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF004D40),
            Color(0xFF00695C),
            Color(0xFF00796B),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.swap_horiz,
                color: Colors.tealAccent,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                "Focus Traversal Keys",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.tealAccent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "FocusTraversalPolicy",
                  style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _TraversalCard(
                  title: "Forward",
                  keys: const ["Tab"],
                  color: Colors.tealAccent,
                  icon: Icons.arrow_forward,
                  body: "Moves focus to the next focusable widget in the traversal order.",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TraversalCard(
                  title: "Backward",
                  keys: const ["Shift", "Tab"],
                  color: Colors.cyanAccent,
                  icon: Icons.arrow_back,
                  body: "Moves focus to the previous focusable widget in the traversal order.",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TraversalCard(
                  title: "Activate",
                  keys: const ["Enter"],
                  color: Colors.amberAccent,
                  icon: Icons.touch_app_outlined,
                  body: "Activates the currently focused control, similar to a tap.",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _TraversalCard(
                  title: "Dismiss",
                  keys: const ["Esc"],
                  color: Colors.pinkAccent,
                  icon: Icons.cancel_outlined,
                  body: "Dismisses dialogs, menus, and modal surfaces.",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TraversalCard(
                  title: "Move Up",
                  keys: const ["Arrow Up"],
                  color: Colors.lightGreenAccent,
                  icon: Icons.keyboard_arrow_up,
                  body: "Directional focus traversal upward in spatial groups.",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TraversalCard(
                  title: "Move Down",
                  keys: const ["Arrow Down"],
                  color: Colors.lightBlueAccent,
                  icon: Icons.keyboard_arrow_down,
                  body: "Directional focus traversal downward in spatial groups.",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Default mapping (WidgetsApp defaultShortcuts)",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                _MappingLine(
                  trigger: "LogicalKeyboardKey.tab",
                  intent: "NextFocusIntent",
                ),
                _MappingLine(
                  trigger: "LogicalKeyboardKey.tab + shift",
                  intent: "PreviousFocusIntent",
                ),
                _MappingLine(
                  trigger: "LogicalKeyboardKey.enter",
                  intent: "ActivateIntent",
                ),
                _MappingLine(
                  trigger: "LogicalKeyboardKey.space",
                  intent: "ActivateIntent",
                ),
                _MappingLine(
                  trigger: "LogicalKeyboardKey.escape",
                  intent: "DismissIntent",
                ),
                _MappingLine(
                  trigger: "LogicalKeyboardKey.arrowUp",
                  intent: "DirectionalFocusIntent(up)",
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TraversalCard extends StatelessWidget {
  final String title;
  final List<String> keys;
  final Color color;
  final IconData icon;
  final String body;

  const _TraversalCard({
    required this.title,
    required this.keys,
    required this.color,
    required this.icon,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            children: keys.map((k) => _KeyGlyph(label: k, color: color)).toList(),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _MappingLine extends StatelessWidget {
  final String trigger;
  final String intent;
  final bool isLast;

  const _MappingLine({
    required this.trigger,
    required this.intent,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              trigger,
              style: TextStyle(
                color: Colors.tealAccent.withValues(alpha: 0.9),
                fontSize: 12,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_right_alt,
            color: Colors.white24,
            size: 16,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              intent,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// ACCESSIBILITY NOTES — semantics and a11y guidance for keyboard users.
// =============================================================================
class _AccessibilityNotesSection extends StatelessWidget {
  const _AccessibilityNotesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.deepPurpleAccent.withValues(alpha: 0.22),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.accessibility_new,
                  color: Colors.deepPurpleAccent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Accessibility Notes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                "WCAG 2.1 keyboard guidance",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _A11yPoint(
                  number: "01",
                  title: "Every interactive widget must be reachable via keyboard",
                  body: "Audit your Focus tree: any tap target should have a corresponding keyboard path through Tab / arrow keys.",
                  color: Colors.deepPurpleAccent,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _A11yPoint(
                  number: "02",
                  title: "Provide a visible focus indicator",
                  body: "Default Material themes render a focus ring; preserve or replace it intentionally, never disable it silently.",
                  color: Colors.purpleAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _A11yPoint(
                  number: "03",
                  title: "Esc should always dismiss",
                  body: "Wire DismissIntent in dialogs, popovers, dropdowns. Users should never feel trapped.",
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _A11yPoint(
                  number: "04",
                  title: "Avoid keyboard-only behavior conflicts",
                  body: "Do not consume universal shortcuts (Tab, Esc, Enter) unless the widget genuinely requires it (e.g. a code editor surface).",
                  color: Colors.indigoAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.withValues(alpha: 0.32),
                  Colors.indigo.withValues(alpha: 0.32),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.deepPurpleAccent.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.deepPurpleAccent,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Test plan: walk your UI without a mouse. If you cannot reach a control or cannot tell what is focused, the UI is not yet accessible.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12.5,
                      height: 1.5,
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
}

class _A11yPoint extends StatelessWidget {
  final String number;
  final String title;
  final String body;
  final Color color;

  const _A11yPoint({
    required this.number,
    required this.title,
    required this.body,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                number,
                style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// CHEAT SHEET — compact final reference with categorized key listings.
// =============================================================================
class _CheatSheetSection extends StatelessWidget {
  const _CheatSheetSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF212121),
            Color(0xFF0E1117),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.menu_book_outlined,
                color: Colors.amberAccent,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                "Cheat Sheet",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                "LogicalKeyboardKey constants",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _CheatColumn(
                  title: "Editing",
                  color: Colors.amberAccent,
                  entries: [
                    _CheatEntry("backspace", LogicalKeyboardKey.backspace),
                    _CheatEntry("delete", LogicalKeyboardKey.delete),
                    _CheatEntry("enter", LogicalKeyboardKey.enter),
                    _CheatEntry("tab", LogicalKeyboardKey.tab),
                    _CheatEntry("space", LogicalKeyboardKey.space),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _CheatColumn(
                  title: "Navigation",
                  color: Colors.cyanAccent,
                  entries: [
                    _CheatEntry("arrowUp", LogicalKeyboardKey.arrowUp),
                    _CheatEntry("arrowDown", LogicalKeyboardKey.arrowDown),
                    _CheatEntry("arrowLeft", LogicalKeyboardKey.arrowLeft),
                    _CheatEntry("arrowRight", LogicalKeyboardKey.arrowRight),
                    _CheatEntry("home", LogicalKeyboardKey.home),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _CheatColumn(
                  title: "Function",
                  color: Colors.pinkAccent,
                  entries: [
                    _CheatEntry("f1", LogicalKeyboardKey.f1),
                    _CheatEntry("f2", LogicalKeyboardKey.f2),
                    _CheatEntry("f5", LogicalKeyboardKey.f5),
                    _CheatEntry("f10", LogicalKeyboardKey.f10),
                    _CheatEntry("f12", LogicalKeyboardKey.f12),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _CheatColumn(
                  title: "Control",
                  color: Colors.greenAccent,
                  entries: [
                    _CheatEntry("escape", LogicalKeyboardKey.escape),
                    _CheatEntry("pageUp", LogicalKeyboardKey.pageUp),
                    _CheatEntry("pageDown", LogicalKeyboardKey.pageDown),
                    _CheatEntry("end", LogicalKeyboardKey.end),
                    _CheatEntry("insert", LogicalKeyboardKey.insert),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CheatEntry {
  final String name;
  final LogicalKeyboardKey key;
  const _CheatEntry(this.name, this.key);
}

class _CheatColumn extends StatelessWidget {
  final String title;
  final Color color;
  final List<_CheatEntry> entries;

  const _CheatColumn({
    required this.title,
    required this.color,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                color: color,
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...entries.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1.5,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color: color.withValues(alpha: 0.32),
                      ),
                    ),
                    child: Text(
                      e.name,
                      style: TextStyle(
                        color: color,
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "0x${e.key.keyId.toRadixString(16)}",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 10.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// FOOTER SECTION — closing strip with attribution and quick stats.
// =============================================================================
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.indigo.withValues(alpha: 0.32),
            Colors.deepPurple.withValues(alpha: 0.32),
            Colors.pink.withValues(alpha: 0.22),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.keyboard_command_key,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "End of reference",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "KeyEvent / KeyDownEvent / KeyUpEvent / KeyRepeatEvent demonstrated above.",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          _FooterChip(label: "9 sections", color: Colors.cyanAccent),
          const SizedBox(width: 8),
          _FooterChip(label: "Flutter 3.27+", color: Colors.amberAccent),
          const SizedBox(width: 8),
          _FooterChip(label: "static", color: Colors.greenAccent),
        ],
      ),
    );
  }
}

class _FooterChip extends StatelessWidget {
  final String label;
  final Color color;

  const _FooterChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
