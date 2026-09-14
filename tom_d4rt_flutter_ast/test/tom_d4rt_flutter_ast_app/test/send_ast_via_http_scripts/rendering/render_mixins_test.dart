// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Visual Demo - RenderObject Mixin Gallery
// Profiles RenderObjectWithChildMixin, ContainerRenderObjectMixin,
// RenderProxyBoxMixin, RenderProxySliverMixin, RenderObjectWithLayoutCallbackMixin,
// RenderInlineChildrenContainerDefaults, RenderSemanticsAnnotations,
// RenderSemanticsGestureHandler, DebugCreator, RenderTreeRootElement,
// RootElementMixin and the ParentData family.
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ============================================================================
// PALETTE - deep violet / molten orange / parchment
// ============================================================================

const Color kInk = Color(0xFF1B0E2C);
const Color kVioletDeep = Color(0xFF3B1F62);
const Color kVioletMid = Color(0xFF5A2EA6);
const Color kVioletSoft = Color(0xFFE9DFFB);
const Color kVioletGlow = Color(0xFFB69BE8);
const Color kOrangeMolten = Color(0xFFE85A14);
const Color kOrangeWarm = Color(0xFFF59348);
const Color kOrangeGlow = Color(0xFFFCD7BB);
const Color kAmber = Color(0xFFF7B538);
const Color kParchment = Color(0xFFFBF6EC);
const Color kParchmentMid = Color(0xFFEFE5D2);
const Color kParchmentEdge = Color(0xFFD9C9A7);
const Color kCharcoal = Color(0xFF34263A);
const Color kCharcoalSoft = Color(0xFF6B5A75);
const Color kMintCool = Color(0xFFB6E2C7);
const Color kMintDeep = Color(0xFF1F7A4F);
const Color kCrimson = Color(0xFF8E1A3D);

// ============================================================================
// SMALL MODEL HELPERS - mixin profile descriptor
// ============================================================================

Map<String, dynamic> mixinProfile({
  required String name,
  required String generics,
  required String purpose,
  required String arity,
  required String parentData,
  required List<String> provides,
  required List<String> consumers,
  required List<String> keyMethods,
}) {
  return <String, dynamic>{
    'name': name,
    'generics': generics,
    'purpose': purpose,
    'arity': arity,
    'parentData': parentData,
    'provides': provides,
    'consumers': consumers,
    'keyMethods': keyMethods,
  };
}

// ============================================================================
// BADGE BUILDER - hexagonal badge motif (approximated by rotated rounded box)
// ============================================================================

Widget hexBadge({required String label, required Color color, double size = 56.0}) {
  return SizedBox(
    width: size,
    height: size,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: math.pi / 6,
          child: Container(
            width: size * 0.85,
            height: size * 0.85,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.35),
                  blurRadius: 8.0,
                  offset: Offset(0.0, 3.0),
                ),
              ],
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// ============================================================================
// CARD CHROME
// ============================================================================

Widget anatomyCard({
  required String index,
  required String title,
  required String subtitle,
  required Color accent,
  required Widget body,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 24.0),
    decoration: BoxDecoration(
      color: kParchment,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kParchmentEdge, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: kInk.withOpacity(0.06),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent, accent.withOpacity(0.78)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17.0),
              topRight: Radius.circular(17.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  index,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Color(0xFFF6ECFB),
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: body,
        ),
      ],
    ),
  );
}

Widget sectionLabel(String text, Color color) {
  return Padding(
    padding: EdgeInsets.only(top: 6.0, bottom: 8.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 16.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            color: kCharcoal,
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ],
    ),
  );
}

Widget bulletRow(String text, {Color color = kVioletMid}) {
  return Padding(
    padding: EdgeInsets.only(left: 12.0, top: 3.0, bottom: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6.0, right: 8.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: kCharcoal,
              fontSize: 13.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget specimenFrame({required String label, required Widget child, Color accent = kOrangeMolten}) {
  return Container(
    margin: EdgeInsets.only(top: 12.0, bottom: 4.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kParchmentEdge, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.12),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11.0),
              topRight: Radius.circular(11.0),
            ),
            border: Border(
              bottom: BorderSide(color: accent.withOpacity(0.35)),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.science_outlined, size: 14.0, color: accent),
              SizedBox(width: 6.0),
              Text(
                label,
                style: TextStyle(
                  color: accent,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: child,
        ),
      ],
    ),
  );
}

Widget codeBlock(String text, {Color background = kInk}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: kOrangeGlow,
        fontFamily: 'monospace',
        fontSize: 11.5,
        height: 1.45,
      ),
    ),
  );
}

// ============================================================================
// MIXIN PROFILE TABLE BUILDER
// ============================================================================

