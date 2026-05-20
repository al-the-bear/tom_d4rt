// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// RawKeyEventDataLinux — Visual Deep Demo
// ---------------------------------------------------------------------------
// A long-form, hand-drawn dossier about RawKeyEventDataLinux, the legacy
// Linux-side adapter that converted GTK and GLFW key events into Flutter's
// RawKeyEvent stream. Each section is rendered as a Ubuntu / GNOME flavored
// section card — terracotta orange, aubergine, gtk blue, terminal green —
// against a warm paper background so the layout reads like a printed
// engineering brief rather than a runtime panel.
// ---------------------------------------------------------------------------

class _Pal {
  // Paper / aubergine base
  static const Color paper = Color(0xFFF2EFE8);
  static const Color paperWarm = Color(0xFFE9E2D2);
  static const Color ink = Color(0xFF2C001E); // Ubuntu aubergine
  static const Color inkSoft = Color(0xFF4A1E3C);
  static const Color rule = Color(0xFFC9BFA9);
  static const Color ruleSoft = Color(0xFFDDD3BC);

  // Ubuntu / GNOME accents
  static const Color ubuOrange = Color(0xFFE95420); // Ubuntu accent
  static const Color ubuOrangeSoft = Color(0xFFF7AB8A);
  static const Color aubergine = Color(0xFF2C001E);
  static const Color aubergineSoft = Color(0xFF77216F);
  static const Color gtkBlue = Color(0xFF3584E4);
  static const Color gtkBlueSoft = Color(0xFF99C1F1);
  static const Color termGreen = Color(0xFF26A269);
  static const Color termGreenSoft = Color(0xFF8FF0A4);
  static const Color amber = Color(0xFFE5A50A);
  static const Color amberSoft = Color(0xFFF6D32D);
  static const Color crimson = Color(0xFFC01C28);
  static const Color crimsonSoft = Color(0xFFED333B);
  static const Color teal = Color(0xFF0E8088);
  static const Color tealSoft = Color(0xFF33C7DE);

  // Text
  static const Color text = Color(0xFF2C001E);
  static const Color textDim = Color(0xFF5E3D54);
  static const Color textMuted = Color(0xFF8A6E80);

  // Code surface — looks like a GNOME Terminal pane
  static const Color termBg = Color(0xFF1E1E1E);
  static const Color termPanel = Color(0xFF2D2D2D);
  static const Color termGutter = Color(0xFF3A3A3A);
  static const Color termText = Color(0xFFEEEEEC);
  static const Color termComment = Color(0xFF8F8F8F);
  static const Color termKw = Color(0xFFF9CC6C);
  static const Color termStr = Color(0xFF8FF0A4);
  static const Color termNum = Color(0xFFFF8A5C);
  static const Color termType = Color(0xFF99C1F1);
  static const Color termIdent = Color(0xFFEEEEEC);
}

class _T {
  static const TextStyle heroTitle = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w800,
    color: _Pal.ink,
    letterSpacing: 0.4,
    height: 1.05,
  );
  static const TextStyle heroSub = TextStyle(
    fontSize: 16,
    color: _Pal.inkSoft,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 1.4,
  );
  static const TextStyle heroLead = TextStyle(
    fontSize: 14,
    color: _Pal.textDim,
    height: 1.55,
  );
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: _Pal.ink,
    letterSpacing: 0.3,
  );
  static const TextStyle sectionLead = TextStyle(
    fontSize: 13.5,
    color: _Pal.textDim,
    height: 1.55,
  );
  static const TextStyle body = TextStyle(
    fontSize: 13,
    color: _Pal.text,
    height: 1.55,
  );
  static const TextStyle bodyDim = TextStyle(
    fontSize: 13,
    color: _Pal.textDim,
    height: 1.55,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    color: _Pal.textMuted,
    letterSpacing: 0.7,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle mono = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12.5,
    color: _Pal.text,
    height: 1.5,
  );
  static const TextStyle monoDim = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Pal.textDim,
  );
  static const TextStyle term = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Pal.termText,
    height: 1.55,
  );
  static const TextStyle termKw = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Pal.termKw,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle termStr = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Pal.termStr,
  );
  static const TextStyle termNum = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Pal.termNum,
  );
  static const TextStyle termType = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Pal.termType,
  );
  static const TextStyle termComment = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Pal.termComment,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle termIdent = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Pal.termIdent,
  );
}

// ---------------------------------------------------------------------------
// Section frame — newspaper-style numbered card
// ---------------------------------------------------------------------------
class _Section extends StatelessWidget {
  final String index;
  final String title;
  final String? lead;
  final Color accent;
  final Widget child;
  const _Section({
    required this.index,
    required this.title,
    required this.accent,
    required this.child,
    this.lead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Pal.rule, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: _Pal.ink.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header strip — Ubuntu-style title bar
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accent.withValues(alpha: 0.18),
                  accent.withValues(alpha: 0.04),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              border: Border(
                bottom: BorderSide(
                  color: accent.withValues(alpha: 0.45),
                  width: 1.2,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accent,
                        accent.withValues(alpha: 0.65),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.35),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      index,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: _T.sectionTitle),
                      if (lead != null) ...[
                        const SizedBox(height: 4),
                        Text(lead!, style: _T.sectionLead),
                      ],
                    ],
                  ),
                ),
                // Window dots — GNOME style
                const _WindowDots(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _WindowDots extends StatelessWidget {
  const _WindowDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dot(_Pal.crimsonSoft),
        const SizedBox(width: 5),
        _dot(_Pal.amberSoft),
        const SizedBox(width: 5),
        _dot(_Pal.termGreenSoft),
      ],
    );
  }

  Widget _dot(Color c) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: c,
        shape: BoxShape.circle,
        border: Border.all(color: _Pal.ink.withValues(alpha: 0.18)),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Terminal-style code block (GNOME Terminal aesthetic)
// ---------------------------------------------------------------------------
class _Tok {
  final String text;
  final TextStyle style;
  const _Tok(this.text, this.style);
}

class _Ln {
  final List<_Tok> tokens;
  const _Ln(this.tokens);
  static _Ln blank() => const _Ln([_Tok('', _T.term)]);
  static _Ln plain(String s) => _Ln([_Tok(s, _T.term)]);
}

