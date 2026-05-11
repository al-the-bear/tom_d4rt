// Deep visual demo for Flutter SingleChildScrollView — parameter encyclopedia,
// configuration gallery, anatomy diagrams, physics comparison, idioms, pitfalls,
// and decision matrix versus ListView / CustomScrollView / NestedScrollView.
// ignore_for_file: unused_field, unused_local_variable, unused_element, unused_element_parameter, unused_import, unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter/painting.dart";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:flutter/rendering.dart";
import "package:flutter/gestures.dart";
import "dart:math" as math;
import "dart:ui" as ui;

// ---------------------------------------------------------------------------
// Palette — calm paper background with a structured ink + accent system so the
// many gallery cards read as a coherent reference sheet rather than a circus.
// ---------------------------------------------------------------------------
const Color _kInk = Color(0xFF0E1430);
const Color _kInkSoft = Color(0xFF2A3358);
const Color _kInkMuted = Color(0xFF5F6A95);
const Color _kInkFaint = Color(0xFF9AA3C4);
const Color _kPaper = Color(0xFFF5F6FB);
const Color _kPaperWarm = Color(0xFFFDF8F1);
const Color _kPaperCool = Color(0xFFEEF2FB);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kAccent = Color(0xFF5B4BD6);
const Color _kAccent2 = Color(0xFF00897B);
const Color _kAccent3 = Color(0xFFE91E63);
const Color _kAccent4 = Color(0xFFFB8C00);
const Color _kAccent5 = Color(0xFF1E88E5);
const Color _kAccent6 = Color(0xFF8E24AA);
const Color _kSuccess = Color(0xFF2E7D32);
const Color _kDanger = Color(0xFFC62828);
const Color _kInfo = Color(0xFF1565C0);
const Color _kWarn = Color(0xFFEF6C00);
const Color _kGrid = Color(0xFFE3E7F3);
const Color _kStripeA = Color(0xFFEDF1FA);
const Color _kStripeB = Color(0xFFE3E9F6);

