// ignore_for_file: unused_field, unused_local_variable, unused_element, unused_element_parameter, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';

// =============================================================================
// Divider + ListTile Deep Demo
// =============================================================================
// This file is a static, hand-written deep demo of Material `Divider`,
// `VerticalDivider`, and the `ListTile` family. Everything is rendered
// statelessly. No animations, no timers, no streams, no I/O.
//
// Sections:
//   1.  _HeroBannerSection           - large gradient banner / title card
//   2.  _DividerPropertyGallery      - rows of Dividers with different props
//   3.  _IndentRulerSection          - indent / endIndent diagram + rulers
//   4.  _VerticalDividerToolbar      - VerticalDivider in a Row toolbar
//   5.  _ListTileAnatomySection      - labeled regions of a ListTile
//   6.  _ListTileStateGrid           - default/selected/disabled/focused/hover
//   7.  _ListTileVariantsSection     - Checkbox/Radio/Switch ListTiles
//   8.  _ListPatternSection          - divideTiles + Divider patterns
//   9.  _ListTileThemeChainSection   - nested ListTileTheme inheritance
//   10. _PitfallsSection             - common foot-guns visualised
//   11. _FooterSection               - closing legend / palette
// =============================================================================

class _Palette {
  static const Color ink = Color(0xFF1B1F2A);
  static const Color inkSoft = Color(0xFF394050);
  static const Color inkMute = Color(0xFF6A7384);
  static const Color paper = Color(0xFFFAF8F3);
  static const Color paperSoft = Color(0xFFF0ECE3);
  static const Color accent = Color(0xFF4A6CF7);
  static const Color accentSoft = Color(0xFFC9D2FB);
  static const Color warm = Color(0xFFF7894A);
  static const Color warmSoft = Color(0xFFFBD5BD);
  static const Color cool = Color(0xFF2BB6A6);
  static const Color coolSoft = Color(0xFFBDEAE3);
  static const Color danger = Color(0xFFD64545);
  static const Color dangerSoft = Color(0xFFF7C1C1);
  static const Color sun = Color(0xFFE3B23C);
  static const Color sunSoft = Color(0xFFF5E2A9);
  static const Color leaf = Color(0xFF5A9E3C);
  static const Color leafSoft = Color(0xFFCDE5BD);
  static const Color violet = Color(0xFF7A4AC9);
  static const Color violetSoft = Color(0xFFD9C5F4);
  static const Color slate = Color(0xFF4E5A6B);
  static const Color slateSoft = Color(0xFFCED4DC);
}

class _SectionHeader extends StatelessWidget {
  final String index;
  final String title;
  final String subtitle;
  final Color tone;

  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 36, 20, 12),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tone.withValues(alpha: 0.18), tone.withValues(alpha: 0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tone.withValues(alpha: 0.35), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: tone.withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              index,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _Palette.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _Palette.inkSoft,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
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

class _Chip extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;
  const _Chip({required this.text, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            SizedBox(width: 5),
          ],
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  final String label;
  final String value;
  final Color tone;
  const _Caption(
      {required this.label, required this.value, required this.tone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: tone,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: _Palette.inkMute,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: _Palette.ink,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  final Widget child;
  final Color tone;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  const _CardShell({
    required this.child,
    required this.tone,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tone.withValues(alpha: 0.25), width: 1),
        boxShadow: [
          BoxShadow(
            color: tone.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

// =============================================================================
// 1. HERO BANNER
// =============================================================================

class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 24, 20, 8),
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 26),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.violet,
            _Palette.accent,
            _Palette.cool,
          ],
          stops: [0.0, 0.55, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _Palette.violet.withValues(alpha: 0.32),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu_book_outlined,
                        size: 14, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      'MATERIAL DEEP DEMO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'static · no animations',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            'Divider + ListTile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w900,
              height: 1.05,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'a hand-drawn tour of separation primitives and tile widgets',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
          SizedBox(height: 18),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.0),
                  Colors.white.withValues(alpha: 0.5),
                  Colors.white.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _HeroStat(
                  label: 'sections',
                  value: '11',
                  icon: Icons.dashboard_outlined,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _HeroStat(
                  label: 'tile variants',
                  value: '3',
                  icon: Icons.toggle_on_outlined,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _HeroStat(
                  label: 'divider props',
                  value: '5',
                  icon: Icons.horizontal_rule,
                ),
              ),
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
  final IconData icon;
  const _HeroStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: Colors.white),
              SizedBox(width: 6),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.88),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 2. DIVIDER PROPERTY GALLERY
// =============================================================================

class _DividerPropertyGallery extends StatelessWidget {
  const _DividerPropertyGallery();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      tone: _Palette.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Chip(
                text: 'height',
                color: _Palette.accent,
                icon: Icons.height,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'thickness',
                color: _Palette.warm,
                icon: Icons.line_weight,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'color',
                color: _Palette.violet,
                icon: Icons.palette_outlined,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Five Divider properties — five rows, five visual personalities.',
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 18),
          _DividerSampleRow(
            label: 'height: 4',
            description: 'the box, not the line — total vertical space.',
            tone: _Palette.accent,
            child: Divider(height: 4),
          ),
          _DividerSampleRow(
            label: 'height: 16',
            description: 'line stays 1px, but reserves 16px of layout space.',
            tone: _Palette.accent,
            child: Divider(height: 16),
          ),
          _DividerSampleRow(
            label: 'height: 32',
            description: 'plenty of breathing room above and below the rule.',
            tone: _Palette.accent,
            child: Divider(height: 32),
          ),
          _DividerSampleRow(
            label: 'height: 48',
            description: 'big airy spacer; still a single hairline rule.',
            tone: _Palette.accent,
            child: Divider(height: 48),
          ),
          SizedBox(height: 6),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _Palette.accent.withValues(alpha: 0.0),
                  _Palette.accent.withValues(alpha: 0.4),
                  _Palette.accent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          _DividerSampleRow(
            label: 'thickness: 1',
            description: 'the default hairline; subtle on hi-dpi screens.',
            tone: _Palette.warm,
            child: Divider(height: 24, thickness: 1),
          ),
          _DividerSampleRow(
            label: 'thickness: 2',
            description: 'slightly heavier; reads as a stronger rule.',
            tone: _Palette.warm,
            child: Divider(height: 24, thickness: 2),
          ),
          _DividerSampleRow(
            label: 'thickness: 4',
            description: 'bold separator; useful for section breaks.',
            tone: _Palette.warm,
            child: Divider(height: 24, thickness: 4),
          ),
          _DividerSampleRow(
            label: 'thickness: 8',
            description: 'block-style ribbon; rarely a good idea, but possible.',
            tone: _Palette.warm,
            child: Divider(height: 24, thickness: 8),
          ),
          SizedBox(height: 6),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _Palette.warm.withValues(alpha: 0.0),
                  _Palette.warm.withValues(alpha: 0.4),
                  _Palette.warm.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          _DividerSampleRow(
            label: 'color: accent',
            description: 'override divider color directly.',
            tone: _Palette.violet,
            child: Divider(height: 24, thickness: 2, color: _Palette.accent),
          ),
          _DividerSampleRow(
            label: 'color: warm',
            description: 'a louder rule that grabs the eye.',
            tone: _Palette.violet,
            child: Divider(height: 24, thickness: 2, color: _Palette.warm),
          ),
          _DividerSampleRow(
            label: 'color: cool',
            description: 'a calmer cyan, complements the page palette.',
            tone: _Palette.violet,
            child: Divider(height: 24, thickness: 2, color: _Palette.cool),
          ),
          _DividerSampleRow(
            label: 'color: danger',
            description: 'a hot rule for destructive section breaks.',
            tone: _Palette.violet,
            child: Divider(height: 24, thickness: 2, color: _Palette.danger),
          ),
          _DividerSampleRow(
            label: 'color: leaf',
            description: 'a leafy rule for success sections.',
            tone: _Palette.violet,
            child: Divider(height: 24, thickness: 2, color: _Palette.leaf),
          ),
          _DividerSampleRow(
            label: 'color: sun',
            description: 'a warm yellow rule for highlight sections.',
            tone: _Palette.violet,
            child: Divider(height: 24, thickness: 2, color: _Palette.sun),
          ),
        ],
      ),
    );
  }
}

