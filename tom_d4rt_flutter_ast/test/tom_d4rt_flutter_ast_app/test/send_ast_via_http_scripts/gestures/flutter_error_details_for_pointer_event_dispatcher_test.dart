// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demonstration of
// FlutterErrorDetailsForPointerEventDispatcher from package:flutter/gestures.dart
//
// FlutterErrorDetailsForPointerEventDispatcher is a specialized variant of
// FlutterErrorDetails used by the gesture library's binding when an exception
// is raised while dispatching a pointer event. It augments FlutterErrorDetails
// with two extra fields that are unique to pointer-event dispatch failures:
//
//   - event:        the PointerEvent that was being routed when it threw.
//   - hitTestEntry: the HitTestEntry whose target.handleEvent threw (may be
//                   null for non-hit-tested events such as PointerAddedEvent
//                   and PointerRemovedEvent).
//
// Inherited from FlutterErrorDetails:
//
//   - exception:             the thing that was thrown.
//   - stack:                 stack trace at the point of throw.
//   - library:               human-readable library name (e.g. 'gesture library').
//   - context:               ErrorDescription explaining what was happening.
//   - informationCollector:  optional callback returning extra DiagnosticsNodes.
//   - silent:                whether to suppress the error in console output.
//
// The class is the breadcrumb that lets developers (and FlutterError.onError
// dump handlers) reconstruct *which pointer event* and *which target widget*
// caused the explosion - without it, gesture exceptions would surface with
// only a generic stack trace.

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Construct several FlutterErrorDetailsForPointerEventDispatcher
  // instances representing different failure scenarios. We will
  // demonstrate each field via its own visual card.
  // ============================================================

  final detailsHover = FlutterErrorDetailsForPointerEventDispatcher(
    exception: Exception('null reference inside hover handler'),
    stack: StackTrace.current,
    library: 'gesture library',
    context: ErrorDescription('while dispatching a non-hit-tested pointer event'),
    event: PointerHoverEvent(
      position: Offset(120.0, 240.0),
      device: 1,
      pointer: 7,
    ),
    informationCollector: () => <DiagnosticsNode>[
      DiagnosticsProperty<String>('Event', 'PointerHoverEvent@(120,240)'),
    ],
    silent: false,
  );

  final detailsTap = FlutterErrorDetailsForPointerEventDispatcher(
    exception: StateError('Bad state: setState called after dispose'),
    stack: StackTrace.current,
    library: 'gesture library',
    context: ErrorDescription('while dispatching a pointer event'),
    event: PointerDownEvent(
      position: Offset(64.0, 32.0),
      device: 0,
      pointer: 11,
      buttons: kPrimaryButton,
    ),
    informationCollector: () => <DiagnosticsNode>[
      DiagnosticsProperty<String>('Event', 'PointerDownEvent@(64,32)'),
      DiagnosticsProperty<String>('Target', 'GestureDetector#a3f1c'),
    ],
    silent: false,
  );

  final detailsSilent = FlutterErrorDetailsForPointerEventDispatcher(
    exception: ArgumentError('non-positive radius'),
    stack: StackTrace.current,
    library: 'gesture library',
    context: ErrorDescription('while dispatching a pointer event'),
    event: PointerMoveEvent(
      position: Offset(200.0, 200.0),
      device: 0,
      pointer: 12,
    ),
    silent: true,
  );

  // ============================================================
  // SECTION 1 - Hero header
  // ============================================================
  final heroHeader = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFB71C1C),
          Color(0xFFD84315),
          Color(0xFFFF6F00),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.report_gmailerrorred, color: Colors.white, size: 56.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FlutterErrorDetailsForPointerEventDispatcher',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'extends FlutterErrorDetails  --  carries the offending PointerEvent\n'
            'and HitTestEntry alongside the usual exception / stack / context.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.4,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 - Anatomy diagram (inheritance + extra fields)
  // ============================================================
  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFEBEE), Color(0xFFFFF3E0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Class anatomy',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        // base class block
        _ancestorBox('FlutterErrorDetails', Colors.indigo, [
          'exception',
          'stack',
          'library',
          'context',
          'informationCollector',
          'silent',
        ]),
        Center(
          child: Icon(
            Icons.arrow_downward,
            color: Colors.deepOrange.shade700,
            size: 32.0,
          ),
        ),
        Center(
          child: Text(
            'extends',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.deepOrange.shade700,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        _ancestorBox(
          'FlutterErrorDetailsForPointerEventDispatcher',
          Colors.red,
          ['+ event   (PointerEvent?)', '+ hitTestEntry  (HitTestEntry?)'],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3 - Per-field cards (8 fields total)
  // ============================================================
  final fieldCards = <Widget>[
    _fieldCard(
      glyph: Icons.bug_report,
      title: 'exception',
      type: 'Object',
      gradientColors: [Color(0xFFFFCDD2), Color(0xFFEF9A9A)],
      shadowColor: Colors.red,
      sample: detailsTap.exception.toString(),
      description:
          'The thrown object - usually an Exception or Error subclass. '
          'Inherited from FlutterErrorDetails. This is what FlutterError '
          'will eventually toString() into the console banner.',
    ),
    _fieldCard(
      glyph: Icons.stairs,
      title: 'stack',
      type: 'StackTrace?',
      gradientColors: [Color(0xFFFFE0B2), Color(0xFFFFB74D)],
      shadowColor: Colors.orange,
      sample: '#0  GestureBinding._handlePointerEventImmediately ...',
      description:
          'The stack trace captured at catch-time. Without it the dump '
          'would lose the call chain that led into the gesture handler.',
    ),
    _fieldCard(
      glyph: Icons.menu_book,
      title: 'library',
      type: 'String?',
      gradientColors: [Color(0xFFFFF59D), Color(0xFFFFCA28)],
      shadowColor: Colors.amber,
      sample: detailsHover.library ?? '<null>',
      description:
          'Human-readable library name. Always set to "gesture library" by '
          'GestureBinding.dispatchEvent so the error banner can group '
          'errors by source subsystem.',
    ),
    _fieldCard(
      glyph: Icons.description,
      title: 'context',
      type: 'DiagnosticsNode?',
      gradientColors: [Color(0xFFC8E6C9), Color(0xFF66BB6A)],
      shadowColor: Colors.green,
      sample: detailsTap.context?.toString() ?? '<null>',
      description:
          'A short ErrorDescription explaining the activity that was '
          'happening. Either "while dispatching a pointer event" or '
          '"while dispatching a non-hit-tested pointer event".',
    ),
    _fieldCard(
      glyph: Icons.touch_app,
      title: 'event',
      type: 'PointerEvent?',
      gradientColors: [Color(0xFFB3E5FC), Color(0xFF29B6F6)],
      shadowColor: Colors.lightBlue,
      sample: detailsTap.event?.runtimeType.toString() ?? '<null>',
      description:
          'EXTRA FIELD added by this subclass: the exact PointerEvent that '
          'was being routed. Captures position, device id, pointer id, '
          'buttons and timestamp - critical for reproducing the failure.',
    ),
    _fieldCard(
      glyph: Icons.gps_fixed,
      title: 'hitTestEntry',
      type: 'HitTestEntry?',
      gradientColors: [Color(0xFFD1C4E9), Color(0xFF7E57C2)],
      shadowColor: Colors.deepPurple,
      sample: detailsTap.hitTestEntry?.toString() ?? '<null - hover/add/remove>',
      description:
          'EXTRA FIELD added by this subclass: the HitTestEntry of the '
          'target whose handleEvent threw. Null for non-hit-tested events '
          '(hover, added, removed). Use entry.target to identify the widget.',
    ),
    _fieldCard(
      glyph: Icons.list_alt,
      title: 'informationCollector',
      type: 'InformationCollector?',
      gradientColors: [Color(0xFFB2DFDB), Color(0xFF26A69A)],
      shadowColor: Colors.teal,
      sample: detailsTap.informationCollector == null ? '<null>' : '() => [...]',
      description:
          'Lazy callback returning extra DiagnosticsNodes. Only invoked '
          'when the error is actually printed - keeps cheap-path costs '
          'down. Typically lists the Event and Target as errorProperty.',
    ),
    _fieldCard(
      glyph: Icons.volume_off,
      title: 'silent',
      type: 'bool',
      gradientColors: [Color(0xFFCFD8DC), Color(0xFF78909C)],
      shadowColor: Colors.blueGrey,
      sample: detailsSilent.silent.toString(),
      description:
          'When true, suppresses the per-error banner that FlutterError '
          'normally writes. Used for expected errors during shutdown or '
          'during repeated noisy failures the developer has acknowledged.',
    ),
  ];

  // ============================================================
  // SECTION 4 - Error scenarios (hit-tested vs non-hit-tested)
  // ============================================================
  final scenarioSection = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFE8EAF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.16),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Two dispatch failure scenarios',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _scenarioCard(
          icon: Icons.swipe,
          title: 'Hit-tested dispatch (tap, drag, scroll, ...)',
          color: Colors.indigo,
          eventLabel: 'PointerDownEvent / PointerMoveEvent / PointerUpEvent',
          contextLabel: 'while dispatching a pointer event',
          hitTestNote: 'hitTestEntry  IS  populated',
          collectorBullets: [
            'Event   -> the PointerEvent',
            'Target  -> entry.target (a HitTestTarget)',
          ],
        ),
        SizedBox(height: 12.0),
        _scenarioCard(
          icon: Icons.touch_app,
          title: 'Non-hit-tested dispatch (hover, added, removed)',
          color: Colors.deepPurple,
          eventLabel: 'PointerHoverEvent / PointerAddedEvent / PointerRemovedEvent',
          contextLabel: 'while dispatching a non-hit-tested pointer event',
          hitTestNote: 'hitTestEntry  is  null',
          collectorBullets: [
            'Event  -> the PointerEvent (no Target line)',
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5 - Recipes
  // ============================================================
  final recipeSection = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.green.shade900, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recipeCode(
          'Filter pointer-dispatch errors only',
          "FlutterError.onError = (FlutterErrorDetails details) {\n"
          "  if (details is FlutterErrorDetailsForPointerEventDispatcher) {\n"
          "    final PointerEvent? evt = details.event;\n"
          "    final HitTestEntry? entry = details.hitTestEntry;\n"
          "    crashReporter.recordGestureCrash(evt, entry, details.exception);\n"
          "  } else {\n"
          "    FlutterError.presentError(details);\n"
          "  }\n"
          "};",
        ),
        SizedBox(height: 12.0),
        _recipeCode(
          'Identify the offending widget target',
          "if (details is FlutterErrorDetailsForPointerEventDispatcher) {\n"
          "  final HitTestTarget? target = details.hitTestEntry?.target;\n"
          "  debugPrint('Bad target: \${target.runtimeType}');\n"
          "}",
        ),
        SizedBox(height: 12.0),
        _recipeCode(
          'Reproduce by replaying the captured event',
          "final PointerEvent? evt = details.event;\n"
          "if (evt is PointerDownEvent) {\n"
          "  testReplayQueue.addDown(evt.position, evt.pointer);\n"
          "}",
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6 - Pitfalls
  // ============================================================
  final pitfallSection = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.22),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange.shade900, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallTile(
          'hitTestEntry can be null',
          'For PointerHoverEvent / PointerAddedEvent / PointerRemovedEvent '
              'the gesture binding uses the non-hit-tested branch and leaves '
              'hitTestEntry null. Always null-check before reading .target.',
        ),
        _pitfallTile(
          'event can also be null',
          'The field is declared as PointerEvent? - if you construct an '
              'instance manually for testing without an event, downstream '
              'code that assumes non-null will crash a second time.',
        ),
        _pitfallTile(
          'informationCollector is lazy',
          'It is only invoked when the error is presented. Do not put '
              'side effects in it; treat it as a pure formatting hook.',
        ),
        _pitfallTile(
          'silent does not mean swallowed',
          'silent only suppresses the default banner. The error is still '
              'sent to FlutterError.onError and your custom handler.',
        ),
        _pitfallTile(
          'Do not extend further',
          'The class is designed as a leaf. Adding more subclasses defeats '
              'the type-check pattern used by error reporters.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7 - Debugging flow
  // ============================================================
  final debugFlow = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Debugging flow',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _flowStep(1, 'Pointer dispatched', Icons.touch_app, Colors.blue),
        _flowConnector(),
        _flowStep(2, 'handleEvent throws', Icons.bolt, Colors.red),
        _flowConnector(),
        _flowStep(
          3,
          'Binding wraps in FlutterErrorDetailsForPointerEventDispatcher',
          Icons.archive,
          Colors.orange,
        ),
        _flowConnector(),
        _flowStep(4, 'FlutterError.reportError(details)', Icons.send, Colors.green),
        _flowConnector(),
        _flowStep(
          5,
          'Your FlutterError.onError sees rich context',
          Icons.visibility,
          Colors.deepPurple,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8 - Quick reference table
  // ============================================================
  final quickReference = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFECEFF1), Color(0xFFCFD8DC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick field reference',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade700,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _refHeader('field', 170.0),
              _refHeader('type', 150.0),
              _refHeader('source', 110.0),
            ],
          ),
        ),
        _refRow('exception', 'Object', 'inherited', Colors.red.shade50),
        _refRow('stack', 'StackTrace?', 'inherited', Colors.orange.shade50),
        _refRow('library', 'String?', 'inherited', Colors.amber.shade50),
        _refRow('context', 'DiagnosticsNode?', 'inherited', Colors.green.shade50),
        _refRow('event', 'PointerEvent?', 'subclass', Colors.lightBlue.shade50),
        _refRow('hitTestEntry', 'HitTestEntry?', 'subclass', Colors.deepPurple.shade50),
        _refRow('informationCollector', 'InformationCollector?', 'inherited', Colors.teal.shade50),
        _refRow('silent', 'bool', 'inherited', Colors.blueGrey.shade50),
      ],
    ),
  );

  // ============================================================
  // SECTION 9 - ASCII footer
  // ============================================================
  final asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF000000)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Text(
      '+----------------------------------------------------------+\n'
      '|   FlutterErrorDetails                                    |\n'
      '|       |  exception, stack, library, context,             |\n'
      '|       |  informationCollector, silent                    |\n'
      '|       v                                                  |\n'
      '|   FlutterErrorDetailsForPointerEventDispatcher           |\n'
      '|       + event          : PointerEvent?                   |\n'
      '|       + hitTestEntry   : HitTestEntry?                   |\n'
      '|                                                          |\n'
      '|   raised from: GestureBinding.dispatchEvent              |\n'
      '|   reported  via: FlutterError.reportError(details)       |\n'
      '|   handled   in: FlutterError.onError                     |\n'
      '+----------------------------------------------------------+',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Color(0xFF80DEEA),
        height: 1.4,
      ),
    ),
  );

  // ============================================================
  // Provide a fake animation to satisfy the static-motion rule
  // (AlwaysStoppedAnimation, Duration.zero only)
  // ============================================================
  final Animation<double> staticPulse = AlwaysStoppedAnimation<double>(0.7);
  final Duration staticDuration = Duration.zero;

  // ============================================================
  // Compose final layout
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text('FlutterErrorDetailsForPointerEventDispatcher Demo'),
        backgroundColor: Color(0xFFB71C1C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            SizedBox(height: 8.0),
            _sectionTitle('1. Class anatomy'),
            anatomy,
            _sectionTitle('2. Field cards'),
            ...fieldCards,
            _sectionTitle('3. Failure scenarios'),
            scenarioSection,
            _sectionTitle('4. Recipes'),
            recipeSection,
            _sectionTitle('5. Pitfalls'),
            pitfallSection,
            _sectionTitle('6. Debugging flow'),
            debugFlow,
            _sectionTitle('7. Quick reference'),
            quickReference,
            _sectionTitle('8. ASCII summary'),
            asciiFooter,
            SizedBox(height: 24.0),
            Center(
              child: Opacity(
                opacity: staticPulse.value,
                child: Text(
                  'static pulse alpha=${staticPulse.value} -- duration=$staticDuration',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF263238),
      ),
    ),
  );
}

