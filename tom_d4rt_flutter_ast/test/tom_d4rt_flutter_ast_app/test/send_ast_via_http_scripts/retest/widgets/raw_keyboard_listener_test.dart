// ignore_for_file: unused_field, unused_local_variable, unused_element, unused_element_parameter, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// RawKeyboardListener Deep Demo
// ----------------------------------------------------------------------------
// This file is a fully-static visual exploration of Flutter's
// `RawKeyboardListener` widget, its parameters, its event hierarchy, and its
// migration path to the newer `KeyboardListener` API based on the
// `HardwareKeyboard` singleton.
//
// Everything here is built with const-friendly, side-effect-free widgets.
// There are no timers, no streams, no async work, no real FocusNode
// instances, no AnimationControllers, no setState. All "events", "key codes"
// and "modifier masks" are static data baked into the layout.
//
// The page is structured as a vertical stack of `_*Section` widgets, each
// extending StatelessWidget. Sections are intentionally chunky and visual:
// gradients, badges, chips, tables, and code snippet blocks.
// ============================================================================

// ----------------------------------------------------------------------------
// Palette - small static color helpers used throughout the demo.
// ----------------------------------------------------------------------------
class _Palette {
  static const Color ink = Color(0xFF101828);
  static const Color subtleInk = Color(0xFF475467);
  static const Color hairline = Color(0xFFE4E7EC);
  static const Color bg = Color(0xFFF7F9FC);
  static const Color card = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFF6E59F2);
  static const Color accent2 = Color(0xFF22B8A6);
  static const Color warn = Color(0xFFE0A100);
  static const Color danger = Color(0xFFD92D20);
  static const Color ok = Color(0xFF12B76A);
  static const Color cool = Color(0xFF2E90FA);
  static const Color violet = Color(0xFF7A5AF8);
  static const Color rose = Color(0xFFF63D68);
  static const Color amber = Color(0xFFF79009);
  static const Color slate = Color(0xFF334155);
}

// ----------------------------------------------------------------------------
// Reusable static labels.
// ----------------------------------------------------------------------------
class _Tag extends StatelessWidget {
  final String text;
  final Color color;
  const _Tag(this.text, {this.color = _Palette.accent});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _KeyCap extends StatelessWidget {
  final String label;
  final double width;
  final Color tint;
  const _KeyCap(this.label, {this.width = 56, this.tint = _Palette.slate});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 48,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            tint.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tint.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: tint.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
          color: tint,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  final Color dot;
  const _Bullet(this.text, {this.dot = _Palette.accent});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 10),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dot,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _Palette.ink,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final Color color;
  const _SectionTitle({
    required this.number,
    required this.title,
    required this.subtitle,
    this.color = _Palette.accent,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withValues(alpha: 0.55),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _Palette.ink,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _Palette.subtleInk,
                    fontSize: 12.5,
                    height: 1.35,
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

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color? background;
  const _Card({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.background,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background ?? _Palette.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _Palette.hairline),
        boxShadow: [
          BoxShadow(
            color: _Palette.ink.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String title;
  final String code;
  final Color accent;
  const _CodeBlock({
    required this.title,
    required this.code,
    this.accent = _Palette.accent,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1117),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent.withValues(alpha: 0.35),
                  accent.withValues(alpha: 0.15),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                const Icon(Icons.terminal, size: 14, color: Colors.white70),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFFE6EDF3),
                fontSize: 12,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Section 1 - Hero banner
// ============================================================================
class _HeroSection extends StatelessWidget {
  const _HeroSection();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _Palette.violet,
            _Palette.accent,
            _Palette.cool,
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _Palette.violet.withValues(alpha: 0.35),
            blurRadius: 24,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.4)),
                ),
                child: const Text(
                  'flutter / widgets',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.4)),
                ),
                child: const Text(
                  'deprecated',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'RawKeyboardListener',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'A focus-aware widget that delivers raw, platform-specific keyboard '
            'events. Superseded by KeyboardListener in modern Flutter, but '
            'still shows up in legacy code, plugin examples, and migration '
            'guides.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: const [
              _HeroStat(label: 'Constructors', value: '1'),
              SizedBox(width: 12),
              _HeroStat(label: 'Key params', value: '5'),
              SizedBox(width: 12),
              _HeroStat(label: 'Event types', value: '2+'),
              SizedBox(width: 12),
              _HeroStat(label: 'Replacement', value: 'KbdListener'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String label;
  final String value;
  const _HeroStat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.78),
                fontSize: 10,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Section 2 - Class anatomy
// ============================================================================
class _AnatomySection extends StatelessWidget {
  const _AnatomySection();
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            number: '02',
            title: 'Class anatomy',
            subtitle:
                'The constructor surface and inheritance chain of RawKeyboardListener.',
            color: _Palette.accent,
          ),
          const _Bullet(
            'RawKeyboardListener extends StatefulWidget, owning a State<RawKeyboardListener> instance that attaches focus listeners.',
          ),
          const _Bullet(
            'The widget does not render any visual chrome. It only positions its `child` and forwards raw events while focused.',
            dot: _Palette.cool,
          ),
          const _Bullet(
            'Routing: events reach the listener only if the embedded FocusNode currently has primary focus.',
            dot: _Palette.amber,
          ),
          const SizedBox(height: 12),
          _ParamTable(),
          const SizedBox(height: 16),
          const _CodeBlock(
            title: 'constructor.dart',
            code: 'RawKeyboardListener({\n'
                '  Key? key,\n'
                '  required FocusNode focusNode,\n'
                '  bool autofocus = false,\n'
                '  bool includeSemantics = true,\n'
                '  ValueChanged<RawKeyEvent>? onKey,\n'
                '  required Widget child,\n'
                '})',
            accent: _Palette.accent,
          ),
        ],
      ),
    );
  }
}

