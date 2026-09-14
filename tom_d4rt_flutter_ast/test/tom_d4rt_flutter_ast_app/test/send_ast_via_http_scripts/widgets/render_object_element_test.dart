// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Deep visual demo — RenderObjectElement
///
/// RenderObjectElement is the Element subclass that bridges the widget tree with
/// the render tree. Every RenderObjectWidget (Padding, Align, SizedBox, etc.)
/// creates a RenderObjectElement whose job is to call createRenderObject,
/// updateRenderObject, and eventually didUnmountRenderObject on the render
/// object it owns.
///
/// Sections
/// ─────────
/// 1. Element lifecycle — mount → rebuild → update → deactivate → unmount
/// 2. Create / update render-object cycle
/// 3. Ancestor render-object lookup
/// 4. ParentData propagation
/// 5. Slot management in multi-child layouts
/// 6. Debug inspection & diagnostics
/// 7. Custom single-child RenderObjectWidget
/// 8. Custom multi-child RenderObjectWidget

// ─── palette ───────────────────────────────────────────────
const _kCyan      = Color(0xFF00BCD4);
const _kCyanLight = Color(0xFFB2EBF2);
const _kCyanDark  = Color(0xFF00838F);
const _kDeepPurple      = Color(0xFF673AB7);
const _kDeepPurpleLight = Color(0xFFD1C4E9);
const _kSurface   = Color(0xFFFAFAFA);
const _kDivider   = Color(0xFFE0E0E0);
const _kTextDark  = Color(0xFF212121);
const _kTextMuted = Color(0xFF757575);

// ─── 1. Lifecycle phases ───────────────────────────────────
const _kLifecyclePhases = <String, String>{
  'createElement':
      'Framework calls Widget.createElement(). The Element is born but not yet '
      'in the tree.',
  'mount':
      'Element.mount(parent, newSlot) — inserts the element into the tree. '
      'For RenderObjectElement this also calls widget.createRenderObject() and '
      'attachs the render object to the render tree via insertRenderObjectChild '
      'on the nearest ancestor RenderObjectElement.',
  'performRebuild':
      'Triggers when the element is marked dirty. Calls widget.updateRenderObject '
      'with the current render object so the render object picks up new config.',
  'update':
      'Called when the parent rebuilds with a new widget of the same runtimeType '
      'and key. The element keeps its identity; only the widget reference changes.',
  'deactivate':
      'The element is removed from the tree *but may be reinserted* during the '
      'same frame if a GlobalKey moves it. The render object is detached.',
  'unmount':
      'Permanent removal. Calls widget.didUnmountRenderObject(), then the element '
      'is garbage-collected.',
};

// ─── 2. Create / update pairs ──────────────────────────────
class _CreateUpdateEntry {
  const _CreateUpdateEntry(this.widgetName, this.createCall, this.updateCall, this.note);
  final String widgetName;
  final String createCall;
  final String updateCall;
  final String note;
}

const _kCreateUpdatePairs = <_CreateUpdateEntry>[
  _CreateUpdateEntry(
    'Padding',
    'createRenderObject → RenderPadding(padding)',
    'updateRenderObject → set padding = newPadding',
    'The most common single-property update.',
  ),
  _CreateUpdateEntry(
    'Align',
    'createRenderObject → RenderPositionedBox(alignment, widthFactor, heightFactor)',
    'updateRenderObject → set alignment, widthFactor, heightFactor',
    'Three properties copied on update.',
  ),
  _CreateUpdateEntry(
    'Opacity',
    'createRenderObject → RenderOpacity(opacity, alwaysIncludeSemantics)',
    'updateRenderObject → set opacity, alwaysIncludeSemantics',
    'opacity change triggers repaint, not relayout.',
  ),
  _CreateUpdateEntry(
    'Transform',
    'createRenderObject → RenderTransform(transform, origin, alignment)',
    'updateRenderObject → set transform, origin, alignment, textDirection',
    'Heavy matrix copy — framework caches identical matrices.',
  ),
  _CreateUpdateEntry(
    'SizedBox',
    'createRenderObject → RenderConstrainedBox(additionalConstraints)',
    'updateRenderObject → set additionalConstraints',
    'Constraints are the *only* property.',
  ),
];

