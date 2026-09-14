// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import, unnecessary_type_check, avoid_print
// D4rt test script: Deep visual demo of object-disposed lifecycle in Flutter.
//
// Flutter's foundation library does not export an ObjectDisposedException type
// the way some other ecosystems do (e.g. .NET's System.ObjectDisposedException
// or RxDart's ObjectDisposedException). Instead, framework objects that own
// state — ChangeNotifier, FocusNode, ScrollController, AnimationController,
// TextEditingController, ValueNotifier, etc. — implement a `dispose()`
// contract and use a debug-only assertion to detect post-dispose use.
//
// In the Flutter framework this looks like:
//
//   bool _debugDisposed = false;
//   bool _debugAssertNotDisposed() {
//     assert(() {
//       if (_debugDisposed) {
//         throw FlutterError(
//           'A ${runtimeType} was used after being disposed.\n'
//           'Once you have called dispose() on a ${runtimeType}, it can no '
//           'longer be used.',
//         );
//       }
//       return true;
//     }());
//     return true;
//   }
//
// In release mode the assertion is stripped: the side effects are undefined.
// "ObjectDisposedException" is therefore conceptual in Flutter — the symptom
// is a thrown FlutterError (a kind of AssertionError) rather than a typed
// exception class. This visual demo explores:
//
//   1. The end-to-end lifecycle of a disposable object
//   2. The dispose() contract and the _debugAssertNotDisposed() pattern
//   3. The framework-specific reason there is no ObjectDisposedException type
//   4. Common consumer patterns and how widgets own / dispose them
//   5. An anti-pattern gallery (BAD vs GOOD panels)
//   6. A diagnostic-output mock-up of a realistic stack trace
//   7. A recap card with the rules of thumb
//
// IMPORTANT: this demo is purely declarative — it never actually invokes
// dispose() or otherwise mutates any of the disposable objects, so the
// SendTestRunner can reproduce the widget tree without runtime exceptions.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Build a small zoo of disposable objects WITHOUT ever disposing them.
  // We only describe their lifecycle through text, icons and labels.
  // ---------------------------------------------------------------------------
  final ChangeNotifier sampleNotifier = ChangeNotifier();
  final ValueNotifier<int> sampleCounter = ValueNotifier<int>(0);
  final ValueNotifier<String> sampleLabel = ValueNotifier<String>('idle');
  final FocusNode sampleFocus = FocusNode(debugLabel: 'demo-focus');
  final ScrollController sampleScroll = ScrollController();
  final TextEditingController sampleText =
      TextEditingController(text: 'hello');

  // Stage descriptors for the lifecycle diagram (Section 2). We use plain
  // data-bag classes (see _LifecycleStage at the bottom of the file) instead
  // of records to keep the AST small and friendly to the test runner.
  final List<_LifecycleStage> lifecycleStages = <_LifecycleStage>[
    _LifecycleStage(
      label: 'created',
      caption: 'constructor returns',
      icon: Icons.add_circle_outline,
      color: Color(0xFF6B8E23), // moss-green
      tint: Color(0xFFE8F0D8),
      flag: '_debugDisposed = false',
    ),
    _LifecycleStage(
      label: 'active',
      caption: 'addListener / hasListeners',
      icon: Icons.bolt_outlined,
      color: Color(0xFF558B2F),
      tint: Color(0xFFEAF2DB),
      flag: 'in use; assertions pass',
    ),
    _LifecycleStage(
      label: 'dispose-called',
      caption: 'dispose() invoked',
      icon: Icons.power_settings_new,
      color: Color(0xFF8B7355), // muted brown bridge
      tint: Color(0xFFEDE6DD),
      flag: '_debugDisposed := true',
    ),
    _LifecycleStage(
      label: 'disposed',
      caption: 'any further use throws',
      icon: Icons.do_not_disturb_on_outlined,
      color: Color(0xFF8A8A8A), // faded grey
      tint: Color(0xFFE5E5E5),
      flag: '_debugAssertNotDisposed() → false',
    ),
  ];

  // Anti-patterns shown side-by-side in Section 5.
  final List<_AntiPattern> antiPatterns = <_AntiPattern>[
    _AntiPattern(
      title: 'Disposing twice',
      bad:
          "controller.dispose();\n// somewhere later...\ncontroller.dispose(); // throws",
      good:
          "@override\nvoid dispose() {\n  controller.dispose();\n  super.dispose();\n}\n// owned in exactly one State; never disposed elsewhere.",
      explanation:
          'The second dispose() runs the same _debugAssertNotDisposed() and '
          'asserts. Ownership must be exactly one place.',
      icon: Icons.repeat_on_outlined,
    ),
    _AntiPattern(
      title: 'Use-after-dispose',
      bad:
          "controller.dispose();\nfinal text = controller.text; // throws in debug",
      good:
          "if (mounted) {\n  final text = controller.text;\n}\n// + dispose only in State.dispose()",
      explanation:
          'Reading any property after dispose() trips the debug assertion. '
          'Always treat dispose() as the very last line of the object\'s life.',
      icon: Icons.warning_amber_outlined,
    ),
    _AntiPattern(
      title: 'Listening on a disposed notifier',
      bad:
          "final n = ChangeNotifier();\nn.dispose();\nn.addListener(_onChange); // throws",
      good:
          "// Construct after parent's initState; always pair addListener\n// with removeListener in dispose() before the notifier itself is freed.",
      explanation:
          'addListener and removeListener both call the debug-not-disposed '
          'check. Subscribing after the object is dead leaks intent and '
          'aborts in debug builds.',
      icon: Icons.hearing_disabled_outlined,
    ),
    _AntiPattern(
      title: 'Forgetting dispose()',
      bad:
          "class _MyState extends State<MyWidget> {\n  final controller = ScrollController();\n  // no dispose() at all\n}",
      good:
          "class _MyState extends State<MyWidget> {\n  final controller = ScrollController();\n  @override\n  void dispose() {\n    controller.dispose();\n    super.dispose();\n  }\n}",
      explanation:
          'No exception is thrown, but the object is never released — its '
          'listeners and any internal timers leak. Memory-allocation tools '
          '(see ObjectCreated / ObjectDisposed events) will report '
          'unbalanced events.',
      icon: Icons.delete_sweep_outlined,
    ),
    _AntiPattern(
      title: 'Sharing a controller across two States',
      bad:
          "// Parent passes the same controller to two children;\n// both children call controller.dispose() in their dispose().",
      good:
          "// Either lift ownership to the parent and dispose there, or\n// give each child its own controller.",
      explanation:
          'Two independent dispose() calls produce the double-dispose '
          'failure mode plus a subtle ownership bug.',
      icon: Icons.call_split_outlined,
    ),
  ];

  // Consumer patterns shown in Section 4.
  final List<_ConsumerPattern> consumers = <_ConsumerPattern>[
    _ConsumerPattern(
      type: 'TextEditingController',
      summary: 'Owns a TextEditingValue + listeners.',
      ownership: 'Always owned by State.initState/dispose().',
      icon: Icons.text_fields_outlined,
      tint: Color(0xFFE3F2FD),
      stroke: Color(0xFF1565C0),
      assertOn: 'addListener, removeListener, value=, text=',
    ),
    _ConsumerPattern(
      type: 'FocusNode',
      summary: 'Tracks focus; participates in FocusScope tree.',
      ownership: 'State, or a controller-style helper.',
      icon: Icons.center_focus_strong_outlined,
      tint: Color(0xFFE8F5E9),
      stroke: Color(0xFF2E7D32),
      assertOn: 'requestFocus, unfocus, addListener',
    ),
    _ConsumerPattern(
      type: 'ScrollController',
      summary: 'Bridges Scrollable position with consumers.',
      ownership: 'Owning State that supplies it to Scrollable widgets.',
      icon: Icons.unfold_more_outlined,
      tint: Color(0xFFFFF3E0),
      stroke: Color(0xFFE65100),
      assertOn: 'jumpTo, animateTo, position, addListener',
    ),
    _ConsumerPattern(
      type: 'AnimationController',
      summary: 'Drives Animations; needs a TickerProvider.',
      ownership: 'State with SingleTickerProviderStateMixin.',
      icon: Icons.animation_outlined,
      tint: Color(0xFFFCE4EC),
      stroke: Color(0xFFAD1457),
      assertOn: 'forward, reverse, value=, addListener',
    ),
    _ConsumerPattern(
      type: 'ChangeNotifier',
      summary: 'Base class for listenable notifiers.',
      ownership: 'Whichever object constructed it.',
      icon: Icons.campaign_outlined,
      tint: Color(0xFFEDE7F6),
      stroke: Color(0xFF512DA8),
      assertOn:
          'addListener, removeListener, notifyListeners, hasListeners',
    ),
    _ConsumerPattern(
      type: 'ValueNotifier<T>',
      summary: 'ChangeNotifier that exposes a single value.',
      ownership: 'Same as ChangeNotifier.',
      icon: Icons.toggle_on_outlined,
      tint: Color(0xFFE0F7FA),
      stroke: Color(0xFF00838F),
      assertOn: 'value=, value, addListener',
    ),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.all(20.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // 1. Title banner
        _buildTitleBanner(),
        SizedBox(height: 24.0),

        // 2. Lifecycle diagram
        _buildSectionTitle('1. Lifecycle: created → active → dispose → disposed'),
        SizedBox(height: 12.0),
        _buildLifecycleDiagram(lifecycleStages),
        SizedBox(height: 24.0),

        // 3. Anatomy of dispose()
        _buildSectionTitle('2. Anatomy of ChangeNotifier.dispose()'),
        SizedBox(height: 12.0),
        _buildAnatomyOfDispose(),
        SizedBox(height: 24.0),

        // 4. Why no ObjectDisposedException type
        _buildSectionTitle('3. Why Flutter has no ObjectDisposedException type'),
        SizedBox(height: 12.0),
        _buildDivergencePanel(),
        SizedBox(height: 24.0),

        // 5. Consumer patterns
        _buildSectionTitle('4. Common Consumer Patterns'),
        SizedBox(height: 12.0),
        _buildConsumerGrid(consumers),
        SizedBox(height: 24.0),

        // 6. Bad vs Good gallery
        _buildSectionTitle('5. Anti-pattern Gallery (BAD vs GOOD)'),
        SizedBox(height: 12.0),
        _buildAntiPatternGallery(antiPatterns),
        SizedBox(height: 24.0),

        // 7. Diagnostic stack trace mock-up
        _buildSectionTitle('6. Diagnostic Output Mock-up'),
        SizedBox(height: 12.0),
        _buildDiagnosticPanel(),
        SizedBox(height: 24.0),

        // 8. Cross-reference to memory-allocation events
        _buildSectionTitle('7. Cross-reference: Memory-Allocation Events'),
        SizedBox(height: 12.0),
        _buildCrossReferencePanel(),
        SizedBox(height: 24.0),

        // 9. Recap card
        _buildSectionTitle('8. Recap'),
        SizedBox(height: 12.0),
        _buildRecapCard(),
        SizedBox(height: 24.0),

        // 10. Footer / live sample inventory
        _buildInventoryFooter(
          sampleNotifier,
          sampleCounter,
          sampleLabel,
          sampleFocus,
          sampleScroll,
          sampleText,
        ),
        SizedBox(height: 24.0),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1: Title banner — moss-green to faded grey
// =============================================================================

Widget _buildTitleBanner() {
  return Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF6B8E23), // moss-green (alive)
          Color(0xFF556B2F), // dark olive
          Color(0xFF8A8A8A), // faded grey (disposed)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x556B8E23),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFFFFFF), Color(0xFFDFE7C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x55000000),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.delete_outline,
                size: 44.0,
                color: Color(0xFF6B8E23),
              ),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ObjectDisposedException',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/foundation.dart  ·  conceptual',
                    style: TextStyle(
                      color: Color(0xFFE8F0D8),
                      fontSize: 14.0,
                      fontFamily: 'monospace',
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
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0x66FFFFFF),
              width: 1.0,
            ),
          ),
          child: Text(
            'Flutter does NOT export an ObjectDisposedException class. '
            'It models the same idea with a debug-only assertion in '
            'ChangeNotifier and friends. Triggering it raises a FlutterError '
            '("A FooController was used after being disposed."). '
            'This deep demo walks the lifecycle, the contract, the divergence, '
            'and the common bugs.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _buildPill('lifecycle', Color(0xFFDFE7C0), Color(0xFF33691E)),
            _buildPill('contract', Color(0xFFFFE082), Color(0xFF5D4037)),
            _buildPill('debug-only', Color(0xFFA5D6A7), Color(0xFF1B5E20)),
            _buildPill('FlutterError', Color(0xFFFFAB91), Color(0xFFB71C1C)),
            _buildPill('framework', Color(0xFFB0BEC5), Color(0xFF263238)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPill(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildSectionTitle(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFE8F0D8), Color(0xFFFFFFFF)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: Color(0xFF6B8E23), width: 5.0),
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF33691E),
      ),
    ),
  );
}