class _ParamTable extends StatelessWidget {
  const _ParamTable();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.hairline),
      ),
      child: Column(
        children: const [
          _ParamRow(
            name: 'focusNode',
            type: 'FocusNode',
            required: true,
            note:
                'Anchors keyboard focus. Must be retained across rebuilds (typically in State).',
          ),
          _ParamRow(
            name: 'autofocus',
            type: 'bool',
            required: false,
            defaultVal: 'false',
            note:
                'If true, the focus node grabs focus when first inserted into the tree.',
          ),
          _ParamRow(
            name: 'includeSemantics',
            type: 'bool',
            required: false,
            defaultVal: 'true',
            note:
                'Controls whether the Focus widget participates in the semantics tree.',
          ),
          _ParamRow(
            name: 'onKey',
            type: 'ValueChanged<RawKeyEvent>?',
            required: false,
            note:
                'Single-callback handler invoked on every raw key event while focused.',
          ),
          _ParamRow(
            name: 'child',
            type: 'Widget',
            required: true,
            note:
                'Subtree below the listener. Typically a focus-receiving widget or layout.',
            last: true,
          ),
        ],
      ),
    );
  }
}

class _ParamRow extends StatelessWidget {
  final String name;
  final String type;
  final bool required;
  final String? defaultVal;
  final String note;
  final bool last;
  const _ParamRow({
    required this.name,
    required this.type,
    required this.required,
    this.defaultVal,
    required this.note,
    this.last = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: last ? Colors.transparent : _Palette.hairline,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: _Palette.ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (required)
                      const _Tag('required', color: _Palette.danger),
                    if (!required && defaultVal != null)
                      _Tag('= $defaultVal', color: _Palette.cool),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _Palette.accent,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                color: _Palette.subtleInk,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Section 3 - RawKeyEvent hierarchy diagram
// ============================================================================
class _HierarchySection extends StatelessWidget {
  const _HierarchySection();
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            number: '03',
            title: 'RawKeyEvent hierarchy',
            subtitle:
                'Two concrete subclasses, one shared base, and per-platform event data.',
            color: _Palette.violet,
          ),
          _HierarchyTree(),
          const SizedBox(height: 16),
          const _Bullet(
            'RawKeyEvent.data is a RawKeyEventData subclass, populated by the engine to expose native scan / key codes and modifier flags.',
          ),
          const _Bullet(
            'RawKeyDownEvent fires once per physical press, then optionally repeats while held (platform-dependent).',
            dot: _Palette.cool,
          ),
          const _Bullet(
            'RawKeyUpEvent fires exactly once when the key is released, regardless of repeat behavior.',
            dot: _Palette.ok,
          ),
        ],
      ),
    );
  }
}

