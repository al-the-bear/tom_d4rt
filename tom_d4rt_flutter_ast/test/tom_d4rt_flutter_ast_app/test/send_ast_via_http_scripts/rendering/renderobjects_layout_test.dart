// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual test script: RenderBox layout family — constraints down, sizes up.
// Renders an "architect's drafting table" exploring BoxConstraints, ConstrainedBox,
// LimitedBox, UnconstrainedBox, AspectRatio, IntrinsicWidth/Height,
// FractionallySizedBox, SizedOverflowBox, CustomMultiChildLayout, Flex/Row/Column,
// and Stack — the public widget counterparts of the RenderBox layout protocol.
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ---------------------------------------------------------------------------
// PALETTE — navy blueprint / chalk-white / drafting pencil
// ---------------------------------------------------------------------------
const Color kBlueprintInk = Color(0xFF0A1F3D);
const Color kBlueprintDeep = Color(0xFF12305E);
const Color kBlueprintMid = Color(0xFF1B4A8A);
const Color kBlueprintAccent = Color(0xFF3D6FB8);
const Color kBlueprintLine = Color(0xFF6C9BD2);
const Color kChalkWhite = Color(0xFFF4F1E8);
const Color kChalkSoft = Color(0xFFE5E0CC);
const Color kPencilGraphite = Color(0xFF323A48);
const Color kPencilSepia = Color(0xFFB68A4A);
const Color kAccentRust = Color(0xFFB55835);
const Color kAccentOlive = Color(0xFF7C8A3B);
const Color kAccentTeal = Color(0xFF3F8C8C);
const Color kAccentLavender = Color(0xFF7A6FAE);
const Color kBlueprintGrid = Color(0x222C7AC9);

// ---------------------------------------------------------------------------
// DATA MODELS
// ---------------------------------------------------------------------------
class ConstraintRecord {
  final String label;
  final String formula;
  final double minW;
  final double maxW;
  final double minH;
  final double maxH;
  final String note;
  const ConstraintRecord({
    required this.label,
    required this.formula,
    required this.minW,
    required this.maxW,
    required this.minH,
    required this.maxH,
    required this.note,
  });
}

class WidgetEntry {
  final String name;
  final String constrains;
  final String childReq;
  final String performance;
  final Color tint;
  const WidgetEntry(
    this.name,
    this.constrains,
    this.childReq,
    this.performance,
    this.tint,
  );
}

class RecipeCard {
  final String title;
  final String snippet;
  final String purpose;
  final Color accent;
  const RecipeCard(this.title, this.snippet, this.purpose, this.accent);
}

class GlossaryItem {
  final String term;
  final String meaning;
  const GlossaryItem(this.term, this.meaning);
}

class PitfallNote {
  final String title;
  final String body;
  final Color color;
  const PitfallNote(this.title, this.body, this.color);
}

// ---------------------------------------------------------------------------
// SHARED HELPERS
// ---------------------------------------------------------------------------
BoxDecoration kBlueprintCard({Color? fill, Color? border, double radius = 12}) {
  return BoxDecoration(
    color: fill ?? kChalkWhite,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: border ?? kBlueprintLine, width: 1.2),
  );
}

BoxDecoration kInkPanel({double radius = 14}) {
  return BoxDecoration(
    color: kBlueprintInk,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: kBlueprintAccent, width: 1.0),
  );
}