// =============================================================================
// SECTION 2: Lifecycle diagram
// =============================================================================

Widget _buildLifecycleDiagram(List<_LifecycleStage> stages) {
  final List<Widget> stageWidgets = <Widget>[];
  for (int i = 0; i < stages.length; i++) {
    stageWidgets.add(_buildLifecycleStageCard(stages[i], i));
    if (i < stages.length - 1) {
      stageWidgets.add(SizedBox(height: 8.0));
      stageWidgets.add(_buildLifecycleConnector(stages[i], stages[i + 1]));
      stageWidgets.add(SizedBox(height: 8.0));
    }
  }
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFF7F9F1), Color(0xFFFFFFFF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFCDD9B5), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x226B8E23),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.timeline,
              size: 22.0,
              color: Color(0xFF33691E),
            ),
            SizedBox(width: 8.0),
            Text(
              'Stage timeline',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF33691E),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...stageWidgets,
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFFFE082), width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.info_outline,
                size: 18.0,
                color: Color(0xFFE65100),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'In release builds the assertion is stripped; the object is '
                  'silently broken instead of throwing. Always test in debug.',
                  style: TextStyle(
                    fontSize: 12.0,
                    height: 1.4,
                    color: Color(0xFF5D4037),
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

Widget _buildLifecycleStageCard(_LifecycleStage stage, int index) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: stage.tint,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: stage.color, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: stage.color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: stage.color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: stage.color.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Icon(stage.icon, color: Colors.white, size: 24.0),
        ),
        SizedBox(width: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: stage.color, width: 1.0),
          ),
          child: Text(
            '${index + 1}',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: stage.color,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                stage.label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: stage.color,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                stage.caption,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF424242),
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: stage.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  stage.flag,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: stage.color,
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

