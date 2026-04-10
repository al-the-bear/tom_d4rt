// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

/// Deep visual demo — RestorationMixin
///
/// RestorationMixin is the mixin applied to State objects that need to persist
/// and restore their UI state across process restarts (Android backgrounding,
/// web page navigation, etc.). It integrates with the framework's restoration
/// bucket hierarchy to save and restore RestorableProperty values.
///
/// Sections
/// ─────────
/// 1. Why state restoration matters
/// 2. RestorationMixin anatomy — restorationId, restoreState, registerForRestoration
/// 3. RestorableProperty types — RestorableInt, RestorableBool, RestorableString, etc.
/// 4. RestorationBucket hierarchy
/// 5. Restoration lifecycle
/// 6. Live restoration demo — counter with multiple restorable properties
/// 7. Writing custom RestorableProperty
/// 8. Common pitfalls and best practices

// ─── palette ───────────────────────────────────────────────
const _kLime       = Color(0xFFCDDC39);
const _kLimeLight  = Color(0xFFF0F4C3);
const _kLimeDark   = Color(0xFF827717);
const _kRed        = Color(0xFFF44336);
const _kRedLight   = Color(0xFFFFCDD2);
const _kRedDark    = Color(0xFFB71C1C);
const _kSurface    = Color(0xFFFCFCF5);
const _kDivider    = Color(0xFFE0E0E0);
const _kTextDark   = Color(0xFF212121);
const _kTextMuted  = Color(0xFF757575);

// ─── 1. Why it matters ─────────────────────────────────────
const _kWhyItMatters = <String, String>{
  'Android process death':
      'Android can kill your app process at any time when it\'s in the background. '
      'When the user returns, the system recreates the activity from scratch. '
      'Without state restoration, the user loses their place.',
  'Web navigation':
      'The browser\'s back/forward buttons may recreate the Flutter web app from '
      'scratch. Restoration preserves the user\'s scroll position, form inputs, '
      'and navigation stack.',
  'Low-memory scenarios':
      'Any platform can reclaim memory by destroying inactive UI state. The '
      'restoration framework provides a structured way to serialize and '
      'reconstruct that state.',
  'User expectations':
      'Users expect apps to "remember" where they were. A good restoration '
      'implementation is invisible — the app simply works as expected after '
      'returning from the background.',
};

// ─── 2. Anatomy ────────────────────────────────────────────
class _MixinMember {
  const _MixinMember(this.name, this.signature, this.description);
  final String name;
  final String signature;
  final String description;
}

const _kMixinMembers = <_MixinMember>[
  _MixinMember('restorationId', 'String? get restorationId',
      'Override to return a unique ID for this widget\'s restoration data. '
      'Return null to disable restoration entirely. The ID must be unique '
      'within the parent restoration scope.'),
  _MixinMember('restoreState', 'void restoreState(RestorationBucket? oldBucket, bool initialRestore)',
      'Called when restoration data is available. Register all restorable '
      'properties here using registerForRestoration(). initialRestore is true '
      'the first time and false when the bucket changes.'),
  _MixinMember('registerForRestoration', 'void registerForRestoration(RestorableProperty, String restorationId)',
      'Links a RestorableProperty to the restoration bucket under the given ID. '
      'If stored data exists for that ID, the property\'s value is restored. '
      'Otherwise, the property keeps its default.'),
  _MixinMember('bucket', 'RestorationBucket? get bucket',
      'The current restoration bucket. Null when restoration is disabled '
      '(either restorationId is null or no RestorationScope exists above).'),
  _MixinMember('didToggleBucket', 'void didToggleBucket(RestorationBucket? oldBucket)',
      'Called when the bucket switches between null and non-null. Override '
      'to handle the transition — e.g., to reset properties when restoration '
      'becomes unavailable.'),
  _MixinMember('didUpdateRestorationId', 'void didUpdateRestorationId()',
      'Call this method when the restorationId getter would return a different '
      'value. The mixin will re-register with the parent scope.'),
];

// ─── 3. RestorableProperty types ───────────────────────────
class _RestorableType {
  const _RestorableType(this.name, this.dartType, this.defaultValue, this.note);
  final String name;
  final String dartType;
  final String defaultValue;
  final String note;
}

