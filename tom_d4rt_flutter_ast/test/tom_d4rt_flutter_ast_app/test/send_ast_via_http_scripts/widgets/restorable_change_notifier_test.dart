// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — RestorableChangeNotifier
// Demonstrates RestorableChangeNotifier — the abstract base class for
// wrapping ChangeNotifier instances in the state restoration framework.
// Covers the restoration lifecycle, RestorableTextEditingController as
// a concrete subclass, custom implementation patterns, and how the
// framework auto-disposes the wrapped notifier.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableChangeNotifier Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.restore,
      'title': 'Restorable ChangeNotifier Wrapper',
      'body': 'RestorableChangeNotifier<T extends ChangeNotifier> is '
          'an abstract class that bridges ChangeNotifier instances '
          'with Flutter\'s state restoration system. It serializes '
          'notifier state so it survives process death on mobile.',
      'accent': Color(0xFF37474F),
    },
    {
      'icon': Icons.save_alt,
      'title': 'Automatic Serialization',
      'body': 'Subclasses implement toPrimitives() to encode the notifier '
          'state as a serializable object (String, List, Map, etc.) and '
          'fromPrimitives() to rebuild it. The framework calls these '
          'during save and restore cycles.',
      'accent': Color(0xFFC62828),
    },
    {
      'icon': Icons.delete_sweep,
      'title': 'Auto-Disposal',
      'body': 'When the RestorableProperty is disposed (widget removed), '
          'it automatically disposes the wrapped ChangeNotifier. This '
          'prevents listener leaks without manual cleanup code.',
      'accent': Color(0xFF37474F),
    },
    {
      'icon': Icons.link,
      'title': 'Listener Forwarding',
      'body': 'RestorableChangeNotifier (via RestorableListenable) '
          'listens to the wrapped notifier and calls notifyListeners() '
          'on itself when the value changes. This lets the restoration '
          'framework track state mutations.',
      'accent': Color(0xFFC62828),
    },
  ];

  print('  Cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: Class Hierarchy
  // ============================================================
  print('=== Section 2: Class Hierarchy ===');

  final hierarchy = <Map<String, dynamic>>[
    {
      'class': 'RestorableProperty<T>',
      'depth': 0,
      'description': 'Base: registers with RestorationMixin, '
          'serializes/deserializes via primitives',
      'color': Colors.grey[600]!,
    },
    {
      'class': 'RestorableListenable<T>',
      'depth': 1,
      'description': 'Adds ChangeNotifier forwarding — listens to '
          'wrapped value, auto-disposes it',
      'color': Color(0xFF37474F),
    },
    {
      'class': 'RestorableChangeNotifier<T>',
      'depth': 2,
      'description': 'Narrows T to ChangeNotifier — the abstract '
          'base you subclass for custom notifiers',
      'color': Color(0xFFC62828),
    },
    {
      'class': 'RestorableTextEditingController',
      'depth': 3,
      'description': 'Concrete: wraps TextEditingController, '
          'serializes text + selection + composing',
      'color': Color(0xFF37474F),
    },
  ];

  print('  Hierarchy: ${hierarchy.length}');

  // ============================================================
  // SECTION 3: Restoration Lifecycle
  // ============================================================
  print('=== Section 3: Restoration Lifecycle ===');

  final lifecycle = <Map<String, dynamic>>[
    {
      'step': '1',
      'phase': 'registerForRestoration()',
      'description': 'The State mixin (RestorationMixin) registers '
          'the RestorableChangeNotifier with a restoration ID. '
          'The framework tracks this property.',
      'color': Color(0xFF37474F),
    },
    {
      'step': '2',
      'phase': 'createDefaultValue()',
      'description': 'If no saved state exists, this is called to '
          'create a fresh ChangeNotifier with default values.',
      'color': Color(0xFFC62828),
    },
    {
      'step': '3',
      'phase': 'User interaction',
      'description': 'The ChangeNotifier mutates as the user interacts. '
          'Each mutation triggers notifyListeners() which the '
          'restoration framework observes.',
      'color': Color(0xFF37474F),
    },
    {
      'step': '4',
      'phase': 'toPrimitives()',
      'description': 'When the system needs to save state (app '
          'backgrounded, route pushed), it calls toPrimitives() '
          'to serialize the notifier to a primitive object.',
      'color': Color(0xFFC62828),
    },
    {
      'step': '5',
      'phase': 'Process death / restart',
      'description': 'The OS kills the app. Serialized primitives '
          'are preserved in the restoration bundle by the engine.',
      'color': Color(0xFF37474F),
    },
    {
      'step': '6',
      'phase': 'fromPrimitives(data)',
      'description': 'On restore, the framework calls fromPrimitives() '
          'with the saved data. A new ChangeNotifier is created '
          'and populated from the serialized state.',
      'color': Color(0xFFC62828),
    },
    {
      'step': '7',
      'phase': 'dispose()',
      'description': 'When the widget is removed, the property auto-'
          'disposes the wrapped ChangeNotifier, cleaning up '
          'listeners and resources.',
      'color': Color(0xFF37474F),
    },
  ];

  print('  Lifecycle steps: ${lifecycle.length}');

  // ============================================================
  // SECTION 4: RestorableTextEditingController
  // ============================================================
  print('=== Section 4: Concrete Example ===');

  final rtecProperties = <Map<String, dynamic>>[
    {
      'property': 'text',
      'serialized': 'String',
      'description': 'The plain text content of the TextEditingController.',
      'color': Color(0xFF37474F),
    },
    {
      'property': 'selection',
      'serialized': 'List<int> (start, end)',
      'description': 'TextSelection range — cursor position or highlighted '
          'range, serialized as [start, end].',
      'color': Color(0xFFC62828),
    },
    {
      'property': 'composing',
      'serialized': 'List<int> (start, end)',
      'description': 'Composing region for IME input — the range undergoing '
          'composition, also serialized as [start, end].',
      'color': Color(0xFF37474F),
    },
  ];

  final rtecCode = '''// Using RestorableTextEditingController:
class _MyFormState extends State<MyForm>
    with RestorationMixin {
  // 1. Declare the restorable property
  final _name = RestorableTextEditingController();
  final _email = RestorableTextEditingController(
    text: 'user@example.com',
  );

  @override
  String get restorationId => 'my_form';

  @override
  void restoreState(
    RestorationBucket? old,
    bool initialRestore,
  ) {
    // 2. Register for restoration
    registerForRestoration(_name, 'name');
    registerForRestoration(_email, 'email');
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // 3. Use .value to get the controller
      TextField(controller: _name.value),
      TextField(controller: _email.value),
    ]);
  }

  @override
  void dispose() {
    _name.dispose(); // auto-disposes controller
    _email.dispose();
    super.dispose();
  }
}''';

  print('  RTEC properties: ${rtecProperties.length}');

  // ============================================================
  // SECTION 5: Custom Implementation
  // ============================================================
  print('=== Section 5: Custom Implementation ===');

  final customCode = '''// Custom RestorableChangeNotifier for a counter:
class CounterNotifier extends ChangeNotifier {
  int _count;
  CounterNotifier([this._count = 0]);

  int get count => _count;
  void increment() { _count++; notifyListeners(); }
  void reset() { _count = 0; notifyListeners(); }
}

class RestorableCounter
    extends RestorableChangeNotifier<CounterNotifier> {

  @override
  CounterNotifier createDefaultValue() =>
      CounterNotifier(0);

  @override
  CounterNotifier fromPrimitives(Object? data) =>
      CounterNotifier(data as int);

  @override
  Object toPrimitives() => value.count;
}''';

  final customUsage = '''// Register in a RestorationMixin State:
final _counter = RestorableCounter();

@override
void restoreState(
  RestorationBucket? old,
  bool initialRestore,
) {
  registerForRestoration(_counter, 'counter');
}

// Access the notifier:
Text('\${_counter.value.count}')

// Mutate (triggers save):
_counter.value.increment();''';

  print('  Custom implementation ready');

  // ============================================================
  // SECTION 6: What Gets Restored
  // ============================================================
  print('=== Section 6: What Gets Restored ===');

  final restorationExamples = <Map<String, dynamic>>[
    {
      'notifier': 'TextEditingController',
      'class': 'RestorableTextEditingController',
      'saves': 'text, selection, composing range',
      'icon': Icons.text_fields,
      'color': Color(0xFF37474F),
    },
    {
      'notifier': 'ScrollController',
      'class': 'RestorableScrollController (hypothetical)',
      'saves': 'scroll offset',
      'icon': Icons.swap_vert,
      'color': Color(0xFFC62828),
    },
    {
      'notifier': 'TabController',
      'class': 'Custom RestorableChangeNotifier',
      'saves': 'selected index',
      'icon': Icons.tab,
      'color': Color(0xFF37474F),
    },
    {
      'notifier': 'AnimationController',
      'class': 'Custom RestorableChangeNotifier',
      'saves': 'current value, velocity, direction',
      'icon': Icons.animation,
      'color': Color(0xFFC62828),
    },
    {
      'notifier': 'Custom ChangeNotifier',
      'class': 'Your RestorableChangeNotifier subclass',
      'saves': 'Whatever you serialize',
      'icon': Icons.settings,
      'color': Color(0xFF37474F),
    },
  ];

  print('  Examples: ${restorationExamples.length}');

  // ============================================================
  // SECTION 7: Comparison with Other Restorables
  // ============================================================
  print('=== Section 7: Comparison ===');

  final comparison = <Map<String, dynamic>>[
    {
      'type': 'RestorableValue<T>',
      'for': 'Simple values (int, String, bool)',
      'disposal': 'No disposal needed',
      'listener': 'No internal listener',
      'color': Color(0xFF37474F),
    },
    {
      'type': 'RestorableListenable<T>',
      'for': 'Any Listenable',
      'disposal': 'Auto-disposes',
      'listener': 'Forwards changes',
      'color': Color(0xFFC62828),
    },
    {
      'type': 'RestorableChangeNotifier<T>',
      'for': 'ChangeNotifier subclasses',
      'disposal': 'Auto-disposes',
      'listener': 'Forwards changes',
      'color': Color(0xFF37474F),
    },
    {
      'type': 'RestorableEnum<T>',
      'for': 'Enum values',
      'disposal': 'No disposal needed',
      'listener': 'No internal listener',
      'color': Color(0xFFC62828),
    },
  ];

  print('  Comparison: ${comparison.length}');

  // ============================================================
  // SECTION 8: Best Practices
  // ============================================================
  print('=== Section 8: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Keep Primitives Small',
      'detail': 'toPrimitives() should return compact data — avoid '
          'serializing large collections. The restoration bundle '
          'has limited space and is saved synchronously.',
      'icon': Icons.compress,
      'color': Color(0xFF37474F),
    },
    {
      'title': 'Idempotent Restoration',
      'detail': 'fromPrimitives() may be called multiple times if '
          'the restoration data changes. Ensure it produces a '
          'consistent notifier regardless of call count.',
      'icon': Icons.replay,
      'color': Color(0xFFC62828),
    },
    {
      'title': 'Always Dispose the Property',
      'detail': 'Call dispose() on the RestorableChangeNotifier in '
          'your State\'s dispose(). Even though the notifier is '
          'auto-disposed, the property itself needs cleanup.',
      'icon': Icons.cleaning_services,
      'color': Color(0xFF37474F),
    },
    {
      'title': 'Use restorationId',
      'detail': 'Each property needs a unique ID within its '
          'RestorationMixin scope. Use descriptive names like '
          '\'name_field\' rather than \'r1\', \'r2\'.',
      'icon': Icons.badge,
      'color': Color(0xFFC62828),
    },
    {
      'title': 'Test Restoration Round-trips',
      'detail': 'Write tests that serialize via toPrimitives() then '
          'restore via fromPrimitives() and verify equality. '
          'Catches serialization bugs early.',
      'icon': Icons.science,
      'color': Color(0xFF37474F),
    },
  ];

  print('  Practices: ${practices.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF37474F), Color(0xFFC62828)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.restore, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text('RestorableChangeNotifier',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(
                'The abstract base class that bridges ChangeNotifier '
                'instances with state restoration — serializing mutable '
                'objects so they survive process death and rebuild.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.lightbulb_outline, Color(0xFF37474F)),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: Class Hierarchy ----
        _sectionHeader('2. Class Hierarchy', Icons.account_tree, Color(0xFFC62828)),
        SizedBox(height: 10),
        ...hierarchy.map((h) => Padding(
              padding: EdgeInsets.only(left: (h['depth'] as int) * 20.0, bottom: 6),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: (h['color'] as Color).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(left: BorderSide(
                    color: h['color'] as Color,
                    width: h['class'] == 'RestorableChangeNotifier<T>' ? 4 : 2,
                  )),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(h['class'] as String,
                        style: TextStyle(
                          fontWeight: h['class'] == 'RestorableChangeNotifier<T>' ? FontWeight.bold : FontWeight.w600,
                          fontFamily: 'monospace',
                          fontSize: h['class'] == 'RestorableChangeNotifier<T>' ? 14 : 12,
                          color: h['color'] as Color,
                        )),
                    SizedBox(height: 2),
                    Text(h['description'] as String,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Restoration Lifecycle ----
        _sectionHeader('3. Restoration Lifecycle', Icons.timeline, Color(0xFF37474F)),
        SizedBox(height: 10),
        ...List.generate(lifecycle.length, (i) {
          final lc = lifecycle[i];
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: lc['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(lc['step'] as String,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (lc['color'] as Color).withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border(left: BorderSide(color: lc['color'] as Color, width: 3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lc['phase'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace',
                                  fontSize: 12, color: lc['color'] as Color)),
                          SizedBox(height: 3),
                          Text(lc['description'] as String,
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (i < lifecycle.length - 1)
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(Icons.arrow_downward, size: 14, color: Colors.grey[400]),
                ),
            ],
          );
        }),

        SizedBox(height: 20),

        // ---- Section 4: RestorableTextEditingController ----
        _sectionHeader('4. RestorableTextEditingController', Icons.text_fields, Color(0xFFC62828)),
        SizedBox(height: 10),
        Text('Properties serialized by the built-in implementation:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        ...rtecProperties.map((rp) => Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: rp['color'] as Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(rp['property'] as String,
                          style: TextStyle(color: Colors.white, fontFamily: 'monospace',
                              fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('→ ${rp['serialized']}',
                          style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(rp['description'] as String,
                          style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ),
            )),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(rtecCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFEF9A9A))),
        ),

        SizedBox(height: 20),

        // ---- Section 5: Custom Implementation ----
        _sectionHeader('5. Custom Implementation', Icons.code, Color(0xFF37474F)),
        SizedBox(height: 10),
        Text('Building a restorable counter notifier from scratch:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(customCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF90A4AE))),
        ),
        SizedBox(height: 12),
        Text('Registering and using it:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(customUsage,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFEF9A9A))),
        ),

        SizedBox(height: 20),

        // ---- Section 6: What Gets Restored ----
        _sectionHeader('6. What Gets Restored', Icons.inventory_2, Color(0xFFC62828)),
        SizedBox(height: 10),
        ...restorationExamples.map((re) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (re['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: re['color'] as Color, width: 3)),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(re['icon'] as IconData, color: re['color'] as Color, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(re['notifier'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 2),
                          Text(re['class'] as String,
                              style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: re['color'] as Color)),
                          SizedBox(height: 2),
                          Text('Saves: ${re['saves']}',
                              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 7: Comparison ----
        _sectionHeader('7. vs Other Restorables', Icons.compare_arrows, Color(0xFF37474F)),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Color(0xFF37474F),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Type',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('For',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Disposal',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Listener',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(comparison.length, (i) {
                final c = comparison[i];
                return Container(
                  color: i.isEven ? Colors.white : Color(0xFFECEFF1),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text(c['type'] as String,
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'monospace'))),
                      Expanded(flex: 3, child: Text(c['for'] as String,
                          style: TextStyle(fontSize: 10))),
                      Expanded(flex: 2, child: Text(c['disposal'] as String,
                          style: TextStyle(fontSize: 10))),
                      Expanded(flex: 2, child: Text(c['listener'] as String,
                          style: TextStyle(fontSize: 10))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 8: Best Practices ----
        _sectionHeader('8. Best Practices', Icons.tips_and_updates, Color(0xFFC62828)),
        SizedBox(height: 10),
        ...practices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(p['icon'] as IconData, color: p['color'] as Color, size: 18),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 3),
                          Text(p['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.restore, color: Color(0xFFC62828), size: 28),
              SizedBox(height: 6),
              Text(
                'RestorableChangeNotifier: serialize, restore, and '
                'auto-dispose ChangeNotifier state — letting mutable '
                'objects survive process death transparently.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