Widget _buildLifecycleConnector(_LifecycleStage from, _LifecycleStage to) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 22.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 2.0,
          height: 18.0,
          color: from.color.withValues(alpha: 0.6),
        ),
        SizedBox(width: 10.0),
        Icon(
          Icons.arrow_downward,
          size: 16.0,
          color: from.color.withValues(alpha: 0.7),
        ),
        SizedBox(width: 10.0),
        Container(
          width: 2.0,
          height: 18.0,
          color: to.color.withValues(alpha: 0.6),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3: Anatomy of ChangeNotifier.dispose()
// =============================================================================

Widget _buildAnatomyOfDispose() {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFFFFDE7), Color(0xFFFFF9C4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFFBC02D), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.architecture,
              color: Color(0xFFE65100),
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'How ChangeNotifier protects itself',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _anatomyRow(
          Icons.flag_outlined,
          '_debugDisposed',
          'bool',
          'Set to true at the end of dispose(). Read-only in release builds.',
          Color(0xFFD84315),
        ),
        SizedBox(height: 6.0),
        _anatomyRow(
          Icons.shield_outlined,
          '_debugAssertNotDisposed()',
          'bool',
          'Called from every public mutating method. Throws FlutterError when '
          '_debugDisposed is true. Returns true to satisfy assert(...).',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 6.0),
        _anatomyRow(
          Icons.cleaning_services_outlined,
          'dispose()',
          'void',
          'Override to release resources. Calls _debugAssertNotDisposed first '
          '(so double-dispose throws), then sets _debugDisposed = true.',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 6.0),
        _anatomyRow(
          Icons.notifications_off_outlined,
          'addListener / removeListener',
          'void',
          'Each call begins with _debugAssertNotDisposed(). Touching a '
          'disposed notifier therefore aborts in debug.',
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 6.0),
        _anatomyRow(
          Icons.broadcast_on_personal_outlined,
          'notifyListeners',
          'void',
          'Same protection. After dispose() this would call into a freed '
          'listener list, which is exactly the bug the assertion catches.',
          Color(0xFFAD1457),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '@protected\n'
            'bool _debugAssertNotDisposed() {\n'
            '  assert(() {\n'
            '    if (_debugDisposed) {\n'
            '      throw FlutterError(\n'
            "        'A \$runtimeType was used after being disposed.\\n'\n"
            "        'Once you have called dispose() on a \$runtimeType, '\n"
            "        'it can no longer be used.',\n"
            '      );\n'
            '    }\n'
            '    return true;\n'
            '  }());\n'
            '  return true;\n'
            '}',
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Color(0xFFCFD8DC),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(
  IconData icon,
  String name,
  String type,
  String description,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: color,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  height: 1.35,
                  color: Color(0xFF424242),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 4: Why Flutter has no ObjectDisposedException type
// =============================================================================

Widget _buildDivergencePanel() {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFEDE7F6), Color(0xFFF3E5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF7B1FA2), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.fork_right,
              color: Color(0xFF6A1B9A),
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'No typed ObjectDisposedException',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Other ecosystems expose a dedicated exception type:',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
            color: Color(0xFF311B92),
          ),
        ),
        SizedBox(height: 8.0),
        _ecosystemRow(
          '.NET',
          'System.ObjectDisposedException',
          'thrown by IDisposable.Dispose pattern',
          Color(0xFF512DA8),
        ),
        _ecosystemRow(
          'RxDart',
          'ObjectDisposedException',
          'thrown by close()d Subject usage',
          Color(0xFF1565C0),
        ),
        _ecosystemRow(
          'flame',
          'ComponentRemovedException',
          'lifecycle is component-removed, not generic',
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 12.0),
        Text(
          'Flutter chose a different approach:',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
            color: Color(0xFF311B92),
          ),
        ),
        SizedBox(height: 8.0),
        _flutterChoiceRow(
          Icons.bug_report_outlined,
          'Debug-only',
          'The check lives inside an assert(), so production builds eat the '
          'cost of zero extra branches.',
        ),
        _flutterChoiceRow(
          Icons.warning_amber_outlined,
          'FlutterError, not a typed exception',
          'You catch (FlutterError e) — the message is the protocol; the '
          'type carries no extra data.',
        ),
        _flutterChoiceRow(
          Icons.touch_app_outlined,
          'Per-API check',
          'Every public method that could observe the broken state opens with '
          '_debugAssertNotDisposed().',
        ),
        _flutterChoiceRow(
          Icons.workspaces_outlined,
          'Co-located with the contract',
          'Each disposable type owns its own variant: TextEditingController, '
          'FocusNode, AnimationController, etc.',
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFDE7),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFFBC02D), width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.lightbulb_outline,
                color: Color(0xFFE65100),
                size: 18.0,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'When you read existing tutorials that say "catch '
                  'ObjectDisposedException", they are talking about another '
                  'ecosystem. In Flutter the signal is a thrown FlutterError '
                  'whose message contains "was used after being disposed".',
                  style: TextStyle(
                    fontSize: 12.0,
                    height: 1.4,
                    color: Color(0xFF5D4037),
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

Widget _ecosystemRow(
  String tech,
  String type,
  String detail,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 6.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            tech,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                type,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF212121),
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFF616161),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flutterChoiceRow(IconData icon, String title, String body) {
  return Container(
    margin: EdgeInsets.only(bottom: 6.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFB39DDB), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: Color(0xFF512DA8), size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF311B92),
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
                  height: 1.4,
                  color: Color(0xFF424242),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5: Consumer patterns grid
// =============================================================================

Widget _buildConsumerGrid(List<_ConsumerPattern> consumers) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < consumers.length; i += 2) {
    final Widget left = _buildConsumerCard(consumers[i]);
    final Widget right = (i + 1) < consumers.length
        ? _buildConsumerCard(consumers[i + 1])
        : SizedBox.shrink();
    rows.add(
      Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: left),
            SizedBox(width: 10.0),
            Expanded(child: right),
          ],
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