const _kRestorableTypes = <_RestorableType>[
  _RestorableType('RestorableInt', 'int', '0', 'Non-nullable integer'),
  _RestorableType('RestorableIntN', 'int?', 'null', 'Nullable integer'),
  _RestorableType('RestorableDouble', 'double', '0.0', 'Non-nullable double'),
  _RestorableType('RestorableDoubleN', 'double?', 'null', 'Nullable double'),
  _RestorableType('RestorableBool', 'bool', 'false', 'Non-nullable boolean'),
  _RestorableType('RestorableBoolN', 'bool?', 'null', 'Nullable boolean'),
  _RestorableType('RestorableString', 'String', '\'\'', 'Non-nullable string'),
  _RestorableType('RestorableStringN', 'String?', 'null', 'Nullable string'),
  _RestorableType('RestorableNum', 'num', '0', 'Generic num'),
  _RestorableType('RestorableDateTime', 'DateTime', 'DateTime.now()', 'Non-nullable date/time'),
  _RestorableType('RestorableDateTimeN', 'DateTime?', 'null', 'Nullable date/time'),
  _RestorableType('RestorableTextEditingController', 'TextEditingController', 'empty', 'Text field state'),
  _RestorableType('RestorableEnum', 'T extends Enum', 'first value', 'Enum by index'),
  _RestorableType('RestorableEnumN', 'T? extends Enum', 'null', 'Nullable enum'),
];

// ─── 4. Bucket hierarchy ───────────────────────────────────
const _kBucketHierarchy = <String>[
  'RootRestorationScope (provided by WidgetsApp / MaterialApp)',
  '  └─ RestorationScope (restorationId: "home")',
  '      └─ State with RestorationMixin (restorationId: "counter")',
  '          ├─ RestorableInt "count" → bucket["count"] = 42',
  '          ├─ RestorableBool "darkMode" → bucket["darkMode"] = true',
  '          └─ RestorableString "name" → bucket["name"] = "Alice"',
];

// ─── 5. Lifecycle ──────────────────────────────────────────
const _kLifecycleSteps = <String, String>{
  'initState':
      'RestorationMixin registers itself with the nearest RestorationScope. '
      'If a bucket is available, restoreState() is called immediately with '
      'initialRestore = true.',
  'restoreState (initial)':
      'You call registerForRestoration() for every RestorableProperty. '
      'Each property checks the bucket for stored data and restores it.',
  'setState / property change':
      'When you change a RestorableProperty\'s value, it automatically writes '
      'the new value into the bucket. No manual save needed.',
  'didUpdateWidget':
      'If the widget\'s restorationId changes, the mixin calls '
      'didUpdateRestorationId(), which re-registers with the parent scope.',
  'restoreState (bucket change)':
      'May be called again if the bucket itself changes (e.g., parent scope '
      'rebuilt). initialRestore will be false. Properties are re-registered.',
  'dispose':
      'The mixin de-registers from the parent scope and disposes all '
      'registered RestorableProperties.',
};

// ─── 8. Pitfalls ───────────────────────────────────────────
class _Pitfall {
  const _Pitfall(this.mistake, this.fix);
  final String mistake;
  final String fix;
}

