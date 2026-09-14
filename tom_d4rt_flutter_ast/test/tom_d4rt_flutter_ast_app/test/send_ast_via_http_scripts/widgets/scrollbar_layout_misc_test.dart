// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// =====================================================================
// Scrollbar Layout & Miscellaneous — Deep Visual Demo
// =====================================================================
//
// This file is a hand-authored exploration of Flutter's scrollbar
// machinery focused on layout, theming, and miscellaneous behavior.
// It is intentionally long and structured so that each subsystem can
// be inspected in isolation.
//
// Widgets covered:
//   * Scrollbar              — Material scrollbar wrapper around RawScrollbar.
//   * RawScrollbar           — low-level scrollbar primitive with all knobs.
//   * ScrollbarTheme         — InheritedTheme injecting ScrollbarThemeData.
//   * ScrollbarThemeData     — token bag for scrollbar appearance.
//   * ScrollbarOrientation   — enum for thumb placement (left/right/top/bottom).
//   * CupertinoScrollbar     — iOS-styled scrollbar with bouncing physics feel.
//
// Sections:
//   1. Dossier — overview, when to use, motivation.
//   2. Anatomy — thumb / track / extent / radius / thickness / orientation.
//   3. Recipes — vertical, horizontal, themed, alwaysShown, interactive,
//                ScrollbarTheme override, dark mode, fat thumb, thin thumb.
//   4. Comparison — Scrollbar vs CupertinoScrollbar.
//   5. RawScrollbar variations.
//   6. Common pitfalls — PrimaryScrollController, multiple scrollables, etc.
//   7. Glossary.
//   8. Recap.
//
// The build entry point returns a MaterialApp containing a stateless
// scaffold that lays out all sections in a single scrollable page.
// =====================================================================

// ---------------------------------------------------------------------
// Palette and typography tokens
// ---------------------------------------------------------------------

const Color _kSurface       = Color(0xFFF8F7F4);
const Color _kCard          = Color(0xFFFFFFFF);
const Color _kCardAlt       = Color(0xFFFDFCF8);
const Color _kInk           = Color(0xFF1B1B1F);
const Color _kInkSoft       = Color(0xFF4A4A52);
const Color _kInkMuted      = Color(0xFF8A8A93);
const Color _kDivider       = Color(0xFFE7E4DC);
const Color _kAccent        = Color(0xFF2F6FED);
const Color _kAccentSoft    = Color(0xFFD9E4FB);
const Color _kAccentDark    = Color(0xFF173E91);
const Color _kTeal          = Color(0xFF0E9488);
const Color _kTealSoft      = Color(0xFFCFEAE6);
const Color _kAmber         = Color(0xFFD97706);
const Color _kAmberSoft     = Color(0xFFFCE8C8);
const Color _kRose          = Color(0xFFE11D48);
const Color _kRoseSoft      = Color(0xFFFBD5DD);
const Color _kEmerald       = Color(0xFF059669);
const Color _kEmeraldSoft   = Color(0xFFCDF1E1);
const Color _kViolet        = Color(0xFF7C3AED);
const Color _kVioletSoft    = Color(0xFFE4D7FC);
const Color _kSlate         = Color(0xFF334155);
const Color _kSlateSoft     = Color(0xFFDCE3EE);
const Color _kDark          = Color(0xFF0F172A);
const Color _kDarkCard      = Color(0xFF1E293B);
const Color _kDarkInk       = Color(0xFFE2E8F0);
const Color _kDarkInkSoft   = Color(0xFF94A3B8);
const Color _kDarkDivider   = Color(0xFF334155);

const String _kMono = 'monospace';

// ---------------------------------------------------------------------
// Reusable small primitives (stateless)
// ---------------------------------------------------------------------