Widget _buildConsumerCard(_ConsumerPattern p) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: p.tint,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: p.stroke, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: p.stroke,
                shape: BoxShape.circle,
              ),
              child: Icon(p.icon, color: Colors.white, size: 18.0),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                p.type,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: p.stroke,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          p.summary,
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF424242),
            height: 1.35,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: p.stroke.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Text(
            'owner: ${p.ownership}',
            style: TextStyle(
              fontSize: 10.5,
              fontFamily: 'monospace',
              color: Color(0xFF212121),
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: p.stroke.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'asserts on: ${p.assertOn}',
            style: TextStyle(
              fontSize: 10.5,
              fontFamily: 'monospace',
              color: p.stroke,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 6: Anti-pattern gallery (BAD vs GOOD)
// =============================================================================

Widget _buildAntiPatternGallery(List<_AntiPattern> patterns) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (final _AntiPattern p in patterns) ...<Widget>[
        _buildAntiPatternBlock(p),
        SizedBox(height: 14.0),
      ],
    ],
  );
}

Widget _buildAntiPatternBlock(_AntiPattern p) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: Color(0xFF607D8B),
                shape: BoxShape.circle,
              ),
              child: Icon(p.icon, color: Colors.white, size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                p.title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          p.explanation,
          style: TextStyle(
            fontSize: 12.0,
            height: 1.4,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _buildBadPanel(p.bad)),
            SizedBox(width: 10.0),
            Expanded(child: _buildGoodPanel(p.good)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBadPanel(String code) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC62828), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.cancel_outlined,
              size: 16.0,
              color: Color(0xFFC62828),
            ),
            SizedBox(width: 6.0),
            Text(
              'BAD',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC62828),
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: Color(0xFFFFCDD2),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildGoodPanel(String code) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF2E7D32), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.check_circle_outline,
              size: 16.0,
              color: Color(0xFF2E7D32),
            ),
            SizedBox(width: 6.0),
            Text(
              'GOOD',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: Color(0xFFC8E6C9),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7: Diagnostic stack-trace mock-up
// =============================================================================

Widget _buildDiagnosticPanel() {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF1B1B1B),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF455A64), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x88000000),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Color(0xFFEF5350),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Color(0xFFFFEE58),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Color(0xFF66BB6A),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              'flutter run -d chrome',
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: Color(0xFFB0BEC5),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFC62828), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '════════ Exception caught by widgets library ════════',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Color(0xFFEF9A9A),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'The following assertion was thrown building Builder:\n'
                'A TextEditingController was used after being disposed.\n'
                'Once you have called dispose() on a TextEditingController, '
                'it can no longer be used.\n',
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: Color(0xFFFFCDD2),
                  height: 1.45,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                "When the exception was thrown, this was the stack:\n"
                '#0   ChangeNotifier._debugAssertNotDisposed.<anonymous closure> (package:flutter/src/foundation/change_notifier.dart:117:9)\n'
                '#1   ChangeNotifier._debugAssertNotDisposed (package:flutter/src/foundation/change_notifier.dart:124:6)\n'
                '#2   ChangeNotifier.addListener (package:flutter/src/foundation/change_notifier.dart:266:12)\n'
                '#3   _MyFormState.build.<anonymous closure> (package:my_app/widgets/my_form.dart:48:18)\n'
                '#4   StatelessElement.build (package:flutter/src/widgets/framework.dart:5074:49)\n'
                '#5   ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5004:15)\n'
                '...',
                style: TextStyle(
                  fontSize: 10.5,
                  fontFamily: 'monospace',
                  color: Color(0xFFB0BEC5),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '════════════════════════════════════════════════════',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Color(0xFFEF9A9A),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF37474F),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF78909C), width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.info_outline,
                color: Color(0xFFB3E5FC),
                size: 18.0,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'How to read it: frame #2 is the public method that '
                  'detected the dead object. The actionable line is the '
                  'first frame from your own package — frame #3 in the '
                  'example. That is where ownership is wrong.',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                    color: Color(0xFFCFD8DC),
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
}