class _Term extends StatelessWidget {
  final String? title;
  final List<_Ln> lines;
  const _Term({required this.lines, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _Pal.termBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Pal.ink.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: _Pal.ink.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Terminal title bar
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _Pal.termPanel,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
              border: Border(
                bottom: BorderSide(
                  color: _Pal.ink.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                const _WindowDots(),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title ?? 'Terminal — dart',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: _Pal.termText,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Text(
                  'gnome-terminal',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: _Pal.termComment,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < lines.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 28,
                          child: Text(
                            '${i + 1}'.padLeft(2),
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              color: _Pal.termGutter,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: _T.term,
                              children: [
                                for (final tok in lines[i].tokens)
                                  TextSpan(text: tok.text, style: tok.style),
                              ],
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
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pill / chip
// ---------------------------------------------------------------------------
class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.7),
          width: 1.1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 0 — Deprecation banner (Ubuntu warning aesthetic)
// ---------------------------------------------------------------------------
class _DeprecationBanner extends StatelessWidget {
  const _DeprecationBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _Pal.ubuOrange.withValues(alpha: 0.95),
            _Pal.crimson.withValues(alpha: 0.85),
            _Pal.aubergine.withValues(alpha: 0.95),
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _Pal.ubuOrange.withValues(alpha: 0.9),
          width: 1.6,
        ),
        boxShadow: [
          BoxShadow(
            color: _Pal.ubuOrange.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _Pal.amberSoft,
                  _Pal.ubuOrange,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: _Pal.amber.withValues(alpha: 0.55),
                  blurRadius: 16,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                '!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4)),
                      ),
                      child: const Text(
                        '@Deprecated',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'LEGACY · RawKeyboard family',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'RawKeyEventDataLinux is part of the deprecated raw '
                  'keyboard subsystem. Modern Flutter code should consume '
                  'KeyEvent objects through HardwareKeyboard.instance, '
                  'KeyboardListener, or Focus.onKeyEvent, and resolve keys '
                  'via LogicalKeyboardKey / PhysicalKeyboardKey. The Linux '
                  'wrapper survives only for the migration window.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: const [
                    _BannerChip('use HardwareKeyboard'),
                    _BannerChip('use KeyEvent'),
                    _BannerChip('use LogicalKeyboardKey'),
                    _BannerChip('use PhysicalKeyboardKey'),
                    _BannerChip('migration ongoing'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerChip extends StatelessWidget {
  final String label;
  const _BannerChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 1 — Hero card
// ---------------------------------------------------------------------------
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 26),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _Pal.aubergine,
            _Pal.aubergineSoft.withValues(alpha: 0.85),
            _Pal.ubuOrange.withValues(alpha: 0.75),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _Pal.ubuOrange.withValues(alpha: 0.55),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: _Pal.aubergine.withValues(alpha: 0.35),
            blurRadius: 26,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _heroTag('flutter/services', _Pal.ubuOrangeSoft),
              const SizedBox(width: 8),
              _heroTag('linux', _Pal.gtkBlueSoft),
              const SizedBox(width: 8),
              _heroTag('legacy', _Pal.amberSoft),
              const SizedBox(width: 8),
              _heroTag('GTK · GLFW', _Pal.termGreenSoft),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'RawKeyEventDataLinux',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.5,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'GTK / X11 key data anatomy',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.92),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Surfaces a snapshot of a key event as the Linux embedder produced '
            'it: a KeyHelper that names the toolkit (GTK or GLFW), the X11 '
            'keyval / keycode, the hardware scancode, the unicodeScalarValues '
            'returned by the toolkit, and the modifiers bitmask. Accessed as '
            '(rawEvent.data as RawKeyEventDataLinux).',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _HeroFact('keyHelper', 'GTK | GLFW', _Pal.gtkBlueSoft),
              _HeroFact('keyCode', 'X11 keyval', _Pal.ubuOrangeSoft),
              _HeroFact('scanCode', 'evdev hw code', _Pal.termGreenSoft),
              _HeroFact('modifiers', 'GDK bitmask', _Pal.amberSoft),
              _HeroFact('unicodeScalarValues', 'int', _Pal.tealSoft),
              _HeroFact('isDown', 'bool', _Pal.crimsonSoft),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1.1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _HeroFact extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _HeroFact(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.6),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 2 — Subclass hierarchy diagram (Linux highlighted)
// ---------------------------------------------------------------------------
class _Hierarchy extends StatelessWidget {
  const _Hierarchy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Parent abstract class node
        Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _Pal.aubergine,
                  _Pal.aubergineSoft,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: _Pal.aubergine.withValues(alpha: 0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Column(
              children: [
                Text(
                  'abstract class',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFE0CADA),
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'RawKeyEventData',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Vertical connector
        Center(
          child: Container(
            width: 2,
            height: 20,
            color: _Pal.aubergineSoft,
          ),
        ),
        // Horizontal rail
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Container(
            height: 2,
            color: _Pal.aubergineSoft,
          ),
        ),
        const SizedBox(height: 4),
        // Six subclass boxes
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(child: _SubclassNode(name: 'Android', code: 'AOSP',
                color: _Pal.termGreen, highlighted: false)),
            SizedBox(width: 6),
            Expanded(child: _SubclassNode(name: 'iOS', code: 'UIKey',
                color: _Pal.gtkBlue, highlighted: false)),
            SizedBox(width: 6),
            Expanded(child: _SubclassNode(name: 'Linux', code: 'GTK/GLFW',
                color: _Pal.ubuOrange, highlighted: true)),
            SizedBox(width: 6),
            Expanded(child: _SubclassNode(name: 'MacOS', code: 'NSEvent',
                color: _Pal.aubergineSoft, highlighted: false)),
            SizedBox(width: 6),
            Expanded(child: _SubclassNode(name: 'Web', code: 'KeyboardEvent',
                color: _Pal.teal, highlighted: false)),
            SizedBox(width: 6),
            Expanded(child: _SubclassNode(name: 'Windows', code: 'VK_*',
                color: _Pal.crimson, highlighted: false)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _Pal.ubuOrange.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: _Pal.ubuOrange.withValues(alpha: 0.45)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.fiber_manual_record,
                  size: 12, color: _Pal.ubuOrange),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'RawKeyEventDataLinux is the variant emitted by the Linux '
                  'embedder. It is uniquely identified by carrying a KeyHelper '
                  'instance — neither Android nor Web nor any other subclass '
                  'exposes that field — which in turn names whether the '
                  'producing toolkit is GTK or GLFW.',
                  style: _T.body,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SubclassNode extends StatelessWidget {
  final String name;
  final String code;
  final Color color;
  final bool highlighted;
  const _SubclassNode({
    required this.name,
    required this.code,
    required this.color,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 2,
          height: 16,
          color: _Pal.aubergineSoft,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
          decoration: BoxDecoration(
            gradient: highlighted
                ? LinearGradient(
                    colors: [
                      color,
                      color.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: highlighted ? null : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: highlighted
                  ? color
                  : color.withValues(alpha: 0.6),
              width: highlighted ? 2 : 1.1,
            ),
            boxShadow: highlighted
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.45),
                      blurRadius: 14,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Text(
                'RawKeyEventData',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 8.5,
                  color: highlighted
                      ? Colors.white.withValues(alpha: 0.8)
                      : _Pal.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: highlighted ? Colors.white : color,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: highlighted
                      ? Colors.white.withValues(alpha: 0.2)
                      : color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  code,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    color: highlighted ? Colors.white : color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 3 — Field anatomy (one labeled card per field)
// ---------------------------------------------------------------------------
class _FieldAnatomy extends StatelessWidget {
  const _FieldAnatomy();

  @override
  Widget build(BuildContext context) {
    final fields = <_FieldSpec>[
      _FieldSpec(
        name: 'keyHelper',
        type: 'KeyHelper',
        example: 'GtkKeyHelper / GLFWKeyHelper',
        glyph: 'KH',
        color: _Pal.gtkBlue,
        role:
            'Strategy object that names the originating toolkit and supplies '
            'modifier-mask constants. Two concrete subclasses ship today: '
            'GtkKeyHelper (default on GNOME / most distros) and '
            'GLFWKeyHelper (used when Flutter is hosted inside a GLFW '
            'window). Helper selection is per-event, not per-process.',
      ),
      _FieldSpec(
        name: 'unicodeScalarValues',
        type: 'int',
        example: '97 for "a", 0 for arrow keys',
        glyph: 'U+',
        color: _Pal.termGreen,
        role:
            'The Unicode scalar(s) the toolkit decided this press produces, '
            'packed into a single int. Zero is the canonical "no character" '
            'sentinel — used by function keys, arrow keys, and pure modifier '
            'presses. Locale and dead-key composition both feed into this.',
      ),
      _FieldSpec(
        name: 'keyCode',
        type: 'int',
        example: 'GDK_KEY_a = 0x0061',
        glyph: 'KC',
        color: _Pal.ubuOrange,
        role:
            'The platform key code: under GTK this is a GDK keyval (e.g. '
            'GDK_KEY_a == 0x0061); under GLFW this is the GLFW key constant '
            '(e.g. GLFW_KEY_A == 65). It is layout-aware but modifier-naive: '
            'Shift+a still arrives as the lowercase keyval.',
      ),
      _FieldSpec(
        name: 'scanCode',
        type: 'int',
        example: 'evdev KEY_A = 38',
        glyph: 'SC',
        color: _Pal.amber,
        role:
            'The hardware scan code lifted straight from the kernel input '
            'layer (evdev). This is layout-independent: physical "A" on '
            'a QWERTY board produces the same scancode whether the active '
            'layout is QWERTY, AZERTY, or Dvorak.',
      ),
      _FieldSpec(
        name: 'modifiers',
        type: 'int',
        example: 'GDK_SHIFT_MASK | GDK_CONTROL_MASK',
        glyph: 'M',
        color: _Pal.aubergineSoft,
        role:
            'A bitmask of modifier flags. The numerical values come from the '
            'helper — GTK and GLFW use different bit positions, so reading '
            'modifiers without consulting keyHelper is a portability bug. '
            'Use the isXPressed getters whenever possible.',
      ),
      _FieldSpec(
        name: 'isDown',
        type: 'bool',
        example: 'true for KeyDown, false for KeyUp',
        glyph: 'v',
        color: _Pal.crimson,
        role:
            'True when this event represents a press, false for a release. '
            'Combined with the keyCode it determines whether modifier '
            'helpers should consider the key currently active for the lock-'
            'style modifiers (CapsLock / NumLock / ScrollLock).',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < fields.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _FieldCard(spec: fields[i], index: i + 1),
          ),
      ],
    );
  }
}

class _FieldSpec {
  final String name;
  final String type;
  final String example;
  final String glyph;
  final Color color;
  final String role;
  const _FieldSpec({
    required this.name,
    required this.type,
    required this.example,
    required this.glyph,
    required this.color,
    required this.role,
  });
}

class _FieldCard extends StatelessWidget {
  final _FieldSpec spec;
  final int index;
  const _FieldCard({required this.spec, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Pal.paper,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: spec.color.withValues(alpha: 0.55),
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  spec.color,
                  spec.color.withValues(alpha: 0.55),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                  color: spec.color.withValues(alpha: 0.35),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Center(
              child: Text(
                spec.glyph,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: spec.color.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '#${index.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: spec.color,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      spec.name,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 15,
                        color: _Pal.ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      spec.type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: spec.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(spec.role, style: _T.body),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: spec.color.withValues(alpha: 0.35)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('e.g. ',
                          style: _T.caption.copyWith(fontSize: 10)),
                      Text(
                        spec.example,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          color: spec.color,
                          fontWeight: FontWeight.w700,
                        ),
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
}

// ---------------------------------------------------------------------------
// SECTION 4 — KeyHelper variant comparison (GTK vs GLFW)
// ---------------------------------------------------------------------------
class _KeyHelperCompare extends StatelessWidget {
  const _KeyHelperCompare();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: _HelperCard(
                title: 'GtkKeyHelper',
                subtitle: 'Default · GNOME · most distros',
                accent: _Pal.gtkBlue,
                icon: 'G',
                selectedWhen:
                    'The Linux embedder is running under GTK — that is, '
                    'the standard desktop Flutter build on Linux. This is '
                    'the case the vast majority of the time.',
                masks: [
                  _MaskRow('Shift',     'GDK_SHIFT_MASK',   0x00000001),
                  _MaskRow('CapsLock',  'GDK_LOCK_MASK',    0x00000002),
                  _MaskRow('Control',   'GDK_CONTROL_MASK', 0x00000004),
                  _MaskRow('Alt',       'GDK_MOD1_MASK',    0x00000008),
                  _MaskRow('NumLock',   'GDK_MOD2_MASK',    0x00000010),
                  _MaskRow('Meta',      'GDK_META_MASK',    0x10000000),
                  _MaskRow('Super',     'GDK_SUPER_MASK',   0x04000000),
                ],
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: _HelperCard(
                title: 'GLFWKeyHelper',
                subtitle: 'Niche · GLFW-hosted Flutter shells',
                accent: _Pal.amber,
                icon: 'F',
                selectedWhen:
                    'The Linux embedder is hosted inside a GLFW window — '
                    'historically the original Flutter desktop prototype '
                    'and still used by some embedded / custom shells.',
                masks: [
                  _MaskRow('Shift',     'GLFW_MOD_SHIFT',     0x0001),
                  _MaskRow('Control',   'GLFW_MOD_CONTROL',   0x0002),
                  _MaskRow('Alt',       'GLFW_MOD_ALT',       0x0004),
                  _MaskRow('Super',     'GLFW_MOD_SUPER',     0x0008),
                  _MaskRow('CapsLock',  'GLFW_MOD_CAPS_LOCK', 0x0010),
                  _MaskRow('NumLock',   'GLFW_MOD_NUM_LOCK',  0x0020),
                  _MaskRow('Meta',      '(synthesized)',      0x0008),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _Pal.amber.withValues(alpha: 0.10),
                _Pal.ubuOrange.withValues(alpha: 0.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: _Pal.amber.withValues(alpha: 0.45)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded,
                  size: 18, color: _Pal.amber),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Note the GLFW Shift bit is 0x0001 while the Gtk Shift bit '
                  'is also 0x0001 — but only by coincidence. The Control '
                  'bits diverge: 0x0002 (GLFW) vs 0x0004 (GTK). Never read '
                  'modifiers as a raw int without going through the helper.',
                  style: _T.body,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MaskRow {
  final String name;
  final String constant;
  final int value;
  const _MaskRow(this.name, this.constant, this.value);
}

class _HelperCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color accent;
  final String icon;
  final String selectedWhen;
  final List<_MaskRow> masks;
  const _HelperCard({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.icon,
    required this.selectedWhen,
    required this.masks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: accent.withValues(alpha: 0.6),
          width: 1.3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent.withValues(alpha: 0.20),
                  accent.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accent,
                        accent.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      icon,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 15,
                            color: accent,
                            fontWeight: FontWeight.w800,
                          )),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: _T.caption.copyWith(fontSize: 10.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selected when',
                    style: _T.caption.copyWith(fontSize: 10)),
                const SizedBox(height: 4),
                Text(selectedWhen, style: _T.bodyDim),
                const SizedBox(height: 12),
                Text('Modifier masks',
                    style: _T.caption.copyWith(fontSize: 10)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: _Pal.paper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _Pal.rule),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < masks.length; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: i == masks.length - 1
                                    ? Colors.transparent
                                    : _Pal.rule.withValues(alpha: 0.6),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 58,
                                child: Text(
                                  masks[i].name,
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 11,
                                    color: _Pal.ink,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  masks[i].constant,
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 10.5,
                                    color: _Pal.textDim,
                                  ),
                                ),
                              ),
                              Text(
                                '0x${masks[i].value.toRadixString(16).toUpperCase().padLeft(8, '0')}',
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 10.5,
                                  color: accent,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
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
}

// ---------------------------------------------------------------------------
// SECTION 5 — Modifier mask grid (Shift, Ctrl, Alt, Meta, CapsLock, NumLock,
//             ScrollLock) shown as checkbox-style chips
// ---------------------------------------------------------------------------
class _ModifierGrid extends StatelessWidget {
  const _ModifierGrid();

  @override
  Widget build(BuildContext context) {
    final mods = <_ModSpec>[
      _ModSpec('Shift',      '⇧',  _Pal.gtkBlue,        0x00000001, true),
      _ModSpec('Control',    '⎈',  _Pal.ubuOrange,      0x00000004, true),
      _ModSpec('Alt',        '⌥',  _Pal.amber,          0x00000008, false),
      _ModSpec('Meta/Super', '✦',  _Pal.aubergineSoft,  0x04000000, false),
      _ModSpec('CapsLock',   'A',  _Pal.termGreen,      0x00000002, true),
      _ModSpec('NumLock',    '1',  _Pal.teal,           0x00000010, false),
      _ModSpec('ScrollLock', '↕',  _Pal.crimson,        0x00008000, false),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _Pal.paper,
                _Pal.paperWarm,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _Pal.rule),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _Pal.ink,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'GDK modifier sample',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: Colors.white,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Hypothetical event: Shift + Ctrl + CapsLock active',
                    style: _T.caption,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final m in mods) _ModChip(m),
                ],
              ),
              const SizedBox(height: 14),
              // Computed mask line
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: _Pal.termBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _Pal.ink),
                ),
                child: Row(
                  children: [
                    Text(
                      'modifiers =',
                      style: _T.term.copyWith(color: _Pal.termComment),
                    ),
                    const SizedBox(width: 8),
                    Text('0x00000007',
                        style: _T.term.copyWith(
                          color: _Pal.termNum,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(width: 8),
                    Text('//',
                        style: _T.term.copyWith(color: _Pal.termComment)),
                    const SizedBox(width: 4),
                    Text(
                      'SHIFT(1) | LOCK(2) | CONTROL(4)',
                      style: _T.term.copyWith(color: _Pal.termComment),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // Bitmask diagram visualization
        _BitmaskDiagram(mods: mods),
      ],
    );
  }
}

class _ModSpec {
  final String name;
  final String glyph;
  final Color color;
  final int mask;
  final bool active;
  const _ModSpec(this.name, this.glyph, this.color, this.mask, this.active);
}

class _ModChip extends StatelessWidget {
  final _ModSpec m;
  const _ModChip(this.m);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: m.active ? m.color : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: m.color,
          width: m.active ? 2 : 1.2,
        ),
        boxShadow: m.active
            ? [
                BoxShadow(
                  color: m.color.withValues(alpha: 0.45),
                  blurRadius: 10,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Checkbox-style indicator
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: m.active ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: m.active ? Colors.white : m.color,
                width: 1.4,
              ),
            ),
            child: m.active
                ? Icon(Icons.check, size: 13, color: m.color)
                : null,
          ),
          const SizedBox(width: 9),
          Text(
            m.glyph,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
              color: m.active ? Colors.white : m.color,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            m.name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: m.active ? Colors.white : _Pal.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '0x${m.mask.toRadixString(16).toUpperCase()}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: m.active
                  ? Colors.white.withValues(alpha: 0.85)
                  : m.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _BitmaskDiagram extends StatelessWidget {
  final List<_ModSpec> mods;
  const _BitmaskDiagram({required this.mods});

  @override
  Widget build(BuildContext context) {
    // Render bits 0..15 with labels for known mask positions.
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Pal.termBg,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: _Pal.ink),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GDK modifier bitfield · low 16 bits',
            style: _T.term.copyWith(color: _Pal.termComment),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (int b = 15; b >= 0; b--)
                Expanded(
                  child: _BitCell(
                    bit: b,
                    spec: _findFor(b),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              for (int b = 15; b >= 0; b--)
                Expanded(
                  child: Text(
                    b.toString().padLeft(2, '0'),
                    textAlign: TextAlign.center,
                    style: _T.term.copyWith(
                      fontSize: 9,
                      color: _Pal.termComment,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  _ModSpec? _findFor(int bit) {
    final m = 1 << bit;
    for (final mod in mods) {
      if (mod.mask == m) return mod;
    }
    return null;
  }
}

class _BitCell extends StatelessWidget {
  final int bit;
  final _ModSpec? spec;
  const _BitCell({required this.bit, required this.spec});

  @override
  Widget build(BuildContext context) {
    final color = spec?.color ?? _Pal.termGutter;
    final filled = spec != null && spec!.active;
    final reserved = spec != null;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      height: 30,
      decoration: BoxDecoration(
        color: filled
            ? color
            : reserved
                ? color.withValues(alpha: 0.20)
                : _Pal.termPanel,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: reserved
              ? color.withValues(alpha: 0.85)
              : _Pal.termGutter,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          filled ? '1' : '0',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: filled
                ? Colors.white
                : reserved
                    ? color
                    : _Pal.termGutter,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 6 — Physical key mapping (stylized Linux keyboard layout)
// ---------------------------------------------------------------------------
class _KeyboardMap extends StatelessWidget {
  const _KeyboardMap();

  @override
  Widget build(BuildContext context) {
    // Rows of (label, scanCode, keyval) — six are spotlighted with a color
    final row1 = <_Cap>[
      _Cap('Esc',   1,   0xFF1B, accent: _Pal.crimson, highlight: true),
      _Cap('F1',    59,  0xFFBE),
      _Cap('F2',    60,  0xFFBF),
      _Cap('F3',    61,  0xFFC0),
      _Cap('F4',    62,  0xFFC1),
      _Cap('F5',    63,  0xFFC2),
      _Cap('F6',    64,  0xFFC3),
      _Cap('F7',    65,  0xFFC4),
      _Cap('F8',    66,  0xFFC5),
      _Cap('F9',    67,  0xFFC6),
      _Cap('F10',   68,  0xFFC7),
      _Cap('F11',   87,  0xFFC8),
      _Cap('F12',   88,  0xFFC9),
    ];
    final row2 = <_Cap>[
      _Cap('`',     41,  0x0060),
      _Cap('1',     2,   0x0031),
      _Cap('2',     3,   0x0032),
      _Cap('3',     4,   0x0033),
      _Cap('4',     5,   0x0034),
      _Cap('5',     6,   0x0035),
      _Cap('6',     7,   0x0036),
      _Cap('7',     8,   0x0037),
      _Cap('8',     9,   0x0038),
      _Cap('9',     10,  0x0039),
      _Cap('0',     11,  0x0030),
      _Cap('-',     12,  0x002D),
      _Cap('=',     13,  0x003D),
      _Cap('⌫',     14,  0xFF08, accent: _Pal.amber, highlight: true),
    ];
    final row3 = <_Cap>[
      _Cap('Tab',   15,  0xFF09, accent: _Pal.teal, highlight: true),
      _Cap('Q',     16,  0x0071),
      _Cap('W',     17,  0x0077),
      _Cap('E',     18,  0x0065),
      _Cap('R',     19,  0x0072),
      _Cap('T',     20,  0x0074),
      _Cap('Y',     21,  0x0079),
      _Cap('U',     22,  0x0075),
      _Cap('I',     23,  0x0069),
      _Cap('O',     24,  0x006F),
      _Cap('P',     25,  0x0070),
      _Cap('[',     26,  0x005B),
      _Cap(']',     27,  0x005D),
      _Cap('\\',    43,  0x005C),
    ];
    final row4 = <_Cap>[
      _Cap('Caps',  58,  0xFFE5),
      _Cap('A',     30,  0x0061,
          accent: _Pal.ubuOrange, highlight: true),
      _Cap('S',     31,  0x0073),
      _Cap('D',     32,  0x0064),
      _Cap('F',     33,  0x0066),
      _Cap('G',     34,  0x0067),
      _Cap('H',     35,  0x0068),
      _Cap('J',     36,  0x006A),
      _Cap('K',     37,  0x006B),
      _Cap('L',     38,  0x006C),
      _Cap(';',     39,  0x003B),
      _Cap("'",     40,  0x0027),
      _Cap('⏎',     28,  0xFF0D,
          accent: _Pal.termGreen, highlight: true, wide: true),
    ];
    final row5 = <_Cap>[
      _Cap('Shift', 42,  0xFFE1),
      _Cap('Z',     44,  0x007A),
      _Cap('X',     45,  0x0078),
      _Cap('C',     46,  0x0063),
      _Cap('V',     47,  0x0076),
      _Cap('B',     48,  0x0062),
      _Cap('N',     49,  0x006E),
      _Cap('M',     50,  0x006D),
      _Cap(',',     51,  0x002C),
      _Cap('.',     52,  0x002E),
      _Cap('/',     53,  0x002F),
      _Cap('Shift', 54,  0xFFE2),
    ];
    final row6 = <_Cap>[
      _Cap('Ctrl',  29,  0xFFE3),
      _Cap('Super', 125, 0xFFEB, accent: _Pal.aubergineSoft, highlight: true),
      _Cap('Alt',   56,  0xFFE9),
      _Cap('Space', 57,  0x0020, wide: true, extraWide: true),
      _Cap('Alt',   100, 0xFFEA),
      _Cap('Menu',  127, 0xFF67),
      _Cap('Ctrl',  97,  0xFFE4),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _Pal.aubergine,
                _Pal.aubergineSoft.withValues(alpha: 0.65),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: _Pal.ubuOrange.withValues(alpha: 0.6), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: _Pal.aubergine.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _KbRow(caps: row1),
              const SizedBox(height: 5),
              _KbRow(caps: row2),
              const SizedBox(height: 5),
              _KbRow(caps: row3),
              const SizedBox(height: 5),
              _KbRow(caps: row4),
              const SizedBox(height: 5),
              _KbRow(caps: row5),
              const SizedBox(height: 5),
              _KbRow(caps: row6),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // Legend
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _Pal.paper,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _Pal.rule),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Spotlighted keys', style: _T.caption),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: const [
                  _Legend('A',     30,  0x0061, _Pal.ubuOrange),
                  _Legend('Esc',   1,   0xFF1B, _Pal.crimson),
                  _Legend('Tab',   15,  0xFF09, _Pal.teal),
                  _Legend('⌫ BS',  14,  0xFF08, _Pal.amber),
                  _Legend('⏎ Ret', 28,  0xFF0D, _Pal.termGreen),
                  _Legend('Super', 125, 0xFFEB, _Pal.aubergineSoft),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Each cap shows the evdev scancode (kernel layer) and the '
                'GTK keyval — the same value RawKeyEventDataLinux.keyCode '
                'would report when GtkKeyHelper is in effect.',
                style: _T.bodyDim,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Cap {
  final String label;
  final int scan;
  final int keyval;
  final Color? accent;
  final bool highlight;
  final bool wide;
  final bool extraWide;
  const _Cap(
    this.label,
    this.scan,
    this.keyval, {
    this.accent,
    this.highlight = false,
    this.wide = false,
    this.extraWide = false,
  });
}

class _KbRow extends StatelessWidget {
  final List<_Cap> caps;
  const _KbRow({required this.caps});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final c in caps)
          Expanded(
            flex: c.extraWide ? 6 : (c.wide ? 2 : 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _KeyCap(cap: c),
            ),
          ),
      ],
    );
  }
}

class _KeyCap extends StatelessWidget {
  final _Cap cap;
  const _KeyCap({required this.cap});

  @override
  Widget build(BuildContext context) {
    final accent = cap.accent ?? _Pal.gtkBlueSoft;
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: cap.highlight
            ? LinearGradient(
                colors: [
                  accent,
                  accent.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.95),
                  Colors.white.withValues(alpha: 0.75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: cap.highlight
              ? Colors.white
              : Colors.white.withValues(alpha: 0.3),
          width: cap.highlight ? 1.5 : 1,
        ),
        boxShadow: cap.highlight
            ? [
                BoxShadow(
                  color: accent.withValues(alpha: 0.6),
                  blurRadius: 12,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            cap.label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: cap.label.length > 3 ? 10 : 13,
              color: cap.highlight ? Colors.white : _Pal.ink,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          if (cap.highlight) ...[
            Text(
              'sc ${cap.scan}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 8.5,
                color: Colors.white.withValues(alpha: 0.95),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '0x${cap.keyval.toRadixString(16).toUpperCase()}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 8,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final String label;
  final int scan;
  final int keyval;
  final Color color;
  const _Legend(this.label, this.scan, this.keyval, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _Pal.ink,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'sc=$scan',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '0x${keyval.toRadixString(16).toUpperCase()}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: _Pal.textDim,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 7 — isXPressed helpers (4 cards with lit-up modifier indicators)
// ---------------------------------------------------------------------------
class _IsPressedHelpers extends StatelessWidget {
  const _IsPressedHelpers();

  @override
  Widget build(BuildContext context) {
    final helpers = <_HelperGetter>[
      _HelperGetter(
        getter: 'isControlPressed',
        glyph: '⎈',
        color: _Pal.ubuOrange,
        gdkMask: 'GDK_CONTROL_MASK',
        bitsHex: '0x00000004',
        description:
            'True if any Control key is held. Reads (modifiers & '
            'GDK_CONTROL_MASK) != 0 under GTK and (modifiers & '
            'GLFW_MOD_CONTROL) != 0 under GLFW — picking the right bit '
            'is the whole point of keyHelper.',
        scenarioName: 'Ctrl + C in a terminal',
      ),
      _HelperGetter(
        getter: 'isShiftPressed',
        glyph: '⇧',
        color: _Pal.gtkBlue,
        gdkMask: 'GDK_SHIFT_MASK',
        bitsHex: '0x00000001',
        description:
            'True if either Shift key is held. Combined with isMetaPressed '
            'this is how Flutter detects modified menu shortcuts like '
            'Shift+Super+S (region screenshot on GNOME).',
        scenarioName: 'Shift + A → capital A',
      ),
      _HelperGetter(
        getter: 'isMetaPressed',
        glyph: '✦',
        color: _Pal.aubergineSoft,
        gdkMask: 'GDK_META_MASK',
        bitsHex: '0x10000000',
        description:
            'True if a Meta key is held. On Linux the Meta key is typically '
            'the Super (Windows) key — the GNOME activities key. GTK and '
            'GLFW disagree on bit position; never short-circuit through '
            'the raw mask.',
        scenarioName: 'Super + L → lock screen',
      ),
      _HelperGetter(
        getter: 'isAltPressed',
        glyph: '⌥',
        color: _Pal.amber,
        gdkMask: 'GDK_MOD1_MASK',
        bitsHex: '0x00000008',
        description:
            'True if Alt is held. On GTK this is the MOD1 mask (0x08); on '
            'GLFW it is the dedicated ALT bit (0x04). Used everywhere from '
            'Alt+Tab window switching to Alt+letter mnemonics in legacy '
            'GTK menus.',
        scenarioName: 'Alt + Tab → window switch',
      ),
    ];

    return Column(
      children: [
        for (int i = 0; i < helpers.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _HelperCard2(spec: helpers[i])),
                const SizedBox(width: 12),
                Expanded(
                  child: i + 1 < helpers.length
                      ? _HelperCard2(spec: helpers[i + 1])
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _HelperGetter {
  final String getter;
  final String glyph;
  final Color color;
  final String gdkMask;
  final String bitsHex;
  final String description;
  final String scenarioName;
  const _HelperGetter({
    required this.getter,
    required this.glyph,
    required this.color,
    required this.gdkMask,
    required this.bitsHex,
    required this.description,
    required this.scenarioName,
  });
}

class _HelperCard2 extends StatelessWidget {
  final _HelperGetter spec;
  const _HelperCard2({required this.spec});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            spec.color.withValues(alpha: 0.10),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: spec.color.withValues(alpha: 0.55),
          width: 1.3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Lit-up modifier indicator
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: spec.color.withValues(alpha: 0.15),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          spec.color,
                          spec.color.withValues(alpha: 0.65),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: spec.color.withValues(alpha: 0.55),
                          blurRadius: 14,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        spec.glyph,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'bool get',
                      style: _T.caption.copyWith(fontSize: 9.5),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      spec.getter,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14.5,
                        color: spec.color,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: spec.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${spec.gdkMask}  ·  ${spec.bitsHex}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: spec.color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(spec.description, style: _T.body),
          const SizedBox(height: 10),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: spec.color.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.bolt, size: 14, color: spec.color),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    spec.scenarioName,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: _Pal.ink,
                      fontWeight: FontWeight.w700,
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

// ---------------------------------------------------------------------------
// SECTION 8 — Code block — RawKeyboard.instance.addListener pattern
// ---------------------------------------------------------------------------
class _CodeListenerExample extends StatelessWidget {
  const _CodeListenerExample();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Term(
          title: 'snippet · listening for Linux key events',
          lines: [
            const _Ln([
              _Tok('// ', _T.termComment),
              _Tok(
                  'Legacy raw keyboard listener — pattern shown for reference.',
                  _T.termComment),
            ]),
            const _Ln([
              _Tok('// ', _T.termComment),
              _Tok('In new code, prefer HardwareKeyboard / KeyEvent.',
                  _T.termComment),
            ]),
            _Ln.blank(),
            const _Ln([
              _Tok('RawKeyboard', _T.termType),
              _Tok('.', _T.term),
              _Tok('instance', _T.termIdent),
              _Tok('.', _T.term),
              _Tok('addListener', _T.termIdent),
              _Tok('((', _T.term),
              _Tok('event', _T.termIdent),
              _Tok(') {', _T.term),
            ]),
            const _Ln([
              _Tok('  if ', _T.termKw),
              _Tok('(', _T.term),
              _Tok('event', _T.termIdent),
              _Tok('.', _T.term),
              _Tok('data ', _T.termIdent),
              _Tok('is ', _T.termKw),
              _Tok('RawKeyEventDataLinux', _T.termType),
              _Tok(') {', _T.term),
            ]),
            const _Ln([
              _Tok('    final ', _T.termKw),
              _Tok('linux ', _T.termIdent),
              _Tok('= ', _T.term),
              _Tok('event', _T.termIdent),
              _Tok('.', _T.term),
              _Tok('data ', _T.termIdent),
              _Tok('as ', _T.termKw),
              _Tok('RawKeyEventDataLinux', _T.termType),
              _Tok(';', _T.term),
            ]),
            _Ln.blank(),
            const _Ln([
              _Tok('    // ', _T.termComment),
              _Tok('Toolkit-aware dispatch', _T.termComment),
            ]),
            const _Ln([
              _Tok('    if ', _T.termKw),
              _Tok('(', _T.term),
              _Tok('linux', _T.termIdent),
              _Tok('.', _T.term),
              _Tok('isControlPressed ', _T.termIdent),
              _Tok('&& ', _T.termKw),
              _Tok('linux', _T.termIdent),
              _Tok('.', _T.term),
              _Tok('keyCode ', _T.termIdent),
              _Tok('== ', _T.termKw),
              _Tok('0x0061', _T.termNum),
              _Tok(') {', _T.term),
            ]),
            const _Ln([
              _Tok('      // ', _T.termComment),
              _Tok('Ctrl + a — select all (terminal-style)', _T.termComment),
            ]),
            const _Ln([
              _Tok('      selectAll', _T.termIdent),
              _Tok('();', _T.term),
            ]),
            const _Ln([_Tok('    }', _T.term)]),
            _Ln.blank(),
            const _Ln([
              _Tok('    // ', _T.termComment),
              _Tok('Diagnostics', _T.termComment),
            ]),
            const _Ln([
              _Tok('    debugPrint', _T.termIdent),
              _Tok('(', _T.term),
              _Tok("'helper=", _T.termStr),
              _Tok(r"${" , _T.termStr),
              _Tok('linux.keyHelper.runtimeType', _T.termIdent),
              _Tok(r"} sc=", _T.termStr),
              _Tok(r"${", _T.termStr),
              _Tok('linux.scanCode', _T.termIdent),
              _Tok(r"} kc=", _T.termStr),
              _Tok(r"${", _T.termStr),
              _Tok('linux.keyCode', _T.termIdent),
              _Tok(r"}'", _T.termStr),
              _Tok(');', _T.term),
            ]),
            const _Ln([_Tok('  }', _T.term)]),
            const _Ln([_Tok('});', _T.term)]),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _Pal.termGreen.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: _Pal.termGreen.withValues(alpha: 0.55)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.terminal,
                  size: 18, color: _Pal.termGreen),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Notice the cast pattern: event.data is checked with `is '
                  'RawKeyEventDataLinux` before being narrowed with `as`. '
                  'This is the legacy way to consume platform-specific raw '
                  'data; do not assume the cast succeeds on non-Linux '
                  'platforms.',
                  style: _T.body,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 9 — Side-by-side legacy vs modern (HardwareKeyboard) comparison
// ---------------------------------------------------------------------------
class _LegacyVsModern extends StatelessWidget {
  const _LegacyVsModern();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ApiColumn(
                badge: 'LEGACY',
                badgeColor: _Pal.crimson,
                title: 'RawKeyboard · RawKeyEvent',
                subtitle: 'Linux variant: RawKeyEventDataLinux',
                accent: _Pal.crimson,
                bullets: const [
                  _ApiBullet('RawKeyboard.instance.addListener',
                      'One global stream, no per-Focus routing.'),
                  _ApiBullet('event.data is RawKeyEventDataLinux',
                      'Manual platform-specific cast for each call site.'),
                  _ApiBullet('linux.keyHelper / scanCode / keyCode',
                      'Raw GTK or GLFW values — toolkit-aware logic.'),
                  _ApiBullet('linux.modifiers (raw int)',
                      'Bitmask whose layout depends on the helper.'),
                  _ApiBullet('@Deprecated',
                      'Marked for removal; no new features.'),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _ApiColumn(
                badge: 'PREFERRED',
                badgeColor: _Pal.termGreen,
                title: 'HardwareKeyboard · KeyEvent',
                subtitle: 'Cross-platform, Focus-aware',
                accent: _Pal.termGreen,
                bullets: const [
                  _ApiBullet('HardwareKeyboard.instance.addHandler',
                      'Focus-aware delivery — input falls through if unhandled.'),
                  _ApiBullet('event.physicalKey  /  event.logicalKey',
                      'PhysicalKeyboardKey / LogicalKeyboardKey — same on all OSes.'),
                  _ApiBullet('event.character',
                      'Already-decoded character (when applicable).'),
                  _ApiBullet('HardwareKeyboard.instance.isControlPressed',
                      'Modifier state queryable directly, no helper indirection.'),
                  _ApiBullet('Active API',
                      'New features and shortcut framework target this API.'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ApiBullet {
  final String api;
  final String note;
  const _ApiBullet(this.api, this.note);
}

class _ApiColumn extends StatelessWidget {
  final String badge;
  final Color badgeColor;
  final String title;
  final String subtitle;
  final Color accent;
  final List<_ApiBullet> bullets;
  const _ApiColumn({
    required this.badge,
    required this.badgeColor,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: accent.withValues(alpha: 0.55),
          width: 1.3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent.withValues(alpha: 0.22),
                  accent.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(title,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.5,
                      color: accent,
                      fontWeight: FontWeight.w800,
                    )),
                const SizedBox(height: 2),
                Text(subtitle, style: _T.caption.copyWith(fontSize: 10.5)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final b in bullets) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6, right: 8),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(b.api,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11.5,
                                  color: _Pal.ink,
                                  fontWeight: FontWeight.w800,
                                )),
                            const SizedBox(height: 2),
                            Text(b.note, style: _T.bodyDim),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 10 — Use cases (4 cards)
// ---------------------------------------------------------------------------
class _UseCases extends StatelessWidget {
  const _UseCases();

  @override
  Widget build(BuildContext context) {
    final cases = <_UseCase>[
      _UseCase(
        title: 'Terminal applications',
        icon: '>_',
        color: _Pal.termGreen,
        body:
            'Terminal emulators care about raw scan codes (to detect Ctrl+C, '
            'Ctrl+Z, etc.) and need to forward modifier-aware escape '
            'sequences to the shell. RawKeyEventDataLinux exposed the '
            'GTK keyval and modifier bitmask that mapped cleanly to '
            'PTY escape sequences.',
      ),
      _UseCase(
        title: 'Custom IME / IBus bridges',
        icon: 'IM',
        color: _Pal.gtkBlue,
        body:
            'Custom input method engines bridging IBus or Fcitx historically '
            'inspected the raw GTK keyval and unicode scalars to decide '
            'whether to swallow, transform, or forward a key event. '
            'Modern Flutter routes this through TextInput plugins instead.',
      ),
      _UseCase(
        title: 'Accessibility helpers',
        icon: 'A11y',
        color: _Pal.ubuOrange,
        body:
            'Sticky-keys, dwell-click hooks, and on-screen-keyboard mirrors '
            'inspected scancodes (layout-independent) to track which '
            'physical keys were held. The Orca screen reader integration '
            'on Ubuntu followed this path.',
      ),
      _UseCase(
        title: 'Game input',
        icon: '🎮',
        color: _Pal.aubergineSoft,
        body:
            'Games want layout-independent input — pressing the key in the '
            'top-left, not "Q". Reading scanCode directly avoided the '
            'AZERTY problem where WASD becomes ZQSD. PhysicalKeyboardKey '
            'now solves this without raw scancodes.',
      ),
    ];

    return Column(
      children: [
        for (int i = 0; i < cases.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _UseCaseCard(c: cases[i])),
                const SizedBox(width: 12),
                Expanded(
                  child: i + 1 < cases.length
                      ? _UseCaseCard(c: cases[i + 1])
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _UseCase {
  final String title;
  final String icon;
  final Color color;
  final String body;
  const _UseCase({
    required this.title,
    required this.icon,
    required this.color,
    required this.body,
  });
}

class _UseCaseCard extends StatelessWidget {
  final _UseCase c;
  const _UseCaseCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            c.color.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: c.color.withValues(alpha: 0.5),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [c.color, c.color.withValues(alpha: 0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    c.icon,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  c.title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _Pal.ink,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(c.body, style: _T.body),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 11 — Pitfalls (5 bullets, danger styling)
// ---------------------------------------------------------------------------
class _Pitfalls extends StatelessWidget {
  const _Pitfalls();

  @override
  Widget build(BuildContext context) {
    final items = <_Pitfall>[
      _Pitfall(
        title: 'Toolkit-specific modifier masks',
        body:
            'GTK and GLFW use *different* bit positions for the same modifier '
            '(e.g. Control is 0x04 under GTK but 0x02 under GLFW). Reading '
            'modifiers as a raw int without consulting keyHelper produces '
            'silently wrong logic on whichever toolkit was not tested.',
      ),
      _Pitfall(
        title: 'Lock-key state behavior',
        body:
            'CapsLock, NumLock and ScrollLock are reported as *state bits* '
            'that persist across key events — not as transient press '
            'modifiers. Treating them as "is the user currently holding it '
            'down" leads to flickering UI state.',
      ),
      _Pitfall(
        title: 'Locale-dependent unicodeScalarValues',
        body:
            'The unicode scalar(s) the toolkit produces depend on the active '
            'XKB layout, dead-key composition, and IME state. A key '
            'producing "é" in one layout produces "´" then "e" in another. '
            'Do not match shortcuts against unicodeScalarValues.',
      ),
      _Pitfall(
        title: 'Deprecated migration path',
        body:
            'The whole RawKeyboard subsystem is annotated @Deprecated. Code '
            'using RawKeyEventDataLinux today will eventually have to '
            'migrate to HardwareKeyboard / KeyEvent. Plan the cut-over '
            'when adopting it for new work.',
      ),
      _Pitfall(
        title: 'No Wayland-specific subclass',
        body:
            'RawKeyEventDataLinux is shared between X11 and Wayland sessions '
            '— the embedder still funnels both through GtkKeyHelper. Code '
            'cannot distinguish "Wayland vs X11" at this layer; if that '
            'matters, query the platform plugin instead.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _PitfallRow(p: items[i], index: i + 1),
          ),
      ],
    );
  }
}

class _Pitfall {
  final String title;
  final String body;
  const _Pitfall({required this.title, required this.body});
}

class _PitfallRow extends StatelessWidget {
  final _Pitfall p;
  final int index;
  const _PitfallRow({required this.p, required this.index});

  @override
  Widget build(BuildContext context) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #95, P5(a))
    // The Border below has a heavy 4-px crimson `left` side against
    // 1-px crimson@0.3 sides on top/right/bottom — non-uniform widths
    // (and arguably colours with the alpha shift) cannot coexist with
    // `borderRadius: BorderRadius.circular(10)`. Drop the borderRadius;
    // the heavy left accent bar carries the pitfall-row visual
    // identity. The helper is invoked 5 times (5 _Pitfall entries in
    // the pitfalls list) → 5 banners cleared.
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _Pal.crimson.withValues(alpha: 0.06),
        border: Border(
          left: BorderSide(color: _Pal.crimson, width: 4),
          top: BorderSide(color: _Pal.crimson.withValues(alpha: 0.3)),
          right: BorderSide(color: _Pal.crimson.withValues(alpha: 0.3)),
          bottom: BorderSide(color: _Pal.crimson.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _Pal.crimson,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: _Pal.ink,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(p.body, style: _T.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 12 — Footer (version stamp)
// ---------------------------------------------------------------------------
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Pal.aubergine,
            _Pal.aubergineSoft.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _Pal.ubuOrange.withValues(alpha: 0.5),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_Pal.ubuOrange, _Pal.amber],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'L',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RawKeyEventDataLinux · visual deep demo',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Hand-authored dossier · flutter/services · GTK + GLFW · '
                  'deprecated as of 3.18 · prefer HardwareKeyboard',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _Pal.ubuOrangeSoft.withValues(alpha: 0.7),
              ),
            ),
            child: const Text(
              'v1.0 · linux',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reference touch-points to flutter/services so the import is non-trivially
// used at analysis time. None of these are mutated at build time — they are
// captured as const-level expressions purely so the analyzer keeps the import
// load-bearing.
// ---------------------------------------------------------------------------
class _ServicesAnchors {
  static const LogicalKeyboardKey keyA = LogicalKeyboardKey.keyA;
  static const LogicalKeyboardKey keyEnter = LogicalKeyboardKey.enter;
  static const LogicalKeyboardKey keyEscape = LogicalKeyboardKey.escape;
  static const LogicalKeyboardKey keyShiftLeft = LogicalKeyboardKey.shiftLeft;
  static const LogicalKeyboardKey keyControlLeft =
      LogicalKeyboardKey.controlLeft;
  static const LogicalKeyboardKey keyMetaLeft = LogicalKeyboardKey.metaLeft;
  static const LogicalKeyboardKey keyAltLeft = LogicalKeyboardKey.altLeft;

  static const PhysicalKeyboardKey physA = PhysicalKeyboardKey.keyA;
  static const PhysicalKeyboardKey physEnter = PhysicalKeyboardKey.enter;
  static const PhysicalKeyboardKey physEscape = PhysicalKeyboardKey.escape;
  static const PhysicalKeyboardKey physTab = PhysicalKeyboardKey.tab;
}

// ---------------------------------------------------------------------------
// Top-level build — assembles every section into the long-form dossier.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  // Anchor a few flutter/services constants so the import stays load-bearing
  // even when the rest of the document is purely declarative.
  final _ = <LogicalKeyboardKey>[
    _ServicesAnchors.keyA,
    _ServicesAnchors.keyEnter,
    _ServicesAnchors.keyEscape,
    _ServicesAnchors.keyShiftLeft,
    _ServicesAnchors.keyControlLeft,
    _ServicesAnchors.keyMetaLeft,
    _ServicesAnchors.keyAltLeft,
  ];
  final __ = <PhysicalKeyboardKey>[
    _ServicesAnchors.physA,
    _ServicesAnchors.physEnter,
    _ServicesAnchors.physEscape,
    _ServicesAnchors.physTab,
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFFF2EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _Hero(),
              _DeprecationBanner(),
              _Section(
                index: '02',
                title: 'Subclass hierarchy',
                lead:
                    'Where RawKeyEventDataLinux sits in the RawKeyEventData '
                    'family — one of six per-platform leaves.',
                accent: _Pal.gtkBlue,
                child: _Hierarchy(),
              ),
              _Section(
                index: '03',
                title: 'Field anatomy',
                lead:
                    'Every field of RawKeyEventDataLinux, with its type, '
                    'role, and a representative sample value.',
                accent: _Pal.ubuOrange,
                child: _FieldAnatomy(),
              ),
              _Section(
                index: '04',
                title: 'KeyHelper variants',
                lead:
                    'GtkKeyHelper vs GLFWKeyHelper — when each is selected, '
                    'and how their modifier-mask constants compare.',
                accent: _Pal.aubergineSoft,
                child: _KeyHelperCompare(),
              ),
              _Section(
                index: '05',
                title: 'Modifier mask grid',
                lead:
                    'Modifier bits as checkbox chips — Shift, Ctrl, Alt, '
                    'Meta/Super, CapsLock, NumLock, ScrollLock.',
                accent: _Pal.amber,
                child: _ModifierGrid(),
              ),
              _Section(
                index: '06',
                title: 'Physical key mapping',
                lead:
                    'A stylized Linux keyboard, with six spotlighted caps '
                    'showing scancodes and GTK keyvals.',
                accent: _Pal.termGreen,
                child: _KeyboardMap(),
              ),
              _Section(
                index: '07',
                title: 'isXPressed helpers',
                lead:
                    'isControlPressed, isShiftPressed, isMetaPressed, '
                    'isAltPressed — with their underlying GDK masks.',
                accent: _Pal.ubuOrange,
                child: _IsPressedHelpers(),
              ),
              _Section(
                index: '08',
                title: 'Listener pattern',
                lead:
                    'How RawKeyboard.instance.addListener was traditionally '
                    'used to react to Linux key events.',
                accent: _Pal.teal,
                child: _CodeListenerExample(),
              ),
              _Section(
                index: '09',
                title: 'Legacy vs modern',
                lead:
                    'Side-by-side comparison: the deprecated RawKeyboard '
                    'path vs the modern HardwareKeyboard / KeyEvent path.',
                accent: _Pal.crimson,
                child: _LegacyVsModern(),
              ),
              _Section(
                index: '10',
                title: 'Use cases',
                lead:
                    'Real-world scenarios where the Linux raw-key payload '
                    'historically mattered.',
                accent: _Pal.aubergineSoft,
                child: _UseCases(),
              ),
              _Section(
                index: '11',
                title: 'Pitfalls',
                lead:
                    'Five things that bite developers consuming '
                    'RawKeyEventDataLinux.',
                accent: _Pal.crimson,
                child: _Pitfalls(),
              ),
              _Footer(),
            ],
          ),
        ),
      ),
    ),
  );
}