Widget profileTable(Map<String, dynamic> profile) {
  final rows = <List<String>>[
    <String>['type parameters', profile['generics'] as String],
    <String>['child arity', profile['arity'] as String],
    <String>['ParentData', profile['parentData'] as String],
  ];
  return Container(
    decoration: BoxDecoration(
      color: kParchmentMid,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      children: <Widget>[
        for (int i = 0; i < rows.length; i += 1)
          Container(
            decoration: BoxDecoration(
              border: i == rows.length - 1
                  ? null
                  : Border(
                      bottom: BorderSide(color: kParchmentEdge, width: 1.0),
                    ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    rows[i][0],
                    style: TextStyle(
                      color: kVioletMid,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    rows[i][1],
                    style: TextStyle(
                      color: kCharcoal,
                      fontSize: 12.5,
                      fontFamily: 'monospace',
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

// ============================================================================
// TREE DIAGRAM BUILDER
// ============================================================================

Widget treeNode(String label, Color color, {bool isMixin = false, double width = 200.0}) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: isMixin ? color.withOpacity(0.18) : color,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.4),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          isMixin ? Icons.hexagon_outlined : Icons.account_tree_outlined,
          size: 14.0,
          color: isMixin ? color : Color(0xFFFFFFFF),
        ),
        SizedBox(width: 6.0),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              color: isMixin ? color : Color(0xFFFFFFFF),
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget treeConnector({double height = 14.0, Color color = kCharcoalSoft}) {
  return Container(
    width: 2.0,
    height: height,
    color: color,
  );
}

// ============================================================================
// build entry point
// ============================================================================

dynamic build(BuildContext context) {
  // --------------------------------------------------------------------------
  // STATIC DATA -- profiles for the seven main mixins
  // --------------------------------------------------------------------------

  final mixinProfiles = <Map<String, dynamic>>[
    mixinProfile(
      name: 'RenderObjectWithChildMixin',
      generics: '<ChildType extends RenderObject>',
      purpose: 'Adds a single-child slot to a RenderObject with proper attach/detach plumbing.',
      arity: 'exactly one child (nullable)',
      parentData: 'ParentData (whatever the child needs)',
      provides: <String>[
        'child getter/setter that handles attach/detach',
        'visitChildren(visitor) over the single slot',
        'redepthChildren / debugDescribeChildren wiring',
      ],
      consumers: <String>[
        'RenderProxyBox (via subclassing)',
        'RenderDecoratedBox',
        'RenderTransform',
        'RenderConstrainedBox',
      ],
      keyMethods: <String>['attach(owner)', 'detach()', 'visitChildren', 'redepthChildren'],
    ),
    mixinProfile(
      name: 'ContainerRenderObjectMixin',
      generics: '<ChildType extends RenderObject, ParentDataType extends ContainerParentDataMixin<ChildType>>',
      purpose: 'Maintains an intrusive doubly-linked list of children stored inside each child\'s ParentData.',
      arity: 'zero or more children',
      parentData: 'ContainerParentDataMixin<ChildType>',
      provides: <String>[
        'insert / remove / move operations on the child list',
        'firstChild / lastChild / childCount getters',
        'childBefore / childAfter walk via ParentData',
        'attach/detach iterating every child',
      ],
      consumers: <String>[
        'RenderFlex (Row, Column) with FlexParentData',
        'RenderStack with StackParentData',
        'RenderWrap, RenderListBody',
        'RenderSliverList / RenderSliverGrid',
      ],
      keyMethods: <String>['insert', 'remove', 'move', 'childBefore', 'childAfter'],
    ),
    mixinProfile(
      name: 'RenderProxyBoxMixin',
      generics: '<T extends RenderBox>',
      purpose: 'Forwards layout, paint and hit-test to a single RenderBox child verbatim.',
      arity: 'exactly one RenderBox child',
      parentData: 'BoxParentData',
      provides: <String>[
        'computeMinIntrinsicWidth/Height delegated to child',
        'performLayout sizes self to child.size',
        'paint() that paints the child as-is',
        'hitTest delegated to the child',
      ],
      consumers: <String>[
        'RenderOpacity, RenderAnimatedOpacity',
        'RenderColoredBox, RenderClipRect',
        'RenderIgnorePointer, RenderAbsorbPointer',
        'RenderFractionallySizedOverflowBox',
      ],
      keyMethods: <String>['performLayout', 'paint', 'hitTestChildren'],
    ),
    mixinProfile(
      name: 'RenderProxySliverMixin',
      generics: '<T extends RenderSliver>',
      purpose: 'Sliver counterpart to RenderProxyBoxMixin -- delegates geometry to a single sliver child.',
      arity: 'exactly one RenderSliver child',
      parentData: 'SliverPhysicalParentData',
      provides: <String>[
        'performLayout copies child.geometry',
        'paint forwards to child',
        'hitTestChildren via sliver hit-test protocol',
        'applyPaintTransform with sliver offset',
      ],
      consumers: <String>[
        'RenderSliverOpacity',
        'RenderSliverIgnorePointer',
        'RenderSliverAnimatedOpacity',
        'RenderSliverOffstage',
      ],
      keyMethods: <String>['performLayout', 'paint', 'hitTestChildren', 'applyPaintTransform'],
    ),
    mixinProfile(
      name: 'RenderObjectWithLayoutCallbackMixin',
      generics: '<T extends Constraints>',
      purpose: 'Marks a RenderObject as supporting a callback-driven layout pass (LayoutBuilder style).',
      arity: 'depends on host class',
      parentData: 'inherited from host',
      provides: <String>[
        'invokeLayoutCallback<T>(callback) inside performLayout',
        'safe re-entry guard for build during layout',
        'allows building widgets after parent constraints are known',
      ],
      consumers: <String>[
        'RenderConstrainedLayoutBuilder',
        'RenderSliverLayoutBuilder',
        '_RenderTwoDimensionalViewport (lazy lists)',
      ],
      keyMethods: <String>['invokeLayoutCallback', 'performLayout', 'markNeedsBuild'],
    ),
    mixinProfile(
      name: 'RenderInlineChildrenContainerDefaults',
      generics: '<ChildType extends RenderBox, ParentDataType extends TextParentData>',
      purpose: 'Provides default inline child placement logic for RenderParagraph-like objects (WidgetSpans).',
      arity: 'zero or more inline children',
      parentData: 'TextParentData (offset + scale + placeholder index)',
      provides: <String>[
        'computeChildrenWidthAsMax / Sum helpers',
        'positionInlineChildren walk',
        'paintInlineChildren / hitTestInlineChildren',
        'computeChildrenBaseline support',
      ],
      consumers: <String>[
        'RenderParagraph (WidgetSpan placement)',
        'Custom inline text render objects',
      ],
      keyMethods: <String>['positionInlineChildren', 'paintInlineChildren', 'hitTestInlineChildren'],
    ),
    mixinProfile(
      name: 'RenderSemanticsAnnotations',
      generics: '<no generics>',
      purpose: 'Injects SemanticsConfiguration into the semantics tree without affecting layout/paint.',
      arity: 'single child (delegating)',
      parentData: 'BoxParentData',
      provides: <String>[
        'describeSemanticsConfiguration with labels, hints, values',
        'flags toggling (button, header, image, link, ...)',
        'actions (onTap, onLongPress, onScrollUp, ...)',
        'merge/exclude behaviour',
      ],
      consumers: <String>[
        'RenderSemanticsAnnotations directly (via Semantics widget)',
        'RenderMergeSemantics, RenderBlockSemantics',
        'RenderExcludeSemantics',
      ],
      keyMethods: <String>['describeSemanticsConfiguration', 'markNeedsSemanticsUpdate'],
    ),
  ];

  // --------------------------------------------------------------------------
  // SUMMARY ROWS for the comparison table
  // --------------------------------------------------------------------------

  final comparisonRows = <List<String>>[
    <String>['Mixin', 'Purpose', 'Arity', 'ParentData', 'Consumer'],
    <String>['RenderObjectWithChildMixin', 'single child slot', '1', 'ParentData', 'RenderProxyBox*'],
    <String>['ContainerRenderObjectMixin', 'linked-list children', '0..n', 'ContainerParentDataMixin', 'RenderFlex'],
    <String>['RenderProxyBoxMixin', 'forward to child', '1', 'BoxParentData', 'RenderOpacity'],
    <String>['RenderProxySliverMixin', 'forward sliver to child', '1', 'SliverPhysicalParentData', 'RenderSliverOpacity'],
    <String>['RenderObjectWithLayoutCallbackMixin', 'callback layout', 'host-defined', 'host-defined', 'RenderConstrainedLayoutBuilder'],
    <String>['RenderInlineChildrenContainerDefaults', 'inline placeholders', '0..n', 'TextParentData', 'RenderParagraph'],
    <String>['RenderSemanticsAnnotations', 'semantics injection', '1', 'BoxParentData', 'Semantics widget'],
    <String>['DebugOverflowIndicatorMixin', 'debug overflow paint', 'host-defined', 'host-defined', 'RenderFlex'],
  ];

  // --------------------------------------------------------------------------
  // PARENT DATA family
  // --------------------------------------------------------------------------

  final parentDataFamily = <Map<String, String>>[
    <String, String>{
      'name': 'ParentData',
      'addsWhat': 'base marker class; storage slot owned by the parent render object',
      'usedBy': 'any RenderObject',
    },
    <String, String>{
      'name': 'BoxParentData',
      'addsWhat': 'Offset offset -- where the child is positioned relative to the parent box',
      'usedBy': 'RenderBox descendants',
    },
    <String, String>{
      'name': 'ContainerBoxParentData<ChildType>',
      'addsWhat': 'doubly-linked list pointers (previousSibling / nextSibling) plus BoxParentData fields',
      'usedBy': 'multi-child box render objects',
    },
    <String, String>{
      'name': 'FlexParentData',
      'addsWhat': 'flex factor + FlexFit for Expanded/Flexible children',
      'usedBy': 'RenderFlex (Row, Column)',
    },
    <String, String>{
      'name': 'StackParentData',
      'addsWhat': 'top/right/bottom/left, width, height, plus positioned flag',
      'usedBy': 'RenderStack',
    },
    <String, String>{
      'name': 'TextParentData',
      'addsWhat': 'inline offset + textScale + placeholderIndex for WidgetSpan',
      'usedBy': 'RenderParagraph',
    },
    <String, String>{
      'name': 'SliverPhysicalParentData',
      'addsWhat': 'Offset paintOffset for sliver children',
      'usedBy': 'sliver render objects',
    },
    <String, String>{
      'name': 'SliverLogicalParentData',
      'addsWhat': 'double layoutOffset for sliver children',
      'usedBy': 'logical sliver layouts',
    },
  ];

  // --------------------------------------------------------------------------
  // GLOSSARY
  // --------------------------------------------------------------------------

  final glossary = <Map<String, String>>[
    <String, String>{'term': 'RenderObject', 'def': 'Element in the render tree responsible for layout, paint, hit-test, semantics.'},
    <String, String>{'term': 'RenderBox', 'def': 'RenderObject that uses Cartesian (x,y, width, height) constraints.'},
    <String, String>{'term': 'RenderSliver', 'def': 'RenderObject for scrollable viewport children using SliverConstraints/SliverGeometry.'},
    <String, String>{'term': 'mixin', 'def': 'Dart construct that contributes fields and methods to a class via with-clause.'},
    <String, String>{'term': 'ParentData', 'def': 'Opaque storage that a parent RenderObject hangs off each child.'},
    <String, String>{'term': 'parentData walk', 'def': 'Walking children via parentData.nextSibling / previousSibling pointers.'},
    <String, String>{'term': 'attach', 'def': 'Called when a RenderObject becomes part of a tree owned by a PipelineOwner.'},
    <String, String>{'term': 'detach', 'def': 'Inverse of attach; clears the owner and dispatches to children.'},
    <String, String>{'term': 'markNeedsLayout', 'def': 'Schedules this RenderObject for re-layout in the next frame.'},
    <String, String>{'term': 'markNeedsPaint', 'def': 'Schedules a paint pass without forcing layout.'},
    <String, String>{'term': 'performLayout', 'def': 'Implementation hook where a RenderObject sizes itself and its children.'},
    <String, String>{'term': 'paint', 'def': 'Implementation hook that records painting onto the supplied PaintingContext.'},
    <String, String>{'term': 'hitTest', 'def': 'Implementation hook that maps a position to RenderObjects under the pointer.'},
    <String, String>{'term': 'LayoutCallback', 'def': 'Callback invoked during performLayout when build needs constraints first.'},
    <String, String>{'term': 'SemanticsConfiguration', 'def': 'Bag of flags/labels/actions describing a RenderObject for accessibility.'},
    <String, String>{'term': 'DebugCreator', 'def': 'Wrapper object attached to a RenderObject linking back to its creating Element.'},
    <String, String>{'term': 'RenderTreeRootElement', 'def': 'Marker mixin for elements that introduce a new render tree root.'},
    <String, String>{'term': 'RootElementMixin', 'def': 'Mixin that hosts a detached render tree (used by RenderObjectToWidgetAdapter).'},
  ];

  // --------------------------------------------------------------------------
  // PITFALLS
  // --------------------------------------------------------------------------

  final pitfalls = <Map<String, String>>[
    <String, String>{
      'mistake': 'Forgetting to call super.attach(owner) / super.detach()',
      'why': 'ContainerRenderObjectMixin iterates children inside its attach/detach. Skipping super leaves children with a stale owner.',
    },
    <String, String>{
      'mistake': 'Not redeclaring covariant child type',
      'why': 'RenderObjectWithChildMixin<RenderBox> exposes RenderObject getters by default; without covariant, subclasses cannot tighten the API.',
    },
    <String, String>{
      'mistake': 'ContainerRenderObjectMixin with the wrong ParentData type',
      'why': 'setupParentData must produce a ContainerParentDataMixin or the linked-list walk crashes with type errors.',
    },
    <String, String>{
      'mistake': 'Calling markNeedsBuild outside invokeLayoutCallback',
      'why': 'Only RenderObjectWithLayoutCallbackMixin lets the framework rebuild widgets safely while layout is in flight.',
    },
    <String, String>{
      'mistake': 'Mutating SemanticsConfiguration without markNeedsSemanticsUpdate',
      'why': 'RenderSemanticsAnnotations caches the previous config; without the mark, accessibility services see stale data.',
    },
    <String, String>{
      'mistake': 'Confusing RenderProxyBoxMixin with subclassing RenderProxyBox',
      'why': 'The mixin provides defaults; the class adds RenderBox inheritance. Use the mixin only when you already extend a RenderBox base.',
    },
  ];

  // --------------------------------------------------------------------------
  // RECIPES
  // --------------------------------------------------------------------------

  final recipes = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Single-child wrapper that paints',
      'mixins': <String>['RenderObjectWithChildMixin', 'RenderProxyBoxMixin'],
      'snippet': 'class _MyPaintBox extends RenderBox with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin<RenderBox> {\n  @override\n  void paint(PaintingContext c, Offset o) {\n    // ... custom paint ...\n    super.paint(c, o); // forwards to child\n  }\n}',
    },
    <String, dynamic>{
      'title': 'Multi-child container with parent data',
      'mixins': <String>['ContainerRenderObjectMixin'],
      'snippet': 'class _MyRow extends RenderBox\n    with ContainerRenderObjectMixin<RenderBox, FlexParentData> {\n  @override\n  void setupParentData(RenderBox child) {\n    if (child.parentData is! FlexParentData) {\n      child.parentData = FlexParentData();\n    }\n  }\n}',
    },
    <String, dynamic>{
      'title': 'Proxy box with hit-test override',
      'mixins': <String>['RenderProxyBoxMixin'],
      'snippet': 'class _ConditionalHit extends RenderProxyBox {\n  bool absorbing = false;\n  @override\n  bool hitTest(BoxHitTestResult r, { required Offset position }) {\n    return absorbing ? false : super.hitTest(r, position: position);\n  }\n}',
    },
    <String, dynamic>{
      'title': 'Layout-aware UI via LayoutBuilder',
      'mixins': <String>['RenderObjectWithLayoutCallbackMixin'],
      'snippet': 'LayoutBuilder(\n  builder: (ctx, c) => c.maxWidth < 400\n      ? Column(children: cards)\n      : Row(children: cards),\n);',
    },
    <String, dynamic>{
      'title': 'Semantically-annotated card',
      'mixins': <String>['RenderSemanticsAnnotations'],
      'snippet': 'Semantics(\n  label: \'Important card\',\n  hint: \'Tap to expand\',\n  button: true,\n  child: card,\n);',
    },
    <String, dynamic>{
      'title': 'Container with custom paint via mixin',
      'mixins': <String>['ContainerRenderObjectMixin', 'DebugOverflowIndicatorMixin'],
      'snippet': 'class _DebugColumn extends RenderBox\n    with ContainerRenderObjectMixin<RenderBox, FlexParentData>,\n         DebugOverflowIndicatorMixin {\n  @override\n  void performLayout() { /* walk children, set parentData.offset */ }\n}',
    },
  ];

  // --------------------------------------------------------------------------
  // ASSEMBLED ROOT
  // --------------------------------------------------------------------------

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // ================================================================
          // HERO HEADER
          // ================================================================
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[kInk, kVioletDeep, kVioletMid],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: kVioletDeep.withOpacity(0.4),
                  blurRadius: 24.0,
                  offset: Offset(0.0, 12.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    hexBadge(label: 'mixin', color: kOrangeMolten, size: 64.0),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'RenderObject mixins',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'the modular contracts of the render tree',
                            style: TextStyle(
                              color: kVioletGlow,
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: <Widget>[
                    for (final p in mixinProfiles)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Color(0x22FFFFFF),
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(color: Color(0x33FFFFFF)),
                        ),
                        child: Text(
                          p['name'] as String,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 28.0),

          // ================================================================
          // 1. CONCEPT OVERVIEW
          // ================================================================
          anatomyCard(
            index: '01',
            title: 'What mixins do in Dart',
            subtitle: 'Reusable behaviour contracts attached without single inheritance.',
            accent: kVioletMid,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Dart\'s mixin system lets a class compose behaviour from multiple sources without '
                  'classical multiple inheritance. A class declared with the mixin keyword can be applied '
                  'via the with clause: class RenderFlex extends RenderBox with ContainerRenderObjectMixin<...>, '
                  'DebugOverflowIndicatorMixin.',
                  style: TextStyle(color: kCharcoal, fontSize: 13.5, height: 1.55),
                ),
                SizedBox(height: 14.0),
                sectionLabel('Why the render tree relies on mixins', kVioletMid),
                bulletRow('Most RenderObject contracts are orthogonal: child slots, parent data, semantics, debug overflow.'),
                bulletRow('Concrete classes pick exactly the combination they need: RenderFlex needs containers AND debug overflow; RenderOpacity needs proxy behaviour AND a single child slot.'),
                bulletRow('Mixins let the framework avoid a combinatorial explosion of base classes (RenderBoxWithChildAndDebugOverflow...) by composing instead.'),
                bulletRow('Generic mixins ensure type-safe child slots: RenderObjectWithChildMixin<RenderBox> versus RenderObjectWithChildMixin<RenderSliver>.'),
                SizedBox(height: 14.0),
                sectionLabel('Relationship to RenderObject base classes', kOrangeMolten),
                codeBlock(
                  'abstract class RenderObject extends AbstractNode\n'
                  '    with DiagnosticableTreeMixin\n'
                  '    implements HitTestTarget {\n'
                  '  // layout, paint, hit-test, semantics protocols ...\n'
                  '}\n\n'
                  'abstract class RenderBox extends RenderObject {\n'
                  '  // box constraints, baseline, size ...\n'
                  '}\n\n'
                  'class RenderFlex extends RenderBox\n'
                  '    with ContainerRenderObjectMixin<RenderBox, FlexParentData>,\n'
                  '         RenderBoxContainerDefaultsMixin<RenderBox, FlexParentData>,\n'
                  '         DebugOverflowIndicatorMixin {\n'
                  '  // flex specifics only\n'
                  '}',
                ),
              ],
            ),
          ),

          // ================================================================
          // 2. MASTER MOLECULE DIAGRAM
          // ================================================================
          anatomyCard(
            index: '02',
            title: 'Master diagram',
            subtitle: 'RenderObject as the trunk with mixin branches.',
            accent: kOrangeMolten,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                treeNode('RenderObject', kInk),
                treeConnector(),
                treeNode('RenderBox / RenderSliver', kVioletDeep, width: 240.0),
                treeConnector(),
                Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: kParchmentMid,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: kParchmentEdge),
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 18.0,
                    runSpacing: 18.0,
                    children: <Widget>[
                      hexBadge(label: 'ChildMixin', color: kVioletMid),
                      hexBadge(label: 'Container', color: kOrangeMolten),
                      hexBadge(label: 'ProxyBox', color: kAmber),
                      hexBadge(label: 'ProxySliver', color: kMintDeep),
                      hexBadge(label: 'LayoutCb', color: kCrimson),
                      hexBadge(label: 'Inline', color: kCharcoalSoft),
                      hexBadge(label: 'Semantics', color: kVioletDeep),
                    ],
                  ),
                ),
                SizedBox(height: 14.0),
                Text(
                  'Each hexagonal badge is a mixin you can snap onto a RenderObject. '
                  'The concrete class is the molecule built by combining the trunk with these branches.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kCharcoalSoft, fontSize: 12.5, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),

          // ================================================================
          // 3. RenderObjectWithChildMixin
          // ================================================================
          anatomyCard(
            index: '03',
            title: 'RenderObjectWithChildMixin<ChildType>',
            subtitle: 'Single-child slot with parentData and attach/detach wired in.',
            accent: kVioletMid,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profileTable(mixinProfiles[0]),
                SizedBox(height: 12.0),
                sectionLabel('What it provides', kVioletMid),
                for (final s in (mixinProfiles[0]['provides'] as List<String>)) bulletRow(s),
                SizedBox(height: 10.0),
                sectionLabel('Who uses it', kOrangeMolten),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 6.0,
                  children: <Widget>[
                    for (final c in (mixinProfiles[0]['consumers'] as List<String>))
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: kVioletSoft,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          c,
                          style: TextStyle(color: kVioletDeep, fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.0),
                specimenFrame(
                  label: 'live specimen — Opacity around Text',
                  accent: kVioletMid,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: kParchmentMid,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Opacity(
                      opacity: 0.65,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: kVioletDeep,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Single-child render object',
                          style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                codeBlock(
                  'mixin RenderObjectWithChildMixin<ChildType extends RenderObject> on RenderObject {\n'
                  '  ChildType? _child;\n'
                  '  ChildType? get child => _child;\n'
                  '  set child(ChildType? value) {\n'
                  '    if (_child != null) dropChild(_child!);\n'
                  '    _child = value;\n'
                  '    if (_child != null) adoptChild(_child!);\n'
                  '  }\n'
                  '}',
                ),
              ],
            ),
          ),

          // ================================================================
          // 4. ContainerRenderObjectMixin
          // ================================================================
          anatomyCard(
            index: '04',
            title: 'ContainerRenderObjectMixin<Child, ParentData>',
            subtitle: 'Intrusive linked-list children stored inside each child\'s ParentData.',
            accent: kOrangeMolten,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profileTable(mixinProfiles[1]),
                SizedBox(height: 12.0),
                sectionLabel('What it provides', kOrangeMolten),
                for (final s in (mixinProfiles[1]['provides'] as List<String>)) bulletRow(s, color: kOrangeMolten),
                SizedBox(height: 10.0),
                sectionLabel('Who uses it', kVioletMid),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 6.0,
                  children: <Widget>[
                    for (final c in (mixinProfiles[1]['consumers'] as List<String>))
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: kOrangeGlow,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          c,
                          style: TextStyle(color: kCrimson, fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 6.0),
                sectionLabel('Linked-list metaphor', kVioletDeep),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: kParchmentMid,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #73, P3):
                  // The treeNode helper renders Container(padding h:10, border 1.4) >
                  // Row(Icon(14) + SizedBox(6) + Flexible(Text)). At width 36 the
                  // content area is only 36 - 2*(10 + 1.4) = 13.2 px, but Row's
                  // minimum non-shrinkable children (Icon + SizedBox) need >= 20 px,
                  // producing a 6.8 px right-overflow once per node (4x total).
                  // Width 56 yields a 33.2 px content area, fitting Icon+gap+1-char
                  // Text comfortably. The helper itself stays unchanged so other
                  // call sites (default width 200.0) are unaffected.
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      treeNode('A', kVioletMid, width: 56.0),
                      Icon(Icons.arrow_forward_rounded, size: 16.0, color: kCharcoalSoft),
                      treeNode('B', kVioletMid, width: 56.0),
                      Icon(Icons.arrow_forward_rounded, size: 16.0, color: kCharcoalSoft),
                      treeNode('C', kVioletMid, width: 56.0),
                      Icon(Icons.arrow_forward_rounded, size: 16.0, color: kCharcoalSoft),
                      treeNode('D', kVioletMid, width: 56.0),
                    ],
                  ),
                ),
                specimenFrame(
                  label: 'live specimen — Row with 4 children',
                  accent: kOrangeMolten,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (int i = 0; i < 4; i += 1)
                        Container(
                          width: 48.0,
                          height: 48.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: <Color>[kOrangeMolten, kAmber, kVioletMid, kMintDeep][i],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            String.fromCharCode(65 + i),
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                codeBlock(
                  'mixin ContainerRenderObjectMixin<Child extends RenderObject,\n'
                  '                                  PD extends ContainerParentDataMixin<Child>>\n'
                  '    on RenderObject {\n'
                  '  Child? _firstChild;\n'
                  '  Child? _lastChild;\n'
                  '  int _childCount = 0;\n'
                  '  void insert(Child child, { Child? after });\n'
                  '  void remove(Child child);\n'
                  '  Child? childBefore(Child child) =>\n'
                  '      (child.parentData! as PD).previousSibling;\n'
                  '  Child? childAfter(Child child) =>\n'
                  '      (child.parentData! as PD).nextSibling;\n'
                  '}',
                ),
              ],
            ),
          ),

          // ================================================================
          // 5. RenderProxyBoxMixin
          // ================================================================
          anatomyCard(
            index: '05',
            title: 'RenderProxyBoxMixin',
            subtitle: 'Forward layout, paint and hit-test to a single RenderBox child.',
            accent: kAmber,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profileTable(mixinProfiles[2]),
                SizedBox(height: 10.0),
                sectionLabel('Proxy pattern', kAmber),
                bulletRow('intrinsic sizes delegated 1:1 to child', color: kAmber),
                bulletRow('performLayout: child.layout(constraints, parentUsesSize: true); size = child.size', color: kAmber),
                bulletRow('paint: context.paintChild(child!, offset)', color: kAmber),
                bulletRow('hitTestChildren: child!.hitTest(result, position: position)', color: kAmber),
                specimenFrame(
                  label: 'live specimen — Opacity / ColoredBox / IgnorePointer',
                  accent: kAmber,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Opacity(
                            opacity: 0.35,
                            child: Container(
                              width: 56.0,
                              height: 56.0,
                              color: kVioletDeep,
                              alignment: Alignment.center,
                              child: Text('OP', style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
                            ),
                          ),
                          ColoredBox(
                            color: kOrangeMolten,
                            child: SizedBox(
                              width: 56.0,
                              height: 56.0,
                              child: Center(
                                child: Text('CB', style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          IgnorePointer(
                            ignoring: true,
                            child: Container(
                              width: 56.0,
                              height: 56.0,
                              color: kMintDeep,
                              alignment: Alignment.center,
                              child: Text('IP', style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'OP = RenderOpacity, CB = RenderColoredBox, IP = RenderIgnorePointer — '
                        'all three share RenderProxyBoxMixin and only override paint or hit-test.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11.5, color: kCharcoalSoft, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                codeBlock(
                  'mixin RenderProxyBoxMixin<T extends RenderBox>\n'
                  '    on RenderBox, RenderObjectWithChildMixin<T> {\n'
                  '  @override\n'
                  '  void performLayout() {\n'
                  '    if (child != null) {\n'
                  '      child!.layout(constraints, parentUsesSize: true);\n'
                  '      size = child!.size;\n'
                  '    } else {\n'
                  '      size = computeSizeForNoChild(constraints);\n'
                  '    }\n'
                  '  }\n'
                  '}',
                ),
              ],
            ),
          ),

          // ================================================================
          // 6. RenderProxySliverMixin
          // ================================================================
          anatomyCard(
            index: '06',
            title: 'RenderProxySliverMixin',
            subtitle: 'Sliver counterpart -- delegates geometry to a single sliver child.',
            accent: kMintDeep,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profileTable(mixinProfiles[3]),
                SizedBox(height: 10.0),
                sectionLabel('Why slivers need their own mixin', kMintDeep),
                bulletRow('Slivers exchange SliverGeometry instead of Size', color: kMintDeep),
                bulletRow('Hit-testing uses sliver-specific protocol with axis cross-axis split', color: kMintDeep),
                bulletRow('paintOffset stored in SliverPhysicalParentData', color: kMintDeep),
                specimenFrame(
                  label: 'live specimen — CustomScrollView with SliverOpacity',
                  accent: kMintDeep,
                  child: SizedBox(
                    height: 160.0,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Container(
                            height: 36.0,
                            color: kVioletDeep,
                            alignment: Alignment.center,
                            child: Text(
                              'Header (sliver adapter)',
                              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
                            ),
                          ),
                        ),
                        SliverOpacity(
                          opacity: 0.5,
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext ctx, int i) => Container(
                                height: 28.0,
                                color: i.isEven ? kMintCool : kParchmentMid,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                  'Translucent row $i (RenderSliverOpacity)',
                                  style: TextStyle(fontSize: 11.5, color: kCharcoal),
                                ),
                              ),
                              childCount: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                codeBlock(
                  'mixin RenderProxySliverMixin on RenderSliver {\n'
                  '  RenderSliver? child;\n'
                  '  @override\n'
                  '  void performLayout() {\n'
                  '    child?.layout(constraints, parentUsesSize: true);\n'
                  '    geometry = child?.geometry ?? SliverGeometry.zero;\n'
                  '  }\n'
                  '}',
                ),
              ],
            ),
          ),

          // ================================================================
          // 7. RenderInlineChildrenContainerDefaults
          // ================================================================
          anatomyCard(
            index: '07',
            title: 'RenderInlineChildrenContainerDefaults',
            subtitle: 'Internal helpers for laying out inline render children (WidgetSpan placeholders).',
            accent: kCharcoalSoft,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profileTable(mixinProfiles[5]),
                SizedBox(height: 10.0),
                sectionLabel('Internal mixin -- rarely consumed directly', kCharcoalSoft),
                bulletRow('Used inside RenderParagraph for WidgetSpan children', color: kCharcoalSoft),
                bulletRow('Provides default implementations for positionInlineChildren, paintInlineChildren, hitTestInlineChildren', color: kCharcoalSoft),
                bulletRow('Most app code touches it only via Text.rich and WidgetSpan', color: kCharcoalSoft),
                specimenFrame(
                  label: 'live specimen — Text.rich with WidgetSpan',
                  accent: kCharcoalSoft,
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: kCharcoal, fontSize: 14.0, height: 1.4),
                      children: <InlineSpan>[
                        TextSpan(text: 'Inline children flow with the text: '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                            decoration: BoxDecoration(
                              color: kOrangeWarm,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              'badge',
                              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.0),
                            ),
                          ),
                        ),
                        TextSpan(text: ' surrounded by '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(Icons.star_rounded, size: 16.0, color: kAmber),
                        ),
                        TextSpan(text: ' icons placed by RenderInlineChildrenContainerDefaults.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ================================================================
          // 8. RenderObjectWithLayoutCallbackMixin
          // ================================================================
          anatomyCard(
            index: '08',
            title: 'RenderObjectWithLayoutCallbackMixin',
            subtitle: 'Allows widget building during the layout phase (LayoutBuilder).',
            accent: kCrimson,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profileTable(mixinProfiles[4]),
                SizedBox(height: 10.0),
                sectionLabel('What the layout callback unlocks', kCrimson),
                bulletRow('Lets a builder see its parent constraints before deciding children', color: kCrimson),
                bulletRow('Used by LayoutBuilder, SliverLayoutBuilder, lazily built lists', color: kCrimson),
                bulletRow('Re-entry from build to layout is guarded by invokeLayoutCallback', color: kCrimson),
                specimenFrame(
                  label: 'live specimen — LayoutBuilder reacting to parent width',
                  accent: kCrimson,
                  child: Column(
                    children: <Widget>[
                      for (final w in <double>[260.0, 360.0, 460.0])
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          child: SizedBox(
                            width: w,
                            child: LayoutBuilder(
                              builder: (BuildContext ctx, BoxConstraints c) {
                                final isWide = c.maxWidth >= 360.0;
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: isWide ? kMintCool : kOrangeGlow,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: kCharcoalSoft.withOpacity(0.25)),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        isWide ? Icons.desktop_windows_outlined : Icons.smartphone_outlined,
                                        size: 16.0,
                                        color: kCharcoal,
                                      ),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                          'maxWidth=${c.maxWidth.toStringAsFixed(1)} -> '
                                          '${isWide ? 'wide layout' : 'narrow layout'}',
                                          style: TextStyle(fontSize: 12.0, color: kCharcoal),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                codeBlock(
                  'mixin RenderObjectWithLayoutCallbackMixin<T extends Constraints>\n'
                  '    on RenderObject {\n'
                  '  void invokeLayoutCallback<C extends Constraints>(\n'
                  '      LayoutCallback<C> callback) {\n'
                  '    assert(debugDoingThisLayout);\n'
                  '    // ... safe re-entry into build during layout ...\n'
                  '    callback(constraints as C);\n'
                  '  }\n'
                  '}',
                ),
              ],
            ),
          ),

          // ================================================================
          // 9. RenderSemanticsAnnotations family
          // ================================================================
          anatomyCard(
            index: '09',
            title: 'RenderSemanticsAnnotations & friends',
            subtitle: 'How mixins inject SemanticsConfiguration into the semantics tree.',
            accent: kVioletDeep,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profileTable(mixinProfiles[6]),
                SizedBox(height: 10.0),
                sectionLabel('Related semantics mixins / classes', kVioletDeep),
                bulletRow('RenderSemanticsAnnotations — labels, hints, values, flags, actions'),
                bulletRow('RenderSemanticsGestureHandler — handles onTap, onLongPress for semantics'),
                bulletRow('RenderMergeSemantics — flattens descendants into one semantic node'),
                bulletRow('RenderBlockSemantics — hides earlier siblings from accessibility'),
                bulletRow('RenderExcludeSemantics — drops a subtree from semantics output'),
                specimenFrame(
                  label: 'live specimen — Semantics-decorated cards',
                  accent: kVioletDeep,
                  child: Column(
                    children: <Widget>[
                      Semantics(
                        label: 'Primary action card',
                        hint: 'Activate to confirm',
                        button: true,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: kVioletDeep,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.check_rounded, color: Color(0xFFFFFFFF), size: 18.0),
                              SizedBox(width: 8.0),
                              Text(
                                'Confirm',
                                style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Semantics(
                        header: true,
                        label: 'Inbox section, 3 unread messages',
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kOrangeGlow,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            'Inbox (3)',
                            style: TextStyle(color: kCharcoal, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      MergeSemantics(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: kMintCool,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.notifications_outlined, size: 18.0, color: kMintDeep),
                              SizedBox(width: 8.0),
                              Text('5', style: TextStyle(color: kCharcoal, fontWeight: FontWeight.w800)),
                              SizedBox(width: 4.0),
                              Text('alerts', style: TextStyle(color: kCharcoal)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ExcludeSemantics(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: kParchmentMid,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            'Decorative ribbon — excluded from semantics',
                            style: TextStyle(color: kCharcoalSoft, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                codeBlock(
                  'mixin RenderSemanticsAnnotations on RenderObject {\n'
                  '  void describeSemanticsConfiguration(SemanticsConfiguration config) {\n'
                  '    config.label = _label;\n'
                  '    config.hint = _hint;\n'
                  '    config.isButton = _button;\n'
                  '    if (_onTap != null) config.onTap = _onTap;\n'
                  '    // markNeedsSemanticsUpdate() when any of these mutate\n'
                  '  }\n'
                  '}',
                ),
              ],
            ),
          ),

          // ================================================================
          // 10. ParentData family
          // ================================================================
          anatomyCard(
            index: '10',
            title: 'ParentData family',
            subtitle: 'The shapes of data that parents hang off their children.',
            accent: kOrangeWarm,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final pd in parentDataFamily)
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: kParchmentMid,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: kParchmentEdge),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 8.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                color: kOrangeMolten,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              pd['name']!,
                              style: TextStyle(
                                color: kVioletDeep,
                                fontWeight: FontWeight.w800,
                                fontSize: 13.0,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'adds: ${pd['addsWhat']}',
                          style: TextStyle(color: kCharcoal, fontSize: 12.5, height: 1.4),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          'used by: ${pd['usedBy']}',
                          style: TextStyle(color: kCharcoalSoft, fontSize: 11.5, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // ================================================================
          // 11. Mixin layering diagram
          // ================================================================
          anatomyCard(
            index: '11',
            title: 'Mixin layering: how RenderFlex is built',
            subtitle: 'A concrete class as a stack of mixins on a RenderBox base.',
            accent: kVioletDeep,
            body: Column(
              children: <Widget>[
                treeNode('RenderObject', kInk, width: 260.0),
                treeConnector(),
                treeNode('RenderBox', kVioletDeep, width: 260.0),
                treeConnector(),
                treeNode('+ ContainerRenderObjectMixin<RenderBox, FlexParentData>', kOrangeMolten, isMixin: true, width: 360.0),
                treeConnector(color: kOrangeMolten),
                treeNode('+ RenderBoxContainerDefaultsMixin<RenderBox, FlexParentData>', kAmber, isMixin: true, width: 360.0),
                treeConnector(color: kAmber),
                treeNode('+ DebugOverflowIndicatorMixin', kCrimson, isMixin: true, width: 280.0),
                treeConnector(color: kCrimson),
                treeNode('= RenderFlex (Row / Column)', kVioletMid, width: 260.0),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: kParchmentMid,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: kParchmentEdge),
                  ),
                  child: Text(
                    'Reading the stack: each + adds a focused contract. RenderFlex ends up with '
                    'child management, default box container helpers, debug overflow paint, and '
                    'flex-specific layout code -- none of which had to be duplicated from sibling classes.',
                    style: TextStyle(fontSize: 12.5, color: kCharcoal, height: 1.5),
                  ),
                ),
              ],
            ),
          ),

          // ================================================================
          // 12. Live composite specimen
          // ================================================================
          anatomyCard(
            index: '12',
            title: 'Composite specimen: which mixin powers which part?',
            subtitle: 'A small annotated tree showing several mixins working together.',
            accent: kOrangeMolten,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 220.0,
                  decoration: BoxDecoration(
                    color: kParchmentMid,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: kParchmentEdge),
                  ),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                          height: 40.0,
                          color: kVioletDeep,
                          alignment: Alignment.center,
                          child: Text(
                            'Header — SliverToBoxAdapter -> RenderProxySliverMixin',
                            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.5),
                          ),
                        ),
                      ),
                      SliverOpacity(
                        opacity: 0.85,
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext ctx, int i) => Container(
                              height: 32.0,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              color: i.isEven ? kOrangeGlow : kParchment,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: kOrangeMolten,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'List item $i — ContainerRenderObjectMixin children',
                                    style: TextStyle(fontSize: 12.0, color: kCharcoal),
                                  ),
                                ],
                              ),
                            ),
                            childCount: 6,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 36.0,
                          color: kMintDeep,
                          alignment: Alignment.center,
                          child: Text(
                            'Footer — RenderProxyBoxMixin (ColoredBox) under SliverToBoxAdapter',
                            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                bulletRow('CustomScrollView -> RenderViewport with ContainerRenderObjectMixin<RenderSliver, SliverPhysicalContainerParentData>'),
                bulletRow('SliverToBoxAdapter -> RenderSliverSingleBoxAdapter (single-child slot)', color: kOrangeMolten),
                bulletRow('SliverOpacity -> RenderProxySliverMixin (forwards geometry, modulates alpha)', color: kAmber),
                bulletRow('SliverList -> ContainerRenderObjectMixin over RenderBox children', color: kMintDeep),
                bulletRow('Each row Container -> RenderColoredBox / RenderDecoratedBox using RenderProxyBoxMixin', color: kCrimson),
              ],
            ),
          ),

          // ================================================================
          // 13. Recipe cards
          // ================================================================
          anatomyCard(
            index: '13',
            title: 'Recipe cards',
            subtitle: 'Six common patterns assembled from these mixins.',
            accent: kAmber,
            body: Column(
              children: <Widget>[
                for (final r in recipes)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 12.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: kParchment,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: kParchmentEdge),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.menu_book_outlined, size: 16.0, color: kAmber),
                            SizedBox(width: 6.0),
                            Expanded(
                              child: Text(
                                r['title'] as String,
                                style: TextStyle(
                                  color: kVioletDeep,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.0),
                        Wrap(
                          spacing: 6.0,
                          runSpacing: 4.0,
                          children: <Widget>[
                            for (final m in (r['mixins'] as List<String>))
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                                decoration: BoxDecoration(
                                  color: kVioletSoft,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  m,
                                  style: TextStyle(color: kVioletDeep, fontSize: 10.5, fontWeight: FontWeight.w600),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        codeBlock(r['snippet'] as String),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // ================================================================
          // 14. Comparison table
          // ================================================================
          anatomyCard(
            index: '14',
            title: 'Comparison table',
            subtitle: 'Mixin x purpose x arity x ParentData x representative consumer.',
            accent: kVioletMid,
            body: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: kParchmentEdge),
              ),
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < comparisonRows.length; i += 1)
                    Container(
                      decoration: BoxDecoration(
                        color: i == 0
                            ? kVioletDeep
                            : (i.isEven ? kParchmentMid : kParchment),
                        borderRadius: i == 0
                            ? BorderRadius.only(
                                topLeft: Radius.circular(9.0),
                                topRight: Radius.circular(9.0),
                              )
                            : null,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      child: Row(
                        children: <Widget>[
                          for (int c = 0; c < comparisonRows[i].length; c += 1)
                            Expanded(
                              flex: c == 0 ? 3 : 2,
                              child: Text(
                                comparisonRows[i][c],
                                style: TextStyle(
                                  color: i == 0 ? Color(0xFFFFFFFF) : kCharcoal,
                                  fontSize: 11.0,
                                  fontWeight: i == 0 ? FontWeight.w800 : FontWeight.w500,
                                  fontFamily: c == 0 || i == 0 ? null : 'monospace',
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ================================================================
          // 15. Pitfalls
          // ================================================================
          anatomyCard(
            index: '15',
            title: 'Pitfalls',
            subtitle: 'Where mixin-based code goes wrong in the render tree.',
            accent: kCrimson,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final p in pitfalls)
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFFDECEF),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: kCrimson.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.warning_amber_rounded, size: 18.0, color: kCrimson),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                p['mistake']!,
                                style: TextStyle(
                                  color: kCrimson,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          p['why']!,
                          style: TextStyle(color: kCharcoal, fontSize: 12.5, height: 1.5),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // ================================================================
          // 16. DebugCreator + Root element mixins
          // ================================================================
          anatomyCard(
            index: '16',
            title: 'DebugCreator, RootElementMixin, RenderTreeRootElement',
            subtitle: 'Auxiliary plumbing around the render tree.',
            accent: kCharcoalSoft,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                sectionLabel('DebugCreator', kCharcoalSoft),
                bulletRow('Object attached to RenderObject.debugCreator in debug builds.'),
                bulletRow('Carries the Element that created the render object, used by debug error messages.'),
                bulletRow('Never present in release builds; consumers must guard with kDebugMode.'),
                SizedBox(height: 8.0),
                sectionLabel('RootElementMixin', kCharcoalSoft),
                bulletRow('Mixin applied to Element subclasses that anchor a fresh render tree.'),
                bulletRow('Used by RenderObjectToWidgetAdapter to bridge widget tree into an existing RenderObject.'),
                bulletRow('Hosts a private build owner and assignment hook for the root render object.'),
                SizedBox(height: 8.0),
                sectionLabel('RenderTreeRootElement', kCharcoalSoft),
                bulletRow('Marker mixin signalling that an element introduces a new render tree root.'),
                bulletRow('Used internally by adapters and tests; not typically extended in app code.'),
                codeBlock(
                  '// RootElementMixin (sketch)\n'
                  'mixin RootElementMixin on Element {\n'
                  '  void assignOwner(BuildOwner owner) {\n'
                  '    super.assignOwner(owner);\n'
                  '  }\n'
                  '  @override\n'
                  '  void performRebuild() {\n'
                  '    super.performRebuild();\n'
                  '  }\n'
                  '}\n\n'
                  '// RenderTreeRootElement (sketch)\n'
                  'mixin RenderTreeRootElement on RenderObjectElement {\n'
                  '  // declares this element as a top-level render tree mount point\n'
                  '}',
                ),
              ],
            ),
          ),

          // ================================================================
          // 17. Glossary
          // ================================================================
          anatomyCard(
            index: '17',
            title: 'Glossary',
            subtitle: 'Reference vocabulary for render-tree mixins.',
            accent: kVioletDeep,
            body: Column(
              children: <Widget>[
                for (final g in glossary)
                  Container(
                    margin: EdgeInsets.only(bottom: 6.0),
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: kParchmentMid,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 140.0,
                          child: Text(
                            g['term']!,
                            style: TextStyle(
                              color: kVioletDeep,
                              fontFamily: 'monospace',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            g['def']!,
                            style: TextStyle(color: kCharcoal, fontSize: 12.0, height: 1.45),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // ================================================================
          // 18. Epilogue
          // ================================================================
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[kVioletDeep, kInk],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.auto_awesome, color: kOrangeWarm, size: 22.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Epilogue',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  'RenderObject mixins are the modular contracts that make Flutter\'s render tree extensible '
                  'without an exponential class hierarchy. Whenever you read a concrete render class, decoding '
                  'its with clause tells you its child arity, its parent-data shape, whether it forwards layout, '
                  'and whether it injects semantics. The hexagonal badges in this gallery are the alphabet; '
                  'concrete render classes spell entire words by snapping them together.',
                  style: TextStyle(color: kVioletGlow, fontSize: 13.5, height: 1.55),
                ),
                SizedBox(height: 14.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0x22FFFFFF),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.science_outlined, color: kOrangeGlow, size: 16.0),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'Specimens: Opacity, ColoredBox, IgnorePointer, Row, CustomScrollView with SliverOpacity, '
                          'LayoutBuilder, Semantics, MergeSemantics, ExcludeSemantics, Text.rich with WidgetSpan.',
                          style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0, height: 1.45),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}
