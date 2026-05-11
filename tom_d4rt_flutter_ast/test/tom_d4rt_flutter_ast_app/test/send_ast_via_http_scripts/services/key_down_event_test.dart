// ignore_for_file: unused_field, unused_local_variable, unused_element, unused_element_parameter, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// KeyDownEvent — Deep Visual Demo
// ----------------------------------------------------------------------------
// This file is a static, hand-authored visual reference for the modern Flutter
// keyboard API. It focuses on KeyDownEvent (from package:flutter/services.dart)
// and the related sealed hierarchy of KeyEvent subclasses introduced when the
// framework migrated away from the legacy RawKeyEvent system.
//
// The widget tree is intentionally fully static: no Stateful widgets, no
// Timers, no Futures, no Streams, no AnimationControllers. All visual motion
// is implied through diagrams, chips, gradients, and tables.
// ============================================================================

const Color _bg = Color(0xFF0F1220);
const Color _panel = Color(0xFF181C2F);
const Color _panel2 = Color(0xFF20243C);
const Color _accent = Color(0xFF7C4DFF);
const Color _accent2 = Color(0xFF18FFFF);
const Color _accent3 = Color(0xFFFFD740);
const Color _accent4 = Color(0xFFFF4081);
const Color _accent5 = Color(0xFF69F0AE);
const Color _accent6 = Color(0xFFFF8A65);
const Color _text = Color(0xFFE8ECFF);
const Color _muted = Color(0xFF8A92B2);
const Color _border = Color(0xFF2A2F4A);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'KeyDownEvent Deep Demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _bg,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: _bg,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _HeroBannerSection(),
            _HierarchyDiagramSection(),
            _FieldCardSection(),
            _PhysicalVsLogicalSection(),
            _EventTimelineSection(),
            _CharacterVsLogicalTableSection(),
            _HardwareKeyboardSection(),
            _HandlerSnippetGallerySection(),
            _PitfallsSection(),
            _MigrationCheatSheetSection(),
            _FooterSection(),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Reusable atoms
// ============================================================================

class _SectionFrame extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;
  final Widget child;
  final List<Color> gradient;
  const _SectionFrame({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF000000).withValues(alpha: 0.35),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: _accent.withValues(alpha: 0.45), width: 1),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: _accent2,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _text,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              color: _muted,
              fontSize: 14,
              height: 1.45,
            ),
          ),
          SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  const _Chip({required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 14, color: color),
            SizedBox(width: 6),
          ],
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

