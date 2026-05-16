// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Draggable Sheet Atelier
// A visual atlas of DraggableScrollableSheet, DraggableScrollableController,
// DraggableScrollableNotification, snap behavior, and modal sheet recipes.
import 'package:flutter/material.dart';

// Top-level controller so inspection cards can reference it without a State.
final DraggableScrollableController _atelierController =
    DraggableScrollableController();

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: PARAMETER RECIPES
  // ============================================================================

  final parameterRecipes = <Map<String, dynamic>>[
    {
      'name': 'initialChildSize',
      'type': 'double',
      'default': '0.5',
      'role': 'Resting fraction of the parent height on first render.',
      'tone': 'Anchor',
    },
    {
      'name': 'minChildSize',
      'type': 'double',
      'default': '0.25',
      'role': 'Lower bound for the drag fraction (>= 0.0).',
      'tone': 'Floor',
    },
    {
      'name': 'maxChildSize',
      'type': 'double',
      'default': '1.0',
      'role': 'Upper bound for the drag fraction (<= 1.0).',
      'tone': 'Ceiling',
    },
    {
      'name': 'snap',
      'type': 'bool',
      'default': 'false',
      'role': 'When true, sheet settles to nearest snap or bound.',
      'tone': 'Magnet',
    },
    {
      'name': 'snapSizes',
      'type': 'List<double>?',
      'default': 'null',
      'role': 'Sorted intermediate fractions used by the snap engine.',
      'tone': 'Steps',
    },
    {
      'name': 'snapAnimationDuration',
      'type': 'Duration?',
      'default': 'null',
      'role': 'Settle animation length; null uses physics simulation.',
      'tone': 'Cadence',
    },
    {
      'name': 'expand',
      'type': 'bool',
      'default': 'true',
      'role': 'When true sheet expands to fill its parent.',
      'tone': 'Fill',
    },
    {
      'name': 'controller',
      'type': 'DraggableScrollableController?',
      'default': 'null',
      'role': 'External handle to read size, animate, jump, or reset.',
      'tone': 'Handle',
    },
    {
      'name': 'builder',
      'type': 'ScrollableWidgetBuilder',
      'default': 'required',
      'role': '(ctx, scrollController) returning the inner scrollable.',
      'tone': 'Body',
    },
    {
      'name': 'shouldCloseOnMinExtent',
      'type': 'bool',
      'default': 'true',
      'role': 'Whether to dismiss when dragged to min extent in a route.',
      'tone': 'Exit',
    },
  ];

  // ============================================================================
  // SECTION 2: PARAMETER MATRIX SNAPSHOTS
  // ============================================================================

  final matrixSnapshots = <Map<String, dynamic>>[
    {
      'label': 'A · Compact',
      'initial': 0.25,
      'min': 0.1,
      'max': 0.9,
      'snap': false,
      'palette': Color(0xFF4DB6AC),
      'subtitle': 'Resting at 25% — peek mode',
    },
    {
      'label': 'B · Half',
      'initial': 0.5,
      'min': 0.2,
      'max': 0.95,
      'snap': true,
      'palette': Color(0xFF4FC3F7),
      'subtitle': 'Half rest with snap engaged',
    },
    {
      'label': 'C · Tall',
      'initial': 0.75,
      'min': 0.3,
      'max': 1.0,
      'snap': true,
      'palette': Color(0xFFBA68C8),
      'subtitle': 'Tall rest, snaps to bounds',
    },
    {
      'label': 'D · Full',
      'initial': 1.0,
      'min': 0.4,
      'max': 1.0,
      'snap': false,
      'palette': Color(0xFFFF8A65),
      'subtitle': 'Full screen rest, no snapping',
    },
  ];

  // ============================================================================
  // SECTION 3: SNAPSIZES RULER
  // ============================================================================

  final snapSizes = <double>[0.15, 0.35, 0.55, 0.75, 0.95];
  final snapMarkers = <Map<String, dynamic>>[
    {'fraction': 0.15, 'label': 'Peek', 'tint': Color(0xFFFFE082)},
    {'fraction': 0.35, 'label': 'Low', 'tint': Color(0xFFFFB74D)},
    {'fraction': 0.55, 'label': 'Mid', 'tint': Color(0xFFFF7043)},
    {'fraction': 0.75, 'label': 'High', 'tint': Color(0xFFD84315)},
    {'fraction': 0.95, 'label': 'Top', 'tint': Color(0xFF6D4C41)},
  ];

  // ============================================================================
  // SECTION 4: SNAP vs FREE DRAG COMPARISON
  // ============================================================================

  final snapComparison = <Map<String, dynamic>>[
    {
      'aspect': 'Drag release',
      'free': 'Settles where finger leaves',
      'snap': 'Animates to nearest snap',
    },
    {
      'aspect': 'Configuration',
      'free': 'snap: false',
      'snap': 'snap: true + snapSizes',
    },
    {
      'aspect': 'Animation',
      'free': 'Physics simulation',
      'snap': 'snapAnimationDuration',
    },
    {
      'aspect': 'Feel',
      'free': 'Liquid, freeform',
      'snap': 'Decisive, magnetic',
    },
    {
      'aspect': 'Use case',
      'free': 'Reading, browsing',
      'snap': 'Stops, peek-full',
    },
  ];

  // ============================================================================
  // SECTION 5: BUILDER SIGNATURE INVENTORY
  // ============================================================================

  final builderFacts = <Map<String, dynamic>>[
    {
      'item': 'Signature',
      'value': '(BuildContext, ScrollController) → Widget',
    },
    {
      'item': 'ScrollController',
      'value': 'MUST be attached to the inner scrollable',
    },
    {
      'item': 'Inner widget',
      'value': 'Typically ListView, GridView, CustomScrollView',
    },
    {
      'item': 'Drag binding',
      'value': 'The controller routes overscroll to sheet drag',
    },
    {
      'item': 'Common mistake',
      'value': 'Forgetting controller — sheet stops working',
    },
    {
      'item': 'Header trick',
      'value': 'Use SliverPersistentHeader for sticky handle',
    },
  ];

  // ============================================================================
  // SECTION 6: CONTROLLER INVENTORY
  // ============================================================================

  final controllerMembers = <Map<String, dynamic>>[
    {
      'member': 'size',
      'kind': 'property',
      'returns': 'double',
      'role': 'Current fraction of parent height (read-only).',
    },
    {
      'member': 'pixels',
      'kind': 'property',
      'returns': 'double',
      'role': 'Current size in logical pixels.',
    },
    {
      'member': 'isAttached',
      'kind': 'property',
      'returns': 'bool',
      'role': 'True once a sheet has registered with this controller.',
    },
    {
      'member': 'animateTo',
      'kind': 'method',
      'returns': 'Future<void>',
      'role': 'Animate to a target size with a curve and duration.',
    },
    {
      'member': 'jumpTo',
      'kind': 'method',
      'returns': 'void',
      'role': 'Jump immediately to a target size, no animation.',
    },
    {
      'member': 'reset',
      'kind': 'method',
      'returns': 'void',
      'role': 'Return the sheet to its initialChildSize.',
    },
    {
      'member': 'addListener',
      'kind': 'method',
      'returns': 'void',
      'role': 'Listen for size changes (acts like a ChangeNotifier).',
    },
    {
      'member': 'pixelsToSize',
      'kind': 'method',
      'returns': 'double',
      'role': 'Convert logical pixels to a normalized fraction.',
    },
    {
      'member': 'sizeToPixels',
      'kind': 'method',
      'returns': 'double',
      'role': 'Convert a fraction to logical pixels.',
    },
  ];

  // ============================================================================
  // SECTION 7: NOTIFICATION TRIO DIAGRAM
  // ============================================================================

  final notificationFields = <Map<String, dynamic>>[
    {
      'field': 'extent',
      'meaning': 'Current size as a fraction (0.0 – 1.0)',
      'sample': '0.42',
      'tint': Color(0xFF80CBC4),
    },
    {
      'field': 'minExtent',
      'meaning': 'Lower bound set by minChildSize',
      'sample': '0.10',
      'tint': Color(0xFFA5D6A7),
    },
    {
      'field': 'maxExtent',
      'meaning': 'Upper bound set by maxChildSize',
      'sample': '0.95',
      'tint': Color(0xFFFFAB91),
    },
    {
      'field': 'initialExtent',
      'meaning': 'The initialChildSize fraction',
      'sample': '0.30',
      'tint': Color(0xFFCE93D8),
    },
    {
      'field': 'shouldCloseOnMinExtent',
      'meaning': 'Mirror of the sheet flag (modal close hint)',
      'sample': 'true',
      'tint': Color(0xFF90CAF9),
    },
    {
      'field': 'context',
      'meaning': 'BuildContext of the dispatching widget',
      'sample': 'sheetCtx',
      'tint': Color(0xFFFFE082),
    },
    {
      'field': 'depth',
      'meaning': 'Depth in the listener tree',
      'sample': '0',
      'tint': Color(0xFFB0BEC5),
    },
  ];

  // ============================================================================
  // SECTION 8: showModalBottomSheet COMPARISON
  // ============================================================================

  final modalComparison = <Map<String, dynamic>>[
    {
      'feature': 'Lives in tree',
      'draggable': 'Inline in body',
      'modal': 'Pushed onto Navigator',
    },
    {
      'feature': 'Dismiss',
      'draggable': 'Stays mounted',
      'modal': 'Pops on barrier tap',
    },
    {
      'feature': 'Scrolling',
      'draggable': 'Sheet ↔ inner list bound',
      'modal': 'Needs isScrollControlled: true',
    },
    {
      'feature': 'Snap',
      'draggable': 'snap + snapSizes',
      'modal': 'Wrap a DraggableScrollableSheet',
    },
    {
      'feature': 'Theming',
      'draggable': 'Style your container',
      'modal': 'BottomSheetThemeData applies',
    },
    {
      'feature': 'Lifecycle',
      'draggable': 'Inherits widget tree lifetime',
      'modal': 'Future returns result on close',
    },
  ];

  // ============================================================================
  // SECTION 9: RECIPE CARDS
  // ============================================================================

  final recipes = <Map<String, dynamic>>[
    {
      'title': 'Music Player Drawer',
      'icon': Icons.music_note,
      'palette': Color(0xFF7E57C2),
      'initial': 0.18,
      'min': 0.18,
      'max': 0.92,
      'snapSizes': <double>[0.18, 0.55, 0.92],
      'recipe': 'Mini bar at peek, queue at half, lyrics at full.',
    },
    {
      'title': 'Filter Sheet',
      'icon': Icons.filter_list,
      'palette': Color(0xFF26A69A),
      'initial': 0.45,
      'min': 0.2,
      'max': 0.85,
      'snapSizes': <double>[0.2, 0.45, 0.85],
      'recipe': 'Quick chips at rest, full taxonomy when expanded.',
    },
    {
      'title': 'Map Preview',
      'icon': Icons.map_outlined,
      'palette': Color(0xFFEF6C00),
      'initial': 0.3,
      'min': 0.12,
      'max': 0.95,
      'snapSizes': <double>[0.12, 0.5, 0.95],
      'recipe': 'Glimpse address, then trip details, then booking.',
    },
    {
      'title': 'Comment Composer',
      'icon': Icons.mode_comment_outlined,
      'palette': Color(0xFF5C6BC0),
      'initial': 0.4,
      'min': 0.25,
      'max': 0.9,
      'snapSizes': <double>[0.25, 0.4, 0.9],
      'recipe': 'Show top thread, snap to compose, full for editor.',
    },
  ];

  // ============================================================================
  // SECTION 10: GLOSSARY
  // ============================================================================

  final glossary = <Map<String, dynamic>>[
    {
      'term': 'Extent',
      'definition':
          'Normalized fraction (0.0 – 1.0) of the parent height occupied by the sheet.',
    },
    {
      'term': 'Snap',
      'definition':
          'Magnetic settling behavior — the sheet animates to a discrete fraction.',
    },
    {
      'term': 'Snap size',
      'definition':
          'A specific fraction inside snapSizes (or one of the bounds).',
    },
    {
      'term': 'Anchor',
      'definition':
          'The initialChildSize used on first build and after reset().',
    },
    {
      'term': 'Expand',
      'definition':
          'Whether the sheet fills available space (true) or sizes to fit (false).',
    },
    {
      'term': 'Shoulder',
      'definition':
          'Slang for the visible portion of the sheet at minChildSize.',
    },
    {
      'term': 'Notification',
      'definition':
          'A DraggableScrollableNotification dispatched on each frame of motion.',
    },
    {
      'term': 'Modal',
      'definition':
          'A sheet rendered as a route via showModalBottomSheet().',
    },
  ];

  // Snapshot animations for any potential inner widgets needing values.
  final stoppedHalf = AlwaysStoppedAnimation<double>(0.5);
  final stoppedQuarter = AlwaysStoppedAnimation<double>(0.25);
  final snapDuration = Duration.zero;

  // ============================================================================
  // BUILD COMPREHENSIVE UI
  // ============================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ===== HERO HEADER =====
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF5C6BC0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x553949AB),
                      blurRadius: 18.0,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0x33FFFFFF),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Icon(
                            Icons.unfold_more,
                            color: Color(0xFFFFFFFF),
                            size: 28.0,
                          ),
                        ),
                        SizedBox(width: 14.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Draggable Sheet Atelier',
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Bottom-Sheet Stop-Snapshots Gallery',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xFFC5CAE9),
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
                      children: [
                        _heroChip('DraggableScrollableSheet'),
                        _heroChip('Controller'),
                        _heroChip('Notification'),
                        _heroChip('snapSizes'),
                        _heroChip('builder'),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== CONCEPT OVERVIEW =====
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFF9FA8DA), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF3949AB),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            Icons.menu_book,
                            color: Color(0xFFFFFFFF),
                            size: 20.0,
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          'Concept Overview',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.0),
                    Text(
                      'A DraggableScrollableSheet is a bottom-sheet style surface whose height '
                      'is a fraction of its parent. It binds an inner ScrollController to the '
                      'drag gesture so the sheet expands before the list scrolls. A controller '
                      'lets you inspect or drive the sheet from outside, and a notification '
                      'fires for each motion frame so listeners can react to extent changes.',
                      style: TextStyle(fontSize: 13.5, height: 1.55),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'In this atlas:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    _bullet('Parameter recipes — every constructor argument'),
                    _bullet('Stop-snapshots — sheets rendered at fixed rests'),
                    _bullet('Snap mechanics — sizes, durations, free vs magnet'),
                    _bullet('Builder & controller — the wiring under the hood'),
                    _bullet('Notification trio — extent, bounds, lifecycle'),
                    _bullet('Modal comparison — when to push, when to inline'),
                    _bullet('Recipe cards — real product surfaces in miniature'),
                    _bullet('Glossary & epilogue — quick reference'),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 1: PARAMETER RECIPES =====
              _sectionBanner(
                '1',
                'Parameter Recipes',
                'Constructor args, defaults, and their job in the dance.',
                Color(0xFF00838F),
                Color(0xFFB2EBF2),
                Icons.tune,
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE0F7FA),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFF80DEEA), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Each parameter is a knob on the same instrument.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF00695C),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    for (final recipe in parameterRecipes)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color(0xFFB2EBF2),
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      recipe['name'] as String,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF006064),
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 3.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF00838F),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Text(
                                      recipe['tone'] as String,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.0),
                              Row(
                                children: [
                                  _miniTag('type', recipe['type'] as String,
                                      Color(0xFF26C6DA)),
                                  SizedBox(width: 6.0),
                                  _miniTag('default', recipe['default'] as String,
                                      Color(0xFF80CBC4)),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                recipe['role'] as String,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 2: PARAMETER MATRIX SNAPSHOTS =====
              _sectionBanner(
                '2',
                'Stop-Snapshots Matrix',
                'Four bounded boxes — each one a sheet at a different rest.',
                Color(0xFF6A1B9A),
                Color(0xFFE1BEE7),
                Icons.grid_view,
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF3E5F5),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Each tile shows a real DraggableScrollableSheet inside a 360px stack. '
                      'The initialChildSize differs so you can see where each sheet rests.',
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.5,
                        color: Color(0xFF4A148C),
                      ),
                    ),
                    SizedBox(height: 14.0),
                    for (final snap in matrixSnapshots)
                      Padding(
                        padding: EdgeInsets.only(bottom: 14.0),
                        child: _snapshotTile(
                          snap['label'] as String,
                          snap['subtitle'] as String,
                          snap['initial'] as double,
                          snap['min'] as double,
                          snap['max'] as double,
                          snap['snap'] as bool,
                          snap['palette'] as Color,
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 3: SNAPSIZES RULER =====
              _sectionBanner(
                '3',
                'snapSizes Ruler',
                'Where the sheet wants to come to rest.',
                Color(0xFFE65100),
                Color(0xFFFFE0B2),
                Icons.straighten,
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFFFFB74D), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'snapSizes: ${snapSizes.toString()}',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        color: Color(0xFFBF360C),
                      ),
                    ),
                    SizedBox(height: 14.0),
                    Container(
                      height: 240.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Color(0xFFFFCC80),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Vertical ruler
                          SizedBox(
                            width: 60.0,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    color: Color(0xFFFFF8E1),
                                  ),
                                ),
                                for (final marker in snapMarkers)
                                  Positioned(
                                    left: 0.0,
                                    right: 0.0,
                                    top: (1.0 - (marker['fraction'] as double)) *
                                        220.0,
                                    child: Container(
                                      height: 2.0,
                                      color: marker['tint'] as Color,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Sheet preview
                          Expanded(
                            child: Stack(
                              children: [
                                for (final marker in snapMarkers)
                                  Positioned(
                                    left: 8.0,
                                    top: (1.0 - (marker['fraction'] as double)) *
                                        220.0 -
                                        10.0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                        vertical: 2.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: marker['tint'] as Color,
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        '${marker['label']} · ${(marker['fraction'] as double).toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                Positioned(
                                  left: 0.0,
                                  right: 0.0,
                                  bottom: 0.0,
                                  height: 220.0 * 0.55,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFFFF7043),
                                          Color(0xFFE64A19),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Sheet @ 0.55',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.bold,
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
                    SizedBox(height: 14.0),
                    Text(
                      'A drag release near any marker animates the sheet to that fraction.',
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.5,
                        color: Color(0xFFBF360C),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 4: SNAP vs FREE DRAG =====
              _sectionBanner(
                '4',
                'Snap vs Free Drag',
                'Two release behaviors — choose the right feel.',
                Color(0xFF2E7D32),
                Color(0xFFC8E6C9),
                Icons.compare_arrows,
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFF81C784), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF388E3C),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'Aspect',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF66BB6A),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'Free Drag',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF1B5E20),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'Snap',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    for (final row in snapComparison)
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFA5D6A7),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  row['aspect'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 6.0),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                    color: Color(0xFFA5D6A7),
                                  ),
                                ),
                                child: Text(
                                  row['free'] as String,
                                  style: TextStyle(fontSize: 11.5),
                                ),
                              ),
                            ),
                            SizedBox(width: 6.0),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2E7D32),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  row['snap'] as String,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 11.5,
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

              SizedBox(height: 24.0),

              // ===== SECTION 5: BUILDER PATTERN =====
              _sectionBanner(
                '5',
                'Builder Pattern',
                'How (ctx, scrollController) glues the sheet to its scrollable.',
                Color(0xFFAD1457),
                Color(0xFFF8BBD0),
                Icons.build_circle,
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFCE4EC),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFFF48FB1), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF880E4F),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "builder: (context, scrollController) => "
                        "ListView.builder(controller: scrollController, ...)",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.0),
                    for (final fact in builderFacts)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100.0,
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 6.0,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFC2185B),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Text(
                                fact['item'] as String,
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.5,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.0),
                                child: Text(
                                  fact['value'] as String,
                                  style: TextStyle(fontSize: 12.5, height: 1.45),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 6: CONTROLLER INVENTORY =====
              _sectionBanner(
                '6',
                'Controller Inventory',
                'Members of DraggableScrollableController, your remote handle.',
                Color(0xFF1565C0),
                Color(0xFFBBDEFB),
                Icons.settings_remote,
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFF64B5F6), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.gamepad,
                              color: Color(0xFFFFFFFF), size: 20.0),
                          SizedBox(width: 8.0),
                          Text(
                            'final controller = DraggableScrollableController();',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'monospace',
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'isAttached on the atelier controller: ${_atelierController.isAttached}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    for (final member in controllerMembers)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Color(0xFF90CAF9),
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                      vertical: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (member['kind'] as String) ==
                                              'method'
                                          ? Color(0xFF1976D2)
                                          : Color(0xFF42A5F5),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      member['kind'] as String,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    member['member'] as String,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0,
                                      fontFamily: 'monospace',
                                      color: Color(0xFF0D47A1),
                                    ),
                                  ),
                                  SizedBox(width: 6.0),
                                  Text(
                                    '→ ${member['returns']}',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontFamily: 'monospace',
                                      color: Color(0xFF1565C0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.0),
                              Text(
                                member['role'] as String,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 7: NOTIFICATION TRIO DIAGRAM =====
              _sectionBanner(
                '7',
                'Notification Trio',
                'DraggableScrollableNotification fields — listen, react, adapt.',
                Color(0xFF00695C),
                Color(0xFFB2DFDB),
                Icons.notifications_active,
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFF4DB6AC), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF004D40),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "NotificationListener<DraggableScrollableNotification>(\n"
                        "  onNotification: (n) { /* ... */ return false; },\n"
                        "  child: sheet,\n"
                        ")",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.0),
                    for (final field in notificationFields)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: field['tint'] as Color,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  field['field'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                    fontSize: 13.0,
                                    color: Color(0xFF004D40),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  field['meaning'] as String,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xCC004D40),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  field['sample'] as String,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 11.0,
                                    fontFamily: 'monospace',
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

              SizedBox(height: 24.0),

              // ===== SECTION 8: MODAL COMPARISON =====
              _sectionBanner(
                '8',
                'Inline vs Modal',
                'DraggableScrollableSheet vs showModalBottomSheet().',
                Color(0xFF4527A0),
                Color(0xFFD1C4E9),
                Icons.compare,
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFF9575CD), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF311B92),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'Feature',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF5E35B1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'DraggableScrollableSheet',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF7E57C2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'showModalBottomSheet',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    for (final row in modalComparison)
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFB39DDB),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  row['feature'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.5,
                                    color: Color(0xFF311B92),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 6.0),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                    color: Color(0xFFB39DDB),
                                  ),
                                ),
                                child: Text(
                                  row['draggable'] as String,
                                  style: TextStyle(fontSize: 11.5),
                                ),
                              ),
                            ),
                            SizedBox(width: 6.0),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF512DA8),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  row['modal'] as String,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 11.5,
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

              SizedBox(height: 24.0),

              // ===== SECTION 9: RECIPE CARDS =====
              _sectionBanner(
                '9',
                'Recipe Cards',
                'Product surfaces built from a DraggableScrollableSheet.',
                Color(0xFFBF360C),
                Color(0xFFFFCCBC),
                Icons.menu_book_outlined,
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFBE9E7),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFFFF8A65), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final recipe in recipes)
                      Padding(
                        padding: EdgeInsets.only(bottom: 14.0),
                        child: _recipeCard(
                          recipe['title'] as String,
                          recipe['icon'] as IconData,
                          recipe['palette'] as Color,
                          recipe['initial'] as double,
                          recipe['min'] as double,
                          recipe['max'] as double,
                          recipe['snapSizes'] as List<double>,
                          recipe['recipe'] as String,
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 10: GLOSSARY =====
              _sectionBanner(
                '10',
                'Glossary',
                'Words you will say while wrestling with sheets.',
                Color(0xFF455A64),
                Color(0xFFCFD8DC),
                Icons.local_library,
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Color(0xFF90A4AE), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final entry in glossary)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Color(0xFFB0BEC5),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF455A64),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  entry['term'] as String,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: Text(
                                  entry['definition'] as String,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    height: 1.45,
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

              SizedBox(height: 24.0),

              // ===== EPILOGUE / SUMMARY =====
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A237E), Color(0xFF512DA8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.verified,
                          color: Color(0xFFFFFFFF),
                          size: 24.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Epilogue',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.0),
                    _summaryItem('Parameter recipes', '10 knobs'),
                    _summaryItem('Stop-snapshots matrix', '4 rests'),
                    _summaryItem('snapSizes ruler', '5 markers'),
                    _summaryItem('Snap vs free drag', '5 axes'),
                    _summaryItem('Builder pattern', '6 facts'),
                    _summaryItem('Controller inventory', '9 members'),
                    _summaryItem('Notification fields', '7 fields'),
                    _summaryItem('Modal comparison', '6 features'),
                    _summaryItem('Recipe cards', '4 products'),
                    _summaryItem('Glossary entries', '8 terms'),
                    SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Draggable Sheet Atelier · ',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            'Sheets at rest, in motion, in stories',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.0),

              // ===== FOOTER =====
              Center(
                child: Text(
                  'Deep Demo · DraggableScrollableSheet · Bottom Sheet Stop-Snapshots',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF9E9E9E)),
                ),
              ),

              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// HELPERS
