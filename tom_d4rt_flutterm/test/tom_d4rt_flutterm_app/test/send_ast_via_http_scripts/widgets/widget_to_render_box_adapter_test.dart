// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — WidgetToRenderBoxAdapter
// Demonstrates WidgetToRenderBoxAdapter, a widget that wraps a
// pre-existing RenderBox so it can be inserted into the widget tree.
// Bridges the render layer and widget layer for low-level rendering.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetToRenderBoxAdapter Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.extension,
      'title': 'What is WidgetToRenderBoxAdapter?',
      'body': 'WidgetToRenderBoxAdapter is a widget that takes an '
          'existing RenderBox and exposes it as a widget. This bridges '
          'the gap between the render object layer (low-level) and '
          'the widget layer (high-level declarative API).',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.layers,
      'title': 'Two-Layer Architecture',
      'body': 'Flutter has a widget layer (declarative, build methods) and '
          'a render layer (imperative, layout/paint). Normally widgets '
          'create render objects. WidgetToRenderBoxAdapter reverses this: '
          'a render object is wrapped to be usable as a widget.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Advanced / Low-Level',
      'body': 'This widget is for advanced use cases where you have a '
          'RenderBox created outside the widget tree (e.g., from a '
          'custom rendering engine, a platform adapter, or legacy code). '
          'Most apps never need this.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.sync_alt,
      'title': 'Lifecycle Bridge',
      'body': 'The adapter manages the lifecycle connection: the RenderBox '
          'is attached to the render tree when the widget mounts and '
          'detached when it unmounts. It does not create or destroy the '
          'RenderBox itself — that\u0027s the caller\u0027s responsibility.',
      'accent': Colors.green,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final c = conceptItems[i];
    final accent = c['accent'] as Color;
    print('Concept ${i + 1}: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'renderBox',
      'type': 'RenderBox',
      'desc': 'The pre-existing RenderBox to be wrapped. This render '
          'object must not already be in the render tree. The adapter '
          'attaches it when the widget mounts.',
    },
    {
      'name': 'onBuild',
      'type': 'VoidCallback?',
      'desc': 'Optional callback invoked during the build phase. Can be '
          'used to synchronize external state with the widget tree\u0027s '
          'rebuild cycle.',
    },
    {
      'name': 'RenderBox',
      'type': 'Base class',
      'desc': 'The base class for render objects that have a 2D Cartesian '
          'coordinate system. RenderBox defines the layout protocol: '
          'constraints in, size out.',
    },
    {
      'name': 'LeafRenderObjectWidget',
      'type': 'Superclass',
      'desc': 'WidgetToRenderBoxAdapter extends LeafRenderObjectWidget. '
          'It creates a render object element that manages the provided '
          'RenderBox\u0027s attachment to the render tree.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.deepOrange.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepOrange.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: RenderBox Basics
  // ============================================================
  print('=== Section 3: RenderBox ===');

  final renderBoxTopics = <Map<String, dynamic>>[
    {
      'title': 'Box Constraints',
      'desc': 'A RenderBox receives BoxConstraints: minWidth, maxWidth, '
          'minHeight, maxHeight. It chooses a Size within these bounds. '
          'The parent provides constraints; the child reports its size.',
      'icon': Icons.crop,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Layout Protocol',
      'desc': 'performLayout() computes the box\u0027s size from '
          'constraints. For a leaf box (no children), size is computed '
          'directly. For parent boxes, children are laid out first, '
          'then the parent sizes based on children\u0027s sizes.',
      'icon': Icons.straighten,
      'color': Colors.blue,
    },
    {
      'title': 'Paint Protocol',
      'desc': 'paint(PaintingContext, Offset) draws the box\u0027s visual '
          'content. The offset is the top-left corner in the parent\u0027s '
          'coordinate space. Use context.canvas for drawing operations.',
      'icon': Icons.brush,
      'color': Colors.green,
    },
    {
      'title': 'Hit Testing',
      'desc': 'hitTest() determines if a point is within the box. '
          'Returns true if the box handles the event. Custom hit '
          'testing allows non-rectangular or transparent hit areas.',
      'icon': Icons.touch_app,
      'color': Colors.orange,
    },
    {
      'title': 'Semantics',
      'desc': 'describeSemanticsConfiguration() adds accessibility '
          'metadata. A RenderBox can describe itself for screen readers. '
          'The adapter\u0027s RenderBox should provide meaningful semantics.',
      'icon': Icons.accessibility,
      'color': Colors.purple,
    },
  ];

  final renderBoxWidgets = <Widget>[];
  for (var i = 0; i < renderBoxTopics.length; i++) {
    final rb = renderBoxTopics[i];
    final rbColor = rb['color'] as Color;
    print('RenderBox ${i + 1}: ${rb['title']}');
    renderBoxWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: rbColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: rbColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: rbColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  rb['icon'] as IconData,
                  color: rbColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rb['title'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: rbColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rb['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Attachment Flow
  // ============================================================
  print('=== Section 4: Attachment ===');

  final attachSteps = <Map<String, dynamic>>[
    {
      'step': '1. Create RenderBox',
      'desc': 'The caller creates a RenderBox externally. This could '
          'be a custom paint box, a platform rendering bridge, or '
          'a render object from a different framework subsystem.',
      'icon': Icons.build,
      'color': Colors.deepOrange,
    },
    {
      'step': '2. Pass to Adapter',
      'desc': 'The RenderBox is passed to WidgetToRenderBoxAdapter\u0027s '
          'renderBox parameter. The adapter stores a reference but '
          'does not yet attach the box to the render tree.',
      'icon': Icons.input,
      'color': Colors.blue,
    },
    {
      'step': '3. Widget Mounts',
      'desc': 'When the adapter widget is inserted into the widget tree, '
          'createElement creates a LeafRenderObjectElement. The element\u0027s '
          'mount triggers createRenderObject, which returns the stored box.',
      'icon': Icons.play_arrow,
      'color': Colors.green,
    },
    {
      'step': '4. Box Attached',
      'desc': 'The render pipeline attaches the RenderBox. It receives '
          'an owner (PipelineOwner) and is added to the render tree. '
          'Layout and paint are scheduled.',
      'icon': Icons.link,
      'color': Colors.orange,
    },
    {
      'step': '5. Layout and Paint',
      'desc': 'The RenderBox participates in normal layout and paint '
          'passes. It receives constraints from its parent render '
          'object, reports its size, and paints its content.',
      'icon': Icons.brush,
      'color': Colors.purple,
    },
    {
      'step': '6. Widget Unmounts',
      'desc': 'When the adapter widget is removed, the RenderBox is '
          'detached from the render tree. The box itself is NOT '
          'disposed — the caller retains ownership.',
      'icon': Icons.eject,
      'color': Colors.red,
    },
  ];

  final attachWidgets = <Widget>[];
  for (var i = 0; i < attachSteps.length; i++) {
    final as_ = attachSteps[i];
    final asColor = as_['color'] as Color;
    print('Attach ${i + 1}: ${as_['step']}');
    attachWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: asColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    as_['icon'] as IconData,
                    color: asColor,
                    size: 18,
                  ),
                ),
                if (i < attachSteps.length - 1)
                  Container(
                    width: 2,
                    height: 24,
                    color: asColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: asColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: asColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      as_['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: asColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      as_['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Comparison
  // ============================================================
  print('=== Section 5: Compare ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'aspect': 'Direction',
      'adapter': 'RenderBox \u2192 Widget',
      'custom': 'Widget \u2192 RenderBox',
      'color': Colors.deepOrange,
    },
    {
      'aspect': 'Creation',
      'adapter': 'RenderBox created externally',
      'custom': 'RenderBox created by widget',
      'color': Colors.blue,
    },
    {
      'aspect': 'Ownership',
      'adapter': 'Caller owns the RenderBox',
      'custom': 'Widget owns its RenderBox',
      'color': Colors.green,
    },
    {
      'aspect': 'Lifecycle',
      'adapter': 'Attach/detach only',
      'custom': 'Create/update/dispose',
      'color': Colors.orange,
    },
    {
      'aspect': 'Use Case',
      'adapter': 'External render integration',
      'custom': 'Standard widget development',
      'color': Colors.purple,
    },
    {
      'aspect': 'Children',
      'adapter': 'None (leaf widget)',
      'custom': 'Can have widget children',
      'color': Colors.teal,
    },
  ];

  final compareWidgets = <Widget>[];
  // Table header
  compareWidgets.add(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.deepOrange.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              'Aspect',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Adapter',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Custom Widget',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  for (var i = 0; i < comparisons.length; i++) {
    final cmp = comparisons[i];
    final cmpColor = cmp['color'] as Color;
    print('Compare ${i + 1}: ${cmp['aspect']}');
    compareWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: i.isEven
              ? cmpColor.withOpacity(0.03)
              : Colors.transparent,
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.15)),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                cmp['aspect'] as String,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: cmpColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                cmp['adapter'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                cmp['custom'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Caveats
  // ============================================================
  print('=== Section 6: Caveats ===');

  final caveats = <Map<String, dynamic>>[
    {
      'title': 'Single-Use Constraint',
      'desc': 'A RenderBox can only be in one place in the render tree. '
          'If you try to use the same RenderBox in two adapters '
          'simultaneously, the framework will throw a "render object '
          'already has a parent" error.',
      'icon': Icons.warning,
      'color': Colors.red,
    },
    {
      'title': 'No Widget Rebuilds',
      'desc': 'Standard widgets rebuild when setState is called. The '
          'adapter does not rebuild the RenderBox — it\u0027s not a '
          'widget-created object. To update, call markNeedsLayout '
          'or markNeedsPaint on the box directly.',
      'icon': Icons.refresh,
      'color': Colors.orange,
    },
    {
      'title': 'Ownership Responsibility',
      'desc': 'The adapter does NOT dispose the RenderBox when unmounting. '
          'The caller must track the box\u0027s lifecycle and dispose it '
          'when done. Failure to do so causes memory leaks.',
      'icon': Icons.delete_forever,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Constraints Mismatch',
      'desc': 'The adapter\u0027s parent provides BoxConstraints. If the '
          'RenderBox was designed for specific constraints, a mismatch '
          'can cause layout assertion failures or visual glitches. '
          'Wrap in SizedBox or ConstrainedBox to control constraints.',
      'icon': Icons.broken_image,
      'color': Colors.purple,
    },
    {
      'title': 'No Children via Widget Tree',
      'desc': 'WidgetToRenderBoxAdapter is a LeafRenderObjectWidget. It '
          'cannot have widget children. If the RenderBox has child '
          'render objects, they must be managed outside the widget tree.',
      'icon': Icons.block,
      'color': Colors.blue,
    },
  ];

  final caveatWidgets = <Widget>[];
  for (var i = 0; i < caveats.length; i++) {
    final cv = caveats[i];
    final cvColor = cv['color'] as Color;
    print('Caveat ${i + 1}: ${cv['title']}');
    caveatWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cvColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cvColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: cvColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                cv['icon'] as IconData,
                color: cvColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cv['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: cvColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    cv['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Use Cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Custom Rendering Engine',
      'desc': 'A custom rendering engine (e.g., a game engine or chart '
          'library) produces RenderBoxes. The adapter integrates '
          'these into a Flutter widget tree for layout and compositing.',
      'icon': Icons.games,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Platform View Bridge',
      'desc': 'Platform-specific rendering (e.g., native canvas) wrapped '
          'in a RenderBox. The adapter makes it usable alongside '
          'Flutter widgets without a full PlatformView setup.',
      'icon': Icons.devices_other,
      'color': Colors.blue,
    },
    {
      'title': 'Testing Infrastructure',
      'desc': 'In tests, a mock or stub RenderBox can be injected into '
          'the widget tree for verifying layout, paint, or hit-test '
          'behavior without building a full widget subtree.',
      'icon': Icons.science,
      'color': Colors.green,
    },
    {
      'title': 'Lazy Initialization',
      'desc': 'A RenderBox that\u0027s expensive to create can be '
          'pre-created and reattached via the adapter as needed. '
          'The box persists while the widget mounts/unmounts, '
          'avoiding recreation costs.',
      'icon': Icons.speed,
      'color': Colors.orange,
    },
    {
      'title': 'Interop with Render Libraries',
      'desc': 'Third-party render libraries that produce RenderBoxes '
          'directly. The adapter allows mixing their output with '
          'standard Flutter widgets in the same layout tree.',
      'icon': Icons.merge_type,
      'color': Colors.purple,
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    final ucColor = uc['color'] as Color;
    print('UseCase ${i + 1}: ${uc['title']}');
    useCaseWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ucColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ucColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: ucColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  uc['icon'] as IconData,
                  color: ucColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      uc['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ucColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      uc['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.extension,
      'text': 'WidgetToRenderBoxAdapter wraps a pre-existing RenderBox '
          'for use in the widget tree.',
    },
    {
      'icon': Icons.sync_alt,
      'text': 'Bridges the render layer and widget layer in the '
          'reverse direction: render object to widget.',
    },
    {
      'icon': Icons.link,
      'text': 'Attaches the RenderBox on mount and detaches on unmount. '
          'The caller retains ownership of the box.',
    },
    {
      'icon': Icons.warning_amber,
      'text': 'Advanced use only: for custom rendering engines, '
          'platform bridges, and testing infrastructure.',
    },
    {
      'icon': Icons.block,
      'text': 'Leaf widget: cannot have widget children. The RenderBox '
          'can only be in one adapter at a time.',
    },
    {
      'icon': Icons.memory,
      'text': 'The caller must dispose the RenderBox when done. '
          'The adapter does not manage disposal.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepOrange.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.deepOrange.shade800,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('WidgetToRenderBoxAdapter'),
        backgroundColor: Colors.deepOrange.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.view_in_ar), text: 'RenderBox'),
            Tab(icon: Icon(Icons.link), text: 'Attachment'),
            Tab(icon: Icon(Icons.compare), text: 'Compare'),
            Tab(icon: Icon(Icons.warning_amber), text: 'Caveats'),
            Tab(icon: Icon(Icons.cases), text: 'Use Cases'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'WidgetToRenderBoxAdapter: bridge a pre-existing '
                  'RenderBox into the widget tree.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'WidgetToRenderBoxAdapter API and class hierarchy.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'RenderBox fundamentals: constraints, layout, paint.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...renderBoxWidgets,
            ],
          ),
          // Tab 4
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How the RenderBox attaches and detaches from the tree.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...attachWidgets,
            ],
          ),
          // Tab 5
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Adapter vs. custom RenderObjectWidget comparison.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...compareWidgets,
            ],
          ),
          // Tab 6
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Important caveats and pitfalls to watch for.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...caveatWidgets,
            ],
          ),
          // Tab 7
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Real-world scenarios for using the adapter.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...useCaseWidgets,
            ],
          ),
          // Tab 8
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.withOpacity(0.12),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about WidgetToRenderBoxAdapter.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}