// =====================================================================
// ROOT
// =====================================================================
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "SingleChildScrollView Encyclopedia",
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _kAccent,
      scaffoldBackgroundColor: _kPaper,
      fontFamily: "Roboto",
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroSection(),
              _WhenToUseSection(),
              _ParameterTableSection(),
              _ConfigGallerySection(),
              _AnatomySection(),
              _PhysicsComparisonSection(),
              _IdiomSamplesSection(),
              _PitfallsSection(),
              _DecisionMatrixSection(),
              _FooterCheatsheetSection(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// HERO SECTION
// =====================================================================
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 40, 32, 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0E1430),
            Color(0xFF26276A),
            Color(0xFF5B4BD6),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _HeroBadge(label: "widgets"),
              SizedBox(width: 8),
              _HeroBadge(label: "scrolling"),
              SizedBox(width: 8),
              _HeroBadge(label: "eager-layout"),
              SizedBox(width: 8),
              _HeroBadge(label: "viewport"),
            ],
          ),
          SizedBox(height: 18),
          Text(
            "SingleChildScrollView",
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              height: 1.05,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "One viewport, one child, fully measured up-front",
            style: TextStyle(
              color: Color(0xFFCDD3F0),
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 22),
          Container(
            constraints: BoxConstraints(maxWidth: 920),
            child: Text(
              "SingleChildScrollView wraps a single child in a scrollable viewport. "
              "Unlike ListView or CustomScrollView, it lays out the whole child "
              "eagerly: every byte of the subtree is measured and painted, then "
              "translated by the current scroll offset. That makes it ideal for "
              "forms, settings pages, dialog bodies and other known-bounded "
              "content — and a performance trap for very long lists.",
              style: TextStyle(
                color: Color(0xFFE6E9FA),
                fontSize: 14.5,
                height: 1.55,
              ),
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              _HeroStat(label: "Parameters", value: "11"),
              SizedBox(width: 28),
              _HeroStat(label: "Axes", value: "2"),
              SizedBox(width: 28),
              _HeroStat(label: "Physics", value: "4+"),
              SizedBox(width: 28),
              _HeroStat(label: "Children", value: "1"),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  final String label;
  const _HeroBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFB9BFE0),
            fontSize: 11,
            letterSpacing: 0.8,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// WHEN-TO-USE SECTION
// =====================================================================
class _WhenToUseSection extends StatelessWidget {
  const _WhenToUseSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaper,
      padding: EdgeInsets.fromLTRB(32, 36, 32, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: "WHEN TO REACH FOR IT"),
          SizedBox(height: 14),
          _SectionTitle(text: "Eager layout, bounded content"),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _UseCaseCard(
                  color: _kSuccess,
                  title: "Use SingleChildScrollView",
                  bullets: [
                    "A settings page with ~30 rows",
                    "A long form (Material text fields, switches)",
                    "Dialog or BottomSheet body content",
                    "Onboarding pages that overflow on small screens",
                    "Static documentation / about pages",
                    "Horizontal chip rows with known width",
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _UseCaseCard(
                  color: _kDanger,
                  title: "Avoid in favour of ListView",
                  bullets: [
                    "Hundreds or thousands of homogeneous rows",
                    "Lazy-loaded paginated streams",
                    "Reorderable / dismissible lists",
                    "Lists with separator builders",
                    "Anywhere itemBuilder is the natural shape",
                    "Anywhere render-recycling matters",
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _UseCaseCard(
                  color: _kInfo,
                  title: "Step up to slivers when",
                  bullets: [
                    "Mixing fixed + scrolling regions in one viewport",
                    "Collapsing app bars / flexible space",
                    "Sticky headers above grouped lists",
                    "Pinned floating action regions",
                    "Multiple grids/lists sharing one scroll",
                    "Custom paging snap behaviours",
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

class _UseCaseCard extends StatelessWidget {
  final Color color;
  final String title;
  final List<String> bullets;
  const _UseCaseCard({
    required this.color,
    required this.title,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kGrid, width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: _kInk,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 12),
          for (final b in bullets)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b,
                      style: TextStyle(
                        color: _kInkSoft,
                        fontSize: 12.5,
                        height: 1.45,
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

// =====================================================================
// PARAMETER TABLE SECTION
// =====================================================================
class _ParameterTableSection extends StatelessWidget {
  const _ParameterTableSection();

  @override
  Widget build(BuildContext context) {
    final rows = const <_ParamRow>[
      _ParamRow(
        name: "scrollDirection",
        type: "Axis",
        defaultValue: "Axis.vertical",
        description:
            "The axis along which the viewport scrolls. Switch to Axis.horizontal "
            "for chip strips, carousel-like layouts, or fixed-height ribbons.",
      ),
      _ParamRow(
        name: "reverse",
        type: "bool",
        defaultValue: "false",
        description:
            "Reverses the scroll origin. With reverse:true, scrollOffset 0 places "
            "the child against the trailing edge. Useful for chat-style logs.",
      ),
      _ParamRow(
        name: "padding",
        type: "EdgeInsetsGeometry?",
        defaultValue: "null",
        description:
            "Outer padding INSIDE the viewport. Applied before the child is laid "
            "out, so it scrolls with the content rather than acting as a frame.",
      ),
      _ParamRow(
        name: "primary",
        type: "bool?",
        defaultValue: "null (true if vertical, no controller)",
        description:
            "When true, attaches to PrimaryScrollController.of(context). Setting "
            "false detaches and lets you nest scrollables without conflicts.",
      ),
      _ParamRow(
        name: "physics",
        type: "ScrollPhysics?",
        defaultValue: "null (platform default)",
        description:
            "Drives drag/release behaviour: Bouncing (iOS), Clamping (Android), "
            "AlwaysScrollable, NeverScrollable, or a custom subclass.",
      ),
      _ParamRow(
        name: "controller",
        type: "ScrollController?",
        defaultValue: "null",
        description:
            "Owns the scroll position, allows programmatic animateTo/jumpTo, and "
            "powers Scrollbar attachment. Must not coexist with primary:true.",
      ),
      _ParamRow(
        name: "dragStartBehavior",
        type: "DragStartBehavior",
        defaultValue: "DragStartBehavior.start",
        description:
            "When drag motion is recognised: at the first touch-down (start) or "
            "after movement exceeds slop (down). Affects perceived responsiveness.",
      ),
      _ParamRow(
        name: "clipBehavior",
        type: "Clip",
        defaultValue: "Clip.hardEdge",
        description:
            "How the viewport clips the painted child. hardEdge is fastest; "
            "antiAlias smooths rotated children; none disables clipping (risky).",
      ),
      _ParamRow(
        name: "restorationId",
        type: "String?",
        defaultValue: "null",
        description:
            "Identifier used by RestorationManager to save/restore scroll offset "
            "across process restarts. Pair with restoration scopes upstream.",
      ),
      _ParamRow(
        name: "keyboardDismissBehavior",
        type: "ScrollViewKeyboardDismissBehavior",
        defaultValue: "manual",
        description:
            "manual leaves the keyboard alone; onDrag dismisses it as soon as the "
            "user begins scrolling — almost always what forms want on mobile.",
      ),
      _ParamRow(
        name: "hitTestBehavior",
        type: "HitTestBehavior",
        defaultValue: "HitTestBehavior.opaque",
        description:
            "How the viewport responds to hit testing on its background. opaque "
            "absorbs taps, translucent lets them pass through transparent regions.",
      ),
      _ParamRow(
        name: "child",
        type: "Widget?",
        defaultValue: "null",
        description:
            "The single subtree painted inside the viewport. Typically a Column, "
            "Row, Wrap, or a custom widget — but it is laid out fully, not lazily.",
      ),
    ];

    return Container(
      color: _kPaperCool,
      padding: EdgeInsets.fromLTRB(32, 36, 32, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: "API SURFACE"),
          SizedBox(height: 14),
          _SectionTitle(text: "Every constructor parameter"),
          SizedBox(height: 6),
          Text(
            "Each row links the parameter name, its Dart type, its default value, "
            "and the semantic effect on the viewport.",
            style: TextStyle(
              color: _kInkMuted,
              fontSize: 13,
              height: 1.45,
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kGrid, width: 1),
            ),
            child: Column(
              children: [
                _ParamHeader(),
                for (int i = 0; i < rows.length; i++)
                  _ParamRowView(row: rows[i], even: i.isEven),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ParamRow {
  final String name;
  final String type;
  final String defaultValue;
  final String description;
  const _ParamRow({
    required this.name,
    required this.type,
    required this.defaultValue,
    required this.description,
  });
}

class _ParamHeader extends StatelessWidget {
  const _ParamHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: _ParamHeadText(text: "PARAMETER")),
          Expanded(flex: 3, child: _ParamHeadText(text: "TYPE")),
          Expanded(flex: 3, child: _ParamHeadText(text: "DEFAULT")),
          Expanded(flex: 7, child: _ParamHeadText(text: "DESCRIPTION")),
        ],
      ),
    );
  }
}

class _ParamHeadText extends StatelessWidget {
  final String text;
  const _ParamHeadText({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.9,
      ),
    );
  }
}

class _ParamRowView extends StatelessWidget {
  final _ParamRow row;
  final bool even;
  const _ParamRowView({required this.row, required this.even});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: even ? _kCard : _kStripeA,
        border: Border(
          top: BorderSide(color: _kGrid, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              row.name,
              style: TextStyle(
                color: _kAccent,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: "monospace",
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.type,
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                fontFamily: "monospace",
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.defaultValue,
              style: TextStyle(
                color: _kInkMuted,
                fontSize: 12,
                fontFamily: "monospace",
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              row.description,
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// CONFIGURATION GALLERY
// =====================================================================
class _ConfigGallerySection extends StatelessWidget {
  const _ConfigGallerySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaper,
      padding: EdgeInsets.fromLTRB(32, 40, 32, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: "GALLERY"),
          SizedBox(height: 14),
          _SectionTitle(text: "Twelve concrete configurations"),
          SizedBox(height: 6),
          Text(
            "Each card pairs a real SingleChildScrollView (sized down so layout is "
            "stable in a static render) with a label strip diagram of the child "
            "and an arrow indicating the scroll direction.",
            style: TextStyle(color: _kInkMuted, fontSize: 13, height: 1.45),
          ),
          SizedBox(height: 22),
          _GalleryGrid(),
        ],
      ),
    );
  }
}

class _GalleryGrid extends StatelessWidget {
  const _GalleryGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _GalleryCardVertical()),
            SizedBox(width: 16),
            Expanded(child: _GalleryCardHorizontal()),
            SizedBox(width: 16),
            Expanded(child: _GalleryCardReverse()),
          ],
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _GalleryCardPadded()),
            SizedBox(width: 16),
            Expanded(child: _GalleryCardBouncing()),
            SizedBox(width: 16),
            Expanded(child: _GalleryCardClamping()),
          ],
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _GalleryCardNever()),
            SizedBox(width: 16),
            Expanded(child: _GalleryCardAlways()),
            SizedBox(width: 16),
            Expanded(child: _GalleryCardPrimaryFalse()),
          ],
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _GalleryCardClipHardEdge()),
            SizedBox(width: 16),
            Expanded(child: _GalleryCardRestoration()),
            SizedBox(width: 16),
            Expanded(child: _GalleryCardKeyboardOnDrag()),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared gallery building blocks.
// ---------------------------------------------------------------------------
class _GalleryCardShell extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> tags;
  final Widget body;
  final String? footnote;
  final Color accent;
  const _GalleryCardShell({
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.body,
    required this.accent,
    this.footnote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kGrid, width: 1),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.05),
            blurRadius: 14,
            offset: Offset(0, 3),
          ),
        ],
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
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(color: _kInkMuted, fontSize: 11.5, height: 1.4),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tags,
          ),
          SizedBox(height: 12),
          body,
          if (footnote != null) ...[
            SizedBox(height: 10),
            Text(
              footnote!,
              style: TextStyle(
                color: _kInkFaint,
                fontSize: 11,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MiniTag extends StatelessWidget {
  final String label;
  final Color color;
  const _MiniTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// Tall child used in vertical gallery cards.
class _TallStrips extends StatelessWidget {
  final int count;
  final Color base;
  const _TallStrips({this.count = 12, this.base = _kAccent});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final t = i / (count - 1);
        return Container(
          height: 28,
          margin: EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: Color.lerp(base, _kAccent3, t)!.withOpacity(0.85),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "row #" + (i + 1).toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }),
    );
  }
}

// Wide child used in horizontal gallery cards.
class _WideStrips extends StatelessWidget {
  final int count;
  final Color base;
  const _WideStrips({this.count = 10, this.base = _kAccent2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final t = i / (count - 1);
        return Container(
          width: 88,
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: Color.lerp(base, _kAccent4, t)!.withOpacity(0.85),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            "col " + (i + 1).toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }),
    );
  }
}

class _ScrollArrow extends StatelessWidget {
  final Axis axis;
  final bool reverse;
  const _ScrollArrow({required this.axis, this.reverse = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: SizedBox(
        width: 200,
        height: 18,
        child: CustomPaint(
          painter: _ArrowPainter(axis: axis, reverse: reverse),
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final Axis axis;
  final bool reverse;
  _ArrowPainter({required this.axis, required this.reverse});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = _kInkMuted
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    if (axis == Axis.vertical) {
      final cx = size.width / 2;
      canvas.drawLine(Offset(cx, 2), Offset(cx, size.height - 2), p);
      final tip = reverse ? Offset(cx, 2) : Offset(cx, size.height - 2);
      final back = reverse ? 6.0 : -6.0;
      canvas.drawLine(tip, Offset(cx - 5, tip.dy + back), p);
      canvas.drawLine(tip, Offset(cx + 5, tip.dy + back), p);
    } else {
      final cy = size.height / 2;
      canvas.drawLine(Offset(2, cy), Offset(size.width - 2, cy), p);
      final tip = reverse ? Offset(2, cy) : Offset(size.width - 2, cy);
      final back = reverse ? 6.0 : -6.0;
      canvas.drawLine(tip, Offset(tip.dx + back, cy - 5), p);
      canvas.drawLine(tip, Offset(tip.dx + back, cy + 5), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Twelve gallery cards, one per important configuration.
// ---------------------------------------------------------------------------
class _GalleryCardVertical extends StatelessWidget {
  const _GalleryCardVertical();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kAccent,
      title: "1 · Vertical default",
      subtitle: "scrollDirection: Axis.vertical (the implicit default).",
      tags: const [
        _MiniTag(label: "Axis.vertical", color: _kAccent),
        _MiniTag(label: "physics: platform", color: _kInkSoft),
      ],
      body: SizedBox(
        height: 140,
        child: SingleChildScrollView(
          child: _TallStrips(),
        ),
      ),
      footnote:
          "The whole column is measured. Scroll offset translates the painting "
          "of the child upward; the viewport itself never changes size.",
    );
  }
}

class _GalleryCardHorizontal extends StatelessWidget {
  const _GalleryCardHorizontal();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kAccent2,
      title: "2 · Horizontal axis",
      subtitle: "scrollDirection: Axis.horizontal — for chip / card strips.",
      tags: const [
        _MiniTag(label: "Axis.horizontal", color: _kAccent2),
        _MiniTag(label: "primary: false (implicit)", color: _kInkSoft),
      ],
      body: SizedBox(
        height: 70,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _WideStrips(),
        ),
      ),
      footnote:
          "Horizontal SingleChildScrollViews do NOT use PrimaryScrollController "
          "by default — primary is implicitly false. No conflict to worry about.",
    );
  }
}

class _GalleryCardReverse extends StatelessWidget {
  const _GalleryCardReverse();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kAccent3,
      title: "3 · reverse: true",
      subtitle: "Scroll origin flips. Useful for chat bubbles / logs.",
      tags: const [
        _MiniTag(label: "reverse", color: _kAccent3),
        _MiniTag(label: "Axis.vertical", color: _kAccent),
      ],
      body: SizedBox(
        height: 140,
        child: SingleChildScrollView(
          reverse: true,
          child: _TallStrips(base: _kAccent3),
        ),
      ),
      footnote:
          "offset 0 sits against the trailing edge. Children appear bottom-up; "
          "physics curves are mirrored across the axis.",
    );
  }
}

class _GalleryCardPadded extends StatelessWidget {
  const _GalleryCardPadded();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kAccent4,
      title: "4 · padding: EdgeInsets",
      subtitle: "Padding is INSIDE the viewport and scrolls with the content.",
      tags: const [
        _MiniTag(label: "padding: 16", color: _kAccent4),
        _MiniTag(label: "Axis.vertical", color: _kAccent),
      ],
      body: SizedBox(
        height: 140,
        child: Container(
          color: _kPaperWarm,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: _TallStrips(base: _kAccent4),
          ),
        ),
      ),
      footnote:
          "Compare with wrapping in Padding outside the scroll view: that would "
          "shrink the viewport, this preserves it and pads inside.",
    );
  }
}

