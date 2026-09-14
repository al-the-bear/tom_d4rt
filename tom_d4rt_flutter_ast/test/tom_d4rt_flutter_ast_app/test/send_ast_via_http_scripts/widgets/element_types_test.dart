// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// D4rt visual deep demo — Element Types
//
// Walks through the Element class hierarchy and the role Elements play
// between the Widget tree (configuration) and the RenderObject tree
// (layout / paint). Covers the full mount / update / deactivate /
// unmount lifecycle, the rules of element reuse via canUpdate(), and
// the four major Element variants: StatelessElement, StatefulElement,
// InheritedElement (a ProxyElement) and the RenderObjectElement
// family (Single / Multi / Leaf).
//
// This file is a documentation page rendered with Flutter widgets.
// It does NOT instantiate any Element subclass directly — Elements are
// created by the framework. We describe them via diagrams, code blocks
// and explanatory cards.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Palette — element family colors used throughout the demo.
  // ============================================================
  final Color cBg = const Color(0xFFF5F7FB);
  final Color cInk = const Color(0xFF1F2330);
  final Color cInkSoft = const Color(0xFF4D5468);
  final Color cMuted = const Color(0xFF8A93A6);
  final Color cLine = const Color(0xFFE3E7EF);

  final Color cWidget = const Color(0xFF2563EB); // blue — config
  final Color cElement = const Color(0xFFB45309); // amber — bridge
  final Color cRender = const Color(0xFF059669); // green — paint

  final Color cStateless = const Color(0xFFD97706);
  final Color cStateful = const Color(0xFFB91C1C);
  final Color cInherited = const Color(0xFF7C3AED);
  final Color cRoElement = const Color(0xFF0F766E);

  final Color cSingle = const Color(0xFF0EA5E9);
  final Color cMulti = const Color(0xFF6366F1);
  final Color cLeaf = const Color(0xFF14B8A6);

  // ============================================================
  // SECTION DATA — three trees overview
  // ============================================================
  final List<Map<String, dynamic>> threeTrees = <Map<String, dynamic>>[
    <String, dynamic>{
      'tree': 'Widget Tree',
      'role': 'Configuration',
      'icon': Icons.description_outlined,
      'color': cWidget,
      'lifetime': 'short — recreated every build',
      'mutability': 'immutable',
      'examples': <String>[
        'Text("Hello")',
        'Padding(padding: EdgeInsets.all(8))',
        'Container(color: Colors.red)',
        'StatefulWidget subclasses',
      ],
      'job': 'Describe what the UI should look like, in plain Dart '
          'objects that are cheap to throw away.',
    },
    <String, dynamic>{
      'tree': 'Element Tree',
      'role': 'Bridge & Lifecycle',
      'icon': Icons.account_tree_outlined,
      'color': cElement,
      'lifetime': 'long — survives across rebuilds while keys + types match',
      'mutability': 'mutable',
      'examples': <String>[
        'StatelessElement',
        'StatefulElement',
        'InheritedElement',
        'RenderObjectElement (Single / Multi / Leaf)',
      ],
      'job': 'Hold identity, manage parent / child / slot, decide whether '
          'a Widget update can reuse the existing slot, drive build() '
          'for component widgets, and own the RenderObject for '
          'render widgets.',
    },
    <String, dynamic>{
      'tree': 'RenderObject Tree',
      'role': 'Layout & Paint',
      'icon': Icons.brush_outlined,
      'color': cRender,
      'lifetime': 'long — replaced only when the Element is replaced',
      'mutability': 'mutable',
      'examples': <String>[
        'RenderParagraph (Text)',
        'RenderFlex (Row / Column)',
        'RenderPadding',
        'RenderBox subclasses',
      ],
      'job': 'Perform layout (constraints down, sizes up), paint into a '
          'PictureLayer, and respond to hit-testing. Only '
          'RenderObjectWidgets create one; component widgets do not.',
    },
  ];

  // ============================================================
  // SECTION DATA — Element subclass tree (diagrammed)
  // ============================================================
  final List<Map<String, dynamic>> hierarchy = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'Element',
      'depth': 0,
      'color': cInk,
      'kind': 'abstract',
      'note': 'Root abstract class. Holds Widget reference, parent, slot, '
          'depth, owner. Implements BuildContext.',
    },
    <String, dynamic>{
      'name': 'ComponentElement',
      'depth': 1,
      'color': cElement,
      'kind': 'abstract',
      'note': 'For widgets that COMPOSE other widgets. Has a single child '
          'slot. Implements performRebuild → build → updateChild.',
    },
    <String, dynamic>{
      'name': 'StatelessElement',
      'depth': 2,
      'color': cStateless,
      'kind': 'concrete',
      'note': 'Backs StatelessWidget. build() returns widget.build(this).',
    },
    <String, dynamic>{
      'name': 'StatefulElement',
      'depth': 2,
      'color': cStateful,
      'kind': 'concrete',
      'note': 'Backs StatefulWidget. Owns the State object. build() '
          'returns state.build(this).',
    },
    <String, dynamic>{
      'name': 'ProxyElement',
      'depth': 2,
      'color': cInherited,
      'kind': 'abstract',
      'note': 'For widgets that wrap a single child without composing — '
          'they propagate information instead.',
    },
    <String, dynamic>{
      'name': 'InheritedElement',
      'depth': 3,
      'color': cInherited,
      'kind': 'concrete',
      'note': 'Backs InheritedWidget. Maintains dependent map and notifies '
          'descendants when updateShouldNotify returns true.',
    },
    <String, dynamic>{
      'name': 'RenderObjectElement',
      'depth': 1,
      'color': cRoElement,
      'kind': 'abstract',
      'note': 'For widgets that CREATE a RenderObject. Owns the render '
          'object directly; does NOT call build().',
    },
    <String, dynamic>{
      'name': 'LeafRenderObjectElement',
      'depth': 2,
      'color': cLeaf,
      'kind': 'concrete',
      'note': 'No children. e.g. RichText, RawImage, ColoredBox-leaf.',
    },
    <String, dynamic>{
      'name': 'SingleChildRenderObjectElement',
      'depth': 2,
      'color': cSingle,
      'kind': 'concrete',
      'note': 'Exactly one child. e.g. Padding, Align, Center, Opacity.',
    },
    <String, dynamic>{
      'name': 'MultiChildRenderObjectElement',
      'depth': 2,
      'color': cMulti,
      'kind': 'concrete',
      'note': 'List of children with slots = previous-sibling. e.g. Row, '
          'Column, Stack, Flex.',
    },
  ];

  // ============================================================
  // SECTION DATA — four Element variants
  // ============================================================
  final List<Map<String, dynamic>> variants = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'StatelessElement',
      'parent': 'ComponentElement',
      'icon': Icons.crop_din,
      'color': cStateless,
      'createdBy': 'StatelessWidget.createElement()',
      'overrides': <String>[
        'Widget build() => (widget as StatelessWidget).build(this)',
        'void update(StatelessWidget newWidget) → super + rebuild()',
      ],
      'why': 'StatelessElement is intentionally tiny. It just delegates '
          'to widget.build(this) and lets the framework reconcile the '
          'returned subtree. There is no per-instance state; all '
          'configuration comes from the (immutable) widget.',
      'lifeMatters': 'A new StatelessWidget instance arrives every '
          'rebuild; the StatelessElement is reused if runtimeType + '
          'key match. The element holds no fields of its own.',
    },
    <String, dynamic>{
      'name': 'StatefulElement',
      'parent': 'ComponentElement',
      'icon': Icons.timeline,
      'color': cStateful,
      'createdBy': 'StatefulWidget.createElement() (also calls createState)',
      'overrides': <String>[
        'Widget build() => state.build(this)',
        'void update(StatefulWidget newWidget) → state.didUpdateWidget(old)',
        'void activate() → state.activate()',
        'void deactivate() → state.deactivate()',
        'void unmount() → state.dispose()',
      ],
      'why': 'StatefulElement carries the State object across widget '
          'rebuilds. That is the entire point of StatefulWidget: keep '
          'something that survives configuration changes. The Element '
          'is the long-lived thing; the StatefulWidget instances are '
          'disposable wrappers.',
      'lifeMatters': 'When the parent rebuilds, a new StatefulWidget '
          'arrives. canUpdate matches → element keeps the same State '
          'instance, calls state.didUpdateWidget(old). That is how '
          'TextField keeps its cursor position across parent rebuilds.',
    },
    <String, dynamic>{
      'name': 'InheritedElement',
      'parent': 'ProxyElement',
      'icon': Icons.share_outlined,
      'color': cInherited,
      'createdBy': 'InheritedWidget.createElement()',
      'overrides': <String>[
        'void updated(InheritedWidget oldWidget) → notifyClients if changed',
        'void notifyClients(covariant InheritedWidget oldWidget)',
        'Object? getDependencies(Element dep) / setDependencies(...)',
        'void updateDependencies(Element dep, Object? aspect)',
      ],
      'why': 'InheritedElement is the only Element that maintains a '
          'reverse map: a Set<Element> of descendants that depend on '
          'this widget. When the InheritedWidget changes and '
          'updateShouldNotify returns true, every dependent Element '
          'is marked dirty.',
      'lifeMatters': 'context.dependOnInheritedWidgetOfExactType<T>() '
          'walks UP the element tree, finds the nearest '
          'InheritedElement of type T, and registers the calling '
          'element as a dependent. That is O(depth), not O(n).',
    },
    <String, dynamic>{
      'name': 'RenderObjectElement',
      'parent': 'Element',
      'icon': Icons.brush_outlined,
      'color': cRoElement,
      'createdBy': 'RenderObjectWidget.createElement()',
      'overrides': <String>[
        'void mount() → widget.createRenderObject(this); attach to parent',
        'void update(newWidget) → widget.updateRenderObject(this, ro)',
        'void unmount() → widget.didUnmountRenderObject(ro)',
        'void insertRenderObjectChild / moveRenderObjectChild / remove…',
      ],
      'why': 'RenderObjectElement is the seam between the Element world '
          'and the RenderObject world. It owns a RenderObject and '
          'forwards Widget changes to it. There is no build() — the '
          'render object IS the visual output.',
      'lifeMatters': 'When the framework finalizes layout, it walks the '
          'render tree, NOT the element tree. RenderObjectElement keeps '
          'them aligned: every change to its widget is mirrored to its '
          'render object via updateRenderObject.',
    },
  ];

  // ============================================================
  // SECTION DATA — RenderObjectElement subkinds
  // ============================================================
  final List<Map<String, dynamic>> renderSubkinds = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'LeafRenderObjectElement',
      'children': '0',
      'icon': Icons.circle_outlined,
      'color': cLeaf,
      'examples': 'RichText, RawImage, Texture, PerformanceOverlay',
      'note': 'Has no element children. Render object has no children. '
          'Common for terminal nodes that paint pixels themselves.',
    },
    <String, dynamic>{
      'name': 'SingleChildRenderObjectElement',
      'children': '1',
      'icon': Icons.expand,
      'color': cSingle,
      'examples': 'Padding, Align, Center, Opacity, Transform, '
          'ConstrainedBox, ColoredBox',
      'note': 'Exactly one child element. The RenderObject is a '
          'RenderProxyBox or similar single-child render object.',
    },
    <String, dynamic>{
      'name': 'MultiChildRenderObjectElement',
      'children': 'N',
      'icon': Icons.view_column,
      'color': cMulti,
      'examples': 'Row, Column, Stack, Flex, Wrap, ListBody, CustomMultiChildLayout',
      'note': 'Manages a List<Element> _children. Slot of each child is '
          'a reference to its previous sibling — that is how children '
          'are inserted into the linked list of the RenderObject.',
    },
  ];

  // ============================================================
  // SECTION DATA — full lifecycle
  // ============================================================
  final List<Map<String, dynamic>> lifecycle = <Map<String, dynamic>>[
    <String, dynamic>{
      'phase': 'initial',
      'step': '1',
      'name': 'createElement()',
      'color': cWidget,
      'who': 'Widget',
      'detail': 'The framework calls widget.createElement(). For '
          'StatelessWidget that returns StatelessElement(this); for '
          'StatefulWidget StatefulElement(this) which also calls '
          'createState() and stores the State.',
    },
    <String, dynamic>{
      'phase': 'initial',
      'step': '2',
      'name': 'mount(parent, newSlot)',
      'color': cElement,
      'who': 'Element',
      'detail': 'The element is inserted into the tree. _parent and _slot '
          'are set. _depth = parent.depth + 1. State becomes "active". '
          'For StatefulElement, state.initState() runs here, '
          'followed by state.didChangeDependencies().',
    },
    <String, dynamic>{
      'phase': 'initial',
      'step': '3',
      'name': 'performRebuild() → build()',
      'color': cElement,
      'who': 'ComponentElement',
      'detail': 'First build. ComponentElement calls build() which '
          'returns a child Widget. updateChild(null, newChild, slot) '
          'inflates the child Widget into a new child Element by '
          'calling newChild.createElement().mount(this, slot).',
    },
    <String, dynamic>{
      'phase': 'update',
      'step': '4',
      'name': 'parent rebuilds → update(newWidget)',
      'color': cInherited,
      'who': 'Element',
      'detail': 'Parent build() emits a new widget for this slot. '
          'Framework checks Widget.canUpdate(oldWidget, newWidget). '
          'If true, _widget = newWidget, _dirty = true, element '
          'queued for rebuild. State (for StatefulElement) is kept.',
    },
    <String, dynamic>{
      'phase': 'update',
      'step': '5',
      'name': 'markNeedsBuild()',
      'color': cStateful,
      'who': 'Element / setState',
      'detail': 'setState() in a State ultimately calls '
          'element.markNeedsBuild(), which adds the element to the '
          'BuildOwner._dirtyElements list. Nothing happens '
          'synchronously — the rebuild is scheduled for the next frame.',
    },
    <String, dynamic>{
      'phase': 'update',
      'step': '6',
      'name': 'rebuild() in next frame',
      'color': cElement,
      'who': 'BuildOwner',
      'detail': 'During the build phase, BuildOwner.buildScope sorts '
          'dirty elements by depth (ancestors first) and calls '
          'rebuild() → performRebuild() → build() on each. '
          'updateChild reconciles the new widget with the existing '
          'child element where possible.',
    },
    <String, dynamic>{
      'phase': 'remove',
      'step': '7',
      'name': 'deactivate()',
      'color': cMuted,
      'who': 'Element',
      'detail': 'Element is removed from its parent. State becomes '
          '"inactive". Element is added to BuildOwner._inactiveElements. '
          'It MAY come back this frame (e.g. GlobalKey reparenting), '
          'so resources are kept alive temporarily.',
    },
    <String, dynamic>{
      'phase': 'remove',
      'step': '8',
      'name': 'activate() (reparenting)',
      'color': cElement,
      'who': 'Element',
      'detail': 'Optional. If the element was deactivated and then '
          'matched against a new slot via GlobalKey, activate() runs '
          'instead of unmount(). State is preserved across the move.',
    },
    <String, dynamic>{
      'phase': 'remove',
      'step': '9',
      'name': 'unmount()',
      'color': cInk,
      'who': 'Element',
      'detail': 'End of frame, element was not reactivated. '
          'unmount() runs: child elements are unmounted recursively, '
          'state.dispose() runs, render objects are detached, and '
          '_widget is cleared. State becomes "defunct". The Element '
          'object becomes garbage.',
    },
  ];

  // ============================================================
  // SECTION DATA — canUpdate matrix
  // ============================================================
  final List<Map<String, dynamic>> canUpdateRules = <Map<String, dynamic>>[
    <String, dynamic>{
      'oldType': 'Padding',
      'oldKey': 'null',
      'newType': 'Padding',
      'newKey': 'null',
      'verdict': 'REUSE',
      'note': 'Same runtimeType, same null key → element kept, '
          'state preserved.',
      'color': cRoElement,
    },
    <String, dynamic>{
      'oldType': 'Counter',
      'oldKey': 'ValueKey("a")',
      'newType': 'Counter',
      'newKey': 'ValueKey("a")',
      'verdict': 'REUSE',
      'note': 'Both type and key match → state preserved.',
      'color': cRoElement,
    },
    <String, dynamic>{
      'oldType': 'Counter',
      'oldKey': 'ValueKey("a")',
      'newType': 'Counter',
      'newKey': 'ValueKey("b")',
      'verdict': 'REPLACE',
      'note': 'Different keys → old element is deactivated, new one '
          'created. State is LOST.',
      'color': cStateful,
    },
    <String, dynamic>{
      'oldType': 'Counter',
      'oldKey': 'null',
      'newType': 'Counter',
      'newKey': 'ValueKey("a")',
      'verdict': 'REPLACE',
      'note': 'Adding a key counts as a different identity.',
      'color': cStateful,
    },
    <String, dynamic>{
      'oldType': 'Container',
      'oldKey': 'null',
      'newType': 'Padding',
      'newKey': 'null',
      'verdict': 'REPLACE',
      'note': 'Different runtimeType → element replaced unconditionally. '
          'A subtree swap occurs.',
      'color': cStateful,
    },
    <String, dynamic>{
      'oldType': 'Counter',
      'oldKey': 'GlobalKey()',
      'newType': 'Counter',
      'newKey': 'same GlobalKey',
      'verdict': 'REUSE + MOVE',
      'note': 'GlobalKey allows the element to move across the tree '
          'without losing state. activate() instead of unmount().',
      'color': cInherited,
    },
  ];

  // ============================================================
  // SECTION DATA — build context = element
  // ============================================================
  final List<Map<String, dynamic>> contextFacts = <Map<String, dynamic>>[
    <String, dynamic>{
      'fact': 'BuildContext is just an Element',
      'icon': Icons.fingerprint,
      'detail': 'In Flutter, the BuildContext interface is implemented '
          'by Element. When you write build(BuildContext context), the '
          'context parameter IS the element backing the current widget. '
          'That is how Theme.of(context) can walk up the tree.',
      'color': cElement,
    },
    <String, dynamic>{
      'fact': 'context.findAncestor* walks the Element tree',
      'icon': Icons.alt_route,
      'detail': 'findAncestorWidgetOfExactType, '
          'findAncestorRenderObjectOfType, '
          'dependOnInheritedWidgetOfExactType — all use Element._parent '
          'links. The Widget tree is recreated each rebuild and cannot '
          'be walked; only the Element tree has stable parent links.',
      'color': cInherited,
    },
    <String, dynamic>{
      'fact': 'Do not use context after unmount',
      'icon': Icons.report_outlined,
      'detail': 'Once the Element is unmounted, context.mounted is '
          'false. Async callbacks must guard with `if (!context.mounted) '
          'return;` or capture values up-front. Calling Navigator.of '
          'on a defunct context throws.',
      'color': cStateful,
    },
    <String, dynamic>{
      'fact': 'Each widget has its OWN context',
      'icon': Icons.center_focus_strong,
      'detail': 'A common mistake is calling Theme.of(context) at the '
          'top of a build method that wraps in a Theme widget. The '
          'top-level context belongs to the parent element — it sees '
          'the OLD theme. Use a Builder to get a fresh context below '
          'the Theme widget.',
      'color': cStateless,
    },
  ];

  // ============================================================
  // SECTION DATA — pitfalls
  // ============================================================
  final List<Map<String, dynamic>> pitfalls = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Wrapping in a different type loses state',
      'icon': Icons.warning_amber_outlined,
      'color': cStateful,
      'detail': 'If you conditionally wrap a child in a Padding when '
          'some flag is true, the child changes runtimeType in the '
          'eyes of the parent slot — element replaced, state lost. '
          'Use a stable wrapper (always Padding with variable padding) '
          'or assign a Key.',
    },
    <String, dynamic>{
      'title': 'Reordering children without keys',
      'icon': Icons.swap_vert,
      'color': cMulti,
      'detail': 'In a Column, MultiChildRenderObjectElement matches '
          'children by index by default. Swapping the order of two '
          'StatefulWidget children without keys means each one keeps '
          'the OTHER one\'s state. Add ValueKey to each child.',
    },
    <String, dynamic>{
      'title': 'Calling setState in initState',
      'icon': Icons.error_outline,
      'color': cStateful,
      'detail': 'During mount, the element is already being built — '
          'markNeedsBuild during build is illegal. Use '
          'WidgetsBinding.instance.addPostFrameCallback or set state '
          'directly in initState without setState.',
    },
    <String, dynamic>{
      'title': 'Using context inside initState',
      'icon': Icons.bolt_outlined,
      'color': cInherited,
      'detail': 'context is valid in initState, but inherited '
          'dependencies are NOT yet wired up — '
          'dependOnInheritedWidgetOfExactType throws. Move that work '
          'to didChangeDependencies which runs immediately after.',
    },
    <String, dynamic>{
      'title': 'Holding the Widget across rebuilds',
      'icon': Icons.handyman_outlined,
      'color': cWidget,
      'detail': 'Widget instances are short-lived. Don\'t store '
          '"my parent\'s widget" in a field. Use the Element via '
          'context.findAncestor… or read the widget property from State '
          'fresh each call.',
    },
    <String, dynamic>{
      'title': 'GlobalKey thrash',
      'icon': Icons.vpn_key_outlined,
      'color': cElement,
      'detail': 'GlobalKey lookups are linear in the tree per frame. '
          'Allocating GlobalKey in build() creates a new key each '
          'rebuild — element identity is lost AND lookups are wasted. '
          'Always store GlobalKey as an instance field.',
    },
  ];

  // ============================================================
  // SECTION DATA — code blocks shown as monospace text
  // ============================================================
  final List<Map<String, dynamic>> codeBlocks = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'StatelessElement.build() — conceptual',
      'color': cStateless,
      'lines': <String>[
        'class StatelessElement extends ComponentElement {',
        '  StatelessElement(StatelessWidget super.widget);',
        '',
        '  @override',
        '  Widget build() => (widget as StatelessWidget).build(this);',
        '',
        '  @override',
        '  void update(StatelessWidget newWidget) {',
        '    super.update(newWidget);',
        '    rebuild(force: true);',
        '  }',
        '}',
      ],
    },
    <String, dynamic>{
      'title': 'StatefulElement — owns the State',
      'color': cStateful,
      'lines': <String>[
        'class StatefulElement extends ComponentElement {',
        '  StatefulElement(StatefulWidget widget) : super(widget) {',
        '    _state = widget.createState();',
        '    _state._element = this;',
        '    _state._widget = widget;',
        '  }',
        '',
        '  @override',
        '  Widget build() => _state.build(this);',
        '',
        '  @override',
        '  void update(StatefulWidget newWidget) {',
        '    super.update(newWidget);',
        '    final old = _state._widget;',
        '    _state._widget = newWidget;',
        '    _state.didUpdateWidget(old);',
        '    rebuild(force: true);',
        '  }',
        '',
        '  @override',
        '  void unmount() {',
        '    super.unmount();',
        '    _state.dispose();',
        '    _state._element = null;',
        '  }',
        '}',
      ],
    },
    <String, dynamic>{
      'title': 'InheritedElement — dependents map',
      'color': cInherited,
      'lines': <String>[
        'class InheritedElement extends ProxyElement {',
        '  final Map<Element, Object?> _dependents = HashMap();',
        '',
        '  @override',
        '  void updateDependencies(Element dependent, Object? aspect) {',
        '    setDependencies(dependent, null);',
        '  }',
        '',
        '  @override',
        '  void notifyClients(InheritedWidget oldWidget) {',
        '    for (final dep in _dependents.keys) {',
        '      notifyDependent(oldWidget, dep);',
        '    }',
        '  }',
        '',
        '  void notifyDependent(InheritedWidget old, Element dep) {',
        '    dep.didChangeDependencies();',
        '  }',
        '}',
      ],
    },
    <String, dynamic>{
      'title': 'SingleChildRenderObjectElement — render hookup',
      'color': cSingle,
      'lines': <String>[
        'class SingleChildRenderObjectElement',
        '    extends RenderObjectElement {',
        '  Element? _child;',
        '',
        '  @override',
        '  void mount(Element? parent, Object? newSlot) {',
        '    super.mount(parent, newSlot);',
        '    _child = updateChild(',
        '      _child,',
        '      (widget as SingleChildRenderObjectWidget).child,',
        '      null,',
        '    );',
        '  }',
        '',
        '  @override',
        '  void insertRenderObjectChild(',
        '      RenderObject child, Object? slot) {',
        '    final ro = renderObject as RenderObjectWithChildMixin;',
        '    ro.child = child;',
        '  }',
        '}',
      ],
    },
  ];

  // ============================================================
  // SECTION DATA — component vs render contrast
  // ============================================================
  final List<Map<String, dynamic>> contrast = <Map<String, dynamic>>[
    <String, dynamic>{
      'aspect': 'Has build() method',
      'component': 'YES — calls widget.build / state.build',
      'render': 'NO — produces a RenderObject directly',
    },
    <String, dynamic>{
      'aspect': 'Owns a RenderObject',
      'component': 'NO — only its descendants own one',
      'render': 'YES — exactly one, created at mount',
    },
    <String, dynamic>{
      'aspect': 'Number of children',
      'component': 'Exactly 1 (whatever build() returns)',
      'render': '0, 1 or N depending on subkind',
    },
    <String, dynamic>{
      'aspect': 'Reacts to setState',
      'component': 'YES — triggers performRebuild',
      'render': 'NO directly — only via parent ComponentElement',
    },
    <String, dynamic>{
      'aspect': 'Inflate cost',
      'component': 'Calls user code (build) — variable',
      'render': 'Cheap — just createRenderObject + attach',
    },
    <String, dynamic>{
      'aspect': 'Examples',
      'component': 'Stateless, Stateful, Inherited',
      'render': 'Padding, Row, RichText, ColoredBox',
    },
  ];

  // ============================================================
  // SECTION DATA — when reuse happens (truth table)
  // ============================================================
  final List<Map<String, dynamic>> reuseRules = <Map<String, dynamic>>[
    <String, dynamic>{
      'rule': 'Element reuse condition',
      'expression': 'oldWidget.runtimeType == newWidget.runtimeType '
          '&& oldWidget.key == newWidget.key',
      'detail': 'This is exactly Widget.canUpdate(old, new). It is '
          'static, fast, and called once per slot per frame.',
      'color': cElement,
    },
    <String, dynamic>{
      'rule': 'Why not reuse on different types?',
      'expression': 'StatefulElement holds a State<T> where T is the '
          'specific widget type. Different type → wrong State.',
      'detail': 'The framework would have to dispose state anyway, '
          'so it just creates a fresh element.',
      'color': cStateful,
    },
    <String, dynamic>{
      'rule': 'Why does key matter?',
      'expression': 'Two children with same type but different '
          'identities (e.g. todo items) — keys distinguish them.',
      'detail': 'Without keys, children of a list are matched by '
          'position; reordering scrambles state. With keys, the '
          'framework matches by key first.',
      'color': cMulti,
    },
    <String, dynamic>{
      'rule': 'GlobalKey identity',
      'expression': 'A GlobalKey points at most one Element across the '
          'entire tree. Moving the widget moves the element with state.',
      'detail': 'Implementation: BuildOwner._globalKeyRegistry maps '
          'key → element. Reparenting is just remove + reinsert.',
      'color': cInherited,
    },
  ];

  // ============================================================
  // SMALL HELPERS — built inline as widgets via local functions.
  // ============================================================
  Widget heroChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.32),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 14),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget heroPanel() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            cElement,
            cInherited,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.account_tree_outlined,
                    color: Colors.white, size: 28),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Element Types',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'The middle layer of the Flutter render pipeline',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            'Widgets describe what the UI should be. RenderObjects do '
            'the actual layout and painting. Elements live between '
            'them — they hold identity, manage lifecycle, and decide '
            'what gets rebuilt vs reused. This page walks through the '
            'Element class hierarchy from the abstract base down to '
            'StatelessElement, StatefulElement, InheritedElement, and '
            'the RenderObjectElement family.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 14,
              height: 1.55,
            ),
          ),
          SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              heroChip('build', Icons.build_outlined),
              heroChip('mount / unmount', Icons.swap_horiz),
              heroChip('canUpdate', Icons.compare_arrows),
              heroChip('reuse vs replace', Icons.recycling_outlined),
              heroChip('BuildContext', Icons.fingerprint),
            ],
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String number, String title, String subtitle,
      Color accent) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
      margin: EdgeInsets.only(top: 4, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: accent, width: 5),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: cInk,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: cInkSoft,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget treeColumn(Map<String, dynamic> tree) {
    final Color color = tree['color'] as Color;
    final List<String> examples = (tree['examples'] as List<String>);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border(
          top: BorderSide(color: color, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(tree['icon'] as IconData,
                    color: color, size: 20),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tree['tree'] as String,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      tree['role'] as String,
                      style: TextStyle(
                        color: cInkSoft,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: cBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'lifetime: ',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: cInk),
                    ),
                    Expanded(
                      child: Text(
                        tree['lifetime'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: cInkSoft,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  children: <Widget>[
                    Text(
                      'mutability: ',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: cInk),
                    ),
                    Expanded(
                      child: Text(
                        tree['mutability'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: cInkSoft,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            tree['job'] as String,
            style: TextStyle(
              fontSize: 13,
              color: cInkSoft,
              height: 1.5,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: examples
                .map<Widget>(
                  (String e) => Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: color.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      e,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget hierarchyDiagram() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: hierarchy.map<Widget>((Map<String, dynamic> h) {
          final int depth = h['depth'] as int;
          final Color color = h['color'] as Color;
          final String prefix;
          if (depth == 0) {
            prefix = '';
          } else if (depth == 1) {
            prefix = '├── ';
          } else if (depth == 2) {
            prefix = '│    ├── ';
          } else {
            prefix = '│    │    └── ';
          }
          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 110,
                  child: Text(
                    prefix,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: cMuted,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color, width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        h['name'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: color,
                        ),
                      ),
                      SizedBox(width: 6),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          h['kind'] as String,
                          style: TextStyle(
                            fontSize: 9,
                            color: color,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      h['note'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: cInkSoft,
                        height: 1.35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget variantCard(Map<String, dynamic> v) {
    final Color color = v['color'] as Color;
    final List<String> overrides = (v['overrides'] as List<String>);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: color, width: 5),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(v['icon'] as IconData,
                    color: color, size: 22),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      v['name'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        fontFamily: 'monospace',
                        color: color,
                      ),
                    ),
                    Text(
                      'extends ${v['parent']}',
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: cMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.cable_outlined, size: 14, color: color),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    v['createdBy'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Text(
            'overrides',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: cInk,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cInk,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: overrides
                  .map<Widget>(
                    (String line) => Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Text(
                        '  $line',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.92),
                          height: 1.45,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 12),
          Text(
            v['why'] as String,
            style: TextStyle(
              fontSize: 13,
              color: cInkSoft,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cBg,
              borderRadius: BorderRadius.circular(8),
              border: Border(
                left: BorderSide(color: color, width: 3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.lightbulb_outline,
                    size: 16, color: color),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    v['lifeMatters'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: cInkSoft,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
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

  Widget renderSubkindCard(Map<String, dynamic> r) {
    final Color color = r['color'] as Color;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(r['icon'] as IconData, color: color, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  r['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    fontFamily: 'monospace',
                    color: color,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'children: ${r['children']}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            r['note'] as String,
            style: TextStyle(
              fontSize: 12,
              color: cInkSoft,
              height: 1.45,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: cBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'examples: ${r['examples']}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: cInk,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lifecycleCard(Map<String, dynamic> step) {
    final Color color = step['color'] as Color;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Text(
              step['step'] as String,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        step['name'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: cInk,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        step['phase'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: color,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Text(
                  'caller: ${step['who']}',
                  style: TextStyle(
                    fontSize: 11,
                    color: cMuted,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  step['detail'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: cInkSoft,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget canUpdateRow(Map<String, dynamic> r) {
    final Color color = r['color'] as Color;
    final bool reuse = (r['verdict'] as String).startsWith('REUSE');
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
        border: Border.all(
          color: color.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('OLD',
                          style: TextStyle(
                              fontSize: 9,
                              color: cMuted,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6)),
                      SizedBox(height: 2),
                      Text(
                        r['oldType'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: cInk,
                        ),
                      ),
                      Text(
                        'key: ${r['oldKey']}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: cInkSoft,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward,
                    size: 16, color: cMuted),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('NEW',
                          style: TextStyle(
                              fontSize: 9,
                              color: cMuted,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6)),
                      SizedBox(height: 2),
                      Text(
                        r['newType'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: cInk,
                        ),
                      ),
                      Text(
                        'key: ${r['newKey']}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: cInkSoft,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      reuse
                          ? Icons.recycling_outlined
                          : Icons.cancel_outlined,
                      size: 14,
                      color: color,
                    ),
                    SizedBox(width: 5),
                    Text(
                      r['verdict'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: color,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            r['note'] as String,
            style: TextStyle(
              fontSize: 12,
              color: cInkSoft,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget contextFactCard(Map<String, dynamic> f) {
    final Color color = f['color'] as Color;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(f['icon'] as IconData, color: color, size: 18),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  f['fact'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: cInk,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  f['detail'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: cInkSoft,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget contrastTable() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: cInk,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 110,
                  child: Text(
                    'aspect',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'ComponentElement',
                    style: TextStyle(
                      color: cElement.withValues(alpha: 0.95),
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'RenderObjectElement',
                    style: TextStyle(
                      color: cRoElement.withValues(alpha: 0.95),
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...contrast.asMap().entries.map<Widget>((MapEntry<int, Map<String, dynamic>> e) {
            final int i = e.key;
            final Map<String, dynamic> row = e.value;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: i.isEven ? cBg : Colors.white,
                border: Border(
                  bottom: BorderSide(color: cLine, width: 1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 110,
                    child: Text(
                      row['aspect'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: cInk,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row['component'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: cInkSoft,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row['render'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: cInkSoft,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget codeBlock(Map<String, dynamic> cb) {
    final Color color = cb['color'] as Color;
    final List<String> lines = cb['lines'] as List<String>;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cInk,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.code, color: color, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    cb['title'] as String,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Text(
                  'dart',
                  style: TextStyle(
                    color: color.withValues(alpha: 0.7),
                    fontFamily: 'monospace',
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: lines
                  .map<Widget>(
                    (String line) => Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text(
                        line,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.92),
                          height: 1.5,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget pitfallCard(Map<String, dynamic> p) {
    final Color color = p['color'] as Color;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(p['icon'] as IconData, color: color, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  p['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: cInk,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  p['detail'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: cInkSoft,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reuseRuleCard(Map<String, dynamic> r) {
    final Color color = r['color'] as Color;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            r['rule'] as String,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: cInk,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding:
                EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              r['expression'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: color,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            r['detail'] as String,
            style: TextStyle(
              fontSize: 12,
              color: cInkSoft,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget footer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[cInk, cInkSoft],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.bookmark_outline,
                  color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Mental model takeaway',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'A Widget is a description. An Element is the description, '
            'made tangible — given a place in the tree, a parent, '
            'a slot, a stable identity. A RenderObject is the '
            'description, made visible — given a size, a position, '
            'a paint command. The Element is the only one of the '
            'three that you can stably point at across rebuilds, '
            'and that is exactly why BuildContext is implemented '
            'by Element. Every time you call setState, '
            'Theme.of(context), or addPostFrameCallback, you are '
            'reaching through this middle layer.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 13.5,
              height: 1.65,
            ),
          ),
          SizedBox(height: 18),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.format_list_numbered,
                    color: Colors.white, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Widget describes • Element identifies • '
                    'RenderObject paints',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      letterSpacing: 0.3,
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

  // ============================================================
  // ASSEMBLE PAGE
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Element Types — Visual Deep Demo',
    home: Scaffold(
      backgroundColor: cBg,
      appBar: AppBar(
        backgroundColor: cElement,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Icon(Icons.account_tree_outlined, size: 22),
            SizedBox(width: 10),
            Text(
              'Element Types',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Hero
            heroPanel(),

            SizedBox(height: 24),

            // 2. Three Trees overview
            sectionHeader(
              '1',
              'The Three Trees',
              'Widget → Element → RenderObject — Element is the middle.',
              cElement,
            ),
            ...threeTrees.map<Widget>(treeColumn),

            SizedBox(height: 16),

            // 3. Element class hierarchy diagram
            sectionHeader(
              '2',
              'Element class hierarchy',
              'From the abstract Element root down to concrete subclasses.',
              cInherited,
            ),
            hierarchyDiagram(),

            SizedBox(height: 16),

            // 4. The four main Element variants
            sectionHeader(
              '3',
              'Four major Element variants',
              'StatelessElement, StatefulElement, InheritedElement, RenderObjectElement.',
              cStateful,
            ),
            ...variants.map<Widget>(variantCard),

            SizedBox(height: 16),

            // 5. ComponentElement vs RenderObjectElement
            sectionHeader(
              '4',
              'ComponentElement vs RenderObjectElement',
              'Two siblings under Element with very different jobs.',
              cRoElement,
            ),
            contrastTable(),

            SizedBox(height: 16),

            // 6. RenderObjectElement subkinds
            sectionHeader(
              '5',
              'RenderObjectElement subkinds',
              'Leaf, single-child and multi-child render-object elements.',
              cMulti,
            ),
            ...renderSubkinds.map<Widget>(renderSubkindCard),

            SizedBox(height: 16),

            // 7. Lifecycle
            sectionHeader(
              '6',
              'Mount / Update / Deactivate / Unmount',
              'Every Element walks this lifecycle. setState lives at step 5.',
              cElement,
            ),
            ...lifecycle.map<Widget>(lifecycleCard),

            SizedBox(height: 16),

            // 8. canUpdate matrix
            sectionHeader(
              '7',
              'canUpdate() — when an Element is reused',
              'Same runtimeType + same key → reuse. Otherwise → replace.',
              cInherited,
            ),
            ...canUpdateRules.map<Widget>(canUpdateRow),

            SizedBox(height: 16),

            // 9. Reuse truth-table
            sectionHeader(
              '8',
              'Why reuse matters — and when it happens',
              'Element identity is what preserves State, scroll position, focus.',
              cStateful,
            ),
            ...reuseRules.map<Widget>(reuseRuleCard),

            SizedBox(height: 16),

            // 10. BuildContext == Element
            sectionHeader(
              '9',
              'BuildContext is just an Element',
              'The context parameter in build() is the backing element.',
              cInherited,
            ),
            ...contextFacts.map<Widget>(contextFactCard),

            SizedBox(height: 16),

            // 11. Code patterns
            sectionHeader(
              '10',
              'Conceptual implementations',
              'Sketches of what each Element subclass actually overrides.',
              cStateless,
            ),
            ...codeBlocks.map<Widget>(codeBlock),

            SizedBox(height: 16),

            // 12. Pitfalls
            sectionHeader(
              '11',
              'Pitfalls and gotchas',
              'Common ways to accidentally lose Element identity.',
              cStateful,
            ),
            ...pitfalls.map<Widget>(pitfallCard),

            SizedBox(height: 16),

            // 13. Quick recap chips
            sectionHeader(
              '12',
              'Quick recap',
              'A mental cheat-sheet for the Element layer.',
              cElement,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _recapChip('Element = identity', cElement),
                  _recapChip('Widget = config', cWidget),
                  _recapChip('RenderObject = paint', cRender),
                  _recapChip('build() lives on Component', cStateless),
                  _recapChip(
                      'createRenderObject lives on RO', cRoElement),
                  _recapChip('State lives on StatefulElement',
                      cStateful),
                  _recapChip('Inherited propagates updates',
                      cInherited),
                  _recapChip('canUpdate = type+key', cMulti),
                  _recapChip('GlobalKey = move-with-state',
                      cInherited),
                  _recapChip('context.mounted before async',
                      cStateful),
                ],
              ),
            ),

            SizedBox(height: 16),

            // 14. Quick API surface table
            sectionHeader(
              '13',
              'Quick API surface',
              'Methods you will hit when reading the framework source.',
              cRoElement,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _apiRow('Element.mount(parent, slot)',
                      'Insert into tree, set parent/slot/depth, become active.'),
                  _apiRow('Element.update(newWidget)',
                      'Adopt new widget config; mark dirty.'),
                  _apiRow('Element.activate()',
                      'Re-attach after a transient deactivate (e.g. GlobalKey move).'),
                  _apiRow('Element.deactivate()',
                      'Detach from tree but keep around for end-of-frame reuse.'),
                  _apiRow('Element.unmount()',
                      'Final teardown; State.dispose runs here.'),
                  _apiRow('Element.markNeedsBuild()',
                      'Add to BuildOwner dirty list for next frame.'),
                  _apiRow('Element.rebuild()',
                      'Drive performRebuild if dirty.'),
                  _apiRow('ComponentElement.performRebuild()',
                      'Call build(), then updateChild for the returned widget.'),
                  _apiRow('Element.updateChild(child, newWidget, slot)',
                      'Reconcile one slot: reuse, replace, insert or remove.'),
                  _apiRow('RenderObjectElement.insertRenderObjectChild',
                      'Hook child render object into parent render object.'),
                  _apiRow(
                      'InheritedElement.notifyClients(oldWidget)',
                      'Walk dependents and mark them needing rebuild.'),
                ],
              ),
            ),

            SizedBox(height: 24),

            // 15. Footer
            footer(),

            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}

// Recap chip helper kept at top-level so the inline Wrap in section 12
// can reference it cleanly.
Widget _recapChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: 11,
      ),
    ),
  );
}

Widget _apiRow(String name, String desc) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1F2330),
          ),
        ),
        SizedBox(height: 2),
        Text(
          desc,
          style: TextStyle(
            fontSize: 11.5,
            color: const Color(0xFF4D5468),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}
