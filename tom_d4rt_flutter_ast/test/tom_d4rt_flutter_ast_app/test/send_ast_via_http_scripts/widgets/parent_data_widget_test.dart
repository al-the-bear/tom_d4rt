// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// ParentDataWidget — Complete Deep Dive
///
/// Palette: Coral / Salmon (warm pink-orange spectrum)
/// Primary:   Color(0xFFE85D5D) — Coral Red
/// Secondary: Color(0xFFFA8072) — Salmon
/// Accent:    Color(0xFFF06292) — Pink 300
/// Surface:   Color(0xFFFFF0EE) — Warm Blush
/// Deep:      Color(0xFFB71C1C) — Red 900
/// Muted:     Color(0xFFEF9A9A) — Red 200
/// Warm:      Color(0xFFFF7043) — Deep Orange 400
/// Highlight: Color(0xFFFFCDD2) — Red 100
/// Light:     Color(0xFFFCE4EC) — Pink 50
/// Dark:      Color(0xFFC62828) — Red 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   ParentDataWidget — Complete Deep Dive               ██');
  print('██   Abstract proxy widget for child layout metadata     ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const coral = Color(0xFFE85D5D);
  const salmon = Color(0xFFFA8072);
  const pink300 = Color(0xFFF06292);
  const warmBlush = Color(0xFFFFF0EE);
  const red900 = Color(0xFFB71C1C);
  const red200 = Color(0xFFEF9A9A);
  const deepOrange400 = Color(0xFFFF7043);
  const red100 = Color(0xFFFFCDD2);
  const pink50 = Color(0xFFFCE4EC);
  const red800 = Color(0xFFC62828);

  // ─── Section 2: What Is ParentDataWidget? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is ParentDataWidget?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentDataWidget is an abstract class that represents');
  print('  "metadata about how a child should be laid out by its');
  print('  parent." It doesn NOT paint or size itself — instead,');
  print('  it writes configuration into its child render object\'s');
  print('  parentData slot so the parent layout can read it.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Core idea:                                          │');
  print('  │                                                      │');
  print('  │  "I am Positioned(left: 10, top: 20). I don\'t draw  │');
  print('  │   anything. I just tell my parent Stack where to     │');
  print('  │   place my child."                                   │');
  print('  │                                                      │');
  print('  │  This separation allows each child in a multi-child  │');
  print('  │  layout to carry its own layout instructions without  │');
  print('  │  the parent needing to know widget-layer details.    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Inheritance Chain ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Inheritance Chain');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('       ┌──────────────────────┐');
  print('       │  Widget              │  Immutable description');
  print('       └──────────┬───────────┘');
  print('                  │');
  print('       ┌──────────┴───────────┐');
  print('       │  ProxyWidget         │  Single child, no render');
  print('       │  (child: Widget)     │');
  print('       └──────────┬───────────┘');
  print('                  │');
  print('       ┌──────────┴───────────────┐');
  print('       │  ParentDataWidget<T>     │  T extends ParentData');
  print('       │                          │');
  print('       │  abstract:               │');
  print('       │    applyParentData(RO)   │');
  print('       │    debugTypicalAncestor  │');
  print('       └──────────┬───────────────┘');
  print('                  │');
  print('     ┌────────────┼──────────────┐');
  print('     │            │              │');
  print('  Positioned   Flexible     LayoutId');
  print('  (Stack)      (Row/Col)    (CustomMulti)');
  print('');
  print('  ProxyWidget provides the single child property.');
  print('  ParentDataWidget adds the layout metadata mechanism.');
  print('  Concrete subclasses implement applyParentData().');
  print('');

  // ─── Section 4: The applyParentData Contract ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: The applyParentData() Contract');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The most important method on ParentDataWidget:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  void applyParentData(RenderObject renderObject)     │');
  print('  │                                                      │');
  print('  │  Called by the framework to write this widget\'s       │');
  print('  │  configuration into renderObject.parentData.          │');
  print('  │                                                      │');
  print('  │  Contract:                                            │');
  print('  │  1. Cast renderObject.parentData to your type T      │');
  print('  │  2. Write your fields into it                        │');
  print('  │  3. Call renderObject.parent.markNeedsLayout()       │');
  print('  │     (the AbstractNode parent, which is the RO that   │');
  print('  │      will READ the parent data during layout)        │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Example — Positioned.applyParentData:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  void applyParentData(RenderObject renderObject) {   │');
  print('  │    final parentData =                                │');
  print('  │        renderObject.parentData as StackParentData;   │');
  print('  │    bool needsLayout = false;                         │');
  print('  │    if (parentData.left != left) {                    │');
  print('  │      parentData.left = left;                         │');
  print('  │      needsLayout = true;                             │');
  print('  │    }                                                 │');
  print('  │    if (parentData.top != top) {                      │');
  print('  │      parentData.top = top;                           │');
  print('  │      needsLayout = true;                             │');
  print('  │    }                                                 │');
  print('  │    // ... more fields ...                            │');
  print('  │    if (needsLayout) {                                │');
  print('  │      renderObject.parent?.markNeedsLayout();         │');
  print('  │    }                                                 │');
  print('  │  }                                                   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: createElement() ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: createElement() — ParentDataElement');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentDataWidget creates a ParentDataElement:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  @override                                            │');
  print('  │  ParentDataElement<T> createElement() =>              │');
  print('  │      ParentDataElement<T>(this);                      │');
  print('  │                                                       │');
  print('  │  The element is responsible for:                      │');
  print('  │  • Holding the widget reference                       │');
  print('  │  • Calling applyParentData when widget updates        │');
  print('  │  • Supporting applyWidgetOutOfTurn for mid-build      │');
  print('  │    updates (used by AutomaticKeepAlive)               │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  The element-widget relationship:');
  print('  ┌─────────────────┐     ┌─────────────────────────┐');
  print('  │ ParentDataWidget │────→│ ParentDataElement<T>    │');
  print('  │ (immutable)      │     │ (long-lived)            │');
  print('  └─────────────────┘     │ - calls applyParentData │');
  print('                          │   on mount and update    │');
  print('                          └─────────────────────────┘');
  print('');

  // ─── Section 6: Debug Type Safety ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: Debug Type Safety');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentDataWidget has debug checks to ensure you');
  print('  use it with the correct parent:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  abstract getter:                                     │');
  print('  │  Type get debugTypicalAncestorWidgetClass;            │');
  print('  │                                                       │');
  print('  │  // Returns the expected parent RenderObjectWidget    │');
  print('  │  // type. Used in error messages:                     │');
  print('  │  //                                                   │');
  print('  │  // "Positioned widgets must be placed directly       │');
  print('  │  //  inside Stack widgets."                           │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  bool debugIsValidRenderObject(RenderObject ro)       │');
  print('  │                                                       │');
  print('  │  // Checks if ro.parentData is compatible type T      │');
  print('  │  // Default implementation: ro.parentData is T        │');
  print('  │  //                                                   │');
  print('  │  // Can be overridden for custom compatibility logic  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Common error messages this generates:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  ✗ Positioned inside Column:                          │');
  print('  │    "Incorrect use of ParentDataWidget.                │');
  print('  │     Positioned widgets must be placed inside Stack"   │');
  print('  │                                                       │');
  print('  │  ✗ Flexible inside Stack:                             │');
  print('  │    "Incorrect use of ParentDataWidget.                │');
  print('  │     Flexible widgets must be placed inside Flex"      │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: All Known Subclasses Table ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: All Known Subclasses');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────┬────────────────────┬─────────────┐');
  print('  │  Subclass         │  ParentData type   │  Parent RO  │');
  print('  ├──────────────────┼────────────────────┼─────────────┤');
  print('  │  Positioned       │  StackParentData   │  RenderStack│');
  print('  │  Flexible         │  FlexParentData    │  RenderFlex │');
  print('  │  Expanded         │  FlexParentData    │  RenderFlex │');
  print('  │  Spacer           │  FlexParentData    │  RenderFlex │');
  print('  │  LayoutId         │  MultiChildLayout  │  RenderCML  │');
  print('  │                   │  ParentData        │             │');
  print('  │  KeepAlive        │  KeepAliveParent   │  Sliver     │');
  print('  │                   │  DataMixin         │             │');
  print('  │  TableCell        │  TableCellPD       │  RenderTable│');
  print('  │  SliverCrossAxis  │  SliverPhysical    │  RenderSlvr │');
  print('  │  Expanded         │  ContainerPD       │             │');
  print('  └──────────────────┴────────────────────┴─────────────┘');
  print('');
  print('  Every time you write Stack → Positioned, Row → Expanded,');
  print('  or Column → Flexible, you are using ParentDataWidget.');
  print('  It is one of the most frequently used patterns.');
  print('');

  // ─── Section 8: Data Flow Pipeline ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Data Flow Pipeline');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Complete flow when user writes:');
  print('  Stack(children: [Positioned(left: 10, child: Box())])');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  WIDGET TREE                                          │');
  print('  │  ┌──────────────┐                                    │');
  print('  │  │ Stack widget │                                    │');
  print('  │  │  children: [ │                                    │');
  print('  │  │   Positioned │  ← ParentDataWidget<StackPD>      │');
  print('  │  │    (left:10) │                                    │');
  print('  │  │     └─ Box   │                                    │');
  print('  │  │  ]           │                                    │');
  print('  │  └──────────────┘                                    │');
  print('  │         │                                             │');
  print('  │  ELEMENT TREE                                         │');
  print('  │  ┌──────────────┐                                    │');
  print('  │  │ Multi-child  │                                    │');
  print('  │  │ RO Element   │                                    │');
  print('  │  │  └─ Parent   │  ← ParentDataElement<StackPD>     │');
  print('  │  │    DataElem  │                                    │');
  print('  │  │     └─ Box   │                                    │');
  print('  │  │       Elem   │                                    │');
  print('  │  └──────────────┘                                    │');
  print('  │         │                                             │');
  print('  │  RENDER TREE                                          │');
  print('  │  ┌──────────────┐                                    │');
  print('  │  │ RenderStack  │  reads child.parentData during     │');
  print('  │  │  └─ RenderBox│  performLayout()                   │');
  print('  │  │    .parentData = StackParentData(left:10)         │');
  print('  │  └──────────────┘                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: debugCanApplyOutOfTurn ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: debugCanApplyOutOfTurn()');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Most ParentDataWidgets return false (the default):');
  print('  parent data should only be applied during build.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  bool debugCanApplyOutOfTurn() => false;              │');
  print('  │                                                       │');
  print('  │  KeepAlive overrides this to return TRUE, because    │');
  print('  │  it needs to update parent data from within a        │');
  print('  │  child\'s State lifecycle (updateKeepAlive), which    │');
  print('  │  can happen outside the normal build traversal.       │');
  print('  │                                                       │');
  print('  │  class KeepAlive extends ParentDataWidget<...> {      │');
  print('  │    @override                                          │');
  print('  │    bool debugCanApplyOutOfTurn() => true;             │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Positioned Deep Dive ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Positioned Deep Dive');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Positioned is the most common ParentDataWidget.');
  print('  It carries up to 6 positioning fields:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Positioned({                                        │');
  print('  │    double? left,     // offset from Stack left edge  │');
  print('  │    double? top,      // offset from Stack top edge   │');
  print('  │    double? right,    // offset from Stack right edge │');
  print('  │    double? bottom,   // offset from Stack bottom edge│');
  print('  │    double? width,    // constrained width            │');
  print('  │    double? height,   // constrained height           │');
  print('  │    required Widget child,                            │');
  print('  │  })                                                  │');
  print('  │                                                      │');
  print('  │  debugTypicalAncestorWidgetClass → Stack             │');
  print('  │  ParentData type → StackParentData                   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 11: Flexible / Expanded Deep Dive ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Flexible / Expanded Deep Dive');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Flexible and Expanded are ParentDataWidgets for Flex:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Flexible({                                          │');
  print('  │    int flex = 1,          // share of remaining space│');
  print('  │    FlexFit fit = loose,   // loose or tight fill     │');
  print('  │    required Widget child,                            │');
  print('  │  })                                                  │');
  print('  │                                                      │');
  print('  │  Expanded extends Flexible with fit = tight          │');
  print('  │                                                      │');
  print('  │  debugTypicalAncestorWidgetClass → Flex              │');
  print('  │  ParentData type → FlexParentData                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  FlexParentData fields:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  int? flex;      // null means 0 (non-flexible)      │');
  print('  │  FlexFit fit;    // tight (fill) or loose (shrink)   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: LayoutId Deep Dive ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: LayoutId Deep Dive');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  LayoutId assigns a named identity for');
  print('  CustomMultiChildLayout delegates:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  LayoutId({                                          │');
  print('  │    required Object id,    // identifier for delegate │');
  print('  │    required Widget child,                            │');
  print('  │  })                                                  │');
  print('  │                                                      │');
  print('  │  // In the delegate:                                 │');
  print('  │  void performLayout(Size size) {                     │');
  print('  │    layoutChild(id, constraints);                     │');
  print('  │    positionChild(id, Offset(x, y));                  │');
  print('  │  }                                                   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 13: ProxyWidget Relationship ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: ProxyWidget Family');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentDataWidget and InheritedWidget both extend');
  print('  ProxyWidget, but serve opposite data flow directions:');
  print('');
  print('  ┌────────────────────────────────────────────────────────┐');
  print('  │                    ProxyWidget                         │');
  print('  │                   (single child)                       │');
  print('  │                  /              \\                      │');
  print('  │    ParentDataWidget      InheritedWidget               │');
  print('  │    ┌───────────────┐     ┌────────────────┐            │');
  print('  │    │ Data UP       │     │ Data DOWN       │           │');
  print('  │    │ to parent RO  │     │ to descendants  │           │');
  print('  │    │               │     │                 │           │');
  print('  │    │ via parentData│     │ via of(context)  │          │');
  print('  │    │ field on child│     │ dependency       │          │');
  print('  │    │ RenderObject  │     │ mechanism        │          │');
  print('  │    └───────────────┘     └────────────────┘            │');
  print('  └────────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Performance Characteristics ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Performance Characteristics');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentDataWidget is extremely lightweight:');
  print('');
  print('  ┌────────────────────────┬──────────────────────────────┐');
  print('  │  Aspect                │  Cost                        │');
  print('  ├────────────────────────┼──────────────────────────────┤');
  print('  │  Widget creation       │  Const constructor (free)    │');
  print('  │  Element creation      │  One ParentDataElement       │');
  print('  │  RenderObject creation │  NONE (zero render cost)     │');
  print('  │  applyParentData       │  O(1) — set a few fields     │');
  print('  │  Update detection      │  O(1) — field comparison     │');
  print('  │  Tree depth addition   │  +1 element per widget       │');
  print('  │  Layout pass cost      │  Zero extra layout work      │');
  print('  └────────────────────────┴──────────────────────────────┘');
  print('');
  print('  ParentDataWidget is so cheap that Flutter uses it');
  print('  pervasively. Every child in a Stack, Row, Column,');
  print('  or CustomMultiChildLayout wraps itself in one.');
  print('');

  // ─── Section 15: Common Mistakes ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Common Mistakes');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Mistake 1: Wrong parent                              │');
  print('  │  Column(children: [Positioned(child: Text("x"))])    │');
  print('  │  → "Positioned must be placed inside Stack"           │');
  print('  │                                                       │');
  print('  │  Mistake 2: Multiple incompatible wrappers            │');
  print('  │  Stack(children: [Flexible(child: Text("x"))])       │');
  print('  │  → "Flexible must be placed inside Flex"              │');
  print('  │                                                       │');
  print('  │  Mistake 3: Nesting ParentDataWidgets                 │');
  print('  │  Stack(children: [                                    │');
  print('  │    Positioned(child: Positioned(child: Box(...)))     │');
  print('  │  ])                                                   │');
  print('  │  → Inner Positioned has no direct Stack parent-data   │');
  print('  │    context — confusing behavior                       │');
  print('  │                                                       │');
  print('  │  Mistake 4: Forgetting it in CustomMultiChildLayout   │');
  print('  │  CustomMultiChildLayout(children: [Text("x")])       │');
  print('  │  → Children must be wrapped in LayoutId(...)          │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 16: Live Demo — Stack with Positioned ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 16: Live Demo — Stack with Positioned');
  print('═══════════════════════════════════════════════════════════');
  print('');

  // ─── Section 17: Live Demo — Row with Flexible/Expanded ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 17: Live Demo — Row with Flexible/Expanded');
  print('═══════════════════════════════════════════════════════════');
  print('');

  // ─── Section 18: Live Demo — CustomMultiChildLayout ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 18: Live Demo — CustomMultiChildLayout');
  print('═══════════════════════════════════════════════════════════');
  print('');

  // Build the comprehensive visual demo
  final demo = Scaffold(
    backgroundColor: warmBlush,
    appBar: AppBar(
      title: const Text(
        'ParentDataWidget — Visual Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      backgroundColor: red900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Demo A: Stack with Positioned children ──
          Text(
            'A. Positioned → StackParentData',
            style: TextStyle(
              color: red900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Each Positioned is a ParentDataWidget that writes '
            'left/top/right/bottom/width/height into the child\'s '
            'StackParentData.',
            style: TextStyle(color: red800, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: red200, width: 1.5),
            ),
            child: Stack(
              children: [
                // Background grid
                Positioned.fill(
                  child: CustomPaint(
                    painter: _ParentDataGridPainter(color: red100),
                  ),
                ),

                // Top-left card
                Positioned(
                  left: 8,
                  top: 8,
                  child: _buildPositionedCard(
                    label: 'left: 8\ntop: 8',
                    color: coral,
                  ),
                ),

                // Top-right card
                Positioned(
                  right: 8,
                  top: 8,
                  width: 120,
                  child: _buildPositionedCard(
                    label: 'right: 8\ntop: 8\nwidth: 120',
                    color: salmon,
                  ),
                ),

                // Bottom with width + height
                Positioned(
                  left: 60,
                  bottom: 8,
                  width: 200,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [coral, deepOrange400],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'left:60, bottom:8, w:200, h:50',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                // Center fill card
                Positioned(
                  left: 10,
                  top: 80,
                  right: 140,
                  bottom: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      color: pink300.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: pink300),
                    ),
                    child: Center(
                      child: Text(
                        'Positioned.fill-like\n(all 4 edges set)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: pink300,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Demo B: Row with Flexible/Expanded ──
          Text(
            'B. Flexible / Expanded → FlexParentData',
            style: TextStyle(
              color: red900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Each Flexible/Expanded writes flex factor and fit '
            'into FlexParentData. RenderFlex reads these during layout.',
            style: TextStyle(color: red800, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),

          // Row 1: Expanded with different flex
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: red200, width: 1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildFlexCard(
                    label: 'flex: 3\n(Expanded)',
                    color: coral,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: _buildFlexCard(
                    label: 'flex: 2\n(Expanded)',
                    color: salmon,
                  ),
                ),
                Expanded(
                  child: _buildFlexCard(
                    label: 'flex: 1\n(Expanded)',
                    color: deepOrange400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Row 2: Flexible (loose) vs Expanded (tight)
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: red200, width: 1.5),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: pink300.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: pink300),
                    ),
                    child: Center(
                      child: Text(
                        'Flexible (loose)',
                        style: TextStyle(
                          color: pink300,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: _buildFlexCard(
                    label: 'Expanded (tight)\nflex: 2',
                    color: coral,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Row 3: Column (vertical flex) with Expanded
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: red200, width: 1.5),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: salmon.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: salmon),
                    ),
                    child: Center(
                      child: Text(
                        'Column → Expanded(flex: 2)',
                        style: TextStyle(
                          color: salmon,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: deepOrange400.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: deepOrange400),
                    ),
                    child: Center(
                      child: Text(
                        'Column → Expanded(flex: 1)',
                        style: TextStyle(
                          color: deepOrange400,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Demo C: CustomMultiChildLayout with LayoutId ──
          Text(
            'C. LayoutId → MultiChildLayoutParentData',
            style: TextStyle(
              color: red900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'LayoutId is a ParentDataWidget that assigns an identity '
            'used by CustomMultiChildLayout delegates for positioning.',
            style: TextStyle(color: red800, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),

          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: red200, width: 1.5),
            ),
            child: CustomMultiChildLayout(
              delegate: _DemoLayoutDelegate(),
              children: [
                LayoutId(
                  id: 'header',
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: coral,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'LayoutId: "header"',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                LayoutId(
                  id: 'body',
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: salmon.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: salmon),
                    ),
                    child: Text(
                      'LayoutId: "body"\n'
                      'Positioned by delegate below header',
                      style: TextStyle(
                        color: red800,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                LayoutId(
                  id: 'badge',
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: pink300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'badge',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Summary Card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [red900, red800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ParentDataWidget Key Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  'Abstract class — never used directly',
                  'Extends ProxyWidget (single child, no RO)',
                  'applyParentData() writes to child.parentData',
                  'Type-safe: debug checks enforce correct parent',
                  'Positioned, Flexible, LayoutId are subclasses',
                  'Zero render overhead — metadata-only bridge',
                  'Most frequently used Flutter pattern',
                ].map((point) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: salmon,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            point,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 13,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Type mapping reference ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: pink50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: red200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ParentDataWidget → ParentData → Parent RO',
                  style: TextStyle(
                    color: red900,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                ...[
                  {
                    'widget': 'Positioned',
                    'data': 'StackParentData',
                    'parent': 'RenderStack',
                  },
                  {
                    'widget': 'Flexible',
                    'data': 'FlexParentData',
                    'parent': 'RenderFlex',
                  },
                  {
                    'widget': 'Expanded',
                    'data': 'FlexParentData',
                    'parent': 'RenderFlex',
                  },
                  {
                    'widget': 'LayoutId',
                    'data': 'MultiChildLayoutPD',
                    'parent': 'RenderCML',
                  },
                  {
                    'widget': 'KeepAlive',
                    'data': 'KeepAliveParentData',
                    'parent': 'SliverList',
                  },
                ].map((row) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            row['widget']!,
                            style: TextStyle(
                              color: coral,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: red200, size: 14),
                        SizedBox(
                          width: 110,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              row['data']!,
                              style: TextStyle(
                                color: red800,
                                fontSize: 11,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: red200, size: 14),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              row['parent']!,
                              style: TextStyle(
                                color: red900,
                                fontSize: 11,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('  Live widget built: ParentDataWidget visual');
  print('  • Stack with 4 Positioned children (StackParentData)');
  print('  • 3 Row/Column demos (FlexParentData)');
  print('  • CustomMultiChildLayout with 3 LayoutId children');
  print('  • Summary card and type mapping reference');
  print('');

  // ─── Section 19: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 19: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentDataWidget is the abstract base that gives');
  print('  Flutter its per-child layout configuration system.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                      │');
  print('  │                                                      │');
  print('  │  1. Abstract class, never instantiated directly      │');
  print('  │  2. Extends ProxyWidget (single child, no render)    │');
  print('  │  3. applyParentData() is the core mechanism          │');
  print('  │  4. createElement() creates ParentDataElement<T>     │');
  print('  │  5. Debug type safety via debugTypicalAncestorWidget │');
  print('  │  6. Subclasses: Positioned, Flexible, LayoutId, etc.│');
  print('  │  7. Zero render overhead — pure metadata bridge      │');
  print('  │  8. Most common usage: Stack→Positioned, Row→Flex    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Red 900   ${red900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Red 800   ${red800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Coral     ${coral.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Salmon    ${salmon.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  DOrange4  ${deepOrange400.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Pink 300  ${pink300.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Red 200   ${red200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Red 100   ${red100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Blush     ${warmBlush.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Pink 50   ${pink50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  ParentDataWidget — Demonstration Complete             ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}

Widget _buildPositionedCard({
  required String label,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
    ),
  );
}

Widget _buildFlexCard({
  required String label,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
      ),
    ),
  );
}

/// Grid painter for Stack demo background
class _ParentDataGridPainter extends CustomPainter {
  final Color color;

  const _ParentDataGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    const spacing = 20.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_ParentDataGridPainter oldDelegate) =>
      color != oldDelegate.color;
}

/// Custom delegate for the CustomMultiChildLayout demo
class _DemoLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    const padding = 12.0;

    // Layout header at top-left
    final headerSize = layoutChild(
      'header',
      BoxConstraints.loose(size),
    );
    positionChild('header', const Offset(padding, padding));

    // Layout body below header
    final bodyConstraints = BoxConstraints(
      maxWidth: size.width - padding * 2,
      maxHeight: size.height - headerSize.height - padding * 3,
    );
    layoutChild('body', bodyConstraints);
    positionChild(
      'body',
      Offset(padding, headerSize.height + padding * 2),
    );

    // Layout badge at top-right
    final badgeSize = layoutChild(
      'badge',
      BoxConstraints.loose(size),
    );
    positionChild(
      'badge',
      Offset(size.width - badgeSize.width - padding, padding),
    );
  }

  @override
  bool shouldRelayout(_DemoLayoutDelegate oldDelegate) => false;
}