class _DividerSampleRow extends StatelessWidget {
  final String label;
  final String description;
  final Color tone;
  final Widget child;
  const _DividerSampleRow({
    required this.label,
    required this.description,
    required this.tone,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: tone.withValues(alpha: 0.3)),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: tone,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _Palette.paperSoft,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: child,
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: _Palette.inkMute,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
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
// 3. INDENT / END-INDENT DIAGRAM WITH RULERS
// =============================================================================

class _IndentRulerSection extends StatelessWidget {
  const _IndentRulerSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      tone: _Palette.warm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Chip(
                text: 'indent',
                color: _Palette.warm,
                icon: Icons.format_indent_increase,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'endIndent',
                color: _Palette.cool,
                icon: Icons.format_indent_decrease,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Indent is the empty padding before the divider line; endIndent is '
            'the empty padding after it. Both are measured in logical pixels '
            'and respect text direction.',
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          _IndentSpecimen(
            label: 'indent: 0  ·  endIndent: 0',
            indent: 0,
            endIndent: 0,
          ),
          _IndentSpecimen(
            label: 'indent: 16  ·  endIndent: 0',
            indent: 16,
            endIndent: 0,
          ),
          _IndentSpecimen(
            label: 'indent: 0  ·  endIndent: 16',
            indent: 0,
            endIndent: 16,
          ),
          _IndentSpecimen(
            label: 'indent: 24  ·  endIndent: 24',
            indent: 24,
            endIndent: 24,
          ),
          _IndentSpecimen(
            label: 'indent: 48  ·  endIndent: 8',
            indent: 48,
            endIndent: 8,
          ),
          _IndentSpecimen(
            label: 'indent: 72  ·  endIndent: 16',
            indent: 72,
            endIndent: 16,
          ),
          SizedBox(height: 14),
          _RulerStrip(),
          SizedBox(height: 8),
          _Caption(
            label: 'RULE',
            value: 'indent shifts the START edge of the rule.',
            tone: _Palette.warm,
          ),
          _Caption(
            label: 'RULE',
            value: 'endIndent shifts the END edge.',
            tone: _Palette.cool,
          ),
          _Caption(
            label: 'NOTE',
            value: 'both default to 0.0 in Material 3.',
            tone: _Palette.inkMute,
          ),
        ],
      ),
    );
  }
}