class _GalleryCardBouncing extends StatelessWidget {
  const _GalleryCardBouncing();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kAccent5,
      title: "5 · BouncingScrollPhysics",
      subtitle: "iOS-style overscroll: drags past the edge then snaps back.",
      tags: const [
        _MiniTag(label: "physics", color: _kAccent5),
        _MiniTag(label: "iOS feel", color: _kInkSoft),
      ],
      body: SizedBox(
        height: 140,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: _TallStrips(base: _kAccent5),
        ),
      ),
      footnote:
          "Bouncing returns a non-zero offset BEYOND the edge with a damping "
          "curve; great on touch, surprising on a mouse wheel.",
    );
  }
}

class _GalleryCardClamping extends StatelessWidget {
  const _GalleryCardClamping();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kAccent6,
      title: "6 · ClampingScrollPhysics",
      subtitle: "Material/Android: edge is a wall, glow indicator instead.",
      tags: const [
        _MiniTag(label: "physics", color: _kAccent6),
        _MiniTag(label: "Material feel", color: _kInkSoft),
      ],
      body: SizedBox(
        height: 140,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: _TallStrips(base: _kAccent6),
        ),
      ),
      footnote:
          "Scroll offset is clamped to [0, maxScrollExtent]. Overscroll is "
          "rendered by an ancestor GlowingOverscrollIndicator, not by motion.",
    );
  }
}

