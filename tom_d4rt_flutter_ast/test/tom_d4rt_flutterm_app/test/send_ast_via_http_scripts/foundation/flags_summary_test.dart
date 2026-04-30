// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Deep demo of FlagsSummary<T> from foundation
// FlagsSummary extends DiagnosticsProperty<Map<String, T?>> and summarizes
// a map of named flags, showing only non-null entries. Empty or all-null
// maps produce hidden-level properties that are filtered from output.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlagsSummary deep demo executing');

  // ============================================================
  // SECTION 1: Overview Banner
  // ============================================================
  print('=== Section 1: Overview ===');

  Widget fsBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFAD1457), Color(0xFFD81B60), Color(0xFFEC407A)],
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      children: [
        Icon(Icons.flag, color: Colors.white, size: 44.0),
        SizedBox(height: 8.0),
        Text('FlagsSummary<T>', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text('extends DiagnosticsProperty<Map<String, T?>>', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'monospace')),
        ),
        SizedBox(height: 8.0),
        Text(
          'Summarizes a map of named flags, displaying only non-null entries. Empty or all-null maps are automatically hidden from diagnostics output.',
          style: TextStyle(fontSize: 12.0, color: Colors.white.withValues(alpha: 0.9)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Class Anatomy
  // ============================================================
  print('=== Section 2: Class Anatomy ===');

  Widget fsAnatomyRow(String member, String signature, String desc, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border(left: BorderSide(color: accent, width: 3.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(member, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: accent)),
              Spacer(),
              Text(signature, style: TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: Colors.grey.shade700)),
            ],
          ),
          SizedBox(height: 4.0),
          Text(desc, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 3: Basic Boolean Flags
  // ============================================================
  print('=== Section 3: Boolean Flags ===');
  final fsBoolFlags = FlagsSummary<bool>(
    'widgetState',
    <String, bool?>{
      'enabled': true,
      'visible': true,
      'selected': false,
      'focused': true,
      'hovered': null,
    },
  );
  print('Bool flags: ${fsBoolFlags.value}');
  print('valueToString: ${fsBoolFlags.valueToString()}');
  print('level: ${fsBoolFlags.level}');

  Widget fsFlagChip(String name, dynamic value, Color color) {
    final isNull = value == null;
    return Container(
      margin: EdgeInsets.all(3.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: isNull ? Colors.grey.shade200 : color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: isNull ? Colors.grey.shade400 : color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isNull ? Icons.remove_circle_outline : (value == true ? Icons.check_circle : Icons.cancel),
            size: 14.0,
            color: isNull ? Colors.grey : color,
          ),
          SizedBox(width: 6.0),
          Text(name, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: isNull ? Colors.grey : color)),
          if (!isNull) ...[
            SizedBox(width: 4.0),
            Text('= $value', style: TextStyle(fontFamily: 'monospace', fontSize: 10.0, color: Colors.grey.shade700)),
          ] else
            Text(' (null)', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 4: Non-Null Filtering
  // ============================================================
  print('=== Section 4: Non-Null Filtering ===');
  final fsNonNull = fsBoolFlags.value.entries.where((e) => e.value != null).toList();
  final fsNullEntries = fsBoolFlags.value.entries.where((e) => e.value == null).toList();
  print('Non-null entries: ${fsNonNull.length}');
  print('Null entries: ${fsNullEntries.length}');

  Widget fsFilterSection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFF48FB1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.filter_list, color: Color(0xFFAD1457), size: 22.0),
            SizedBox(width: 8.0),
            Text('Non-Null Filtering', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xFFAD1457))),
          ],
        ),
        SizedBox(height: 4.0),
        Text('FlagsSummary only displays entries where value != null. Null entries are silently excluded.', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    Text('Shown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.green.shade700)),
                    Text('${fsNonNull.length} entries', style: TextStyle(fontFamily: 'monospace', fontSize: 14.0)),
                    ...fsNonNull.map((e) => Text('${e.key}: ${e.value}', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace'))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    Text('Filtered', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.grey.shade600)),
                    Text('${fsNullEntries.length} entries', style: TextStyle(fontFamily: 'monospace', fontSize: 14.0)),
                    ...fsNullEntries.map((e) => Text('${e.key}: null', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Empty Flags
  // ============================================================
  print('=== Section 5: Empty Flags ===');
  final fsEmpty = FlagsSummary<String>('emptyFlags', <String, String?>{});
  print('Empty: level=${fsEmpty.level}, isHidden=${fsEmpty.level == DiagnosticLevel.hidden}');

  Widget fsEmptySection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.visibility_off, color: Colors.grey.shade600, size: 22.0),
            SizedBox(width: 8.0),
            Text('Empty Flags → Hidden', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.grey.shade700)),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            children: [
              Text('FlagsSummary("emptyFlags", {})', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
              SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_downward, color: Colors.grey, size: 16.0),
                ],
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4.0)),
                child: Text('level = DiagnosticLevel.hidden', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.grey.shade700)),
              ),
              SizedBox(height: 4.0),
              Text('Automatically filtered from toString output', style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: All-Null Flags
  // ============================================================
  print('=== Section 6: All-Null Flags ===');
  final fsAllNull = FlagsSummary<int>('nullFlags', <String, int?>{'a': null, 'b': null, 'c': null});
  print('All-null: level=${fsAllNull.level}');

  final fsWithIfEmpty = FlagsSummary<int>('nullFlags', <String, int?>{'a': null, 'b': null}, ifEmpty: 'no flags set');
  print('With ifEmpty: ${fsWithIfEmpty.valueToString()}');

  // ============================================================
  // SECTION 7: ifEmpty Parameter
  // ============================================================
  print('=== Section 7: ifEmpty ===');

  Widget fsIfEmptySection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, color: Colors.indigo.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('ifEmpty Parameter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.indigo.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Customizes what appears when no flags have non-null values:', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Without ifEmpty:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
              Text('level → hidden (filtered out)', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.grey.shade700)),
              SizedBox(height: 8.0),
              Text('With ifEmpty: "no flags set":', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
              Text('valueToString → "${fsWithIfEmpty.valueToString()}"', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.indigo)),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Integer (Numeric) Flags
  // ============================================================
  print('=== Section 8: Numeric Flags ===');
  final fsIntFlags = FlagsSummary<int>(
    'metrics',
    <String, int?>{
      'width': 100,
      'height': 200,
      'depth': null,
      'layers': 3,
    },
    level: DiagnosticLevel.info,
  );
  print('Int flags: ${fsIntFlags.valueToString()}');

  // ============================================================
  // SECTION 9: String Flags
  // ============================================================
  print('=== Section 9: String Flags ===');
  final fsStringFlags = FlagsSummary<String>(
    'labels',
    <String, String?>{
      'title': 'Hello',
      'subtitle': null,
      'footer': 'World',
    },
  );
  print('String flags: ${fsStringFlags.valueToString()}');

  // ============================================================
  // SECTION 10: Level Control
  // ============================================================
  print('=== Section 10: Level Control ===');
  final fsDebugFlags = FlagsSummary<bool>('debugFlags', {'verbose': true}, level: DiagnosticLevel.debug);
  final fsWarningFlags = FlagsSummary<bool>('warnFlags', {'overflow': true}, level: DiagnosticLevel.warning);
  print('debug level: ${fsDebugFlags.level}');
  print('warning level: ${fsWarningFlags.level}');

  Widget fsLevelRow(String name, DiagnosticLevel level, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.0),
        border: Border(left: BorderSide(color: color, width: 3.0)),
      ),
      child: Row(
        children: [
          Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: color)),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4.0)),
            child: Text(level.name, style: TextStyle(fontFamily: 'monospace', fontSize: 10.0, fontWeight: FontWeight.bold, color: color)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 11: showName and showSeparator
  // ============================================================
  print('=== Section 11: showName / showSeparator ===');
  final fsShowName = FlagsSummary<bool>('flags', {'a': true}, showName: true, showSeparator: true);
  final fsHideName = FlagsSummary<bool>('flags', {'a': true}, showName: false);
  print('showName=true: ${fsShowName.toString()}');
  print('showName=false: ${fsHideName.toString()}');

  // ============================================================
  // SECTION 12: toString and toStringDeep
  // ============================================================
  print('=== Section 12: toString ===');
  print('toString: ${fsBoolFlags.toString()}');
  print('toStringDeep: ${fsBoolFlags.toStringDeep().trim()}');

  Widget fsToStringSection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_snippet, color: Colors.orange.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('String Representations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.orange.shade800)),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('toString():', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: Colors.orange.shade700)),
              Text(fsBoolFlags.toString(), style: TextStyle(fontFamily: 'monospace', fontSize: 10.5)),
              SizedBox(height: 8.0),
              Text('toStringDeep():', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: Colors.orange.shade700)),
              Text(fsBoolFlags.toStringDeep().trim(), style: TextStyle(fontFamily: 'monospace', fontSize: 10.5)),
              SizedBox(height: 8.0),
              Text('valueToString():', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: Colors.orange.shade700)),
              Text(fsBoolFlags.valueToString(), style: TextStyle(fontFamily: 'monospace', fontSize: 10.5)),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 13: JSON Serialization
  // ============================================================
  print('=== Section 13: JSON ===');
  final fsDelegate = DiagnosticsSerializationDelegate();
  final fsJson = fsBoolFlags.toJsonMap(fsDelegate);
  print('JSON keys: ${fsJson.keys.toList()}');
  print('Has name: ${fsJson.containsKey("name")}');
  print('Has type: ${fsJson.containsKey("type")}');

  Widget fsJsonSection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.data_object, color: Colors.green.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('toJsonMap() Output', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.green.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Serializes flag data for DevTools and debugging tools:', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        ...fsJson.entries.take(8).map((entry) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 1.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              children: [
                SizedBox(width: 100.0, child: Text('"${entry.key}"', style: TextStyle(fontFamily: 'monospace', fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.green.shade700))),
                Text(': ', style: TextStyle(color: Colors.grey)),
                Expanded(child: Text('${entry.value}', style: TextStyle(fontFamily: 'monospace', fontSize: 10.0), overflow: TextOverflow.ellipsis)),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ============================================================
  // SECTION 14: Inheritance Chain
  // ============================================================
  print('=== Section 14: Inheritance ===');
  print('is DiagnosticsProperty: true (extends it)');
  print('is DiagnosticsNode: true (transitive)');

  Widget fsInheritRow(String className, String role, int indent, Color color, bool current) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 20.0, top: 3.0, bottom: 3.0),
      child: Row(
        children: [
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: current ? color : Colors.grey.shade400,
              shape: BoxShape.circle,
              border: current ? Border.all(color: Color.lerp(color, Colors.black, 0.3)!, width: 2.0) : null,
            ),
          ),
          SizedBox(width: 8.0),
          Text(className, style: TextStyle(fontWeight: current ? FontWeight.bold : FontWeight.w500, fontSize: 12.0, color: current ? color : Colors.grey.shade700)),
          SizedBox(width: 6.0),
          Text(role, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 15: Real-World Widget Flags
  // ============================================================
  print('=== Section 15: Real-World ===');

  Widget fsUseCaseRow(String widget, String flags, IconData icon, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border(left: BorderSide(color: accent, width: 3.0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent, size: 18.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: accent)),
                Text(flags, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 16: Summary Dashboard
  // ============================================================
  print('=== Section 16: Summary ===');

  Widget fsSummaryTile(String label, String value, Color bg, Color text) {
    return Container(
      width: 95.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: text)),
          SizedBox(height: 2.0),
          Text(label, style: TextStyle(fontSize: 9.5, color: text.withValues(alpha: 0.7)), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  print('FlagsSummary deep demo completed');

  // ============================================================
  // ASSEMBLE FULL UI
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FlagsSummary<T> Deep Demo'),
        backgroundColor: Color(0xFFAD1457),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1
            fsBanner,

            // Section 2: Anatomy
            SizedBox(height: 20.0),
            Text('2. Class Anatomy', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 8.0),
            fsAnatomyRow('FlagsSummary()', 'name, Map<String, T?>, ...', 'Constructor taking a name and map of flags', Color(0xFFD81B60)),
            fsAnatomyRow('.value', 'Map<String, T?>', 'The raw flag map (includes null entries)', Color(0xFFD81B60)),
            fsAnatomyRow('.valueToString()', 'String', 'Comma-separated non-null flag names', Color(0xFFD81B60)),
            fsAnatomyRow('.level', 'DiagnosticLevel', 'Hidden if empty/all-null, else user-specified', Color(0xFFD81B60)),
            fsAnatomyRow('.ifEmpty', 'String?', 'Custom text when no flags are non-null', Color(0xFFD81B60)),
            fsAnatomyRow('.toJsonMap()', 'Map<String, Object?>', 'Serialization for DevTools', Color(0xFFD81B60)),

            // Section 3: Bool flags
            SizedBox(height: 20.0),
            Text('3. Boolean Flags', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 4.0),
            Text('Widget state flags — the most common use case:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            Wrap(
              children: fsBoolFlags.value.entries.map((e) => fsFlagChip(e.key, e.value, Color(0xFFD81B60))).toList(),
            ),

            // Section 4: Filtering
            SizedBox(height: 20.0),
            Text('4. Non-Null Filtering', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 4.0),
            fsFilterSection,

            // Section 5: Empty
            SizedBox(height: 20.0),
            Text('5. Empty Flags', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 4.0),
            fsEmptySection,

            // Section 6: All-null
            SizedBox(height: 20.0),
            Text('6. All-Null Flags', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Map: {a: null, b: null, c: null}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                  SizedBox(height: 4.0),
                  Text('Level: ${fsAllNull.level.name}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.grey.shade600)),
                  Text('Treated same as empty — all filtered away', style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
                ],
              ),
            ),

            // Section 7: ifEmpty
            SizedBox(height: 20.0),
            Text('7. ifEmpty Parameter', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 4.0),
            fsIfEmptySection,

            // Section 8: Int flags
            SizedBox(height: 20.0),
            Text('8. Numeric Flags', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 8.0),
            Wrap(
              children: fsIntFlags.value.entries.map((e) => fsFlagChip(e.key, e.value, Color(0xFF1565C0))).toList(),
            ),
            SizedBox(height: 6.0),
            Text('Output: ${fsIntFlags.valueToString()}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.grey.shade700)),

            // Section 9: String flags
            SizedBox(height: 20.0),
            Text('9. String Flags', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 8.0),
            Wrap(
              children: fsStringFlags.value.entries.map((e) => fsFlagChip(e.key, e.value, Color(0xFF2E7D32))).toList(),
            ),
            SizedBox(height: 6.0),
            Text('Output: ${fsStringFlags.valueToString()}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.grey.shade700)),

            // Section 10: Level control
            SizedBox(height: 20.0),
            Text('10. Level Control', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 4.0),
            Text('Override the diagnostic level for different severity contexts:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            fsLevelRow('Default (info)', fsBoolFlags.level, Color(0xFF66BB6A)),
            fsLevelRow('Debug flags', fsDebugFlags.level, Color(0xFF42A5F5)),
            fsLevelRow('Warning flags', fsWarningFlags.level, Color(0xFFFFA726)),
            fsLevelRow('Empty (hidden)', fsEmpty.level, Color(0xFF9E9E9E)),

            // Section 11: showName
            SizedBox(height: 20.0),
            Text('11. showName & showSeparator', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(color: Color(0xFFF3E5F5), borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('showName: true, showSeparator: true', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
                  Text('${fsShowName.toString()}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                  SizedBox(height: 6.0),
                  Text('showName: false', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
                  Text('${fsHideName.toString()}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                ],
              ),
            ),

            // Section 12: toString
            SizedBox(height: 20.0),
            Text('12. String Representations', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 4.0),
            fsToStringSection,

            // Section 13: JSON
            SizedBox(height: 20.0),
            Text('13. JSON Serialization', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 4.0),
            fsJsonSection,

            // Section 14: Inheritance
            SizedBox(height: 20.0),
            Text('14. Inheritance Chain', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(color: Color(0xFFFCE4EC), borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fsInheritRow('DiagnosticsNode', 'abstract base', 0, Colors.grey, false),
                  fsInheritRow('DiagnosticsProperty<T>', 'typed name-value pair', 1, Color(0xFF7E57C2), false),
                  fsInheritRow('FlagsSummary<T>', 'Map<String, T?> summary', 2, Color(0xFFAD1457), true),
                ],
              ),
            ),

            // Section 15: Real world
            SizedBox(height: 20.0),
            Text('15. Real-World Flutter Uses', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 4.0),
            Text('Where FlagsSummary appears in the framework:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            fsUseCaseRow('RenderBox', 'needsLayout, needsPaint, needsCompositing', Icons.crop_square, Color(0xFFD81B60)),
            fsUseCaseRow('RenderObject', 'sizedByParent, debugNeedsLayout, debugDoingThisResize', Icons.account_tree, Color(0xFFD81B60)),
            fsUseCaseRow('GestureRecognizer', 'drag flags: down, start, update, end', Icons.touch_app, Color(0xFFD81B60)),
            fsUseCaseRow('ScrollPosition', 'atEdge, outOfRange, keepScrollOffset', Icons.swap_vert, Color(0xFFD81B60)),
            fsUseCaseRow('FocusNode', 'hasFocus, hasPrimaryFocus, canRequestFocus', Icons.center_focus_strong, Color(0xFFD81B60)),

            // Section 16: Summary
            SizedBox(height: 20.0),
            Text('16. Summary', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 8.0),
            Wrap(
              children: [
                fsSummaryTile('Instances', '7', Color(0xFFFCE4EC), Color(0xFFAD1457)),
                fsSummaryTile('Bool Flags', '${fsBoolFlags.value.length}', Color(0xFFE3F2FD), Colors.blue.shade700),
                fsSummaryTile('Int Flags', '${fsIntFlags.value.length}', Color(0xFFF3E5F5), Colors.purple.shade700),
                fsSummaryTile('JSON Keys', '${fsJson.keys.length}', Color(0xFFE8F5E9), Colors.green.shade700),
                fsSummaryTile('Use Cases', '5', Color(0xFFFFF3E0), Colors.orange.shade700),
                fsSummaryTile('Sections', '16', Color(0xFFECEFF1), Colors.grey.shade700),
              ],
            ),

            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}
