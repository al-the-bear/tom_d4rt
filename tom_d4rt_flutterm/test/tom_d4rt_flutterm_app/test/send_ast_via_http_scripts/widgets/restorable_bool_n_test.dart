import 'package:flutter/material.dart';

// Top-level restorable instance for demonstration (real instantiation)
final RestorableBoolN _restorable = RestorableBoolN(null);

// ValueNotifiers for the simulated save/restore cycle
final ValueNotifier<bool?> _currentValue = ValueNotifier<bool?>(null);
final ValueNotifier<bool?> _savedValue = ValueNotifier<bool?>(null);
final ValueNotifier<bool> _appKilled = ValueNotifier<bool>(false);

dynamic build(BuildContext context) {
  final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme,
    home: const _RestorableBoolNDemo(),
  );
}

class _RestorableBoolNDemo extends StatelessWidget {
  const _RestorableBoolNDemo();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RestorableBoolN Deep Demo'),
          backgroundColor: Colors.teal.shade700,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.teal,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: 'Overview'),
              Tab(text: 'Architecture'),
              Tab(text: 'Nullable vs Non'),
              Tab(text: 'Save/Restore'),
              Tab(text: 'Real Instance'),
              Tab(text: 'Use Cases'),
              Tab(text: 'Comparison'),
              Tab(text: 'Bucket API'),
              Tab(text: 'Pitfalls & API'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _OverviewTab(),
            _ArchitectureTab(),
            _NullableVsNonTab(),
            _SaveRestoreTab(),
            _RealInstanceTab(),
            _UseCasesTab(),
            _ComparisonTab(),
            _BucketApiTab(),
            _PitfallsAndApiTab(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 1 – Overview / Hero Banner
// ─────────────────────────────────────────────────────────────────────────────

class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _HeroBanner(
          icon: Icons.restore,
          title: 'RestorableBoolN',
          subtitle: 'Nullable restorable bool — survives process restarts',
          color: cs.primaryContainer,
          onColor: cs.onPrimaryContainer,
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'What is State Restoration?',
          child: const Text(
            'Flutter\'s state restoration framework allows an app to save its '
            'UI state before it is killed by the OS, and then restore that state '
            'when the user returns. On Android and iOS, apps in the background '
            'may be terminated at any time to reclaim memory. Without state '
            'restoration, the user would always see a blank app on return. With '
            'state restoration, the app re-appears exactly as the user left it.',
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'The RestorableProperty Family',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'RestorableProperty<T> is the abstract base for all restorable '
                'values. Flutter ships several concrete implementations:',
              ),
              const SizedBox(height: 8),
              _BulletItem('RestorableBool — non-nullable bool (true/false)'),
              _BulletItem('RestorableBoolN — nullable bool? (true/false/null)'),
              _BulletItem('RestorableInt / RestorableIntN'),
              _BulletItem('RestorableDouble / RestorableDoubleN'),
              _BulletItem('RestorableString / RestorableStringN'),
              _BulletItem('RestorableEnum / RestorableEnumN'),
              _BulletItem('RestorableTextEditingController'),
              _BulletItem('RestorableDateTime / RestorableDateTimeN'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Why RestorableBoolN (Nullable)?',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'The nullable variant is critical for three-state semantics '
                'where null means "not yet decided" or "unknown", which is '
                'distinct from both true and false:',
              ),
              const SizedBox(height: 8),
              _BulletItem('Consent dialogs: user hasn\'t answered yet (null), '
                  'accepted (true), or declined (false)'),
              _BulletItem('Permission state: not-requested (null), granted '
                  '(true), denied (false)'),
              _BulletItem('Feature toggles: loading/unknown (null), '
                  'enabled (true), disabled (false)'),
              _BulletItem('Dark mode preference: follow system (null), '
                  'always dark (true), always light (false)'),
              const SizedBox(height: 8),
              const Text(
                'If you collapsed null to false you would lose the ability to '
                'distinguish "the user explicitly said no" from "the user has '
                'not been asked yet". RestorableBoolN preserves all three states '
                'across process restarts.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Class Signature',
          child: _MonoBox(
            'class RestorableBoolN extends RestorableValue<bool?> {\n'
            '  RestorableBoolN(bool? defaultValue);\n'
            '\n'
            '  // Inherited from RestorableValue<bool?>:\n'
            '  bool? get value;\n'
            '  set value(bool? newValue);\n'
            '\n'
            '  // Inherited from RestorableProperty<bool?>:\n'
            '  bool get enabled;\n'
            '  void addListener(VoidCallback listener);\n'
            '  void removeListener(VoidCallback listener);\n'
            '}',
          ),
        ),
        const SizedBox(height: 12),
        _InfoChip(
          icon: Icons.lightbulb,
          text: 'RestorableBoolN is part of dart:ui / flutter/widgets.dart — '
              'no additional dependency needed.',
          color: Colors.teal.shade50,
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'How it fits into the framework',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'The lifecycle goes through RestorationManager, which is '
                'provided by the platform (WidgetsFlutterBinding). It serialises '
                'the restoration data as a byte buffer and hands it back on '
                'the next launch. Your State class opts in via RestorationMixin '
                'and registers each RestorableProperty with a stable string ID.',
              ),
              const SizedBox(height: 8),
              _MonoBox(
                'class _MyWidgetState extends State<MyWidget>\n'
                '    with RestorationMixin {\n'
                '  final RestorableBoolN _consent = RestorableBoolN(null);\n'
                '\n'
                '  @override\n'
                '  String get restorationId => \'my_widget\';\n'
                '\n'
                '  @override\n'
                '  void restoreState(\n'
                '    RestorationBucket? oldBucket,\n'
                '    bool initialRestore,\n'
                '  ) {\n'
                '    registerForRestoration(_consent, \'consent\');\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  void dispose() {\n'
                '    _consent.dispose();\n'
                '    super.dispose();\n'
                '  }\n'
                '}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 2 – Architecture Diagram (CustomPainter)
// ─────────────────────────────────────────────────────────────────────────────

class _ArchitectureTab extends StatelessWidget {
  const _ArchitectureTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionHeader('Restoration Framework Architecture'),
        const SizedBox(height: 8),
        const Text(
          'The diagram below shows the full journey of a RestorableBoolN value '
          'from your State class all the way through a process restart and back.',
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 480,
          child: CustomPaint(
            painter: _ArchitecturePainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Step-by-step walkthrough',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _NumberedStep(
                1,
                'RestorationManager',
                'Singleton provided by WidgetsFlutterBinding. Communicates '
                    'with the platform (Android Activity / iOS UIViewController) '
                    'to obtain or submit the restoration byte buffer.',
              ),
              const SizedBox(height: 8),
              _NumberedStep(
                2,
                'RestorationBucket',
                'A namespaced, tree-structured container. Each bucket has a '
                    'restoration ID and can hold key-value pairs or child buckets. '
                    'Your State\'s bucket is a child of the root bucket.',
              ),
              const SizedBox(height: 8),
              _NumberedStep(
                3,
                'RestorableProperty.registerForRestoration()',
                'Binds the property to the bucket under a string key. From '
                    'this moment the property can read its saved value (if any) '
                    'and write new values that will be included in the next save.',
              ),
              const SizedBox(height: 8),
              _NumberedStep(
                4,
                'Value encoded → byte buffer',
                'When the app is backgrounded the framework calls '
                    'performBinaries() on the RestorationManager, which serialises '
                    'the entire bucket tree into a Uint8List and hands it to '
                    'the platform.',
              ),
              const SizedBox(height: 8),
              _NumberedStep(
                5,
                'Process restart',
                'OS kills the process to reclaim memory. The platform holds '
                    'onto the byte buffer. On next launch the byte buffer is '
                    'provided to the engine via the restoration channel.',
              ),
              const SizedBox(height: 8),
              _NumberedStep(
                6,
                'Decoded → value restored',
                'RestorationManager decodes the buffer and rebuilds the bucket '
                    'tree. Your State\'s restoreState() is called again. '
                    'registerForRestoration() reads the previously saved bool? '
                    'value from the bucket and populates the property.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ArchitecturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()
      ..color = Colors.teal.shade100
      ..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..color = Colors.teal.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint arrowPaint = Paint()
      ..color = Colors.teal.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint killPaint = Paint()
      ..color = Colors.red.shade100
      ..style = PaintingStyle.fill;
    final Paint killBorderPaint = Paint()
      ..color = Colors.red.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const double boxW = 160;
    const double boxH = 44;
    const double vGap = 32;

    // Layout: two columns of 3 boxes on left side, process restart box in middle bottom
    // Row 0: RestorationManager
    // Row 1: RestorationBucket
    // Row 2: RestorableProperty (RestorableBoolN)
    // Row 3 (centre): → encode → [process restart] → decode →
    // Row 4: Value restored

    final double colX = (size.width - boxW) / 2;
    final double startY = 20;

    final List<String> labels = <String>[
      'RestorationManager',
      'RestorationBucket',
      'RestorableBoolN\n(registerForRestoration)',
      'Value encoded\n→ byte buffer',
    ];

    final List<Offset> positions = <Offset>[
      Offset(colX, startY),
      Offset(colX, startY + boxH + vGap),
      Offset(colX, startY + (boxH + vGap) * 2),
      Offset(colX, startY + (boxH + vGap) * 3),
    ];

    // Draw normal boxes
    for (int i = 0; i < labels.length; i++) {
      final Rect rect = Rect.fromLTWH(
          positions[i].dx, positions[i].dy, boxW, boxH);
      final RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(8));
      canvas.drawRRect(rRect, boxPaint);
      canvas.drawRRect(rRect, borderPaint);
      _drawLabel(canvas, labels[i], rect);
    }

    // Process restart box (red)
    final double killY = startY + (boxH + vGap) * 3 + boxH + vGap;
    final Rect killRect = Rect.fromLTWH(colX, killY, boxW, boxH);
    final RRect killRRect = RRect.fromRectAndRadius(killRect, const Radius.circular(8));
    canvas.drawRRect(killRRect, killPaint);
    canvas.drawRRect(killRRect, killBorderPaint);
    _drawLabelColor(canvas, 'Process Restart\n(OS kills app)', killRect, Colors.red.shade900);

    // Decoded / restored box
    final double restoreY = killY + boxH + vGap;
    final Rect restoreRect = Rect.fromLTWH(colX, restoreY, boxW, boxH);
    final RRect restoreRRect = RRect.fromRectAndRadius(restoreRect, const Radius.circular(8));
    canvas.drawRRect(restoreRRect, boxPaint);
    canvas.drawRRect(restoreRRect, borderPaint);
    _drawLabel(canvas, 'Value decoded\n→ state restored', restoreRect);

    // Draw downward arrows between boxes
    final List<Offset> arrowTops = <Offset>[
      Offset(colX + boxW / 2, startY + boxH),
      Offset(colX + boxW / 2, startY + boxH + vGap + boxH),
      Offset(colX + boxW / 2, startY + (boxH + vGap) * 2 + boxH),
      Offset(colX + boxW / 2, startY + (boxH + vGap) * 3 + boxH),
      Offset(colX + boxW / 2, killY + boxH),
    ];

    final List<Offset> arrowBottoms = <Offset>[
      Offset(colX + boxW / 2, startY + boxH + vGap),
      Offset(colX + boxW / 2, startY + (boxH + vGap) * 2),
      Offset(colX + boxW / 2, startY + (boxH + vGap) * 3),
      Offset(colX + boxW / 2, killY),
      Offset(colX + boxW / 2, restoreY),
    ];

    for (int i = 0; i < arrowTops.length; i++) {
      _drawArrow(canvas, arrowPaint, arrowTops[i], arrowBottoms[i]);
    }
  }

  void _drawLabel(Canvas canvas, String text, Rect rect) {
    _drawLabelColor(canvas, text, rect, Colors.teal.shade900);
  }

  void _drawLabelColor(Canvas canvas, String text, Rect rect, Color color) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: rect.width - 8);
    tp.paint(
      canvas,
      Offset(
        rect.left + (rect.width - tp.width) / 2,
        rect.top + (rect.height - tp.height) / 2,
      ),
    );
  }

  void _drawArrow(Canvas canvas, Paint paint, Offset from, Offset to) {
    canvas.drawLine(from, to, paint);
    // Arrowhead
    final Paint headPaint = Paint()
      ..color = Colors.teal.shade800
      ..style = PaintingStyle.fill;
    final Path head = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(to.dx - 6, to.dy - 10)
      ..lineTo(to.dx + 6, to.dy - 10)
      ..close();
    canvas.drawPath(head, headPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 3 – RestorableBoolN vs RestorableBool
// ─────────────────────────────────────────────────────────────────────────────

class _NullableVsNonTab extends StatelessWidget {
  const _NullableVsNonTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionHeader('RestorableBoolN vs RestorableBool'),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _CompareCard(
                title: 'RestorableBoolN',
                subtitle: 'bool? — nullable',
                color: Colors.teal.shade50,
                borderColor: Colors.teal.shade400,
                states: const <String>['true', 'false', 'null'],
                stateColors: <Color>[Colors.green, Colors.red, Colors.grey],
                points: const <String>[
                  'Three-state semantics',
                  'null = not-yet-decided',
                  'Consent dialogs',
                  'Permission tracking',
                  'Dark mode (system pref)',
                  'Constructor: RestorableBoolN(null)',
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _CompareCard(
                title: 'RestorableBool',
                subtitle: 'bool — non-nullable',
                color: Colors.orange.shade50,
                borderColor: Colors.orange.shade400,
                states: const <String>['true', 'false'],
                stateColors: <Color>[Colors.green, Colors.red],
                points: const <String>[
                  'Binary semantics only',
                  'Always true or false',
                  'Feature flags',
                  'Checkbox state',
                  'Panel expanded',
                  'Constructor: RestorableBool(false)',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'State Matrix',
          child: Table(
            border: TableBorder.all(color: cs.outlineVariant),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: cs.primaryContainer),
                children: <Widget>[
                  _TableHeader('Scenario'),
                  _TableHeader('BoolN'),
                  _TableHeader('Bool'),
                ],
              ),
              _tableRow('User accepted consent', 'true', 'true'),
              _tableRow('User declined consent', 'false', 'false'),
              _tableRow('User not yet asked', 'null', '⚠ false?'),
              _tableRow('Permission granted', 'true', 'true'),
              _tableRow('Permission denied', 'false', 'false'),
              _tableRow('Permission not requested', 'null', '⚠ false?'),
              _tableRow('Dark mode on', 'true', 'true'),
              _tableRow('Dark mode off', 'false', 'false'),
              _tableRow('Follow system theme', 'null', '⚠ impossible'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Code Comparison',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('RestorableBoolN — three states:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              _MonoBox(
                'final _consent = RestorableBoolN(null);\n'
                '\n'
                '// Reading:\n'
                'final bool? consent = _consent.value;\n'
                'if (consent == null) {\n'
                '  // Never asked\n'
                '} else if (consent) {\n'
                '  // Accepted\n'
                '} else {\n'
                '  // Declined\n'
                '}',
              ),
              const SizedBox(height: 12),
              const Text('RestorableBool — two states:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              _MonoBox(
                'final _expanded = RestorableBool(false);\n'
                '\n'
                '// Reading:\n'
                'final bool expanded = _expanded.value; // never null\n'
                'if (expanded) {\n'
                '  // Panel is open\n'
                '} else {\n'
                '  // Panel is closed\n'
                '}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _InfoChip(
          icon: Icons.warning_amber,
          text: 'Use RestorableBool when null is meaningless. Use '
              'RestorableBoolN when you need to distinguish "not set" '
              'from "explicitly false".',
          color: Colors.amber.shade50,
        ),
      ],
    );
  }

  TableRow _tableRow(String scenario, String boolN, String bool_) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(scenario, style: const TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(boolN,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: boolN == 'null'
                    ? Colors.grey.shade600
                    : boolN == 'true'
                        ? Colors.green.shade700
                        : Colors.red.shade700,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(bool_,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: bool_.startsWith('⚠')
                    ? Colors.orange.shade700
                    : bool_ == 'true'
                        ? Colors.green.shade700
                        : Colors.red.shade700,
              )),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 4 – Simulated Save / Restore Cycle
// ─────────────────────────────────────────────────────────────────────────────

class _SaveRestoreTab extends StatelessWidget {
  const _SaveRestoreTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionHeader('Simulated Save / Restore Cycle'),
        const SizedBox(height: 8),
        const Text(
          'In a real app RestorableBoolN is managed by the framework. Here we '
          'simulate the full lifecycle manually to make the mechanics visible.',
        ),
        const SizedBox(height: 16),
        const _CycleWidget(),
      ],
    );
  }
}

class _CycleWidget extends StatelessWidget {
  const _CycleWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Step 1 – Pick current value
        _SectionCard(
          title: 'Step 1 — Pick a value',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Choose the current RestorableBoolN value using the '
                'segmented button below.',
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<bool?>(
                valueListenable: _currentValue,
                builder: (BuildContext context, bool? val, Widget? _) {
                  return SegmentedButton<bool?>(
                    segments: const <ButtonSegment<bool?>>[
                      ButtonSegment<bool?>(
                        value: true,
                        label: Text('true'),
                        icon: Icon(Icons.check_circle_outline),
                      ),
                      ButtonSegment<bool?>(
                        value: false,
                        label: Text('false'),
                        icon: Icon(Icons.cancel_outlined),
                      ),
                      ButtonSegment<bool?>(
                        value: null,
                        label: Text('null'),
                        icon: Icon(Icons.help_outline),
                      ),
                    ],
                    selected: <bool?>{val},
                    onSelectionChanged: (Set<bool?> s) {
                      _currentValue.value = s.first;
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder<bool?>(
                valueListenable: _currentValue,
                builder: (BuildContext context, bool? val, Widget? _) {
                  return _ValueBadge(
                    label: 'Current value',
                    value: val,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Step 2 – Save state
        _SectionCard(
          title: 'Step 2 — Save state (app backgrounded)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Pressing "Save State" simulates the OS snapshotting the '
                'restoration data. The current value is serialised into the '
                '"restoration bucket".',
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<bool?>(
                valueListenable: _savedValue,
                builder: (BuildContext context, bool? saved, Widget? _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FilledButton.icon(
                        onPressed: () {
                          _savedValue.value = _currentValue.value;
                          _appKilled.value = false;
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Save State'),
                      ),
                      const SizedBox(height: 8),
                      _StorageRow(
                        label: 'Saved in bucket',
                        value: saved,
                        active: saved != null || _appKilled.value == false,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Step 3 – Kill app
        _SectionCard(
          title: 'Step 3 — Kill app (OS reclaims memory)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'The OS kills the process. The current in-memory value is gone. '
                'The restoration bucket data is preserved by the platform.',
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<bool>(
                valueListenable: _appKilled,
                builder: (BuildContext context, bool killed, Widget? _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                        ),
                        onPressed: () {
                          _currentValue.value = null;
                          _appKilled.value = true;
                        },
                        icon: const Icon(Icons.power_off),
                        label: const Text('Kill App'),
                      ),
                      const SizedBox(height: 8),
                      if (killed)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade300),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.warning,
                                  color: Colors.red.shade700, size: 18),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  'App killed. In-memory value is null. '
                                  'Restoration bucket still holds saved data.',
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Step 4 – Restore
        _SectionCard(
          title: 'Step 4 — Restore state (app relaunch)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'On next launch, the framework reads the restoration bucket '
                'and calls restoreState(). The RestorableBoolN is populated '
                'from the saved data.',
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<bool?>(
                valueListenable: _savedValue,
                builder: (BuildContext context, bool? saved, Widget? _) {
                  return ValueListenableBuilder<bool?>(
                    valueListenable: _currentValue,
                    builder: (BuildContext context, bool? current, Widget? _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.green.shade700,
                            ),
                            onPressed: saved != null
                                ? () {
                                    _currentValue.value = saved;
                                    _appKilled.value = false;
                                  }
                                : null,
                            icon: const Icon(Icons.restore),
                            label: const Text('Restore'),
                          ),
                          const SizedBox(height: 8),
                          _ValueBadge(
                            label: 'Restored value',
                            value: current,
                          ),
                          if (saved == null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Nothing saved yet — save a value first.',
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 12),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Visual cycle diagram
        _SectionCard(
          title: 'Visual Cycle',
          child: Column(
            children: <Widget>[
              const SizedBox(height: 8),
              _CycleRow(
                steps: const <String>[
                  'State\nrunning',
                  'Save\nstate',
                  'Process\nkilled',
                  'Platform\nholds data',
                  'App\nrestarts',
                  'State\nrestored',
                ],
                icons: const <IconData>[
                  Icons.play_arrow,
                  Icons.save,
                  Icons.power_off,
                  Icons.storage,
                  Icons.refresh,
                  Icons.check_circle,
                ],
                colors: <Color>[
                  Colors.teal,
                  Colors.blue,
                  Colors.red,
                  Colors.orange,
                  Colors.purple,
                  Colors.green,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 5 – Real Instance
// ─────────────────────────────────────────────────────────────────────────────

class _RealInstanceTab extends StatelessWidget {
  const _RealInstanceTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionHeader('Real RestorableBoolN Instantiation'),
        const SizedBox(height: 8),
        const Text(
          'The following code shows a real RestorableBoolN instance created '
          'at the top level of this file. This is a live object — not a mock.',
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Live instance info',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _InfoRow(
                label: 'Type',
                value: _restorable.runtimeType.toString(),
              ),
              const SizedBox(height: 6),
              _InfoRow(
                label: 'Current value',
                value: _restorable.value?.toString() ?? 'null',
              ),
              const SizedBox(height: 6),
              _InfoRow(
                label: 'Enabled',
                value: _restorable.enabled.toString(),
              ),
              const SizedBox(height: 6),
              const Text(
                'Note: enabled is false because this instance is not registered '
                'with a RestorationBucket. Registration requires a State with '
                'RestorationMixin, which is outside a stateless sandbox.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Construction',
          child: _MonoBox(
            '// At top level (outside any widget):\n'
            'final RestorableBoolN _restorable = RestorableBoolN(null);\n'
            '\n'
            '// With a non-null default:\n'
            'final RestorableBoolN _featureEnabled = RestorableBoolN(false);\n'
            '\n'
            '// The defaultValue is used when no restoration data is present:\n'
            'final RestorableBoolN _consent = RestorableBoolN(null);\n'
            '// → value is null until saved & restored or explicitly set',
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Full Registration Pattern',
          child: _MonoBox(
            'class _ConsentScreenState extends State<ConsentScreen>\n'
            '    with RestorationMixin {\n'
            '\n'
            '  // 1. Declare the property\n'
            '  final RestorableBoolN _consent = RestorableBoolN(null);\n'
            '\n'
            '  // 2. Provide a unique restoration ID for this State\n'
            '  @override\n'
            '  String get restorationId => \'consent_screen\';\n'
            '\n'
            '  // 3. Register all properties\n'
            '  @override\n'
            '  void restoreState(\n'
            '    RestorationBucket? oldBucket,\n'
            '    bool initialRestore,\n'
            '  ) {\n'
            '    registerForRestoration(_consent, \'consent_value\');\n'
            '  }\n'
            '\n'
            '  // 4. Use the value\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    return Text(\n'
            '      \'Consent: \${_consent.value ?? "not answered"}\',\n'
            '    );\n'
            '  }\n'
            '\n'
            '  // 5. Dispose\n'
            '  @override\n'
            '  void dispose() {\n'
            '    _consent.dispose();\n'
            '    super.dispose();\n'
            '  }\n'
            '}',
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Setting values',
          child: _MonoBox(
            '// Inside State — after registration:\n'
            '_consent.value = true;   // user accepted\n'
            '_consent.value = false;  // user declined\n'
            '_consent.value = null;   // reset to "not answered"\n'
            '\n'
            '// The framework automatically persists any assignment.\n'
            '// No manual save needed — the bucket is updated immediately.',
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Listening for changes',
          child: _MonoBox(
            '// RestorableProperty extends ChangeNotifier:\n'
            '_consent.addListener(() {\n'
            '  final bool? val = _consent.value;\n'
            '  // val is true, false, or null\n'
            '  setState(() {});\n'
            '});\n'
            '\n'
            '// Or use it directly in build — read from .value',
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.verified, color: cs.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'The instance at the top of this file is a real '
                  'RestorableBoolN(null) object. Its runtimeType is shown above. '
                  'The value field reflects the default (null) since it is '
                  'unregistered in this demo context.',
                  style: TextStyle(color: cs.onPrimaryContainer),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 6 – Common Use Cases
// ─────────────────────────────────────────────────────────────────────────────

class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionHeader('Common Use Cases'),
        const SizedBox(height: 8),
        const Text(
          'These six mini-cards show realistic scenarios where RestorableBoolN '
          'is the right choice because null carries distinct meaning.',
        ),
        const SizedBox(height: 16),
        _UseCaseCard(
          icon: Icons.privacy_tip,
          title: 'Consent Dialog',
          color: Colors.purple.shade50,
          borderColor: Colors.purple.shade300,
          states: <_StateRow>[
            _StateRow('null', 'User has not been shown the dialog yet'),
            _StateRow('true', 'User accepted the privacy policy'),
            _StateRow('false', 'User declined — limited functionality'),
          ],
          codeSnippet:
              'final _privacyConsent = RestorableBoolN(null);\n'
              '\n'
              'Widget buildDialog() {\n'
              '  if (_privacyConsent.value == null) {\n'
              '    return ConsentDialog();\n'
              '  }\n'
              '  if (_privacyConsent.value!) {\n'
              '    return FullApp();\n'
              '  }\n'
              '  return LimitedApp();\n'
              '}',
        ),
        const SizedBox(height: 12),
        _UseCaseCard(
          icon: Icons.toggle_on,
          title: 'Feature Toggle (with loading state)',
          color: Colors.blue.shade50,
          borderColor: Colors.blue.shade300,
          states: <_StateRow>[
            _StateRow('null', 'Feature config still loading from server'),
            _StateRow('true', 'Feature enabled for this user'),
            _StateRow('false', 'Feature disabled for this user'),
          ],
          codeSnippet:
              'final _featureEnabled = RestorableBoolN(null);\n'
              '\n'
              '// After fetching remote config:\n'
              '_featureEnabled.value = remoteConfig.featureX;\n'
              '\n'
              '// In build:\n'
              'if (_featureEnabled.value == null) {\n'
              '  return const CircularProgressIndicator();\n'
              '}',
        ),
        const SizedBox(height: 12),
        _UseCaseCard(
          icon: Icons.dark_mode,
          title: 'Dark Mode Preference',
          color: Colors.indigo.shade50,
          borderColor: Colors.indigo.shade300,
          states: <_StateRow>[
            _StateRow('null', 'Follow system theme (default)'),
            _StateRow('true', 'Always dark'),
            _StateRow('false', 'Always light'),
          ],
          codeSnippet:
              'final _darkMode = RestorableBoolN(null);\n'
              '\n'
              'ThemeMode get themeMode {\n'
              '  final bool? pref = _darkMode.value;\n'
              '  if (pref == null) return ThemeMode.system;\n'
              '  return pref ? ThemeMode.dark : ThemeMode.light;\n'
              '}',
        ),
        const SizedBox(height: 12),
        _UseCaseCard(
          icon: Icons.notifications,
          title: 'Notification Permission',
          color: Colors.amber.shade50,
          borderColor: Colors.amber.shade300,
          states: <_StateRow>[
            _StateRow('null', 'Permission not yet requested'),
            _StateRow('true', 'Permission granted'),
            _StateRow('false', 'Permission denied (show rationale)'),
          ],
          codeSnippet:
              'final _notifPerm = RestorableBoolN(null);\n'
              '\n'
              'Future<void> requestPermission() async {\n'
              '  final granted = await requestNotifications();\n'
              '  _notifPerm.value = granted;\n'
              '}\n'
              '\n'
              '// Never show rationale until asked:\n'
              'if (_notifPerm.value == null) return;\n'
              'if (!_notifPerm.value!) showRationale();',
        ),
        const SizedBox(height: 12),
        _UseCaseCard(
          icon: Icons.sync,
          title: 'Sync / Backup Status',
          color: Colors.green.shade50,
          borderColor: Colors.green.shade300,
          states: <_StateRow>[
            _StateRow('null', 'Never synced — awaiting first sync'),
            _StateRow('true', 'Last sync succeeded'),
            _StateRow('false', 'Last sync failed'),
          ],
          codeSnippet:
              'final _lastSyncSuccess = RestorableBoolN(null);\n'
              '\n'
              '// In build:\n'
              'final bool? sync = _lastSyncSuccess.value;\n'
              'final icon = sync == null\n'
              '    ? Icons.cloud_off\n'
              '    : sync\n'
              '        ? Icons.cloud_done\n'
              '        : Icons.cloud_off;',
        ),
        const SizedBox(height: 12),
        _UseCaseCard(
          icon: Icons.person,
          title: 'Onboarding Completion',
          color: Colors.teal.shade50,
          borderColor: Colors.teal.shade300,
          states: <_StateRow>[
            _StateRow('null', 'Onboarding not started'),
            _StateRow('true', 'Onboarding completed'),
            _StateRow('false', 'Onboarding skipped by user'),
          ],
          codeSnippet:
              'final _onboarded = RestorableBoolN(null);\n'
              '\n'
              'Widget get firstScreen {\n'
              '  switch (_onboarded.value) {\n'
              '    case null:  return OnboardingScreen();\n'
              '    case true:  return HomeScreen();\n'
              '    case false: return QuickSetupScreen();\n'
              '  }\n'
              '}',
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 7 – Comparison Table
// ─────────────────────────────────────────────────────────────────────────────

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionHeader('Comparison: Restorable Types'),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            border: TableBorder.all(color: cs.outlineVariant),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: cs.primaryContainer),
                children: <Widget>[
                  _TableHeader('Type'),
                  _TableHeader('Nullable'),
                  _TableHeader('States'),
                  _TableHeader('Survives restart'),
                  _TableHeader('ChangeNotifier'),
                  _TableHeader('Best for'),
                ],
              ),
              _compRow('RestorableBoolN', 'Yes', 'true/false/null', 'Yes', 'Yes', 'Tri-state flags'),
              _compRow('RestorableBool', 'No', 'true/false', 'Yes', 'Yes', 'Binary flags'),
              _compRow('RestorableString', 'No', 'any string', 'Yes', 'Yes', 'Text values'),
              _compRow('RestorableStringN', 'Yes', 'string/null', 'Yes', 'Yes', 'Optional text'),
              _compRow('RestorableInt', 'No', 'integer', 'Yes', 'Yes', 'Counters/indices'),
              _compRow('RestorableIntN', 'Yes', 'integer/null', 'Yes', 'Yes', 'Optional counts'),
              _compRow('RestorableDouble', 'No', 'double', 'Yes', 'Yes', 'Numeric values'),
              _compRow('ValueNotifier<bool?>', 'Yes', 'true/false/null', 'No', 'Yes', 'In-memory only'),
              _compRow('SharedPreferences', 'Manual', 'any', 'Yes', 'No', 'Persistent settings'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'When to choose RestorableBoolN over ValueNotifier<bool?>',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem('Your app supports state restoration (restorationScopeId set on MaterialApp)'),
              _BulletItem('The value must survive a process kill during backgrounding'),
              _BulletItem('You are already using RestorationMixin in the State class'),
              _BulletItem('You need the value to be part of the framework\'s serialisation tree'),
              const SizedBox(height: 8),
              const Text(
                'If none of these apply, ValueNotifier<bool?> is simpler and '
                'has zero framework overhead.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'When to choose RestorableBoolN over SharedPreferences',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem('State is ephemeral UI state, not long-term user settings'),
              _BulletItem('You want framework-managed save/restore with no extra code'),
              _BulletItem('You need change notification (ChangeNotifier is built in)'),
              _BulletItem('You are already using RestorationMixin'),
              const SizedBox(height: 8),
              const Text(
                'For settings that persist across full uninstall/reinstall or '
                'across multiple sessions intentionally, SharedPreferences or '
                'a database is more appropriate.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Serialisation format',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'RestorableBoolN serialises the bool? value as follows inside '
                'the restoration bucket:',
              ),
              const SizedBox(height: 8),
              _MonoBox(
                '// Internal encoding (simplified):\n'
                '// null  → stored as -1 (or absent key)\n'
                '// false → stored as  0\n'
                '// true  → stored as  1\n'
                '\n'
                '// The bucket stores the value under your registration key:\n'
                'bucket.write<int>(\'consent\', encodedValue);\n'
                '\n'
                '// On restore:\n'
                'final int? raw = bucket.read<int>(\'consent\');\n'
                'value = raw == null ? null : raw == 1;',
              ),
            ],
          ),
        ),
      ],
    );
  }

  TableRow _compRow(
    String type,
    String nullable,
    String states,
    String survives,
    String notifier,
    String best,
  ) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(type,
              style: const TextStyle(
                  fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(nullable,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  color: nullable == 'Yes' ? Colors.green.shade700 : Colors.grey.shade600)),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(states, style: const TextStyle(fontSize: 11)),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(survives,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  color: survives == 'Yes' ? Colors.green.shade700 : Colors.red.shade700)),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(notifier,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  color: notifier == 'Yes' ? Colors.green.shade700 : Colors.orange.shade700)),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(best, style: const TextStyle(fontSize: 11)),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 8 – RestorationBucket API
// ─────────────────────────────────────────────────────────────────────────────

class _BucketApiTab extends StatelessWidget {
  const _BucketApiTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionHeader('RestorationBucket API'),
        const SizedBox(height: 8),
        const Text(
          'RestorationBucket is the storage container that RestorableBoolN '
          'reads from and writes to. Understanding the bucket API helps when '
          'implementing custom RestorableProperty subclasses.',
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Core API',
          child: _MonoBox(
            'class RestorationBucket {\n'
            '  // Read a value from the bucket\n'
            '  T? read<T>(String key);\n'
            '\n'
            '  // Write a value to the bucket\n'
            '  void write<T>(String key, T value);\n'
            '\n'
            '  // Remove a key from the bucket\n'
            '  void remove<T>(String key);\n'
            '\n'
            '  // Check whether a key exists\n'
            '  bool contains(String key);\n'
            '\n'
            '  // Create or claim a child bucket\n'
            '  RestorationBucket claimChild(\n'
            '    String restorationId,\n'
            '    {@required debugOwner},\n'
            '  );\n'
            '\n'
            '  // The unique ID of this bucket\n'
            '  String get restorationId;\n'
            '\n'
            '  // Whether the bucket is currently enabled\n'
            '  bool get isReplacing;\n'
            '}',
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Reading and writing bool?',
          child: _MonoBox(
            '// Writing a nullable bool:\n'
            'void writeBoolN(RestorationBucket bucket, String key, bool? v) {\n'
            '  if (v == null) {\n'
            '    bucket.remove<int>(key);\n'
            '  } else {\n'
            '    bucket.write<int>(key, v ? 1 : 0);\n'
            '  }\n'
            '}\n'
            '\n'
            '// Reading back:\n'
            'bool? readBoolN(RestorationBucket bucket, String key) {\n'
            '  final int? raw = bucket.read<int>(key);\n'
            '  if (raw == null) return null;\n'
            '  return raw != 0;\n'
            '}',
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Supported value types',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'RestorationBucket can store any value that can be encoded '
                'in the StandardMessageCodec. The supported primitive types are:',
              ),
              const SizedBox(height: 8),
              _MonoBox(
                '// Supported primitives:\n'
                'bucket.write<int>(\'key\', 42);\n'
                'bucket.write<double>(\'key\', 3.14);\n'
                'bucket.write<bool>(\'key\', true);\n'
                'bucket.write<String>(\'key\', \'hello\');\n'
                'bucket.write<Uint8List>(\'key\', bytes);\n'
                'bucket.write<List<Object?>>(\'key\', list);\n'
                'bucket.write<Map<String, Object?>>(\'key\', map);\n'
                '\n'
                '// Not supported (must encode manually):\n'
                '// DateTime, Color, Enum, custom objects',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Child buckets',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Buckets are organised as a tree. Each State with '
                'RestorationMixin claims a child bucket from its parent. '
                'This avoids key collisions between different widgets.',
              ),
              const SizedBox(height: 8),
              _MonoBox(
                '// Bucket tree example:\n'
                '// root\n'
                '//   └─ "my_app"            (MaterialApp)\n'
                '//        └─ "consent_screen" (ConsentScreen)\n'
                '//             ├─ "consent_value"  (RestorableBoolN)\n'
                '//             └─ "scroll_offset"  (RestorableDouble)\n'
                '\n'
                '// Each string must be unique within its parent bucket.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Custom RestorableProperty example',
          child: _MonoBox(
            '// How RestorableBoolN is implemented internally:\n'
            'class RestorableBoolN extends RestorableValue<bool?> {\n'
            '  RestorableBoolN(bool? defaultValue)\n'
            '      : _defaultValue = defaultValue;\n'
            '\n'
            '  final bool? _defaultValue;\n'
            '\n'
            '  @override\n'
            '  bool? createDefaultValue() => _defaultValue;\n'
            '\n'
            '  @override\n'
            '  bool? fromPrimitives(Object? data) {\n'
            '    if (data == null) return null;\n'
            '    return (data as int) != 0;\n'
            '  }\n'
            '\n'
            '  @override\n'
            '  Object toPrimitives() {\n'
            '    final bool? v = value;\n'
            '    if (v == null) throw StateError(\'null cannot be serialised\');\n'
            '    return v ? 1 : 0;\n'
            '  }\n'
            '}',
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 9 – Pitfalls & API Cheat Sheet
// ─────────────────────────────────────────────────────────────────────────────

class _PitfallsAndApiTab extends StatelessWidget {
  const _PitfallsAndApiTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionHeader('Common Pitfalls'),
        const SizedBox(height: 8),
        _PitfallCard(
          number: 1,
          title: 'Forgetting to register',
          description:
              'Declaring a RestorableBoolN field and never calling '
              'registerForRestoration() means the value will never be saved '
              'or restored. The property remains in an unregistered state '
              'and enabled returns false.',
          wrong:
              'class _MyState extends State<MyWidget>\n'
              '    with RestorationMixin {\n'
              '  final _flag = RestorableBoolN(null);\n'
              '\n'
              '  @override\n'
              '  String get restorationId => \'my_widget\';\n'
              '\n'
              '  @override\n'
              '  void restoreState(RestorationBucket? o, bool i) {\n'
              '    // BUG: forgot to register _flag!\n'
              '  }\n'
              '}',
          correct:
              '  @override\n'
              '  void restoreState(RestorationBucket? o, bool i) {\n'
              '    registerForRestoration(_flag, \'flag\'); // ✓\n'
              '  }',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          number: 2,
          title: 'Using after dispose',
          description:
              'Calling .value or .addListener on a RestorableBoolN after '
              'dispose() has been called causes a "used after dispose" assertion '
              'error in debug mode. Always dispose in the correct order.',
          wrong:
              '  @override\n'
              '  void dispose() {\n'
              '    super.dispose(); // BUG: super first\n'
              '    _flag.dispose(); // _flag may already be invalid\n'
              '  }',
          correct:
              '  @override\n'
              '  void dispose() {\n'
              '    _flag.dispose(); // ✓ dispose property first\n'
              '    super.dispose();\n'
              '  }',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          number: 3,
          title: 'Restoration ID collisions',
          description:
              'If two sibling State objects (or two properties in the same State) '
              'use the same restoration ID / registration key, one will overwrite '
              'the other\'s data silently. IDs must be unique within their scope.',
          wrong:
              '// Two screens both use "my_screen" — collision!\n'
              'class _Screen1State ... {\n'
              '  String get restorationId => \'my_screen\'; // BUG\n'
              '}\n'
              'class _Screen2State ... {\n'
              '  String get restorationId => \'my_screen\'; // BUG\n'
              '}',
          correct:
              'class _Screen1State ... {\n'
              '  String get restorationId => \'screen_1\'; // ✓\n'
              '}\n'
              'class _Screen2State ... {\n'
              '  String get restorationId => \'screen_2\'; // ✓\n'
              '}',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          number: 4,
          title: 'Not enabling restoration in MaterialApp',
          description:
              'State restoration is opt-in. If restorationScopeId is not set '
              'on MaterialApp (or CupertinoApp), the RestorationManager will '
              'not provide a bucket and restoreState() will receive a null bucket.',
          wrong:
              'MaterialApp(\n'
              '  // BUG: no restorationScopeId\n'
              '  home: MyScreen(),\n'
              ')',
          correct:
              'MaterialApp(\n'
              '  restorationScopeId: \'my_app\', // ✓\n'
              '  home: MyScreen(),\n'
              ')',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          number: 5,
          title: 'Setting value before registration',
          description:
              'Assigning to .value before calling registerForRestoration() '
              'will throw an assertion error. The property is not backed by '
              'a bucket until it is registered.',
          wrong:
              '  @override\n'
              '  void initState() {\n'
              '    super.initState();\n'
              '    _flag.value = true; // BUG: not yet registered\n'
              '  }',
          correct:
              '  @override\n'
              '  void restoreState(RestorationBucket? o, bool i) {\n'
              '    registerForRestoration(_flag, \'flag\');\n'
              '    if (!i) _flag.value = true; // ✓ after registration\n'
              '  }',
        ),
        const SizedBox(height: 20),
        _SectionHeader('API Cheat Sheet'),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'RestorableBoolN',
          child: _MonoBox(
            'RestorableBoolN(bool? defaultValue)\n'
            '\n'
            '// Properties:\n'
            'bool? get value\n'
            'set value(bool? newValue)\n'
            'bool get enabled\n'
            '\n'
            '// Inherited (ChangeNotifier):\n'
            'void addListener(VoidCallback listener)\n'
            'void removeListener(VoidCallback listener)\n'
            'void dispose()\n'
            '\n'
            '// Framework lifecycle (called by RestorationMixin):\n'
            'void initWithValue(bool? value)\n'
            'Object? toPrimitives()\n'
            'bool? fromPrimitives(Object? data)',
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'RestorableBool',
          child: _MonoBox(
            'RestorableBool(bool defaultValue)  // non-nullable\n'
            '\n'
            '// Properties:\n'
            'bool get value\n'
            'set value(bool newValue)           // never null\n'
            'bool get enabled\n'
            '\n'
            '// Same ChangeNotifier interface as RestorableBoolN',
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'RestorationMixin (on State)',
          child: _MonoBox(
            'mixin RestorationMixin<S extends StatefulWidget> on State<S> {\n'
            '  // Must override:\n'
            '  String? get restorationId;\n'
            '  void restoreState(RestorationBucket? oldBucket, bool init);\n'
            '\n'
            '  // Use inside restoreState():\n'
            '  void registerForRestoration(\n'
            '    RestorableProperty<Object?> property,\n'
            '    String restorationId,\n'
            '  );\n'
            '\n'
            '  // Available after restoreState():\n'
            '  RestorationBucket? get bucket;\n'
            '}',
          ),
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Quick reference: nullable variants',
          child: Column(
            children: <Widget>[
              _QuickRefRow('RestorableBoolN(bool? d)', 'nullable bool'),
              _QuickRefRow('RestorableIntN(int? d)', 'nullable int'),
              _QuickRefRow('RestorableDoubleN(double? d)', 'nullable double'),
              _QuickRefRow('RestorableStringN(String? d)', 'nullable String'),
              _QuickRefRow('RestorableEnumN<T>(T? d, values)', 'nullable Enum'),
              _QuickRefRow('RestorableDateTimeN(DateTime? d)', 'nullable DateTime'),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared Widgets
// ─────────────────────────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 52, color: onColor),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: onColor,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: onColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _MonoBox extends StatelessWidget {
  const _MonoBox(this.code);

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: Color(0xFFD4F1C4),
          height: 1.5,
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18, color: Colors.teal.shade700),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

class _NumberedStep extends StatelessWidget {
  const _NumberedStep(this.number, this.title, this.description);

  final int number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.teal.shade700,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$number',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 2),
              Text(description, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.borderColor,
    required this.states,
    required this.stateColors,
    required this.points,
  });

  final String title;
  final String subtitle;
  final Color color;
  final Color borderColor;
  final List<String> states;
  final List<Color> stateColors;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'monospace')),
          Text(subtitle,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade700)),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              for (int i = 0; i < states.length; i++) ...<Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: stateColors[i].withAlpha(30),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: stateColors[i]),
                  ),
                  child: Text(
                    states[i],
                    style: TextStyle(
                        fontSize: 11,
                        color: stateColors[i],
                        fontFamily: 'monospace'),
                  ),
                ),
                if (i < states.length - 1) const SizedBox(width: 4),
              ],
            ],
          ),
          const SizedBox(height: 8),
          for (final String p in points)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('• ', style: TextStyle(fontSize: 11)),
                  Expanded(
                      child: Text(p, style: const TextStyle(fontSize: 11))),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}

class _ValueBadge extends StatelessWidget {
  const _ValueBadge({required this.label, required this.value});

  final String label;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    final Color bg = value == null
        ? Colors.grey.shade200
        : value!
            ? Colors.green.shade100
            : Colors.red.shade100;
    final Color fg = value == null
        ? Colors.grey.shade700
        : value!
            ? Colors.green.shade800
            : Colors.red.shade800;
    final String display = value == null ? 'null' : value.toString();
    return Row(
      children: <Widget>[
        Text('$label: ', style: const TextStyle(fontSize: 12)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            display,
            style: TextStyle(
              color: fg,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _StorageRow extends StatelessWidget {
  const _StorageRow({
    required this.label,
    required this.value,
    required this.active,
  });

  final String label;
  final bool? value;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          active ? Icons.storage : Icons.storage_outlined,
          size: 18,
          color: Colors.teal.shade600,
        ),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontSize: 12)),
        Text(
          value == null ? 'null' : value.toString(),
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: value == null
                ? Colors.grey.shade600
                : value!
                    ? Colors.green.shade700
                    : Colors.red.shade700,
          ),
        ),
      ],
    );
  }
}

class _CycleRow extends StatelessWidget {
  const _CycleRow({
    required this.steps,
    required this.icons,
    required this.colors,
  });

  final List<String> steps;
  final List<IconData> icons;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          for (int i = 0; i < steps.length; i++) ...<Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: colors[i].withAlpha(30),
                    shape: BoxShape.circle,
                    border: Border.all(color: colors[i], width: 2),
                  ),
                  child: Icon(icons[i], color: colors[i], size: 22),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 64,
                  child: Text(
                    steps[i],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
            if (i < steps.length - 1)
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
              ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.borderColor,
    required this.states,
    required this.codeSnippet,
  });

  final IconData icon;
  final String title;
  final Color color;
  final Color borderColor;
  final List<_StateRow> states;
  final String codeSnippet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 20, color: borderColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final _StateRow s in states) ...<Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: s.value == 'null'
                        ? Colors.grey.shade300
                        : s.value == 'true'
                            ? Colors.green.shade200
                            : Colors.red.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    s.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 11, fontFamily: 'monospace'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(s.description,
                        style: const TextStyle(fontSize: 12))),
              ],
            ),
            const SizedBox(height: 4),
          ],
          const SizedBox(height: 8),
          _MonoBox(codeSnippet),
        ],
      ),
    );
  }
}

class _StateRow {
  const _StateRow(this.value, this.description);

  final String value;
  final String description;
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.description,
    required this.wrong,
    required this.correct,
  });

  final int number;
  final String title;
  final String description;
  final String wrong;
  final String correct;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 10),
          const Text('Wrong:',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
          const SizedBox(height: 4),
          _MonoBox(wrong),
          const SizedBox(height: 8),
          const Text('Correct:',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
          const SizedBox(height: 4),
          _MonoBox(correct),
        ],
      ),
    );
  }
}

class _QuickRefRow extends StatelessWidget {
  const _QuickRefRow(this.signature, this.description);

  final String signature;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              signature,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              description,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