class _GalleryCardNever extends StatelessWidget {
  const _GalleryCardNever();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kDanger,
      title: "7 · NeverScrollableScrollPhysics",
      subtitle: "Disables user-driven scrolling entirely — still programmable.",
      tags: const [
        _MiniTag(label: "physics", color: _kDanger),
        _MiniTag(label: "locked", color: _kInkSoft),
      ],
      body: SizedBox(
        height: 140,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: _TallStrips(base: _kDanger),
        ),
      ),
      footnote:
          "Used here as the root viewport: layout still happens, but no drag "
          "events accumulate. controller.jumpTo still works programmatically.",
    );
  }
}

class _GalleryCardAlways extends StatelessWidget {
  const _GalleryCardAlways();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kSuccess,
      title: "8 · AlwaysScrollableScrollPhysics",
      subtitle: "Allow drag even when child fits — required for RefreshIndicator.",
      tags: const [
        _MiniTag(label: "physics", color: _kSuccess),
        _MiniTag(label: "pull-to-refresh", color: _kInkSoft),
      ],
      body: SizedBox(
        height: 140,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: _TallStrips(base: _kSuccess, count: 6),
        ),
      ),
      footnote:
          "Without this, a short child silently disables RefreshIndicator pulls. "
          "Compose with parent: physics: AlwaysScrollable + BouncingScrollPhysics().",
    );
  }
}

class _GalleryCardPrimaryFalse extends StatelessWidget {
  const _GalleryCardPrimaryFalse();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kInfo,
      title: "9 · primary: false",
      subtitle: "Detach from PrimaryScrollController for safe nesting.",
      tags: const [
        _MiniTag(label: "primary: false", color: _kInfo),
        _MiniTag(label: "nesting-safe", color: _kInkSoft),
      ],
      body: SizedBox(
        height: 140,
        child: SingleChildScrollView(
          primary: false,
          child: _TallStrips(base: _kInfo),
        ),
      ),
      footnote:
          "Required when this viewport is itself inside another vertical "
          "scrollable (e.g. NestedScrollView body) — otherwise both fight.",
    );
  }
}

class _GalleryCardClipHardEdge extends StatelessWidget {
  const _GalleryCardClipHardEdge();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kWarn,
      title: "10 · clipBehavior",
      subtitle: "Clip.hardEdge (default), Clip.antiAlias, or Clip.none.",
      tags: const [
        _MiniTag(label: "Clip.hardEdge", color: _kWarn),
        _MiniTag(label: "Clip.antiAlias", color: _kInkSoft),
      ],
      body: SizedBox(
        height: 140,
        child: SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          child: _TallStrips(base: _kWarn),
        ),
      ),
      footnote:
          "antiAlias rounds the clip rectangle's edges if the parent has a "
          "BorderRadius — slightly more expensive than hardEdge.",
    );
  }
}

class _GalleryCardRestoration extends StatelessWidget {
  const _GalleryCardRestoration();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kAccent6,
      title: "11 · restorationId",
      subtitle: "Persist scroll offset across kills/restores.",
      tags: const [
        _MiniTag(label: "restorationId", color: _kAccent6),
        _MiniTag(label: "state-restoration", color: _kInkSoft),
      ],
      body: SizedBox(
        height: 140,
        child: SingleChildScrollView(
          restorationId: "demo_settings_scroll",
          child: _TallStrips(base: _kAccent6, count: 14),
        ),
      ),
      footnote:
          "Pair with a RestorationScope upstream; the framework writes the "
          "current offset into the restoration bucket on lifecycle events.",
    );
  }
}