// A "grid paper" specimen container — emulates blueprint paper visually.
Widget specimen({
  required Widget child,
  required double width,
  required double height,
  Color? bg,
  Color? border,
  String? caption,
}) {
  final stack = Stack(
    alignment: Alignment.center,
    children: [
      // grid paper backdrop using nested borders
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bg ?? kChalkWhite,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: border ?? kBlueprintLine, width: 1.0),
        ),
        child: Column(
          children: [
            for (int i = 0; i < 6; i++)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: kBlueprintGrid, width: 0.6),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      // the actual layout specimen content
      SizedBox(width: width, height: height, child: child),
      if (caption != null)
        Positioned(
          left: 4,
          bottom: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: kBlueprintInk.withOpacity(0.85),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              caption,
              style: TextStyle(
                fontSize: 9,
                color: kChalkWhite,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
    ],
  );
  return stack;
}

Widget tag(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: (color ?? kBlueprintMid).withOpacity(0.18),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: (color ?? kBlueprintMid), width: 0.8),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: color ?? kBlueprintDeep,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget sectionHeader(
  String number,
  String title,
  String subtitle,
  Color accent,
) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kBlueprintDeep,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
      border: Border(bottom: BorderSide(color: accent, width: 3.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
            border: Border.all(color: kChalkWhite, width: 2.0),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: kChalkWhite,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'monospace',
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
                  fontSize: 18,
                  color: kChalkWhite,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: kBlueprintLine,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// CONTENT — pre-computed lists for the visual gallery
// ---------------------------------------------------------------------------
final List<ConstraintRecord> kConstraintCards = [
  ConstraintRecord(
    label: 'tight',
    formula: 'BoxConstraints.tight(Size(120,80))',
    minW: 120,
    maxW: 120,
    minH: 80,
    maxH: 80,
    note: 'min == max — child has no choice.',
  ),
  ConstraintRecord(
    label: 'loose',
    formula: 'BoxConstraints.loose(Size(200,120))',
    minW: 0,
    maxW: 200,
    minH: 0,
    maxH: 120,
    note: 'min == 0 — child may pick any size up to max.',
  ),
  ConstraintRecord(
    label: 'expand',
    formula: 'BoxConstraints.expand()',
    minW: double.infinity,
    maxW: double.infinity,
    minH: double.infinity,
    maxH: double.infinity,
    note: 'tight at infinity — child must fill all available space.',
  ),
  ConstraintRecord(
    label: 'tightFor',
    formula: 'BoxConstraints.tightFor(width: 160)',
    minW: 160,
    maxW: 160,
    minH: 0,
    maxH: double.infinity,
    note: 'tight on one axis, free on the other.',
  ),
  ConstraintRecord(
    label: 'tightForFinite',
    formula: 'BoxConstraints.tightForFinite(width:160,height:90)',
    minW: 160,
    maxW: 160,
    minH: 90,
    maxH: 90,
    note: 'tight only when supplied value is finite.',
  ),
];

final List<WidgetEntry> kWidgetTable = [
  WidgetEntry('ConstrainedBox', 'caller-supplied min/max', 'any', 'O(1)', kBlueprintAccent),
  WidgetEntry('LimitedBox', 'caps width/height only if unbounded', 'any', 'O(1)', kAccentTeal),
  WidgetEntry('UnconstrainedBox', 'removes incoming constraints', 'any', 'O(1)', kAccentRust),
  WidgetEntry('AspectRatio', 'forces width/height ratio', 'any', 'O(1)', kAccentOlive),
  WidgetEntry('IntrinsicWidth', 'tight to child intrinsic width', 'must report intrinsic', 'O(N\u00B2)', kAccentLavender),
  WidgetEntry('IntrinsicHeight', 'tight to child intrinsic height', 'must report intrinsic', 'O(N\u00B2)', kAccentLavender),
  WidgetEntry('FractionallySizedBox', 'fraction of parent', 'any', 'O(1)', kBlueprintMid),
  WidgetEntry('SizedOverflowBox', 'fixed layout size, child overflows', 'any', 'O(1)', kPencilSepia),
  WidgetEntry('Flex / Row / Column', 'partitions main-axis', 'sizes by flex factor', 'O(N)', kBlueprintDeep),
  WidgetEntry('Stack', 'overlays children', 'positioned or non-positioned', 'O(N)', kAccentRust),
  WidgetEntry('CustomMultiChildLayout', 'delegate-driven', 'LayoutId children', 'O(N)', kAccentTeal),
];

final List<RecipeCard> kRecipes = [
  RecipeCard(
    '16:9 hero image',
    'AspectRatio(aspectRatio: 16/9, child: Image(...))',
    'Locks the visual frame for any source size.',
    kAccentOlive,
  ),
  RecipeCard(
    'Two-column equal split',
    'Row(children: [Expanded(child: A), Expanded(child: B)])',
    'Flex factor 1+1 splits remaining width 50/50.',
    kBlueprintAccent,
  ),
  RecipeCard(
    'Ribbon overlay',
    'Stack(children: [base, Positioned(top:8,right:8,child:Ribbon())])',
    'Stack pins decoration without disturbing main flow.',
    kAccentRust,
  ),
  RecipeCard(
    'Min-100 max-300 sidebar',
    'ConstrainedBox(constraints: BoxConstraints(minWidth:100,maxWidth:300))',
    'Caller-supplied range stays elastic between bounds.',
    kAccentTeal,
  ),
  RecipeCard(
    'Half-screen panel',
    'FractionallySizedBox(widthFactor: 0.5, child: ...)',
    'Always half of parent — responsive to resize.',
    kBlueprintMid,
  ),
  RecipeCard(
    'Intrinsic-width tags row',
    'IntrinsicHeight(child: Row(children: [Tag(), Tag(), Tag()]))',
    'All tag children share the tallest intrinsic height.',
    kAccentLavender,
  ),
];

final List<GlossaryItem> kGlossary = [
  GlossaryItem('BoxConstraints', 'Immutable min/max width and height passed from parent to child.'),
  GlossaryItem('RenderBox', 'RenderObject with a Cartesian coordinate system and a Size.'),
  GlossaryItem('RenderProxyBox', 'RenderBox with one child it forwards layout to almost unchanged.'),
  GlossaryItem('RenderShiftedBox', 'RenderProxyBox subclass that positions its child via offset.'),
  GlossaryItem('ParentData', 'Per-child slot for parent-specific layout metadata (e.g. FlexParentData).'),
  GlossaryItem('performLayout', 'Method where a RenderObject lays out children and sets its own size.'),
  GlossaryItem('layout()', 'Public entry point — receives constraints and runs performLayout if needed.'),
  GlossaryItem('markNeedsLayout', 'Schedules a relayout pass walking up to the nearest relayout boundary.'),
  GlossaryItem('hitTest', 'Walks the box tree to find which child contains a pointer event.'),
  GlossaryItem('paint', 'Emits a Picture into the layer tree using a Canvas.'),
  GlossaryItem('isRepaintBoundary', 'When true, the subtree paints into its own offscreen surface.'),
  GlossaryItem('RelayoutBoundary', 'Subtree whose layout is independent of changes outside it.'),
  GlossaryItem('sizedByParent', 'Box whose size is fully determined by its incoming constraints.'),
  GlossaryItem('intrinsicWidth', 'The width a child would prefer given an unbounded constraint.'),
  GlossaryItem('intrinsicHeight', 'The height a child would prefer for a given width.'),
  GlossaryItem('TightConstraints', 'BoxConstraints whose min equals max — exactly one allowed size.'),
  GlossaryItem('LooseConstraints', 'BoxConstraints whose min is zero — child may shrink freely.'),
];

final List<PitfallNote> kPitfalls = [
  PitfallNote(
    'Unbounded constraints in scroll views',
    'A Column inside a ListView receives unbounded height — Expanded throws. Wrap in a SizedBox '
        'or use shrinkWrap with a bounded host.',
    kAccentRust,
  ),
  PitfallNote(
    'Intrinsics are O(N\u00B2)',
    'IntrinsicWidth/Height walks the subtree to ask each child for its preferred size. Avoid deep '
        'nesting; cache where possible or design without intrinsics.',
    kPencilSepia,
  ),
  PitfallNote(
    'UnconstrainedBox surprises',
    'Stripping constraints lets a child grow without bound. Combined with a Row, the row can '
        'overflow horizontally — prefer ConstraintsTransformBox with a documented transform.',
    kAccentLavender,
  ),
  PitfallNote(
    'FractionallySizedBox needs bounded parent',
    'A fraction of "infinity" is undefined. Place inside a SizedBox or constrained container.',
    kBlueprintMid,
  ),
];

// ---------------------------------------------------------------------------
// SECTION BUILDERS
// ---------------------------------------------------------------------------
Widget buildHeroHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [kBlueprintInk, kBlueprintDeep, kBlueprintMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kBlueprintAccent, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: kChalkWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBlueprintAccent, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                '\u25A2',
                style: TextStyle(
                  fontSize: 30,
                  color: kBlueprintDeep,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RenderBox & layout',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: kChalkWhite,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'constraints down, sizes up',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kBlueprintLine,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            tag('BoxConstraints', color: kChalkWhite),
            tag('RenderBox protocol', color: kChalkWhite),
            tag('Flex / Stack', color: kChalkWhite),
            tag('AspectRatio', color: kChalkWhite),
            tag('Intrinsics', color: kChalkWhite),
            tag('Fractional sizing', color: kChalkWhite),
          ],
        ),
      ],
    ),
  );
}

