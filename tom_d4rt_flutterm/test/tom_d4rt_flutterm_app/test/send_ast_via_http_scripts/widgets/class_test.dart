// ignore_for_file: avoid_print
// Deep demo: Class — Dart class fundamentals in user-defined widgets
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Warm Terracotta / Linen
// ─────────────────────────────────────────────────────────────
const Color _clTerracotta = Color(0xFFC75B39);
const Color _clLinen = Color(0xFFFDF5E6);
const Color _clDarkCotta = Color(0xFF8B3A22);
const Color _clMedCotta = Color(0xFFD98E73);
const Color _clLightCotta = Color(0xFFEFC8B8);
const Color _clWhite = Color(0xFFFFFFFF);
const Color _clDarkText = Color(0xFF4A3228);
const Color _clAccentGreen = Color(0xFF2E7D32);
const Color _clAccentBlue = Color(0xFF1565C0);
const Color _clAccentPurple = Color(0xFF6A1B9A);
const Color _clAccentTeal = Color(0xFF00796B);
const Color _clAccentIndigo = Color(0xFF283593);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _clSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _clWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _clLightCotta, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x15C75B39), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _clTerracotta,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _clWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _clLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _clDarkCotta,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _clBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _clDarkText, fontSize: 12.5, height: 1.5)),
  );
}

Widget _clCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF0E5),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _clLightCotta.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _clDarkCotta,
            height: 1.45)),
  );
}

