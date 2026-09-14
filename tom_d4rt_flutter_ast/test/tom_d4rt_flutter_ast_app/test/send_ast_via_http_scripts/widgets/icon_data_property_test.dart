// ignore_for_file: avoid_print
// IconDataProperty – comprehensive deep demo
// Violet / Lilac palette – DiagnosticsProperty<IconData> for debug
// inspection of icon values in Flutter DevTools and toString() output.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color ipViolet = Color(0xFF4527A0);
  const Color ipLilac = Color(0xFFEDE7F6);
  const Color ipOnViolet = Color(0xFFFFFFFF);
  const Color ipDark = Color(0xFF1A0066);
  const Color ipLightLilac = Color(0xFFF5F0FF);
  const Color ipTextDark = Color(0xFF1B1040);
  const Color ipAccent = Color(0xFF7C4DFF);
  const Color ipMuted = Color(0xFFB39DDB);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget ipHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ipViolet, ipDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ipOnViolet)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: ipOnViolet.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget ipSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: ipLightLilac,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ipViolet.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: ipViolet.withValues(alpha: 0.07),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ipViolet)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
          ),
        ],
      ),
    );
  }

  Widget ipBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('● ',
              style: TextStyle(color: ipAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: ipTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget ipCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0E0630),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: ipLilac,
              height: 1.5)),
    );
  }

  Widget ipKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: ipDark)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ipTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ipHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ipAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ipAccent.withValues(alpha: 0.22)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: ipDark,
              height: 1.4)),
    );
  }

  Widget ipDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: ipMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget ipInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ipViolet.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: ipViolet)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ipDark)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ipTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ipCompare(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ipViolet,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: ipDark)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: ipTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: ipLilac,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          ipHeader(
            'IconDataProperty',
            'DiagnosticsProperty<IconData> – specialized diagnostics '
                'property for icon values, with JSON serialization that '
                'includes codePoint in valueProperties',
          ),

          // ── 1. class identity ──
          ipSection('1 · Class Identity & Role', [
            ipKeyValue('Class', 'IconDataProperty'),
            ipKeyValue('Extends', 'DiagnosticsProperty<IconData>'),
            ipKeyValue('Library', 'package:flutter/widgets.dart'),
            ipKeyValue('Purpose',
                'Debug representation of IconData values'),
            ipDivider(),
            ipBullet(
                'IconDataProperty is a specialized DiagnosticsProperty '
                'designed to display IconData values in the diagnostics '
                'tree (DevTools, toString, toJsonMap).'),
            ipBullet(
                'It adds codePoint serialization to the JSON output, '
                'which allows DevTools to display the actual icon glyph.'),
            ipBullet(
                'Without IconDataProperty, IconData would serialize as '
                'a generic object without the codePoint field.'),
          ]),

          // ── 2. constructor ──
          ipSection('2 · Constructor Parameters', [
            ipCodeBlock(
                '// IconDataProperty constructor:\n'
                'IconDataProperty(\n'
                '  String name,          // property name\n'
                '  IconData? value,      // the icon data\n'
                '  {\n'
                '    String? ifNull,     // message when null\n'
                '    bool showName = true,\n'
                '    DiagnosticsTreeStyle style =\n'
                '        DiagnosticsTreeStyle.singleLine,\n'
                '    DiagnosticLevel level =\n'
                '        DiagnosticLevel.info,\n'
                '  }\n'
                ')'),
            ipDivider(),
            ipKeyValue('name', 'The property name (e.g. "icon")'),
            ipKeyValue('value', 'The IconData instance or null'),
            ipKeyValue('ifNull', 'Message when value is null'),
            ipKeyValue('showName', 'Whether to show the property name'),
            ipKeyValue('style', 'DiagnosticsTreeStyle for formatting'),
            ipKeyValue('level', 'DiagnosticLevel for filtering'),
          ]),

          // ── 3. basic usage ──
          ipSection('3 · Basic Usage', [
            ipCodeBlock(
                '// Creating IconDataProperty:\n'
                'final prop = IconDataProperty(\n'
                '  \'icon\',\n'
                '  Icons.home,\n'
                ');\n'
                '\n'
                'print(prop.name);              // "icon"\n'
                'print(prop.value);             // IconData(U+0E88A)\n'
                'print(prop.value?.codePoint);  // 59530\n'
                'print(prop.value?.fontFamily); // "MaterialIcons"\n'
                '\n'
                '// With null value:\n'
                'final nullProp = IconDataProperty(\n'
                '  \'icon\',\n'
                '  null,\n'
                '  ifNull: \'no icon assigned\',\n'
                ');'),
            ipDivider(),
            ipBullet(
                'The property name is typically "icon" but can be anything '
                'descriptive for the diagnostics context.'),
          ]),

          // ── 4. JSON serialization ──
          ipSection('4 · JSON Serialization (toJsonMap)', [
            ipBullet(
                'The PRIMARY unique feature of IconDataProperty is its '
                'custom toJsonMap() implementation.'),
            ipBullet(
                'It adds a "valueProperties" key containing the codePoint '
                'as an integer, enabling DevTools to render the icon.'),
            ipCodeBlock(
                '// JSON output structure:\n'
                '{\n'
                '  "name": "icon",\n'
                '  "type": "IconDataProperty",\n'
                '  "value": "IconData(U+0E88A)",\n'
                '  "valueProperties": {\n'
                '    "codePoint": 59530\n'
                '  }\n'
                '}\n'
                '\n'
                '// When value is null:\n'
                '// "valueProperties" is absent from the map'),
            ipHighlight(
                'The codePoint in valueProperties is what allows Flutter '
                'DevTools to display the actual icon glyph in the '
                'properties panel, not just a textual description.'),
          ]),

          // ── 5. diagnostics hierarchy ──
          ipSection('5 · Diagnostics Hierarchy', [
            ipCompare('DiagnosticsNode', 'Abstract base for all nodes'),
            ipCompare('DiagnosticsProperty<T>',
                'Generic property with typed value'),
            ipCompare('IconDataProperty',
                'Specialized for IconData with codePoint JSON'),
            ipDivider(),
            ipBullet(
                'IconDataProperty extends DiagnosticsProperty<IconData>, '
                'which extends DiagnosticsProperty<IconData?>, which '
                'extends DiagnosticsNode.'),
            ipBullet(
                'It overrides toJsonMap() to add the codePoint to the '
                'serialized output. All other behavior is inherited.'),
          ]),

          // ── 6. common icons ──
          ipSection('6 · Common IconData Values', [
            ipInfoRow('🏠', 'Icons.home:', 'codePoint 0xE88A (59530)'),
            ipInfoRow('⭐', 'Icons.star:', 'codePoint 0xE838 (59448)'),
            ipInfoRow('⚙', 'Icons.settings:', 'codePoint 0xE8B8 (59576)'),
            ipInfoRow('👤', 'Icons.person:', 'codePoint 0xE7FD (59389)'),
            ipInfoRow('❤', 'Icons.favorite:', 'codePoint 0xE87D (59517)'),
            ipInfoRow('✓', 'Icons.check:', 'codePoint 0xE5CA (58826)'),
            ipDivider(),
            ipBullet(
                'Icons.* constants are pre-defined IconData instances with '
                'fontFamily set to "MaterialIcons".'),
            ipBullet(
                'Each icon is identified by a unique codePoint (Unicode code '
                'point in the Material Icons font).'),
          ]),

          // ── 7. in debugFillProperties ──
          ipSection('7 · Usage in debugFillProperties', [
            ipBullet(
                'Widget authors use IconDataProperty inside '
                'debugFillProperties to expose icon values in the '
                'diagnostics tree.'),
            ipCodeBlock(
                '// In a custom widget:\n'
                'class MyIconButton extends StatelessWidget {\n'
                '  final IconData icon;\n'
                '  const MyIconButton({required this.icon});\n'
                '\n'
                '  @override\n'
                '  void debugFillProperties(\n'
                '      DiagnosticPropertiesBuilder properties) {\n'
                '    super.debugFillProperties(properties);\n'
                '    properties.add(\n'
                '      IconDataProperty(\'icon\', icon),\n'
                '    );\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  Widget build(BuildContext context) =>\n'
                '      Icon(icon);\n'
                '}'),
            ipDivider(),
            ipBullet(
                'The Icon widget itself uses IconDataProperty in its '
                'debugFillProperties to display the icon field.'),
          ]),

          // ── 8. DiagnosticLevel filtering ──
          ipSection('8 · DiagnosticLevel Filtering', [
            ipBullet(
                'The level parameter controls when the property appears '
                'in diagnostics output with varying verbosity.'),
            ipCodeBlock(
                '// Level examples:\n'
                'IconDataProperty(\n'
                '  \'icon\', Icons.home,\n'
                '  level: DiagnosticLevel.info,    // default\n'
                ');\n'
                '\n'
                'IconDataProperty(\n'
                '  \'debugIcon\', Icons.bug_report,\n'
                '  level: DiagnosticLevel.debug,   // verbose only\n'
                ');\n'
                '\n'
                'IconDataProperty(\n'
                '  \'hiddenIcon\', Icons.visibility_off,\n'
                '  level: DiagnosticLevel.hidden,  // never shown\n'
                ');'),
            ipDivider(),
            ipKeyValue('info', 'Shown in normal diagnostics'),
            ipKeyValue('debug', 'Shown only in verbose mode'),
            ipKeyValue('fine', 'Very verbose, usually filtered out'),
            ipKeyValue('hidden', 'Never shown in any output'),
          ]),

          // ── 9. toString behavior ──
          ipSection('9 · toString Representation', [
            ipBullet(
                'toString() uses the standard DiagnosticsProperty '
                'formatting: "name: value" (or just "value" if showName '
                'is false).'),
            ipCodeBlock(
                '// toString examples:\n'
                'final p1 = IconDataProperty(\'icon\', Icons.home);\n'
                'p1.toString();\n'
                '// "icon: IconData(U+0E88A)"\n'
                '\n'
                'final p2 = IconDataProperty(\n'
                '  \'icon\', Icons.home,\n'
                '  showName: false,\n'
                ');\n'
                'p2.toString();\n'
                '// "IconData(U+0E88A)"\n'
                '\n'
                'final p3 = IconDataProperty(\n'
                '  \'icon\', null,\n'
                '  ifNull: \'<none>\',\n'
                ');\n'
                'p3.toString();\n'
                '// "icon: <none>"'),
            ipDivider(),
            ipBullet(
                'The U+XXXXX format shows the Unicode code point in hex.'),
          ]),

          // ── 10. comparison with other property types ──
          ipSection('10 · Comparison with Other DiagnosticsProperty Types', [
            ipCompare('StringProperty', 'For String values, quoted output'),
            ipCompare('IntProperty', 'For int values, optional unit suffix'),
            ipCompare('DoubleProperty', 'For double values, precision control'),
            ipCompare('FlagProperty', 'For boolean flags, shows/hides name'),
            ipCompare('ColorProperty', 'For Color values, hex output'),
            ipCompare('IconDataProperty', 'For IconData, codePoint JSON'),
            ipDivider(),
            ipBullet(
                'Each specialized property type exists to provide better '
                'human-readable output and serialization for its data type.'),
            ipBullet(
                'You SHOULD use IconDataProperty instead of generic '
                'DiagnosticsProperty<IconData> to get codePoint JSON.'),
          ]),

          // ── 11. IconData internals ──
          ipSection('11 · IconData Class Structure', [
            ipBullet(
                'IconData is the value type held by IconDataProperty. '
                'Understanding its fields helps interpret the diagnostics.'),
            ipCodeBlock(
                '// IconData fields:\n'
                'class IconData {\n'
                '  final int codePoint;      // Unicode glyph\n'
                '  final String? fontFamily;  // e.g. "MaterialIcons"\n'
                '  final String? fontPackage; // e.g. null for built-in\n'
                '  final bool matchTextDirection; // RTL mirroring\n'
                '}\n'
                '\n'
                '// Example:\n'
                'const home = IconData(\n'
                '  0xe88a,\n'
                '  fontFamily: \'MaterialIcons\',\n'
                '); // equivalent to Icons.home'),
            ipDivider(),
            ipKeyValue('codePoint', 'Unicode index in the icon font'),
            ipKeyValue('fontFamily', 'Icon font name'),
            ipKeyValue('fontPackage', 'Package for custom icon fonts'),
            ipKeyValue('matchTextDirection', 'Whether to flip for RTL'),
          ]),

          // ── 12. DevTools integration ──
          ipSection('12 · Flutter DevTools Integration', [
            ipBullet(
                'In the DevTools Widget Inspector, IconDataProperty values '
                'appear with the icon glyph rendered inline.'),
            ipBullet(
                'The valueProperties.codePoint field is used by DevTools '
                'to look up and display the icon from the Material Icons '
                'font.'),
            ipBullet(
                'This only works for Material Icons and Cupertino Icons. '
                'Custom icon fonts may not render in DevTools.'),
            ipHighlight(
                'DevTools reads the JSON from toJsonMap() and uses the '
                'codePoint to render the glyph. Without IconDataProperty, '
                'DevTools would show "IconData(U+XXXX)" as plain text.'),
          ]),

          // ── 13. null handling ──
          ipSection('13 · Null Value Handling', [
            ipBullet(
                'When IconData? is null, the toJsonMap() output omits the '
                'valueProperties key entirely.'),
            ipBullet(
                'The ifNull parameter provides a human-readable message '
                'displayed in place of the value.'),
            ipCodeBlock(
                '// Null handling:\n'
                'final prop = IconDataProperty(\n'
                '  \'icon\',\n'
                '  null,\n'
                '  ifNull: \'no icon configured\',\n'
                ');\n'
                '\n'
                'prop.toString();\n'
                '// "icon: no icon configured"\n'
                '\n'
                'prop.toJsonMap(delegate);\n'
                '// {\n'
                '//   "name": "icon",\n'
                '//   "ifNull": "no icon configured"\n'
                '//   // NO "valueProperties" key\n'
                '// }'),
            ipDivider(),
            ipBullet(
                'This is consistent with DiagnosticsProperty behavior '
                'where null values suppress value-dependent fields.'),
          ]),

          // ── 14. DiagnosticsTreeStyle ──
          ipSection('14 · DiagnosticsTreeStyle Options', [
            ipBullet(
                'The style parameter controls how the property is formatted '
                'in the full diagnostics tree.'),
            ipKeyValue('singleLine', 'Compact: "icon: IconData(U+0E88A)"'),
            ipKeyValue('flat', 'Name-value pairs, no tree indent'),
            ipKeyValue('error', 'Highlighted as an error'),
            ipKeyValue('whitespace', 'No tree lines, just indentation'),
            ipDivider(),
            ipCodeBlock(
                '// Style comparison:\n'
                'IconDataProperty(\n'
                '  \'icon\', Icons.home,\n'
                '  style: DiagnosticsTreeStyle.singleLine,\n'
                ');\n'
                '// Output: "icon: IconData(U+0E88A)"\n'
                '\n'
                'IconDataProperty(\n'
                '  \'icon\', Icons.home,\n'
                '  style: DiagnosticsTreeStyle.error,\n'
                ');\n'
                '// Output: "icon: IconData(U+0E88A)" (in red)'),
          ]),

          // ── 15. real-world usage in Flutter ──
          ipSection('15 · Where Flutter Uses IconDataProperty', [
            ipBullet(
                'The Icon widget uses IconDataProperty to expose its '
                'icon field in debugFillProperties.'),
            ipBullet(
                'IconButton uses it for its icon diagnostics.'),
            ipBullet(
                'Any custom widget that renders icons should use '
                'IconDataProperty for proper DevTools integration.'),
            ipCodeBlock(
                '// Flutter Icon widget (simplified):\n'
                'class Icon extends StatelessWidget {\n'
                '  final IconData? icon;\n'
                '  \n'
                '  @override\n'
                '  void debugFillProperties(\n'
                '      DiagnosticPropertiesBuilder properties) {\n'
                '    super.debugFillProperties(properties);\n'
                '    properties.add(\n'
                '      IconDataProperty(\'icon\', icon,\n'
                '          ifNull: \'<empty>\'),\n'
                '    );\n'
                '  }\n'
                '}'),
          ]),

          // ── 16. quick API reference ──
          ipSection('16 · Quick API Reference', [
            ipKeyValue('Class', 'IconDataProperty'),
            ipKeyValue('Extends', 'DiagnosticsProperty<IconData>'),
            ipKeyValue('Key override', 'toJsonMap() adds codePoint'),
            ipKeyValue('Library', 'package:flutter/widgets.dart'),
            ipKeyValue('Used by', 'Icon, IconButton, custom widgets'),
            ipDivider(),
            ipCodeBlock(
                '// Quick reference:\n'
                'final prop = IconDataProperty(\n'
                '  \'icon\',       // name\n'
                '  Icons.star,   // value\n'
                '  ifNull: \'none\',\n'
                '  showName: true,\n'
                '  level: DiagnosticLevel.info,\n'
                ');\n'
                '\n'
                'prop.name;                  // "icon"\n'
                'prop.value;                 // IconData(U+0E838)\n'
                'prop.value?.codePoint;      // 59448\n'
                'prop.value?.fontFamily;     // "MaterialIcons"\n'
                'prop.toString();            // "icon: IconData(U+0E838)"\n'
                'prop.toJsonMap(delegate);   // includes valueProperties'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: ipViolet.withValues(alpha: 0.06),
            child: const Text(
              'IconDataProperty · Violet Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: ipMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