class _GalleryCardKeyboardOnDrag extends StatelessWidget {
  const _GalleryCardKeyboardOnDrag();
  @override
  Widget build(BuildContext context) {
    return _GalleryCardShell(
      accent: _kAccent3,
      title: "12 · keyboardDismissBehavior.onDrag",
      subtitle: "Dismisses the IME the moment the user starts scrolling.",
      tags: const [
        _MiniTag(label: "onDrag", color: _kAccent3),
        _MiniTag(label: "mobile-forms", color: _kInkSoft),
      ],
      body: SizedBox(
        height: 140,
        child: SingleChildScrollView(
          keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
          child: _TallStrips(base: _kAccent3, count: 16),
        ),
      ),
      footnote:
          "Default is manual: the keyboard remains visible while scrolling. "
          "onDrag is almost always the right choice for forms on mobile.",
    );
  }
}

// =====================================================================
// CUSTOM PAINTER ANATOMY
// =====================================================================
class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaperCool,
      padding: EdgeInsets.fromLTRB(32, 40, 32, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: "ANATOMY"),
          SizedBox(height: 14),
          _SectionTitle(text: "Viewport, child, offset, clip"),
          SizedBox(height: 6),
          Text(
            "A SingleChildScrollView builds three layers: an outer viewport with "
            "a fixed size, the full child rendered behind it, and a clipping "
            "rectangle that hides everything outside the visible window.",
            style: TextStyle(color: _kInkMuted, fontSize: 13, height: 1.45),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kGrid, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 320,
                    child: CustomPaint(
                      painter: _AnatomyPainter(),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _AnatomyKey(
                        color: _kAccent,
                        title: "viewport",
                        body:
                            "The actual visible box. Its size is dictated by "
                            "the parent constraints.",
                      ),
                      SizedBox(height: 12),
                      _AnatomyKey(
                        color: _kAccent2,
                        title: "child (eagerly laid out)",
                        body:
                            "The full subtree, measured along the scroll axis. "
                            "Often taller than the viewport.",
                      ),
                      SizedBox(height: 12),
                      _AnatomyKey(
                        color: _kAccent4,
                        title: "scroll offset",
                        body:
                            "The translation applied to the child while painting. "
                            "Drives all visible motion.",
                      ),
                      SizedBox(height: 12),
                      _AnatomyKey(
                        color: _kAccent3,
                        title: "clip region",
                        body:
                            "Rectangle (or rounded rect) used to mask whatever "
                            "sits outside the viewport.",
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

class _AnatomyKey extends StatelessWidget {
  final Color color;
  final String title;
  final String body;
  const _AnatomyKey({
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 3),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 3),
              Text(
                body,
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final padding = 26.0;
    final viewportRect = Rect.fromLTWH(padding, padding, w - 2 * padding, h - 2 * padding);

    // Background grid.
    final grid = Paint()
      ..color = _kGrid
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;
    for (double x = 0; x < w; x += 16) {
      canvas.drawLine(Offset(x, 0), Offset(x, h), grid);
    }
    for (double y = 0; y < h; y += 16) {
      canvas.drawLine(Offset(0, y), Offset(w, y), grid);
    }

    // Child (taller than viewport), drawn first so the clip rect cuts it.
    final childRect = Rect.fromLTWH(
      viewportRect.left + 12,
      viewportRect.top - 60,
      viewportRect.width - 24,
      viewportRect.height + 140,
    );
    final childPaint = Paint()..color = _kAccent2.withOpacity(0.18);
    final childStroke = Paint()
      ..color = _kAccent2
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    final childRRect = RRect.fromRectAndRadius(childRect, Radius.circular(10));
    canvas.drawRRect(childRRect, childPaint);
    canvas.drawRRect(childRRect, childStroke);

    // Child rows.
    final rowPaint = Paint()..color = _kAccent2.withOpacity(0.55);
    for (int i = 0; i < 9; i++) {
      final y = childRect.top + 10 + i * 38.0;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(childRect.left + 10, y, childRect.width - 20, 18),
          Radius.circular(4),
        ),
        rowPaint,
      );
    }

    // Clip mask: dim outside the viewport.
    final maskPaint = Paint()..color = _kPaperCool.withOpacity(0.85);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, viewportRect.top), maskPaint);
    canvas.drawRect(
      Rect.fromLTWH(0, viewportRect.bottom, w, h - viewportRect.bottom),
      maskPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(0, viewportRect.top, viewportRect.left, viewportRect.height),
      maskPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(viewportRect.right, viewportRect.top,
          w - viewportRect.right, viewportRect.height),
      maskPaint,
    );

    // Viewport stroke.
    final viewportStroke = Paint()
      ..color = _kAccent
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(viewportRect, Radius.circular(8)),
      viewportStroke,
    );

    // Offset arrow.
    final arrowPaint = Paint()
      ..color = _kAccent4
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final arrowFromX = viewportRect.right - 38;
    final arrowFromY = viewportRect.top - 60 + 40;
    final arrowToY = viewportRect.top + 40;
    canvas.drawLine(
      Offset(arrowFromX, arrowFromY),
      Offset(arrowFromX, arrowToY),
      arrowPaint,
    );
    canvas.drawLine(
      Offset(arrowFromX, arrowToY),
      Offset(arrowFromX - 5, arrowToY - 6),
      arrowPaint,
    );
    canvas.drawLine(
      Offset(arrowFromX, arrowToY),
      Offset(arrowFromX + 5, arrowToY - 6),
      arrowPaint,
    );

    // Labels.
    _drawLabel(canvas, "viewport", Offset(viewportRect.left + 6, viewportRect.top + 6),
        _kAccent);
    _drawLabel(canvas, "child (eager)",
        Offset(childRect.left + 6, childRect.top + 6), _kAccent2);
    _drawLabel(canvas, "scroll offset",
        Offset(arrowFromX - 92, arrowToY - 24), _kAccent4);
    _drawLabel(canvas, "clip", Offset(w - padding - 30, padding + 2), _kAccent3);
  }

  void _drawLabel(Canvas canvas, String text, Offset pos, Color color) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final bg = Paint()..color = Colors.white.withOpacity(0.85);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(pos.dx - 2, pos.dy - 1, tp.width + 6, tp.height + 2),
        Radius.circular(3),
      ),
      bg,
    );
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// PHYSICS COMPARISON SECTION
// =====================================================================
class _PhysicsComparisonSection extends StatelessWidget {
  const _PhysicsComparisonSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaper,
      padding: EdgeInsets.fromLTRB(32, 40, 32, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: "PHYSICS"),
          SizedBox(height: 14),
          _SectionTitle(text: "Drag → release behaviour"),
          SizedBox(height: 6),
          Text(
            "All four physics share the same drag curve until release, then "
            "diverge sharply. Bouncing decays past the edge, Clamping snaps, "
            "Never stays flat, Always permits motion regardless of extent.",
            style: TextStyle(color: _kInkMuted, fontSize: 13, height: 1.45),
          ),
          SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _PhysicsCurveCard(
                  title: "Bouncing",
                  color: _kAccent5,
                  type: _PhysicsCurveType.bouncing,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _PhysicsCurveCard(
                  title: "Clamping",
                  color: _kAccent6,
                  type: _PhysicsCurveType.clamping,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _PhysicsCurveCard(
                  title: "Never",
                  color: _kDanger,
                  type: _PhysicsCurveType.never,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _PhysicsCurveCard(
                  title: "Always",
                  color: _kSuccess,
                  type: _PhysicsCurveType.always,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _PhysicsCurveType { bouncing, clamping, never, always }

class _PhysicsCurveCard extends StatelessWidget {
  final String title;
  final Color color;
  final _PhysicsCurveType type;
  const _PhysicsCurveCard({
    required this.title,
    required this.color,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kGrid, width: 1),
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
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: CustomPaint(
              painter: _PhysicsCurvePainter(color: color, type: type),
            ),
          ),
          SizedBox(height: 8),
          Text(
            _describe(type),
            style: TextStyle(
              color: _kInkSoft,
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  String _describe(_PhysicsCurveType t) {
    switch (t) {
      case _PhysicsCurveType.bouncing:
        return "Past the edge, offset decays exponentially back to the limit.";
      case _PhysicsCurveType.clamping:
        return "Offset hits the wall flat; overscroll painted by glow ancestor.";
      case _PhysicsCurveType.never:
        return "Drag has no effect; offset remains pinned to zero.";
      case _PhysicsCurveType.always:
        return "Drag accepted even when child fits; needed for refresh pulls.";
    }
  }
}

class _PhysicsCurvePainter extends CustomPainter {
  final Color color;
  final _PhysicsCurveType type;
  _PhysicsCurvePainter({required this.color, required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final axis = Paint()
      ..color = _kGrid
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, size.height - 1), Offset(size.width, size.height - 1), axis);
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axis);

    final path = Path();
    final stroke = Paint()
      ..color = color
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;

    final w = size.width;
    final h = size.height;
    final dragEnd = w * 0.45;

    switch (type) {
      case _PhysicsCurveType.bouncing:
        path.moveTo(0, h * 0.85);
        for (double x = 0; x <= dragEnd; x += 2) {
          final t = x / dragEnd;
          final y = h * 0.85 - h * 0.7 * t;
          path.lineTo(x, y);
        }
        // Past edge: bounce overshoot decaying.
        double yPrev = h * 0.15;
        for (double x = dragEnd; x <= w; x += 2) {
          final t = (x - dragEnd) / (w - dragEnd);
          final overshoot = math.sin(t * math.pi * 2.5) * math.exp(-t * 3.5);
          final y = h * 0.15 + overshoot * h * 0.30;
          path.lineTo(x, y);
          yPrev = y;
        }
        break;
      case _PhysicsCurveType.clamping:
        path.moveTo(0, h * 0.85);
        for (double x = 0; x <= dragEnd; x += 2) {
          final t = x / dragEnd;
          final y = h * 0.85 - h * 0.7 * t;
          path.lineTo(x, y);
        }
        for (double x = dragEnd; x <= w; x += 2) {
          path.lineTo(x, h * 0.15);
        }
        break;
      case _PhysicsCurveType.never:
        path.moveTo(0, h * 0.85);
        path.lineTo(w, h * 0.85);
        break;
      case _PhysicsCurveType.always:
        path.moveTo(0, h * 0.85);
        for (double x = 0; x <= dragEnd; x += 2) {
          final t = x / dragEnd;
          final y = h * 0.85 - h * 0.55 * t;
          path.lineTo(x, y);
        }
        for (double x = dragEnd; x <= w; x += 2) {
          final t = (x - dragEnd) / (w - dragEnd);
          final y = h * 0.30 + h * 0.18 * (1 - math.exp(-t * 2.5));
          path.lineTo(x, y);
        }
        break;
    }

    canvas.drawPath(path, stroke);

    // Release marker.
    if (type != _PhysicsCurveType.never) {
      final marker = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(dragEnd, h * 0.15), 3.5, marker);
      final tp = TextPainter(
        text: TextSpan(
          text: "release",
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(dragEnd + 4, h * 0.15 - 12));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// IDIOM SAMPLES SECTION
// =====================================================================
class _IdiomSamplesSection extends StatelessWidget {
  const _IdiomSamplesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaperCool,
      padding: EdgeInsets.fromLTRB(32, 40, 32, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: "IDIOMS"),
          SizedBox(height: 14),
          _SectionTitle(text: "Six recurring code shapes"),
          SizedBox(height: 6),
          Text(
            "These compact snippets cover the situations you will hit most often "
            "when reaching for SingleChildScrollView in real Flutter apps.",
            style: TextStyle(color: _kInkMuted, fontSize: 13, height: 1.45),
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _CodeSnippetCard(
                  title: "1 · Form with onDrag dismiss",
                  code:
                      "SingleChildScrollView(\n"
                      "  padding: const EdgeInsets.all(16),\n"
                      "  keyboardDismissBehavior:\n"
                      "    ScrollViewKeyboardDismissBehavior.onDrag,\n"
                      "  child: Column(children: _fields),\n"
                      ");",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _CodeSnippetCard(
                  title: "2 · With ScrollController + Scrollbar",
                  code:
                      "final _ctrl = ScrollController();\n"
                      "Scrollbar(\n"
                      "  controller: _ctrl,\n"
                      "  child: SingleChildScrollView(\n"
                      "    controller: _ctrl,\n"
                      "    child: _bigStaticPanel,\n"
                      "  ),\n"
                      ");",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _CodeSnippetCard(
                  title: "3 · Flexible inside Column",
                  code:
                      "Column(\n"
                      "  children: [\n"
                      "    Header(),\n"
                      "    Flexible(\n"
                      "      child: SingleChildScrollView(\n"
                      "        child: _content,\n"
                      "      ),\n"
                      "    ),\n"
                      "    Footer(),\n"
                      "  ],\n"
                      ");",
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _CodeSnippetCard(
                  title: "4 · Two horizontal strips",
                  code:
                      "SingleChildScrollView(\n"
                      "  scrollDirection: Axis.horizontal,\n"
                      "  child: Row(\n"
                      "    children: _chipSet,\n"
                      "  ),\n"
                      ");",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _CodeSnippetCard(
                  title: "5 · Web-friendly with primary:false",
                  code:
                      "SingleChildScrollView(\n"
                      "  primary: false,\n"
                      "  physics: const ClampingScrollPhysics(),\n"
                      "  child: _sidePanel,\n"
                      ");",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _CodeSnippetCard(
                  title: "6 · Pull-to-refresh wrapper",
                  code:
                      "RefreshIndicator(\n"
                      "  onRefresh: _refresh,\n"
                      "  child: SingleChildScrollView(\n"
                      "    physics: const\n"
                      "      AlwaysScrollableScrollPhysics(),\n"
                      "    child: _content,\n"
                      "  ),\n"
                      ");",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CodeSnippetCard extends StatelessWidget {
  final String title;
  final String code;
  const _CodeSnippetCard({required this.title, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kInkSoft, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _kInkSoft,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    color: _kAccent4,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    color: _kSuccess,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    color: _kAccent3,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
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
                color: Color(0xFFD6E3FF),
                fontSize: 11.5,
                fontFamily: "monospace",
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PITFALLS SECTION
// =====================================================================
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaper,
      padding: EdgeInsets.fromLTRB(32, 40, 32, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: "PITFALLS"),
          SizedBox(height: 14),
          _SectionTitle(text: "Six classic foot-guns"),
          SizedBox(height: 6),
          Text(
            "Most SingleChildScrollView bugs come from misunderstanding either "
            "intrinsic sizing, the PrimaryScrollController, or the lack of "
            "render recycling. Avoid these patterns.",
            style: TextStyle(color: _kInkMuted, fontSize: 13, height: 1.45),
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _PitfallCard(
                index: 1,
                title: "Column without MainAxisSize.min",
                summary:
                    "A default Column inside a SingleChildScrollView wants "
                    "infinite height and throws ‘RenderFlex overflowed’.",
                fix:
                    "Set mainAxisSize: MainAxisSize.min on the child Column, "
                    "or let it expand naturally only along the scroll axis.",
              )),
              SizedBox(width: 14),
              Expanded(child: _PitfallCard(
                index: 2,
                title: "Unbounded children",
                summary:
                    "Wrapping an Expanded or a ListView inside this scroll view "
                    "produces double-unbounded layout exceptions.",
                fix:
                    "Replace Expanded with concrete sizing, or hoist the inner "
                    "ListView out so only one scrollable owns the axis.",
              )),
              SizedBox(width: 14),
              Expanded(child: _PitfallCard(
                index: 3,
                title: "Conflicting primary controllers",
                summary:
                    "Two vertical SingleChildScrollViews both default to "
                    "primary:true and fight over the PrimaryScrollController.",
                fix:
                    "Set primary:false on the inner one, or attach an explicit "
                    "ScrollController so neither uses the primary.",
              )),
            ],
          ),
          SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _PitfallCard(
                index: 4,
                title: "Default primary inside Scaffold body",
                summary:
                    "A vertical SingleChildScrollView in Scaffold.body picks "
                    "up the PrimaryScrollController and breaks NestedScrollView.",
                fix:
                    "Pass primary:false explicitly when the scroll view is not "
                    "the page's main scroller — or use a dedicated controller.",
              )),
              SizedBox(width: 14),
              Expanded(child: _PitfallCard(
                index: 5,
                title: "Confusing it with ListView.shrinkWrap",
                summary:
                    "Replacing ListView with SingleChildScrollView+Column "
                    "loses lazy building and balloons memory for long lists.",
                fix:
                    "If you have more than ~50 homogeneous items, use "
                    "ListView.builder. shrinkWrap is rarely the right answer.",
              )),
              SizedBox(width: 14),
              Expanded(child: _PitfallCard(
                index: 6,
                title: "Scrollbar without a controller",
                summary:
                    "A Scrollbar wrapped around a SingleChildScrollView on "
                    "desktop/web throws unless both share a controller.",
                fix:
                    "Create one ScrollController, pass it to both Scrollbar "
                    "and SingleChildScrollView. Setting primary on both also works.",
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  final int index;
  final String title;
  final String summary;
  final String fix;
  const _PitfallCard({
    required this.index,
    required this.title,
    required this.summary,
    required this.fix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kGrid, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _kDanger.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  index.toString(),
                  style: TextStyle(
                    color: _kDanger,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            summary,
            style: TextStyle(
              color: _kInkSoft,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSuccess.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kSuccess.withOpacity(0.30), width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FIX",
                  style: TextStyle(
                    color: _kSuccess,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.6,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fix,
                    style: TextStyle(
                      color: _kInkSoft,
                      fontSize: 12,
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

// =====================================================================
// DECISION MATRIX SECTION
// =====================================================================
class _DecisionMatrixSection extends StatelessWidget {
  const _DecisionMatrixSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaperCool,
      padding: EdgeInsets.fromLTRB(32, 40, 32, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: "WHICH SCROLLABLE?"),
          SizedBox(height: 14),
          _SectionTitle(text:
              "SingleChildScrollView vs ListView vs CustomScrollView vs NestedScrollView"),
          SizedBox(height: 6),
          Text(
            "A condensed cross-check across the four Flutter scrollables you "
            "are most likely to choose between.",
            style: TextStyle(color: _kInkMuted, fontSize: 13, height: 1.45),
          ),
          SizedBox(height: 22),
          Container(
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kGrid, width: 1),
            ),
            child: Column(
              children: [
                _DecisionHeader(),
                _DecisionRow(
                  axis: "Lazy layout?",
                  values: const ["no", "yes (builders)", "yes (slivers)", "yes (slivers)"],
                  colors: const [_kDanger, _kSuccess, _kSuccess, _kSuccess],
                ),
                _DecisionRow(
                  axis: "Best for…",
                  values: const [
                    "small bounded content",
                    "long homogeneous lists",
                    "mixed sliver compositions",
                    "headers atop inner scrollers",
                  ],
                  colors: const [_kAccent, _kAccent2, _kAccent4, _kAccent6],
                ),
                _DecisionRow(
                  axis: "Memory cost",
                  values: const ["O(child)", "O(viewport)", "O(viewport)", "O(viewport)"],
                  colors: const [_kDanger, _kSuccess, _kSuccess, _kSuccess],
                ),
                _DecisionRow(
                  axis: "Custom headers / app bars",
                  values: const ["hard", "limited", "native", "native"],
                  colors: const [_kDanger, _kWarn, _kSuccess, _kSuccess],
                ),
                _DecisionRow(
                  axis: "Inner-scrollable nesting",
                  values: const ["risky", "limited", "limited", "designed for it"],
                  colors: const [_kDanger, _kWarn, _kWarn, _kSuccess],
                ),
                _DecisionRow(
                  axis: "API complexity",
                  values: const ["lowest", "low", "high", "high"],
                  colors: const [_kSuccess, _kSuccess, _kWarn, _kWarn],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DecisionHeader extends StatelessWidget {
  const _DecisionHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: _ParamHeadText(text: "DIMENSION")),
          Expanded(flex: 3, child: _ParamHeadText(text: "SingleChildScrollView")),
          Expanded(flex: 3, child: _ParamHeadText(text: "ListView")),
          Expanded(flex: 3, child: _ParamHeadText(text: "CustomScrollView")),
          Expanded(flex: 3, child: _ParamHeadText(text: "NestedScrollView")),
        ],
      ),
    );
  }
}

class _DecisionRow extends StatelessWidget {
  final String axis;
  final List<String> values;
  final List<Color> colors;
  const _DecisionRow({
    required this.axis,
    required this.values,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 11),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: _kGrid, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              axis,
              style: TextStyle(
                color: _kInk,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          for (int i = 0; i < values.length; i++)
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(right: 6),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: colors[i].withOpacity(0.10),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: colors[i].withOpacity(0.4), width: 1),
                ),
                child: Text(
                  values[i],
                  style: TextStyle(
                    color: colors[i],
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =====================================================================
// FOOTER CHEATSHEET
// =====================================================================
class _FooterCheatsheetSection extends StatelessWidget {
  const _FooterCheatsheetSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 40, 32, 48),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF101333),
            Color(0xFF1E2353),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cheat-sheet",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Chip-tagged API surface for SingleChildScrollView. Hover-equivalent "
            "summary you can scan at a glance.",
            style: TextStyle(
              color: Color(0xFFB9BFE0),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _FooterChip(label: "scrollDirection", tone: _kAccent),
              _FooterChip(label: "reverse", tone: _kAccent3),
              _FooterChip(label: "padding", tone: _kAccent4),
              _FooterChip(label: "primary", tone: _kInfo),
              _FooterChip(label: "physics", tone: _kAccent5),
              _FooterChip(label: "controller", tone: _kAccent2),
              _FooterChip(label: "dragStartBehavior", tone: _kAccent6),
              _FooterChip(label: "clipBehavior", tone: _kWarn),
              _FooterChip(label: "restorationId", tone: _kAccent6),
              _FooterChip(label: "keyboardDismissBehavior", tone: _kAccent3),
              _FooterChip(label: "hitTestBehavior", tone: _kSuccess),
              _FooterChip(label: "child", tone: _kAccent),
            ],
          ),
          SizedBox(height: 28),
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "One-line take",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "SingleChildScrollView is a scrolling viewport for ONE eagerly "
                  "laid-out child — pick it for forms, settings, and bounded "
                  "panels; reach for ListView, CustomScrollView, or "
                  "NestedScrollView the moment recycling, slivers, or nested "
                  "scrollables enter the picture.",
                  style: TextStyle(
                    color: Color(0xFFE6E9FA),
                    fontSize: 13.5,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 28),
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _kAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "SCS",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "package:flutter/widgets.dart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: "monospace",
                    ),
                  ),
                  Text(
                    "class SingleChildScrollView extends StatelessWidget",
                    style: TextStyle(
                      color: Color(0xFFB9BFE0),
                      fontSize: 11.5,
                      fontFamily: "monospace",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterChip extends StatelessWidget {
  final String label;
  final Color tone;
  const _FooterChip({required this.label, required this.tone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: tone.withOpacity(0.16),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tone.withOpacity(0.55), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          fontFamily: "monospace",
        ),
      ),
    );
  }
}

// =====================================================================
// SHARED SECTION SCAFFOLD
// =====================================================================
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 3,
          decoration: BoxDecoration(
            color: _kAccent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: _kAccent,
            fontSize: 11.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: _kInk,
        fontSize: 26,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.4,
        height: 1.15,
      ),
    );
  }
}