class _Spacer extends StatelessWidget {
  const _Spacer(this.size, {this.horizontal = false});
  final double size;
  final bool horizontal;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontal ? size : 0,
      height: horizontal ? 0 : size,
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.color,
    this.background,
    this.icon,
  });
  final String label;
  final Color color;
  final Color? background;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background ?? color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontFamily: _kMono,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });
  final String index;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.16),
            color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: color.withValues(alpha: 0.5)),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      index,
                      style: TextStyle(
                        fontFamily: _kMono,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: color,
                        letterSpacing: 1.3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 13,
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

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.child,
    this.subtitle,
    this.accent = _kAccent,
    this.tag,
  });
  final String title;
  final String? subtitle;
  final Widget child;
  final Color accent;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: _kDivider)),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: _kInk,
                        ),
                      ),
                      if (subtitle != null) ...<Widget>[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: _kInkMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (tag != null)
                  _Pill(label: tag!, color: accent),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text, {this.color = _kInkSoft, this.italic = true});
  final String text;
  final Color color;
  final bool italic;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          height: 1.45,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text, {this.color = _kAccent});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 10),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: _kInkSoft,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code, {this.color = _kInk});
  final String code;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0E8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kDivider),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: _kMono,
          fontSize: 11.5,
          color: color,
          height: 1.5,
        ),
      ),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow(this.k, this.v, {this.tone = _kInkSoft});
  final String k;
  final String v;
  final Color tone;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              k,
              style: TextStyle(
                fontFamily: _kMono,
                fontSize: 11.5,
                color: tone,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(
                fontSize: 12,
                color: _kInk,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _kInkSoft,
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

class _SampleContent extends StatelessWidget {
  const _SampleContent({
    required this.itemCount,
    this.color = _kAccent,
    this.horizontal = false,
    this.controller,
  });
  final int itemCount;
  final Color color;
  final bool horizontal;
  // Cluster G TODO #14 / 1401-TODO #2 (F3): when the enclosing Scrollbar uses
  // `thumbVisibility:true` it MUST share its ScrollController with the inner
  // Scrollable. Callers pass the same controller they hand to the Scrollbar.
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    if (horizontal) {
      return ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (BuildContext c, int i) {
          return Container(
            width: 110,
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10 + (i % 6) * 0.04),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            alignment: Alignment.center,
            child: Text(
              'tile ${i.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontFamily: _kMono,
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          );
        },
      );
    }
    return ListView.builder(
      controller: controller,
      itemCount: itemCount,
      itemBuilder: (BuildContext c, int i) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08 + (i % 5) * 0.03),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.30)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontFamily: _kMono,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'row item #$i — sample scrollable content',
                  style: const TextStyle(
                    fontSize: 13,
                    color: _kInk,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: color.withValues(alpha: 0.6), size: 18),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------
// Section 1 — Dossier
// ---------------------------------------------------------------------

class _DossierSection extends StatelessWidget {
  const _DossierSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          index: 'SECTION 01',
          title: 'Dossier — scrollbar surfaces at a glance',
          subtitle:
              'Why these widgets exist, when to reach for them, and how '
              'they relate to the broader scrolling system.',
          color: _kAccent,
          icon: Icons.fact_check_outlined,
        ),
        _Card(
          title: 'Scrollbar',
          subtitle: 'package:flutter/material.dart',
          accent: _kAccent,
          tag: 'material',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'A Material-themed wrapper around RawScrollbar. It picks '
                'colors, sizing, and fade defaults from the ambient '
                'ThemeData.scrollbarTheme. Wrap any single scrollable in a '
                'Scrollbar to make it visible.',
                style: TextStyle(fontSize: 13, color: _kInk, height: 1.5),
              ),
              const SizedBox(height: 10),
              _CodeBlock(
                'Scrollbar(\n'
                '  controller: controller,\n'
                '  thumbVisibility: true,\n'
                '  trackVisibility: true,\n'
                '  thickness: 8,\n'
                '  radius: const Radius.circular(4),\n'
                '  child: ListView(controller: controller, ...),\n'
                ')',
              ),
              const SizedBox(height: 10),
              const _Bullet('Always pair an explicit controller with the inner Scrollable when using thumbVisibility.'),
              const _Bullet('On desktop/web the thumb is interactive (drag).'),
              const _Bullet('On mobile the thumb fades after scroll ends.'),
            ],
          ),
        ),
        _Card(
          title: 'RawScrollbar',
          subtitle: 'package:flutter/widgets.dart',
          accent: _kTeal,
          tag: 'raw',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'The platform-agnostic base implementation. Both Material '
                'Scrollbar and CupertinoScrollbar delegate to it. Use it '
                'directly when you need bespoke colors and behavior outside '
                'of either design system.',
                style: TextStyle(fontSize: 13, color: _kInk, height: 1.5),
              ),
              const SizedBox(height: 10),
              _CodeBlock(
                'RawScrollbar(\n'
                '  controller: controller,\n'
                '  thumbColor: Colors.orange,\n'
                '  thickness: 10,\n'
                '  radius: const Radius.circular(2),\n'
                '  thumbVisibility: true,\n'
                '  child: ListView(controller: controller, ...),\n'
                ')',
              ),
              const SizedBox(height: 10),
              const _Bullet('Exposes every knob the Material/Cupertino wrappers hide.'),
              const _Bullet('Subclass it for custom paint logic when needed.'),
            ],
          ),
        ),
        _Card(
          title: 'ScrollbarTheme + ScrollbarThemeData',
          subtitle: 'theming layer',
          accent: _kViolet,
          tag: 'theme',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'ScrollbarThemeData is the immutable bag of tokens that '
                'configure Material Scrollbar appearance: colors, '
                'thickness, radius, visibility flags, and interactive '
                'feedback. ScrollbarTheme is the InheritedTheme that '
                'projects them into a subtree.',
                style: TextStyle(fontSize: 13, color: _kInk, height: 1.5),
              ),
              const SizedBox(height: 10),
              _CodeBlock(
                'ScrollbarTheme(\n'
                '  data: ScrollbarThemeData(\n'
                '    thumbColor: WidgetStateProperty.all(Colors.purple),\n'
                '    thickness: WidgetStateProperty.all(12),\n'
                '    thumbVisibility: WidgetStateProperty.all(true),\n'
                '  ),\n'
                '  child: Scrollbar(child: ...),\n'
                ')',
              ),
              const SizedBox(height: 10),
              const _Bullet('Most properties are WidgetStateProperty so they react to hover/drag.'),
              const _Bullet('Apply at app level via ThemeData.scrollbarTheme for consistent style.'),
            ],
          ),
        ),
        _Card(
          title: 'ScrollbarOrientation',
          subtitle: 'enum: left, right, top, bottom',
          accent: _kAmber,
          tag: 'enum',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Tells the scrollbar machinery on which edge to draw the '
                'track and thumb. Defaults to right for vertical content '
                'and bottom for horizontal content. RawScrollbar accepts '
                'an explicit ScrollbarOrientation argument.',
                style: TextStyle(fontSize: 13, color: _kInk, height: 1.5),
              ),
              SizedBox(height: 10),
              _Bullet('left/right are valid for vertical scrolls only.'),
              _Bullet('top/bottom are valid for horizontal scrolls only.'),
              _Bullet('Mixing axis and orientation throws an assertion at build time.'),
            ],
          ),
        ),
        _Card(
          title: 'CupertinoScrollbar',
          subtitle: 'package:flutter/cupertino.dart',
          accent: _kEmerald,
          tag: 'iOS',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Pixel-tuned to match iOS scrollbar behavior — thin '
                'translucent pill that fattens when the user starts '
                'dragging it, with default fade timing and physics.',
                style: TextStyle(fontSize: 13, color: _kInk, height: 1.5),
              ),
              const SizedBox(height: 10),
              _CodeBlock(
                'CupertinoScrollbar(\n'
                '  controller: controller,\n'
                '  thumbVisibility: false,\n'
                '  thickness: 3,\n'
                '  thicknessWhileDragging: 8,\n'
                '  radius: const Radius.circular(1.5),\n'
                '  radiusWhileDragging: const Radius.circular(4),\n'
                '  child: ListView(controller: controller, ...),\n'
                ')',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Section 2 — Anatomy of a scrollbar
// ---------------------------------------------------------------------

class _AnatomyDiagram extends StatelessWidget {
  const _AnatomyDiagram();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: _kCardAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kDivider),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 0, 14),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kDivider),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    for (int i = 0; i < 8; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        height: 18,
                        decoration: BoxDecoration(
                          color: _kAccent.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Track
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            width: 22,
            decoration: BoxDecoration(
              color: _kSlateSoft,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kSlate.withValues(alpha: 0.3)),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 28),
                    width: 14,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _kAccent,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Labels
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #132, P2):
              // Wrap the Labels Column in a non-scrolling SingleChildScrollView
              // so the bounded 260 px parent Container clips overflow via
              // RenderViewport.Clip.hardEdge instead of raising a 32 px
              // RenderFlex overflow.
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    _LabelDot(color: _kAccent, label: 'thumb', detail: 'visible draggable bar'),
                    _LabelDot(color: _kSlate, label: 'track', detail: 'background area'),
                    _LabelDot(color: _kInkMuted, label: 'extent', detail: 'viewport vs content ratio'),
                    _LabelDot(color: _kViolet, label: 'radius', detail: 'corner rounding'),
                    _LabelDot(color: _kAmber, label: 'thickness', detail: 'width across axis'),
                    _LabelDot(color: _kEmerald, label: 'orientation', detail: 'edge placement'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelDot extends StatelessWidget {
  const _LabelDot({required this.color, required this.label, required this.detail});
  final Color color;
  final String label;
  final String detail;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                    fontSize: 12,
                    fontFamily: _kMono,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(fontSize: 11, color: _kInkSoft, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          index: 'SECTION 02',
          title: 'Anatomy — thumb, track, extent, radius, thickness, orientation',
          subtitle:
              'Vocabulary for talking about scrollbar parts. Each token '
              'in ScrollbarThemeData maps to one of these concepts.',
          color: _kTeal,
          icon: Icons.architecture,
        ),
        _Card(
          title: 'Visual map',
          accent: _kTeal,
          child: const _AnatomyDiagram(),
        ),
        _Card(
          title: 'Property reference',
          accent: _kTeal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _KeyValueRow('thumb', 'The draggable indicator the user interacts with.'),
              _KeyValueRow('track', 'Background under the thumb. May be invisible by default.'),
              _KeyValueRow('extent', 'Computed from viewport / content; controls thumb length.'),
              _KeyValueRow('thickness', 'Width across the scroll axis. Typical 6–10 logical px.'),
              _KeyValueRow('radius', 'Corner rounding for thumb and (optionally) track.'),
              _KeyValueRow('orientation', 'left/right for vertical, top/bottom for horizontal.'),
              _KeyValueRow('minThumbLength', 'Hard floor on visible thumb size.'),
              _KeyValueRow('crossAxisMargin', 'Spacing from the viewport edge to the track.'),
              _KeyValueRow('mainAxisMargin', 'Spacing from viewport ends to track ends.'),
              _KeyValueRow('fadeDuration', 'How long the thumb takes to fade out.'),
              _KeyValueRow('timeToFade', 'Idle time before fade begins.'),
              _KeyValueRow('pressDuration', 'Hold time on the track before thumb activates.'),
            ],
          ),
        ),
        _Card(
          title: 'How extent maps to thumb length',
          accent: _kTeal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'thumbLength = max(minThumbLength, viewportHeight * '
                '(viewportHeight / contentHeight)). A short list relative '
                'to the viewport produces a long thumb; a long list '
                'produces a short, fast thumb.',
                style: TextStyle(fontSize: 13, color: _kInk, height: 1.5),
              ),
              const SizedBox(height: 10),
              _CodeBlock(
                'final ratio = viewportSize / contentSize;\n'
                'final thumbSize = max(minThumbLength, viewportSize * ratio);\n'
                '// thumbOffset = scrollOffset * (viewportSize - thumbSize) / (contentSize - viewportSize);',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Section 3 — Recipes
// ---------------------------------------------------------------------

/// A small ScrollController owner that constructs its controller in the
/// constructor so the Scrollbar can claim it without needing State.
class _LocalScroll extends StatelessWidget {
  _LocalScroll({
    required this.builder,
    double initialOffset = 0,
  }) : controller = ScrollController(initialScrollOffset: initialOffset);

  final ScrollController controller;
  final Widget Function(BuildContext, ScrollController) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, controller);
  }
}

