// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for GestureDetector,
// RawGestureDetector, and the gesture-recognizer family — every callback
// surface, hit-test behavior, drag start behavior, factory plumbing.
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('GestureDetector deep visual demo executing');

  // ============================================================
  // SECTION 1: Header / Concept Card
  // ============================================================
  print('=== Section 1: Header and concept overview ===');

  final headerCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1A237E), Color(0xFF311B92)],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
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
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(Icons.gesture, color: Colors.white, size: 32.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GestureDetector',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'The full pointer-input surface in Flutter',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GestureDetector is the convenience widget on top of',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
              SizedBox(height: 4.0),
              Text(
                'RawGestureDetector. It exposes a named callback for',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
              SizedBox(height: 4.0),
              Text(
                'every common gesture: taps, double-taps, long presses,',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
              SizedBox(height: 4.0),
              Text(
                'pans, scales, vertical/horizontal drags, force presses.',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _pill('HitTestBehavior', Color(0xFFFFAB00)),
            SizedBox(width: 8.0),
            _pill('DragStartBehavior', Color(0xFF00E5FF)),
            SizedBox(width: 8.0),
            _pill('RecognizerFactory', Color(0xFFFF5252)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Tap / DoubleTap / LongPress Inventory
  // ============================================================
  print('=== Section 2: Tap, double-tap, long-press callbacks ===');

  // Every tap callback fires no-op closures so we exercise just the
  // constructor surface — the interpreter binds the named parameters.
  final tapInventory = GestureDetector(
    onTap: () {},
    onTapDown: (TapDownDetails d) {},
    onTapUp: (TapUpDetails d) {},
    onTapCancel: () {},
    onSecondaryTap: () {},
    onSecondaryTapDown: (TapDownDetails d) {},
    onSecondaryTapUp: (TapUpDetails d) {},
    onSecondaryTapCancel: () {},
    onTertiaryTapDown: (TapDownDetails d) {},
    onTertiaryTapUp: (TapUpDetails d) {},
    onTertiaryTapCancel: () {},
    behavior: HitTestBehavior.opaque,
    child: _swatch('Tap family', Color(0xFF1976D2), Icons.touch_app),
  );

  final doubleTapInventory = GestureDetector(
    onDoubleTap: () {},
    onDoubleTapDown: (TapDownDetails d) {},
    onDoubleTapCancel: () {},
    child: _swatch('Double-tap', Color(0xFF7B1FA2), Icons.double_arrow),
  );

  final longPressInventory = GestureDetector(
    onLongPress: () {},
    onLongPressStart: (LongPressStartDetails d) {},
    onLongPressMoveUpdate: (LongPressMoveUpdateDetails d) {},
    onLongPressUp: () {},
    onLongPressEnd: (LongPressEndDetails d) {},
    onLongPressDown: (LongPressDownDetails d) {},
    onLongPressCancel: () {},
    onSecondaryLongPress: () {},
    onSecondaryLongPressStart: (LongPressStartDetails d) {},
    onSecondaryLongPressMoveUpdate: (LongPressMoveUpdateDetails d) {},
    onSecondaryLongPressUp: () {},
    onSecondaryLongPressEnd: (LongPressEndDetails d) {},
    onSecondaryLongPressDown: (LongPressDownDetails d) {},
    onSecondaryLongPressCancel: () {},
    onTertiaryLongPress: () {},
    onTertiaryLongPressStart: (LongPressStartDetails d) {},
    onTertiaryLongPressMoveUpdate: (LongPressMoveUpdateDetails d) {},
    onTertiaryLongPressUp: () {},
    onTertiaryLongPressEnd: (LongPressEndDetails d) {},
    onTertiaryLongPressDown: (LongPressDownDetails d) {},
    onTertiaryLongPressCancel: () {},
    child: _swatch('Long press', Color(0xFFC62828), Icons.timer),
  );

  final tapSection = _section(
    'Tap, Double-Tap, Long Press',
    'Every callback variant — primary, secondary, tertiary buttons',
    Color(0xFF1976D2),
    Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: [tapInventory, doubleTapInventory, longPressInventory],
    ),
  );

  // ============================================================
  // SECTION 3: HitTestBehavior comparison
  // ============================================================
  print('=== Section 3: HitTestBehavior comparison ===');

  final behaviorDeferToChild = GestureDetector(
    behavior: HitTestBehavior.deferToChild,
    onTap: () {},
    child: _swatch(
      'deferToChild',
      Color(0xFF388E3C),
      Icons.child_care,
    ),
  );

  final behaviorOpaque = GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {},
    child: _swatch(
      'opaque',
      Color(0xFF455A64),
      Icons.layers,
    ),
  );

  final behaviorTranslucent = GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {},
    child: _swatch(
      'translucent',
      Color(0xFFFB8C00),
      Icons.opacity,
    ),
  );

  final hitTestExplainer = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFAED581), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HitTestBehavior',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF33691E),
          ),
        ),
        SizedBox(height: 6.0),
        _bullet('deferToChild', 'only hits the child reports'),
        _bullet('opaque', 'covers the region; blocks behind'),
        _bullet('translucent', 'receives hits AND lets through to behind'),
      ],
    ),
  );

  final hitTestSection = _section(
    'HitTestBehavior',
    'Controls who receives pointer events when stacked',
    Color(0xFF388E3C),
    Column(
      children: [
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            behaviorDeferToChild,
            behaviorOpaque,
            behaviorTranslucent,
          ],
        ),
        hitTestExplainer,
      ],
    ),
  );

  print('Sections 1-3 created');

  // ============================================================
  // SECTION 4: Pan / Drag / Scale demos
  // ============================================================
  print('=== Section 4: Pan, drag, and scale demos ===');

  final panDemo = GestureDetector(
    dragStartBehavior: DragStartBehavior.start,
    onPanDown: (DragDownDetails d) {},
    onPanStart: (DragStartDetails d) {},
    onPanUpdate: (DragUpdateDetails d) {},
    onPanEnd: (DragEndDetails d) {},
    onPanCancel: () {},
    child: _swatch('Pan', Color(0xFF00897B), Icons.pan_tool),
  );

  final verticalDragDemo = GestureDetector(
    dragStartBehavior: DragStartBehavior.down,
    onVerticalDragDown: (DragDownDetails d) {},
    onVerticalDragStart: (DragStartDetails d) {},
    onVerticalDragUpdate: (DragUpdateDetails d) {},
    onVerticalDragEnd: (DragEndDetails d) {},
    onVerticalDragCancel: () {},
    child: _swatch('Vertical drag', Color(0xFF5E35B1), Icons.swap_vert),
  );

  final horizontalDragDemo = GestureDetector(
    dragStartBehavior: DragStartBehavior.start,
    onHorizontalDragDown: (DragDownDetails d) {},
    onHorizontalDragStart: (DragStartDetails d) {},
    onHorizontalDragUpdate: (DragUpdateDetails d) {},
    onHorizontalDragEnd: (DragEndDetails d) {},
    onHorizontalDragCancel: () {},
    child: _swatch('Horizontal drag', Color(0xFFD84315), Icons.swap_horiz),
  );

  final scaleDemo = GestureDetector(
    onScaleStart: (ScaleStartDetails d) {},
    onScaleUpdate: (ScaleUpdateDetails d) {},
    onScaleEnd: (ScaleEndDetails d) {},
    child: _swatch('Scale (pinch)', Color(0xFF6A1B9A), Icons.zoom_out_map),
  );

  final forcePressDemo = GestureDetector(
    onForcePressStart: (ForcePressDetails d) {},
    onForcePressPeak: (ForcePressDetails d) {},
    onForcePressUpdate: (ForcePressDetails d) {},
    onForcePressEnd: (ForcePressDetails d) {},
    child: _swatch('Force press', Color(0xFFB71C1C), Icons.compress),
  );

  final dragStartBehaviorCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFB74D), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DragStartBehavior',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        SizedBox(height: 6.0),
        _bullet(
          'DragStartBehavior.start',
          'drag begins when the slop threshold is crossed',
        ),
        _bullet(
          'DragStartBehavior.down',
          'drag begins immediately on pointer down',
        ),
      ],
    ),
  );

  final dragScaleSection = _section(
    'Pan, Drag, Scale, Force',
    'Continuous gesture callbacks — start/update/end triplets',
    Color(0xFF00897B),
    Column(
      children: [
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            panDemo,
            verticalDragDemo,
            horizontalDragDemo,
            scaleDemo,
            forcePressDemo,
          ],
        ),
        SizedBox(height: 12.0),
        dragStartBehaviorCard,
      ],
    ),
  );

  print('Section 4 created');

  // ============================================================
  // SECTION 5: RawGestureDetector recipe
  // ============================================================
  print('=== Section 5: RawGestureDetector recipe ===');

  // The factory map is the heart of RawGestureDetector. Each entry
  // pairs a recognizer Type with a factory that constructs and
  // initializes an instance of that recognizer. Here we wire up
  // four recognizers using GestureRecognizerFactoryWithHandlers.
  final rawGestureRecipe = RawGestureDetector(
    behavior: HitTestBehavior.opaque,
    excludeFromSemantics: false,
    gestures: <Type, GestureRecognizerFactory>{
      TapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
        () => TapGestureRecognizer(),
        (TapGestureRecognizer instance) {
          instance.onTap = () {};
          instance.onTapDown = (TapDownDetails d) {};
          instance.onTapUp = (TapUpDetails d) {};
          instance.onTapCancel = () {};
        },
      ),
      DoubleTapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
        () => DoubleTapGestureRecognizer(),
        (DoubleTapGestureRecognizer instance) {
          instance.onDoubleTap = () {};
          instance.onDoubleTapDown = (TapDownDetails d) {};
          instance.onDoubleTapCancel = () {};
        },
      ),
      LongPressGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
        () => LongPressGestureRecognizer(),
        (LongPressGestureRecognizer instance) {
          instance.onLongPress = () {};
          instance.onLongPressStart = (LongPressStartDetails d) {};
          instance.onLongPressMoveUpdate =
              (LongPressMoveUpdateDetails d) {};
          instance.onLongPressEnd = (LongPressEndDetails d) {};
          instance.onLongPressUp = () {};
        },
      ),
      PanGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
        () => PanGestureRecognizer(),
        (PanGestureRecognizer instance) {
          instance.onStart = (DragStartDetails d) {};
          instance.onUpdate = (DragUpdateDetails d) {};
          instance.onEnd = (DragEndDetails d) {};
          instance.onCancel = () {};
        },
      ),
    },
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE65100), Color(0xFFFF6F00)],
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.settings_input_component, color: Colors.white, size: 28.0),
          SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RawGestureDetector',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '4 recognizers via factory map',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  final rawRecipeExplainer = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFEF9A9A), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'gestures: <Type, GestureRecognizerFactory>{ ... }',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB71C1C),
          ),
        ),
        SizedBox(height: 8.0),
        _bullet('Key', 'the recognizer Type (TapGestureRecognizer, …)'),
        _bullet('Value', 'GestureRecognizerFactoryWithHandlers<T>(...)'),
        _bullet('Arg 1', '() => T() — constructor closure'),
        _bullet('Arg 2', '(T instance) { instance.onFoo = ...; }'),
        SizedBox(height: 6.0),
        Text(
          'The same map shape is what GestureDetector builds for you,',
          style: TextStyle(fontSize: 12.0, color: Colors.black87),
        ),
        Text(
          'but Raw gives you instance access to tune everything.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87),
        ),
      ],
    ),
  );

  final rawSection = _section(
    'RawGestureDetector',
    'Factory map plumbing — the engine behind GestureDetector',
    Color(0xFFE65100),
    Column(
      children: [rawGestureRecipe, rawRecipeExplainer],
    ),
  );

  print('Section 5 created');

  // ============================================================
  // SECTION 6: Recognizer factory reference table
  // ============================================================
  print('=== Section 6: Recognizer factory reference table ===');

  // Build one row per recognizer family. Each row describes the
  // recognizer type, the GestureDetector callbacks it powers, and
  // the kind of input it disambiguates against.
  final recognizerRows = <Widget>[
    _recognizerRow(
      'TapGestureRecognizer',
      'onTap, onTapDown, onTapUp, onTapCancel',
      'single-finger discrete tap, competes with double-tap',
      Color(0xFF1976D2),
      Icons.touch_app,
    ),
    _recognizerRow(
      'DoubleTapGestureRecognizer',
      'onDoubleTap, onDoubleTapDown, onDoubleTapCancel',
      'two taps within kDoubleTapTimeout',
      Color(0xFF7B1FA2),
      Icons.double_arrow,
    ),
    _recognizerRow(
      'LongPressGestureRecognizer',
      'onLongPress, onLongPressStart, onLongPressMoveUpdate, onLongPressEnd',
      'pointer held past kLongPressTimeout',
      Color(0xFFC62828),
      Icons.timer,
    ),
    _recognizerRow(
      'PanGestureRecognizer',
      'onPanStart, onPanUpdate, onPanEnd, onPanCancel',
      'free 2D drag in any direction',
      Color(0xFF00897B),
      Icons.pan_tool,
    ),
    _recognizerRow(
      'VerticalDragGestureRecognizer',
      'onVerticalDragStart/Update/End',
      'wins gesture arena against horizontal drags vertically',
      Color(0xFF5E35B1),
      Icons.swap_vert,
    ),
    _recognizerRow(
      'HorizontalDragGestureRecognizer',
      'onHorizontalDragStart/Update/End',
      'wins gesture arena against vertical drags horizontally',
      Color(0xFFD84315),
      Icons.swap_horiz,
    ),
    _recognizerRow(
      'ScaleGestureRecognizer',
      'onScaleStart, onScaleUpdate, onScaleEnd',
      'pinch to zoom — two-pointer focal point + scale + rotation',
      Color(0xFF6A1B9A),
      Icons.zoom_out_map,
    ),
    _recognizerRow(
      'ForcePressGestureRecognizer',
      'onForcePressStart/Peak/Update/End',
      'pressure-sensitive press on supporting devices',
      Color(0xFFB71C1C),
      Icons.compress,
    ),
    _recognizerRow(
      'MultiTapGestureRecognizer',
      'onTapDown, onTapUp, onTapCancel (per-pointer)',
      'tracks each pointer individually — no arena coordination',
      Color(0xFF455A64),
      Icons.fingerprint,
    ),
  ];

  final factoryTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: recognizerRows,
    ),
  );

  // Build a few recognizer instances live so the interpreter sees
  // the constructors and named-arg surfaces.
  final tapRecognizerSample = TapGestureRecognizer()
    ..onTap = () {}
    ..onTapDown = (TapDownDetails d) {}
    ..onTapUp = (TapUpDetails d) {}
    ..onTapCancel = () {};
  print(
      'TapGestureRecognizer constructed: ${tapRecognizerSample.runtimeType}');

  final doubleTapRecognizerSample = DoubleTapGestureRecognizer()
    ..onDoubleTap = () {}
    ..onDoubleTapDown = (TapDownDetails d) {}
    ..onDoubleTapCancel = () {};
  print('DoubleTapGestureRecognizer constructed: '
      '${doubleTapRecognizerSample.runtimeType}');

  final longPressRecognizerSample = LongPressGestureRecognizer(
    duration: Duration(milliseconds: 500),
  )
    ..onLongPress = () {}
    ..onLongPressStart = (LongPressStartDetails d) {}
    ..onLongPressMoveUpdate = (LongPressMoveUpdateDetails d) {}
    ..onLongPressEnd = (LongPressEndDetails d) {}
    ..onLongPressUp = () {};
  print('LongPressGestureRecognizer constructed: '
      '${longPressRecognizerSample.runtimeType}');

  final panRecognizerSample = PanGestureRecognizer()
    ..onStart = (DragStartDetails d) {}
    ..onUpdate = (DragUpdateDetails d) {}
    ..onEnd = (DragEndDetails d) {}
    ..onCancel = () {};
  print('PanGestureRecognizer constructed: '
      '${panRecognizerSample.runtimeType}');

  final scaleRecognizerSample = ScaleGestureRecognizer()
    ..onStart = (ScaleStartDetails d) {}
    ..onUpdate = (ScaleUpdateDetails d) {}
    ..onEnd = (ScaleEndDetails d) {};
  print('ScaleGestureRecognizer constructed: '
      '${scaleRecognizerSample.runtimeType}');

  final factorySection = _section(
    'Recognizer Hierarchy',
    'Every Gesture*Recognizer behind the named callbacks',
    Color(0xFF455A64),
    factoryTable,
  );

  print('Section 6 created');

  // ============================================================
  // SECTION 7: Conflict resolution and gesture arena
  // ============================================================
  print('=== Section 7: Conflict resolution explainer ===');

  final arenaIntro = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF90CAF9), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Color(0xFF0D47A1), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'The Gesture Arena',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'When multiple recognizers respond to the same pointer event,',
          style: TextStyle(fontSize: 13.0, color: Colors.black87),
        ),
        Text(
          "Flutter's gesture arena decides who wins.",
          style: TextStyle(fontSize: 13.0, color: Colors.black87),
        ),
        SizedBox(height: 8.0),
        _bullet('Phase 1', 'pointer down — every interested recognizer joins'),
        _bullet('Phase 2', 'each recognizer either accepts, rejects, or waits'),
        _bullet('Phase 3', 'first to accept exclusively wins'),
        _bullet('Phase 4', 'pointer up forces resolution — top remaining wins'),
        SizedBox(height: 6.0),
        Text(
          'Tap loses to drag once movement exceeds slop. Tap loses to',
          style: TextStyle(fontSize: 12.0, color: Colors.black87),
        ),
        Text(
          'double-tap if a second tap arrives within the timeout window.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87),
        ),
      ],
    ),
  );

  // A widget combining several recognizers that compete: tap, double
  // tap, long press, and pan — exactly the scenario that triggers the
  // arena resolution machinery.
  final arenaDemo = GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {},
    onDoubleTap: () {},
    onLongPress: () {},
    onPanStart: (DragStartDetails d) {},
    onPanUpdate: (DragUpdateDetails d) {},
    onPanEnd: (DragEndDetails d) {},
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        children: [
          Text(
            'Tap + DoubleTap + LongPress + Pan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'four recognizers competing on one widget',
            style: TextStyle(color: Colors.white70, fontSize: 12.0),
          ),
        ],
      ),
    ),
  );

  final arenaSection = _section(
    'Conflict Resolution',
    'How the gesture arena disambiguates competing recognizers',
    Color(0xFF0D47A1),
    Column(
      children: [arenaIntro, arenaDemo],
    ),
  );

  print('Section 7 created');

  // ============================================================
  // SECTION 8: DragStartBehavior, supportedDevices, mouse cursor
  // ============================================================
  print('=== Section 8: Misc configuration surface ===');

  final supportedDevicesDemo = GestureDetector(
    supportedDevices: <PointerDeviceKind>{
      PointerDeviceKind.touch,
      PointerDeviceKind.stylus,
      PointerDeviceKind.invertedStylus,
    },
    onTap: () {},
    child: _swatch(
      'supportedDevices',
      Color(0xFF00838F),
      Icons.devices_other,
    ),
  );

  final mouseTrackpadDemo = GestureDetector(
    supportedDevices: <PointerDeviceKind>{
      PointerDeviceKind.mouse,
      PointerDeviceKind.trackpad,
    },
    onTap: () {},
    onScaleStart: (ScaleStartDetails d) {},
    onScaleUpdate: (ScaleUpdateDetails d) {},
    onScaleEnd: (ScaleEndDetails d) {},
    trackpadScrollCausesScale: true,
    trackpadScrollToScaleFactor: Offset(0.0, -1.0 / 200.0),
    child: _swatch(
      'mouse + trackpad',
      Color(0xFFAD1457),
      Icons.mouse,
    ),
  );

  final excludeSemanticsDemo = GestureDetector(
    excludeFromSemantics: true,
    onTap: () {},
    child: _swatch(
      'excludeFromSemantics',
      Color(0xFF6D4C41),
      Icons.accessibility_new,
    ),
  );

  final dragBehaviorDownDemo = GestureDetector(
    dragStartBehavior: DragStartBehavior.down,
    onPanStart: (DragStartDetails d) {},
    onPanUpdate: (DragUpdateDetails d) {},
    onPanEnd: (DragEndDetails d) {},
    child: _swatch(
      'dragStart=down',
      Color(0xFF2E7D32),
      Icons.arrow_downward,
    ),
  );

  final dragBehaviorStartDemo = GestureDetector(
    dragStartBehavior: DragStartBehavior.start,
    onPanStart: (DragStartDetails d) {},
    onPanUpdate: (DragUpdateDetails d) {},
    onPanEnd: (DragEndDetails d) {},
    child: _swatch(
      'dragStart=start',
      Color(0xFFEF6C00),
      Icons.play_arrow,
    ),
  );

  final miscExplainer = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB39DDB), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other configuration knobs',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4527A0),
          ),
        ),
        SizedBox(height: 6.0),
        _bullet(
          'supportedDevices',
          'restrict which PointerDeviceKind values fire callbacks',
        ),
        _bullet(
          'trackpadScrollCausesScale',
          'route trackpad two-finger scroll to scale callbacks',
        ),
        _bullet(
          'trackpadScrollToScaleFactor',
          'scale-factor offset applied per trackpad scroll',
        ),
        _bullet(
          'excludeFromSemantics',
          'omit gesture from accessibility tree',
        ),
      ],
    ),
  );

  final miscSection = _section(
    'Configuration Surface',
    'supportedDevices, dragStartBehavior, trackpad, semantics',
    Color(0xFF4527A0),
    Column(
      children: [
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            supportedDevicesDemo,
            mouseTrackpadDemo,
            excludeSemanticsDemo,
            dragBehaviorDownDemo,
            dragBehaviorStartDemo,
          ],
        ),
        miscExplainer,
      ],
    ),
  );

  print('Section 8 created');

  // ============================================================
  // SECTION 9: Animated snapshot via Tween.transform
  // ============================================================
  print('=== Section 9: Static animation snapshot ===');

  // We use AlwaysStoppedAnimation + Tween.transform to render a
  // frozen frame of an interaction — this stays inside the d4rt
  // interpreter limits (no ticker, no setState).
  const double t = 0.4;
  final double scaleSnapshot = Tween<double>(begin: 1.0, end: 1.4).transform(t);
  final double rotationSnapshot =
      Tween<double>(begin: 0.0, end: 0.25).transform(t);
  final double opacitySnapshot =
      Tween<double>(begin: 0.6, end: 1.0).transform(t);

  final snapshot = AlwaysStoppedAnimation<double>(t);
  print('AlwaysStoppedAnimation value: ${snapshot.value}');
  print('Scale snapshot at t=$t: $scaleSnapshot');
  print('Rotation snapshot at t=$t: $rotationSnapshot');
  print('Opacity snapshot at t=$t: $opacitySnapshot');

  final snapshotCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF263238), Color(0xFF37474F)],
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      children: [
        Text(
          'Frozen Scale + Rotation Snapshot',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.0),
        Opacity(
          opacity: opacitySnapshot,
          child: Transform.rotate(
            angle: rotationSnapshot,
            child: Transform.scale(
              scale: scaleSnapshot,
              child: GestureDetector(
                onScaleStart: (ScaleStartDetails d) {},
                onScaleUpdate: (ScaleUpdateDetails d) {},
                onScaleEnd: (ScaleEndDetails d) {},
                child: Container(
                  width: 120.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFAB00),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'pinch',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'scale=${scaleSnapshot.toStringAsFixed(2)}  '
          'rot=${rotationSnapshot.toStringAsFixed(2)}rad  '
          'op=${opacitySnapshot.toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );

  final snapshotSection = _section(
    'Animation Snapshot',
    'AlwaysStoppedAnimation + Tween.transform for a frozen frame',
    Color(0xFF263238),
    snapshotCard,
  );

  print('Section 9 created');

  // ============================================================
  // SECTION 10: Summary footer
  // ============================================================
  print('=== Section 10: Summary footer ===');

  final summaryFooter = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GestureDetector — coverage summary',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        SizedBox(height: 10.0),
        _summaryLine('tap', '4 callbacks × 3 buttons = 12 entries'),
        _summaryLine('double-tap', 'down + tap + cancel'),
        _summaryLine('long press', '7 callbacks × 3 buttons = 21 entries'),
        _summaryLine('pan', 'down/start/update/end/cancel'),
        _summaryLine('vertical drag', 'down/start/update/end/cancel'),
        _summaryLine('horizontal drag', 'down/start/update/end/cancel'),
        _summaryLine('scale', 'start/update/end (pinch)'),
        _summaryLine('force press', 'start/peak/update/end'),
        _summaryLine('hit-test', 'deferToChild / opaque / translucent'),
        _summaryLine('drag start', 'DragStartBehavior.start / .down'),
        _summaryLine('raw', 'GestureRecognizerFactoryWithHandlers map'),
        _summaryLine('arena', 'tap/double-tap/long-press/pan competing'),
        SizedBox(height: 12.0),
        Text(
          'Every constructor, every named callback, every enum surface',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        Text(
          'exercised by the d4rt analyzer-free interpreter.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  print('All sections assembled — building final ListView');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  final body = ListView(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    children: [
      headerCard,
      tapSection,
      hitTestSection,
      dragScaleSection,
      rawSection,
      factorySection,
      arenaSection,
      miscSection,
      snapshotSection,
      summaryFooter,
    ],
  );

  final scaffold = Scaffold(
    backgroundColor: Color(0xFFFAFAFA),
    appBar: AppBar(
      title: Text('GestureDetector — Deep Visual Demo'),
      backgroundColor: Color(0xFF1A237E),
      foregroundColor: Colors.white,
      elevation: 4.0,
    ),
    body: body,
  );

  print('GestureDetector deep visual demo complete');
  return scaffold;
}

// ============================================================
// SHARED HELPERS — small builders used across sections
// ============================================================

Widget _pill(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _swatch(String label, Color color, IconData icon) {
  return Container(
    width: 140.0,
    height: 80.0,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 24.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _section(String title, String subtitle, Color color, Widget body) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2.0),
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
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        body,
      ],
    ),
  );
}

Widget _bullet(String head, String tail) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 13.0, color: Colors.black87),
              children: <TextSpan>[
                TextSpan(
                  text: '$head: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: tail),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recognizerRow(
  String name,
  String callbacks,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.white, size: 20.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                callbacks,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.black87,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.black54,
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

Widget _summaryLine(String label, String detail) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Container(
          width: 100.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0xFF1A237E),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            detail,
            style: TextStyle(fontSize: 12.0, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}
