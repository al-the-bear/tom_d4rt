// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RootWidget from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF9C27B0); // Purple 500
const _kAccent = Color(0xFF76FF03); // LightGreen A400
const _kSurface = Color(0xFF1A1A1A);
const _kCard = Color(0xFF262626);
const _kDimText = Color(0xFF9E9E9E);
const _kBrightText = Color(0xFFEEEEEE);
const _kHighlight = Color(0xFFCE93D8); // Purple 200

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: ColorScheme.dark(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _RootWidgetDemo(),
  );
}

class _RootWidgetDemo extends StatefulWidget {
  const _RootWidgetDemo();

  @override
  State<_RootWidgetDemo> createState() => _RootWidgetDemoState();
}

class _RootWidgetDemoState extends State<_RootWidgetDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: const Text('RootWidget',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(icon: Icon(Icons.rocket_launch), text: 'Bootstrap'),
            Tab(icon: Icon(Icons.tune), text: 'Properties'),
            Tab(icon: Icon(Icons.link), text: 'Attach Flow'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _BootstrapTab(),
          _PropertiesTab(),
          _AttachFlowTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Bootstrap Overview
// ═══════════════════════════════════════════════════════════════════════════
class _BootstrapTab extends StatelessWidget {
  const _BootstrapTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Hero banner
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4A148C), Color(0xFF311B92)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.rocket_launch, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text(
                'RootWidget',
                style: TextStyle(
                    color: _kBrightText,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _kAccent.withAlpha(80)),
                ),
                child: const Text('The Tree Apex',
                    style: TextStyle(
                        color: _kAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5)),
              ),
              const SizedBox(height: 14),
              const Text(
                'RootWidget sits at the very top of the widget tree. '
                'It is the invisible ancestor of every widget you see '
                'in a Flutter application.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDimText, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // What is RootWidget
        _sectionHeader('What Is RootWidget?'),
        const SizedBox(height: 10),
        _infoTile(
          icon: Icons.widgets_outlined,
          iconColor: _kPrimary,
          title: 'Root of the Widget Tree',
          body: 'RootWidget is a special Widget subclass created by '
              'WidgetsBinding.attachRootWidget(). It wraps the app\'s '
              'top-level widget (usually a MaterialApp or CupertinoApp) '
              'and serves as the absolute root of the entire widget tree.',
        ),
        const SizedBox(height: 10),
        _infoTile(
          icon: Icons.visibility_off,
          iconColor: _kHighlight,
          title: 'Invisible to Developers',
          body: 'You never create a RootWidget directly. The binding '
              'creates it behind the scenes when you call runApp(). '
              'It appears in the element tree inspector as the topmost node.',
        ),
        const SizedBox(height: 10),
        _infoTile(
          icon: Icons.account_tree,
          iconColor: _kAccent,
          title: 'Creates RootElement',
          body: 'RootWidget.createElement() returns a RootElement that '
              'uses RootElementMixin. This element has no parent and '
              'receives the BuildOwner via assignOwner().',
        ),
        const SizedBox(height: 20),

        // runApp flow
        _sectionHeader('How runApp() Uses RootWidget'),
        const SizedBox(height: 10),
        _buildRunAppFlow(),
        const SizedBox(height: 20),

        // Key insight
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kPrimary.withAlpha(15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(60)),
          ),
          child: Row(
            children: [
              const Icon(Icons.lightbulb, color: _kAccent, size: 28),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Key Insight',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(
                      'RootWidget extends Widget directly — not '
                      'StatelessWidget or StatefulWidget. This is '
                      'intentional: it needs custom createElement() '
                      'logic that those subclasses don\'t provide.',
                      style: TextStyle(
                          color: _kDimText.withAlpha(200),
                          fontSize: 12,
                          height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRunAppFlow() {
    const steps = [
      ('runApp(MyApp())', 'App entry point', Icons.play_arrow),
      ('WidgetsFlutterBinding.ensureInitialized()',
          'Creates the binding', Icons.extension),
      ('scheduleAttachRootWidget(app)',
          'Schedules root attachment', Icons.schedule),
      ('attachRootWidget(app)',
          'Creates RootWidget wrapping app', Icons.wrap_text),
      ('RootWidget(child: app)',
          'Wraps your widget', Icons.widgets),
      ('rootWidget.attach(buildOwner)',
          'Bootstraps the element tree', Icons.link),
      ('scheduleWarmUpFrame()',
          'First frame is built', Icons.image),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _kPrimary.withAlpha(60 + i * 20),
                        _kPrimary.withAlpha(30 + i * 15),
                      ],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: _kAccent.withAlpha(40 + i * 15)),
                  ),
                  child: Icon(steps[i].$3,
                      size: 16, color: _kAccent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(steps[i].$1,
                          style: const TextStyle(
                              color: _kBrightText,
                              fontSize: 12,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 2),
                      Text(steps[i].$2,
                          style: const TextStyle(
                              color: _kDimText, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
            if (i < steps.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 16),
                height: 14,
                width: 2,
                color: _kPrimary.withAlpha(50),
              ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Properties & API
// ═══════════════════════════════════════════════════════════════════════════
class _PropertiesTab extends StatelessWidget {
  const _PropertiesTab();

  @override
  Widget build(BuildContext context) {
    // Create instances for live inspection
    final withChild = RootWidget(child: Container(color: Colors.blue));
    final withDesc = RootWidget(
      child: const SizedBox(),
      debugShortDescription: 'TestRoot',
    );
    final noChild = RootWidget();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionHeader('Constructor'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'RootWidget({\n'
                '  Widget? child,\n'
                '  String? debugShortDescription,\n'
                '})',
                style: TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 13,
                    height: 1.6),
              ),
              const SizedBox(height: 10),
              const Text(
                'Both parameters are optional. The child is the app '
                'widget you pass to runApp(). The debugShortDescription '
                'customises the debug output.',
                style: TextStyle(
                    color: _kDimText, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Live property cards
        _sectionHeader('Live Property Inspection'),
        const SizedBox(height: 10),
        _propertyCard(
          name: 'child',
          type: 'Widget?',
          values: [
            ('With Container', '${withChild.child?.runtimeType}'),
            ('With SizedBox', '${withDesc.child?.runtimeType}'),
            ('Null child', '${noChild.child}'),
          ],
        ),
        const SizedBox(height: 10),
        _propertyCard(
          name: 'debugShortDescription',
          type: 'String?',
          values: [
            ('Default', '${withChild.debugShortDescription}'),
            ('Custom', '${withDesc.debugShortDescription}'),
          ],
        ),
        const SizedBox(height: 10),
        _propertyCard(
          name: 'toStringShort()',
          type: 'String',
          values: [
            ('Default', withChild.toStringShort()),
            ('Custom desc', withDesc.toStringShort()),
          ],
        ),
        const SizedBox(height: 20),

        // Methods
        _sectionHeader('Methods'),
        const SizedBox(height: 10),
        _methodCard(
          name: 'createElement()',
          returnType: 'RootElement',
          description:
              'Creates the RootElement that manages this widget in the element tree. '
              'The RootElement uses RootElementMixin for root capabilities.',
          liveResult: '${withChild.createElement().runtimeType}',
        ),
        const SizedBox(height: 10),
        _methodCard(
          name: 'attach(BuildOwner, [RootElement?])',
          returnType: 'RootElement',
          description:
              'Bootstraps the widget tree. If no existing element is provided, '
              'creates a new one. If an element exists, schedules a rebuild. '
              'Always assigns the owner and mounts.',
          liveResult: 'Cannot invoke without BuildOwner',
        ),
        const SizedBox(height: 20),

        // Inheritance
        _sectionHeader('Inheritance Chain'),
        const SizedBox(height: 10),
        _buildInheritanceChain(),
      ],
    );
  }

  Widget _propertyCard({
    required String name,
    required String type,
    required List<(String, String)> values,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _kPrimary.withAlpha(30),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(type,
                    style: const TextStyle(
                        color: _kHighlight,
                        fontSize: 11,
                        fontFamily: 'monospace')),
              ),
              const SizedBox(width: 10),
              Text(name,
                  style: const TextStyle(
                      color: _kAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 10),
          ...values.map((v) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_right,
                        color: _kDimText, size: 16),
                    Text('${v.$1}: ',
                        style: const TextStyle(
                            color: _kDimText, fontSize: 12)),
                    Expanded(
                      child: Text(v.$2,
                          style: const TextStyle(
                              color: _kBrightText,
                              fontSize: 12,
                              fontFamily: 'monospace')),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _methodCard({
    required String name,
    required String returnType,
    required String description,
    required String liveResult,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccent.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.functions, color: _kAccent, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(name,
                    style: const TextStyle(
                        color: _kAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace')),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kPrimary.withAlpha(25),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('→ $returnType',
                    style: const TextStyle(
                        color: _kHighlight,
                        fontSize: 10,
                        fontFamily: 'monospace')),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description,
              style: const TextStyle(
                  color: _kDimText, fontSize: 12, height: 1.4)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kPrimary.withAlpha(30)),
            ),
            child: Text('Result: $liveResult',
                style: const TextStyle(
                    color: _kHighlight,
                    fontSize: 11,
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget _buildInheritanceChain() {
    const chain = [
      ('Object', Icons.circle_outlined, _kDimText),
      ('DiagnosticableTree', Icons.share, _kDimText),
      ('Widget', Icons.widgets, _kHighlight),
      ('RootWidget', Icons.star, _kAccent),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < chain.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: chain[i].$3.withAlpha(20),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: chain[i].$3.withAlpha(80)),
                  ),
                  child: Icon(chain[i].$2,
                      size: 16, color: chain[i].$3),
                ),
                const SizedBox(width: 12),
                Text(chain[i].$1,
                    style: TextStyle(
                        color: chain[i].$3,
                        fontSize: 14,
                        fontWeight: i == chain.length - 1
                            ? FontWeight.bold
                            : FontWeight.normal)),
                if (i == chain.length - 1) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _kAccent.withAlpha(25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('THIS CLASS',
                        style: TextStyle(
                            color: _kAccent,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
                  ),
                ],
              ],
            ),
            if (i < chain.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 15),
                height: 14,
                width: 2,
                color: chain[i].$3.withAlpha(40),
              ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Attach Flow
// ═══════════════════════════════════════════════════════════════════════════
class _AttachFlowTab extends StatefulWidget {
  const _AttachFlowTab();

  @override
  State<_AttachFlowTab> createState() => _AttachFlowTabState();
}

class _AttachFlowTabState extends State<_AttachFlowTab> {
  int _currentStep = 0;

  static const _steps = [
    _AttachStep(
      title: 'RootWidget.attach() called',
      code: 'rootWidget.attach(buildOwner)',
      detail: 'The binding calls attach() with its BuildOwner. '
          'An optional existing RootElement can be passed for hot restart.',
      icon: Icons.play_circle_outline,
    ),
    _AttachStep(
      title: 'Check for existing element',
      code: 'if (element != null) {\n'
          '  element._newWidget = this;\n'
          '  element.markNeedsBuild();\n'
          '} else {\n'
          '  element = createElement();\n'
          '}',
      detail: 'If a previous element exists (hot restart), it is reused. '
          'Otherwise createElement() creates a fresh RootElement.',
      icon: Icons.alt_route,
    ),
    _AttachStep(
      title: 'Assign BuildOwner',
      code: 'element.assignOwner(owner)',
      detail: 'The BuildOwner is assigned to the root element. '
          'This owner will manage the dirty elements list for '
          'the entire subtree.',
      icon: Icons.admin_panel_settings,
    ),
    _AttachStep(
      title: 'Mount the root',
      code: 'owner.buildScope(element, () {\n'
          '  element.mount(null, null);\n'
          '})',
      detail: 'mount() is called with null parent and null slot, '
          'since this is the root. The build scope ensures '
          'that dirty descendants are rebuilt atomically.',
      icon: Icons.download,
    ),
    _AttachStep(
      title: 'Tree is live',
      code: '// Widget tree is now active',
      detail: 'The element tree is now mounted. The child widget '
          '(your app) inflates recursively from here.',
      icon: Icons.check_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionHeader('Attach Flow Step-by-Step'),
        const SizedBox(height: 12),

        // Step navigator
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Column(
            children: [
              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_steps.length, (i) {
                  final active = i == _currentStep;
                  final done = i < _currentStep;
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _currentStep = i),
                        child: Container(
                          width: active ? 28 : 20,
                          height: active ? 28 : 20,
                          decoration: BoxDecoration(
                            color: active
                                ? _kAccent
                                : done
                                    ? _kPrimary
                                    : _kDimText.withAlpha(40),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: active
                                  ? _kAccent
                                  : done
                                      ? _kPrimary.withAlpha(120)
                                      : _kDimText.withAlpha(60),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text('${i + 1}',
                                style: TextStyle(
                                    color: active || done
                                        ? Colors.black
                                        : _kDimText,
                                    fontSize: active ? 12 : 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      if (i < _steps.length - 1)
                        Container(
                          width: 20,
                          height: 2,
                          color: done
                              ? _kPrimary.withAlpha(120)
                              : _kDimText.withAlpha(30),
                        ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Current step detail
              _buildStepDetail(_steps[_currentStep]),

              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: _currentStep > 0
                        ? () => setState(() => _currentStep--)
                        : null,
                    icon: const Icon(Icons.arrow_back, size: 16),
                    label: const Text('Prev'),
                    style: TextButton.styleFrom(
                      foregroundColor: _kAccent,
                      disabledForegroundColor: _kDimText.withAlpha(60),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _currentStep < _steps.length - 1
                        ? () => setState(() => _currentStep++)
                        : null,
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: const Text('Next'),
                    style: TextButton.styleFrom(
                      foregroundColor: _kAccent,
                      disabledForegroundColor: _kDimText.withAlpha(60),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Hot restart vs cold start
        _sectionHeader('Cold Start vs Hot Restart'),
        const SizedBox(height: 10),
        _buildComparisonCards(),
        const SizedBox(height: 20),

        // Element tree after attach
        _sectionHeader('Element Tree After Attach'),
        const SizedBox(height: 10),
        _buildTreeAfterAttach(),
        const SizedBox(height: 20),

        // Q&A
        _sectionHeader('Common Questions'),
        const SizedBox(height: 10),
        _buildQASection(),
      ],
    );
  }

  Widget _buildStepDetail(_AttachStep step) {
    return Column(
      children: [
        Icon(step.icon, color: _kAccent, size: 36),
        const SizedBox(height: 10),
        Text(step.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: _kBrightText,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kPrimary.withAlpha(40)),
          ),
          child: Text(step.code,
              style: const TextStyle(
                  color: _kAccent,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.5)),
        ),
        const SizedBox(height: 10),
        Text(step.detail,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: _kDimText, fontSize: 12, height: 1.5)),
      ],
    );
  }

  Widget _buildComparisonCards() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccent.withAlpha(50)),
            ),
            child: Column(
              children: [
                const Icon(Icons.power_settings_new,
                    color: _kAccent, size: 24),
                const SizedBox(height: 8),
                const Text('Cold Start',
                    style: TextStyle(
                        color: _kAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  'createElement() is called.\n'
                  'New element mounted.\n'
                  'Full tree build.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _kDimText.withAlpha(200),
                      fontSize: 11,
                      height: 1.5),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kHighlight.withAlpha(50)),
            ),
            child: Column(
              children: [
                const Icon(Icons.restart_alt,
                    color: _kHighlight, size: 24),
                const SizedBox(height: 8),
                const Text('Hot Restart',
                    style: TextStyle(
                        color: _kHighlight,
                        fontSize: 13,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  'Existing element reused.\n'
                  'markNeedsBuild() called.\n'
                  'Subtree reconciled.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _kDimText.withAlpha(200),
                      fontSize: 11,
                      height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTreeAfterAttach() {
    const nodes = [
      ('RootElement', 'parent: null, owner: BuildOwner', _kAccent),
      ('  AppElement', 'MaterialApp or CupertinoApp', _kHighlight),
      ('    NavigatorElement', 'Route management', _kPrimary),
      ('      PageElement', 'Your first route', _kDimText),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: nodes.map((n) {
          final indent = n.$1.length - n.$1.trimLeft().length;
          return Padding(
            padding: EdgeInsets.only(
                left: indent * 10.0, top: 4, bottom: 4),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: n.$3,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n.$1.trim(),
                          style: TextStyle(
                              color: n.$3,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                      Text(n.$2,
                          style: const TextStyle(
                              color: _kDimText, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQASection() {
    const items = [
      (
        'Can I create RootWidget myself?',
        'Technically yes, but it serves no practical purpose. The '
            'binding creates it for you via runApp(). Creating one '
            'manually means you\'d also need to manage the BuildOwner.'
      ),
      (
        'Why does RootWidget extend Widget directly?',
        'It needs a custom createElement() that returns RootElement '
            'with RootElementMixin. StatelessWidget and StatefulWidget '
            'have their own fixed Element types.'
      ),
      (
        'What happens if child is null?',
        'The tree simply has no content below the root. In practice '
            'runApp() always provides a child widget.'
      ),
    ];

    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kPrimary.withAlpha(40)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.help_outline,
                        color: _kAccent, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(item.$1,
                          style: const TextStyle(
                              color: _kAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(item.$2,
                    style: const TextStyle(
                        color: _kDimText,
                        fontSize: 12,
                        height: 1.4)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _AttachStep {
  final String title;
  final String code;
  final String detail;
  final IconData icon;

  const _AttachStep({
    required this.title,
    required this.code,
    required this.detail,
    required this.icon,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared Helpers
// ═══════════════════════════════════════════════════════════════════════════
Widget _sectionHeader(String title) {
  return Row(
    children: [
      Container(width: 4, height: 20, color: _kAccent),
      const SizedBox(width: 10),
      Text(title,
          style: const TextStyle(
              color: _kBrightText,
              fontSize: 17,
              fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _infoTile({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: iconColor.withAlpha(50)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: _kBrightText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(body,
                  style: const TextStyle(
                      color: _kDimText, fontSize: 12, height: 1.5)),
            ],
          ),
        ),
      ],
    ),
  );
}