class _RecipeBoxFrame extends StatelessWidget {
  const _RecipeBoxFrame({
    required this.child,
    this.height = 220,
    this.background = _kCardAlt,
  });
  final Widget child;
  final double height;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kDivider),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _RecipeVerticalScrollbar extends StatelessWidget {
  const _RecipeVerticalScrollbar();
  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Recipe 1 — Vertical Scrollbar (defaults)',
      subtitle: 'Scrollbar wraps a ListView with shared controller.',
      accent: _kAccent,
      tag: 'vertical',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeBoxFrame(
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return Scrollbar(
                  controller: ctrl,
                  thumbVisibility: true,
                  child: _SampleContent(itemCount: 28, color: _kAccent, controller: ctrl),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          _CodeBlock(
            'Scrollbar(\n'
            '  controller: controller,\n'
            '  thumbVisibility: true,\n'
            '  child: ListView.builder(controller: controller, itemCount: 28, ...),\n'
            ')',
          ),
          const _Caption(
              'thumbVisibility: true forces the thumb to stay visible. '
              'Without it the thumb fades after the user stops interacting.'),
        ],
      ),
    );
  }
}

class _RecipeHorizontalScrollbar extends StatelessWidget {
  const _RecipeHorizontalScrollbar();
  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Recipe 2 — Horizontal Scrollbar',
      subtitle: 'Track sits at the bottom of the viewport by default.',
      accent: _kTeal,
      tag: 'horizontal',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeBoxFrame(
            height: 140,
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return Scrollbar(
                  controller: ctrl,
                  thumbVisibility: true,
                  child: ListView.builder(
                    controller: ctrl,
                    scrollDirection: Axis.horizontal,
                    itemCount: 24,
                    itemBuilder: (BuildContext c, int i) {
                      return Container(
                        width: 88,
                        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 18),
                        decoration: BoxDecoration(
                          color: _kTeal.withValues(alpha: 0.10 + (i % 5) * 0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _kTeal.withValues(alpha: 0.45)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'col $i',
                          style: const TextStyle(
                            fontFamily: _kMono,
                            color: _kTeal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const _Caption('Horizontal Scrollbar — orientation defaults to bottom.'),
        ],
      ),
    );
  }
}

class _RecipeThemedScrollbar extends StatelessWidget {
  const _RecipeThemedScrollbar();
  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Recipe 3 — Themed Scrollbar via ScrollbarTheme',
      subtitle: 'Inject a ScrollbarThemeData into the subtree.',
      accent: _kViolet,
      tag: 'theme',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeBoxFrame(
            child: ScrollbarTheme(
              data: ScrollbarThemeData(
                thumbColor: WidgetStateProperty.all(_kViolet),
                trackColor: WidgetStateProperty.all(_kVioletSoft),
                trackBorderColor: WidgetStateProperty.all(_kViolet.withValues(alpha: 0.4)),
                thickness: WidgetStateProperty.all(10),
                radius: const Radius.circular(5),
                thumbVisibility: WidgetStateProperty.all(true),
                trackVisibility: WidgetStateProperty.all(true),
              ),
              child: _LocalScroll(
                builder: (BuildContext c, ScrollController ctrl) {
                  return Scrollbar(
                    controller: ctrl,
                    child: _SampleContent(itemCount: 30, color: _kViolet, controller: ctrl),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          _CodeBlock(
            'ScrollbarTheme(\n'
            '  data: ScrollbarThemeData(\n'
            '    thumbColor: WidgetStateProperty.all(violet),\n'
            '    trackColor: WidgetStateProperty.all(violetSoft),\n'
            '    thickness: WidgetStateProperty.all(10),\n'
            '    radius: const Radius.circular(5),\n'
            '    thumbVisibility: WidgetStateProperty.all(true),\n'
            '    trackVisibility: WidgetStateProperty.all(true),\n'
            '  ),\n'
            '  child: Scrollbar(...),\n'
            ')',
          ),
        ],
      ),
    );
  }
}

class _RecipeAlwaysShown extends StatelessWidget {
  const _RecipeAlwaysShown();
  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Recipe 4 — Always shown (thumbVisibility=true)',
      subtitle: 'No fade, thumb is persistently visible.',
      accent: _kEmerald,
      tag: 'visible',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeBoxFrame(
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return Scrollbar(
                  controller: ctrl,
                  thumbVisibility: true,
                  trackVisibility: true,
                  thickness: 10,
                  radius: const Radius.circular(4),
                  child: _SampleContent(itemCount: 22, color: _kEmerald, controller: ctrl),
                );
              },
            ),
          ),
          const _Caption(
              'Set thumbVisibility: true at the widget level for one-off '
              'persistent thumbs, or use ThemeData for global behavior.'),
        ],
      ),
    );
  }
}

