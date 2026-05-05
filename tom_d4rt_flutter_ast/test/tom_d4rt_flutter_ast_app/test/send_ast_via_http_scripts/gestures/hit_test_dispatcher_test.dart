// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests HitTestDispatcher from gestures
// Deep Demo: Visual exploration of the HitTestDispatcher abstract interface
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Palette constants (slate / ember / cyan)
const Color _slateDeep = Color(0xFF0F172A);
const Color _slateMid = Color(0xFF1E293B);
const Color _slateSoft = Color(0xFF334155);
const Color _slateLine = Color(0xFF475569);
const Color _slateMist = Color(0xFFCBD5E1);
const Color _emberCore = Color(0xFFF97316);
const Color _emberSoft = Color(0xFFFB923C);
const Color _emberGlow = Color(0xFFFFB783);
const Color _cyanCore = Color(0xFF06B6D4);
const Color _cyanSoft = Color(0xFF22D3EE);
const Color _cyanGlow = Color(0xFFA5F3FC);
const Color _amberAccent = Color(0xFFFBBF24);

dynamic build(BuildContext context) {
  print('HitTestDispatcher Deep Demo executing');

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slateDeep, _slateMid, _slateSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _cyanCore.withValues(alpha: 0.4), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: _cyanCore.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: _emberCore.withValues(alpha: 0.25),
          blurRadius: 36.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_cyanCore, _cyanSoft],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(
                    color: _cyanCore.withValues(alpha: 0.5),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(Icons.touch_app, color: _slateDeep, size: 36.0),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HitTestDispatcher',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: _cyanGlow,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: _emberCore.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: _emberCore.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'Abstract interface for objects that can dispatch a PointerEvent\n'
            'down a HitTestResult, walking the captured target path.',
            style: TextStyle(
              fontSize: 13.0,
              color: _emberGlow,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildPill('abstract class', _cyanCore),
            _buildPill('1 method', _emberCore),
            _buildPill('routes pointers', _amberAccent),
            _buildPill('mixed-into bindings', _cyanSoft),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _slateDeep,
          _slateMid,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _slateLine, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _slateDeep.withValues(alpha: 0.6),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: _cyanSoft, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Class Anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _cyanGlow,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        // The class diagram box
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: _slateSoft.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _cyanCore, width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: _cyanCore.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.code,
                      color: _cyanGlow,
                      size: 14.0,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      '<<abstract>> HitTestDispatcher',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                height: 1.0,
                color: _slateLine,
              ),
              SizedBox(height: 12.0),
              Text(
                'fields:',
                style: TextStyle(
                  fontSize: 11.0,
                  color: _slateMist,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                '  (none — pure interface)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: _emberSoft,
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                height: 1.0,
                color: _slateLine,
              ),
              SizedBox(height: 12.0),
              Text(
                'methods:',
                style: TextStyle(
                  fontSize: 11.0,
                  color: _slateMist,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 4.0),
              _buildSignatureLine(
                '+ dispatchEvent(',
                'PointerEvent event, HitTestResult result',
                ') → void',
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _emberCore.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: _emberCore.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  'Walks every HitTestEntry in result.path, invoking\n'
                  'entry.target.handleEvent(event, entry).',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: _emberGlow,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Pipeline diagram
  // ============================================================
  print('=== Section 3: Pipeline diagram ===');

  final pipelineDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slateMid, _slateDeep],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _emberCore.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _emberCore.withValues(alpha: 0.2),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.alt_route, color: _emberSoft, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Pointer Event Pipeline',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _emberGlow,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        _buildPipelineStep(
          1,
          'Pointer Arrives',
          'Engine produces PointerDataPacket, dispatched to '
              'GestureBinding._handlePointerDataPacket.',
          Icons.arrow_downward,
          _cyanCore,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          2,
          'Hit-Test Descent',
          'GestureBinding.hitTestInView(result, position, viewId) walks\n'
              'the render tree and lets each render object opt in.',
          Icons.south_east,
          _cyanSoft,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          3,
          'Result List Builds',
          'Targets are appended to HitTestResult.path in deepest-first\n'
              'order, each wrapped in a HitTestEntry.',
          Icons.list_alt,
          _amberAccent,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          4,
          'Dispatcher Walks Back Up',
          'HitTestDispatcher.dispatchEvent invokes handleEvent on every\n'
              'entry, propagating event through the captured chain.',
          Icons.upload,
          _emberSoft,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          5,
          'Recognizers React',
          'GestureDetector / GestureRecognizer instances claim the\n'
              'pointer, declare wins, and fire callbacks.',
          Icons.gesture,
          _emberCore,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Family table
  // ============================================================
  print('=== Section 4: Family table ===');

  final familyTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slateMid, _slateSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _slateLine, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.family_restroom, color: _amberAccent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'HitTest Family',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _amberAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: _cyanCore.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: _cyanCore.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              _buildFamHeader('Type', 130.0),
              _buildFamHeader('Role', 200.0),
              _buildFamHeader('Relationship', 220.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _buildFamRow(
          'HitTestDispatcher',
          'Walks the result, invokes handleEvent.',
          'Consumer of HitTestResult.',
          _cyanGlow,
        ),
        _buildFamRow(
          'HitTestable',
          'Performs the hit-test traversal.',
          'Producer that fills HitTestResult.',
          _cyanSoft,
        ),
        _buildFamRow(
          'HitTestTarget',
          'Receives events via handleEvent.',
          'Held by every HitTestEntry.',
          _emberSoft,
        ),
        _buildFamRow(
          'HitTestResult',
          'Mutable list of entries (path).',
          'Built by HitTestable, read by Dispatcher.',
          _amberAccent,
        ),
        _buildFamRow(
          'HitTestEntry',
          'Pair of (target, transform).',
          'One slot inside HitTestResult.path.',
          _emberCore,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Real-world mock — tap on Stack
  // ============================================================
  print('=== Section 5: Real-world mock ===');

  // Build a mock HitTestResult to mirror what we visualize.
  final demoResult = HitTestResult();
  print('Mock HitTestResult.path length: ${demoResult.path.length}');

  final realWorldMock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slateDeep, _slateMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _cyanCore.withValues(alpha: 0.45), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _cyanCore.withValues(alpha: 0.3),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: _cyanSoft, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Real-World Tap on Stack',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _cyanGlow,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visualization of the stack with a tap dot.
            Container(
              width: 180.0,
              height: 220.0,
              decoration: BoxDecoration(
                color: _slateSoft,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: _slateLine, width: 1.0),
              ),
              child: Stack(
                children: [
                  // Scaffold layer
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _slateMid,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'Scaffold',
                        style: TextStyle(
                          fontSize: 9.0,
                          color: _slateMist,
                        ),
                      ),
                    ),
                  ),
                  // Stack rectangle
                  Positioned(
                    left: 16.0,
                    top: 28.0,
                    right: 16.0,
                    bottom: 28.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _slateLine.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: _amberAccent.withValues(alpha: 0.6),
                          width: 1.0,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Stack',
                        style: TextStyle(
                          fontSize: 9.0,
                          color: _amberAccent,
                        ),
                      ),
                    ),
                  ),
                  // Container child
                  Positioned(
                    left: 32.0,
                    top: 48.0,
                    width: 90.0,
                    height: 80.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _emberSoft.withValues(alpha: 0.6),
                            _emberCore.withValues(alpha: 0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: _emberCore.withValues(alpha: 0.4),
                            blurRadius: 8.0,
                            offset: Offset(0.0, 3.0),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Container',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // TextButton child (top — receives tap first)
                  Positioned(
                    right: 28.0,
                    top: 110.0,
                    width: 90.0,
                    height: 60.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_cyanCore, _cyanSoft],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: _cyanCore.withValues(alpha: 0.6),
                            blurRadius: 10.0,
                            offset: Offset(0.0, 4.0),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'TextButton',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: _slateDeep,
                        ),
                      ),
                    ),
                  ),
                  // Tap dot
                  Positioned(
                    right: 56.0,
                    top: 134.0,
                    child: Container(
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _amberAccent,
                        boxShadow: [
                          BoxShadow(
                            color: _amberAccent.withValues(alpha: 0.8),
                            blurRadius: 12.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            // Hit list
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HitTestResult.path',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: _cyanGlow,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  _buildHitEntry(
                    0,
                    'TextButton',
                    _cyanCore,
                    Icons.smart_button,
                    'innermost',
                  ),
                  _buildArrowDown(),
                  _buildHitEntry(
                    1,
                    'Container',
                    _emberCore,
                    Icons.crop_square,
                    'sibling',
                  ),
                  _buildArrowDown(),
                  _buildHitEntry(
                    2,
                    'Stack',
                    _amberAccent,
                    Icons.layers,
                    'parent layer',
                  ),
                  _buildArrowDown(),
                  _buildHitEntry(
                    3,
                    'Scaffold',
                    _cyanSoft,
                    Icons.dashboard,
                    'route shell',
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _emberCore.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: _emberCore.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Text(
            'dispatchEvent walks this list top-to-bottom, calling\n'
            'entry.target.handleEvent(event, entry) on each entry.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _emberGlow,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Implementations gallery
  // ============================================================
  print('=== Section 6: Implementations gallery ===');

  // Reference the live binding to make the demo grounded in real types.
  final binding = GestureBinding.instance;
  print('Live binding: ${binding.runtimeType}');

  final implementationsGallery = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slateDeep, _slateMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _slateLine, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _cyanCore.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.workspaces, color: _cyanSoft, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Implementations',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _cyanGlow,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildImplCard(
          'GestureBinding',
          'package:flutter/gestures.dart',
          'Owns the pointer router and gesture arena. Its '
              'dispatchEvent is the canonical implementation that '
              'every Flutter app uses by default.',
          Icons.gesture,
          _cyanCore,
          [
            'PointerRouter integration',
            'GestureArenaManager',
            'cancel-on-arena-loss',
          ],
        ),
        SizedBox(height: 14.0),
        _buildImplCard(
          'RendererBinding',
          'package:flutter/rendering.dart',
          'Adds render-tree-aware hit-testing via hitTestInView and '
              'plugs into GestureBinding so the renderer participates '
              'in dispatch.',
          Icons.architecture,
          _emberCore,
          [
            'HitTestable provider',
            'PipelineOwner orchestration',
            'compositeOrder math',
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _slateSoft.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: _slateLine,
              width: 1.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: _amberAccent, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'WidgetsBinding mixes both in via inheritance, so the '
                  'dispatcher you reach in normal apps is effectively '
                  'WidgetsFlutterBinding.instance.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _slateMist,
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

  // ============================================================
  // SECTION 7: PointerEvent family touched
  // ============================================================
  print('=== Section 7: PointerEvent family ===');

  // Construct a real PointerDownEvent to anchor the visualization.
  final samplePointerDown = PointerDownEvent(
    pointer: 7,
    position: Offset(120.0, 80.0),
  );
  print('Sample PointerDownEvent: ${samplePointerDown.runtimeType}, '
      'pointer=${samplePointerDown.pointer}, '
      'position=${samplePointerDown.position}');

  final pointerFamilyCards = <Widget>[];
  final pointerFamilyData = <Map<String, dynamic>>[
    {
      'name': 'PointerDownEvent',
      'icon': Icons.touch_app,
      'color': _cyanCore,
      'role': 'Begins a stream — triggers hit-testing.',
      'phase': 'down',
    },
    {
      'name': 'PointerMoveEvent',
      'icon': Icons.swap_horiz,
      'color': _cyanSoft,
      'role': 'Routed through the cached path of the down event.',
      'phase': 'move',
    },
    {
      'name': 'PointerUpEvent',
      'icon': Icons.upload,
      'color': _amberAccent,
      'role': 'Closes the gesture, dispatched along the same path.',
      'phase': 'up',
    },
    {
      'name': 'PointerCancelEvent',
      'icon': Icons.cancel,
      'color': _emberCore,
      'role': 'Arena loss / system interruption — same path replay.',
      'phase': 'cancel',
    },
    {
      'name': 'PointerScrollEvent',
      'icon': Icons.mouse,
      'color': _emberSoft,
      'role': 'Independent hover hit-test, dispatched per scroll tick.',
      'phase': 'scroll',
    },
  ];

  for (final data in pointerFamilyData) {
    final color = data['color'] as Color;
    pointerFamilyCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _slateMid,
              _slateSoft.withValues(alpha: 0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(data['icon'] as IconData, color: color, size: 22.0),
                SizedBox(width: 6.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    data['phase'] as String,
                    style: TextStyle(
                      fontSize: 9.0,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              data['name'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              data['role'] as String,
              style: TextStyle(
                fontSize: 10.5,
                color: _slateMist,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${pointerFamilyCards.length} pointer family cards');

  // ============================================================
  // SECTION 8: Code block
  // ============================================================
  print('=== Section 8: Code block ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: _slateDeep,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _slateLine, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _cyanCore.withValues(alpha: 0.2),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: _cyanSoft, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Abstract Definition + Implementation',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: _cyanGlow,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeSegment(
          '// 1. Abstract interface (gestures library)',
          _slateMist,
        ),
        _buildCodeSegment(
          'abstract class HitTestDispatcher {',
          _cyanSoft,
        ),
        _buildCodeSegment(
          '  void dispatchEvent(',
          Colors.white,
        ),
        _buildCodeSegment(
          '    PointerEvent event,',
          _emberSoft,
        ),
        _buildCodeSegment(
          '    HitTestResult result,',
          _emberSoft,
        ),
        _buildCodeSegment(
          '  );',
          Colors.white,
        ),
        _buildCodeSegment(
          '}',
          _cyanSoft,
        ),
        SizedBox(height: 12.0),
        _buildCodeSegment(
          '// 2. GestureBinding implementation (sketch)',
          _slateMist,
        ),
        _buildCodeSegment(
          'mixin GestureBinding implements HitTestDispatcher {',
          _cyanSoft,
        ),
        _buildCodeSegment(
          '  @override',
          _amberAccent,
        ),
        _buildCodeSegment(
          '  void dispatchEvent(PointerEvent event, HitTestResult result) {',
          Colors.white,
        ),
        _buildCodeSegment(
          '    for (final HitTestEntry entry in result.path) {',
          Colors.white,
        ),
        _buildCodeSegment(
          '      try {',
          Colors.white,
        ),
        _buildCodeSegment(
          '        entry.target.handleEvent(event.transformed(',
          Colors.white,
        ),
        _buildCodeSegment(
          '            entry.transform), entry);',
          Colors.white,
        ),
        _buildCodeSegment(
          '      } catch (e, s) {',
          Colors.white,
        ),
        _buildCodeSegment(
          '        FlutterError.reportError(...);',
          _slateMist,
        ),
        _buildCodeSegment(
          '      }',
          Colors.white,
        ),
        _buildCodeSegment(
          '    }',
          Colors.white,
        ),
        _buildCodeSegment(
          '  }',
          Colors.white,
        ),
        _buildCodeSegment(
          '}',
          _cyanSoft,
        ),
        SizedBox(height: 12.0),
        _buildCodeSegment(
          '// 3. Helper that builds a HitTestResult',
          _slateMist,
        ),
        _buildCodeSegment(
          'HitTestResult buildEmptyResult() {',
          _cyanSoft,
        ),
        _buildCodeSegment(
          '  return HitTestResult();   // path is empty by default',
          Colors.white,
        ),
        _buildCodeSegment(
          '}',
          _cyanSoft,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Lifecycle steps
  // ============================================================
  print('=== Section 9: Lifecycle steps ===');

  final lifecycleBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slateMid, _slateDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _emberCore.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _emberCore.withValues(alpha: 0.25),
          blurRadius: 18.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: _emberSoft, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Dispatch Lifecycle (5 phases)',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _emberGlow,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildLifecycleStep(
          1,
          'Cache hit chain',
          'On PointerDownEvent the dispatcher records the path so '
              'follow-ups (move/up/cancel) can replay against the same '
              'targets without re-running the hit-test.',
        ),
        _buildLifecycleStep(
          2,
          'Walk the path top-down',
          'Iterates result.path from index 0 (deepest hit) to the last '
              'entry (root container).',
        ),
        _buildLifecycleStep(
          3,
          'Transform per entry',
          'Each event is transformed by entry.transform so the target '
              'sees coordinates in its own coordinate space.',
        ),
        _buildLifecycleStep(
          4,
          'handleEvent fan-out',
          'entry.target.handleEvent(event, entry) lets the target route '
              'the event into recognizers, callbacks, or render layers.',
        ),
        _buildLifecycleStep(
          5,
          'Error containment',
          'Exceptions in any handler are reported via FlutterError so '
              'one rogue listener never breaks the rest of the chain.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footgun cards ===');

  final footgunData = <Map<String, dynamic>>[
    {
      'title': 'Order matters',
      'note': 'result.path is deepest-first. Skipping that order or '
          'iterating in reverse breaks bubble semantics.',
      'icon': Icons.format_list_numbered,
      'color': _emberCore,
    },
    {
      'title': 'Propagation is implicit',
      'note': 'There is no stopPropagation; every entry sees the event '
          'unless the handler throws or arena cancels.',
      'icon': Icons.arrow_circle_down,
      'color': _emberSoft,
    },
    {
      'title': 'Custom dispatchers are rare',
      'note': 'Replacing the dispatcher means you also own arena '
          'cleanup and recognizer lifecycle.',
      'icon': Icons.warning_amber,
      'color': _amberAccent,
    },
    {
      'title': 'Empty path is legal',
      'note': 'A hit-test off-tree returns an empty path. dispatchEvent '
          'simply does nothing — no error, no fallback.',
      'icon': Icons.do_not_disturb,
      'color': _cyanSoft,
    },
    {
      'title': 'Transforms are local',
      'note': 'Each entry has its own transform. Caching the event '
          'globally and reusing it across entries is wrong.',
      'icon': Icons.transform,
      'color': _cyanCore,
    },
  ];

  final footgunCards = <Widget>[];
  for (final data in footgunData) {
    final color = data['color'] as Color;
    footgunCards.add(
      Container(
        width: 240.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _slateMid,
              _slateSoft,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    data['icon'] as IconData,
                    color: color,
                    size: 18.0,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    data['title'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              data['note'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: _slateMist,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${footgunCards.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap card ===');

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slateDeep, _slateMid, _slateSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _emberCore, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: _emberCore.withValues(alpha: 0.4),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: _cyanCore.withValues(alpha: 0.25),
          blurRadius: 30.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark, color: _emberSoft, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: _emberGlow,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecapLine(
          'HitTestDispatcher',
          'one-method abstract — dispatchEvent(PointerEvent, HitTestResult).',
          _cyanCore,
        ),
        _buildRecapLine(
          'Producer',
          'HitTestable fills a HitTestResult during the down phase.',
          _cyanSoft,
        ),
        _buildRecapLine(
          'Consumer',
          'GestureBinding (and via mixin RendererBinding) walks the result.',
          _amberAccent,
        ),
        _buildRecapLine(
          'Targets',
          'Each HitTestEntry.target.handleEvent runs in deepest-first order.',
          _emberSoft,
        ),
        _buildRecapLine(
          'Caching',
          'Down events seed a path replayed by move/up/cancel.',
          _emberCore,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _cyanCore.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: _cyanCore.withValues(alpha: 0.45),
              width: 1.0,
            ),
          ),
          child: Text(
            'Replacing the dispatcher is unusual — the default '
            'GestureBinding implementation already handles arena, '
            'transforms, and error reporting.',
            style: TextStyle(
              fontSize: 12.0,
              color: _cyanGlow,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  print('HitTestDispatcher Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: _slateDeep,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          _buildSectionTitle('1. Anatomy'),
          anatomyBlock,
          SizedBox(height: 16.0),
          _buildSectionTitle('2. Pointer Pipeline'),
          pipelineDiagram,
          SizedBox(height: 16.0),
          _buildSectionTitle('3. Family'),
          familyTable,
          SizedBox(height: 16.0),
          _buildSectionTitle('4. Real-World Mock'),
          realWorldMock,
          SizedBox(height: 16.0),
          _buildSectionTitle('5. Implementations'),
          implementationsGallery,
          SizedBox(height: 16.0),
          _buildSectionTitle('6. PointerEvent Family'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: pointerFamilyCards,
            ),
          ),
          SizedBox(height: 16.0),
          _buildSectionTitle('7. Code'),
          codeBlock,
          SizedBox(height: 16.0),
          _buildSectionTitle('8. Lifecycle'),
          lifecycleBlock,
          SizedBox(height: 16.0),
          _buildSectionTitle('9. Footguns'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: footgunCards,
            ),
          ),
          SizedBox(height: 16.0),
          _buildSectionTitle('10. Recap'),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

Widget _buildSectionTitle(String text) {
  return Container(
    margin: EdgeInsets.only(top: 8.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _cyanCore.withValues(alpha: 0.25),
          _cyanCore.withValues(alpha: 0.05),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: _cyanSoft, width: 4.0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: _cyanGlow,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _buildPill(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: color.withValues(alpha: 0.6),
        width: 1.0,
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildSignatureLine(
  String prefix,
  String params,
  String suffix,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: _slateDeep,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          prefix,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: _cyanSoft,
          ),
        ),
        Text(
          params,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: _emberSoft,
          ),
        ),
        Text(
          suffix,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: _cyanSoft,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPipelineStep(
  int index,
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.12),
          color.withValues(alpha: 0.04),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: color.withValues(alpha: 0.5),
        width: 1.0,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.5),
                blurRadius: 8.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: _slateDeep,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 16.0),
                  SizedBox(width: 6.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.5,
                  color: _slateMist,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPipelineArrow() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 16.0),
    child: Icon(
      Icons.arrow_downward,
      color: _emberSoft,
      size: 20.0,
    ),
  );
}

Widget _buildFamHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.bold,
        color: _cyanGlow,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _buildFamRow(
  String type,
  String role,
  String relationship,
  Color accent,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: _slateLine, width: 0.5),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        SizedBox(
          width: 200.0,
          child: Text(
            role,
            style: TextStyle(
              fontSize: 11.0,
              color: _slateMist,
              height: 1.35,
            ),
          ),
        ),
        SizedBox(
          width: 220.0,
          child: Text(
            relationship,
            style: TextStyle(
              fontSize: 11.0,
              color: _emberGlow,
              height: 1.35,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHitEntry(
  int index,
  String label,
  Color color,
  IconData icon,
  String tag,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.2),
          color.withValues(alpha: 0.05),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: color.withValues(alpha: 0.5),
        width: 1.0,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 22.0,
          height: 22.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.3),
          ),
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Icon(icon, color: color, size: 14.0),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          tag,
          style: TextStyle(
            fontSize: 9.0,
            color: color,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _buildArrowDown() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2.0),
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 10.0),
    child: Icon(
      Icons.south,
      color: _emberSoft,
      size: 14.0,
    ),
  );
}

Widget _buildImplCard(
  String title,
  String pkg,
  String body,
  IconData icon,
  Color color,
  List<String> tags,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _slateMid,
          _slateSoft.withValues(alpha: 0.85),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    pkg,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: _slateMist,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 12.0,
            color: _slateMist,
            height: 1.45,
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: [
            for (final tag in tags) _buildPill(tag, color),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCodeSegment(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 1.5),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: color,
        height: 1.4,
      ),
    ),
  );
}

Widget _buildLifecycleStep(
  int index,
  String title,
  String body,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _slateSoft.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: _emberCore, width: 3.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _emberCore.withValues(alpha: 0.2),
            border: Border.all(color: _emberCore, width: 1.5),
          ),
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: _emberSoft,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: _emberGlow,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
                  color: _slateMist,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecapLine(String label, String body, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: color, width: 3.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            body,
            style: TextStyle(
              fontSize: 11.5,
              color: _slateMist,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