// ─── 3. Ancestor lookup diagram data ───────────────────────
const _kAncestorLookupSteps = <String>[
  'RenderObjectElement._findAncestorRenderObjectElement() walks up parents',
  'Skips every Element that is NOT a RenderObjectElement (StatefulElement, etc.)',
  'Returns the first RenderObjectElement found',
  'Uses that ancestor to call insertRenderObjectChild / moveRenderObjectChild',
  'If no ancestor found (root), the render object becomes the root of the render tree',
];

// ─── 4. ParentData propagation ─────────────────────────────
class _ParentDataExample {
  const _ParentDataExample(this.widget, this.parentData, this.usage);
  final String widget;
  final String parentData;
  final String usage;
}

const _kParentDataExamples = <_ParentDataExample>[
  _ParentDataExample('Positioned', 'StackParentData', 'top, left, right, bottom, width, height'),
  _ParentDataExample('Expanded', 'FlexParentData', 'flex factor and FlexFit'),
  _ParentDataExample('TableCell', 'TableCellParentData', 'verticalAlignment per cell'),
  _ParentDataExample('SliverGridDelegateItem', 'SliverMultiBoxAdaptorParentData', 'layout offset, index, keepAlive'),
];

// ─── 5. Slot concept ───────────────────────────────────────
const _kSlotExplanation =
    'In a multi-child RenderObjectWidget (Row, Column, Stack), each child '
    'occupies a "slot" — typically the Element of the *previous sibling*. '
    'insertRenderObjectChild uses the slot to know *where* in the child list '
    'to place the render object. When children reorder, moveRenderObjectChild '
    'is called with the new slot.';

const _kSlotSteps = <String>[
  'Parent calls inflateWidget(child, nextSibling: slot)',
  'Child element receives slot in mount(parent, slot)',
  'Child calls ancestor.insertRenderObjectChild(renderObject, slot)',
  'Ancestor uses slot to find the correct position in its child list',
  'On reorder, parent calls updateSlotForChild → moveRenderObjectChild',
];

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCyanDark, _kDeepPurple],
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text, style: TextStyle(fontSize: 11, color: _kTextMuted, fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'monospace',
      fontSize: 12.5,
      color: color ?? _kTextDark,
      height: 1.45,
    ),
  );
}

Widget _bulletPoint(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 7),
          width: 5, height: 5,
          decoration: BoxDecoration(color: _kCyan, shape: BoxShape.circle),
        ),
        SizedBox(width: 10),
        Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── 7. Custom single-child RenderObjectWidget ─────────────
/// Demonstrates a minimal custom SingleChildRenderObjectWidget that
/// adds a fixed amount of inset on all sides — a simplified Padding.
class _DemoInsetWidget extends SingleChildRenderObjectWidget {
  const _DemoInsetWidget({required this.inset, super.child});
  final double inset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    print('[DemoInset] createRenderObject  inset=$inset');
    return RenderPadding(padding: EdgeInsets.all(inset));
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderPadding renderObject) {
    print('[DemoInset] updateRenderObject  inset=$inset');
    renderObject.padding = EdgeInsets.all(inset);
  }

  @override
  void didUnmountRenderObject(covariant RenderPadding renderObject) {
    print('[DemoInset] didUnmountRenderObject');
  }
}