class _RecipeInteractive extends StatelessWidget {
  const _RecipeInteractive();
  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Recipe 5 — Interactive Scrollbar (interactive=true)',
      subtitle: 'Lets the user drag the thumb to scroll.',
      accent: _kAmber,
      tag: 'interactive',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeBoxFrame(
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return Scrollbar(
                  controller: ctrl,
                  thumbVisibility: true,
                  interactive: true,
                  thickness: 12,
                  radius: const Radius.circular(6),
                  child: _SampleContent(itemCount: 26, color: _kAmber, controller: ctrl),
                );
              },
            ),
          ),
          const _Caption(
              'On desktop and web, interactive=true (the default for '
              'Material Scrollbar) lets the user drag the thumb. On mobile '
              'it is normally false unless explicitly requested.'),
        ],
      ),
    );
  }
}

class _RecipeFatThumb extends StatelessWidget {
  const _RecipeFatThumb();
  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Recipe 6 — Fat thumb (thickness: 18)',
      subtitle: 'Big finger-target style for tablet apps.',
      accent: _kRose,
      tag: 'thick',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeBoxFrame(
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return Scrollbar(
                  controller: ctrl,
                  thumbVisibility: true,
                  trackVisibility: true,
                  thickness: 18,
                  radius: const Radius.circular(9),
                  child: _SampleContent(itemCount: 24, color: _kRose, controller: ctrl),
                );
              },
            ),
          ),
          const _Caption(
              'Useful in dense data viewers where a small thumb would be '
              'hard to grab. Pair with trackVisibility=true so users see '
              'where they can press.'),
        ],
      ),
    );
  }
}