Widget buildConceptOverview() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    decoration: kBlueprintCard(fill: kChalkSoft, border: kBlueprintMid),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kBlueprintDeep,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '\u270E',
                style: TextStyle(fontSize: 20, color: kChalkWhite),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'The box protocol',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kBlueprintInk,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Text(
          'Layout in Flutter is a two-direction conversation between parent and child. '
          'The parent passes BoxConstraints DOWN the tree (min/max width and height). '
          'The child responds with a Size that satisfies those constraints, returned UP the tree.',
          style: TextStyle(fontSize: 14, height: 1.5, color: kPencilGraphite),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kBlueprintInk,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '  parent ──BoxConstraints──▶ child',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: kChalkWhite,
                  fontSize: 12,
                ),
              ),
              Text(
                '  parent ◀──── Size ──────── child',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: kBlueprintLine,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Tight constraints (min == max) force a specific size. Loose constraints (min == 0) '
          'let the child decide. Box layout is finite, depth-first, and almost always single-pass — '
          'unlike Sliver layout which uses a SliverConstraints/SliverGeometry pair to support '
          'lazy scrolling and dynamic extents.',
          style: TextStyle(fontSize: 13, height: 1.5, color: kPencilGraphite),
        ),
      ],
    ),
  );
}

Widget buildConstraintsAnatomy() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '03',
          'BoxConstraints anatomy',
          'five canonical shapes that drive almost everything below',
          kBlueprintAccent,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            children: [
              for (final c in kConstraintCards)
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kChalkSoft,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kBlueprintLine, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 90,
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            color: kBlueprintDeep,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            c.label,
                            style: TextStyle(
                              color: kChalkWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.formula,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: kBlueprintInk,
                                ),
                              ),
                              SizedBox(height: 4),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: [
                                  tag(
                                    'minW ${c.minW == double.infinity ? "∞" : c.minW.toStringAsFixed(0)}',
                                    color: kAccentTeal,
                                  ),
                                  tag(
                                    'maxW ${c.maxW == double.infinity ? "∞" : c.maxW.toStringAsFixed(0)}',
                                    color: kAccentTeal,
                                  ),
                                  tag(
                                    'minH ${c.minH == double.infinity ? "∞" : c.minH.toStringAsFixed(0)}',
                                    color: kAccentOlive,
                                  ),
                                  tag(
                                    'maxH ${c.maxH == double.infinity ? "∞" : c.maxH.toStringAsFixed(0)}',
                                    color: kAccentOlive,
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                c.note,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                  color: kPencilGraphite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

Widget buildTightVsLoose() {
  Widget childBox(String label, Color color) => Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        color: kChalkWhite,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    ),
  );

  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '04',
          'Tight vs loose specimen',
          'same child, opposite outcomes',
          kAccentTeal,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'tight (min==max)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBlueprintInk,
                      ),
                    ),
                    SizedBox(height: 8),
                    specimen(
                      width: 180,
                      height: 120,
                      caption: 'forced 160×100',
                      child: Center(
                        child: SizedBox(
                          width: 160,
                          height: 100,
                          child: childBox('child', kAccentRust),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'loose (min==0)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBlueprintInk,
                      ),
                    ),
                    SizedBox(height: 8),
                    specimen(
                      width: 180,
                      height: 120,
                      caption: 'child picks 80×60',
                      child: Center(
                        child: SizedBox(
                          width: 80,
                          height: 60,
                          child: childBox('child', kAccentOlive),
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

Widget buildConstrainedBox() {
  final specimens = <Map<String, dynamic>>[
    {
      'caption': 'tight width 140',
      'constraints': BoxConstraints.tightFor(width: 140),
      'child': Container(color: kBlueprintAccent, height: 40),
    },
    {
      'caption': 'maxWidth 100',
      'constraints': BoxConstraints(maxWidth: 100),
      'child': Container(color: kAccentTeal, height: 40, width: double.infinity),
    },
    {
      'caption': 'minHeight 60..100',
      'constraints': BoxConstraints(minHeight: 60, maxHeight: 100),
      'child': Container(color: kAccentRust, width: 80),
    },
    {
      'caption': 'expand all',
      'constraints': BoxConstraints.expand(width: 160, height: 80),
      'child': Container(color: kAccentLavender),
    },
    {
      'caption': 'fixed 120×70',
      'constraints': BoxConstraints.tight(Size(120, 70)),
      'child': Container(color: kAccentOlive),
    },
  ];
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '05',
          'ConstrainedBox',
          'caller layers an additional BoxConstraints on top of incoming ones',
          kBlueprintMid,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final s in specimens)
                specimen(
                  width: 180,
                  height: 120,
                  caption: s['caption'] as String,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: s['constraints'] as BoxConstraints,
                      child: s['child'] as Widget,
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

Widget buildLimitedBox() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '06',
          'LimitedBox',
          'only applies its maximums when incoming constraint is unbounded',
          kAccentOlive,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            children: [
              Text(
                'In a scroll, parent passes unbounded height — LimitedBox caps it.',
                style: TextStyle(
                  fontSize: 12,
                  color: kPencilGraphite,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: specimen(
                      width: 180,
                      height: 130,
                      caption: 'inside SizedBox',
                      child: Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: LimitedBox(
                            maxHeight: 50,
                            maxWidth: 50,
                            child: Container(color: kBlueprintAccent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: specimen(
                      width: 180,
                      height: 130,
                      caption: 'limit kicks in',
                      child: Center(
                        child: UnconstrainedBox(
                          child: LimitedBox(
                            maxHeight: 60,
                            maxWidth: 60,
                            child: Container(color: kAccentTeal),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: specimen(
                      width: 180,
                      height: 130,
                      caption: 'huge max ignored',
                      child: Center(
                        child: SizedBox(
                          width: 80,
                          height: 50,
                          child: LimitedBox(
                            maxHeight: 999,
                            maxWidth: 999,
                            child: Container(color: kAccentRust),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildUnconstrainedBox() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '07',
          'UnconstrainedBox',
          'strips incoming constraints — handle with care',
          kAccentRust,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'safe — child smaller than parent',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBlueprintInk,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 6),
                    specimen(
                      width: 220,
                      height: 110,
                      caption: 'child 60×40 in 220×110',
                      child: Center(
                        child: UnconstrainedBox(
                          child: SizedBox(
                            width: 60,
                            height: 40,
                            child: Container(color: kAccentOlive),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'dangerous — child wants more',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kAccentRust,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 6),
                    specimen(
                      width: 220,
                      height: 110,
                      caption: 'overflow risk if child > parent',
                      child: ClipRect(
                        child: Center(
                          child: UnconstrainedBox(
                            child: SizedBox(
                              width: 180,
                              height: 60,
                              child: Container(color: kAccentRust),
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
        ),
      ],
    ),
  );
}

Widget buildAspectRatio() {
  final ratios = <Map<String, dynamic>>[
    {'label': '16:9', 'ratio': 16 / 9, 'color': kBlueprintAccent},
    {'label': '4:3', 'ratio': 4 / 3, 'color': kAccentTeal},
    {'label': '1:1', 'ratio': 1.0, 'color': kAccentOlive},
    {'label': '3:4', 'ratio': 3 / 4, 'color': kAccentRust},
    {'label': '9:16', 'ratio': 9 / 16, 'color': kAccentLavender},
  ];
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '08',
          'AspectRatio',
          'forces a width/height ratio inside available space',
          kAccentLavender,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final r in ratios)
                Column(
                  children: [
                    Text(
                      r['label'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBlueprintInk,
                      ),
                    ),
                    SizedBox(height: 4),
                    specimen(
                      width: 120,
                      height: 120,
                      caption: r['label'] as String,
                      child: Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: AspectRatio(
                            aspectRatio: r['ratio'] as double,
                            child: Container(color: r['color'] as Color),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildIntrinsics() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '09',
          'IntrinsicWidth & IntrinsicHeight',
          'sizes a child to its intrinsic preferred dimension (O(N²) — use sparingly)',
          kAccentRust,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            children: [
              Text(
                'IntrinsicWidth — every child gets the widest child\'s width',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBlueprintInk,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kChalkSoft,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: kBlueprintAccent,
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'short',
                          style: TextStyle(color: kChalkWhite),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        color: kAccentTeal,
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'a much longer label inside',
                          style: TextStyle(color: kChalkWhite),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        color: kAccentOlive,
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'mid',
                          style: TextStyle(color: kChalkWhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 14),
              Text(
                'IntrinsicHeight — Row children share tallest natural height',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBlueprintInk,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 6),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        color: kBlueprintMid,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'one line',
                          style: TextStyle(color: kChalkWhite),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        color: kAccentRust,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'two lines here — slightly more text\nso this column dictates height',
                          style: TextStyle(color: kChalkWhite),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        color: kAccentLavender,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'short',
                          style: TextStyle(color: kChalkWhite),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kAccentRust.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: kAccentRust, width: 1),
                ),
                child: Text(
                  '⚠  Intrinsic methods recurse — combine with shallow children only.',
                  style: TextStyle(fontSize: 11, color: kAccentRust),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildFractionallySized() {
  final factors = <Map<String, dynamic>>[
    {'w': 1.0, 'h': 0.5, 'label': 'w 1.0 h 0.5'},
    {'w': 0.5, 'h': 1.0, 'label': 'w 0.5 h 1.0'},
    {'w': 0.75, 'h': 0.75, 'label': 'w 0.75 h 0.75'},
    {'w': 0.33, 'h': 0.33, 'label': 'w 0.33 h 0.33'},
  ];
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '10',
          'FractionallySizedBox',
          'always a fraction of the parent — must have a bounded parent',
          kBlueprintMid,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final f in factors)
                specimen(
                  width: 160,
                  height: 100,
                  caption: f['label'] as String,
                  child: FractionallySizedBox(
                    widthFactor: f['w'] as double,
                    heightFactor: f['h'] as double,
                    alignment: Alignment.center,
                    child: Container(color: kAccentTeal),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSizedOverflowBox() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '11',
          'SizedOverflowBox',
          'box reports a fixed layout size; child may exceed it (clipped here)',
          kPencilSepia,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(
                child: specimen(
                  width: 200,
                  height: 120,
                  caption: 'layout 60×40; child 120×80',
                  child: Center(
                    child: ClipRect(
                      child: SizedOverflowBox(
                        size: Size(60, 40),
                        child: Container(width: 120, height: 80, color: kAccentRust),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: specimen(
                  width: 200,
                  height: 120,
                  caption: 'layout 100×60; child 80×40',
                  child: Center(
                    child: SizedOverflowBox(
                      size: Size(100, 60),
                      child: Container(width: 80, height: 40, color: kAccentOlive),
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

Widget buildFlexSpecimens() {
  Widget chip(String t, Color c, {double width = 36, double height = 28}) =>
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          t,
          style: TextStyle(
            color: kChalkWhite,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget row(MainAxisAlignment m, String label) => Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: kBlueprintInk,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 36,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: kChalkSoft,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: kBlueprintLine, width: 0.6),
            ),
            child: Row(
              mainAxisAlignment: m,
              children: [
                chip('A', kBlueprintAccent),
                chip('B', kAccentTeal),
                chip('C', kAccentRust),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget crossRow(CrossAxisAlignment c, String label) => Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: kBlueprintInk,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 50,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: kChalkSoft,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: kBlueprintLine, width: 0.6),
            ),
            child: Row(
              crossAxisAlignment: c,
              children: [
                chip('A', kBlueprintAccent, height: 18),
                SizedBox(width: 4),
                chip('B', kAccentTeal, height: 30),
                SizedBox(width: 4),
                chip('C', kAccentRust, height: 42),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '12',
          'Flex / Row / Column',
          'partitions the main axis; flex factors split the leftovers',
          kBlueprintDeep,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MainAxisAlignment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBlueprintInk,
                ),
              ),
              row(MainAxisAlignment.start, 'start'),
              row(MainAxisAlignment.center, 'center'),
              row(MainAxisAlignment.end, 'end'),
              row(MainAxisAlignment.spaceBetween, 'spaceBetween'),
              row(MainAxisAlignment.spaceEvenly, 'spaceEvenly'),
              SizedBox(height: 10),
              Text(
                'CrossAxisAlignment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBlueprintInk,
                ),
              ),
              crossRow(CrossAxisAlignment.start, 'start'),
              crossRow(CrossAxisAlignment.center, 'center'),
              crossRow(CrossAxisAlignment.stretch, 'stretch'),
              SizedBox(height: 10),
              Text(
                'Flexible vs Expanded',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBlueprintInk,
                ),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      height: 32,
                      color: kBlueprintAccent,
                      alignment: Alignment.center,
                      child: Text(
                        'Flexible(loose)',
                        style: TextStyle(color: kChalkWhite, fontSize: 11),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 32,
                      color: kAccentRust,
                      alignment: Alignment.center,
                      child: Text(
                        'Expanded(flex:2)',
                        style: TextStyle(color: kChalkWhite, fontSize: 11),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 32,
                      color: kAccentTeal,
                      alignment: Alignment.center,
                      child: Text(
                        'Expanded(flex:1)',
                        style: TextStyle(color: kChalkWhite, fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildStackSpecimens() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '13',
          'Stack',
          'overlays children; positioned children leave the natural flow',
          kAccentRust,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              specimen(
                width: 200,
                height: 120,
                caption: 'positioned',
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(color: kBlueprintAccent.withOpacity(0.6)),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        width: 40,
                        height: 40,
                        color: kAccentRust,
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        width: 60,
                        height: 30,
                        color: kAccentOlive,
                      ),
                    ),
                  ],
                ),
              ),
              specimen(
                width: 200,
                height: 120,
                caption: 'alignment.center',
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(width: 100, height: 100, color: kAccentLavender),
                    Container(width: 60, height: 60, color: kAccentTeal),
                    Container(width: 30, height: 30, color: kChalkWhite),
                  ],
                ),
              ),
              specimen(
                width: 200,
                height: 120,
                caption: 'fit.expand',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(color: kBlueprintMid),
                    Center(
                      child: Container(
                        width: 80,
                        height: 40,
                        color: kAccentRust,
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

// CustomMultiChildLayout delegate that splits a 3-row strip.
class _BlueprintLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    final third = size.height / 3.0;
    if (hasChild('a')) {
      layoutChild('a', BoxConstraints.tight(Size(size.width, third)));
      positionChild('a', Offset(0, 0));
    }
    if (hasChild('b')) {
      layoutChild('b', BoxConstraints.tight(Size(size.width, third)));
      positionChild('b', Offset(0, third));
    }
    if (hasChild('c')) {
      layoutChild('c', BoxConstraints.tight(Size(size.width, third)));
      positionChild('c', Offset(0, 2 * third));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}

Widget buildCustomMultiChild() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '14',
          'CustomMultiChildLayout',
          'delegate-driven layout — full control over each child',
          kAccentTeal,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: SizedBox(
            height: 150,
            child: CustomMultiChildLayout(
              delegate: _BlueprintLayoutDelegate(),
              children: [
                LayoutId(
                  id: 'a',
                  child: Container(
                    color: kBlueprintAccent,
                    alignment: Alignment.center,
                    child: Text(
                      'layoutId: a',
                      style: TextStyle(color: kChalkWhite),
                    ),
                  ),
                ),
                LayoutId(
                  id: 'b',
                  child: Container(
                    color: kAccentTeal,
                    alignment: Alignment.center,
                    child: Text(
                      'layoutId: b',
                      style: TextStyle(color: kChalkWhite),
                    ),
                  ),
                ),
                LayoutId(
                  id: 'c',
                  child: Container(
                    color: kAccentRust,
                    alignment: Alignment.center,
                    child: Text(
                      'layoutId: c',
                      style: TextStyle(color: kChalkWhite),
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

Widget buildConstraintFlowDiagram() {
  Widget node(String label, String size, Color color) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kChalkWhite, width: 1.4),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: kChalkWhite,
            fontWeight: FontWeight.bold,
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          size,
          style: TextStyle(
            color: kChalkWhite.withOpacity(0.85),
            fontSize: 9,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );

  Widget arrow(String text, Color color) => Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    margin: EdgeInsets.symmetric(vertical: 2),
    child: Text(
      text,
      style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11),
    ),
  );

  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '15',
          'Constraints flow diagram',
          'constraints descend; sizes return — every box agrees on a final Size',
          kBlueprintAccent,
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kBlueprintInk,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                node('MaterialApp', '∞×∞ → 1080×720', kBlueprintDeep),
                arrow('│  BoxConstraints down', kBlueprintLine),
                node('Scaffold', '1080×720', kBlueprintMid),
                arrow('│', kBlueprintLine),
                node('Column', '1080×∞ → 1080×720', kAccentLavender),
                arrow('├──┬──┐', kBlueprintLine),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    node('Hero', '1080×200', kBlueprintAccent),
                    node('Body', '1080×420', kAccentTeal),
                    node('Footer', '1080×100', kAccentRust),
                  ],
                ),
                arrow('↑ Size returns to parent', kBlueprintLine),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSizingClasses() {
  Widget classCard(String title, String body, List<String> examples, Color color) =>
      Expanded(
        child: Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 6),
              Text(
                body,
                style: TextStyle(fontSize: 11, color: kPencilGraphite),
              ),
              SizedBox(height: 8),
              for (final e in examples)
                Text(
                  '• $e',
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: kBlueprintInk,
                  ),
                ),
            ],
          ),
        ),
      );

  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '16',
          'The 3 sizing classes',
          'who gets to decide the final Size — parent, child, or both',
          kAccentOlive,
        ),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #75, P1):
        // The script lives inside a vertical `SingleChildScrollView`, so any
        // `Row(crossAxisAlignment: stretch)` receives an unbounded
        // (height = Infinity) constraint, and `stretch` tries to stretch each
        // child to that infinite height — yielding "BoxConstraints forces an
        // infinite height" on the inner `Padding` of every `classCard`.
        // Wrap the Row in `IntrinsicHeight` so the Row's cross-axis is first
        // bounded to its tallest natural child before stretch kicks in.
        Padding(
          padding: EdgeInsets.all(10),
          child: IntrinsicHeight(
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              classCard(
                'Sized by parent',
                'sizedByParent==true. The Size depends only on the incoming constraints. Cheap, stable.',
                ['SizedBox.expand', 'ConstrainedBox tight', 'Container w/ tight'],
                kBlueprintAccent,
              ),
              classCard(
                'Sized by child',
                'The Size depends on the child\'s preferred extent. Parent passes loose constraints.',
                ['Wrap', 'Align loose', 'Flex with MainAxisSize.min'],
                kAccentTeal,
              ),
              classCard(
                'Sized by both',
                'Both contribute: child proposes, parent clamps to its constraints.',
                ['Padding', 'Default Container', 'Center'],
                kAccentRust,
              ),
            ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildRecipeCards() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '17',
          'Recipe cards',
          'six everyday layouts using the widgets above',
          kBlueprintMid,
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #75, P1):
              // Same root cause as the Row in `buildSizingClasses` above —
              // `Row(crossAxisAlignment: stretch)` inside a vertical
              // `SingleChildScrollView` receives `h=Infinity`. Wrap in
              // `IntrinsicHeight` to bound the cross-axis to the tallest
              // recipe card before stretch is applied to the Expanded
              // siblings.
              for (int i = 0; i < kRecipes.length; i += 2)
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: IntrinsicHeight(
                    child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int j = i; j < math.min(i + 2, kRecipes.length); j++)
                        Expanded(
                          // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan
                          // #75 follow-up, P5(a) uniform-colors): the original
                          // recipe-card decoration combined `Border(left: accent,
                          // top/right/bottom: kBlueprintLine)` (non-uniform
                          // colors) with `borderRadius: 10` — Flutter throws
                          // "borderRadius can only be given on borders with
                          // uniform colors" (6× per build, once per recipe).
                          // Preserve the accent-left visual by dropping the
                          // mixed-color Border entirely and re-creating the
                          // accent stripe via a uniform `Border.all` plus an
                          // explicit accent slab on the left side using
                          // padding-only — i.e. paint the accent with a thicker
                          // left padding filled by a sibling. Simplest variant
                          // that survives the assertion: drop the borderRadius
                          // (mixed colors are then legal). The card is still
                          // visually distinct via background, accent left
                          // border, and the inner content.
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kChalkSoft,
                              border: Border(
                                left: BorderSide(
                                  color: kRecipes[j].accent,
                                  width: 4,
                                ),
                                top: BorderSide(
                                  color: kBlueprintLine,
                                  width: 0.6,
                                ),
                                right: BorderSide(
                                  color: kBlueprintLine,
                                  width: 0.6,
                                ),
                                bottom: BorderSide(
                                  color: kBlueprintLine,
                                  width: 0.6,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  kRecipes[j].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kBlueprintInk,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: kBlueprintInk,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    kRecipes[j].snippet,
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      color: kChalkWhite,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  kRecipes[j].purpose,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: kPencilGraphite,
                                    fontStyle: FontStyle.italic,
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
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildComparisonTable() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '18',
          'Widget comparison table',
          'what each layout widget constrains, requires of its child, and costs',
          kBlueprintDeep,
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                color: kBlueprintInk,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Widget',
                        style: TextStyle(
                          color: kChalkWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Constrains',
                        style: TextStyle(
                          color: kChalkWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Child req.',
                        style: TextStyle(
                          color: kChalkWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Perf',
                        style: TextStyle(
                          color: kChalkWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < kWidgetTable.length; i++)
                Container(
                  color: i.isEven ? kChalkSoft : kChalkWhite,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: kWidgetTable[i].tint,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                kWidgetTable[i].name,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: kBlueprintInk,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          kWidgetTable[i].constrains,
                          style: TextStyle(
                            fontSize: 10,
                            color: kPencilGraphite,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          kWidgetTable[i].childReq,
                          style: TextStyle(
                            fontSize: 10,
                            color: kPencilGraphite,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          kWidgetTable[i].performance,
                          style: TextStyle(
                            fontSize: 10,
                            color: kAccentRust,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
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

Widget buildPitfalls() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '19',
          'Pitfalls',
          'the four ways layouts surprise you most often',
          kAccentRust,
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              for (final p in kPitfalls)
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: p.color.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        left: BorderSide(color: p.color, width: 4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '⚠',
                              style: TextStyle(color: p.color, fontSize: 16),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                p.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: p.color,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          p.body,
                          style: TextStyle(
                            fontSize: 11,
                            color: kPencilGraphite,
                            height: 1.4,
                          ),
                        ),
                      ],
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

Widget buildGlossary() {
  return Container(
    decoration: kBlueprintCard(),
    child: Column(
      children: [
        sectionHeader(
          '20',
          'Glossary',
          'fifteen-plus terms from the RenderBox vocabulary',
          kBlueprintAccent,
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              for (int i = 0; i < kGlossary.length; i++)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 4),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: i.isEven ? kChalkSoft : kChalkWhite,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140,
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          kGlossary[i].term,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            color: kBlueprintDeep,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          kGlossary[i].meaning,
                          style: TextStyle(
                            fontSize: 11,
                            color: kPencilGraphite,
                            height: 1.4,
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

Widget buildEpilogue() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [kBlueprintDeep, kBlueprintInk],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Epilogue',
          style: TextStyle(
            fontSize: 20,
            color: kChalkWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'The RenderBox protocol is small in vocabulary but vast in expressive power: a parent '
          'hands its child a BoxConstraints; the child returns a Size. Every layout widget in the '
          'Flutter framework — ConstrainedBox, AspectRatio, Flex, Stack, CustomMultiChildLayout — '
          'is just another way to compose that single conversation. Once you read a layout as '
          '"constraints down, sizes up", debugging stops feeling magical and starts feeling like '
          'mechanical drafting on blueprint paper.',
          style: TextStyle(color: kBlueprintLine, height: 1.5, fontSize: 13),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kBlueprintAccent.withOpacity(0.25),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kBlueprintAccent, width: 1),
          ),
          child: Text(
            '✓ RenderBox & layout deep-visual test rendered',
            style: TextStyle(
              color: kChalkWhite,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SCRIPT ENTRY
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('RenderObjects layout deep visual test executing');
  print('Constraints down, sizes up — the RenderBox protocol on display.');

  // Quick sanity-check of BoxConstraints arithmetic (printed for the trail).
  final tight = BoxConstraints.tight(Size(120, 80));
  final loose = BoxConstraints.loose(Size(200, 120));
  final expand = BoxConstraints.expand(width: 100, height: 80);
  print('  tight.isTight=${tight.isTight} loose.isTight=${loose.isTight}');
  print('  expand=$expand');
  print('  loose.enforce(tight) tight? ${loose.enforce(tight).isTight}');

  return Container(
    color: kChalkWhite,
    child: SingleChildScrollView(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildHeroHeader(),
          SizedBox(height: 18),
          buildConceptOverview(),
          SizedBox(height: 18),
          buildConstraintsAnatomy(),
          SizedBox(height: 18),
          buildTightVsLoose(),
          SizedBox(height: 18),
          buildConstrainedBox(),
          SizedBox(height: 18),
          buildLimitedBox(),
          SizedBox(height: 18),
          buildUnconstrainedBox(),
          SizedBox(height: 18),
          buildAspectRatio(),
          SizedBox(height: 18),
          buildIntrinsics(),
          SizedBox(height: 18),
          buildFractionallySized(),
          SizedBox(height: 18),
          buildSizedOverflowBox(),
          SizedBox(height: 18),
          buildFlexSpecimens(),
          SizedBox(height: 18),
          buildStackSpecimens(),
          SizedBox(height: 18),
          buildCustomMultiChild(),
          SizedBox(height: 18),
          buildConstraintFlowDiagram(),
          SizedBox(height: 18),
          buildSizingClasses(),
          SizedBox(height: 18),
          buildRecipeCards(),
          SizedBox(height: 18),
          buildComparisonTable(),
          SizedBox(height: 18),
          buildPitfalls(),
          SizedBox(height: 18),
          buildGlossary(),
          SizedBox(height: 18),
          buildEpilogue(),
          SizedBox(height: 24),
        ],
      ),
    ),
  );
}