class _KeyCap extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final Color tint;
  final bool pressed;
  const _KeyCap({
    required this.label,
    this.width = 44,
    this.height = 44,
    this.tint = _panel2,
    this.pressed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: pressed
              ? <Color>[
                  _accent.withValues(alpha: 0.85),
                  _accent2.withValues(alpha: 0.65),
                ]
              : <Color>[
                  tint,
                  Color.lerp(tint, Colors.black, 0.35)!,
                ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: pressed
              ? _accent.withValues(alpha: 0.9)
              : _border.withValues(alpha: 0.8),
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF000000).withValues(alpha: 0.3),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: pressed ? Colors.white : _text,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  final String title;
  const _CodeBlock({required this.code, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF0A0D1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  _accent.withValues(alpha: 0.35),
                  _accent2.withValues(alpha: 0.15),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.code, size: 14, color: _text),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: _text,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                Spacer(),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _accent4,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _accent3,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _accent5,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14),
            child: Text(
              code,
              style: TextStyle(
                color: _text,
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TblRow extends StatelessWidget {
  final List<String> cells;
  final bool header;
  final List<int> flex;
  const _TblRow({
    required this.cells,
    required this.flex,
    this.header = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: header
            ? _accent.withValues(alpha: 0.18)
            : _panel.withValues(alpha: 0.6),
        border: Border(
          bottom: BorderSide(color: _border, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          for (int i = 0; i < cells.length; i++)
            Expanded(
              flex: flex[i],
              child: Text(
                cells[i],
                style: TextStyle(
                  color: header ? _accent2 : _text,
                  fontFamily: header ? null : 'monospace',
                  fontWeight:
                      header ? FontWeight.w800 : FontWeight.w500,
                  fontSize: 12.5,
                  letterSpacing: header ? 0.6 : 0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  const _Bullet(
      {required this.text, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
              border:
                  Border.all(color: color.withValues(alpha: 0.5), width: 1),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 14, color: color),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: _text,
                fontSize: 13.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  final String label;
  final Color color;
  const _Arrow({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 2),
          Icon(Icons.east, color: color, size: 22),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 1 — Hero Banner
// ============================================================================

class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 56),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF1A0B3E),
            Color(0xFF2C1B5C),
            Color(0xFF0F1220),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: <double>[0.0, 0.55, 1.0],
        ),
        border: Border(
          bottom: BorderSide(color: _accent.withValues(alpha: 0.45), width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[_accent, _accent2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: _accent.withValues(alpha: 0.55),
                      blurRadius: 24,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(Icons.keyboard_alt_outlined,
                    color: Colors.white, size: 28),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'package:flutter/services.dart',
                    style: TextStyle(
                      color: _accent2,
                      fontSize: 12,
                      letterSpacing: 1.6,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'KeyDownEvent — Deep Visual Reference',
                    style: TextStyle(
                      color: _text,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 22),
          Container(
            constraints: BoxConstraints(maxWidth: 720),
            child: Text(
              'KeyDownEvent represents the press-down phase of a physical keyboard '
              'interaction in Flutter\'s modern keyboard pipeline. It is one '
              'subtype of the sealed KeyEvent hierarchy that replaced the legacy '
              'RawKeyEvent system, and carries both a physical-key identity '
              '(hardware location) and a logical-key identity (semantic meaning '
              'after layout translation), along with an optional rendered '
              'character and a monotonic timestamp.',
              style: TextStyle(
                color: _muted,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
          SizedBox(height: 24),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _Chip(
                label: 'sealed KeyEvent',
                color: _accent2,
                icon: Icons.bolt,
              ),
              _Chip(
                label: 'physicalKey',
                color: _accent3,
                icon: Icons.hardware,
              ),
              _Chip(
                label: 'logicalKey',
                color: _accent4,
                icon: Icons.translate,
              ),
              _Chip(
                label: 'character',
                color: _accent5,
                icon: Icons.text_fields,
              ),
              _Chip(
                label: 'timeStamp',
                color: _accent6,
                icon: Icons.schedule,
              ),
              _Chip(
                label: 'synthesized',
                color: _accent,
                icon: Icons.auto_awesome,
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        _accent.withValues(alpha: 0.22),
                        _accent2.withValues(alpha: 0.10),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: _accent.withValues(alpha: 0.4), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '11',
                        style: TextStyle(
                          color: _text,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'sections in this demo',
                        style: TextStyle(color: _muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        _accent3.withValues(alpha: 0.20),
                        _accent6.withValues(alpha: 0.10),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: _accent3.withValues(alpha: 0.4), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '3',
                        style: TextStyle(
                          color: _text,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'KeyEvent subtypes covered',
                        style: TextStyle(color: _muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        _accent5.withValues(alpha: 0.20),
                        _accent2.withValues(alpha: 0.10),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: _accent5.withValues(alpha: 0.4), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '0',
                        style: TextStyle(
                          color: _text,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Stateful widgets (static demo)',
                        style: TextStyle(color: _muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 2 — KeyEvent hierarchy diagram
// ============================================================================

class _HierarchyDiagramSection extends StatelessWidget {
  const _HierarchyDiagramSection();

  Widget _node({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    bool sealed = false,
  }) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.30),
            color.withValues(alpha: 0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.7), width: 1.4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.20),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 18),
              SizedBox(width: 8),
              if (sealed)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: color.withValues(alpha: 0.6), width: 1),
                  ),
                  child: Text(
                    'sealed',
                    style: TextStyle(
                      color: color,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: _text,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: _muted,
              fontSize: 11,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'HIERARCHY',
      title: 'The sealed KeyEvent family',
      subtitle:
          'KeyEvent is a sealed superclass. The three concrete subtypes — '
          'KeyDownEvent, KeyRepeatEvent, KeyUpEvent — model the three discrete '
          'phases of a key interaction. Because the class is sealed, an '
          'exhaustive switch over a KeyEvent does not need a default branch.',
      gradient: <Color>[
        Color(0xFF1B1240),
        Color(0xFF13182E),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _node(
            title: 'KeyEvent',
            subtitle: 'Sealed superclass. Carries physical/logical key, '
                'character, timeStamp, synthesized, deviceType.',
            color: _accent,
            icon: Icons.account_tree_outlined,
            sealed: true,
          ),
          SizedBox(height: 12),
          Container(
            width: 2,
            height: 32,
            color: _accent.withValues(alpha: 0.55),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _node(
                title: 'KeyDownEvent',
                subtitle: 'Initial press of a key. Fires once per physical '
                    'press, before any repeats.',
                color: _accent2,
                icon: Icons.arrow_downward_rounded,
              ),
              SizedBox(width: 16),
              _node(
                title: 'KeyRepeatEvent',
                subtitle: 'OS-driven auto-repeat while the key is held. '
                    'Cadence is platform-controlled.',
                color: _accent3,
                icon: Icons.repeat_rounded,
              ),
              SizedBox(width: 16),
              _node(
                title: 'KeyUpEvent',
                subtitle: 'Release of a key. Not always guaranteed — see the '
                    'Pitfalls section below.',
                color: _accent4,
                icon: Icons.arrow_upward_rounded,
              ),
            ],
          ),
          SizedBox(height: 22),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _panel.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _border, width: 1),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.info_outline, color: _accent2, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'A "press and hold" produces: 1× KeyDownEvent, '
                    'N× KeyRepeatEvent (platform cadence), 1× KeyUpEvent. '
                    'A single tap produces: 1× KeyDownEvent, 1× KeyUpEvent.',
                    style: TextStyle(
                      color: _text,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          _CodeBlock(
            title: 'exhaustive switch — no default branch needed',
            code: 'String describe(KeyEvent e) => switch (e) {\n'
                '  KeyDownEvent()   => "down:   \${e.logicalKey.debugName}",\n'
                '  KeyRepeatEvent() => "repeat: \${e.logicalKey.debugName}",\n'
                '  KeyUpEvent()     => "up:     \${e.logicalKey.debugName}",\n'
                '};',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 3 — KeyDownEvent field card
// ============================================================================

class _FieldCardSection extends StatelessWidget {
  const _FieldCardSection();

  Widget _fieldRow({
    required String name,
    required String type,
    required String description,
    required IconData icon,
    required Color color,
    String? example,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _panel.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: color.withValues(alpha: 0.6), width: 1),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: color, size: 18),
              ),
              SizedBox(width: 12),
              Text(
                name,
                style: TextStyle(
                  color: _text,
                  fontFamily: 'monospace',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: color.withValues(alpha: 0.45), width: 1),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              color: _text,
              fontSize: 13.5,
              height: 1.55,
            ),
          ),
          if (example != null) ...<Widget>[
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF0A0D1A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: color.withValues(alpha: 0.3), width: 1),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.east, size: 12, color: color),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      example,
                      style: TextStyle(
                        color: _accent2,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'FIELDS',
      title: 'KeyDownEvent — anatomy of an event object',
      subtitle:
          'Every concrete KeyEvent (including KeyDownEvent) carries the same '
          'set of immutable fields. The framework guarantees they are populated '
          'at construction time and never mutate; consumers can safely capture '
          'an event reference across frames.',
      gradient: <Color>[
        Color(0xFF14283D),
        Color(0xFF0F1F30),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _fieldRow(
            name: 'physicalKey',
            type: 'PhysicalKeyboardKey',
            icon: Icons.hardware,
            color: _accent3,
            description:
                'Identifies the hardware location on the keyboard. Independent '
                'of any layout the user has installed. The "Q" key in the '
                'top-left row of a US QWERTY keyboard is the same physicalKey '
                'as the "A" key on an AZERTY keyboard — they occupy the same '
                'physical spot.',
            example: 'PhysicalKeyboardKey.keyQ  // USB HID usage 0x070014',
          ),
          _fieldRow(
            name: 'logicalKey',
            type: 'LogicalKeyboardKey',
            icon: Icons.translate,
            color: _accent4,
            description:
                'Identifies the semantic meaning of the key after applying the '
                'active keyboard layout. On a French AZERTY keyboard, pressing '
                'the same physical location that yields "Q" on US QWERTY will '
                'yield logicalKey.keyA.',
            example: 'LogicalKeyboardKey.keyA   // semantic "A"',
          ),
          _fieldRow(
            name: 'character',
            type: 'String?',
            icon: Icons.text_fields,
            color: _accent5,
            description:
                'The rendered character (or short grapheme cluster) that this '
                'key press produces, when applicable. Null for non-text keys '
                '(modifiers, function keys, arrows). Applies any active shift, '
                'AltGr, or composition state.',
            example: '"A"  // Shift+A; or null for ShiftLeft',
          ),
          _fieldRow(
            name: 'timeStamp',
            type: 'Duration',
            icon: Icons.schedule,
            color: _accent6,
            description:
                'A monotonic Duration measured from an arbitrary origin chosen '
                'by the framework. Useful for computing inter-event intervals, '
                'detecting double-presses, and ordering events deterministically '
                'across input devices.',
            example: 'Duration(milliseconds: 1842)',
          ),
          _fieldRow(
            name: 'synthesized',
            type: 'bool',
            icon: Icons.auto_awesome,
            color: _accent,
            description:
                'True when the framework manufactured the event to keep its '
                'internal model of pressed keys consistent — for example, when '
                'the app regains focus and a previously-pressed key state must '
                'be reconciled. Synthesized events do not correspond to a real '
                'hardware action.',
            example: 'false  // for organic user input',
          ),
          _fieldRow(
            name: 'deviceType',
            type: 'KeyEventDeviceType',
            icon: Icons.devices,
            color: _accent2,
            description:
                'Identifies the source class of input device (keyboard, '
                'gamepad, accessibility input, etc.). Lets a handler decide '
                'whether to react — e.g. ignoring gamepad events in a text '
                'editor.',
            example: 'KeyEventDeviceType.keyboard',
          ),
          SizedBox(height: 4),
          _CodeBlock(
            title: 'constructing a KeyDownEvent (used in tests)',
            code: 'final event = KeyDownEvent(\n'
                '  physicalKey: PhysicalKeyboardKey.keyA,\n'
                '  logicalKey:  LogicalKeyboardKey.keyA,\n'
                '  character:   "a",\n'
                '  timeStamp:   const Duration(milliseconds: 100),\n'
                ');\n'
                '\n'
                '// Read access\n'
                'event.physicalKey;  // PhysicalKeyboardKey.keyA\n'
                'event.logicalKey;   // LogicalKeyboardKey.keyA\n'
                'event.character;    // "a"\n'
                'event.timeStamp;    // Duration(ms: 100)\n'
                'event.synthesized;  // false (default)',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 4 — PhysicalKeyboardKey vs LogicalKeyboardKey
// ============================================================================

class _PhysicalVsLogicalSection extends StatelessWidget {
  const _PhysicalVsLogicalSection();

  Widget _layoutRow(String layoutName, List<String> caps, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              layoutName,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ),
          for (int i = 0; i < caps.length; i++)
            _KeyCap(
              label: caps[i],
              pressed: i == 0,
              tint: i == 0 ? _panel2 : _panel,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'PHYSICAL vs LOGICAL',
      title: 'Same hardware key, different meaning',
      subtitle:
          'The split between physicalKey and logicalKey is what lets Flutter '
          'apps support international keyboard layouts cleanly. The physical '
          'identity is constant across layouts; the logical identity tracks '
          'what the user actually intends.',
      gradient: <Color>[
        Color(0xFF2A1438),
        Color(0xFF1A0E2A),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Top-left letter row on three layouts. The highlighted key is the '
            'same physical key (USB HID usage code 0x070014). Notice how the '
            'logical key — and therefore the produced character — changes.',
            style: TextStyle(color: _muted, fontSize: 13, height: 1.5),
          ),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  _panel.withValues(alpha: 0.85),
                  _panel2.withValues(alpha: 0.65),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _border, width: 1),
            ),
            child: Column(
              children: <Widget>[
                _layoutRow(
                    'US QWERTY',
                    <String>['Q', 'W', 'E', 'R', 'T', 'Y'],
                    _accent2),
                _layoutRow(
                    'FR AZERTY',
                    <String>['A', 'Z', 'E', 'R', 'T', 'Y'],
                    _accent3),
                _layoutRow(
                    'DE QWERTZ',
                    <String>['Q', 'W', 'E', 'R', 'T', 'Z'],
                    _accent5),
                _layoutRow(
                    'DVORAK',
                    <String>["'", ',', '.', 'P', 'Y', 'F'],
                    _accent4),
              ],
            ),
          ),
          SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        _accent3.withValues(alpha: 0.22),
                        _accent3.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: _accent3.withValues(alpha: 0.5), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Icon(Icons.hardware,
                            color: _accent3, size: 16),
                        SizedBox(width: 6),
                        Text('physicalKey',
                            style: TextStyle(
                              color: _accent3,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'monospace',
                              fontSize: 14,
                            )),
                      ]),
                      SizedBox(height: 10),
                      Text(
                        'PhysicalKeyboardKey.keyQ',
                        style: TextStyle(
                          color: _text,
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Constant across all four layouts above. '
                        'Use this when the operation depends on key location '
                        '— for example, "WASD" navigation in a game should '
                        'be tied to physical keys so the same physical '
                        'fingers work on any layout.',
                        style: TextStyle(
                          color: _muted,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        _accent4.withValues(alpha: 0.22),
                        _accent4.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: _accent4.withValues(alpha: 0.5), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Icon(Icons.translate,
                            color: _accent4, size: 16),
                        SizedBox(width: 6),
                        Text('logicalKey',
                            style: TextStyle(
                              color: _accent4,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'monospace',
                              fontSize: 14,
                            )),
                      ]),
                      SizedBox(height: 10),
                      Text(
                        'varies per layout',
                        style: TextStyle(
                          color: _text,
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'On QWERTY → LogicalKeyboardKey.keyQ. '
                        'On AZERTY → LogicalKeyboardKey.keyA. '
                        'On Dvorak → the quote character. '
                        'Use this when the operation depends on intent '
                        '— for example, the shortcut "Cmd+Q to quit" should '
                        'bind to the logical Q regardless of layout.',
                        style: TextStyle(
                          color: _muted,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 5 — Static event-stream timeline
// ============================================================================

class _EventTimelineSection extends StatelessWidget {
  const _EventTimelineSection();

  Widget _eventChip({
    required String label,
    required String ts,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.32),
            color.withValues(alpha: 0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.7), width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, color: color, size: 14),
              SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            ts,
            style: TextStyle(
              color: _muted,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _track(String title, List<Widget> events) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: _text,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            decoration: BoxDecoration(
              color: _panel.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _border, width: 1),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.timeline, color: _muted, size: 14),
                SizedBox(width: 8),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: events),
                  ),
                ),
                Icon(Icons.east, color: _muted, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'TIMELINE',
      title: 'What a "press, hold, release" looks like',
      subtitle:
          'Three representative interactions rendered as horizontal event '
          'chips. Read left-to-right; each chip carries its KeyEvent subtype '
          'and approximate timeStamp. The first interaction is a simple tap; '
          'the second is a held key triggering OS auto-repeat; the third is a '
          'modifier combination.',
      gradient: <Color>[
        Color(0xFF103029),
        Color(0xFF0A1C18),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _track('Single tap on "A"', <Widget>[
            _eventChip(
                label: 'KeyDownEvent  A',
                ts: 't = 0 ms',
                color: _accent2,
                icon: Icons.arrow_downward_rounded),
            _Arrow(label: '~85 ms', color: _muted),
            _eventChip(
                label: 'KeyUpEvent    A',
                ts: 't = 85 ms',
                color: _accent4,
                icon: Icons.arrow_upward_rounded),
          ]),
          _track('Held arrow-right (≈500 ms before release)', <Widget>[
            _eventChip(
                label: 'KeyDownEvent  →',
                ts: 't = 0 ms',
                color: _accent2,
                icon: Icons.arrow_downward_rounded),
            _Arrow(label: '~400 ms', color: _muted),
            _eventChip(
                label: 'KeyRepeatEvent →',
                ts: 't = 400 ms',
                color: _accent3,
                icon: Icons.repeat_rounded),
            _Arrow(label: '~30 ms', color: _muted),
            _eventChip(
                label: 'KeyRepeatEvent →',
                ts: 't = 430 ms',
                color: _accent3,
                icon: Icons.repeat_rounded),
            _Arrow(label: '~30 ms', color: _muted),
            _eventChip(
                label: 'KeyRepeatEvent →',
                ts: 't = 460 ms',
                color: _accent3,
                icon: Icons.repeat_rounded),
            _Arrow(label: '~40 ms', color: _muted),
            _eventChip(
                label: 'KeyUpEvent    →',
                ts: 't = 500 ms',
                color: _accent4,
                icon: Icons.arrow_upward_rounded),
          ]),
          _track('Ctrl+Shift+S (overlapping presses)', <Widget>[
            _eventChip(
                label: 'KeyDownEvent  Ctrl',
                ts: 't = 0 ms',
                color: _accent2,
                icon: Icons.arrow_downward_rounded),
            _Arrow(label: '~40 ms', color: _muted),
            _eventChip(
                label: 'KeyDownEvent  Shift',
                ts: 't = 40 ms',
                color: _accent2,
                icon: Icons.arrow_downward_rounded),
            _Arrow(label: '~60 ms', color: _muted),
            _eventChip(
                label: 'KeyDownEvent  S',
                ts: 't = 100 ms',
                color: _accent2,
                icon: Icons.arrow_downward_rounded),
            _Arrow(label: '~80 ms', color: _muted),
            _eventChip(
                label: 'KeyUpEvent    S',
                ts: 't = 180 ms',
                color: _accent4,
                icon: Icons.arrow_upward_rounded),
            _Arrow(label: '~30 ms', color: _muted),
            _eventChip(
                label: 'KeyUpEvent    Shift',
                ts: 't = 210 ms',
                color: _accent4,
                icon: Icons.arrow_upward_rounded),
            _Arrow(label: '~25 ms', color: _muted),
            _eventChip(
                label: 'KeyUpEvent    Ctrl',
                ts: 't = 235 ms',
                color: _accent4,
                icon: Icons.arrow_upward_rounded),
          ]),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _accent3.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: _accent3.withValues(alpha: 0.4), width: 1),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.lightbulb_outline,
                    color: _accent3, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'KeyRepeatEvent is distinct from KeyDownEvent on purpose: '
                    'it lets text inputs accept repeats while game-style code '
                    'paths (which usually want only the initial press) can '
                    'filter them out by matching only on KeyDownEvent.',
                    style: TextStyle(
                      color: _text,
                      fontSize: 13,
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

// ============================================================================
// SECTION 6 — character vs logicalKey table
// ============================================================================

class _CharacterVsLogicalTableSection extends StatelessWidget {
  const _CharacterVsLogicalTableSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'CHARACTER  vs  LOGICALKEY',
      title: 'Why both fields exist',
      subtitle:
          'logicalKey is stable across shift/AltGr/composition state — it '
          'identifies "this key". character is the *result* of pressing it '
          'right now, with all active modifiers applied. Reading both lets a '
          'handler distinguish "the A key" from "the letter A".',
      gradient: <Color>[
        Color(0xFF38201A),
        Color(0xFF24140F),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _border, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: <Widget>[
                  _TblRow(
                    header: true,
                    flex: <int>[3, 3, 2, 4],
                    cells: <String>[
                      'physicalKey',
                      'logicalKey',
                      'character',
                      'context (modifiers / layout)',
                    ],
                  ),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'keyA',
                    'keyA',
                    '"a"',
                    'US QWERTY, no modifiers',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'keyA',
                    'keyA',
                    '"A"',
                    'US QWERTY, Shift held',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'keyA',
                    'keyA',
                    'null',
                    'CapsLock toggling (some hosts)',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'keyQ',
                    'keyA',
                    '"a"',
                    'FR AZERTY, no modifiers',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'keyQ',
                    'keyA',
                    '"A"',
                    'FR AZERTY, Shift held',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'digit2',
                    'digit2',
                    '"2"',
                    'US QWERTY',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'digit2',
                    'digit2',
                    '"@"',
                    'US QWERTY + Shift',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'digit2',
                    'digit2',
                    '"é"',
                    'FR AZERTY (top-row 2 yields é)',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'space',
                    'space',
                    '" "',
                    'spacebar',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'enter',
                    'enter',
                    '"\\n"',
                    'return key — character is newline',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'escape',
                    'escape',
                    'null',
                    'no produced text',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'shiftLeft',
                    'shiftLeft',
                    'null',
                    'pure modifier — never has character',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'controlLeft',
                    'controlLeft',
                    'null',
                    'pure modifier',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'f1',
                    'f1',
                    'null',
                    'function key, no glyph',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'arrowUp',
                    'arrowUp',
                    'null',
                    'navigation, no glyph',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'numpad1',
                    'numpad1',
                    '"1"',
                    'NumLock on',
                  ]),
                  _TblRow(flex: <int>[3, 3, 2, 4], cells: <String>[
                    'numpad1',
                    'end',
                    'null',
                    'NumLock off → numpad1 becomes End',
                  ]),
                ],
              ),
            ),
          ),
          SizedBox(height: 14),
          _Bullet(
            icon: Icons.info,
            color: _accent2,
            text: 'Rule of thumb: bind shortcuts on logicalKey. Bind text '
                'input on character. Bind gameplay controls on physicalKey.',
          ),
          _Bullet(
            icon: Icons.warning_amber_rounded,
            color: _accent3,
            text: 'character is String? — always null-check it. Many real '
                'keys (modifiers, function keys, arrows, escape) produce no '
                'character at all.',
          ),
          _Bullet(
            icon: Icons.swap_horiz,
            color: _accent5,
            text: 'logicalKey can change identity when NumLock toggles '
                '(numpad keys), but physicalKey stays the same.',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 7 — HardwareKeyboard integration diagram
// ============================================================================

class _HardwareKeyboardSection extends StatelessWidget {
  const _HardwareKeyboardSection();

  Widget _pipelineNode({
    required String title,
    required String sub,
    required Color color,
    required IconData icon,
    double width = 170,
  }) {
    return Container(
      width: width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.30),
            color.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 16),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _text,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            sub,
            style: TextStyle(
              color: _muted,
              fontSize: 10.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'INTEGRATION',
      title: 'How KeyDownEvent gets into your widget',
      subtitle:
          'Below: the path a hardware key press takes from the OS into a '
          'Flutter widget. KeyDownEvent is produced by the framework\'s '
          'embedding layer, fanned out by HardwareKeyboard, and surfaced to '
          'your code through several entry points.',
      gradient: <Color>[
        Color(0xFF0E2B3E),
        Color(0xFF0A1E2C),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 10,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              _pipelineNode(
                title: 'OS / Embedder',
                sub: 'Native key event from Windows/macOS/Linux/Android/iOS/Web.',
                color: _accent6,
                icon: Icons.computer,
              ),
              _Arrow(label: 'embed', color: _muted),
              _pipelineNode(
                title: 'HardwareKeyboard',
                sub: 'Singleton. Tracks pressed-key state and dispatches.',
                color: _accent2,
                icon: Icons.hub,
              ),
              _Arrow(label: 'dispatch', color: _muted),
              _pipelineNode(
                title: 'Focus / Shortcuts',
                sub: 'FocusNode chain + Shortcuts/Actions resolution.',
                color: _accent,
                icon: Icons.account_tree,
              ),
              _Arrow(label: 'deliver', color: _muted),
              _pipelineNode(
                title: 'Your handler',
                sub: 'onKeyEvent, KeyboardListener, or Shortcut action.',
                color: _accent5,
                icon: Icons.keyboard,
              ),
            ],
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _CodeBlock(
                  title: 'HardwareKeyboard.instance.addHandler',
                  code: 'bool _onKey(KeyEvent event) {\n'
                      '  if (event is KeyDownEvent &&\n'
                      '      event.logicalKey == LogicalKeyboardKey.escape) {\n'
                      '    // Handle ESC. Return true to mark as handled\n'
                      '    // and stop propagation to other handlers.\n'
                      '    return true;\n'
                      '  }\n'
                      '  return false;\n'
                      '}\n'
                      '\n'
                      'void wire() {\n'
                      '  HardwareKeyboard.instance.addHandler(_onKey);\n'
                      '}\n'
                      '\n'
                      'void unwire() {\n'
                      '  HardwareKeyboard.instance.removeHandler(_onKey);\n'
                      '}',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _CodeBlock(
                  title: 'KeyboardListener widget',
                  code: 'KeyboardListener(\n'
                      '  focusNode: FocusNode(),\n'
                      '  autofocus: true,\n'
                      '  onKeyEvent: (KeyEvent event) {\n'
                      '    if (event is KeyDownEvent) {\n'
                      '      debugPrint("down: \${event.logicalKey}");\n'
                      '    } else if (event is KeyRepeatEvent) {\n'
                      '      debugPrint("repeat");\n'
                      '    } else if (event is KeyUpEvent) {\n'
                      '      debugPrint("up");\n'
                      '    }\n'
                      '  },\n'
                      '  child: const ColoredBox(\n'
                      '    color: Colors.black,\n'
                      '  ),\n'
                      ');',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _panel.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _border, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'HardwareKeyboard — useful read-only state',
                  style: TextStyle(
                    color: _text,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                _Bullet(
                  icon: Icons.fingerprint,
                  color: _accent2,
                  text:
                      'HardwareKeyboard.instance.logicalKeysPressed — Set of '
                      'currently-pressed LogicalKeyboardKey values.',
                ),
                _Bullet(
                  icon: Icons.fingerprint,
                  color: _accent3,
                  text:
                      'HardwareKeyboard.instance.physicalKeysPressed — Set of '
                      'currently-pressed PhysicalKeyboardKey values.',
                ),
                _Bullet(
                  icon: Icons.check_box_outlined,
                  color: _accent5,
                  text:
                      'HardwareKeyboard.instance.isLogicalKeyPressed(...) — '
                      'fast membership check; use this for modifier polling '
                      'rather than tracking down/up yourself.',
                ),
                _Bullet(
                  icon: Icons.check_box_outlined,
                  color: _accent4,
                  text:
                      'HardwareKeyboard.instance.isControlPressed / '
                      'isShiftPressed / isAltPressed / isMetaPressed — '
                      'convenient modifier-state shortcuts.',
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
// SECTION 8 — Sample handler code snippet gallery
// ============================================================================

class _HandlerSnippetGallerySection extends StatelessWidget {
  const _HandlerSnippetGallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'SNIPPETS',
      title: 'Real-world KeyDownEvent handlers',
      subtitle:
          'Five common shapes you will write in production code. Each snippet '
          'is purely illustrative and could be dropped into a real Flutter app '
          'with minimal adjustment.',
      gradient: <Color>[
        Color(0xFF11233F),
        Color(0xFF0A1830),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _CodeBlock(
            title: '1. Detect an arrow-key press (KeyDownEvent only, no repeats)',
            code: 'bool onlyDownArrows(KeyEvent event) {\n'
                '  if (event is! KeyDownEvent) return false;\n'
                '  switch (event.logicalKey) {\n'
                '    case LogicalKeyboardKey.arrowUp:    moveUp();    return true;\n'
                '    case LogicalKeyboardKey.arrowDown:  moveDown();  return true;\n'
                '    case LogicalKeyboardKey.arrowLeft:  moveLeft();  return true;\n'
                '    case LogicalKeyboardKey.arrowRight: moveRight(); return true;\n'
                '  }\n'
                '  return false;\n'
                '}',
          ),
          SizedBox(height: 12),
          _CodeBlock(
            title:
                '2. Continuous movement — accept BOTH KeyDownEvent and KeyRepeatEvent',
            code: 'bool moveWhileHeld(KeyEvent event) {\n'
                '  final isPress = event is KeyDownEvent || event is KeyRepeatEvent;\n'
                '  if (!isPress) return false;\n'
                '  if (event.logicalKey == LogicalKeyboardKey.arrowRight) {\n'
                '    cursorX += 1;\n'
                '    return true;\n'
                '  }\n'
                '  return false;\n'
                '}',
          ),
          SizedBox(height: 12),
          _CodeBlock(
            title: '3. Modifier-aware shortcut (Ctrl+S to save)',
            code: 'bool onCtrlS(KeyEvent event) {\n'
                '  if (event is! KeyDownEvent) return false;\n'
                '  final isCtrl = HardwareKeyboard.instance.isControlPressed;\n'
                '  if (isCtrl && event.logicalKey == LogicalKeyboardKey.keyS) {\n'
                '    save();\n'
                '    return true; // swallow so the browser doesn\'t save HTML\n'
                '  }\n'
                '  return false;\n'
                '}',
          ),
          SizedBox(height: 12),
          _CodeBlock(
            title: '4. WASD game input — bind on physicalKey, not logicalKey',
            code: 'bool wasd(KeyEvent event) {\n'
                '  if (event is! KeyDownEvent && event is! KeyRepeatEvent) return false;\n'
                '  switch (event.physicalKey) {\n'
                '    case PhysicalKeyboardKey.keyW: forward();  return true;\n'
                '    case PhysicalKeyboardKey.keyA: strafeL();  return true;\n'
                '    case PhysicalKeyboardKey.keyS: backward(); return true;\n'
                '    case PhysicalKeyboardKey.keyD: strafeR();  return true;\n'
                '  }\n'
                '  return false;\n'
                '}',
          ),
          SizedBox(height: 12),
          _CodeBlock(
            title: '5. Text-style handler — use character, not logicalKey',
            code: 'bool textInput(KeyEvent event) {\n'
                '  if (event is! KeyDownEvent && event is! KeyRepeatEvent) return false;\n'
                '  final ch = event.character;\n'
                '  if (ch == null || ch.isEmpty) return false;\n'
                '  buffer.write(ch); // already reflects Shift / AltGr\n'
                '  return true;\n'
                '}',
          ),
          SizedBox(height: 12),
          _CodeBlock(
            title: '6. Time-delta debug log',
            code: 'Duration? _lastTs;\n'
                'bool log(KeyEvent event) {\n'
                '  if (event is! KeyDownEvent) return false;\n'
                '  final delta = _lastTs == null\n'
                '      ? Duration.zero\n'
                '      : event.timeStamp - _lastTs!;\n'
                '  _lastTs = event.timeStamp;\n'
                '  debugPrint(\n'
                '    "down \${event.logicalKey.debugName.padRight(14)} "\n'
                '    "+\${delta.inMilliseconds}ms",\n'
                '  );\n'
                '  return false; // observe only\n'
                '}',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 9 — Pitfalls
// ============================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  Widget _pitfall({
    required String title,
    required String body,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: color.withValues(alpha: 0.6), width: 1),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 18),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: _text,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    color: _muted,
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

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'PITFALLS',
      title: 'Things that will trip you up',
      subtitle:
          'Production keyboard code is full of edge cases. The framework '
          'papers over most of them, but a few escape into your handlers — '
          'these are the most common.',
      gradient: <Color>[
        Color(0xFF3A1422),
        Color(0xFF24101A),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _pitfall(
            title: 'KeyUpEvent is not guaranteed',
            color: _accent4,
            icon: Icons.signal_wifi_off,
            body:
                'On web in particular, a key-up can be lost when the window '
                'loses focus (Alt-Tab, command palette, browser dev tools '
                'capturing the key). Always design state machines so that an '
                'eventually-missing KeyUpEvent does not leave you stuck in a '
                '"key still pressed" state.',
          ),
          _pitfall(
            title: 'Synthesized events look real',
            color: _accent3,
            icon: Icons.auto_awesome,
            body:
                'When focus is regained, the framework may emit synthesized '
                'KeyDownEvent / KeyUpEvent so HardwareKeyboard\'s pressed-set '
                'matches reality. If your handler triggers gameplay actions on '
                'every down, gate them with `if (!event.synthesized)`.',
          ),
          _pitfall(
            title: 'Shortcut handlers can swallow events',
            color: _accent6,
            icon: Icons.block,
            body:
                'A higher-level Shortcuts widget that handles a KeyDownEvent '
                'returns KeyEventResult.handled, and the event is not '
                'propagated further. This is why your custom onKeyEvent in '
                'a focus subtree sometimes "never fires" for some keys.',
          ),
          _pitfall(
            title: 'character is null more often than you think',
            color: _accent2,
            icon: Icons.text_decrease,
            body:
                'Modifier keys, function keys, arrows, Home/End/PageUp/Down, '
                'Insert, and even some platform-specific keys produce '
                'character == null. Never assume `event.character!` is safe.',
          ),
          _pitfall(
            title: 'Repeat cadence is OS-controlled',
            color: _accent5,
            icon: Icons.speed,
            body:
                'KeyRepeatEvent timing depends on the user\'s OS auto-repeat '
                'settings, not Flutter. Do not use it as a timer; if you need '
                'a fixed cadence, accept the first KeyDownEvent and drive '
                'subsequent updates from your own game loop.',
          ),
          _pitfall(
            title: 'IME / dead keys can suppress events',
            color: _accent,
            icon: Icons.language,
            body:
                'When an Input Method Editor is composing (CJK, accented '
                'Latin via dead keys, etc.), some KeyDownEvent instances may '
                'be intercepted by the IME and never reach Flutter. Use '
                'TextField + TextInputAction for actual text composition.',
          ),
          _pitfall(
            title: 'logicalKey identity, not equality of debugName',
            color: _accent4,
            icon: Icons.compare_arrows,
            body:
                'Compare logicalKey by identity (`==` against canonical '
                'constants like LogicalKeyboardKey.escape), not by parsing '
                'debugName. debugName is for diagnostics; its format is not '
                'a stable API.',
          ),
          _pitfall(
            title: 'Web duplicate handlers',
            color: _accent3,
            icon: Icons.web,
            body:
                'On web, a key can travel through the browser, Flutter, and '
                'back if your app embeds a webview or uses platform views. '
                'Return true from handlers that fully consume the key to '
                'avoid double-processing.',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 10 — Migration cheat sheet (RawKeyDownEvent → KeyDownEvent)
// ============================================================================

class _MigrationCheatSheetSection extends StatelessWidget {
  const _MigrationCheatSheetSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'MIGRATION',
      title: 'From RawKeyDownEvent → KeyDownEvent',
      subtitle:
          'The legacy "raw" key API (RawKeyboard, RawKeyEvent, RawKeyDownEvent, '
          'RawKeyUpEvent) is now considered the previous generation. New code '
          'should use HardwareKeyboard + KeyEvent. This cheat-sheet maps the '
          'most common operations between the two APIs.',
      gradient: <Color>[
        Color(0xFF231336),
        Color(0xFF160A24),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _border, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: <Widget>[
                  _TblRow(
                    header: true,
                    flex: <int>[5, 5],
                    cells: <String>[
                      'legacy (RawKey*)',
                      'modern (HardwareKeyboard / KeyEvent)',
                    ],
                  ),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'RawKeyEvent (sealed-ish)',
                    'KeyEvent (true sealed)',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'RawKeyDownEvent',
                    'KeyDownEvent',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'RawKeyUpEvent',
                    'KeyUpEvent',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    '— (no analogue)',
                    'KeyRepeatEvent',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'RawKeyboard.instance.addListener',
                    'HardwareKeyboard.instance.addHandler',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'RawKeyboardListener',
                    'KeyboardListener',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'event.data.physicalKey',
                    'event.physicalKey',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'event.data.logicalKey',
                    'event.logicalKey',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'event.character',
                    'event.character',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'event.data.isModifierPressed(...)',
                    'HardwareKeyboard.instance.isShiftPressed etc.',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'RawKeyboard.instance.keysPressed',
                    'HardwareKeyboard.instance.logicalKeysPressed',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'event.repeat (bool)',
                    'event is KeyRepeatEvent',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'event.data.keyLabel',
                    '(use logicalKey.keyLabel)',
                  ]),
                  _TblRow(flex: <int>[5, 5], cells: <String>[
                    'platform-specific RawKeyEventData* casts',
                    'no longer required — KeyEvent is uniform',
                  ]),
                ],
              ),
            ),
          ),
          SizedBox(height: 18),
          _CodeBlock(
            title: 'Before — RawKeyDownEvent',
            code: 'RawKeyboard.instance.addListener((RawKeyEvent event) {\n'
                '  if (event is RawKeyDownEvent) {\n'
                '    if (event.logicalKey == LogicalKeyboardKey.escape) {\n'
                '      Navigator.pop(context);\n'
                '    }\n'
                '  }\n'
                '});',
          ),
          SizedBox(height: 10),
          _CodeBlock(
            title: 'After — KeyDownEvent',
            code: 'HardwareKeyboard.instance.addHandler((KeyEvent event) {\n'
                '  if (event is KeyDownEvent &&\n'
                '      event.logicalKey == LogicalKeyboardKey.escape) {\n'
                '    Navigator.pop(context);\n'
                '    return true;\n'
                '  }\n'
                '  return false;\n'
                '});',
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _accent5.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: _accent5.withValues(alpha: 0.45), width: 1),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline,
                    color: _accent5, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Bonus: the modern handler returns bool. Returning true '
                    'marks the event as handled, which short-circuits other '
                    'handlers and (on web) prevents the browser default. '
                    'RawKeyboard had no such return-value contract.',
                    style: TextStyle(
                      color: _text,
                      fontSize: 13,
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

// ============================================================================
// SECTION 11 — Footer
// ============================================================================

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF0A0D1A),
            Color(0xFF14182C),
            Color(0xFF1A0B3E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: <double>[0.0, 0.5, 1.0],
        ),
        border: Border(
          top: BorderSide(color: _accent.withValues(alpha: 0.45), width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.keyboard_alt_outlined,
                  color: _accent2, size: 22),
              SizedBox(width: 10),
              Text(
                'End of KeyDownEvent deep demo',
                style: TextStyle(
                  color: _text,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'This file is a static visual reference. It does not exercise any '
            'real keyboard hardware, focus tree, or HardwareKeyboard instance '
            '— it just renders an explainer surface that can be screenshotted, '
            'embedded into documentation, or used as a snapshot test target.',
            style: TextStyle(
              color: _muted,
              fontSize: 13,
              height: 1.55,
            ),
          ),
          SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _Chip(label: 'Flutter Material', color: _accent2),
              _Chip(label: 'KeyEvent', color: _accent3),
              _Chip(label: 'HardwareKeyboard', color: _accent4),
              _Chip(label: 'Shortcuts/Actions', color: _accent5),
              _Chip(label: 'Static demo', color: _accent6),
              _Chip(label: '11 sections', color: _accent),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _panel.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _border, width: 1),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.info_outline,
                    color: _muted, size: 14),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'No Stateful widgets · No Timers · No Streams · No Futures '
                    '· Only package:flutter/material.dart',
                    style: TextStyle(
                      color: _muted,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
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