class _HierarchyTree extends StatelessWidget {
  const _HierarchyTree();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.violet.withValues(alpha: 0.08),
            _Palette.cool.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.violet.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: const [
          _TreeNode(
            label: 'RawKeyEvent (abstract)',
            description:
                'logicalKey, physicalKey, character, data, repeat, isControlPressed, ...',
            color: _Palette.violet,
            depth: 0,
          ),
          _TreeNode(
            label: 'RawKeyDownEvent',
            description: 'Emitted when a key transitions to the pressed state.',
            color: _Palette.cool,
            depth: 1,
          ),
          _TreeNode(
            label: 'RawKeyUpEvent',
            description: 'Emitted when a key transitions to the released state.',
            color: _Palette.ok,
            depth: 1,
          ),
          _TreeNode(
            label: 'RawKeyEventData (abstract)',
            description: 'Per-platform payload accessed via RawKeyEvent.data.',
            color: _Palette.amber,
            depth: 0,
          ),
          _TreeNode(
            label: 'RawKeyEventDataAndroid',
            description: 'keyCode, scanCode, metaState, plainCodePoint.',
            color: _Palette.amber,
            depth: 1,
          ),
          _TreeNode(
            label: 'RawKeyEventDataIos',
            description: 'keyCode, modifiers, characters, charactersIgnoringModifiers.',
            color: _Palette.amber,
            depth: 1,
          ),
          _TreeNode(
            label: 'RawKeyEventDataMacOs',
            description: 'keyCode, modifiers, characters, charactersIgnoringModifiers.',
            color: _Palette.amber,
            depth: 1,
          ),
          _TreeNode(
            label: 'RawKeyEventDataLinux',
            description: 'toolkit, keyCode, scanCode, modifiers, unicodeScalarValues.',
            color: _Palette.amber,
            depth: 1,
          ),
          _TreeNode(
            label: 'RawKeyEventDataWindows',
            description: 'keyCode, scanCode, characterCodePoint, modifiers.',
            color: _Palette.amber,
            depth: 1,
          ),
          _TreeNode(
            label: 'RawKeyEventDataWeb',
            description: 'code, key, location, metaState.',
            color: _Palette.amber,
            depth: 1,
            last: true,
          ),
        ],
      ),
    );
  }
}