// =============================================================================
// SECTION 8: Cross-reference to ObjectCreated / ObjectDisposed events
// =============================================================================

Widget _buildCrossReferencePanel() {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFE0F7FA), Color(0xFFFFFFFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF00838F), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.link,
              color: Color(0xFF006064),
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Connection to FlutterMemoryAllocations',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'The lifecycle described above is observed by the framework using '
          'two ObjectEvent subclasses (see object_event_test.dart):',
          style: TextStyle(
            fontSize: 12.5,
            color: Color(0xFF263238),
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _buildEventStub(
                'ObjectCreated',
                Icons.add_circle_outline,
                Color(0xFF2E7D32),
                'Dispatched at the end of the constructor in instrumented '
                'classes; carries library + className + object reference.',
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildEventStub(
                'ObjectDisposed',
                Icons.do_not_disturb_on_outlined,
                Color(0xFF8A8A8A),
                'Dispatched from dispose(); carries object reference. '
                'After this event the assertion gate is closed.',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFBA68C8), width: 1.0),
          ),
          child: Text(
            'Use FlutterMemoryAllocations.instance.addListener to subscribe '
            'in dev tools. Pair it with a leak-tracker like leak_tracker '
            'to catch missing dispose() calls in tests — the absence of an '
            'ObjectDisposed event for a given ObjectCreated is the signal.',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF4A148C),
              height: 1.4,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildEventStub(
  String name,
  IconData icon,
  Color color,
  String body,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 11.5,
            color: Color(0xFF424242),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 9: Recap card
// =============================================================================

Widget _buildRecapCard() {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFE8F5E9), Color(0xFFE0F2F1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF2E7D32), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x332E7D32),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.task_alt,
              color: Color(0xFF1B5E20),
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Rules of thumb',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recapBullet(
          '1.',
          'Treat dispose() as the very last line. After it, the object is '
          'dead — no reads, no writes, no listeners.',
        ),
        _recapBullet(
          '2.',
          'Ownership lives in exactly one State. If two States share a '
          'controller, lift it to the parent.',
        ),
        _recapBullet(
          '3.',
          'Pair every addListener with removeListener BEFORE dispose().',
        ),
        _recapBullet(
          '4.',
          'There is no ObjectDisposedException type. Catch FlutterError and '
          'inspect the message string if you must.',
        ),
        _recapBullet(
          '5.',
          'Always test in debug. Release strips the assertion and may '
          'silently corrupt state instead of throwing.',
        ),
        _recapBullet(
          '6.',
          'Use FlutterMemoryAllocations + leak_tracker to detect missing '
          'dispose() calls automatically.',
        ),
      ],
    ),
  );
}