class _RecipeThinThumb extends StatelessWidget {
  const _RecipeThinThumb();
  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Recipe 7 — Thin thumb (thickness: 4)',
      subtitle: 'Minimal indicator for content-first surfaces.',
      accent: _kSlate,
      tag: 'thin',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeBoxFrame(
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return Scrollbar(
                  controller: ctrl,
                  thumbVisibility: true,
                  thickness: 4,
                  radius: const Radius.circular(2),
                  child: _SampleContent(itemCount: 30, color: _kSlate, controller: ctrl),
                );
              },
            ),
          ),
          const _Caption('Great in reader apps where the scrollbar is feedback, not a tool.'),
        ],
      ),
    );
  }
}

class _RecipeDarkMode extends StatelessWidget {
  const _RecipeDarkMode();
  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Recipe 8 — Dark mode',
      subtitle: 'Theme.of(context) returns dark; scrollbar adapts.',
      accent: _kDark,
      tag: 'dark',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeBoxFrame(
            background: _kDark,
            child: Theme(
              data: ThemeData(
                brightness: Brightness.dark,
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(_kDarkInk),
                  trackColor: WidgetStateProperty.all(_kDarkDivider),
                  trackBorderColor: WidgetStateProperty.all(_kDarkDivider),
                  thickness: WidgetStateProperty.all(8),
                  thumbVisibility: WidgetStateProperty.all(true),
                  trackVisibility: WidgetStateProperty.all(true),
                ),
              ),
              child: _LocalScroll(
                builder: (BuildContext c, ScrollController ctrl) {
                  return Scrollbar(
                    controller: ctrl,
                    child: ListView.builder(
                      controller: ctrl,
                      itemCount: 26,
                      itemBuilder: (BuildContext c, int i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: _kDarkCard,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _kDarkDivider),
                          ),
                          child: Text(
                            'dark item $i',
                            style: const TextStyle(
                              color: _kDarkInk,
                              fontFamily: _kMono,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const _Caption('Use ThemeData.scrollbarTheme for app-wide dark adaptation.'),
        ],
      ),
    );
  }
}

class _RecipeOverride extends StatelessWidget {
  const _RecipeOverride();
  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Recipe 9 — Local ScrollbarTheme override',
      subtitle: 'One subtree gets a different style without affecting siblings.',
      accent: _kAccent,
      tag: 'override',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeBoxFrame(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _LocalScroll(
                    builder: (BuildContext c, ScrollController ctrl) {
                      return Scrollbar(
                        controller: ctrl,
                        thumbVisibility: true,
                        child: _SampleContent(itemCount: 22, color: _kAccent, controller: ctrl),
                      );
                    },
                  ),
                ),
                const VerticalDivider(width: 1, color: _kDivider),
                Expanded(
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      thumbColor: WidgetStateProperty.all(_kAmber),
                      trackColor: WidgetStateProperty.all(_kAmberSoft),
                      thumbVisibility: WidgetStateProperty.all(true),
                      trackVisibility: WidgetStateProperty.all(true),
                      thickness: WidgetStateProperty.all(8),
                      radius: const Radius.circular(4),
                    ),
                    child: _LocalScroll(
                      builder: (BuildContext c, ScrollController ctrl) {
                        return Scrollbar(
                          controller: ctrl,
                          child: _SampleContent(itemCount: 22, color: _kAmber, controller: ctrl),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const _Caption('Left list inherits ambient theme; right list overrides locally.'),
        ],
      ),
    );
  }
}

class _RecipesSection extends StatelessWidget {
  const _RecipesSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _SectionHeader(
          index: 'SECTION 03',
          title: 'Recipes — common scrollbar configurations',
          subtitle:
              'Each recipe is a small reusable pattern wrapped in a card '
              'with its source-ish snippet right below.',
          color: _kViolet,
          icon: Icons.menu_book_outlined,
        ),
        _RecipeVerticalScrollbar(),
        _RecipeHorizontalScrollbar(),
        _RecipeThemedScrollbar(),
        _RecipeAlwaysShown(),
        _RecipeInteractive(),
        _RecipeFatThumb(),
        _RecipeThinThumb(),
        _RecipeDarkMode(),
        _RecipeOverride(),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Section 4 — Comparison: Material Scrollbar vs CupertinoScrollbar
// ---------------------------------------------------------------------

class _CupertinoComparisonSection extends StatelessWidget {
  const _CupertinoComparisonSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          index: 'SECTION 04',
          title: 'Material Scrollbar vs CupertinoScrollbar',
          subtitle:
              'Two design languages, two scrollbar personalities. Same '
              'underlying RawScrollbar engine.',
          color: _kEmerald,
          icon: Icons.compare_arrows,
        ),
        _Card(
          title: 'Side-by-side',
          accent: _kEmerald,
          child: Container(
            height: 280,
            decoration: BoxDecoration(
              color: _kCardAlt,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kDivider),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        width: double.infinity,
                        color: _kAccent.withValues(alpha: 0.10),
                        child: const Text(
                          'Material Scrollbar',
                          style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.w700,
                            fontFamily: _kMono,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _LocalScroll(
                          builder: (BuildContext c, ScrollController ctrl) {
                            return Scrollbar(
                              controller: ctrl,
                              thumbVisibility: true,
                              trackVisibility: true,
                              child: _SampleContent(itemCount: 30, color: _kAccent, controller: ctrl),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1, color: _kDivider),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        width: double.infinity,
                        color: _kEmerald.withValues(alpha: 0.10),
                        child: const Text(
                          'CupertinoScrollbar',
                          style: TextStyle(
                            color: _kEmerald,
                            fontWeight: FontWeight.w700,
                            fontFamily: _kMono,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _LocalScroll(
                          builder: (BuildContext c, ScrollController ctrl) {
                            return CupertinoScrollbar(
                              controller: ctrl,
                              thumbVisibility: true,
                              thickness: 4,
                              thicknessWhileDragging: 8,
                              radius: const Radius.circular(2),
                              radiusWhileDragging: const Radius.circular(4),
                              child: _SampleContent(itemCount: 30, color: _kEmerald, controller: ctrl),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _Card(
          title: 'Design differences',
          accent: _kEmerald,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _KeyValueRow('default thickness', 'Material 6 dp · Cupertino 3 dp'),
              _KeyValueRow('drag feedback', 'Material colors shift · Cupertino fattens'),
              _KeyValueRow('default visibility', 'Material follows theme · Cupertino fades on scroll'),
              _KeyValueRow('thumb color', 'Material from theme · Cupertino fixed translucent'),
              _KeyValueRow('orientation', 'Both default right/bottom'),
              _KeyValueRow('engine', 'Both extend RawScrollbar'),
            ],
          ),
        ),
        _Card(
          title: 'Cupertino-only parameters',
          accent: _kEmerald,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _Bullet('thicknessWhileDragging — fatter thumb during drag'),
              _Bullet('radiusWhileDragging — different corner radius during drag'),
              _Bullet('No interactive flag — interaction is implicit per-platform.'),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Section 5 — RawScrollbar variations
// ---------------------------------------------------------------------

class _RawScrollbarSection extends StatelessWidget {
  const _RawScrollbarSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          index: 'SECTION 05',
          title: 'RawScrollbar — building blocks',
          subtitle:
              'Bypass the design-system defaults to dial in every visual.',
          color: _kAmber,
          icon: Icons.tune,
        ),
        _Card(
          title: 'RawScrollbar with custom thumbColor',
          accent: _kAmber,
          child: _RecipeBoxFrame(
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return RawScrollbar(
                  controller: ctrl,
                  thumbColor: _kAmber,
                  thickness: 10,
                  radius: const Radius.circular(5),
                  thumbVisibility: true,
                  trackVisibility: true,
                  trackColor: _kAmberSoft,
                  trackBorderColor: _kAmber.withValues(alpha: 0.5),
                  child: _SampleContent(itemCount: 24, color: _kAmber, controller: ctrl),
                );
              },
            ),
          ),
        ),
        _Card(
          title: 'RawScrollbar — orientation: left',
          accent: _kRose,
          child: _RecipeBoxFrame(
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return RawScrollbar(
                  controller: ctrl,
                  thumbColor: _kRose,
                  thickness: 8,
                  thumbVisibility: true,
                  scrollbarOrientation: ScrollbarOrientation.left,
                  child: _SampleContent(itemCount: 22, color: _kRose, controller: ctrl),
                );
              },
            ),
          ),
        ),
        _Card(
          title: 'RawScrollbar — orientation: top (horizontal)',
          accent: _kViolet,
          child: _RecipeBoxFrame(
            height: 140,
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return RawScrollbar(
                  controller: ctrl,
                  thumbColor: _kViolet,
                  thickness: 8,
                  thumbVisibility: true,
                  scrollbarOrientation: ScrollbarOrientation.top,
                  child: ListView.builder(
                    controller: ctrl,
                    scrollDirection: Axis.horizontal,
                    itemCount: 30,
                    itemBuilder: (BuildContext c, int i) {
                      return Container(
                        width: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 22),
                        decoration: BoxDecoration(
                          color: _kViolet.withValues(alpha: 0.10 + (i % 5) * 0.04),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _kViolet.withValues(alpha: 0.45)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$i',
                          style: const TextStyle(
                            color: _kViolet,
                            fontFamily: _kMono,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        _Card(
          title: 'RawScrollbar — minThumbLength enforced',
          accent: _kTeal,
          child: _RecipeBoxFrame(
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return RawScrollbar(
                  controller: ctrl,
                  thumbColor: _kTeal,
                  thickness: 8,
                  thumbVisibility: true,
                  minThumbLength: 80,
                  child: _SampleContent(itemCount: 200, color: _kTeal, controller: ctrl),
                );
              },
            ),
          ),
        ),
        _Card(
          title: 'RawScrollbar — long fade duration',
          accent: _kEmerald,
          child: _RecipeBoxFrame(
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return RawScrollbar(
                  controller: ctrl,
                  thumbColor: _kEmerald,
                  thickness: 6,
                  fadeDuration: const Duration(milliseconds: 1200),
                  timeToFade: const Duration(milliseconds: 1500),
                  child: _SampleContent(itemCount: 26, color: _kEmerald, controller: ctrl),
                );
              },
            ),
          ),
        ),
        _Card(
          title: 'RawScrollbar — main/cross axis margin',
          accent: _kSlate,
          child: _RecipeBoxFrame(
            child: _LocalScroll(
              builder: (BuildContext c, ScrollController ctrl) {
                return RawScrollbar(
                  controller: ctrl,
                  thumbColor: _kSlate,
                  thickness: 8,
                  thumbVisibility: true,
                  trackVisibility: true,
                  trackColor: _kSlateSoft,
                  mainAxisMargin: 16,
                  crossAxisMargin: 6,
                  radius: const Radius.circular(4),
                  child: _SampleContent(itemCount: 22, color: _kSlate, controller: ctrl),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Section 6 — Common pitfalls
// ---------------------------------------------------------------------

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          index: 'SECTION 06',
          title: 'Common pitfalls and how to avoid them',
          subtitle:
              'Most scrollbar bugs come from controller wiring or '
              'multiple scrollables sharing the same PrimaryScrollController.',
          color: _kRose,
          icon: Icons.warning_amber_rounded,
        ),
        _Card(
          title: 'Pitfall 1 — Missing controller with thumbVisibility',
          accent: _kRose,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _Banner(
                icon: Icons.error_outline,
                title: 'Assertion error',
                body:
                    'When thumbVisibility is true, both the Scrollbar and '
                    'the inner Scrollable must share an explicit '
                    'ScrollController, otherwise Flutter throws.',
                color: _kRose,
              ),
              _CodeBlock(
                '// BAD\n'
                'Scrollbar(\n'
                '  thumbVisibility: true,\n'
                '  child: ListView(/* no controller */),\n'
                ')\n\n'
                '// GOOD\n'
                'final ctrl = ScrollController();\n'
                'Scrollbar(\n'
                '  controller: ctrl,\n'
                '  thumbVisibility: true,\n'
                '  child: ListView(controller: ctrl, ...),\n'
                ')',
              ),
            ],
          ),
        ),
        _Card(
          title: 'Pitfall 2 — Multiple scrollables sharing PrimaryScrollController',
          accent: _kRose,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _Banner(
                icon: Icons.warning_amber_rounded,
                title: 'Ambiguous attach',
                body:
                    'A Scrollbar that tries to attach to PrimaryScrollController '
                    'will throw if multiple scrollables in the subtree opt into it.',
                color: _kRose,
              ),
              _CodeBlock(
                'PrimaryScrollController(\n'
                '  controller: shared,\n'
                '  child: Column(\n'
                '    children: <Widget>[\n'
                '      Expanded(child: ListView(primary: true, ...)),\n'
                '      Expanded(child: ListView(primary: true, ...)),\n'
                '    ],\n'
                '  ),\n'
                ')\n'
                '// → Scrollbar above this column cannot pick one.',
              ),
              const _Bullet('Give each ListView its own local ScrollController.'),
              const _Bullet('Or set primary: false on all but one ListView.'),
            ],
          ),
        ),
        _Card(
          title: 'Pitfall 3 — Wrapping a NestedScrollView naively',
          accent: _kRose,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _Bullet('NestedScrollView has its own coordination logic.'),
              const _Bullet('Wrapping the outermost widget in Scrollbar may produce two thumbs.'),
              const _Bullet('Prefer to wrap the inner body Scrollable instead.'),
            ],
          ),
        ),
        _Card(
          title: 'Pitfall 4 — CustomScrollView with multiple slivers',
          accent: _kRose,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _Bullet('A single Scrollbar can wrap an entire CustomScrollView.'),
              _Bullet('It tracks the unified scroll extent across slivers.'),
              _Bullet('Make sure controller is passed to the CustomScrollView, not individual slivers.'),
            ],
          ),
        ),
        _Card(
          title: 'Pitfall 5 — Reusing one ScrollController across two scrollables',
          accent: _kRose,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _Bullet('ScrollController.position requires exactly one client at a time.'),
              _Bullet('If you must mirror scroll between two lists, use a CoupledScrollController pattern.'),
              _Bullet('Otherwise the Scrollbar will attach to the wrong client and look frozen.'),
            ],
          ),
        ),
        _Card(
          title: 'Pitfall 6 — Wrong axis vs orientation',
          accent: _kRose,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _Bullet('ScrollbarOrientation.top with Axis.vertical content asserts.'),
              _Bullet('ScrollbarOrientation.left with Axis.horizontal content asserts.'),
              _Bullet('Default behavior is usually what you want — only override for RTL or design needs.'),
            ],
          ),
        ),
        _Card(
          title: 'Pitfall 7 — Theme misalignment between thumb and track',
          accent: _kRose,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _Bullet('Set trackBorderColor when trackVisibility is true; otherwise it may look like a stray line.'),
              _Bullet('Match thumb radius to track radius (or set track radius explicitly) to avoid visual jitter.'),
              _Bullet('Use WidgetStateProperty.resolveWith for hover/drag transitions.'),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Section 7 — Glossary
// ---------------------------------------------------------------------

class _GlossarySection extends StatelessWidget {
  const _GlossarySection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          index: 'SECTION 07',
          title: 'Glossary',
          subtitle: 'Terms used in the scrollbar API and their plain meanings.',
          color: _kSlate,
          icon: Icons.book_outlined,
        ),
        _Card(
          title: 'A–Z',
          accent: _kSlate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _KeyValueRow('attach', 'Process of binding a Scrollbar to a ScrollPosition.'),
              _KeyValueRow('axis', 'The direction the scrollable scrolls in (vertical/horizontal).'),
              _KeyValueRow('client', 'A ScrollPosition currently registered with a ScrollController.'),
              _KeyValueRow('content size', 'Total scrollable extent — usually bigger than viewport.'),
              _KeyValueRow('crossAxisMargin', 'Distance from the viewport edge to the track.'),
              _KeyValueRow('drag start', 'Pointer down on the thumb begins a drag gesture.'),
              _KeyValueRow('fade', 'Process of fading the thumb out after inactivity.'),
              _KeyValueRow('hover', 'Pointer over the thumb without pressing (desktop/web).'),
              _KeyValueRow('interactive', 'Whether the thumb can be dragged to scroll.'),
              _KeyValueRow('main axis', 'Same direction as the scroll axis.'),
              _KeyValueRow('mainAxisMargin', 'Distance from viewport ends to the track ends.'),
              _KeyValueRow('minThumbLength', 'Hard floor on thumb size when content is huge.'),
              _KeyValueRow('orientation', 'Which edge the scrollbar appears on.'),
              _KeyValueRow('PrimaryScrollController', 'Ambient controller shared by widgets that opt-in.'),
              _KeyValueRow('radius', 'Corner rounding for thumb (and track).'),
              _KeyValueRow('RawScrollbar', 'Design-system-neutral scrollbar primitive.'),
              _KeyValueRow('Scrollbar', 'Material wrapper around RawScrollbar.'),
              _KeyValueRow('ScrollbarTheme', 'InheritedTheme injecting ScrollbarThemeData.'),
              _KeyValueRow('ScrollbarThemeData', 'Bag of style tokens, mostly WidgetStateProperty.'),
              _KeyValueRow('ScrollController', 'Listenable handle to a ScrollPosition.'),
              _KeyValueRow('thickness', 'Cross-axis width of the scrollbar.'),
              _KeyValueRow('thumb', 'The visible draggable indicator.'),
              _KeyValueRow('thumbVisibility', 'Whether the thumb is always shown vs faded.'),
              _KeyValueRow('track', 'Background area the thumb slides over.'),
              _KeyValueRow('trackVisibility', 'Whether the track is rendered.'),
              _KeyValueRow('viewport', 'The visible window of scrollable content.'),
              _KeyValueRow('WidgetState', 'Pseudo-states: hovered, dragged, focused, etc.'),
              _KeyValueRow('WidgetStateProperty', 'Function from WidgetState set to value.'),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Section 8 — Recap
// ---------------------------------------------------------------------

class _RecapSection extends StatelessWidget {
  const _RecapSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          index: 'SECTION 08',
          title: 'Recap',
          subtitle: 'Cheat sheet for scrollbar decisions at a glance.',
          color: _kAccentDark,
          icon: Icons.checklist,
        ),
        _Card(
          title: 'Decision tree',
          accent: _kAccentDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _Bullet('Single scrollable, Material app → Scrollbar(controller: ctrl, child: ...)'),
              _Bullet('iOS look → CupertinoScrollbar(controller: ctrl, child: ...)'),
              _Bullet('Need bespoke colors/sizing not in a design system → RawScrollbar'),
              _Bullet('Global style → ThemeData(scrollbarTheme: ScrollbarThemeData(...))'),
              _Bullet('Local override → ScrollbarTheme(data: ..., child: Scrollbar(...))'),
              _Bullet('Left-side or top-edge thumb → RawScrollbar with scrollbarOrientation'),
              _Bullet('Always show → thumbVisibility: true (+ explicit controller)'),
              _Bullet('Drag to scroll → interactive: true (Scrollbar) or default Cupertino'),
            ],
          ),
        ),
        _Card(
          title: 'Foundation knobs',
          accent: _kAccentDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _KeyValueRow('controller', 'Bind explicitly for thumbVisibility:true.'),
              _KeyValueRow('thumbVisibility', 'Always-on thumb when content scrolls.'),
              _KeyValueRow('trackVisibility', 'Show the track background.'),
              _KeyValueRow('thickness', 'Across-axis width.'),
              _KeyValueRow('radius', 'Corner rounding.'),
              _KeyValueRow('interactive', 'Allow drag-the-thumb-to-scroll.'),
              _KeyValueRow('scrollbarOrientation', 'Edge placement; defaults are usually best.'),
            ],
          ),
        ),
        _Card(
          title: 'When to reach for a different widget',
          accent: _kAccentDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _Bullet('Custom painted indicator → write a custom Scrollable + Listener.'),
              _Bullet('Pull-to-refresh on top → RefreshIndicator + Scrollbar combo.'),
              _Bullet('Overscroll glow → leave default; do not nest Scrollbar inside.'),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Root scaffold (stateless) and entry point
// ---------------------------------------------------------------------

class _AppShell extends StatelessWidget {
  const _AppShell();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        backgroundColor: _kCard,
        foregroundColor: _kInk,
        elevation: 0,
        titleSpacing: 20,
        title: Row(
          children: <Widget>[
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _kAccent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kAccent.withValues(alpha: 0.4)),
              ),
              child: const Icon(Icons.linear_scale, color: _kAccent, size: 22),
            ),
            const SizedBox(width: 12),
            const Text(
              'Scrollbar Layout & Misc — Deep Visual Demo',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kTeal.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'd4rt-ast',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: _kMono,
                  color: _kTeal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: _kDivider),
        ),
      ),
      body: _LocalScroll(
        builder: (BuildContext c, ScrollController pageCtrl) {
          return Scrollbar(
            controller: pageCtrl,
            thumbVisibility: true,
            thickness: 8,
            radius: const Radius.circular(4),
            child: SingleChildScrollView(
              controller: pageCtrl,
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _DossierSection(),
                  SizedBox(height: 16),
                  _AnatomySection(),
                  SizedBox(height: 16),
                  _RecipesSection(),
                  SizedBox(height: 16),
                  _CupertinoComparisonSection(),
                  SizedBox(height: 16),
                  _RawScrollbarSection(),
                  SizedBox(height: 16),
                  _PitfallsSection(),
                  SizedBox(height: 16),
                  _GlossarySection(),
                  SizedBox(height: 16),
                  _RecapSection(),
                  SizedBox(height: 48),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

dynamic build(BuildContext context) {
  if (kDebugMode) {
    debugPrint('[scrollbar_layout_misc_test] Scrollbar deep visual demo loaded.');
  }
  print('Scrollbar / RawScrollbar / ScrollbarTheme / ScrollbarThemeData / '
      'ScrollbarOrientation / CupertinoScrollbar — visual demo.');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Scrollbar Deep Visual Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccent, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> s) {
          if (s.contains(WidgetState.dragged)) return _kAccentDark;
          if (s.contains(WidgetState.hovered)) return _kAccent;
          return _kAccent.withValues(alpha: 0.65);
        }),
        trackColor: WidgetStateProperty.all(_kAccentSoft),
        trackBorderColor: WidgetStateProperty.all(_kAccent.withValues(alpha: 0.30)),
        thickness: WidgetStateProperty.all(8),
        radius: const Radius.circular(4),
      ),
    ),
    home: const _AppShell(),
  );
}
