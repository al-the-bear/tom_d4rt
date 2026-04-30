// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DiagnosticsNode, DiagnosticPropertiesBuilder, StringProperty, IntProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Foundation diagnostics test executing');

  // ========== DIAGNOSTICPROPERTIESBUILDER ==========
  print('--- DiagnosticPropertiesBuilder Tests ---');

  final builder = DiagnosticPropertiesBuilder();
  print('DiagnosticPropertiesBuilder created');
  print('  runtimeType: ${builder.runtimeType}');

  // Add StringProperty
  builder.add(StringProperty('name', 'TestWidget'));
  print('Added StringProperty("name", "TestWidget")');

  // Add IntProperty
  builder.add(IntProperty('count', 42));
  print('Added IntProperty("count", 42)');

  // Add DoubleProperty
  builder.add(DoubleProperty('opacity', 0.75));
  print('Added DoubleProperty("opacity", 0.75)');

  // Add FlagProperty
  builder.add(FlagProperty('enabled', value: true, ifTrue: 'enabled'));
  print('Added FlagProperty("enabled", value: true)');

  // Add DiagnosticsProperty
  builder.add(DiagnosticsProperty<String>('label', 'Hello'));
  print('Added DiagnosticsProperty<String>("label", "Hello")');

  // Add EnumProperty
  builder.add(EnumProperty<TextDirection>('direction', TextDirection.ltr));
  print('Added EnumProperty<TextDirection>("direction", TextDirection.ltr)');

  // Print all properties
  print('Builder properties count: ${builder.properties.length}');
  for (final prop in builder.properties) {
    print('  ${prop.name}: ${prop.toStringDeep()}');
  }

  // ========== STRINGPROPERTY ==========
  print('--- StringProperty Tests ---');

  final stringProp = StringProperty('title', 'My Widget');
  print('StringProperty: $stringProp');
  print('  name: ${stringProp.name}');
  print('  value: ${stringProp.value}');
  print('  runtimeType: ${stringProp.runtimeType}');

  final quotedProp = StringProperty('text', 'Hello World', quoted: true);
  print('Quoted StringProperty: $quotedProp');

  final nullStringProp = StringProperty(
    'nullable',
    null,
    defaultValue: 'default',
  );
  print('Null StringProperty: $nullStringProp');

  // ========== INTPROPERTY ==========
  print('--- IntProperty Tests ---');

  final intProp = IntProperty('width', 200);
  print('IntProperty: $intProp');
  print('  name: ${intProp.name}');
  print('  value: ${intProp.value}');
  print('  runtimeType: ${intProp.runtimeType}');

  final nullIntProp = IntProperty('height', null);
  print('Null IntProperty: $nullIntProp');

  // ========== DOUBLEPROPERTY ==========
  print('--- DoubleProperty Tests ---');

  final doubleProp = DoubleProperty('opacity', 0.5);
  print('DoubleProperty: $doubleProp');
  print('  name: ${doubleProp.name}');
  print('  value: ${doubleProp.value}');

  final percentProp = DoubleProperty.lazy('percent', () => 0.85);
  print('Lazy DoubleProperty: $percentProp');

  // ========== FLAGPROPERTY ==========
  print('--- FlagProperty Tests ---');

  final trueFlag = FlagProperty(
    'visible',
    value: true,
    ifTrue: 'visible',
    ifFalse: 'hidden',
  );
  print('FlagProperty (true): $trueFlag');

  final falseFlag = FlagProperty(
    'visible',
    value: false,
    ifTrue: 'visible',
    ifFalse: 'hidden',
  );
  print('FlagProperty (false): $falseFlag');

  // ========== ENUMPROPERTY ==========
  print('--- EnumProperty Tests ---');

  final enumProp = EnumProperty<TextAlign>('align', TextAlign.center);
  print('EnumProperty: $enumProp');
  print('  name: ${enumProp.name}');
  print('  value: ${enumProp.value}');

  final nullEnumProp = EnumProperty<TextAlign>('align', null);
  print('Null EnumProperty: $nullEnumProp');

  // ========== DIAGNOSTICSPROPERTY ==========
  print('--- DiagnosticsProperty Tests ---');

  final diagProp = DiagnosticsProperty<Color>('color', Color(0xFFFF0000));
  print('DiagnosticsProperty<Color>: $diagProp');
  print('  name: ${diagProp.name}');
  print('  value: ${diagProp.value}');

  final diagPropWithDefault = DiagnosticsProperty<int>(
    'size',
    16,
    defaultValue: 14,
  );
  print('DiagnosticsProperty with default: $diagPropWithDefault');

  // ========== DIAGNOSTICSNODE ==========
  print('--- DiagnosticsNode Tests ---');

  // DiagnosticsNode is abstract; test via message node
  final messageNode = DiagnosticsNode.message('This is a diagnostic message');
  print('DiagnosticsNode.message: $messageNode');
  print('  runtimeType: ${messageNode.runtimeType}');
  print('  toString: ${messageNode.toString()}');

  // ========== RETURN WIDGET ==========
  print('Foundation diagnostics test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foundation Diagnostics Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• DiagnosticPropertiesBuilder - collects properties'),
          Text('• DiagnosticsNode - base diagnostic node'),
          Text('• StringProperty - string diagnostic'),
          Text('• IntProperty - integer diagnostic'),
          Text('• DoubleProperty - double diagnostic'),
          Text('• FlagProperty - boolean flag diagnostic'),
          Text('• EnumProperty - enum value diagnostic'),
          Text('• DiagnosticsProperty<T> - generic diagnostic'),
          SizedBox(height: 16.0),

          Text(
            'Property Summary:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE3F2FD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('StringProperty("title", "My Widget")'),
                Text('IntProperty("width", 200)'),
                Text('DoubleProperty("opacity", 0.5)'),
                Text('FlagProperty("visible", value: true)'),
                Text('EnumProperty("align", TextAlign.center)'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