// ─── 8. Custom multi-child RenderObjectWidget ──────────────
/// A custom ParentDataWidget that carries an integer "priority" value
/// applied to each child's parent data in _DemoOverlayRenderBox.
class _DemoPriorityParentDataWidget extends ParentDataWidget<_DemoPriorityParentData> {
  const _DemoPriorityParentDataWidget({required this.priority, required super.child});
  final int priority;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData;
    if (parentData is _DemoPriorityParentData && parentData.priority != priority) {
      parentData.priority = priority;
      final parent = renderObject.parent;
      if (parent is RenderObject) {
        parent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => _DemoOverlayWidget;
}

class _DemoPriorityParentData extends ContainerBoxParentData<RenderBox> {
  int priority = 0;
}

/// A simple multi-child RenderObjectWidget that stacks children with
/// visual priority badges. This shows how MultiChildRenderObjectElement
/// manages the child list and parent data.
class _DemoOverlayWidget extends MultiChildRenderObjectWidget {
  const _DemoOverlayWidget({super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _DemoOverlayRenderBox();
  }
}

class _DemoOverlayRenderBox extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _DemoPriorityParentData>,
         RenderBoxContainerDefaultsMixin<RenderBox, _DemoPriorityParentData> {

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _DemoPriorityParentData) {
      child.parentData = _DemoPriorityParentData();
    }
  }

  @override
  void performLayout() {
    double dy = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      child.layout(constraints.loosen(), parentUsesSize: true);
      final pd = child.parentData as _DemoPriorityParentData;
      pd.offset = Offset(0, dy);
      dy += child.size.height;
      child = pd.nextSibling;
    }
    size = constraints.constrain(Size(constraints.maxWidth, dy));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

// ─── 6. Debug utilities ────────────────────────────────────
Widget _buildDebugSection() {
  final diagnosticMethods = <String, String>{
    'debugDescribeChildren()':
        'Lists child elements with their slots and runtime types.',
    'toStringDeep()':
        'Recursive tree dump showing the entire element sub-tree.',
    'debugGetCreatorChain(limit)':
        'Returns a chain of widget creators up to limit length.',
    'debugGetDiagnosticChain()':
        'Returns the full chain of InformationCollector from this element up.',
    'renderObject.debugDescribeChildren()':
        'Mirror method on the render-object side — useful for verifying '
        'that the render tree matches the element tree.',
  };

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('6 · Debug Inspection & Diagnostics', Icons.bug_report_outlined),
      SizedBox(height: 8),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('DIAGNOSTIC METHODS ON ELEMENT & RENDER OBJECT'),
            SizedBox(height: 8),
            ...diagnosticMethods.entries.map((e) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _mono(e.key, color: _kCyanDark),
                  SizedBox(height: 2),
                  Text(e.value, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
                ],
              ),
            )),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('EXAMPLE: INSPECTING ELEMENT TREE'),
            SizedBox(height: 8),
            _mono('void debugDumpApp() {'),
            _mono('  // Prints the entire widget, element,'),
            _mono('  // and render trees to console.'),
            _mono('  debugDumpApp();'),
            _mono('}'),
            SizedBox(height: 10),
            _mono('context.findRenderObject()'),
            SizedBox(height: 2),
            Text(
              'Returns the nearest RenderObject owned by a RenderObjectElement '
              'at or above this context. This is the bridge from widget code '
              'into the render pipeline.',
              style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35),
            ),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('REASSEMBLE'),
            SizedBox(height: 6),
            Text(
              'During hot-reload, Element.reassemble() walks the tree and calls '
              'widget.updateRenderObject() on every RenderObjectElement, ensuring '
              'the render tree stays synchronized even if the widget identity changed.',
              style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35),
            ),
          ],
        ),
      ),
    ],
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('RenderObjectElement deep visual demo');
  print('─' * 48);
  print('Sections: lifecycle, create/update, ancestor lookup,');
  print('parentData, slots, debug, custom single-child, custom multi-child.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kCyan, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('RenderObjectElement'),
        backgroundColor: _kCyanDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _Body(),
    ),
  );
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  double _insetValue = 12.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        // ── Section 1: Lifecycle ──
        _sectionHeader('1 · Element Lifecycle', Icons.loop),
        SizedBox(height: 8),
        ..._kLifecyclePhases.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kCyanLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  e.key,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kCyanDark,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(e.value, style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4)),
            ],
          ),
        )),

        // ── Lifecycle flow diagram ──
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('LIFECYCLE FLOW'),
              SizedBox(height: 10),
              _buildFlowRow('createElement', _kCyan),
              _buildFlowArrow(),
              _buildFlowRow('mount  ➜  createRenderObject', _kCyan),
              _buildFlowArrow(),
              _buildFlowRow('performRebuild  ➜  updateRenderObject', _kDeepPurple),
              _buildFlowArrow(),
              _buildFlowRow('update  ➜  updateRenderObject', _kDeepPurple),
              _buildFlowArrow(),
              _buildFlowRow('deactivate  ➜  detach render object', Colors.orange),
              _buildFlowArrow(),
              _buildFlowRow('unmount  ➜  didUnmountRenderObject', Colors.red.shade700),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 2: Create / Update ──
        _sectionHeader('2 · Create / Update Render-Object Cycle', Icons.sync_alt),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('HOW THE FRAMEWORK MANAGES RENDER OBJECTS'),
              SizedBox(height: 6),
              Text(
                'When a RenderObjectElement is first mounted, it asks its widget '
                'for a fresh render object via createRenderObject(). On subsequent '
                'rebuilds with a new widget of the same type, the element calls '
                'updateRenderObject() to copy changed properties into the *existing* '
                'render object — the render object identity never changes for the '
                'same element.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        ..._kCreateUpdatePairs.map((entry) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _kDeepPurpleLight,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      entry.widgetName,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _kDeepPurple),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _mono(entry.createCall, color: _kCyanDark),
              SizedBox(height: 3),
              _mono(entry.updateCall, color: _kDeepPurple),
              if (entry.note.isNotEmpty) ...[
                SizedBox(height: 6),
                Text(entry.note, style: TextStyle(fontSize: 12, color: _kTextMuted, fontStyle: FontStyle.italic)),
              ],
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 3: Ancestor lookup ──
        _sectionHeader('3 · Ancestor Render-Object Lookup', Icons.account_tree_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('_findAncestorRenderObjectElement()'),
              SizedBox(height: 8),
              Text(
                'When a RenderObjectElement is mounted, it needs to attach its '
                'render object to the nearest ancestor render object. The problem '
                'is that not every Element owns a render object — StatefulElement, '
                'StatelessElement, InheritedElement, ProxyElement all sit between '
                'render-object-owning elements in the tree.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              ..._kAncestorLookupSteps.asMap().entries.map((e) => Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22, height: 22,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _kCyanDark,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${e.key + 1}',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(e.value, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('EXAMPLE TREE — RENDER OBJECT SPARSITY'),
              SizedBox(height: 8),
              _buildTreeDiagram(),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 4: ParentData propagation ──
        _sectionHeader('4 · ParentData Propagation', Icons.data_object),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ParentDataWidgets let a child configure how its parent lays it '
                'out — without holding a direct reference to the parent\'s render '
                'object. The ParentDataElement calls applyParentData() which writes '
                'into the child\'s render object\'s parentData field.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        ..._kParentDataExamples.map((ex) => _card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 90,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: _kCyanLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ex.widget,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _kCyanDark),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _mono(ex.parentData, color: _kDeepPurple),
                    SizedBox(height: 3),
                    Text(ex.usage, style: TextStyle(fontSize: 12, color: _kTextMuted)),
                  ],
                ),
              ),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 5: Slot management ──
        _sectionHeader('5 · Slot Management in Multi-Child Layouts', Icons.view_column_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _kSlotExplanation,
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              ..._kSlotSteps.map((s) => _bulletPoint(s)),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('SLOT TYPES BY WIDGET'),
              SizedBox(height: 8),
              _buildSlotTable(),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 6: Debug ──
        _buildDebugSection(),

        SizedBox(height: 12),

        // ── Section 7: Custom single-child ──
        _sectionHeader('7 · Custom SingleChildRenderObjectWidget', Icons.widgets_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('LIVE: _DemoInsetWidget'),
              SizedBox(height: 6),
              Text(
                'Below is a custom SingleChildRenderObjectWidget that wraps '
                'RenderPadding. Drag the slider to change the inset — each change '
                'triggers updateRenderObject() and prints to the console.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              Text('Inset: ${_insetValue.toStringAsFixed(0)} px',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Slider(
                value: _insetValue,
                min: 0,
                max: 40,
                divisions: 40,
                activeColor: _kCyanDark,
                onChanged: (v) {
                  setState(() => _insetValue = v);
                  print('[Slider] inset → ${v.toStringAsFixed(0)}');
                },
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _kDeepPurple, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _DemoInsetWidget(
                  inset: _insetValue,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [_kCyan, _kDeepPurple]),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text('Child content',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              SizedBox(height: 8),
              _mono('// createRenderObject called once at mount', color: _kTextMuted),
              _mono('// updateRenderObject called on every slider change', color: _kTextMuted),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('SOURCE OUTLINE'),
              SizedBox(height: 6),
              _mono('class _DemoInsetWidget extends SingleChildRenderObjectWidget {'),
              _mono('  final double inset;'),
              _mono(''),
              _mono('  @override'),
              _mono('  RenderObject createRenderObject(BuildContext context) {'),
              _mono('    return RenderPadding(padding: EdgeInsets.all(inset));'),
              _mono('  }'),
              _mono(''),
              _mono('  @override'),
              _mono('  void updateRenderObject(ctx, RenderPadding ro) {'),
              _mono('    ro.padding = EdgeInsets.all(inset);'),
              _mono('  }'),
              _mono(''),
              _mono('  @override'),
              _mono('  void didUnmountRenderObject(RenderPadding ro) {'),
              _mono('    // cleanup if needed'),
              _mono('  }'),
              _mono('}'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 8: Custom multi-child ──
        _sectionHeader('8 · Custom MultiChildRenderObjectWidget', Icons.layers_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('LIVE: _DemoOverlayWidget + ParentData'),
              SizedBox(height: 6),
              Text(
                'A custom MultiChildRenderObjectWidget that stacks children vertically. '
                'Each child is wrapped in a ParentDataWidget carrying an integer '
                'priority. The render object sets up custom parent data via '
                'setupParentData().',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _kCyan, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                child: _DemoOverlayWidget(
                  children: [
                    _DemoPriorityParentDataWidget(
                      priority: 1,
                      child: Container(
                        height: 36,
                        color: _kCyanLight,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('Priority 1 — Header',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: _kCyanDark)),
                      ),
                    ),
                    _DemoPriorityParentDataWidget(
                      priority: 2,
                      child: Container(
                        height: 36,
                        color: _kDeepPurpleLight,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('Priority 2 — Content',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: _kDeepPurple)),
                      ),
                    ),
                    _DemoPriorityParentDataWidget(
                      priority: 3,
                      child: Container(
                        height: 36,
                        color: _kCyanLight.withOpacity(0.5),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('Priority 3 — Footer',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('MULTI-CHILD ELEMENT INTERNALS'),
              SizedBox(height: 8),
              _bulletPoint('MultiChildRenderObjectElement manages a list of child Elements.'),
              _bulletPoint('It calls insertRenderObjectChild for each child in order.'),
              _bulletPoint('setupParentData() runs before the first layout to install '
                  'the correct ParentData subclass.'),
              _bulletPoint('When the child list changes, the framework diffs old vs new '
                  'using keys and calls insert/move/remove accordingly.'),
              _bulletPoint('ParentDataWidget.applyParentData() writes directly into '
                  'the child\'s render object parentData field.'),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('KEY TAKEAWAY'),
              SizedBox(height: 6),
              Text(
                'RenderObjectElement is the invisible bridge between the declarative '
                'widget tree you write and the mutable render tree that actually '
                'paints pixels. Understanding this bridge is essential for writing '
                'custom RenderObjectWidgets, debugging layout issues, and reasoning '
                'about performance — because the cost of a rebuild is *not* '
                'creating a new render object, but only calling updateRenderObject.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── flow-diagram helpers ──
  Widget _buildFlowRow(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(text,
          style: TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Widget _buildFlowArrow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Center(
        child: Icon(Icons.arrow_downward, size: 16, color: _kTextMuted),
      ),
    );
  }

  // ── tree diagram ──
  Widget _buildTreeDiagram() {
    const lines = <String>[
      'RenderObjectElement (Scaffold)  ← owns RenderFlex',
      '  └─ StatefulElement (AnimatedBuilder)  ← NO render object',
      '      └─ StatelessElement (Padding)  ← NO render object',
      '          └─ RenderObjectElement (Padding)  ← owns RenderPadding',
      '              └─ InheritedElement (Theme)  ← NO render object',
      '                  └─ RenderObjectElement (Text)  ← owns RenderParagraph',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((l) {
        final ownsRO = l.contains('owns');
        return Padding(
          padding: EdgeInsets.only(bottom: 3),
          child: Text(
            l,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: ownsRO ? _kCyanDark : _kTextMuted,
              fontWeight: ownsRO ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── slot table ──
  Widget _buildSlotTable() {
    const rows = <List<String>>[
      ['Row / Column', 'Element? (previous sibling)', 'Linked list order'],
      ['Stack', 'Element? (previous sibling)', 'Paint order = list order'],
      ['Table', 'int (linearized index)', 'Row-major index'],
      ['Overlay', 'OverlayEntry', 'Managed by OverlayState'],
    ];

    return Table(
      columnWidths: {
        0: FlexColumnWidth(1.2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      border: TableBorder.all(color: _kDivider, width: 0.5),
      children: [
        TableRow(
          decoration: BoxDecoration(color: _kCyanLight.withOpacity(0.4)),
          children: ['Widget', 'Slot Type', 'Note'].map((h) => Padding(
            padding: EdgeInsets.all(6),
            child: Text(h, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _kCyanDark)),
          )).toList(),
        ),
        ...rows.map((r) => TableRow(
          children: r.map((c) => Padding(
            padding: EdgeInsets.all(6),
            child: Text(c, style: TextStyle(fontSize: 11.5, color: _kTextDark)),
          )).toList(),
        )),
      ],
    );
  }
}