class _IndentSpecimen extends StatelessWidget {
  final String label;
  final double indent;
  final double endIndent;
  const _IndentSpecimen({
    required this.label,
    required this.indent,
    required this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _Palette.slateSoft,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: _Palette.ink,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: _Palette.paperSoft,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _Palette.slateSoft, width: 0.5),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Divider(
                    height: 28,
                    thickness: 2,
                    indent: indent,
                    endIndent: endIndent,
                    color: _Palette.warm,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 4,
                  child: Container(
                    width: indent.clamp(0, 999).toDouble(),
                    height: 20,
                    decoration: BoxDecoration(
                      color: _Palette.warm.withValues(alpha: 0.12),
                      border: Border(
                        right: BorderSide(
                          color: _Palette.warm.withValues(alpha: 0.6),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 4,
                  child: Container(
                    width: endIndent.clamp(0, 999).toDouble(),
                    height: 20,
                    decoration: BoxDecoration(
                      color: _Palette.cool.withValues(alpha: 0.12),
                      border: Border(
                        left: BorderSide(
                          color: _Palette.cool.withValues(alpha: 0.6),
                          width: 1,
                        ),
                      ),
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

class _RulerStrip extends StatelessWidget {
  const _RulerStrip();

  @override
  Widget build(BuildContext context) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #42, P2):
    // The four "major" tick Columns (i=0, 5, 10, 15) stack
    // SizedBox(4) + Container(height: 12) + SizedBox(2) + Text(fontSize:9)
    // whose natural line height is ~14 px, totalling ~32 px — 4 px taller
    // than the original strip height of 28, producing 4× "RenderFlex
    // overflowed by 4.0 pixels on the bottom". Bumped the strip height
    // to 34 so the major-tick Column fits with a small breathing margin.
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: _Palette.paperSoft,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _Palette.slateSoft, width: 0.5),
      ),
      child: Row(
        children: List<Widget>.generate(20, (i) {
          final isMajor = i % 5 == 0;
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 4),
                Container(
                  width: 1,
                  height: isMajor ? 12 : 6,
                  color: isMajor
                      ? _Palette.ink
                      : _Palette.inkMute.withValues(alpha: 0.6),
                ),
                SizedBox(height: 2),
                if (isMajor)
                  Text(
                    '${i * 8}',
                    style: TextStyle(
                      color: _Palette.inkSoft,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// =============================================================================
// 4. VERTICAL DIVIDER TOOLBAR
// =============================================================================

class _VerticalDividerToolbar extends StatelessWidget {
  const _VerticalDividerToolbar();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      tone: _Palette.cool,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Chip(
                text: 'VerticalDivider',
                color: _Palette.cool,
                icon: Icons.swap_vert,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'Row layout',
                color: _Palette.accent,
                icon: Icons.view_week_outlined,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'A VerticalDivider only makes sense inside an unconstrained-width '
            'Row (or IntrinsicHeight). It splits clusters of horizontal '
            'controls — think toolbars, status bars, breadcrumbs.',
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                color: _Palette.paperSoft,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: _Palette.cool.withValues(alpha: 0.4)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Row(
                children: [
                  _ToolbarButton(icon: Icons.format_bold, label: 'B'),
                  _ToolbarButton(icon: Icons.format_italic, label: 'I'),
                  _ToolbarButton(icon: Icons.format_underline, label: 'U'),
                  VerticalDivider(
                    width: 20,
                    thickness: 1,
                    indent: 6,
                    endIndent: 6,
                    color: _Palette.slate.withValues(alpha: 0.5),
                  ),
                  _ToolbarButton(
                    icon: Icons.format_align_left,
                    label: 'left',
                  ),
                  _ToolbarButton(
                    icon: Icons.format_align_center,
                    label: 'center',
                  ),
                  _ToolbarButton(
                    icon: Icons.format_align_right,
                    label: 'right',
                  ),
                  VerticalDivider(
                    width: 20,
                    thickness: 1,
                    indent: 6,
                    endIndent: 6,
                    color: _Palette.slate.withValues(alpha: 0.5),
                  ),
                  _ToolbarButton(icon: Icons.image_outlined, label: 'img'),
                  _ToolbarButton(icon: Icons.link, label: 'link'),
                  _ToolbarButton(icon: Icons.code, label: 'code'),
                ],
              ),
            ),
          ),
          SizedBox(height: 14),
          IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                color: _Palette.paperSoft,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: _Palette.cool.withValues(alpha: 0.4)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  _StatusCluster(
                    label: 'BRANCH',
                    value: 'main',
                    color: _Palette.leaf,
                    icon: Icons.call_split,
                  ),
                  VerticalDivider(
                    width: 22,
                    thickness: 1.4,
                    color: _Palette.cool,
                  ),
                  _StatusCluster(
                    label: 'STATUS',
                    value: '3 ahead',
                    color: _Palette.accent,
                    icon: Icons.arrow_upward,
                  ),
                  VerticalDivider(
                    width: 22,
                    thickness: 1.4,
                    color: _Palette.cool,
                  ),
                  _StatusCluster(
                    label: 'ENC',
                    value: 'UTF-8',
                    color: _Palette.violet,
                    icon: Icons.text_fields,
                  ),
                  VerticalDivider(
                    width: 22,
                    thickness: 1.4,
                    color: _Palette.cool,
                  ),
                  _StatusCluster(
                    label: 'LF',
                    value: 'LF',
                    color: _Palette.warm,
                    icon: Icons.keyboard_return,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14),
          IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _Palette.cool.withValues(alpha: 0.12),
                    _Palette.accent.withValues(alpha: 0.12),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: _Palette.cool.withValues(alpha: 0.4)),
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  _BreadcrumbCrumb(text: 'home'),
                  VerticalDivider(width: 14, thickness: 1, color: _Palette.cool),
                  _BreadcrumbCrumb(text: 'projects'),
                  VerticalDivider(width: 14, thickness: 1, color: _Palette.cool),
                  _BreadcrumbCrumb(text: 'tom_d4rt'),
                  VerticalDivider(width: 14, thickness: 1, color: _Palette.cool),
                  _BreadcrumbCrumb(text: 'tests'),
                  VerticalDivider(width: 14, thickness: 1, color: _Palette.cool),
                  _BreadcrumbCrumb(
                    text: 'divider_listtile_test.dart',
                    bold: true,
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

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ToolbarButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _Palette.slateSoft, width: 0.6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: _Palette.inkSoft),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: _Palette.ink,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCluster extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;
  const _StatusCluster({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: _Palette.inkMute,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 1),
              Text(
                value,
                style: TextStyle(
                  color: _Palette.ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BreadcrumbCrumb extends StatelessWidget {
  final String text;
  final bool bold;
  const _BreadcrumbCrumb({required this.text, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: TextStyle(
          color: bold ? _Palette.ink : _Palette.inkSoft,
          fontSize: 12,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// =============================================================================
// 5. LIST TILE ANATOMY
// =============================================================================

class _ListTileAnatomySection extends StatelessWidget {
  const _ListTileAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      tone: _Palette.violet,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Chip(
                text: 'leading',
                color: _Palette.accent,
                icon: Icons.start,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'title',
                color: _Palette.violet,
                icon: Icons.title,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'subtitle',
                color: _Palette.cool,
                icon: Icons.subtitles_outlined,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'trailing',
                color: _Palette.warm,
                icon: Icons.chevron_right,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'A ListTile is a single horizontal row with four labeled slots, '
            'an outer contentPadding, an inner minVerticalPadding, and a '
            'configurable density.',
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: _Palette.paperSoft,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _Palette.violet.withValues(alpha: 0.5),
                width: 1.4,
              ),
            ),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_Palette.accent, _Palette.violet],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.bookmark_outlined,
                    color: Colors.white, size: 22),
              ),
              title: Text(
                'A representative ListTile',
                style: TextStyle(
                  color: _Palette.ink,
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: Text(
                'subtitle text — one line by default; wraps if isThreeLine.',
                style: TextStyle(
                  color: _Palette.inkSoft,
                  fontSize: 12.5,
                ),
              ),
              trailing: Icon(Icons.chevron_right, color: _Palette.warm),
            ),
          ),
          SizedBox(height: 12),
          _AnatomyLabelStrip(),
          SizedBox(height: 18),
          Text(
            'Padding and density properties',
            style: TextStyle(
              color: _Palette.ink,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          _PaddingSample(
            label: 'contentPadding: EdgeInsets.symmetric(h: 16, v: 0)',
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
          _PaddingSample(
            label: 'contentPadding: EdgeInsets.symmetric(h: 8, v: 4)',
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          _PaddingSample(
            label: 'contentPadding: EdgeInsets.all(20)',
            padding: EdgeInsets.all(20),
          ),
          _PaddingSample(
            label: 'contentPadding: EdgeInsets.fromLTRB(48, 8, 16, 8)',
            padding: EdgeInsets.fromLTRB(48, 8, 16, 8),
          ),
          SizedBox(height: 14),
          Text(
            'visualDensity samples',
            style: TextStyle(
              color: _Palette.ink,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          _DensitySample(
            label: 'VisualDensity.compact',
            density: VisualDensity.compact,
          ),
          _DensitySample(
            label: 'VisualDensity.standard',
            density: VisualDensity.standard,
          ),
          _DensitySample(
            label: 'VisualDensity.comfortable',
            density: VisualDensity.comfortable,
          ),
          _DensitySample(
            label: 'VisualDensity(h: 4, v: 4)',
            density: VisualDensity(horizontal: 4, vertical: 4),
          ),
          _DensitySample(
            label: 'VisualDensity(h: -4, v: -4)',
            density: VisualDensity(horizontal: -4, vertical: -4),
          ),
        ],
      ),
    );
  }
}

class _AnatomyLabelStrip extends StatelessWidget {
  const _AnatomyLabelStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _LabelPill(text: 'leading', color: _Palette.accent),
        ),
        SizedBox(width: 4),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _LabelPill(text: 'title', color: _Palette.violet),
              SizedBox(height: 4),
              _LabelPill(text: 'subtitle', color: _Palette.cool),
            ],
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: _LabelPill(text: 'trailing', color: _Palette.warm),
        ),
      ],
    );
  }
}

class _LabelPill extends StatelessWidget {
  final String text;
  final Color color;
  const _LabelPill({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _PaddingSample extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry padding;
  const _PaddingSample({required this.label, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 3),
          Container(
            decoration: BoxDecoration(
              color: _Palette.paperSoft,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _Palette.slateSoft, width: 0.6),
            ),
            child: ListTile(
              contentPadding: padding,
              leading: Icon(Icons.tune, color: _Palette.accent),
              title: Text(
                'padded tile',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('contentPadding controls outer slot insets.'),
              trailing: Icon(Icons.more_vert, color: _Palette.inkMute),
            ),
          ),
        ],
      ),
    );
  }
}

class _DensitySample extends StatelessWidget {
  final String label;
  final VisualDensity density;
  const _DensitySample({required this.label, required this.density});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 3),
          Container(
            decoration: BoxDecoration(
              color: _Palette.paperSoft,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _Palette.slateSoft, width: 0.6),
            ),
            child: ListTile(
              visualDensity: density,
              leading: Icon(Icons.density_medium, color: _Palette.cool),
              title: Text(
                'density-controlled tile',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('visualDensity shrinks vertical rhythm.'),
              trailing: Icon(Icons.unfold_more, color: _Palette.inkMute),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 6. LIST TILE STATE GRID
// =============================================================================

class _ListTileStateGrid extends StatelessWidget {
  const _ListTileStateGrid();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      tone: _Palette.leaf,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Chip(
                text: 'states',
                color: _Palette.leaf,
                icon: Icons.swap_horiz,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'static visuals',
                color: _Palette.slate,
                icon: Icons.visibility_outlined,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Each state is simulated with static tileColor / textColor / '
            'iconColor so we can see them side by side without any pointer '
            'events.',
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12),
          _StateRow(
            tag: 'DEFAULT',
            tone: _Palette.inkMute,
            tileColor: Colors.transparent,
            titleColor: _Palette.ink,
            subtitleColor: _Palette.inkSoft,
            iconColor: _Palette.inkSoft,
            description: 'no interaction; resting state.',
          ),
          _StateRow(
            tag: 'SELECTED',
            tone: _Palette.accent,
            tileColor: _Palette.accent.withValues(alpha: 0.14),
            titleColor: _Palette.accent,
            subtitleColor: _Palette.accent.withValues(alpha: 0.8),
            iconColor: _Palette.accent,
            description: 'tile is the current focus of a navigation rail.',
            selected: true,
          ),
          _StateRow(
            tag: 'DISABLED',
            tone: _Palette.slate,
            tileColor: _Palette.slateSoft.withValues(alpha: 0.4),
            titleColor: _Palette.inkMute,
            subtitleColor: _Palette.inkMute.withValues(alpha: 0.7),
            iconColor: _Palette.inkMute.withValues(alpha: 0.6),
            description: 'enabled:false; greys text and icon, removes ripple.',
            enabled: false,
          ),
          _StateRow(
            tag: 'FOCUSED',
            tone: _Palette.violet,
            tileColor: _Palette.violet.withValues(alpha: 0.10),
            titleColor: _Palette.ink,
            subtitleColor: _Palette.inkSoft,
            iconColor: _Palette.violet,
            description: 'keyboard focus halo; here drawn statically.',
            border: Border.all(
              color: _Palette.violet.withValues(alpha: 0.7),
              width: 2,
            ),
          ),
          _StateRow(
            tag: 'HOVERED',
            tone: _Palette.cool,
            tileColor: _Palette.cool.withValues(alpha: 0.10),
            titleColor: _Palette.ink,
            subtitleColor: _Palette.inkSoft,
            iconColor: _Palette.cool,
            description: 'pointer hover; lighter than selected.',
          ),
          _StateRow(
            tag: 'PRESSED',
            tone: _Palette.warm,
            tileColor: _Palette.warm.withValues(alpha: 0.20),
            titleColor: _Palette.warm,
            subtitleColor: _Palette.warm.withValues(alpha: 0.85),
            iconColor: _Palette.warm,
            description: 'simulated pressed background.',
          ),
          _StateRow(
            tag: 'ERROR',
            tone: _Palette.danger,
            tileColor: _Palette.dangerSoft.withValues(alpha: 0.4),
            titleColor: _Palette.danger,
            subtitleColor: _Palette.danger.withValues(alpha: 0.85),
            iconColor: _Palette.danger,
            description: 'static "error" variant via colors only.',
          ),
        ],
      ),
    );
  }
}

class _StateRow extends StatelessWidget {
  final String tag;
  final Color tone;
  final Color tileColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color iconColor;
  final String description;
  final bool selected;
  final bool enabled;
  final BoxBorder? border;
  const _StateRow({
    required this.tag,
    required this.tone,
    required this.tileColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.iconColor,
    required this.description,
    this.selected = false,
    this.enabled = true,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 84,
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: tone.withValues(alpha: 0.5)),
            ),
            child: Text(
              tag,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: tone,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: border,
                color: _Palette.paperSoft,
              ),
              child: ListTile(
                tileColor: tileColor,
                selected: selected,
                enabled: enabled,
                leading: Icon(Icons.folder_outlined, color: iconColor),
                title: Text(
                  tag.toLowerCase() + ' tile',
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: Text(
                  description,
                  style: TextStyle(color: subtitleColor),
                ),
                trailing: Icon(Icons.chevron_right, color: iconColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 7. LIST TILE VARIANTS (Checkbox / Radio / Switch)
// =============================================================================

class _ListTileVariantsSection extends StatelessWidget {
  const _ListTileVariantsSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      tone: _Palette.sun,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Chip(
                text: 'CheckboxListTile',
                color: _Palette.accent,
                icon: Icons.check_box_outlined,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'RadioListTile',
                color: _Palette.cool,
                icon: Icons.radio_button_checked,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'SwitchListTile',
                color: _Palette.warm,
                icon: Icons.toggle_on,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'These three are thin wrappers around ListTile that add a leading '
            'or trailing control. They expose ListTile passthroughs like '
            'subtitle, secondary, contentPadding, dense, shape.',
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          _VariantGroup(
            title: 'CheckboxListTile',
            tone: _Palette.accent,
            tiles: [
              CheckboxListTile(
                value: true,
                onChanged: null,
                title: Text('Bold weights enabled'),
                subtitle: Text('exports include w800 and w900.'),
                secondary: Icon(Icons.format_bold, color: _Palette.accent),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                value: false,
                onChanged: null,
                title: Text('Show experimental fonts'),
                subtitle: Text('off — keeps the font menu compact.'),
                secondary: Icon(Icons.science_outlined, color: _Palette.accent),
              ),
              CheckboxListTile(
                tristate: true,
                value: null,
                onChanged: null,
                title: Text('Apply to nested folders'),
                subtitle: Text('tristate; here shown as indeterminate.'),
                secondary:
                    Icon(Icons.folder_copy_outlined, color: _Palette.accent),
              ),
            ],
          ),
          SizedBox(height: 14),
          _VariantGroup(
            title: 'RadioListTile<int>',
            tone: _Palette.cool,
            tiles: [
              RadioListTile<int>(
                value: 1,
                groupValue: 2,
                onChanged: null,
                title: Text('Low contrast'),
                subtitle: Text('softer text on softer paper.'),
                secondary: Icon(Icons.contrast, color: _Palette.cool),
              ),
              RadioListTile<int>(
                value: 2,
                groupValue: 2,
                onChanged: null,
                title: Text('Standard contrast'),
                subtitle: Text('the recommended default.'),
                secondary:
                    Icon(Icons.brightness_medium, color: _Palette.cool),
              ),
              RadioListTile<int>(
                value: 3,
                groupValue: 2,
                onChanged: null,
                title: Text('High contrast'),
                subtitle: Text('AAA-grade dark-on-light.'),
                secondary: Icon(Icons.brightness_high, color: _Palette.cool),
              ),
            ],
          ),
          SizedBox(height: 14),
          _VariantGroup(
            title: 'SwitchListTile',
            tone: _Palette.warm,
            tiles: [
              SwitchListTile(
                value: true,
                onChanged: null,
                title: Text('Sync queue follow-ups'),
                subtitle: Text('on — follow-up prompts auto-queue.'),
                secondary: Icon(Icons.sync, color: _Palette.warm),
              ),
              SwitchListTile(
                value: false,
                onChanged: null,
                title: Text('Vibrate on completion'),
                subtitle: Text('off — silent completion.'),
                secondary: Icon(Icons.vibration, color: _Palette.warm),
              ),
              SwitchListTile(
                value: true,
                onChanged: null,
                title: Text('Auto-archive answered queues'),
                subtitle: Text('keeps active list tidy.'),
                secondary:
                    Icon(Icons.archive_outlined, color: _Palette.warm),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VariantGroup extends StatelessWidget {
  final String title;
  final Color tone;
  final List<Widget> tiles;
  const _VariantGroup({
    required this.title,
    required this.tone,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.paperSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.18),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: tone,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
                letterSpacing: 0.4,
              ),
            ),
          ),
          ...tiles,
        ],
      ),
    );
  }
}

// =============================================================================
// 8. LIST + DIVIDER PATTERNS (divideTiles)
// =============================================================================

class _ListPatternSection extends StatelessWidget {
  const _ListPatternSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      tone: _Palette.cool,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Chip(
                text: 'ListTile.divideTiles',
                color: _Palette.cool,
                icon: Icons.horizontal_rule,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'mixed Divider',
                color: _Palette.violet,
                icon: Icons.format_list_bulleted,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Three common list patterns: raw tiles, divideTiles-separated '
            'tiles, and an explicit Divider between named groups.',
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          _PatternBlock(
            title: 'A. raw tiles (no dividers)',
            tone: _Palette.slate,
            children: _buildRawTiles(),
          ),
          SizedBox(height: 14),
          _PatternBlock(
            title: 'B. divideTiles(...)',
            tone: _Palette.cool,
            children: ListTile.divideTiles(
              context: context,
              color: _Palette.cool.withValues(alpha: 0.4),
              tiles: _buildRawTiles(),
            ).toList(),
          ),
          SizedBox(height: 14),
          _PatternBlock(
            title: 'C. explicit Divider per group break',
            tone: _Palette.violet,
            children: [
              _GroupHeader(label: 'WORKSPACE', tone: _Palette.violet),
              ListTile(
                leading: Icon(Icons.folder, color: _Palette.violet),
                title: Text('tom_agent_container'),
                subtitle: Text('top-level workspace'),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.folder_open, color: _Palette.violet),
                title: Text('tom_ai'),
                subtitle: Text('AI build + bridge ecosystem'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(
                height: 1,
                thickness: 1.4,
                color: _Palette.violet.withValues(alpha: 0.5),
              ),
              _GroupHeader(label: 'QUESTS', tone: _Palette.accent),
              ListTile(
                leading: Icon(Icons.flag, color: _Palette.accent),
                title: Text('d4rt'),
                subtitle: Text('interpreter + bridges'),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.flag_outlined, color: _Palette.accent),
                title: Text('flutter_ui'),
                subtitle: Text('reusable widgets'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(
                height: 1,
                thickness: 1.4,
                color: _Palette.violet.withValues(alpha: 0.5),
              ),
              _GroupHeader(label: 'TOOLS', tone: _Palette.warm),
              ListTile(
                leading: Icon(Icons.terminal, color: _Palette.warm),
                title: Text('testkit'),
                subtitle: Text('test tracking and baselines'),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.build, color: _Palette.warm),
                title: Text('tom_build'),
                subtitle: Text('end-to-end build orchestration'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRawTiles() {
    return [
      ListTile(
        leading: Icon(Icons.inbox_outlined, color: _Palette.cool),
        title: Text('Inbox'),
        subtitle: Text('12 new items'),
        trailing: Icon(Icons.chevron_right, color: _Palette.inkMute),
      ),
      ListTile(
        leading: Icon(Icons.send_outlined, color: _Palette.cool),
        title: Text('Sent'),
        subtitle: Text('synced 3m ago'),
        trailing: Icon(Icons.chevron_right, color: _Palette.inkMute),
      ),
      ListTile(
        leading: Icon(Icons.drafts_outlined, color: _Palette.cool),
        title: Text('Drafts'),
        subtitle: Text('4 unfinished'),
        trailing: Icon(Icons.chevron_right, color: _Palette.inkMute),
      ),
      ListTile(
        leading: Icon(Icons.archive_outlined, color: _Palette.cool),
        title: Text('Archive'),
        subtitle: Text('older than 90 days'),
        trailing: Icon(Icons.chevron_right, color: _Palette.inkMute),
      ),
      ListTile(
        leading: Icon(Icons.delete_outline, color: _Palette.cool),
        title: Text('Trash'),
        subtitle: Text('auto-purged after 30 days'),
        trailing: Icon(Icons.chevron_right, color: _Palette.inkMute),
      ),
    ];
  }
}

class _PatternBlock extends StatelessWidget {
  final String title;
  final Color tone;
  final List<Widget> children;
  const _PatternBlock({
    required this.title,
    required this.tone,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.paperSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  tone.withValues(alpha: 0.22),
                  tone.withValues(alpha: 0.06),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: tone,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  final String label;
  final Color tone;
  const _GroupHeader({required this.label, required this.tone});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Text(
        label,
        style: TextStyle(
          color: tone,
          fontSize: 10.5,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

// =============================================================================
// 9. LIST TILE THEME INHERITANCE CHAIN
// =============================================================================

class _ListTileThemeChainSection extends StatelessWidget {
  const _ListTileThemeChainSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      tone: _Palette.violet,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Chip(
                text: 'ListTileTheme',
                color: _Palette.violet,
                icon: Icons.style_outlined,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'nested overrides',
                color: _Palette.warm,
                icon: Icons.layers_outlined,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Nested ListTileTheme.merge calls inherit unset properties from '
            'their parent and override the ones they set. Below we walk one '
            'theme down two more levels.',
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          _ThemeLevel(
            label: 'level 1 — outer ListTileTheme',
            tone: _Palette.violet,
            child: ListTileTheme(
              data: ListTileThemeData(
                iconColor: _Palette.violet,
                textColor: _Palette.violet,
                tileColor: _Palette.violetSoft.withValues(alpha: 0.4),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 18, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.bookmark),
                    title: Text('Outer-themed tile A'),
                    subtitle: Text('inherits violet text + icon.'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  SizedBox(height: 6),
                  _ThemeLevel(
                    label: 'level 2 — nested ListTileTheme.merge',
                    tone: _Palette.warm,
                    child: ListTileTheme.merge(
                      iconColor: _Palette.warm,
                      textColor: _Palette.warm,
                      tileColor:
                          _Palette.warmSoft.withValues(alpha: 0.5),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.flash_on),
                            title: Text('Inner-themed tile B'),
                            subtitle: Text(
                                'overrides icon+text+tile, inherits shape.'),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          SizedBox(height: 6),
                          _ThemeLevel(
                            label: 'level 3 — nested again',
                            tone: _Palette.cool,
                            child: ListTileTheme.merge(
                              iconColor: _Palette.cool,
                              textColor: _Palette.cool,
                              tileColor: _Palette.coolSoft
                                  .withValues(alpha: 0.55),
                              child: ListTile(
                                leading: Icon(Icons.eco),
                                title: Text('Deepest-themed tile C'),
                                subtitle: Text(
                                    'inherits shape from level 1, '
                                    'colors from level 3.'),
                                trailing: Icon(Icons.chevron_right),
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
          ),
          SizedBox(height: 10),
          _Caption(
            label: 'TAKEAWAY',
            value:
                'ListTileTheme.merge only sets fields you pass; everything '
                'else flows down from ancestor themes.',
            tone: _Palette.inkMute,
          ),
        ],
      ),
    );
  }
}

class _ThemeLevel extends StatelessWidget {
  final String label;
  final Color tone;
  final Widget child;
  const _ThemeLevel({
    required this.label,
    required this.tone,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _Palette.paperSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.5), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: tone,
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

// =============================================================================
// 10. PITFALLS
// =============================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      tone: _Palette.danger,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Chip(
                text: 'pitfalls',
                color: _Palette.danger,
                icon: Icons.warning_amber_outlined,
              ),
              SizedBox(width: 6),
              _Chip(
                text: 'foot-guns',
                color: _Palette.warm,
                icon: Icons.report_outlined,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Three concrete traps and how the demo renders them. Each one '
            'shows the wrong shape next to a corrected version.',
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          _PitfallCard(
            number: '1',
            title: 'selected + tileColor conflict',
            body:
                'When selected is true, ListTile draws selectedTileColor — '
                'but if you also pass tileColor that does not change with '
                'selection, the tile will look "stuck" in the unselected '
                'palette.',
            tone: _Palette.danger,
            wrong: Container(
              decoration: BoxDecoration(
                color: _Palette.paperSoft,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: _Palette.danger.withValues(alpha: 0.6)),
              ),
              child: ListTile(
                selected: true,
                tileColor: Colors.transparent,
                title: Text(
                  'wrong: selected but tile transparent',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('reads as unselected to the eye.'),
                leading: Icon(Icons.cancel_outlined, color: _Palette.danger),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            right: Container(
              decoration: BoxDecoration(
                color: _Palette.paperSoft,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: _Palette.leaf.withValues(alpha: 0.6)),
              ),
              child: ListTile(
                selected: true,
                selectedTileColor:
                    _Palette.accent.withValues(alpha: 0.14),
                selectedColor: _Palette.accent,
                title: Text(
                  'right: selectedTileColor + selectedColor',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('clearly indicated selection.'),
                leading: Icon(Icons.check_circle_outline,
                    color: _Palette.accent),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          SizedBox(height: 14),
          _PitfallCard(
            number: '2',
            title: 'contentPadding × visualDensity',
            body:
                'These two stack. Heavy contentPadding plus large '
                'VisualDensity yields huge tiles; tight contentPadding plus '
                'negative density yields cramped, hard-to-tap rows.',
            tone: _Palette.warm,
            wrong: Container(
              decoration: BoxDecoration(
                color: _Palette.paperSoft,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: _Palette.danger.withValues(alpha: 0.6)),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                visualDensity:
                    VisualDensity(horizontal: -4, vertical: -4),
                leading: Icon(Icons.unfold_less, color: _Palette.danger),
                title: Text(
                  'wrong: tiny padding + min density',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('hit target too small for fingers.'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            right: Container(
              decoration: BoxDecoration(
                color: _Palette.paperSoft,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: _Palette.leaf.withValues(alpha: 0.6)),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                visualDensity: VisualDensity.standard,
                leading: Icon(Icons.unfold_more, color: _Palette.leaf),
                title: Text(
                  'right: standard padding + density',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('comfortable, accessible target.'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          SizedBox(height: 14),
          _PitfallCard(
            number: '3',
            title: 'divideTiles vs explicit Divider',
            body:
                'divideTiles inserts thin separators between tiles. If you '
                'ALSO drop in a thick Divider for groups, the two visual '
                'languages can clash; pick one.',
            tone: _Palette.violet,
            wrong: Container(
              decoration: BoxDecoration(
                color: _Palette.paperSoft,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: _Palette.danger.withValues(alpha: 0.6)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.brightness_low),
                    title: Text('alpha',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  Divider(height: 1, color: _Palette.slate),
                  ListTile(
                    leading: Icon(Icons.brightness_medium),
                    title: Text('beta',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  Divider(height: 4, thickness: 3, color: _Palette.danger),
                  ListTile(
                    leading: Icon(Icons.brightness_high),
                    title: Text('gamma',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            right: Container(
              decoration: BoxDecoration(
                color: _Palette.paperSoft,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: _Palette.leaf.withValues(alpha: 0.6)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.brightness_low,
                        color: _Palette.leaf),
                    title: Text('alpha',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  Divider(height: 1, color: _Palette.slateSoft),
                  ListTile(
                    leading: Icon(Icons.brightness_medium,
                        color: _Palette.leaf),
                    title: Text('beta',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  Divider(height: 1, color: _Palette.slateSoft),
                  ListTile(
                    leading: Icon(Icons.brightness_high,
                        color: _Palette.leaf),
                    title: Text('gamma',
                        style: TextStyle(fontWeight: FontWeight.w700)),
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

class _PitfallCard extends StatelessWidget {
  final String number;
  final String title;
  final String body;
  final Color tone;
  final Widget wrong;
  final Widget right;
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.body,
    required this.tone,
    required this.wrong,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tone.withValues(alpha: 0.10),
            tone.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tone,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  number,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _Palette.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              color: _Palette.inkSoft,
              fontSize: 12.5,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _Palette.danger.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'WRONG',
                        style: TextStyle(
                          color: _Palette.danger,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    wrong,
                  ],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _Palette.leaf.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'RIGHT',
                        style: TextStyle(
                          color: _Palette.leaf,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    right,
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

// =============================================================================
// 11. FOOTER SECTION
// =============================================================================

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 36),
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.slate,
            _Palette.ink,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recap',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'eleven angles on dividing and listing — all rendered with no '
            'animations or external state.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.0),
                  Colors.white.withValues(alpha: 0.4),
                  Colors.white.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'PALETTE',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Swatch(name: 'ink', color: _Palette.ink),
              _Swatch(name: 'inkSoft', color: _Palette.inkSoft),
              _Swatch(name: 'inkMute', color: _Palette.inkMute),
              _Swatch(name: 'paper', color: _Palette.paper),
              _Swatch(name: 'paperSoft', color: _Palette.paperSoft),
              _Swatch(name: 'accent', color: _Palette.accent),
              _Swatch(name: 'warm', color: _Palette.warm),
              _Swatch(name: 'cool', color: _Palette.cool),
              _Swatch(name: 'danger', color: _Palette.danger),
              _Swatch(name: 'sun', color: _Palette.sun),
              _Swatch(name: 'leaf', color: _Palette.leaf),
              _Swatch(name: 'violet', color: _Palette.violet),
              _Swatch(name: 'slate', color: _Palette.slate),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline,
                    color: Colors.white.withValues(alpha: 0.85), size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'All Divider and ListTile widgets above are 100% static. '
                    'No setState, no Tickers, no timers, no async. '
                    'Re-render the tree as many times as you want — the '
                    'output is deterministic.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.88),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _FooterTag(text: '11 sections'),
              SizedBox(width: 6),
              _FooterTag(text: '6+ gradient decorations'),
              SizedBox(width: 6),
              _FooterTag(text: 'static only'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  final String name;
  final Color color;
  const _Swatch({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
          ),
          SizedBox(width: 6),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterTag extends StatelessWidget {
  final String text;
  const _FooterTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// =============================================================================
// ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Divider + ListTile Deep Demo',
    home: Scaffold(
      backgroundColor: _Palette.paper,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeroBannerSection(),
            _SectionHeader(
              index: '2',
              title: 'Divider property gallery',
              subtitle: 'height · thickness · color, all in one ladder',
              tone: _Palette.accent,
            ),
            _DividerPropertyGallery(),
            _SectionHeader(
              index: '3',
              title: 'Indent / endIndent rulers',
              subtitle: 'where the rule starts and where it stops',
              tone: _Palette.warm,
            ),
            _IndentRulerSection(),
            _SectionHeader(
              index: '4',
              title: 'VerticalDivider toolbar',
              subtitle: 'splitting clusters in a horizontal layout',
              tone: _Palette.cool,
            ),
            _VerticalDividerToolbar(),
            _SectionHeader(
              index: '5',
              title: 'ListTile anatomy',
              subtitle: 'leading · title · subtitle · trailing — plus padding',
              tone: _Palette.violet,
            ),
            _ListTileAnatomySection(),
            _SectionHeader(
              index: '6',
              title: 'ListTile state grid',
              subtitle: 'default · selected · disabled · focused · hover',
              tone: _Palette.leaf,
            ),
            _ListTileStateGrid(),
            _SectionHeader(
              index: '7',
              title: 'ListTile variants',
              subtitle: 'CheckboxListTile · RadioListTile · SwitchListTile',
              tone: _Palette.sun,
            ),
            _ListTileVariantsSection(),
            _SectionHeader(
              index: '8',
              title: 'List + Divider patterns',
              subtitle: 'raw · divideTiles · explicit Divider groups',
              tone: _Palette.cool,
            ),
            _ListPatternSection(),
            _SectionHeader(
              index: '9',
              title: 'ListTileTheme inheritance',
              subtitle: 'three nested levels of merge',
              tone: _Palette.violet,
            ),
            _ListTileThemeChainSection(),
            _SectionHeader(
              index: '10',
              title: 'Pitfalls',
              subtitle: 'three concrete foot-guns and their fixes',
              tone: _Palette.danger,
            ),
            _PitfallsSection(),
            _FooterSection(),
          ],
        ),
      ),
    ),
  );
}