const _kPitfalls = <_Pitfall>[
  _Pitfall(
    'Forgetting to set restorationId on MaterialApp',
    'MaterialApp(restorationScopeId: "app", ...) — without this, no '
    'RestorationScope exists and all restoration is silently disabled.',
  ),
  _Pitfall(
    'Duplicate restorationId within the same scope',
    'Each widget\'s restorationId must be unique among its siblings. '
    'Duplicate IDs cause data overwrite and unpredictable behavior.',
  ),
  _Pitfall(
    'Registering properties outside restoreState',
    'Always call registerForRestoration() inside restoreState(), not in '
    'initState(). The mixin needs the bucket to be ready first.',
  ),
  _Pitfall(
    'Not disposing RestorableProperties',
    'RestorationMixin auto-disposes registered properties, but if you create '
    'extra RestorableProperty instances manually, dispose them in dispose().',
  ),
  _Pitfall(
    'Storing non-serializable data',
    'Restoration data must be serializable to primitives (int, double, bool, '
    'String, List, Map). Complex objects need custom RestorableProperty.',
  ),
  _Pitfall(
    'Changing restorationId without calling didUpdateRestorationId',
    'If your restorationId is dynamic (depends on widget config), call '
    'didUpdateRestorationId() in didUpdateWidget when it changes.',
  ),
];

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kLimeDark, _kRedDark]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text, style: TextStyle(fontSize: 11, color: _kTextMuted, fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5, color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kRed, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('RestorationMixin deep visual demo');
  print('─' * 48);
  print('Sections: why, anatomy, property types, bucket hierarchy,');
  print('lifecycle, live demo, custom property, pitfalls.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    restorationScopeId: 'restoration_demo_app',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kLime, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('RestorationMixin'),
        backgroundColor: _kLimeDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _Body(),
    ),
  );
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with RestorationMixin {
  final RestorableInt _counter = RestorableInt(0);
  final RestorableBool _isDarkLabel = RestorableBool(false);
  final RestorableString _userName = RestorableString('');
  final RestorableDouble _sliderValue = RestorableDouble(0.5);

  @override
  String? get restorationId => 'restoration_demo_body';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_counter, 'counter');
    registerForRestoration(_isDarkLabel, 'isDarkLabel');
    registerForRestoration(_userName, 'userName');
    registerForRestoration(_sliderValue, 'sliderValue');
    print('[RestorationMixin] restoreState called — initial=$initialRestore');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        // ── Section 1: Why ──
        _sectionHeader('1 · Why State Restoration Matters', Icons.restore),
        SizedBox(height: 8),
        ..._kWhyItMatters.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.key,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: _kRedDark)),
              SizedBox(height: 4),
              Text(e.value, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 2: Anatomy ──
        _sectionHeader('2 · RestorationMixin Anatomy', Icons.build_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('MIXIN DEFINITION'),
              SizedBox(height: 8),
              _mono('mixin RestorationMixin<S extends StatefulWidget>'),
              _mono('    on State<S>'),
              SizedBox(height: 10),
              Text(
                'RestorationMixin is applied to a State class and provides the '
                'lifecycle hooks for saving and restoring UI state. It communicates '
                'with the RestorationScope above it in the tree to obtain a '
                'RestorationBucket — a key-value store for serializable data.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        ..._kMixinMembers.map((m) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kLimeLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(m.name,
                    style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                        fontSize: 12, color: _kLimeDark)),
              ),
              SizedBox(height: 6),
              _mono(m.signature, color: _kRedDark),
              SizedBox(height: 6),
              Text(m.description, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 3: Property types ──
        _sectionHeader('3 · RestorableProperty Types', Icons.inventory_2_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The framework provides RestorableProperty subclasses for all '
                'primitive types and some common controllers. Each wraps a value '
                'and knows how to serialize/deserialize it to/from the restoration '
                'bucket.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('BUILT-IN RESTORABLE TYPES'),
              SizedBox(height: 8),
              _buildRestorableTable(),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 4: Bucket hierarchy ──
        _sectionHeader('4 · RestorationBucket Hierarchy', Icons.account_tree_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Restoration data is organized in a tree of RestorationBuckets that '
                'mirrors the widget tree. Each widget with RestorationMixin gets its '
                'own bucket, scoped to its restorationId. The root bucket is provided '
                'by MaterialApp\'s restorationScopeId.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              ..._kBucketHierarchy.map((line) {
                final isValue = line.contains('→');
                final isLeaf = line.contains('├─') || line.contains('└─');
                return Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Text(line,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: isValue ? _kRedDark : (isLeaf ? _kLimeDark : _kTextDark),
                        fontWeight: isValue ? FontWeight.w700 : FontWeight.w400,
                      )),
                );
              }),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('BUCKET DATA FLOW'),
              SizedBox(height: 8),
              _bullet('Write: property.value = x → bucket["id"] = serialize(x)'),
              _bullet('Read: bucket["id"] → property.value = deserialize(data)'),
              _bullet('The platform serializes the root bucket to persistent storage'),
              _bullet('On restore, the platform provides the serialized bucket tree'),
              _bullet('Each RestorationMixin reads its sub-bucket by restorationId'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 5: Lifecycle ──
        _sectionHeader('5 · Restoration Lifecycle', Icons.loop),
        SizedBox(height: 8),
        ..._kLifecycleSteps.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kRedLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(e.key,
                    style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                        fontSize: 12, color: _kRedDark)),
              ),
              SizedBox(height: 6),
              Text(e.value, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 6: Live demo ──
        _sectionHeader('6 · Live Restoration Demo', Icons.play_circle_outline),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('THIS PAGE USES RestorationMixin — VALUES AUTO-PERSIST'),
              SizedBox(height: 8),
              Text(
                'All controls below are backed by RestorableProperty instances. '
                'In a real app, these values would survive process death and '
                'be automatically restored when the app restarts.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        // Counter
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('RestorableInt — COUNTER'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _circleButton(Icons.remove, () {
                    setState(() => _counter.value--);
                    print('[Demo] counter → ${_counter.value}');
                  }),
                  SizedBox(width: 24),
                  Text('${_counter.value}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: _isDarkLabel.value ? _kRedDark : _kLimeDark,
                      )),
                  SizedBox(width: 24),
                  _circleButton(Icons.add, () {
                    setState(() => _counter.value++);
                    print('[Demo] counter → ${_counter.value}');
                  }),
                ],
              ),
              SizedBox(height: 4),
              Center(child: _mono('bucket["counter"] = ${_counter.value}', color: _kTextMuted)),
            ],
          ),
        ),
        // Dark label toggle
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('RestorableBool — DARK LABEL'),
              SizedBox(height: 8),
              SwitchListTile(
                title: Text('Use dark label color',
                    style: TextStyle(fontSize: 14, color: _kTextDark)),
                value: _isDarkLabel.value,
                activeColor: _kRedDark,
                onChanged: (v) {
                  setState(() => _isDarkLabel.value = v);
                  print('[Demo] isDarkLabel → $v');
                },
              ),
              _mono('bucket["isDarkLabel"] = ${_isDarkLabel.value}', color: _kTextMuted),
            ],
          ),
        ),
        // User name
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('RestorableString — USER NAME'),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Type a name...',
                  border: OutlineInputBorder(),
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _kLimeDark, width: 2),
                  ),
                ),
                controller: TextEditingController(text: _userName.value),
                onChanged: (v) {
                  _userName.value = v;
                  print('[Demo] userName → "$v"');
                },
              ),
              SizedBox(height: 6),
              _mono('bucket["userName"] = "${_userName.value}"', color: _kTextMuted),
            ],
          ),
        ),
        // Slider
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('RestorableDouble — SLIDER'),
              SizedBox(height: 8),
              Slider(
                value: _sliderValue.value,
                min: 0, max: 1,
                activeColor: _kRedDark,
                onChanged: (v) {
                  setState(() => _sliderValue.value = v);
                  print('[Demo] sliderValue → ${v.toStringAsFixed(2)}');
                },
              ),
              _mono('bucket["sliderValue"] = ${_sliderValue.value.toStringAsFixed(3)}', color: _kTextMuted),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 7: Custom RestorableProperty ──
        _sectionHeader('7 · Writing a Custom RestorableProperty', Icons.extension_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'For types not covered by the built-in RestorableProperty classes, '
                'you extend RestorableValue<T> and implement createDefaultValue(), '
                'toPrimitives(), and fromPrimitives().',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              _mono('class RestorableColor extends RestorableValue<Color> {'),
              _mono('  RestorableColor(this._default);'),
              _mono('  final Color _default;'),
              _mono(''),
              _mono('  @override'),
              _mono('  Color createDefaultValue() => _default;'),
              _mono(''),
              _mono('  @override'),
              _mono('  void didUpdateValue(Color? oldValue) {'),
              _mono('    if (oldValue != value) notifyListeners();'),
              _mono('  }'),
              _mono(''),
              _mono('  @override'),
              _mono('  Object toPrimitives() => value.value;'),
              _mono(''),
              _mono('  @override'),
              _mono('  Color fromPrimitives(Object? data) {'),
              _mono('    return Color(data as int);'),
              _mono('  }'),
              _mono('}'),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('SERIALIZATION CONTRACT'),
              SizedBox(height: 8),
              _bullet('toPrimitives() must return int, double, bool, String, List, or Map'),
              _bullet('fromPrimitives() receives exactly what toPrimitives() produced'),
              _bullet('The framework handles null values automatically'),
              _bullet('Lists and Maps must contain only primitive types (recursive)'),
              _bullet('Complex objects: serialize to Map<String, Object>'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 8: Pitfalls ──
        _sectionHeader('8 · Common Pitfalls & Best Practices', Icons.warning_amber_outlined),
        SizedBox(height: 8),
        ..._kPitfalls.map((p) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.cancel_outlined, color: _kRedDark, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(p.mistake,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: _kRedDark)),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: _kLimeDark, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(p.fix,
                        style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
                  ),
                ],
              ),
            ],
          ),
        )),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('KEY TAKEAWAY'),
              SizedBox(height: 6),
              Text(
                'RestorationMixin gives your State objects amnesia insurance. '
                'By registering RestorableProperty instances in restoreState(), '
                'you let the framework automatically serialize and restore your '
                'UI state across process boundaries. The pattern is clean: declare '
                'properties, register them once, and let the framework handle '
                'persistence. The most common mistake is forgetting to set '
                'restorationScopeId on MaterialApp.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: _kLimeLight,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 44, height: 44,
          alignment: Alignment.center,
          child: Icon(icon, color: _kLimeDark, size: 22),
        ),
      ),
    );
  }

  Widget _buildRestorableTable() {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(2.5),
        1: FlexColumnWidth(1.2),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1.5),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      border: TableBorder.all(color: _kDivider, width: 0.5),
      children: [
        TableRow(
          decoration: BoxDecoration(color: _kLimeLight.withOpacity(0.5)),
          children: ['Class', 'Type', 'Default', 'Note'].map((h) => Padding(
            padding: EdgeInsets.all(5),
            child: Text(h, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.5, color: _kLimeDark)),
          )).toList(),
        ),
        ..._kRestorableTypes.map((r) => TableRow(
          children: [r.name, r.dartType, r.defaultValue, r.note].map((c) => Padding(
            padding: EdgeInsets.all(5),
            child: Text(c, style: TextStyle(fontSize: 10.5, color: _kTextDark)),
          )).toList(),
        )),
      ],
    );
  }
}