Widget _ancestorBox(String name, Color color, List<String> fields) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.30),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.6),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.30),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: color,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 6.0),
        for (final f in fields)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.chevron_right, size: 14.0, color: color),
                SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    f,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      color: Colors.black87,
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

Widget _fieldCard({
  required IconData glyph,
  required String title,
  required String type,
  required List<Color> gradientColors,
  required Color shadowColor,
  required String sample,
  required String description,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: shadowColor.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
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
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(glyph, color: shadowColor, size: 28.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'value: $sample',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFB2EBF2),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _scenarioCard({
  required IconData icon,
  required String title,
  required Color color,
  required String eventLabel,
  required String contextLabel,
  required String hitTestNote,
  required List<String> collectorBullets,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 26.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _kvRow('event types', eventLabel, color),
        _kvRow('context', '"$contextLabel"', color),
        _kvRow('hitTestEntry', hitTestNote, color),
        SizedBox(height: 8.0),
        Text(
          'informationCollector contributes:',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        for (final b in collectorBullets)
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 2.0),
            child: Text(
              '* $b',
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: Colors.black87,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _kvRow(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCode(String label, String code) {
  return Container(
    margin: EdgeInsets.only(bottom: 4.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1B5E20),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.30),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.lightGreenAccent, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              label,
              style: TextStyle(
                color: Colors.lightGreenAccent,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent.shade100,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallTile(String title, String body) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.error_outline, color: Colors.orange.shade800, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.orange.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flowStep(int idx, String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.4),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 14.0,
          backgroundColor: color,
          foregroundColor: Colors.white,
          child: Text(
            '$idx',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10.0),
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _flowConnector() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Center(
      child: Icon(
        Icons.arrow_downward,
        color: Colors.deepPurple.shade400,
        size: 22.0,
      ),
    ),
  );
}

Widget _refHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'monospace',
        fontSize: 12.0,
      ),
    ),
  );
}

Widget _refRow(String field, String type, String source, Color bg) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 8.0),
    decoration: BoxDecoration(
      color: bg,
      border: Border(
        bottom: BorderSide(color: Colors.blueGrey.shade200, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 170.0,
          child: Text(
            field,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          width: 150.0,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          width: 110.0,
          child: Text(
            source,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: source == 'subclass' ? Colors.red.shade800 : Colors.indigo.shade700,
              fontWeight: source == 'subclass' ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    ),
  );
}
