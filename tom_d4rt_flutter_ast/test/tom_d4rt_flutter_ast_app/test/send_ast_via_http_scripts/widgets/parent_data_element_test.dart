// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// ParentDataElement<T extends ParentData> — Deep Demonstration
///
/// Palette: Teal / Cyan (cool blue-green spectrum)
/// Primary:   Color(0xFF00796B) — Teal 700
/// Secondary: Color(0xFF00897B) — Teal 600
/// Accent:    Color(0xFF4DB6AC) — Teal 300
/// Surface:   Color(0xFFE0F2F1) — Teal 50
/// Deep:      Color(0xFF004D40) — Teal 900
/// Muted:     Color(0xFF80CBC4) — Teal 200
/// Warm:      Color(0xFF26A69A) — Teal 400
/// Highlight: Color(0xFFB2DFDB) — Teal 100
/// Light:     Color(0xFFE8F5E9) — Green 50 (shifted)
/// Dark:      Color(0xFF00695C) — Teal 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   ParentDataElement<T> — Complete Deep Dive           ██');
  print('██   Element node for ParentDataWidget propagation       ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const teal700 = Color(0xFF00796B);
  const teal600 = Color(0xFF00897B);
  const teal300 = Color(0xFF4DB6AC);
  const teal50 = Color(0xFFE0F2F1);
  const teal900 = Color(0xFF004D40);
  const teal200 = Color(0xFF80CBC4);
  const teal400 = Color(0xFF26A69A);
  const teal100 = Color(0xFFB2DFDB);
  const green50 = Color(0xFFE8F5E9);
  const teal800 = Color(0xFF00695C);

  // ─── Section 2: What Is ParentDataElement? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is ParentDataElement?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentDataElement is the Element that corresponds to');
  print('  a ParentDataWidget in the widget tree. It is the');
  print('  bridge that propagates layout metadata from a widget');
  print('  down to the child\'s RenderObject\'s parentData slot.');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  Purpose: Transfer layout directives (like "this   │');
  print('  │  child should be at position (10,20)" or "this     │');
  print('  │  child has flex factor 2") from the widget layer    │');
  print('  │  to the render layer without the child knowing.     │');
  print('  │                                                     │');
  print('  │  Every Positioned, Flexible, Expanded, KeepAlive   │');
  print('  │  widget creates a ParentDataElement in the          │');
  print('  │  element tree.                                      │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Three-Layer Architecture ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Three-Layer Architecture');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Flutter has three parallel trees. ParentDataElement');
  print('  sits in the middle, bridging widget and render:');
  print('');
  print('  Widget Tree         Element Tree         Render Tree');
  print('  ┌──────────┐       ┌──────────┐        ┌──────────┐');
  print('  │  Stack    │──────│ Element   │───────│ RenderStack│');
  print('  └────┬─────┘       └────┬─────┘        └────┬─────┘');
  print('       │                  │                    │');
  print('  ┌────┴─────┐     ┌─────┴──────────┐         │');
  print('  │Positioned│─────│ParentData      │         │');
  print('  │(widget)  │     │Element         │         │');
  print('  └────┬─────┘     └─────┬──────────┘         │');
  print('       │                  │                    │');
  print('  ┌────┴─────┐     ┌─────┴──────┐     ┌──────┴─────┐');
  print('  │Container │─────│ Element    │─────│RenderBox   │');
  print('  │(child)   │     │            │     │.parentData │');
  print('  └──────────┘     └────────────┘     │= StackPD   │');
  print('                                      └────────────┘');
  print('');
  print('  The ParentDataElement takes the configuration from');
  print('  Positioned (left, top, right, bottom, width, height)');
  print('  and applies it to the child RenderBox\'s parentData');
  print('  field, which is of type StackParentData.');
  print('');

  // ─── Section 4: Inheritance Chain ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Inheritance Chain');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('         ┌────────────┐');
  print('         │  Element   │  Base of all elements');
  print('         └─────┬──────┘');
  print('               │');
  print('       ┌───────┴──────┐');
  print('       │ Component    │  build() or update');
  print('       │ Element      │');
  print('       └───────┬──────┘');
  print('               │');
  print('       ┌───────┴──────┐');
  print('       │ Proxy        │  Passes through; wraps child');
  print('       │ Element      │');
  print('       └───────┬──────┘');
  print('               │');
  print('   ┌───────────┴──────────────┐');
  print('   │  ParentDataElement<T>    │  T extends ParentData');
  print('   │                          │');
  print('   │  Applies parent data to  │');
  print('   │  child\'s RenderObject    │');
  print('   └──────────────────────────┘');
  print('');
  print('  ParentDataElement extends ProxyElement, which is');
  print('  an element that wraps exactly one child (like');
  print('  InheritedElement). It doesn\'t create its own');
  print('  RenderObject — it modifies the child\'s.');
  print('');

  // ─── Section 5: ParentData Explained ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: ParentData Explained');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentData is the render-layer concept. Every');
  print('  RenderObject has a parentData field that its parent');
  print('  render object can write to:');
  print('');
  print('  ┌────────────────────────────────────────────────────┐');
  print('  │  class ParentData {                                │');
  print('  │    // Base class — holds no data by default        │');
  print('  │    void detach() { }                               │');
  print('  │  }                                                 │');
  print('  └────────────────────────────────────────────────────┘');
  print('');
  print('  Subclasses add layout-specific fields:');
  print('');
  print('  ┌────────────────────────┬──────────────────────────┐');
  print('  │  Subclass              │  Fields                  │');
  print('  ├────────────────────────┼──────────────────────────┤');
  print('  │  StackParentData       │  top, right, bottom,     │');
  print('  │                        │  left, width, height     │');
  print('  ├────────────────────────┼──────────────────────────┤');
  print('  │  FlexParentData        │  flex (int), fit enum    │');
  print('  ├────────────────────────┼──────────────────────────┤');
  print('  │  SliverMultiBoxAdaptor │  index, keepAlive        │');
  print('  │  ParentData            │                          │');
  print('  ├────────────────────────┼──────────────────────────┤');
  print('  │  BoxParentData         │  offset (Offset)         │');
  print('  ├────────────────────────┼──────────────────────────┤');
  print('  │  ContainerBoxParentData│  offset + sibling links  │');
  print('  │  <ChildType>           │  (doubly linked list)    │');
  print('  └────────────────────────┴──────────────────────────┘');
  print('');

  // ─── Section 6: ParentDataWidget Connection ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: ParentDataWidget → ParentDataElement');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The ParentDataWidget is the widget-layer counterpart.');
  print('  When inflated, it creates a ParentDataElement:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  abstract class ParentDataWidget<T extends       │');
  print('  │      ParentData> extends ProxyWidget {            │');
  print('  │                                                   │');
  print('  │    @override                                      │');
  print('  │    ParentDataElement<T> createElement() =>        │');
  print('  │        ParentDataElement<T>(this);                │');
  print('  │                                                   │');
  print('  │    void applyParentData(RenderObject renderObj);  │');
  print('  │  }                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Key method: applyParentData()');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Called by the framework when the ParentDataWidget│');
  print('  │  is first mounted or when it\'s updated with new  │');
  print('  │  data. It writes to renderObject.parentData.      │');
  print('  │                                                   │');
  print('  │  Example (Positioned):                            │');
  print('  │  void applyParentData(RenderObject renderObj) {   │');
  print('  │    final pd = renderObj.parentData as StackPD;    │');
  print('  │    pd.top = top;                                  │');
  print('  │    pd.left = left;                                │');
  print('  │    // ... mark parent needs layout                │');
  print('  │  }                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: notifyClients Method ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: notifyClients() Method');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  notifyClients is called when the ParentDataWidget');
  print('  updates (new configuration, same element). It');
  print('  triggers applyParentData on the child render object.');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Source (simplified):                             │');
  print('  │                                                   │');
  print('  │  @override                                        │');
  print('  │  void notifyClients(ParentDataWidget<T> oldW) {   │');
  print('  │    // Apply new parent data from the widget       │');
  print('  │    widget.applyParentData(                        │');
  print('  │      findRenderObjectChild()                      │');
  print('  │    );                                             │');
  print('  │  }                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  When is notifyClients called?');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • Positioned changes its top/left/etc            │');
  print('  │  • Flexible changes its flex factor               │');
  print('  │  • Expanded changes (Expanded is a Flexible)      │');
  print('  │  • Any ParentDataWidget rebuilds with new data    │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: applyWidgetOutOfTurn ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: applyWidgetOutOfTurn() — The Escape Hatch');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  This is the most interesting method — it allows');
  print('  modifying parent data OUTSIDE the normal build phase:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  void applyWidgetOutOfTurn(                       │');
  print('  │    ParentDataWidget<T> newWidget,                 │');
  print('  │  )                                                │');
  print('  │                                                   │');
  print('  │  Replaces the current widget and calls            │');
  print('  │  applyParentData immediately, even if we\'re      │');
  print('  │  not in a build phase.                            │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Why does this exist?');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  AutomaticKeepAlive uses it. When a sliver child │');
  print('  │  requests keepAlive, the framework needs to       │');
  print('  │  update the parent data without waiting for       │');
  print('  │  the next build. applyWidgetOutOfTurn allows this.│');
  print('  │                                                   │');
  print('  │  KeepAlive widget (ParentDataWidget):             │');
  print('  │    1. Child calls AutomaticKeepAliveClientMixin   │');
  print('  │       .updateKeepAlive()                          │');
  print('  │    2. This triggers applyWidgetOutOfTurn on the   │');
  print('  │       KeepAlive ParentDataElement                 │');
  print('  │    3. Parent data is updated immediately          │');
  print('  │    4. No rebuild needed!                          │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  ⚠ This is an advanced framework mechanism. You');
  print('  should almost never call it directly in app code.');
  print('');

  // ─── Section 9: Concrete ParentDataWidget Examples ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Concrete ParentDataWidget Examples');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  These widgets create ParentDataElements:');
  print('');
  print('  ┌─────────────────┬──────────────────┬──────────────┐');
  print('  │  Widget          │  ParentData Type │  Parent      │');
  print('  ├─────────────────┼──────────────────┼──────────────┤');
  print('  │  Positioned      │  StackParentData │  Stack       │');
  print('  │  Align(in Stack) │  StackParentData │  Stack       │');
  print('  ├─────────────────┼──────────────────┼──────────────┤');
  print('  │  Flexible        │  FlexParentData  │  Row/Column  │');
  print('  │  Expanded        │  FlexParentData  │  Row/Column  │');
  print('  │  Spacer          │  FlexParentData  │  Row/Column  │');
  print('  ├─────────────────┼──────────────────┼──────────────┤');
  print('  │  KeepAlive       │  KeepAliveParent │  SliverList  │');
  print('  │                  │  Data            │              │');
  print('  ├─────────────────┼──────────────────┼──────────────┤');
  print('  │  TableCell       │  (internal)      │  Table       │');
  print('  └─────────────────┴──────────────────┴──────────────┘');
  print('');
  print('  Each creates a ParentDataElement<T> where T is the');
  print('  specific ParentData subclass expected by the parent.');
  print('');

  // ─── Section 10: Type Safety and debugParentDataType ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Type Safety & debugParentDataType');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The framework enforces that ParentDataWidgets are');
  print('  used with compatible parent render objects. In debug');
  print('  mode, it checks the parentData type:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  // In debug mode:                                │');
  print('  │  Type get debugParentDataType => T;               │');
  print('  │                                                   │');
  print('  │  // Framework asserts:                            │');
  print('  │  assert(renderObject.parentData is T);            │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  This catches common mistakes:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  ✗ Positioned in a Column:                        │');
  print('  │    "Positioned widgets must be placed directly    │');
  print('  │    inside Stack widgets"                          │');
  print('  │                                                   │');
  print('  │  ✗ Flexible in a Stack:                           │');
  print('  │    "Flexible widgets must be placed directly      │');
  print('  │    inside Flex widgets (Row/Column)"              │');
  print('  │                                                   │');
  print('  │  ✗ Expanded in a ListView:                        │');
  print('  │    "Expanded widgets must be placed inside Flex   │');
  print('  │    widgets"                                       │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  These assertions fire because the child\'s parentData');
  print('  type doesn\'t match what the ParentDataWidget expects.');
  print('');

  // ─── Section 11: Data Flow Sequence ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Data Flow Sequence');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Step-by-step flow when Positioned changes:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  1. setState(() { left = 50.0; })                 │');
  print('  │     ↓                                             │');
  print('  │  2. Positioned widget rebuilt with new left value │');
  print('  │     ↓                                             │');
  print('  │  3. Framework calls canUpdate() on element        │');
  print('  │     → same type, same key → update (not replace) │');
  print('  │     ↓                                             │');
  print('  │  4. ParentDataElement.update() called             │');
  print('  │     ↓                                             │');
  print('  │  5. notifyClients() triggered                     │');
  print('  │     ↓                                             │');
  print('  │  6. Positioned.applyParentData(childRenderObj)    │');
  print('  │     ↓                                             │');
  print('  │  7. childRenderObj.parentData.left = 50.0         │');
  print('  │     ↓                                             │');
  print('  │  8. Parent RenderStack marks needs-layout         │');
  print('  │     ↓                                             │');
  print('  │  9. Next frame: RenderStack lays out using new    │');
  print('  │     parentData values                             │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Key insight: The CHILD render object doesn\'t know');
  print('  about the layout directives. Only the PARENT reads');
  print('  the parentData during layout. The child just gets');
  print('  constraints and produces a size.');
  print('');

  // ─── Section 12: ProxyElement Behavior ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: ProxyElement Behavior');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  As a ProxyElement, ParentDataElement is a');
  print('  single-child pass-through element:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Properties inherited from ProxyElement:          │');
  print('  │                                                   │');
  print('  │  • Single child: wraps exactly one child element  │');
  print('  │  • No own render: doesn\'t create a RenderObject  │');
  print('  │  • Transparent: the child\'s render object is     │');
  print('  │    what the parent sees                           │');
  print('  │  • Update: calls notifyClients when widget changes│');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Contrast with InheritedElement (also a ProxyElement):');
  print('  ┌──────────────────────┬────────────────────────────┐');
  print('  │  InheritedElement     │ ParentDataElement         │');
  print('  ├──────────────────────┼────────────────────────────┤');
  print('  │  Data flows DOWN tree │ Data flows UP to parent   │');
  print('  │  Descendants read it  │ Parent render reads it    │');
  print('  │  Via of(context)      │ Via parentData field      │');
  print('  │  Rebuilds dependents  │ Marks parent needs-layout │');
  print('  └──────────────────────┴────────────────────────────┘');
  print('');

  // ─── Section 13: Multiple ParentDataWidgets ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Multiple ParentDataWidgets');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Can a child have multiple ParentDataWidgets above it?');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Generally NO — the framework validates that only │');
  print('  │  ParentDataWidgets compatible with the nearest    │');
  print('  │  ancestor render object are applied.              │');
  print('  │                                                   │');
  print('  │  Stack(children: [                                │');
  print('  │    Positioned(                                    │');
  print('  │      child: Flexible(     // ← ERROR!             │');
  print('  │        child: Container(),                        │');
  print('  │      ),                                           │');
  print('  │    ),                                             │');
  print('  │  ])                                               │');
  print('  │                                                   │');
  print('  │  Flexible expects FlexParentData but the child\'s │');
  print('  │  parentData is StackParentData → assertion error. │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  However, some ParentData classes inherit from others');
  print('  and can combine information:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  StackParentData extends BoxParentData            │');
  print('  │  FlexParentData extends BoxParentData             │');
  print('  │                                                   │');
  print('  │  BoxParentData just has offset, which is common   │');
  print('  │  to most box layout protocols.                    │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: KeepAlive Deep Dive ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: KeepAlive — Key Consumer');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  KeepAlive is the primary user of');
  print('  applyWidgetOutOfTurn, making it the most interesting');
  print('  real-world use of ParentDataElement:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Scenario: ListView with expensive items          │');
  print('  │                                                   │');
  print('  │  SliverList                                       │');
  print('  │    ├─ KeepAlive(keepAlive: true)                  │');
  print('  │    │   └─ ExpensiveWidget()                       │');
  print('  │    ├─ KeepAlive(keepAlive: false)                 │');
  print('  │    │   └─ CheapWidget()                           │');
  print('  │    └─ ...                                         │');
  print('  │                                                   │');
  print('  │  When keepAlive=true:                             │');
  print('  │  • ParentData.keepAlive is set to true            │');
  print('  │  • SliverList keeps the child alive even when     │');
  print('  │    scrolled off screen                            │');
  print('  │  • State is preserved (animation, network, etc.)  │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  The AutomaticKeepAliveClientMixin uses this pattern:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  1. Mixin calls updateKeepAlive()                 │');
  print('  │  2. Finds the KeepAlive ParentDataElement         │');
  print('  │  3. Calls applyWidgetOutOfTurn with new KeepAlive │');
  print('  │  4. Parent data updated without full rebuild      │');
  print('  │  5. SliverList respects keepAlive flag on layout  │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 15: Debug Inspection ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Debug Inspection');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentDataElement appears in the DevTools element');
  print('  tree inspector. Look for these patterns:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Flutter Inspector Element Tree:                  │');
  print('  │                                                   │');
  print('  │  ▼ Stack                                          │');
  print('  │    ▼ Positioned (left: 10, top: 20)               │');
  print('  │      ▶ Container                                  │');
  print('  │    ▼ Positioned (right: 0, bottom: 0)             │');
  print('  │      ▶ FloatingActionButton                       │');
  print('  │                                                   │');
  print('  │  The "Positioned" nodes in the element tree are   │');
  print('  │  ParentDataElements. Selecting them shows the     │');
  print('  │  current parentData values.                       │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  In debug mode, you can also inspect parentData on');
  print('  any RenderObject:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  // In console or debugger:                       │');
  print('  │  renderBox.parentData  // StackParentData         │');
  print('  │    .top      // 20.0                              │');
  print('  │    .left     // 10.0                              │');
  print('  │    .offset   // Offset(10.0, 20.0)                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 16: Performance and Layout ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 16: Performance & Layout Efficiency');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentDataElement is designed for minimal overhead:');
  print('');
  print('  ┌────────────────────────┬──────────────────────────┐');
  print('  │  Aspect                │  Cost                    │');
  print('  ├────────────────────────┼──────────────────────────┤');
  print('  │  Element creation      │  Minimal (one object)    │');
  print('  │  applyParentData       │  O(1) — set a few fields │');
  print('  │  notifyClients         │  O(1) — single child     │');
  print('  │  Render object         │  None — doesn\'t create  │');
  print('  │  Tree depth            │  +1 per ParentDataWidget │');
  print('  │  Layout pass           │  Zero extra cost         │');
  print('  │  applyWidgetOutOfTurn  │  O(1) — inline update    │');
  print('  └────────────────────────┴──────────────────────────┘');
  print('');
  print('  The only concern is deep nesting. If you have many');
  print('  ParentDataWidgets between a parent and child, each');
  print('  adds one element to the tree. In practice, you');
  print('  rarely have more than one (Positioned OR Flexible,');
  print('  not both).');
  print('');

  // ─── Section 17: Live Interactive Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 17: Live Interactive Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  // Build a demo showing ParentDataWidget effects visually
  final parentDataDemo = Scaffold(
    backgroundColor: teal50,
    appBar: AppBar(
      title: const Text(
        'ParentDataElement — Visual Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      backgroundColor: teal900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack with Positioned (StackParentData)
          Text(
            'Positioned → StackParentData',
            style: TextStyle(
              color: teal900,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: teal200),
            ),
            child: Stack(
              children: [
                // Grid background
                Positioned.fill(
                  child: CustomPaint(
                    painter: _LayoutGridPainter(color: teal100),
                  ),
                ),

                // Positioned elements
                Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: teal700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'left:10, top:10',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  right: 10,
                  top: 60,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: teal600,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'right:10, top:60',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 30,
                  bottom: 20,
                  width: 180,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: teal400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'left:30, bottom:20\nwidth:180',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Center label
                Positioned(
                  right: 20,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: teal300.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Stack → StackParentData',
                      style: TextStyle(
                        color: teal800,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Row with Expanded/Flexible (FlexParentData)
          Text(
            'Expanded/Flexible → FlexParentData',
            style: TextStyle(
              color: teal900,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: teal200),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: teal700.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: teal700),
                    ),
                    child: Center(
                      child: Text(
                        'flex: 2',
                        style: TextStyle(
                          color: teal700,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: teal400.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: teal400),
                    ),
                    child: Center(
                      child: Text(
                        'flex: 1',
                        style: TextStyle(
                          color: teal400,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: teal300.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: teal300),
                    ),
                    child: Center(
                      child: Text(
                        'Flexible',
                        style: TextStyle(
                          color: teal600,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Data flow diagram card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [teal700, teal600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Flow: Widget → Element → Render',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  '1. ParentDataWidget configured (left: 10)',
                  '2. ParentDataElement created/updated',
                  '3. applyParentData() called on child RO',
                  '4. child.parentData.left = 10',
                  '5. Parent RO uses it in performLayout()',
                ].map((step) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            step,
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

          // Type mapping reference
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: green50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: teal200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Widget → ParentData Type Map',
                  style: TextStyle(
                    color: teal900,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                ...[
                  {'widget': 'Positioned', 'data': 'StackParentData'},
                  {'widget': 'Expanded', 'data': 'FlexParentData'},
                  {'widget': 'Flexible', 'data': 'FlexParentData'},
                  {'widget': 'KeepAlive', 'data': 'KeepAliveParentDataMixin'},
                ].map((mapping) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            mapping['widget']!,
                            style: TextStyle(
                              color: teal700,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: teal400, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            mapping['data']!,
                            style: TextStyle(
                              color: teal800,
                              fontSize: 13,
                              fontFamily: 'monospace',
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

  print('  Live widget built: ParentDataElement visual');
  print('  • Stack with 3 Positioned children (StackParentData)');
  print('  • Row with Expanded/Flexible children (FlexParentData)');
  print('  • Data flow pipeline diagram');
  print('  • Widget-to-ParentData type map');
  print('');

  // ─── Section 18: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 18: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ParentDataElement is the invisible bridge that');
  print('  connects layout directives from widgets to render');
  print('  objects via the parentData slot.');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                     │');
  print('  │                                                     │');
  print('  │  1. Extends ProxyElement (single-child, no RO)      │');
  print('  │  2. Created by ParentDataWidget.createElement()     │');
  print('  │  3. notifyClients() pushes data to child\'s RO      │');
  print('  │  4. applyWidgetOutOfTurn() for mid-build updates    │');
  print('  │  5. Used by Positioned, Flexible, Expanded, etc.    │');
  print('  │  6. Type-safe: debug checks parentData type         │');
  print('  │  7. Zero render overhead (no own RenderObject)      │');
  print('  │  8. KeepAlive uses the out-of-turn escape hatch     │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Teal 900  ${teal900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Teal 800  ${teal800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Teal 700  ${teal700.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Teal 600  ${teal600.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Teal 400  ${teal400.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Teal 300  ${teal300.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Teal 200  ${teal200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Teal 100  ${teal100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Teal 50   ${teal50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Green 50  ${green50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  ParentDataElement<T> — Demonstration Complete        ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return parentDataDemo;
}

/// Paints a subtle layout grid for the Stack demo
class _LayoutGridPainter extends CustomPainter {
  final Color color;

  const _LayoutGridPainter({required this.color});

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
  bool shouldRepaint(_LayoutGridPainter oldDelegate) =>
      color != oldDelegate.color;
}