// ============================================================================

Widget _heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0x66FFFFFF), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(top: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•  ',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF1A237E),
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13.0, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

Widget _miniTag(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 10.0,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _sectionBanner(
  String number,
  String title,
  String subtitle,
  Color accent,
  Color soft,
  IconData icon,
) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [accent, soft],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Row(
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Icon(icon, color: Color(0xFFFFFFFF), size: 24.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SECTION $number: ${title.toUpperCase()}',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: Color(0xEEFFFFFF),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _snapshotTile(
  String label,
  String subtitle,
  double initial,
  double minSize,
  double maxSize,
  bool snap,
  Color palette,
) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: palette, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: palette,
            borderRadius: BorderRadius.vertical(top: Radius.circular(11.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Color(0xEEFFFFFF),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  snap ? 'snap: true' : 'snap: false',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        // Bounded sheet host
        SizedBox(
          height: 360.0,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFF5F5F5),
                        Color(0xFFE0E0E0),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.landscape,
                          size: 36.0,
                          color: Color(0xFF9E9E9E),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Background',
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: initial,
                minChildSize: minSize,
                maxChildSize: maxSize,
                snap: snap,
                snapSizes: snap ? <double>[minSize, initial, maxSize] : null,
                snapAnimationDuration: Duration.zero,
                expand: true,
                builder: (ctx, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x44000000),
                          blurRadius: 10.0,
                          offset: Offset(0, -3),
                        ),
                      ],
                    ),
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.zero,
                      children: [
                        SizedBox(height: 8.0),
                        Center(
                          child: Container(
                            width: 40.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              color: palette,
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: Text(
                            'initialChildSize: ${initial.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: palette,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.0,
                            vertical: 6.0,
                          ),
                          child: Text(
                            'min: ${minSize.toStringAsFixed(2)}   max: ${maxSize.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                              color: Color(0xFF455A64),
                            ),
                          ),
                        ),
                        Divider(color: Color(0xFFE0E0E0)),
                        for (int i = 0; i < 12; i++)
                          ListTile(
                            dense: true,
                            leading: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: palette.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Center(
                                child: Text(
                                  '${i + 1}',
                                  style: TextStyle(
                                    color: palette,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              'Row ${i + 1}',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            subtitle: Text(
                              'Scroll routes through the sheet first',
                              style: TextStyle(fontSize: 10.5),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCard(
  String title,
  IconData icon,
  Color palette,
  double initial,
  double minSize,
  double maxSize,
  List<double> snapSizes,
  String recipe,
) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: palette, width: 1.5),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: palette,
            borderRadius: BorderRadius.vertical(top: Radius.circular(11.0)),
          ),
          child: Row(
            children: [
              Icon(icon, color: Color(0xFFFFFFFF), size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'init ${initial.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe,
                style: TextStyle(fontSize: 12.5, height: 1.5),
              ),
              SizedBox(height: 10.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: [
                  _miniTag('min', minSize.toStringAsFixed(2), palette),
                  _miniTag('max', maxSize.toStringAsFixed(2), palette),
                  for (final s in snapSizes)
                    _miniTag(
                      'snap',
                      s.toStringAsFixed(2),
                      palette.withOpacity(0.7),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220.0,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        palette.withOpacity(0.08),
                        palette.withOpacity(0.22),
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(11.0),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      size: 56.0,
                      color: palette.withOpacity(0.35),
                    ),
                  ),
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: initial,
                minChildSize: minSize,
                maxChildSize: maxSize,
                snap: true,
                snapSizes: snapSizes,
                snapAnimationDuration: Duration.zero,
                expand: true,
                shouldCloseOnMinExtent: false,
                builder: (ctx, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(14.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 8.0,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.zero,
                      children: [
                        SizedBox(height: 6.0),
                        Center(
                          child: Container(
                            width: 36.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              color: palette,
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 14.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              color: palette,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        for (int i = 0; i < 8; i++)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 4.0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  icon,
                                  color: palette,
                                  size: 14.0,
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    '$title detail ${i + 1}',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 12.0),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _summaryItem(String label, String value) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Icon(
          Icons.check_circle,
          color: Color(0xFFFFFFFF),
          size: 16.0,
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13.5),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
