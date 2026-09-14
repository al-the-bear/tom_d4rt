// D4rt deep demo: LiveTextInputStatus — Apple's Live Text camera-OCR
// integration for Flutter text fields (iOS 15+ / macOS 12+). This file is an
// educational architectural simulation because the real platform feature cannot
// render inside the d4rt sandbox.
import 'package:flutter/material.dart';

// ─── Top-level ValueNotifiers (stateless d4rt demo) ──────────────────────────
final ValueNotifier<bool> _liveTextEnabled = ValueNotifier<bool>(true);
final ValueNotifier<String> _ocrState = ValueNotifier<String>('idle');
final ValueNotifier<String> _detectedText = ValueNotifier<String>('');
final ValueNotifier<String> _fieldContent = ValueNotifier<String>('');
dynamic build(BuildContext context) {
  return const _LiveTextDemoApp();
}

// ══════════════════════════════════════════════════════════════════════════════
//  Root application
// ══════════════════════════════════════════════════════════════════════════════
class _LiveTextDemoApp extends StatelessWidget {
  const _LiveTextDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LiveTextInputStatus Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A84FF),
          brightness: Brightness.light,
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: const _LiveTextHome(),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  Home: 9-tab DefaultTabController
// ══════════════════════════════════════════════════════════════════════════════
class _LiveTextHome extends StatelessWidget {
  const _LiveTextHome();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: scheme.surfaceContainerLowest,
        appBar: AppBar(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          toolbarHeight: 76,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'LiveTextInputStatus Deep Demo',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 2),
              Text(
                'Apple camera-OCR for Flutter text fields — iOS 15+ / macOS 12+',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: _DemoTabBar(),
          ),
        ),
        body: const SafeArea(
          top: false,
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              _HeroTab(),
              _PlatformDiagramTab(),
              _OcrFlowTab(),
              _ContextMenuTab(),
              _NotifierLifecycleTab(),
              _StatusEnumTab(),
              _ToggleTab(),
              _UseCasesTab(),
              _PitfallsApiTab(),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
//  Tab bar
// ──────────────────────────────────────────────────────────────────────────────
class _DemoTabBar extends StatelessWidget {
  const _DemoTabBar();

  static const List<String> _labels = <String>[
    'Hero',
    'Platforms',
    'OCR Flow',
    'Context Menu',
    'Lifecycle',
    'Enum',
    'Toggle',
    'Use Cases',
    'Pitfalls & API',
  ];

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelColor: Theme.of(context).colorScheme.onPrimary,
      unselectedLabelColor:
          Theme.of(context).colorScheme.onPrimary.withAlpha(153),
      indicatorColor: Theme.of(context).colorScheme.onPrimary,
      tabs: _labels
          .map((String l) => Tab(text: l))
          .toList(),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 1 — Hero Banner
// ══════════════════════════════════════════════════════════════════════════════
class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        // ── Gradient hero card ───────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                scheme.primary,
                scheme.tertiary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: scheme.onPrimary,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Live Text',
                      style: text.headlineMedium?.copyWith(
                        color: scheme.onPrimary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Apple\'s Live Text turns your device camera into an instant '
                'OCR scanner. Introduced in iOS 15 and macOS 12 (Monterey), '
                'it lets users point their camera at physical text — a receipt, '
                'a sign, a business card — and paste it directly into any text '
                'field without leaving the app.',
                style: text.bodyLarge?.copyWith(
                  color: scheme.onPrimary.withAlpha(230),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // ── What it does ─────────────────────────────────────────────────────
        _SectionHeader(label: 'What the camera icon does'),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.touch_app_rounded,
          title: 'Tap the camera glyph in the context menu',
          body: 'When a user long-presses a Flutter TextField on a supported '
              'Apple device, a small camera icon appears in the context menu '
              'alongside Cut / Copy / Paste. Tapping it launches the system '
              'Live Text overlay.',
        ),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.document_scanner_rounded,
          title: 'System OCR overlay activates',
          body: 'The OS renders a camera viewfinder over the screen. As the '
              'user moves the camera, text is recognised in real time and '
              'highlighted with yellow bounding boxes.',
        ),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.keyboard_return_rounded,
          title: 'Text is inserted into the field',
          body: 'Tapping highlighted text copies it into the text field at the '
              'cursor position, exactly as if the user had typed it. The '
              'Flutter app receives the text through the standard platform '
              'text-input channel.',
        ),
        const SizedBox(height: 24),
        // ── Flutter API introduction ──────────────────────────────────────────
        _SectionHeader(label: 'Flutter API surface'),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: scheme.outlineVariant),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _ApiRow(
                name: 'LiveTextInputStatus',
                description: 'Enum: enabled | disabled',
              ),
              const SizedBox(height: 8),
              _ApiRow(
                name: 'LiveTextInputStatusNotifier',
                description:
                    'ValueNotifier<LiveTextInputStatus> attached to an '
                    'EditableText state',
              ),
              const SizedBox(height: 8),
              _ApiRow(
                name: 'showLiveTextInput',
                description:
                    'Action triggered from the context menu to launch the '
                    'system camera overlay',
              ),
              const SizedBox(height: 8),
              _ApiRow(
                name: 'contextMenuBuilder',
                description:
                    'TextField parameter; inspect the notifier here to decide '
                    'whether to show the camera item',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // ── Availability chips ────────────────────────────────────────────────
        _SectionHeader(label: 'Availability at a glance'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const <Widget>[
            _AvailChip(label: 'iOS 15+', available: true),
            _AvailChip(label: 'macOS 12+', available: true),
            _AvailChip(label: 'Android', available: false),
            _AvailChip(label: 'Windows', available: false),
            _AvailChip(label: 'Linux', available: false),
            _AvailChip(label: 'Web', available: false),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 2 — Platform availability diagram (CustomPainter)
// ══════════════════════════════════════════════════════════════════════════════
class _PlatformDiagramTab extends StatelessWidget {
  const _PlatformDiagramTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeader(label: 'Platform Support Matrix'),
        const SizedBox(height: 16),
        SizedBox(
          height: 340,
          child: CustomPaint(
            painter: _PlatformMatrixPainter(scheme: scheme),
          ),
        ),
        const SizedBox(height: 24),
        _SectionHeader(label: 'The Flutter Bridge'),
        const SizedBox(height: 12),
        Text(
          'Flutter\'s framework communicates with the iOS/macOS Live Text '
          'system through the platform text-input channel '
          '(TextInputChannel / SystemChannels.textInput). The '
          'LiveTextInputStatusNotifier listens to platform messages that '
          'inform it whether the current device and OS version support '
          'Live Text. On Android and desktop platforms these messages are '
          'never sent, so the notifier stays null and the camera item is '
          'never shown in the context menu.',
          style: text.bodyMedium?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 20),
        // Bridge diagram cards
        _BridgeStepCard(
          step: 1,
          title: 'TextField creates EditableText',
          body: 'The TextField widget internally creates an EditableText, '
              'which manages focus, keyboard, and text-input connections.',
          scheme: scheme,
        ),
        const SizedBox(height: 10),
        _BridgeStepCard(
          step: 2,
          title: 'EditableTextState attaches the notifier',
          body: 'In initState / didChangeDependencies, EditableTextState '
              'creates a LiveTextInputStatusNotifier and stores it as a '
              'static field accessible via '
              'LiveTextInputStatusNotifier.notifier.',
          scheme: scheme,
        ),
        const SizedBox(height: 10),
        _BridgeStepCard(
          step: 3,
          title: 'Platform channel query',
          body: 'The iOS/macOS engine plugin receives a method call asking '
              'whether Live Text is available. It checks OS version and '
              'device capabilities.',
          scheme: scheme,
        ),
        const SizedBox(height: 10),
        _BridgeStepCard(
          step: 4,
          title: 'Notifier value updated',
          body: 'The result arrives on the Flutter side; the notifier\'s '
              'value is set to LiveTextInputStatus.enabled or .disabled. '
              'Any widget listening to this notifier rebuilds.',
          scheme: scheme,
        ),
        const SizedBox(height: 10),
        _BridgeStepCard(
          step: 5,
          title: 'contextMenuBuilder decides',
          body: 'Your contextMenuBuilder callback reads the notifier value '
              'and conditionally inserts an AdaptiveTextSelectionToolbar '
              'button that triggers showLiveTextInput.',
          scheme: scheme,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _PlatformMatrixPainter extends CustomPainter {
  const _PlatformMatrixPainter({required this.scheme});

  final ColorScheme scheme;

  static const List<Map<String, Object>> _rows = <Map<String, Object>>[
    <String, Object>{
      'name': 'iOS',
      'icon': '📱',
      'supported': true,
      'note': 'iOS 15+',
    },
    <String, Object>{
      'name': 'macOS',
      'icon': '💻',
      'supported': true,
      'note': 'macOS 12+',
    },
    <String, Object>{
      'name': 'Android',
      'icon': '🤖',
      'supported': false,
      'note': 'Not supported',
    },
    <String, Object>{
      'name': 'Windows',
      'icon': '🪟',
      'supported': false,
      'note': 'Not supported',
    },
    <String, Object>{
      'name': 'Linux',
      'icon': '🐧',
      'supported': false,
      'note': 'Not supported',
    },
    <String, Object>{
      'name': 'Web',
      'icon': '🌐',
      'supported': false,
      'note': 'Not supported',
    },
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double rowH = size.height / _rows.length;
    final Paint bg = Paint()..color = scheme.surfaceContainerHighest;
    final Paint supportedPaint = Paint()..color = scheme.primary.withAlpha(30);
    final Paint unsupportedPaint = Paint()
      ..color = scheme.error.withAlpha(20);
    final Paint checkPaint = Paint()
      ..color = scheme.primary
      ..style = PaintingStyle.fill;
    final Paint crossPaint = Paint()
      ..color = scheme.error
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    final Paint dividerPaint = Paint()
      ..color = scheme.outlineVariant
      ..strokeWidth = 1;

    // Background
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(16),
      ),
      bg,
    );

    // Header
    final Paint headerPaint = Paint()..color = scheme.primary;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, rowH * 0.8),
        topLeft: const Radius.circular(16),
        topRight: const Radius.circular(16),
      ),
      headerPaint,
    );

    // Header text
    _drawText(
      canvas,
      'Platform',
      Offset(16, rowH * 0.22),
      scheme.onPrimary,
      14,
      bold: true,
    );
    _drawText(
      canvas,
      'Live Text',
      Offset(size.width * 0.55, rowH * 0.22),
      scheme.onPrimary,
      14,
      bold: true,
    );
    _drawText(
      canvas,
      'Note',
      Offset(size.width * 0.72, rowH * 0.22),
      scheme.onPrimary,
      14,
      bold: true,
    );

    // Rows
    for (int i = 0; i < _rows.length; i++) {
      final Map<String, Object> row = _rows[i];
      final double top = rowH * 0.8 + i * ((size.height - rowH * 0.8) / _rows.length);
      final double h = (size.height - rowH * 0.8) / _rows.length;
      final bool supported = row['supported'] as bool;

      // Row bg
      if (i < _rows.length - 1) {
        canvas.drawLine(
          Offset(0, top + h),
          Offset(size.width, top + h),
          dividerPaint,
        );
      }

      // Highlight supported rows
      if (supported) {
        canvas.drawRect(Rect.fromLTWH(0, top, size.width, h), supportedPaint);
      } else {
        canvas.drawRect(
            Rect.fromLTWH(0, top, size.width, h), unsupportedPaint);
      }

      final double midY = top + h / 2;

      // Platform name
      _drawText(
        canvas,
        '${row["icon"]}  ${row["name"]}',
        Offset(16, midY - 8),
        scheme.onSurface,
        13,
      );

      // Check or cross
      final double symbolX = size.width * 0.58;
      if (supported) {
        // Draw a filled circle with a tick
        canvas.drawCircle(
          Offset(symbolX, midY),
          10,
          checkPaint,
        );
        final Paint tickPaint = Paint()
          ..color = scheme.onPrimary
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        final Path tick = Path()
          ..moveTo(symbolX - 5, midY)
          ..lineTo(symbolX - 1, midY + 4)
          ..lineTo(symbolX + 5, midY - 4);
        canvas.drawPath(tick, tickPaint);
      } else {
        // Draw an X
        canvas.drawLine(
          Offset(symbolX - 7, midY - 7),
          Offset(symbolX + 7, midY + 7),
          crossPaint,
        );
        canvas.drawLine(
          Offset(symbolX + 7, midY - 7),
          Offset(symbolX - 7, midY + 7),
          crossPaint,
        );
      }

      // Note
      _drawText(
        canvas,
        row['note'] as String,
        Offset(size.width * 0.68, midY - 8),
        supported ? scheme.primary : scheme.onSurfaceVariant,
        12,
      );
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset,
    Color color,
    double size, {
    bool bold = false,
  }) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_PlatformMatrixPainter oldDelegate) =>
      oldDelegate.scheme != scheme;
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 3 — Simulated OCR flow
// ══════════════════════════════════════════════════════════════════════════════
class _OcrFlowTab extends StatelessWidget {
  const _OcrFlowTab();

  static const List<String> _sampleTexts = <String>[
    'Invoice #4821 — Total: \$142.50',
    '42 Wallaby Way, Sydney NSW 2000',
    'MEETING at 14:00 Conference Room B',
    'Wi-Fi: GuestNetwork  Pass: visitor2026',
    'https://example.com/promo?code=SAVE20',
  ];

  void _startScan(BuildContext context) {
    if (_ocrState.value != 'idle') return;
    _ocrState.value = 'scanning';
    // Simulate scanning → detected transition after a brief moment
    Future<void>.delayed(const Duration(milliseconds: 1200), () {
      if (_ocrState.value != 'scanning') return;
      _detectedText.value =
          _sampleTexts[DateTime.now().millisecond % _sampleTexts.length];
      _ocrState.value = 'detected';
    });
  }

  void _insertText() {
    if (_detectedText.value.isEmpty) return;
    _fieldContent.value =
        '${_fieldContent.value}${_fieldContent.value.isEmpty ? "" : " "}${_detectedText.value}';
    _ocrState.value = 'pasting';
    Future<void>.delayed(const Duration(milliseconds: 600), () {
      _ocrState.value = 'idle';
      _detectedText.value = '';
    });
  }

  void _reset() {
    _ocrState.value = 'idle';
    _detectedText.value = '';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeader(label: 'Simulated Camera OCR Workflow'),
        const SizedBox(height: 4),
        Text(
          'A mock "scan → detect → paste" state machine driven by '
          'top-level ValueNotifiers.',
          style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 20),
        // Camera viewfinder card
        ValueListenableBuilder<String>(
          valueListenable: _ocrState,
          builder: (BuildContext ctx, String state, Widget? _) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: state == 'scanning'
                      ? scheme.primary
                      : state == 'detected'
                          ? Colors.green
                          : scheme.outline,
                  width: 2,
                ),
              ),
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: <Widget>[
                    // Fake camera background
                    Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          colors: <Color>[
                            Color(0xFF1A1A2E),
                            Color(0xFF000000),
                          ],
                        ),
                      ),
                    ),
                    // Corner brackets via CustomPaint
                    CustomPaint(
                      painter: _ViewfinderPainter(
                        state: state,
                        bracketColor: state == 'detected'
                            ? Colors.green
                            : state == 'scanning'
                                ? scheme.primary
                                : Colors.white54,
                      ),
                      child: const SizedBox.expand(),
                    ),
                    // State label
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (state == 'idle')
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white54,
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Ready to scan',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          if (state == 'scanning')
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(
                                  width: 36,
                                  height: 36,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Scanning…',
                                  style: TextStyle(
                                    color: scheme.primary.withAlpha(230),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          if (state == 'detected' || state == 'pasting')
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.green.shade300,
                                  size: 36,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state == 'pasting'
                                      ? 'Inserting…'
                                      : 'Text detected!',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        // Action buttons
        ValueListenableBuilder<String>(
          valueListenable: _ocrState,
          builder: (BuildContext ctx, String state, Widget? _) {
            return Row(
              children: <Widget>[
                Expanded(
                  child: FilledButton.icon(
                    onPressed: state == 'idle'
                        ? () => _startScan(ctx)
                        : null,
                    icon: const Icon(Icons.camera_alt_rounded),
                    label: const Text('Scan'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: state != 'idle' ? _reset : null,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Reset'),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        // Detected text card
        ValueListenableBuilder<String>(
          valueListenable: _detectedText,
          builder: (BuildContext ctx, String detected, Widget? _) {
            if (detected.isEmpty) {
              return const SizedBox.shrink();
            }
            final ColorScheme s = Theme.of(ctx).colorScheme;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _SectionHeader(label: 'Detected Text'),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withAlpha(80)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    detected,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 15,
                      color: s.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _insertText,
                    icon: const Icon(Icons.input_rounded),
                    label: const Text('Insert into field'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
        // Text field content
        _SectionHeader(label: 'TextField Content (simulated)'),
        const SizedBox(height: 8),
        ValueListenableBuilder<String>(
          valueListenable: _fieldContent,
          builder: (BuildContext ctx, String content, Widget? _) {
            final ColorScheme s = Theme.of(ctx).colorScheme;
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: s.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: content.isNotEmpty
                      ? s.primary
                      : s.outlineVariant,
                  width: content.isNotEmpty ? 2 : 1,
                ),
              ),
              padding: const EdgeInsets.all(14),
              child: Text(
                content.isEmpty ? '(empty)' : content,
                style: TextStyle(
                  fontSize: 14,
                  color: content.isEmpty
                      ? s.onSurfaceVariant
                      : s.onSurface,
                  fontStyle: content.isEmpty
                      ? FontStyle.italic
                      : FontStyle.normal,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => _fieldContent.value = '',
          icon: const Icon(Icons.delete_outline_rounded),
          label: const Text('Clear field'),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _ViewfinderPainter extends CustomPainter {
  const _ViewfinderPainter({
    required this.state,
    required this.bracketColor,
  });

  final String state;
  final Color bracketColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bracketPaint = Paint()
      ..color = bracketColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const double margin = 24;
    const double bracketLen = 30;
    final double l = margin;
    final double t = margin;
    final double r = size.width - margin;
    final double b = size.height - margin;

    // Top-left bracket
    canvas.drawLine(Offset(l, t + bracketLen), Offset(l, t), bracketPaint);
    canvas.drawLine(Offset(l, t), Offset(l + bracketLen, t), bracketPaint);
    // Top-right bracket
    canvas.drawLine(Offset(r - bracketLen, t), Offset(r, t), bracketPaint);
    canvas.drawLine(Offset(r, t), Offset(r, t + bracketLen), bracketPaint);
    // Bottom-left bracket
    canvas.drawLine(Offset(l, b - bracketLen), Offset(l, b), bracketPaint);
    canvas.drawLine(Offset(l, b), Offset(l + bracketLen, b), bracketPaint);
    // Bottom-right bracket
    canvas.drawLine(Offset(r - bracketLen, b), Offset(r, b), bracketPaint);
    canvas.drawLine(Offset(r, b), Offset(r, b - bracketLen), bracketPaint);

    // Crosshair center
    if (state == 'scanning') {
      final Paint crosshairPaint = Paint()
        ..color = bracketColor.withAlpha(120)
        ..strokeWidth = 1;
      canvas.drawLine(
        Offset(size.width / 2 - 12, size.height / 2),
        Offset(size.width / 2 + 12, size.height / 2),
        crosshairPaint,
      );
      canvas.drawLine(
        Offset(size.width / 2, size.height / 2 - 12),
        Offset(size.width / 2, size.height / 2 + 12),
        crosshairPaint,
      );
    }

    // Text highlight simulation when detected
    if (state == 'detected') {
      final Paint highlightPaint = Paint()
        ..color = Colors.yellow.withAlpha(60)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * 0.15,
            size.height * 0.4,
            size.width * 0.7,
            24,
          ),
          const Radius.circular(4),
        ),
        highlightPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_ViewfinderPainter oldDelegate) =>
      oldDelegate.state != state || oldDelegate.bracketColor != bracketColor;
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 4 — TextField context menu integration
// ══════════════════════════════════════════════════════════════════════════════
class _ContextMenuTab extends StatelessWidget {
  const _ContextMenuTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeader(label: 'contextMenuBuilder Integration'),
        const SizedBox(height: 12),
        Text(
          'The contextMenuBuilder parameter of TextField receives a callback '
          'invoked whenever the selection context menu needs to appear. Inside '
          'that callback, you check the LiveTextInputStatusNotifier and '
          'conditionally add a camera button.',
          style: text.bodyMedium?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 20),
        // Annotated code block
        _SectionHeader(label: 'Annotated Code'),
        const SizedBox(height: 10),
        _AnnotatedCodeBlock(
          lines: const <_CodeLine>[
            _CodeLine(
              code: 'TextField(',
              annotation: null,
            ),
            _CodeLine(
              code: '  contextMenuBuilder: (ctx, editableTextState) {',
              annotation: '① Called when context menu opens',
            ),
            _CodeLine(
              code: '    final notifier =',
              annotation: null,
            ),
            _CodeLine(
              code: '      LiveTextInputStatusNotifier.notifier;',
              annotation: '② Static accessor — may be null',
            ),
            _CodeLine(
              code: '    final bool liveTextOn =',
              annotation: null,
            ),
            _CodeLine(
              code:
                  '      notifier?.value == LiveTextInputStatus.enabled;',
              annotation: '③ Safe null-check + enum comparison',
            ),
            _CodeLine(
              code: '    final buttons = editableTextState',
              annotation: null,
            ),
            _CodeLine(
              code: '      .contextMenuButtonItems;',
              annotation: '④ Existing Cut/Copy/Paste items',
            ),
            _CodeLine(
              code: '    if (liveTextOn) {',
              annotation: null,
            ),
            _CodeLine(
              code: '      buttons.add(',
              annotation: '⑤ Add camera item only when enabled',
            ),
            _CodeLine(
              code:
                  '        ContextMenuButtonItem(',
              annotation: null,
            ),
            _CodeLine(
              code: '          label: "Scan Text",',
              annotation: null,
            ),
            _CodeLine(
              code: '          onPressed: () {',
              annotation: null,
            ),
            _CodeLine(
              code:
                  '            editableTextState.showLiveTextInput();',
              annotation: '⑥ Trigger system OCR overlay',
            ),
            _CodeLine(
              code: '          },',
              annotation: null,
            ),
            _CodeLine(
              code: '        ),',
              annotation: null,
            ),
            _CodeLine(
              code: '      );',
              annotation: null,
            ),
            _CodeLine(
              code: '    }',
              annotation: null,
            ),
            _CodeLine(
              code:
                  '    return AdaptiveTextSelectionToolbar.buttonItems(',
              annotation: '⑦ Return complete toolbar',
            ),
            _CodeLine(
              code: '      anchors: editableTextState',
              annotation: null,
            ),
            _CodeLine(
              code: '        .contextMenuAnchors,',
              annotation: null,
            ),
            _CodeLine(
              code: '      buttonItems: buttons,',
              annotation: null,
            ),
            _CodeLine(
              code: '    );',
              annotation: null,
            ),
            _CodeLine(
              code: '  },',
              annotation: null,
            ),
            _CodeLine(
              code: ')',
              annotation: null,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SectionHeader(label: 'Simulated Context Menu'),
        const SizedBox(height: 8),
        Text(
          'When liveTextOn is true the camera chip appears alongside the '
          'standard editing actions:',
          style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 14),
        ValueListenableBuilder<bool>(
          valueListenable: _liveTextEnabled,
          builder: (BuildContext ctx, bool enabled, Widget? _) {
            return Container(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: scheme.outlineVariant),
              ),
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _ContextMenuChip(label: 'Cut', icon: Icons.content_cut),
                  _ContextMenuChip(label: 'Copy', icon: Icons.copy_rounded),
                  _ContextMenuChip(label: 'Paste', icon: Icons.paste_rounded),
                  _ContextMenuChip(
                    label: 'Select All',
                    icon: Icons.select_all_rounded,
                  ),
                  if (enabled)
                    _ContextMenuChip(
                      label: 'Scan Text',
                      icon: Icons.camera_alt_rounded,
                      highlighted: true,
                    ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Text(
          'Toggle Live Text on the "Toggle" tab to see the camera chip '
          'appear and disappear.',
          style: text.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 5 — Notifier lifecycle diagram (CustomPainter)
// ══════════════════════════════════════════════════════════════════════════════
class _NotifierLifecycleTab extends StatelessWidget {
  const _NotifierLifecycleTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeader(label: 'LiveTextInputStatusNotifier Lifecycle'),
        const SizedBox(height: 16),
        SizedBox(
          height: 420,
          child: CustomPaint(
            painter: _LifecyclePainter(scheme: scheme),
          ),
        ),
        const SizedBox(height: 24),
        _SectionHeader(label: 'Key lifecycle facts'),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.add_circle_outline_rounded,
          title: 'Created in EditableTextState.initState',
          body: 'The notifier is instantiated once per EditableText instance '
              'and stored as a static field so contextMenuBuilder callbacks '
              'can access it without a BuildContext.',
        ),
        const SizedBox(height: 10),
        _InfoCard(
          icon: Icons.link_rounded,
          title: 'Attached via platform channel',
          body: 'Immediately after creation a platform message is sent to '
              'query Live Text availability. The reply updates the notifier\'s '
              'value on the main isolate.',
        ),
        const SizedBox(height: 10),
        _InfoCard(
          icon: Icons.refresh_rounded,
          title: 'Updates on focus change',
          body: 'Each time the EditableText receives or loses focus the '
              'platform is re-queried, so the notifier always reflects the '
              'current state of the focused field.',
        ),
        const SizedBox(height: 10),
        _InfoCard(
          icon: Icons.delete_outline_rounded,
          title: 'Disposed in dispose()',
          body: 'EditableTextState.dispose() calls notifier.dispose() and '
              'sets the static field to null, preventing stale references '
              'after the widget is removed from the tree.',
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _LifecyclePainter extends CustomPainter {
  const _LifecyclePainter({required this.scheme});

  final ColorScheme scheme;

  static const List<String> _stages = <String>[
    'LiveTextInputStatusNotifier\ncreated',
    'Attached to\nEditableTextState',
    'Platform checks\navailability',
    'notifier.value\nupdated',
    'Dependent widgets\nrebuild',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double boxW = size.width * 0.78;
    final double boxH = 52.0;
    final double gap = (size.height - _stages.length * boxH) / (_stages.length + 1);
    final double boxX = (size.width - boxW) / 2;

    for (int i = 0; i < _stages.length; i++) {
      final double boxY = gap + i * (boxH + gap);

      // Arrow from previous
      if (i > 0) {
        final Paint arrowPaint = Paint()
          ..color = scheme.primary
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        final double prevBottom = gap + (i - 1) * (boxH + gap) + boxH;
        canvas.drawLine(
          Offset(size.width / 2, prevBottom),
          Offset(size.width / 2, boxY - 4),
          arrowPaint,
        );
        // Arrowhead
        final Paint fillPaint = Paint()..color = scheme.primary;
        final Path arrowHead = Path()
          ..moveTo(size.width / 2, boxY)
          ..lineTo(size.width / 2 - 6, boxY - 10)
          ..lineTo(size.width / 2 + 6, boxY - 10)
          ..close();
        canvas.drawPath(arrowHead, fillPaint);
      }

      // Box fill
      final Color boxColor = i == 0
          ? scheme.primaryContainer
          : i == _stages.length - 1
              ? scheme.tertiaryContainer
              : scheme.secondaryContainer;
      final Color textColor = i == 0
          ? scheme.onPrimaryContainer
          : i == _stages.length - 1
              ? scheme.onTertiaryContainer
              : scheme.onSecondaryContainer;

      final RRect rr = RRect.fromRectAndRadius(
        Rect.fromLTWH(boxX, boxY, boxW, boxH),
        const Radius.circular(10),
      );
      canvas.drawRRect(rr, Paint()..color = boxColor);

      // Step number
      canvas.drawCircle(
        Offset(boxX + 22, boxY + boxH / 2),
        14,
        Paint()..color = scheme.primary,
      );
      _drawText(
        canvas,
        '${i + 1}',
        Offset(boxX + 16, boxY + boxH / 2 - 8),
        scheme.onPrimary,
        12,
        bold: true,
      );

      // Stage text
      _drawText(
        canvas,
        _stages[i],
        Offset(boxX + 44, boxY + 8),
        textColor,
        12,
      );
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset,
    Color color,
    double size, {
    bool bold = false,
  }) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          height: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 260);
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_LifecyclePainter oldDelegate) =>
      oldDelegate.scheme != scheme;
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 6 — Status enum gallery
// ══════════════════════════════════════════════════════════════════════════════
class _StatusEnumTab extends StatelessWidget {
  const _StatusEnumTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeader(label: 'LiveTextInputStatus Enum Values'),
        const SizedBox(height: 12),
        Text(
          'The enum has exactly two values. Its purpose is to communicate '
          'from the platform layer to the Flutter widget layer whether the '
          'Live Text feature is currently available on this device.',
          style: text.bodyMedium?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // enabled card
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.green.shade200, width: 2),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.green.withAlpha(40),
                      blurRadius: 16,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Chip(
                      avatar: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: const Text(
                        'enabled',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.green.shade600,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'LiveTextInputStatus.enabled',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Device is running iOS 15+ or macOS 12+ with Live Text '
                      'supported. The camera button SHOULD appear in the '
                      'context menu.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade900,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green.shade700,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Show camera chip',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // disabled card
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(18),
                  border:
                      Border.all(color: scheme.outlineVariant, width: 2),
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Tooltip(
                      message: 'iOS 15+ only',
                      child: Chip(
                        avatar: Icon(
                          Icons.camera_alt_outlined,
                          color: scheme.onSurfaceVariant,
                          size: 18,
                        ),
                        label: Text(
                          'disabled',
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: scheme.surfaceContainerHigh,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'LiveTextInputStatus.disabled',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Device does not support Live Text: older iOS, Android, '
                      'desktop, or web. The camera button should NOT appear.',
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.block_rounded,
                            color: scheme.onSurfaceVariant,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Hide camera chip',
                              style: TextStyle(
                                fontSize: 11,
                                color: scheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SectionHeader(label: 'Enum definition (simplified)'),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outlineVariant),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            '/// Whether Live Text is available on this platform.\n'
            'enum LiveTextInputStatus {\n'
            '  /// Available; show the camera context-menu item.\n'
            '  enabled,\n'
            '\n'
            '  /// Not available; omit the camera context-menu item.\n'
            '  disabled,\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: scheme.onSurface,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 7 — Simulated enabled/disabled toggle
// ══════════════════════════════════════════════════════════════════════════════
class _ToggleTab extends StatelessWidget {
  const _ToggleTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeader(label: 'Simulated Status Toggle'),
        const SizedBox(height: 8),
        Text(
          'Use the segmented button to switch between enabled and disabled. '
          'All connected cards and buttons on every tab update instantly '
          'because they listen to the same top-level ValueNotifier.',
          style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 20),
        // SegmentedButton
        ValueListenableBuilder<bool>(
          valueListenable: _liveTextEnabled,
          builder: (BuildContext ctx, bool enabled, Widget? _) {
            return SegmentedButton<bool>(
              segments: const <ButtonSegment<bool>>[
                ButtonSegment<bool>(
                  value: true,
                  label: Text('enabled'),
                  icon: Icon(Icons.camera_alt_rounded),
                ),
                ButtonSegment<bool>(
                  value: false,
                  label: Text('disabled'),
                  icon: Icon(Icons.camera_alt_outlined),
                ),
              ],
              selected: <bool>{enabled},
              onSelectionChanged: (Set<bool> val) {
                _liveTextEnabled.value = val.first;
              },
            );
          },
        ),
        const SizedBox(height: 28),
        // Status display card
        ValueListenableBuilder<bool>(
          valueListenable: _liveTextEnabled,
          builder: (BuildContext ctx, bool enabled, Widget? _) {
            final ColorScheme s = Theme.of(ctx).colorScheme;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: enabled
                    ? Colors.green.withAlpha(20)
                    : s.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: enabled ? Colors.green.shade300 : s.outlineVariant,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: <Widget>[
                  Icon(
                    enabled
                        ? Icons.camera_alt_rounded
                        : Icons.camera_alt_outlined,
                    size: 52,
                    color: enabled ? Colors.green.shade600 : s.onSurfaceVariant,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    enabled
                        ? 'LiveTextInputStatus.enabled'
                        : 'LiveTextInputStatus.disabled',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: enabled
                          ? Colors.green.shade700
                          : s.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    enabled
                        ? 'The platform has confirmed Live Text is available. '
                            'Your contextMenuBuilder should add the camera item.'
                        : 'Live Text is not available on this platform or OS '
                            'version. Omit the camera item from the menu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: enabled
                          ? Colors.green.shade800
                          : s.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        _SectionHeader(label: 'Effect on context menu'),
        const SizedBox(height: 12),
        ValueListenableBuilder<bool>(
          valueListenable: _liveTextEnabled,
          builder: (BuildContext ctx, bool enabled, Widget? _) {
            final ColorScheme s = Theme.of(ctx).colorScheme;
            return Container(
              decoration: BoxDecoration(
                color: s.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: s.outlineVariant),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Context menu items:',
                    style: text.labelMedium
                        ?.copyWith(color: s.onSurfaceVariant),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      _ContextMenuChip(
                        label: 'Cut',
                        icon: Icons.content_cut,
                      ),
                      _ContextMenuChip(
                        label: 'Copy',
                        icon: Icons.copy_rounded,
                      ),
                      _ContextMenuChip(
                        label: 'Paste',
                        icon: Icons.paste_rounded,
                      ),
                      if (enabled)
                        _ContextMenuChip(
                          label: 'Scan Text',
                          icon: Icons.camera_alt_rounded,
                          highlighted: true,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    enabled
                        ? '"Scan Text" is present because Live Text is enabled.'
                        : '"Scan Text" is absent because Live Text is disabled.',
                    style: TextStyle(
                      fontSize: 12,
                      color: s.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        _SectionHeader(label: 'notifier?.value pattern'),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outlineVariant),
          ),
          padding: const EdgeInsets.all(16),
          child: ValueListenableBuilder<bool>(
            valueListenable: _liveTextEnabled,
            builder: (BuildContext ctx, bool enabled, Widget? _) {
              return Text(
                '// notifier?.value currently evaluates to:\n'
                'LiveTextInputStatus.${enabled ? "enabled" : "disabled"}\n\n'
                '// Conditional check:\n'
                'if (notifier?.value ==\n'
                '    LiveTextInputStatus.enabled) {\n'
                '  // Show camera item ✓\n'
                '}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: scheme.onSurface,
                  height: 1.6,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 8 — Real-world use cases
// ══════════════════════════════════════════════════════════════════════════════
class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  static const List<_UseCase> _cases = <_UseCase>[
    _UseCase(
      icon: Icons.contact_page_rounded,
      title: 'Address Book Form',
      body: 'User scans a business card and the name, address, and phone '
          'number fields are populated from the camera in seconds — no '
          'manual typing required.',
      color: Color(0xFF6200EE),
    ),
    _UseCase(
      icon: Icons.receipt_long_rounded,
      title: 'Receipt Scanner',
      body: 'Finance apps let employees scan expense receipts. Live Text '
          'captures vendor name, total, and date directly into the '
          'expense-report form.',
      color: Color(0xFF018786),
    ),
    _UseCase(
      icon: Icons.qr_code_rounded,
      title: 'Login via QR / Code',
      body: 'One-time login codes printed on hardware tokens or displayed '
          'on secondary screens can be scanned and pasted into password '
          'or OTP fields instantly.',
      color: Color(0xFFB00020),
    ),
    _UseCase(
      icon: Icons.description_rounded,
      title: 'Document Digitizer',
      body: 'Legal and medical apps use Live Text to transcribe paper '
          'documents into editable text fields, eliminating manual data '
          'entry and OCR pre-processing pipelines.',
      color: Color(0xFF37474F),
    ),
    _UseCase(
      icon: Icons.draw_rounded,
      title: 'Handwriting to Text',
      body: 'Note-taking apps allow handwritten notes on paper to be '
          'captured and stored as searchable plain text by pointing the '
          'camera at notebook pages.',
      color: Color(0xFFE65100),
    ),
    _UseCase(
      icon: Icons.present_to_all_rounded,
      title: 'Whiteboard Capture',
      body: 'Meeting tools let attendees scan whiteboard text at the end '
          'of a session, instantly creating typed action items and '
          'agendas without a dedicated scanner app.',
      color: Color(0xFF1B5E20),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeader(label: 'Real-World Use Cases'),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.9,
          ),
          itemCount: _cases.length,
          itemBuilder: (BuildContext ctx, int i) {
            final _UseCase uc = _cases[i];
            return Container(
              decoration: BoxDecoration(
                color: uc.color.withAlpha(15),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: uc.color.withAlpha(60)),
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: uc.color.withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(uc.icon, color: uc.color, size: 26),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    uc.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: uc.color,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      uc.body,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.4,
                        color: Color(0xFF333333),
                      ),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 9 — Pitfalls + API cheat sheet
// ══════════════════════════════════════════════════════════════════════════════
class _PitfallsApiTab extends StatelessWidget {
  const _PitfallsApiTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeader(label: 'Common Pitfalls'),
        const SizedBox(height: 12),
        _PitfallTile(
          number: 1,
          title: 'Feature detection on older iOS',
          body: 'Never assume Live Text is available just because the user is '
              'on iOS. Devices running iOS 14 or earlier do not support it. '
              'Always guard with notifier?.value == '
              'LiveTextInputStatus.enabled rather than an OS version check '
              'in Dart — the platform does the correct capability query for '
              'you. Hard-coding version thresholds creates brittle code that '
              'breaks on future OS versions.',
          scheme: scheme,
        ),
        const SizedBox(height: 12),
        _PitfallTile(
          number: 2,
          title: 'Missing camera permission on iOS',
          body: 'Even though Live Text is an OS-level feature, iOS still '
              'requires NSCameraUsageDescription in your Info.plist if your '
              'app triggers the Live Text overlay. Without this key the '
              'camera overlay fails silently or the app crashes on some iOS '
              'versions. Add a clear, user-facing description explaining why '
              'you need camera access.',
          scheme: scheme,
        ),
        const SizedBox(height: 12),
        _PitfallTile(
          number: 3,
          title: 'Forgetting existing items in contextMenuBuilder',
          body: 'A common mistake is building the context menu from scratch '
              'in contextMenuBuilder and only returning the Live Text button. '
              'This removes Cut, Copy, Paste, Select All, and any other '
              'standard buttons. Always start from '
              'editableTextState.contextMenuButtonItems and append the Live '
              'Text button; never replace the list entirely.',
          scheme: scheme,
        ),
        const SizedBox(height: 28),
        _SectionHeader(label: 'API Cheat Sheet'),
        const SizedBox(height: 14),
        // Enum
        _CheatSheetSection(
          title: 'LiveTextInputStatus (enum)',
          entries: const <_CheatEntry>[
            _CheatEntry(
              name: '.enabled',
              description: 'Live Text is available; show the camera item.',
            ),
            _CheatEntry(
              name: '.disabled',
              description:
                  'Live Text unavailable; omit the camera item.',
            ),
          ],
          scheme: scheme,
        ),
        const SizedBox(height: 14),
        // Notifier
        _CheatSheetSection(
          title: 'LiveTextInputStatusNotifier',
          entries: const <_CheatEntry>[
            _CheatEntry(
              name: 'LiveTextInputStatusNotifier.notifier',
              description:
                  'Static accessor (nullable). Returns the notifier '
                  'for the currently focused EditableText, or null if no '
                  'field is focused or platform does not support it.',
            ),
            _CheatEntry(
              name: '.value',
              description:
                  'The current LiveTextInputStatus. Listen to this '
                  'notifier to rebuild contextMenuBuilder dependents.',
            ),
          ],
          scheme: scheme,
        ),
        const SizedBox(height: 14),
        // showLiveTextInput
        _CheatSheetSection(
          title: 'showLiveTextInput',
          entries: const <_CheatEntry>[
            _CheatEntry(
              name: 'editableTextState.showLiveTextInput()',
              description:
                  'Triggers the system Live Text camera overlay. '
                  'Call this from the onPressed of the ContextMenuButtonItem '
                  'you add inside contextMenuBuilder. No-op on unsupported '
                  'platforms.',
            ),
          ],
          scheme: scheme,
        ),
        const SizedBox(height: 14),
        // contextMenuBuilder
        _CheatSheetSection(
          title: 'TextField.contextMenuBuilder',
          entries: const <_CheatEntry>[
            _CheatEntry(
              name: 'contextMenuBuilder:',
              description:
                  '(BuildContext, EditableTextState) → Widget. '
                  'Return an AdaptiveTextSelectionToolbar built from '
                  'editableTextState.contextMenuButtonItems (append, '
                  'don\'t replace). Use this as the integration point '
                  'for Live Text.',
            ),
          ],
          scheme: scheme,
        ),
        const SizedBox(height: 24),
        // Quick pattern
        _SectionHeader(label: 'Complete minimal pattern'),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outlineVariant),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            'TextField(\n'
            '  contextMenuBuilder: (ctx, state) {\n'
            '    final items =\n'
            '        state.contextMenuButtonItems;\n'
            '    if (LiveTextInputStatusNotifier\n'
            '            .notifier?.value ==\n'
            '        LiveTextInputStatus.enabled) {\n'
            '      items.add(ContextMenuButtonItem(\n'
            '        label: \'Scan Text\',\n'
            '        onPressed: () {\n'
            '          state.showLiveTextInput();\n'
            '        },\n'
            '      ));\n'
            '    }\n'
            '    return AdaptiveTextSelectionToolbar\n'
            '        .buttonItems(\n'
            '      anchors: state.contextMenuAnchors,\n'
            '      buttonItems: items,\n'
            '    );\n'
            '  },\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: scheme.onSurface,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  Shared small widgets
// ══════════════════════════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: scheme.primary,
          ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(6),
            child: Icon(icon, color: scheme.onPrimaryContainer, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: scheme.onSurfaceVariant,
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

class _AvailChip extends StatelessWidget {
  const _AvailChip({required this.label, required this.available});

  final String label;
  final bool available;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Chip(
      avatar: Icon(
        available ? Icons.check_circle_rounded : Icons.cancel_rounded,
        size: 16,
        color: available ? Colors.green.shade600 : scheme.error,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: available ? Colors.green.shade700 : scheme.error,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: available
          ? Colors.green.withAlpha(20)
          : scheme.errorContainer.withAlpha(80),
      side: BorderSide(
        color: available ? Colors.green.shade200 : scheme.error.withAlpha(80),
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({required this.name, required this.description});

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 160),
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: scheme.primary,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: scheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _BridgeStepCard extends StatelessWidget {
  const _BridgeStepCard({
    required this.step,
    required this.title,
    required this.body,
    required this.scheme,
  });

  final int step;
  final String title;
  final String body;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 14,
            backgroundColor: scheme.primary,
            child: Text(
              '$step',
              style: TextStyle(
                color: scheme.onPrimary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: scheme.onSurfaceVariant,
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

class _AnnotatedCodeBlock extends StatelessWidget {
  const _AnnotatedCodeBlock({required this.lines});

  final List<_CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines.map((_CodeLine line) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    line.code,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFFCDD6F4),
                      height: 1.6,
                    ),
                  ),
                ),
                if (line.annotation != null) ...<Widget>[
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '// ${line.annotation}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: Color(0xFF6C7086),
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CodeLine {
  const _CodeLine({required this.code, required this.annotation});

  final String code;
  final String? annotation;
}

class _ContextMenuChip extends StatelessWidget {
  const _ContextMenuChip({
    required this.label,
    required this.icon,
    this.highlighted = false,
  });

  final String label;
  final IconData icon;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Chip(
      avatar: Icon(
        icon,
        size: 15,
        color: highlighted ? scheme.onPrimary : scheme.onSurfaceVariant,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: highlighted ? scheme.onPrimary : scheme.onSurface,
          fontWeight: highlighted ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      backgroundColor:
          highlighted ? scheme.primary : scheme.surfaceContainerHighest,
      side: BorderSide(
        color: highlighted ? scheme.primary : scheme.outlineVariant,
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.number,
    required this.title,
    required this.body,
    required this.scheme,
  });

  final int number;
  final String title;
  final String body;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: scheme.errorContainer.withAlpha(40),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.error.withAlpha(60)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 14,
            backgroundColor: scheme.error,
            child: Text(
              '$number',
              style: TextStyle(
                color: scheme.onError,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: scheme.error,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: scheme.onSurface,
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

class _CheatSheetSection extends StatelessWidget {
  const _CheatSheetSection({
    required this.title,
    required this.entries,
    required this.scheme,
  });

  final String title;
  final List<_CheatEntry> entries;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(13),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: scheme.onPrimaryContainer,
              ),
            ),
          ),
          ...entries.map((_CheatEntry e) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: 0, maxWidth: 180),
                    child: Text(
                      e.name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      e.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onSurfaceVariant,
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
}

class _CheatEntry {
  const _CheatEntry({required this.name, required this.description});

  final String name;
  final String description;
}

class _UseCase {
  const _UseCase({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color color;
}