Widget _clChip(String text, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(text,
        style:
            TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _clDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _clLightCotta.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: Class');
  print('  Dart class fundamentals in widget construction');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _clLinen,
      appBarTheme: const AppBarTheme(
        backgroundColor: _clTerracotta,
        foregroundColor: _clWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Class (Widgets)',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Banner
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_clDarkCotta, _clTerracotta, _clMedCotta],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _clWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.class_,
                        color: _clWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('Class',
                      style: TextStyle(
                          color: _clWhite,
                          fontSize: 22,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(
                      'The Dart class as the foundation of every Flutter widget',
                      style: TextStyle(
                          color: _clWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _clChip('Inheritance', _clWhite.withValues(alpha: 0.25), _clWhite),
                      _clChip('Constructor', _clWhite.withValues(alpha: 0.25), _clWhite),
                      _clChip('Lifecycle', _clWhite.withValues(alpha: 0.25), _clWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is a Class in widgets context?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('1 · What Is a Class in Widget Context?', [
              _clBody(
                'Every Flutter widget is a Dart class. The class provides '
                'the structure: fields for configuration, a constructor for '
                'initialization, and methods for lifecycle and rendering. '
                'Understanding class mechanics is essential to understanding widgets.',
              ),
              _clLabel('Widget = Class'),
              _clCodeBlock(
                'class MyButton extends StatelessWidget {\n'
                '  // Field: immutable configuration\n'
                '  final String label;\n'
                '  final VoidCallback? onTap;\n'
                '\n'
                '  // Constructor: receives parameters\n'
                '  const MyButton({required this.label, this.onTap});\n'
                '\n'
                '  // Method: describes the UI\n'
                '  @override\n'
                '  Widget build(BuildContext context) { ... }\n'
                '}',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Class hierarchy
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('2 · Widget Class Hierarchy', [
              _clBody(
                'All widgets share a common class hierarchy rooted in '
                'the Widget abstract class.',
              ),
              _buildClassHierarchy(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Constructor patterns
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('3 · Constructor Patterns', [
              _clBody(
                'Widget classes use several constructor patterns to '
                'support different initialization scenarios.',
              ),
              ..._buildConstructorPatterns(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Stateless vs Stateful anatomy
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('4 · Stateless vs Stateful Class Anatomy', [
              _clBody(
                'The two primary widget class patterns have different '
                'internal structures.',
              ),
              _buildStatelessStatefulComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Lifecycle through class methods
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('5 · Widget Lifecycle via Class Methods', [
              _clBody(
                'The widget lifecycle is implemented as overridable class '
                'methods. Each method serves a specific phase.',
              ),
              _buildLifecycleMethods(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Key class members
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('6 · Key Class Members', [
              _buildKeyMembersTable(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Mixin composition
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('7 · Mixin Composition in Widget Classes', [
              _clBody(
                'Dart mixins allow widget classes to compose reusable '
                'behavior without deep inheritance chains.',
              ),
              ..._buildMixinCards(),
              _clDivider(),
              _clCodeBlock(
                'class AnimatedCounter extends StatefulWidget { ... }\n'
                '\n'
                'class _AnimatedCounterState\n'
                '    extends State<AnimatedCounter>\n'
                '    with SingleTickerProviderStateMixin,\n'
                '         AutomaticKeepAliveClientMixin {\n'
                '  // Gets ticker + keep-alive behavior\n'
                '}',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Inheritance chains
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('8 · Inheritance Chains', [
              _clBody(
                'Widget classes often form multi-level inheritance '
                'to share behavior across related widgets.',
              ),
              _buildInheritanceChainDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Generic class parameters
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('9 · Generic Widget Classes', [
              _clBody(
                'Dart generics make widget classes type-safe and reusable '
                'across different data types.',
              ),
              _clCodeBlock(
                'class DataList<T> extends StatelessWidget {\n'
                '  final List<T> items;\n'
                '  final Widget Function(T item) itemBuilder;\n'
                '\n'
                '  const DataList({\n'
                '    required this.items,\n'
                '    required this.itemBuilder,\n'
                '  });\n'
                '\n'
                '  @override\n'
                '  Widget build(BuildContext context) {\n'
                '    return ListView(\n'
                '      children: items.map(itemBuilder).toList(),\n'
                '    );\n'
                '  }\n'
                '}',
              ),
              _clDivider(),
              _buildGenericUsageCards(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Real-world widget class
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('10 · Real-World Widget Class Structure', [
              _clBody(
                'A complete widget class with all common elements: '
                'fields, constructor, lifecycle, build, and disposal.',
              ),
              _buildRealWorldClassDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Class best practices
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('11 · Class Best Practices', [
              _buildBestPracticesGrid(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _clSection('12 · Summary', [
              _clBody(
                'The Dart class is the structural foundation of every '
                'Flutter widget, providing the blueprint for configuration, '
                'lifecycle, and rendering.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_clTerracotta, _clMedCotta],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _clSummaryRow(Icons.class_, 'Every widget is a Dart class'),
                    _clSummaryRow(Icons.account_tree, 'Hierarchy: Widget → Stateless/Stateful → Your widget'),
                    _clSummaryRow(Icons.build, 'Constructors: const, named, factory, redirecting'),
                    _clSummaryRow(Icons.loop, 'Lifecycle methods: initState → build → dispose'),
                    _clSummaryRow(Icons.extension, 'Mixins compose behavior without deep inheritance'),
                    _clSummaryRow(Icons.data_object, 'Generics make classes type-safe and reusable'),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 2: Class hierarchy
// ─────────────────────────────────────────────────────────────
Widget _buildClassHierarchy() {
  final levels = <Map<String, dynamic>>[
    {'name': 'Object', 'desc': 'Root of all Dart classes', 'depth': 0, 'color': _clAccentIndigo},
    {'name': 'DiagnosticableTree', 'desc': 'Debug printing support', 'depth': 1, 'color': _clAccentPurple},
    {'name': 'Widget', 'desc': 'Abstract: key, createElement()', 'depth': 2, 'color': _clAccentBlue},
    {'name': 'StatelessWidget', 'desc': 'Immutable, build() only', 'depth': 3, 'color': _clAccentGreen},
    {'name': 'StatefulWidget', 'desc': 'Mutable via State<T>', 'depth': 3, 'color': _clAccentTeal},
    {'name': 'RenderObjectWidget', 'desc': 'Direct render tree access', 'depth': 3, 'color': _clTerracotta},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _clLinen,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _clLightCotta),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: levels.map((l) {
        final indent = (l['depth'] as int) * 20.0;
        return Padding(
          padding: EdgeInsets.only(left: indent, bottom: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: (l['color'] as Color).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: (l['color'] as Color).withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: l['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(l['name'] as String,
                    style: TextStyle(
                        color: l['color'] as Color,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace')),
                const SizedBox(width: 6),
                Text('— ${l['desc']}',
                    style: const TextStyle(
                        color: _clDarkText, fontSize: 10)),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Constructor patterns
// ─────────────────────────────────────────────────────────────
List<Widget> _buildConstructorPatterns() {
  final patterns = <Map<String, dynamic>>[
    {
      'name': 'Default const',
      'desc': 'Most widget constructors. Enables compile-time constant creation.',
      'code': 'const MyWidget({super.key, required this.title});',
      'color': _clAccentBlue,
      'icon': Icons.star,
    },
    {
      'name': 'Named constructor',
      'desc': 'Alternative constructors for specialized configurations.',
      'code': 'MyWidget.outlined({super.key})\n  : title = \'\', border = true;',
      'color': _clAccentGreen,
      'icon': Icons.label,
    },
    {
      'name': 'Factory constructor',
      'desc': 'Returns existing instance or subtype. Used for caching.',
      'code': 'factory MyWidget.cached(String id) {\n  return _cache[id] ??= MyWidget(id: id);\n}',
      'color': _clAccentPurple,
      'icon': Icons.factory,
    },
    {
      'name': 'Redirecting',
      'desc': 'Delegates to another constructor with default values.',
      'code': 'MyWidget.primary()\n  : this(title: \'Default\', color: blue);',
      'color': _clTerracotta,
      'icon': Icons.subdirectory_arrow_right,
    },
  ];

  return patterns.map((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (p['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: (p['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: p['color'] as Color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(p['icon'] as IconData,
                    color: _clWhite, size: 14),
              ),
              const SizedBox(width: 8),
              Text(p['name'] as String,
                  style: TextStyle(
                      color: p['color'] as Color,
                      fontSize: 12,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 4),
          Text(p['desc'] as String,
              style: const TextStyle(
                  color: _clDarkText, fontSize: 10.5, height: 1.3)),
          const SizedBox(height: 6),
          _clCodeBlock(p['code'] as String),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 4: Stateless vs Stateful comparison
// ─────────────────────────────────────────────────────────────
Widget _buildStatelessStatefulComparison() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _clLinen,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _clLightCotta),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _clClassCard(
            'StatelessWidget',
            [
              '1 class',
              'const constructor',
              'build() method',
              'Immutable fields only',
              'No state object',
              'Rebuilt by parent only',
            ],
            _clAccentGreen,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _clClassCard(
            'StatefulWidget',
            [
              '2 classes (Widget + State)',
              'createState() method',
              'State owns build()',
              'Mutable state fields',
              'initState() / dispose()',
              'Can self-rebuild via setState',
            ],
            _clAccentTeal,
          ),
        ),
      ],
    ),
  );
}

Widget _clClassCard(String title, List<String> items, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace')),
        const SizedBox(height: 6),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(item,
                        style: const TextStyle(
                            color: _clDarkText,
                            fontSize: 10,
                            height: 1.3)),
                  ),
                ],
              ),
            )),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 5: Lifecycle methods
// ─────────────────────────────────────────────────────────────
Widget _buildLifecycleMethods() {
  final methods = <Map<String, dynamic>>[
    {'method': 'initState()', 'phase': 'Creation', 'desc': 'Called once when State is first created', 'color': _clAccentBlue},
    {'method': 'didChangeDependencies()', 'phase': 'Dependencies', 'desc': 'Called when InheritedWidget changes', 'color': _clAccentPurple},
    {'method': 'build()', 'phase': 'Rendering', 'desc': 'Returns the widget tree — called frequently', 'color': _clAccentGreen},
    {'method': 'didUpdateWidget()', 'phase': 'Update', 'desc': 'Parent rebuilt with new widget config', 'color': _clTerracotta},
    {'method': 'deactivate()', 'phase': 'Removal', 'desc': 'Removed from tree (may be reinserted)', 'color': _clAccentTeal},
    {'method': 'dispose()', 'phase': 'Cleanup', 'desc': 'Permanently removed — free resources', 'color': _clDarkCotta},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _clLinen,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _clLightCotta),
    ),
    child: Column(
      children: methods.asMap().entries.map((entry) {
        final m = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (m['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: (m['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: m['color'] as Color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('${entry.key + 1}',
                      style: const TextStyle(
                          color: _clWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(m['method'] as String,
                            style: TextStyle(
                                color: m['color'] as Color,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace')),
                        const SizedBox(width: 6),
                        _clChip(m['phase'] as String,
                            (m['color'] as Color).withValues(alpha: 0.12),
                            m['color'] as Color),
                      ],
                    ),
                    Text(m['desc'] as String,
                        style: const TextStyle(
                            color: _clDarkText, fontSize: 10)),
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

// ─────────────────────────────────────────────────────────────
// Section 6: Key members table
// ─────────────────────────────────────────────────────────────
Widget _buildKeyMembersTable() {
  final rows = <List<String>>[
    ['Member', 'Type', 'Purpose'],
    ['key', 'Key?', 'Element identity for diffing'],
    ['widget', 'T', 'Current config (in State)'],
    ['context', 'BuildContext', 'Position in widget tree'],
    ['mounted', 'bool', 'Whether State is in tree'],
    ['build()', 'Widget', 'Returns the subtree'],
    ['setState()', 'void', 'Marks State as dirty'],
    ['createState()', 'State<T>', 'Factory for mutable state'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _clLightCotta),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          color: isHeader
              ? _clTerracotta
              : entry.key.isEven
                  ? _clLinen
                  : _clWhite,
          child: Row(
            children: entry.value.asMap().entries.map((col) {
              return Expanded(
                flex: col.key == 2 ? 3 : 2,
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader ? _clWhite : _clDarkText,
                        fontSize: 10.5,
                        fontWeight:
                            isHeader ? FontWeight.w700 : FontWeight.w400,
                        fontFamily: col.key < 2 ? 'monospace' : null)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 7: Mixin cards
// ─────────────────────────────────────────────────────────────
List<Widget> _buildMixinCards() {
  final mixins = <Map<String, dynamic>>[
    {'name': 'SingleTickerProviderStateMixin', 'desc': 'Provides a single AnimationController ticker', 'color': _clAccentBlue},
    {'name': 'TickerProviderStateMixin', 'desc': 'Provides multiple tickers for animations', 'color': _clAccentGreen},
    {'name': 'AutomaticKeepAliveClientMixin', 'desc': 'Keeps state alive in lazy lists', 'color': _clAccentPurple},
    {'name': 'WidgetsBindingObserver', 'desc': 'Observes app lifecycle (resume, pause)', 'color': _clAccentTeal},
  ];

  return mixins.map((m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: (m['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: (m['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: m['color'] as Color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m['name'] as String,
                    style: TextStyle(
                        color: m['color'] as Color,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace')),
                Text(m['desc'] as String,
                    style: const TextStyle(
                        color: _clDarkText, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 8: Inheritance chain
// ─────────────────────────────────────────────────────────────
Widget _buildInheritanceChainDemo() {
  final chain = <Map<String, dynamic>>[
    {'name': 'BaseCard', 'members': 'padding, elevation, radius', 'color': _clAccentIndigo},
    {'name': 'InteractiveCard', 'members': '+ onTap, onLongPress', 'color': _clAccentBlue},
    {'name': 'ProductCard', 'members': '+ name, price, image', 'color': _clAccentGreen},
    {'name': 'FeaturedProductCard', 'members': '+ badge, highlight', 'color': _clTerracotta},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _clLinen,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _clLightCotta),
    ),
    child: Column(
      children: chain.asMap().entries.map((entry) {
        final c = entry.value;
        return Container(
          margin: EdgeInsets.only(left: entry.key * 16.0, bottom: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (c['color'] as Color).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: (c['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Text(c['name'] as String,
                  style: TextStyle(
                      color: c['color'] as Color,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace')),
              const SizedBox(width: 8),
              Expanded(
                child: Text(c['members'] as String,
                    style: const TextStyle(
                        color: _clDarkText, fontSize: 10)),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 9: Generic usage cards
// ─────────────────────────────────────────────────────────────
Widget _buildGenericUsageCards() {
  final usages = <Map<String, dynamic>>[
    {'usage': 'DataList<String>', 'desc': 'List of strings', 'color': _clAccentBlue},
    {'usage': 'DataList<Product>', 'desc': 'List of product objects', 'color': _clAccentGreen},
    {'usage': 'DataList<int>', 'desc': 'List of numeric values', 'color': _clAccentPurple},
    {'usage': 'Selector<Model, String>', 'desc': 'Type-safe field selection', 'color': _clAccentTeal},
  ];

  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: usages.map((u) {
      return Container(
        width: 145,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (u['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: (u['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(u['usage'] as String,
                style: TextStyle(
                    color: u['color'] as Color,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace')),
            Text(u['desc'] as String,
                style:
                    const TextStyle(color: _clDarkText, fontSize: 9.5)),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Real-world class demo
// ─────────────────────────────────────────────────────────────
Widget _buildRealWorldClassDemo() {
  final sections = <Map<String, dynamic>>[
    {'label': 'Class declaration', 'code': 'class SearchBar extends StatefulWidget {', 'color': _clAccentIndigo},
    {'label': 'Fields', 'code': '  final String hint;\n  final ValueChanged<String>? onChanged;', 'color': _clAccentBlue},
    {'label': 'Constructor', 'code': '  const SearchBar({super.key, this.hint = "Search...", this.onChanged});', 'color': _clAccentGreen},
    {'label': 'createState()', 'code': '  @override\n  State<SearchBar> createState() => _SearchBarState();', 'color': _clAccentPurple},
    {'label': 'State class', 'code': 'class _SearchBarState extends State<SearchBar> {', 'color': _clTerracotta},
    {'label': 'State fields', 'code': '  late final TextEditingController _ctrl;\n  bool _hasText = false;', 'color': _clAccentTeal},
    {'label': 'initState()', 'code': '  @override void initState() {\n    super.initState();\n    _ctrl = TextEditingController();\n  }', 'color': _clAccentBlue},
    {'label': 'dispose()', 'code': '  @override void dispose() {\n    _ctrl.dispose();\n    super.dispose();\n  }', 'color': _clDarkCotta},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _clLinen,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _clLightCotta),
    ),
    child: Column(
      children: sections.map((s) {
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: (s['color'] as Color).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(s['label'] as String,
                      style: TextStyle(
                          color: s['color'] as Color,
                          fontSize: 9,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0E5),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: _clLightCotta.withValues(alpha: 0.5)),
                  ),
                  child: Text(s['code'] as String,
                      style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 9.5,
                          color: _clDarkCotta,
                          height: 1.4)),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Best practices grid
// ─────────────────────────────────────────────────────────────
Widget _buildBestPracticesGrid() {
  final practices = <Map<String, dynamic>>[
    {'do': 'Use const constructors', 'why': 'Enables compile-time optimization', 'icon': Icons.check_circle, 'color': _clAccentGreen},
    {'do': 'Make fields final', 'why': 'Widget immutability contract', 'icon': Icons.lock, 'color': _clAccentBlue},
    {'do': 'Prefer composition', 'why': 'Shallow inheritance trees', 'icon': Icons.layers, 'color': _clAccentPurple},
    {'do': 'Dispose resources', 'why': 'Prevent memory leaks', 'icon': Icons.delete_sweep, 'color': _clAccentTeal},
    {'do': 'Keep build() pure', 'why': 'No side effects in render', 'icon': Icons.spa, 'color': _clTerracotta},
    {'do': 'Extract subwidgets', 'why': 'Granular rebuilds', 'icon': Icons.dashboard, 'color': _clAccentIndigo},
  ];

  return Column(
    children: practices.map((p) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (p['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: (p['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(p['icon'] as IconData,
                size: 20, color: p['color'] as Color),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['do'] as String,
                      style: TextStyle(
                          color: p['color'] as Color,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700)),
                  Text(p['why'] as String,
                      style: const TextStyle(
                          color: _clDarkText,
                          fontSize: 10,
                          height: 1.3)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _clSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _clWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _clWhite.withValues(alpha: 0.95),
                  fontSize: 12.5)),
        ),
      ],
    ),
  );
}