Widget _recapBullet(String marker, String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Color(0xFF1B5E20),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            marker,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10: Inventory footer — proves we created live objects without
// disposing them.
// =============================================================================

Widget _buildInventoryFooter(
  ChangeNotifier notifier,
  ValueNotifier<int> counter,
  ValueNotifier<String> label,
  FocusNode focus,
  ScrollController scroll,
  TextEditingController text,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.inventory_2_outlined,
              color: Color(0xFF455A64),
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Live (not disposed) sample inventory',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _inventoryRow(
          'ChangeNotifier',
          notifier.runtimeType.toString(),
          'hasListeners is gated by _debugAssertNotDisposed',
          Color(0xFF512DA8),
        ),
        _inventoryRow(
          'ValueNotifier<int>',
          counter.runtimeType.toString(),
          'value=${counter.value}; listener-protected',
          Color(0xFF00838F),
        ),
        _inventoryRow(
          'ValueNotifier<String>',
          label.runtimeType.toString(),
          'value="${label.value}"; same protection',
          Color(0xFF00838F),
        ),
        _inventoryRow(
          'FocusNode',
          focus.runtimeType.toString(),
          'debugLabel="${focus.debugLabel ?? '<none>'}"',
          Color(0xFF2E7D32),
        ),
        _inventoryRow(
          'ScrollController',
          scroll.runtimeType.toString(),
          'never attached → no positions to query',
          Color(0xFFE65100),
        ),
        _inventoryRow(
          'TextEditingController',
          text.runtimeType.toString(),
          'text="${text.text}"',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFDE7),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFFBC02D), width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.warning_amber_outlined,
                size: 18.0,
                color: Color(0xFFE65100),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Note: in a real app these objects would be owned by a '
                  'State and disposed in dispose(). This test script never '
                  'invokes dispose() — the SendTestRunner reads the widget '
                  'tree once, and runtime mutations would defeat the purpose '
                  'of a deterministic visual demo.',
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.4,
                    color: Color(0xFF5D4037),
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

Widget _inventoryRow(
  String label,
  String runtime,
  String detail,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 6.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                runtime,
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Color(0xFF212121),
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFF616161),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Plain data-bag classes used by the build above.
// =============================================================================

class _LifecycleStage {
  _LifecycleStage({
    required this.label,
    required this.caption,
    required this.icon,
    required this.color,
    required this.tint,
    required this.flag,
  });

  final String label;
  final String caption;
  final IconData icon;
  final Color color;
  final Color tint;
  final String flag;
}

class _AntiPattern {
  _AntiPattern({
    required this.title,
    required this.bad,
    required this.good,
    required this.explanation,
    required this.icon,
  });

  final String title;
  final String bad;
  final String good;
  final String explanation;
  final IconData icon;
}

class _ConsumerPattern {
  _ConsumerPattern({
    required this.type,
    required this.summary,
    required this.ownership,
    required this.icon,
    required this.tint,
    required this.stroke,
    required this.assertOn,
  });

  final String type;
  final String summary;
  final String ownership;
  final IconData icon;
  final Color tint;
  final Color stroke;
  final String assertOn;
}