class _TreeNode extends StatelessWidget {
  final String label;
  final String description;
  final Color color;
  final int depth;
  final bool last;
  const _TreeNode({
    required this.label,
    required this.description,
    required this.color,
    required this.depth,
    this.last = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(depth * 22.0, 6, 0, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 14,
            height: 14,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              border: Border.all(color: color, width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: _Palette.subtleInk,
                    fontSize: 12,
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
}

// ============================================================================
// Section 4 - Key-press timeline
// ============================================================================
class _TimelineSection extends StatelessWidget {
  const _TimelineSection();
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            number: '04',
            title: 'Sample key-press timeline',
            subtitle:
                'A held A-key emits Down, then several Repeats, then a single Up.',
            color: _Palette.cool,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                _EventChip(
                  label: 'Down',
                  detail: 'A @ 0ms',
                  color: _Palette.cool,
                  icon: Icons.arrow_downward,
                ),
                _Arrow(),
                _EventChip(
                  label: 'Repeat',
                  detail: 'A @ 33ms',
                  color: _Palette.violet,
                  icon: Icons.repeat,
                ),
                _Arrow(),
                _EventChip(
                  label: 'Repeat',
                  detail: 'A @ 66ms',
                  color: _Palette.violet,
                  icon: Icons.repeat,
                ),
                _Arrow(),
                _EventChip(
                  label: 'Repeat',
                  detail: 'A @ 99ms',
                  color: _Palette.violet,
                  icon: Icons.repeat,
                ),
                _Arrow(),
                _EventChip(
                  label: 'Repeat',
                  detail: 'A @ 132ms',
                  color: _Palette.violet,
                  icon: Icons.repeat,
                ),
                _Arrow(),
                _EventChip(
                  label: 'Up',
                  detail: 'A @ 180ms',
                  color: _Palette.ok,
                  icon: Icons.arrow_upward,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _Palette.cool.withValues(alpha: 0.10),
                  _Palette.violet.withValues(alpha: 0.05),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _Palette.cool.withValues(alpha: 0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet(
                  'Each Down/Repeat event in RawKeyboardListener arrives as a RawKeyDownEvent. The `repeat` flag distinguishes them.',
                  dot: _Palette.cool,
                ),
                _Bullet(
                  'In modern KeyboardListener, repeats are exposed as KeyRepeatEvent, a distinct subtype.',
                  dot: _Palette.violet,
                ),
                _Bullet(
                  'A single RawKeyUpEvent closes the gesture; no implicit Up is generated if focus is lost mid-press.',
                  dot: _Palette.ok,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventChip extends StatelessWidget {
  final String label;
  final String detail;
  final Color color;
  final IconData icon;
  const _EventChip({
    required this.label,
    required this.detail,
    required this.color,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            detail,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _Palette.ink,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.chevron_right, color: _Palette.subtleInk),
    );
  }
}

// ============================================================================
// Section 5 - Logical vs Physical keys
// ============================================================================
class _LogicalPhysicalSection extends StatelessWidget {
  const _LogicalPhysicalSection();
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            number: '05',
            title: 'Logical vs Physical keys',
            subtitle:
                'LogicalKeyboardKey tracks meaning, PhysicalKeyboardKey tracks location.',
            color: _Palette.accent2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _Palette.accent.withValues(alpha: 0.12),
                        _Palette.violet.withValues(alpha: 0.04),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: _Palette.accent.withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'LogicalKeyboardKey',
                        style: TextStyle(
                          color: _Palette.accent,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Represents what the key MEANS in the current layout. '
                        'Affected by the OS keyboard layout, dead-keys, and IME state.',
                        style: TextStyle(
                          color: _Palette.ink,
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 10),
                      _Bullet('LogicalKeyboardKey.keyA -> the letter "a/A"'),
                      _Bullet('LogicalKeyboardKey.enter -> ENTER'),
                      _Bullet('LogicalKeyboardKey.escape -> ESC'),
                      _Bullet('LogicalKeyboardKey.shiftLeft -> Left SHIFT'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _Palette.accent2.withValues(alpha: 0.14),
                        _Palette.cool.withValues(alpha: 0.04),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: _Palette.accent2.withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'PhysicalKeyboardKey',
                        style: TextStyle(
                          color: _Palette.accent2,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Represents WHERE the key sits on the keyboard. '
                        'Stable across layouts and locales — ideal for WASD games.',
                        style: TextStyle(
                          color: _Palette.ink,
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 10),
                      _Bullet('PhysicalKeyboardKey.keyA -> A position',
                          dot: _Palette.accent2),
                      _Bullet('PhysicalKeyboardKey.enter -> Enter slot',
                          dot: _Palette.accent2),
                      _Bullet('PhysicalKeyboardKey.escape -> ESC slot',
                          dot: _Palette.accent2),
                      _Bullet(
                          'PhysicalKeyboardKey.shiftLeft -> Left shift slot',
                          dot: _Palette.accent2),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _KeyMappingTable(),
        ],
      ),
    );
  }
}

class _KeyMappingTable extends StatelessWidget {
  const _KeyMappingTable();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.hairline),
      ),
      child: Column(
        children: const [
          _KeyMappingHeader(),
          _KeyMappingRow(
            label: 'A on QWERTY',
            logical: 'keyA',
            physical: 'keyA',
            character: 'a',
          ),
          _KeyMappingRow(
            label: 'A on Dvorak',
            logical: 'keyA',
            physical: 'keyA',
            character: 'a',
          ),
          _KeyMappingRow(
            label: 'Q on AZERTY',
            logical: 'keyA',
            physical: 'keyQ',
            character: 'a',
          ),
          _KeyMappingRow(
            label: 'Enter',
            logical: 'enter',
            physical: 'enter',
            character: '\\n',
          ),
          _KeyMappingRow(
            label: 'Numpad Enter',
            logical: 'numpadEnter',
            physical: 'numpadEnter',
            character: '\\n',
          ),
          _KeyMappingRow(
            label: 'F1',
            logical: 'f1',
            physical: 'f1',
            character: '(none)',
          ),
          _KeyMappingRow(
            label: 'Arrow Up',
            logical: 'arrowUp',
            physical: 'arrowUp',
            character: '(none)',
            last: true,
          ),
        ],
      ),
    );
  }
}

class _KeyMappingHeader extends StatelessWidget {
  const _KeyMappingHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: _Palette.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: const [
          SizedBox(
            width: 140,
            child: Text(
              'Scenario',
              style: TextStyle(
                color: _Palette.subtleInk,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              'LogicalKey',
              style: TextStyle(
                color: _Palette.accent,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              'PhysicalKey',
              style: TextStyle(
                color: _Palette.accent2,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Character',
              style: TextStyle(
                color: _Palette.subtleInk,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyMappingRow extends StatelessWidget {
  final String label;
  final String logical;
  final String physical;
  final String character;
  final bool last;
  const _KeyMappingRow({
    required this.label,
    required this.logical,
    required this.physical,
    required this.character,
    this.last = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: _Palette.hairline),
          bottom: BorderSide(
            color: last ? Colors.transparent : Colors.transparent,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: _Palette.ink,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              logical,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _Palette.accent,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              physical,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _Palette.accent2,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              character,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _Palette.subtleInk,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Section 6 - Modifier mask visualization
// ============================================================================
class _ModifierSection extends StatelessWidget {
  const _ModifierSection();
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            number: '06',
            title: 'Modifier mask visualization',
            subtitle:
                'Shift / Ctrl / Alt / Meta combine as bit flags accessed via isXxxPressed.',
            color: _Palette.amber,
          ),
          _ModifierBitRow(
            label: 'Shift only',
            mask: '0001',
            flags: [true, false, false, false],
          ),
          _ModifierBitRow(
            label: 'Ctrl only',
            mask: '0010',
            flags: [false, true, false, false],
          ),
          _ModifierBitRow(
            label: 'Alt only',
            mask: '0100',
            flags: [false, false, true, false],
          ),
          _ModifierBitRow(
            label: 'Meta only',
            mask: '1000',
            flags: [false, false, false, true],
          ),
          _ModifierBitRow(
            label: 'Ctrl + Shift',
            mask: '0011',
            flags: [true, true, false, false],
          ),
          _ModifierBitRow(
            label: 'Ctrl + Alt + Del',
            mask: '0110',
            flags: [false, true, true, false],
          ),
          _ModifierBitRow(
            label: 'Cmd + Shift + Z',
            mask: '1001',
            flags: [true, false, false, true],
          ),
          _ModifierBitRow(
            label: 'All four',
            mask: '1111',
            flags: [true, true, true, true],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _Palette.amber.withValues(alpha: 0.14),
                  _Palette.warn.withValues(alpha: 0.04),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: _Palette.amber.withValues(alpha: 0.35)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Reading modifiers from RawKeyEvent',
                  style: TextStyle(
                    color: _Palette.amber,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                _Bullet(
                    'event.isShiftPressed - true if either left or right Shift is down.',
                    dot: _Palette.amber),
                _Bullet(
                    'event.isControlPressed - true if either Control modifier is down.',
                    dot: _Palette.amber),
                _Bullet(
                    'event.isAltPressed - true if Alt/Option is down.',
                    dot: _Palette.amber),
                _Bullet(
                    'event.isMetaPressed - true if Cmd/Win/Meta is down.',
                    dot: _Palette.amber),
                _Bullet(
                    'event.data.modifiers - integer bitmask for advanced inspection (platform-specific).',
                    dot: _Palette.warn),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModifierBitRow extends StatelessWidget {
  final String label;
  final String mask;
  final List<bool> flags;
  const _ModifierBitRow({
    required this.label,
    required this.mask,
    required this.flags,
  });
  @override
  Widget build(BuildContext context) {
    const labels = ['Shift', 'Ctrl', 'Alt', 'Meta'];
    final colors = [
      _Palette.rose,
      _Palette.cool,
      _Palette.amber,
      _Palette.violet,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: _Palette.ink,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              mask,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _Palette.subtleInk,
                fontSize: 12,
              ),
            ),
          ),
          Row(
            children: List<Widget>.generate(4, (i) {
              final active = flags[i];
              final c = colors[i];
              return Container(
                width: 64,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  gradient: active
                      ? LinearGradient(
                          colors: [
                            c.withValues(alpha: 0.85),
                            c.withValues(alpha: 0.55),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: [
                            _Palette.hairline,
                            _Palette.bg,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: active
                        ? c
                        : _Palette.hairline,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      labels[i],
                      style: TextStyle(
                        color: active ? Colors.white : _Palette.subtleInk,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      active ? '1' : '0',
                      style: TextStyle(
                        color: active ? Colors.white : _Palette.subtleInk,
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
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
}

// ============================================================================
// Section 7 - Migration to KeyboardListener cheat sheet
// ============================================================================
class _MigrationSection extends StatelessWidget {
  const _MigrationSection();
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            number: '07',
            title: 'Migration to KeyboardListener',
            subtitle:
                'Side-by-side cheat sheet covering the renamed types and APIs.',
            color: _Palette.ok,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _Palette.hairline),
            ),
            child: Column(
              children: const [
                _MigrationHeader(),
                _MigrationRow(
                  oldName: 'RawKeyboardListener',
                  newName: 'KeyboardListener',
                  notes: 'Same role: focus-aware wrapper around a key callback.',
                ),
                _MigrationRow(
                  oldName: 'RawKeyEvent',
                  newName: 'KeyEvent',
                  notes:
                      'KeyEvent is a sealed hierarchy: KeyDownEvent, KeyUpEvent, KeyRepeatEvent.',
                ),
                _MigrationRow(
                  oldName: 'RawKeyDownEvent',
                  newName: 'KeyDownEvent',
                  notes:
                      'No more `repeat` flag - repeats are their own KeyRepeatEvent.',
                ),
                _MigrationRow(
                  oldName: 'RawKeyUpEvent',
                  newName: 'KeyUpEvent',
                  notes: 'Same single Up semantics.',
                ),
                _MigrationRow(
                  oldName: 'RawKeyboard.instance',
                  newName: 'HardwareKeyboard.instance',
                  notes:
                      'Global singleton snapshot of pressed keys & modifier state.',
                ),
                _MigrationRow(
                  oldName: 'RawKeyEvent.data.modifiers',
                  newName: 'HardwareKeyboard.instance.logicalKeysPressed',
                  notes:
                      'Modifier state queried via the hardware keyboard set.',
                ),
                _MigrationRow(
                  oldName: 'onKey: ValueChanged<RawKeyEvent>?',
                  newName: 'onKeyEvent: ValueChanged<KeyEvent>?',
                  notes: 'Callback signature renamed and retyped.',
                  last: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const _CodeBlock(
            title: 'before_rawkeyboardlistener.dart',
            code: 'Widget build(BuildContext context) {\n'
                '  // legacy: deprecated in current Flutter.\n'
                '  return RawKeyboardListener(\n'
                '    focusNode: _focusNode,\n'
                '    autofocus: true,\n'
                '    onKey: (RawKeyEvent event) {\n'
                '      if (event is RawKeyDownEvent) {\n'
                '        // handle press\n'
                '      }\n'
                '    },\n'
                '    child: const Text("Press any key"),\n'
                '  );\n'
                '}',
            accent: _Palette.warn,
          ),
          const _CodeBlock(
            title: 'after_keyboardlistener.dart',
            code: 'Widget build(BuildContext context) {\n'
                '  // modern: replacement that handles repeats explicitly.\n'
                '  return KeyboardListener(\n'
                '    focusNode: _focusNode,\n'
                '    autofocus: true,\n'
                '    onKeyEvent: (KeyEvent event) {\n'
                '      if (event is KeyDownEvent) {\n'
                '        // handle press\n'
                '      } else if (event is KeyRepeatEvent) {\n'
                '        // handle auto-repeat\n'
                '      } else if (event is KeyUpEvent) {\n'
                '        // handle release\n'
                '      }\n'
                '    },\n'
                '    child: const Text("Press any key"),\n'
                '  );\n'
                '}',
            accent: _Palette.ok,
          ),
        ],
      ),
    );
  }
}

class _MigrationHeader extends StatelessWidget {
  const _MigrationHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.warn.withValues(alpha: 0.12),
            _Palette.ok.withValues(alpha: 0.12),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: const [
          SizedBox(
            width: 220,
            child: Text(
              'Legacy (RawKeyboard*)',
              style: TextStyle(
                color: _Palette.warn,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              'Modern (KeyboardListener)',
              style: TextStyle(
                color: _Palette.ok,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Notes',
              style: TextStyle(
                color: _Palette.subtleInk,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MigrationRow extends StatelessWidget {
  final String oldName;
  final String newName;
  final String notes;
  final bool last;
  const _MigrationRow({
    required this.oldName,
    required this.newName,
    required this.notes,
    this.last = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: _Palette.hairline),
          bottom: BorderSide(
            color: last ? Colors.transparent : Colors.transparent,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 220,
            child: Text(
              oldName,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _Palette.warn,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              newName,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _Palette.ok,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              notes,
              style: const TextStyle(
                color: _Palette.subtleInk,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Section 8 - Code snippet gallery
// ============================================================================
class _GallerySection extends StatelessWidget {
  const _GallerySection();
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _SectionTitle(
            number: '08',
            title: 'Code snippet gallery',
            subtitle:
                'Three canonical snippets you will encounter in legacy codebases.',
            color: _Palette.rose,
          ),
          _CodeBlock(
            title: 'snippet_basic_listener.dart',
            code: 'class _LegacyGame extends StatefulWidget {\n'
                '  @override\n'
                '  State<_LegacyGame> createState() => _LegacyGameState();\n'
                '}\n\n'
                'class _LegacyGameState extends State<_LegacyGame> {\n'
                '  final FocusNode _focusNode = FocusNode();\n\n'
                '  void _onKey(RawKeyEvent event) {\n'
                '    if (event is RawKeyDownEvent) {\n'
                '      if (event.logicalKey == LogicalKeyboardKey.space) {\n'
                '        // jump!\n'
                '      }\n'
                '    }\n'
                '  }\n\n'
                '  @override\n'
                '  Widget build(BuildContext context) {\n'
                '    return RawKeyboardListener(\n'
                '      focusNode: _focusNode,\n'
                '      autofocus: true,\n'
                '      onKey: _onKey,\n'
                '      child: const Center(child: Text("Game canvas")),\n'
                '    );\n'
                '  }\n'
                '}',
            accent: _Palette.cool,
          ),
          _CodeBlock(
            title: 'snippet_modifier_check.dart',
            code: 'void _handle(RawKeyEvent event) {\n'
                '  if (event is! RawKeyDownEvent) return;\n'
                '  final isSubmit = event.logicalKey == LogicalKeyboardKey.enter\n'
                '      && event.isControlPressed;\n'
                '  if (isSubmit) {\n'
                '    // Ctrl + Enter -> submit\n'
                '  }\n'
                '  final isUndo = event.isMetaPressed\n'
                '      && event.logicalKey == LogicalKeyboardKey.keyZ;\n'
                '  if (isUndo) {\n'
                '    // Cmd + Z -> undo\n'
                '  }\n'
                '}',
            accent: _Palette.violet,
          ),
          _CodeBlock(
            title: 'snippet_repeat_handling.dart',
            code: 'void _onKey(RawKeyEvent event) {\n'
                '  if (event is RawKeyDownEvent) {\n'
                '    if (event.repeat) {\n'
                '      // auto-repeat tick — used for continuous scroll / pan.\n'
                '    } else {\n'
                '      // first press.\n'
                '    }\n'
                '  } else if (event is RawKeyUpEvent) {\n'
                '    // release — stop continuous action.\n'
                '  }\n'
                '}',
            accent: _Palette.rose,
          ),
          _CodeBlock(
            title: 'snippet_keycap_row.dart',
            code: '// Common debug visualization for pressed-key inspection.\n'
                'Row(\n'
                '  children: const [\n'
                '    _KeyCap("W"),\n'
                '    _KeyCap("A"),\n'
                '    _KeyCap("S"),\n'
                '    _KeyCap("D"),\n'
                '    SizedBox(width: 8),\n'
                '    _KeyCap("Shift", width: 80),\n'
                '    _KeyCap("Space", width: 120),\n'
                '  ],\n'
                ')',
            accent: _Palette.accent2,
          ),
          SizedBox(height: 10),
          _DemoKeyboard(),
        ],
      ),
    );
  }
}

class _DemoKeyboard extends StatelessWidget {
  const _DemoKeyboard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.slate.withValues(alpha: 0.10),
            _Palette.cool.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.slate.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _KeyCap('Esc', width: 64, tint: _Palette.rose),
              SizedBox(width: 12),
              _KeyCap('F1', tint: _Palette.subtleInk),
              _KeyCap('F2', tint: _Palette.subtleInk),
              _KeyCap('F3', tint: _Palette.subtleInk),
              _KeyCap('F4', tint: _Palette.subtleInk),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _KeyCap('Q', tint: _Palette.slate),
              _KeyCap('W', tint: _Palette.cool),
              _KeyCap('E', tint: _Palette.slate),
              _KeyCap('R', tint: _Palette.slate),
              _KeyCap('T', tint: _Palette.slate),
              _KeyCap('Y', tint: _Palette.slate),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _KeyCap('A', tint: _Palette.cool),
              _KeyCap('S', tint: _Palette.cool),
              _KeyCap('D', tint: _Palette.cool),
              _KeyCap('F', tint: _Palette.slate),
              _KeyCap('G', tint: _Palette.slate),
              _KeyCap('H', tint: _Palette.slate),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _KeyCap('Shift', width: 96, tint: _Palette.rose),
              _KeyCap('Z', tint: _Palette.slate),
              _KeyCap('X', tint: _Palette.slate),
              _KeyCap('C', tint: _Palette.slate),
              _KeyCap('V', tint: _Palette.slate),
              _KeyCap('Ctrl', width: 72, tint: _Palette.violet),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _KeyCap('Ctrl', width: 72, tint: _Palette.violet),
              _KeyCap('Alt', width: 64, tint: _Palette.amber),
              _KeyCap('Space', width: 200, tint: _Palette.accent2),
              _KeyCap('Alt', width: 64, tint: _Palette.amber),
              _KeyCap('Meta', width: 64, tint: _Palette.violet),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Section 9 - Pitfalls
// ============================================================================
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _SectionTitle(
            number: '09',
            title: 'Common pitfalls',
            subtitle:
                'Things that bite when wiring a RawKeyboardListener for the first time.',
            color: _Palette.danger,
          ),
          _PitfallCard(
            title: 'Focus is required',
            description:
                'No focus = no events. Always pair with a FocusNode that is actually focused. '
                'Wrap the child in a Focus-receiving widget (or set autofocus: true).',
            color: _Palette.danger,
            icon: Icons.center_focus_strong,
          ),
          _PitfallCard(
            title: 'Swallowing parent shortcuts',
            description:
                'Returning early from onKey does NOT block parent Shortcuts/Actions. '
                'Use FocusScope / Shortcuts for ordered key dispatch instead.',
            color: _Palette.amber,
            icon: Icons.layers,
          ),
          _PitfallCard(
            title: 'Deprecated in newer Flutter',
            description:
                'RawKeyboardListener is marked @Deprecated. New code should use '
                'KeyboardListener + HardwareKeyboard. Lints will flag legacy usages.',
            color: _Palette.warn,
            icon: Icons.warning_amber_rounded,
          ),
          _PitfallCard(
            title: 'Platform-specific data',
            description:
                'event.data is a different RawKeyEventData subclass per platform. '
                'Avoid switching on subclass type — query the high-level fields instead.',
            color: _Palette.cool,
            icon: Icons.public,
          ),
          _PitfallCard(
            title: 'Repeats are merged into Down',
            description:
                'In RawKeyboardListener, auto-repeats arrive as RawKeyDownEvent with repeat=true. '
                'In KeyboardListener, they become a separate KeyRepeatEvent subtype.',
            color: _Palette.violet,
            icon: Icons.repeat_on,
          ),
          _PitfallCard(
            title: 'FocusNode lifecycle',
            description:
                'Always create FocusNode in initState and dispose() in dispose(). '
                'Leaking a FocusNode keeps the entire widget tree alive.',
            color: _Palette.rose,
            icon: Icons.recycling,
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  const _PitfallCard({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.14),
            color.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withValues(alpha: 0.5)),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: _Palette.ink,
                    fontSize: 12.5,
                    height: 1.45,
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

// ============================================================================
// Section 10 - Footer
// ============================================================================
class _FooterSection extends StatelessWidget {
  const _FooterSection();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.slate,
            _Palette.ink,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _Palette.ink.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _Palette.accent,
                      _Palette.cool,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.keyboard,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                'RawKeyboardListener — Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'This static demo covers the legacy RawKeyboardListener widget, '
            'the RawKeyEvent hierarchy, key identity (logical vs physical), '
            'modifier masks, and the migration path to KeyboardListener + '
            'HardwareKeyboard. All content is rendered statelessly — there '
            'are no timers, streams, or animations involved.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: const [
              _Tag('flutter', color: _Palette.cool),
              _Tag('widgets', color: _Palette.violet),
              _Tag('keyboard', color: _Palette.accent),
              _Tag('legacy', color: _Palette.warn),
              _Tag('migration', color: _Palette.ok),
              _Tag('static-demo', color: _Palette.accent2),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Entry point
// ============================================================================
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RawKeyboardListener Deep Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _Palette.accent,
      scaffoldBackgroundColor: _Palette.bg,
    ),
    home: Scaffold(
      backgroundColor: _Palette.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _HeroSection(),
              SizedBox(height: 20),
              _AnatomySection(),
              SizedBox(height: 20),
              _HierarchySection(),
              SizedBox(height: 20),
              _TimelineSection(),
              SizedBox(height: 20),
              _LogicalPhysicalSection(),
              SizedBox(height: 20),
              _ModifierSection(),
              SizedBox(height: 20),
              _MigrationSection(),
              SizedBox(height: 20),
              _GallerySection(),
              SizedBox(height: 20),
              _PitfallsSection(),
              SizedBox(height: 20),
              _FooterSection(),
            ],
          ),
        ),
      ),
    ),
  );
}
