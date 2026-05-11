// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_import
// D4rt test script: Deep Demo - Advanced RenderObjectWidget Patterns
// Comprehensive demonstration of LeafRenderObjectWidget,
// SingleChildRenderObjectWidget, MultiChildRenderObjectWidget, ParentDataWidget
// and their corresponding Element classes from package:flutter/widgets.dart.
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ==========================================================================
  // DATA COLLECTION - Instantiate concrete examples of each category and
  // capture metadata used by the visual sections below.
  // ==========================================================================

  // --- LeafRenderObjectWidget instances ----------------------------------
  // Real leaf render-object widgets have no children at all.
  const leafPlaceholder = Placeholder(
    color: Color(0xFF1976D2),
    strokeWidth: 2.0,
    fallbackHeight: 60.0,
    fallbackWidth: 120.0,
  );
  final leafErrorBox = ErrorWidget.withDetails(message: 'leaf demo');
  const leafProgress = CircularProgressIndicator(strokeWidth: 3.0);

  final leafGallery = <Map<String, dynamic>>[
    {
      'name': 'Placeholder',
      'runtimeType': leafPlaceholder.runtimeType.toString(),
      'note': 'Placeholder draws a labelled rectangle for layout previews.',
      'createElement': 'LeafRenderObjectElement',
      'createRenderObject': 'RenderCustomPaint (internal)',
    },
    {
      'name': 'ErrorWidget',
      'runtimeType': leafErrorBox.runtimeType.toString(),
      'note': 'Used by the framework to display widget build errors.',
      'createElement': 'LeafRenderObjectElement',
      'createRenderObject': 'RenderErrorBox',
    },
    {
      'name': 'CircularProgressIndicator',
      'runtimeType': leafProgress.runtimeType.toString(),
      'note': 'Renders a Material-style progress spinner. Stateful leaf-ish.',
      'createElement': 'StatefulElement → LeafRenderObjectElement (paint)',
      'createRenderObject': 'RenderCustomPaint',
    },
  ];

  // --- SingleChildRenderObjectWidget instances ---------------------------
  final singleChildPadding = Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(color: const Color(0xFFB39DDB), height: 24.0, width: 24.0),
  );
  const singleChildSizedBox = SizedBox(width: 48.0, height: 24.0);
  final singleChildCenter = Center(
    child: Container(
      color: const Color(0xFF80CBC4),
      width: 24.0,
      height: 24.0,
    ),
  );
  final singleChildAlign = Align(
    alignment: Alignment.topRight,
    child: Container(
      color: const Color(0xFFFFAB91),
      width: 16.0,
      height: 16.0,
    ),
  );
  final singleChildTransform = Transform.rotate(
    angle: 0.15,
    child: Container(
      color: const Color(0xFF90CAF9),
      width: 40.0,
      height: 24.0,
    ),
  );
  final singleChildClipRect = ClipRect(
    child: Container(
      color: const Color(0xFFFFE082),
      width: 48.0,
      height: 24.0,
    ),
  );
  final singleChildOpacity = Opacity(
    opacity: 0.55,
    child: Container(
      color: const Color(0xFFF48FB1),
      width: 40.0,
      height: 24.0,
    ),
  );
  final singleChildColoredBox = ColoredBox(
    color: const Color(0xFFA5D6A7),
    child: const SizedBox(width: 48.0, height: 24.0),
  );

  final singleChildGallery = <Map<String, dynamic>>[
    {
      'name': 'Padding',
      'widget': singleChildPadding,
      'runtimeType': singleChildPadding.runtimeType.toString(),
      'note': 'Adds insets around a single child. Pure layout adjustment.',
    },
    {
      'name': 'SizedBox',
      'widget': singleChildSizedBox,
      'runtimeType': singleChildSizedBox.runtimeType.toString(),
      'note': 'Forces a tight constraint with optional child.',
    },
    {
      'name': 'Center',
      'widget': singleChildCenter,
      'runtimeType': singleChildCenter.runtimeType.toString(),
      'note': 'Subclass of Align with Alignment.center.',
    },
    {
      'name': 'Align',
      'widget': singleChildAlign,
      'runtimeType': singleChildAlign.runtimeType.toString(),
      'note': 'Positions child within itself using AlignmentGeometry.',
    },
    {
      'name': 'Transform',
      'widget': singleChildTransform,
      'runtimeType': singleChildTransform.runtimeType.toString(),
      'note': 'Applies a 4x4 matrix transform to its child.',
    },
    {
      'name': 'ClipRect',
      'widget': singleChildClipRect,
      'runtimeType': singleChildClipRect.runtimeType.toString(),
      'note': 'Clips the child to the bounds of the render object.',
    },
    {
      'name': 'Opacity',
      'widget': singleChildOpacity,
      'runtimeType': singleChildOpacity.runtimeType.toString(),
      'note': 'Renders child at the given opacity in a saveLayer.',
    },
    {
      'name': 'ColoredBox',
      'widget': singleChildColoredBox,
      'runtimeType': singleChildColoredBox.runtimeType.toString(),
      'note': 'Cheaper than Container for solid colour backgrounds.',
    },
  ];

  // --- MultiChildRenderObjectWidget instances ----------------------------
  final multiRow = Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      SizedBox(width: 12.0, height: 12.0),
      SizedBox(width: 12.0, height: 12.0),
      SizedBox(width: 12.0, height: 12.0),
    ],
  );
  final multiColumn = Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      SizedBox(width: 12.0, height: 8.0),
      SizedBox(width: 24.0, height: 8.0),
      SizedBox(width: 36.0, height: 8.0),
    ],
  );
  final multiStack = Stack(
    children: const [
      SizedBox(width: 36.0, height: 36.0),
      SizedBox(width: 24.0, height: 24.0),
      SizedBox(width: 12.0, height: 12.0),
    ],
  );
  final multiWrap = Wrap(
    spacing: 4.0,
    runSpacing: 4.0,
    children: const [
      SizedBox(width: 16.0, height: 16.0),
      SizedBox(width: 16.0, height: 16.0),
      SizedBox(width: 16.0, height: 16.0),
      SizedBox(width: 16.0, height: 16.0),
    ],
  );
  final multiIndexedStack = IndexedStack(
    index: 1,
    children: const [
      SizedBox(width: 24.0, height: 24.0),
      SizedBox(width: 24.0, height: 24.0),
      SizedBox(width: 24.0, height: 24.0),
    ],
  );

  final multiChildGallery = <Map<String, dynamic>>[
    {
      'name': 'Row',
      'runtimeType': multiRow.runtimeType.toString(),
      'count': 3,
      'note': 'Horizontal Flex; children are RenderFlex children.',
    },
    {
      'name': 'Column',
      'runtimeType': multiColumn.runtimeType.toString(),
      'count': 3,
      'note': 'Vertical Flex; same Flex render object with vertical axis.',
    },
    {
      'name': 'Stack',
      'runtimeType': multiStack.runtimeType.toString(),
      'count': 3,
      'note': 'Overlays children; Positioned attaches StackParentData.',
    },
    {
      'name': 'Wrap',
      'runtimeType': multiWrap.runtimeType.toString(),
      'count': 4,
      'note': 'Multi-line flex layout; runs of children flow across axes.',
    },
    {
      'name': 'IndexedStack',
      'runtimeType': multiIndexedStack.runtimeType.toString(),
      'count': 3,
      'note': 'Stack subclass that paints only the active index.',
    },
  ];

  // --- ParentDataWidget instances ---------------------------------------
  const positioned = Positioned(
    left: 4.0,
    top: 8.0,
    width: 32.0,
    height: 32.0,
    child: SizedBox(),
  );
  const flexible = Flexible(flex: 2, child: SizedBox());
  const expanded = Expanded(flex: 3, child: SizedBox());

  final parentDataGallery = <Map<String, dynamic>>[
    {
      'name': 'Positioned',
      'runtimeType': positioned.runtimeType.toString(),
      'parent': 'Stack',
      'parentDataType': 'StackParentData',
      'note': 'Sets top/left/right/bottom/width/height on the StackParentData.',
    },
    {
      'name': 'Flexible',
      'runtimeType': flexible.runtimeType.toString(),
      'parent': 'Flex (Row, Column)',
      'parentDataType': 'FlexParentData',
      'note': 'Sets flex factor and FlexFit on the FlexParentData.',
    },
    {
      'name': 'Expanded',
      'runtimeType': expanded.runtimeType.toString(),
      'parent': 'Flex (Row, Column)',
      'parentDataType': 'FlexParentData',
      'note': 'Flexible with FlexFit.tight - always fills available space.',
    },
  ];

  // --- Anatomy table ------------------------------------------------------
  final anatomyRows = <Map<String, String>>[
    {
      'widget': 'LeafRenderObjectWidget',
      'element': 'LeafRenderObjectElement',
      'children': '0',
      'use': 'Atomic visuals: Placeholder, custom painters with no child.',
    },
    {
      'widget': 'SingleChildRenderObjectWidget',
      'element': 'SingleChildRenderObjectElement',
      'children': '1',
      'use': 'Decorators: Padding, SizedBox, Opacity, Transform, ClipRect.',
    },
    {
      'widget': 'MultiChildRenderObjectWidget',
      'element': 'MultiChildRenderObjectElement',
      'children': 'N',
      'use': 'Containers: Row, Column, Stack, Wrap, Flow, IndexedStack.',
    },
    {
      'widget': 'ParentDataWidget<T>',
      'element': 'ParentDataElement<T>',
      'children': '1',
      'use': 'Inject ParentData onto a child so a specific Multi parent reads it.',
    },
  ];

  // --- Recipe cards -------------------------------------------------------
  final recipes = <Map<String, String>>[
    {
      'title': 'Soft card frame',
      'primitives': 'ColoredBox + Padding + ClipRect',
      'recipe': 'Wrap content in ClipRect → ColoredBox → Padding for a clean tile.',
    },
    {
      'title': 'Fixed-size badge',
      'primitives': 'SizedBox + ColoredBox + Center',
      'recipe': 'SizedBox locks size, ColoredBox fills, Center positions glyph.',
    },
    {
      'title': 'Overlay corner mark',
      'primitives': 'Stack + Positioned + SizedBox',
      'recipe': 'Stack hosts base child; Positioned(top, right) injects parent data.',
    },
    {
      'title': 'Two-column proportion split',
      'primitives': 'Row + Expanded',
      'recipe': 'Row with two Expanded(flex: 2) and Expanded(flex: 3) children.',
    },
    {
      'title': 'Translucent overlay',
      'primitives': 'Opacity + ColoredBox',
      'recipe': 'Opacity(0.4) wrapping ColoredBox dims an entire subtree.',
    },
    {
      'title': 'Rotated sticker',
      'primitives': 'Transform.rotate + Padding',
      'recipe': 'Rotate child slightly, pad to keep tap target predictable.',
    },
    {
      'title': 'Flow tag cloud',
      'primitives': 'Wrap + Padding + ColoredBox',
      'recipe': 'Wrap auto-flows tag chips into multiple runs.',
    },
    {
      'title': 'Animated cross-fade index',
      'primitives': 'IndexedStack + Opacity',
      'recipe': 'IndexedStack flips between layered children by index.',
    },
  ];

  // --- Comparison table ---------------------------------------------------
  final comparison = <Map<String, String>>[
    {
      'aspect': 'Owns RenderObject',
      'leaf': 'yes',
      'single': 'yes',
      'multi': 'yes',
      'parent': 'no (delegates)',
      'stateless': 'no',
    },
    {
      'aspect': 'Has child slots',
      'leaf': 'none',
      'single': 'one',
      'multi': 'list',
      'parent': 'one + injects data',
      'stateless': 'whatever build returns',
    },
    {
      'aspect': 'Affects paint directly',
      'leaf': 'yes',
      'single': 'yes',
      'multi': 'yes',
      'parent': 'indirect via parent',
      'stateless': 'no - composes others',
    },
    {
      'aspect': 'Element subclass',
      'leaf': 'Leaf',
      'single': 'SingleChild',
      'multi': 'MultiChild',
      'parent': 'ParentDataElement',
      'stateless': 'StatelessElement',
    },
    {
      'aspect': 'Typical cost',
      'leaf': 'low',
      'single': 'low',
      'multi': 'medium',
      'parent': 'tiny (metadata)',
      'stateless': 'depends on build()',
    },
  ];

  // --- Glossary -----------------------------------------------------------
  final glossary = <Map<String, String>>[
    {
      'term': 'RenderObjectWidget',
      'def': 'Widget that owns a RenderObject in the render tree.',
    },
    {
      'term': 'LeafRenderObjectWidget',
      'def': 'RenderObjectWidget with zero children. Creates LeafRenderObjectElement.',
    },
    {
      'term': 'SingleChildRenderObjectWidget',
      'def': 'RenderObjectWidget with exactly one child slot.',
    },
    {
      'term': 'MultiChildRenderObjectWidget',
      'def': 'RenderObjectWidget with a List<Widget> children.',
    },
    {
      'term': 'ParentDataWidget<T>',
      'def': 'Proxy widget that writes ParentData of type T onto its child.',
    },
    {
      'term': 'ParentData',
      'def': 'Layout metadata a parent RenderObject keeps for each child.',
    },
    {
      'term': 'createElement()',
      'def': 'Widget hook that returns the matching Element subclass.',
    },
    {
      'term': 'createRenderObject(context)',
      'def': 'Widget hook that returns the RenderObject for this slot.',
    },
    {
      'term': 'updateRenderObject(context, ro)',
      'def': 'Pushes new widget values onto an existing RenderObject.',
    },
    {
      'term': 'Element',
      'def': 'Mutable instantiation of a Widget; tracks identity and lifecycle.',
    },
    {
      'term': 'RenderObject',
      'def': 'Layout/paint/hit-test primitive in the render tree.',
    },
    {
      'term': 'StackParentData',
      'def': 'ParentData used by RenderStack to store top/left/right/bottom.',
    },
    {
      'term': 'FlexParentData',
      'def': 'ParentData used by RenderFlex (Row/Column) for flex factor + fit.',
    },
  ];

  // ==========================================================================
  // PRINTED DIAGNOSTIC LINE - cheap proof the script executed end to end.
  // ==========================================================================
  print('Render object widgets adv (deep demo) prepared.');
  print('Leaf entries:        ${leafGallery.length}');
  print('SingleChild entries: ${singleChildGallery.length}');
  print('MultiChild entries:  ${multiChildGallery.length}');
  print('ParentData entries:  ${parentDataGallery.length}');
  print('Recipe count:        ${recipes.length}');
  print('Glossary terms:      ${glossary.length}');

  // ==========================================================================
  // BUILD UI
  // ==========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ============================================================
              // HEADER
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF311B92), Color(0xFF512DA8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'RenderObjectWidget Patterns',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'Leaf · SingleChild · MultiChild · ParentDataWidget',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFFD1C4E9),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'Deep demo: the three-tree relationship (Widget → Element → RenderObject)'
                      ' walked through real Flutter primitives.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFFEDE7F6),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 1 - DOSSIER
              // ============================================================
              _sectionHeader('1. Dossier', 'When to reach for which base class',
                  const Color(0xFF311B92)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFFB39DDB), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _DossierLine(
                      icon: 'L',
                      title: 'LeafRenderObjectWidget',
                      body: 'No children. Paints itself entirely. Use for '
                          'atomic visuals like Placeholder or custom painted glyphs.',
                      color: Color(0xFF1976D2),
                    ),
                    SizedBox(height: 8.0),
                    _DossierLine(
                      icon: 'S',
                      title: 'SingleChildRenderObjectWidget',
                      body: 'Exactly one child. Decorates/transforms. Use for '
                          'Padding, Opacity, Transform, ClipRect, ColoredBox.',
                      color: Color(0xFF388E3C),
                    ),
                    SizedBox(height: 8.0),
                    _DossierLine(
                      icon: 'M',
                      title: 'MultiChildRenderObjectWidget',
                      body: 'List of children. Layout containers. Use for Row, '
                          'Column, Stack, Wrap, Flow, IndexedStack.',
                      color: Color(0xFFEF6C00),
                    ),
                    SizedBox(height: 8.0),
                    _DossierLine(
                      icon: 'P',
                      title: 'ParentDataWidget<T>',
                      body: 'Wraps a single child to inject ParentData of type '
                          'T. Use Positioned inside Stack, Flexible/Expanded inside Flex.',
                      color: Color(0xFFC2185B),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 2 - ANATOMY TABLE
              // ============================================================
              _sectionHeader(
                  '2. Anatomy', 'Class hierarchy and lifecycle hooks',
                  const Color(0xFF311B92)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFFB0BEC5), width: 1.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Widget base',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Element class',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '#',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            'Use case',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    for (final row in anatomyRows)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                row['widget']!,
                                style: const TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                row['element']!,
                                style: const TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF1976D2),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                row['children']!,
                                style: const TextStyle(fontSize: 11.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                row['use']!,
                                style: const TextStyle(fontSize: 11.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Lifecycle hooks every RenderObjectWidget overrides:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            '• createElement() → returns the right Element subclass',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            '• createRenderObject(BuildContext) → builds the RenderObject',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            '• updateRenderObject(BuildContext, RenderObject) → in-place mutation',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            '• didUnmountRenderObject(RenderObject) → cleanup',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 3 - LEAF GALLERY
              // ============================================================
              _sectionHeader('3. Leaf gallery',
                  'LeafRenderObjectWidget — zero children',
                  const Color(0xFF1976D2)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFF64B5F6), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Each leaf paints itself with no slot to fill.',
                      style: TextStyle(fontSize: 12.0, height: 1.4),
                    ),
                    const SizedBox(height: 12.0),
                    // Three-tree diagram
                    _ThreeTreeDiagram(
                      widgetLabel: 'LeafRenderObjectWidget',
                      elementLabel: 'LeafRenderObjectElement',
                      renderLabel: 'RenderObject (no children)',
                      slot: 'no slot',
                      color: const Color(0xFF1976D2),
                    ),
                    const SizedBox(height: 14.0),
                    for (final item in leafGallery)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: _GalleryCard(
                          name: item['name'] as String,
                          typeLabel: item['runtimeType'] as String,
                          note: item['note'] as String,
                          accent: const Color(0xFF1976D2),
                          preview: SizedBox(
                            width: 80.0,
                            height: 56.0,
                            child: Center(
                              child: Container(
                                width: 60.0,
                                height: 36.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFBBDEFB),
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                    color: const Color(0xFF1976D2),
                                    width: 1.0,
                                  ),
                                ),
                                child: Text(
                                  (item['name'] as String).substring(0, 1),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0D47A1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          extras: [
                            'createElement: ${item['createElement']}',
                            'createRenderObject: ${item['createRenderObject']}',
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 4 - SINGLECHILD GALLERY
              // ============================================================
              _sectionHeader('4. SingleChildRenderObjectWidget gallery',
                  'Exactly one child slot',
                  const Color(0xFF388E3C)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFF81C784), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'A single child slot, decorated, sized or transformed by the parent.',
                      style: TextStyle(fontSize: 12.0, height: 1.4),
                    ),
                    const SizedBox(height: 12.0),
                    _ThreeTreeDiagram(
                      widgetLabel: 'SingleChildRenderObjectWidget',
                      elementLabel: 'SingleChildRenderObjectElement',
                      renderLabel: 'RenderObjectWithChildMixin',
                      slot: '1 slot',
                      color: const Color(0xFF388E3C),
                    ),
                    const SizedBox(height: 14.0),
                    for (final item in singleChildGallery)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: _GalleryCard(
                          name: item['name'] as String,
                          typeLabel: item['runtimeType'] as String,
                          note: item['note'] as String,
                          accent: const Color(0xFF388E3C),
                          preview: SizedBox(
                            width: 80.0,
                            height: 56.0,
                            child: Center(child: item['widget'] as Widget),
                          ),
                          extras: const [
                            'createElement: SingleChildRenderObjectElement',
                            'createRenderObject: subclass of RenderObject',
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 5 - MULTICHILD GALLERY
              // ============================================================
              _sectionHeader('5. MultiChildRenderObjectWidget gallery',
                  'A List<Widget> of children', const Color(0xFFEF6C00)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFFFFB74D), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'A list of children managed via ContainerRenderObjectMixin '
                      '(linked-list of child RenderObjects).',
                      style: TextStyle(fontSize: 12.0, height: 1.4),
                    ),
                    const SizedBox(height: 12.0),
                    _ThreeTreeDiagram(
                      widgetLabel: 'MultiChildRenderObjectWidget',
                      elementLabel: 'MultiChildRenderObjectElement',
                      renderLabel: 'ContainerRenderObjectMixin',
                      slot: 'N slots',
                      color: const Color(0xFFEF6C00),
                    ),
                    const SizedBox(height: 14.0),
                    _GalleryCard(
                      name: 'Row',
                      typeLabel: multiRow.runtimeType.toString(),
                      note: multiChildGallery[0]['note'] as String,
                      accent: const Color(0xFFEF6C00),
                      preview: SizedBox(
                        width: 100.0,
                        height: 56.0,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _miniBox(const Color(0xFFFFCC80)),
                              const SizedBox(width: 4.0),
                              _miniBox(const Color(0xFFFFB74D)),
                              const SizedBox(width: 4.0),
                              _miniBox(const Color(0xFFFF9800)),
                            ],
                          ),
                        ),
                      ),
                      extras: const [
                        'RenderObject: RenderFlex (axis: horizontal)',
                        'ParentData: FlexParentData',
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _GalleryCard(
                      name: 'Column',
                      typeLabel: multiColumn.runtimeType.toString(),
                      note: multiChildGallery[1]['note'] as String,
                      accent: const Color(0xFFEF6C00),
                      preview: SizedBox(
                        width: 100.0,
                        height: 56.0,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _miniBox(const Color(0xFFFFCC80), w: 24.0, h: 8.0),
                              const SizedBox(height: 2.0),
                              _miniBox(const Color(0xFFFFB74D), w: 36.0, h: 8.0),
                              const SizedBox(height: 2.0),
                              _miniBox(const Color(0xFFFF9800), w: 48.0, h: 8.0),
                            ],
                          ),
                        ),
                      ),
                      extras: const [
                        'RenderObject: RenderFlex (axis: vertical)',
                        'ParentData: FlexParentData',
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _GalleryCard(
                      name: 'Stack',
                      typeLabel: multiStack.runtimeType.toString(),
                      note: multiChildGallery[2]['note'] as String,
                      accent: const Color(0xFFEF6C00),
                      preview: SizedBox(
                        width: 100.0,
                        height: 56.0,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              _miniBox(const Color(0xFFFFCC80), w: 40.0, h: 40.0),
                              _miniBox(const Color(0xFFFF9800), w: 24.0, h: 24.0),
                              _miniBox(const Color(0xFFE65100), w: 10.0, h: 10.0),
                            ],
                          ),
                        ),
                      ),
                      extras: const [
                        'RenderObject: RenderStack',
                        'ParentData: StackParentData',
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _GalleryCard(
                      name: 'Wrap',
                      typeLabel: multiWrap.runtimeType.toString(),
                      note: multiChildGallery[3]['note'] as String,
                      accent: const Color(0xFFEF6C00),
                      preview: SizedBox(
                        width: 100.0,
                        height: 56.0,
                        child: Center(
                          child: Wrap(
                            spacing: 2.0,
                            runSpacing: 2.0,
                            children: [
                              _miniBox(const Color(0xFFFFCC80), w: 16.0, h: 16.0),
                              _miniBox(const Color(0xFFFFB74D), w: 16.0, h: 16.0),
                              _miniBox(const Color(0xFFFF9800), w: 16.0, h: 16.0),
                              _miniBox(const Color(0xFFFB8C00), w: 16.0, h: 16.0),
                            ],
                          ),
                        ),
                      ),
                      extras: const [
                        'RenderObject: RenderWrap',
                        'ParentData: WrapParentData',
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _GalleryCard(
                      name: 'IndexedStack',
                      typeLabel: multiIndexedStack.runtimeType.toString(),
                      note: multiChildGallery[4]['note'] as String,
                      accent: const Color(0xFFEF6C00),
                      preview: SizedBox(
                        width: 100.0,
                        height: 56.0,
                        child: Center(
                          child: Container(
                            width: 36.0,
                            height: 36.0,
                            color: const Color(0xFFFFB74D),
                            child: const Center(
                              child: Text(
                                '#1',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      extras: const [
                        'RenderObject: RenderIndexedStack',
                        'Paints only the child at `index`.',
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 6 - PARENTDATAWIDGET GALLERY
              // ============================================================
              _sectionHeader('6. ParentDataWidget gallery',
                  'Inject ParentData into a child slot',
                  const Color(0xFFC2185B)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE4EC),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFFF06292), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'A ParentDataWidget does not own a RenderObject. It mutates'
                      ' the parentData field of its child render object so that the'
                      ' parent layout reads layout hints.',
                      style: TextStyle(fontSize: 12.0, height: 1.4),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Diagram: Positioned inside Stack',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Stack(children: [Positioned(top: 8, child: X)])\n'
                            '   │\n'
                            '   ▼\n'
                            'RenderStack ← reads StackParentData from child X\n'
                            '   ▲\n'
                            '   │ injected by Positioned (a ParentDataWidget<StackParentData>)\n',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    // Live demo: Stack + Positioned
                    Container(
                      width: 160.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: const Color(0xFFC2185B),
                          width: 1.0,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 6.0,
                            top: 6.0,
                            child: Container(
                              width: 30.0,
                              height: 14.0,
                              color: const Color(0xFFF06292),
                              child: const Center(
                                child: Text(
                                  'TL',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 6.0,
                            top: 6.0,
                            child: Container(
                              width: 30.0,
                              height: 14.0,
                              color: const Color(0xFFEC407A),
                              child: const Center(
                                child: Text(
                                  'TR',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 6.0,
                            bottom: 6.0,
                            child: Container(
                              width: 30.0,
                              height: 14.0,
                              color: const Color(0xFFD81B60),
                              child: const Center(
                                child: Text(
                                  'BL',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 6.0,
                            bottom: 6.0,
                            child: Container(
                              width: 30.0,
                              height: 14.0,
                              color: const Color(0xFFAD1457),
                              child: const Center(
                                child: Text(
                                  'BR',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    // Live demo: Row + Expanded/Flexible
                    Container(
                      width: double.infinity,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: const Color(0xFFC2185B),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: const Color(0xFFF06292),
                              child: const Center(
                                child: Text(
                                  'flex 1',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: const Color(0xFFEC407A),
                              child: const Center(
                                child: Text(
                                  'flex 2',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Container(
                              color: const Color(0xFFAD1457),
                              child: const Center(
                                child: Text(
                                  'loose',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    for (final item in parentDataGallery)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                  color: Color(0xFFC2185B),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'parent: ${item['parent']} · '
                                'parentData: ${item['parentDataType']}',
                                style: const TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF424242),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                item['note'] as String,
                                style: const TextStyle(
                                  fontSize: 11.0,
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

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 7 - ELEMENT TREE DIAGRAM
              // ============================================================
              _sectionHeader('7. Element-tree visualization',
                  'Widget : Element : RenderObject correspondence',
                  const Color(0xFF263238)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFF90A4AE), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Every widget produces exactly one element. Render-object widgets'
                      ' attach a render object too. ParentDataWidgets attach no render'
                      ' object but mutate the child\'s parentData.',
                      style: TextStyle(fontSize: 12.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    _correspondenceRow('Placeholder', 'LeafRenderObjectWidget',
                        'LeafRenderObjectElement', 'RenderCustomPaint'),
                    _correspondenceRow('Padding', 'SingleChildRenderObjectWidget',
                        'SingleChildRenderObjectElement', 'RenderPadding'),
                    _correspondenceRow('Opacity', 'SingleChildRenderObjectWidget',
                        'SingleChildRenderObjectElement', 'RenderOpacity'),
                    _correspondenceRow('Row', 'MultiChildRenderObjectWidget',
                        'MultiChildRenderObjectElement', 'RenderFlex'),
                    _correspondenceRow('Column', 'MultiChildRenderObjectWidget',
                        'MultiChildRenderObjectElement', 'RenderFlex'),
                    _correspondenceRow('Stack', 'MultiChildRenderObjectWidget',
                        'MultiChildRenderObjectElement', 'RenderStack'),
                    _correspondenceRow('Positioned', 'ParentDataWidget<StackParentData>',
                        'ParentDataElement<StackParentData>', '— (mutates child parentData)'),
                    _correspondenceRow('Flexible', 'ParentDataWidget<FlexParentData>',
                        'ParentDataElement<FlexParentData>', '— (mutates child parentData)'),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 8 - RECIPE CARDS
              // ============================================================
              _sectionHeader('8. Recipes',
                  'Composing custom-feeling widgets from primitives',
                  const Color(0xFF00838F)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F7FA),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFF4DD0E1), width: 1.0),
                ),
                child: Column(
                  children: [
                    for (final r in recipes)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                  color: Color(0xFF00838F),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB2EBF2),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  r['primitives']!,
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Text(
                                r['recipe']!,
                                style: const TextStyle(
                                  fontSize: 11.0,
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

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 9 - COMPARISON TABLE
              // ============================================================
              _sectionHeader('9. Comparison table',
                  'Leaf · Single · Multi · ParentData · vs StatelessWidget',
                  const Color(0xFF5D4037)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEBE9),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFFA1887F), width: 1.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Aspect',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Leaf',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Single',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Multi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Parent',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Stateless',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    for (final row in comparison)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                row['aspect']!,
                                style: const TextStyle(fontSize: 10.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                row['leaf']!,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                row['single']!,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                row['multi']!,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                row['parent']!,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                row['stateless']!,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 10 - GLOSSARY
              // ============================================================
              _sectionHeader('10. Glossary', 'Core vocabulary',
                  const Color(0xFF3F51B5)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFF7986CB), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final g in glossary)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150.0,
                              child: Text(
                                g['term']!,
                                style: const TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                g['def']!,
                                style: const TextStyle(
                                  fontSize: 11.0,
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

              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 11 - FINAL COMPOSED TREE
              // ============================================================
              _sectionHeader('11. Final composed widget tree',
                  'Everything you just learned, glued into one demo',
                  const Color(0xFF1B5E20)),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFF66BB6A), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'A small composite that mixes leaf, single-child, multi-child '
                      'and ParentDataWidgets all at once.',
                      style: TextStyle(fontSize: 12.0, height: 1.4),
                    ),
                    const SizedBox(height: 12.0),
                    // The composite
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          // SingleChild: ColoredBox wrapping a Leaf (Placeholder)
                          Expanded(
                            flex: 1,
                            child: ColoredBox(
                              color: const Color(0xFFC8E6C9),
                              child: const SizedBox(
                                height: 64.0,
                                child: Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Placeholder(
                                    color: Color(0xFF1B5E20),
                                    strokeWidth: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          // Multi: Stack with Positioned ParentDataWidget
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 64.0,
                              child: Stack(
                                children: [
                                  // SingleChild: ColoredBox base
                                  const Positioned.fill(
                                    child: ColoredBox(
                                      color: Color(0xFFA5D6A7),
                                    ),
                                  ),
                                  // Positioned ParentDataWidget
                                  Positioned(
                                    right: 6.0,
                                    top: 6.0,
                                    child: Opacity(
                                      opacity: 0.85,
                                      child: ColoredBox(
                                        color: const Color(0xFF2E7D32),
                                        child: const SizedBox(
                                          width: 28.0,
                                          height: 16.0,
                                          child: Center(
                                            child: Text(
                                              'PD',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SingleChild: Transform + Padding
                                  Center(
                                    child: Transform.rotate(
                                      angle: -0.1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ColoredBox(
                                          color: const Color(0xFF1B5E20),
                                          child: const SizedBox(
                                            width: 40.0,
                                            height: 14.0,
                                            child: Center(
                                              child: Text(
                                                'core',
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
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
                    const SizedBox(height: 10.0),
                    const Text(
                      'Tree breakdown:\n'
                      '• Row              → MultiChildRenderObjectWidget\n'
                      '  ├── Expanded     → ParentDataWidget<FlexParentData>\n'
                      '  │    └── ColoredBox → SingleChild\n'
                      '  │         └── SizedBox → SingleChild\n'
                      '  │              └── Padding → SingleChild\n'
                      '  │                   └── Placeholder → Leaf\n'
                      '  └── Expanded     → ParentDataWidget<FlexParentData>\n'
                      '       └── SizedBox → SingleChild\n'
                      '            └── Stack → MultiChild\n'
                      '                 ├── Positioned → ParentDataWidget<StackParentData>\n'
                      '                 │    └── ColoredBox → SingleChild\n'
                      '                 ├── Positioned → ParentDataWidget<StackParentData>\n'
                      '                 │    └── Opacity → SingleChild\n'
                      '                 │         └── ColoredBox → SingleChild\n'
                      '                 │              └── SizedBox → SingleChild\n'
                      '                 └── Center → SingleChild\n'
                      '                      └── Transform → SingleChild\n'
                      '                           └── Padding → SingleChild\n'
                      '                                └── ColoredBox → SingleChild\n'
                      '                                     └── SizedBox → SingleChild',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ============================================================
              // FOOTER
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF263238),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Summary',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '• Leaf, Single, Multi own render objects.\n'
                      '• ParentDataWidget does not — it carries metadata.\n'
                      '• Every RenderObjectWidget creates its own Element subclass.\n'
                      '• Positioned only works inside Stack, Flexible/Expanded only inside Flex.\n'
                      '• Combine these primitives instead of subclassing RenderObject.',
                      style: TextStyle(
                        color: Color(0xFFB0BEC5),
                        fontSize: 11.0,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Deep Demo • RenderObjectWidget hierarchy • flutter/widgets.dart',
                      style: TextStyle(
                        color: Color(0xFF78909C),
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// HELPER WIDGETS - kept as private classes / functions to keep build() linear.
// ============================================================================

Widget _sectionHeader(String title, String subtitle, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFFECEFF1),
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );
}

Widget _miniBox(Color color, {double w = 12.0, double h = 12.0}) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(2.0),
    ),
  );
}

Widget _correspondenceRow(
  String widgetName,
  String widgetBase,
  String elementName,
  String renderObject,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF263238),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  widgetName,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  ': $widgetBase',
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF455A64),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            '   Element     → $elementName',
            style: const TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFF1976D2),
            ),
          ),
          Text(
            '   RenderObject→ $renderObject',
            style: const TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFF388E3C),
            ),
          ),
        ],
      ),
    ),
  );
}

class _DossierLine extends StatelessWidget {
  final String icon;
  final String title;
  final String body;
  final Color color;

  const _DossierLine({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: Text(
            icon,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: const TextStyle(fontSize: 11.0, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThreeTreeDiagram extends StatelessWidget {
  final String widgetLabel;
  final String elementLabel;
  final String renderLabel;
  final String slot;
  final Color color;

  const _ThreeTreeDiagram({
    required this.widgetLabel,
    required this.elementLabel,
    required this.renderLabel,
    required this.slot,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color, width: 1.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: _treeNode('Widget', widgetLabel, color),
          ),
          Icon(Icons.arrow_forward, size: 14.0, color: color),
          Expanded(
            child: _treeNode('Element', elementLabel, color),
          ),
          Icon(Icons.arrow_forward, size: 14.0, color: color),
          Expanded(
            child: _treeNode('RenderObject', '$renderLabel\n($slot)', color),
          ),
        ],
      ),
    );
  }

  Widget _treeNode(String layer, String label, Color c) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: c.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            layer,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
              color: c,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9.0,
              fontFamily: 'monospace',
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  final String name;
  final String typeLabel;
  final String note;
  final Widget preview;
  final Color accent;
  final List<String> extras;

  const _GalleryCard({
    required this.name,
    required this.typeLabel,
    required this.note,
    required this.preview,
    required this.accent,
    required this.extras,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: accent.withOpacity(0.4), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90.0,
            height: 64.0,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.06),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: accent.withOpacity(0.3), width: 1.0),
            ),
            alignment: Alignment.center,
            child: preview,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: accent,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 1.0,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        typeLabel,
                        style: const TextStyle(
                          fontSize: 9.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  note,
                  style: const TextStyle(fontSize: 10.5, height: 1.35),
                ),
                if (extras.isNotEmpty) const SizedBox(height: 4.0),
                for (final e in extras)
                  Text(
                    e,
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontFamily: 'monospace',
                      color: Color(0xFF455A64),
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
