// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - ButtonBarTheme (bridged InheritedWidget)
// ----------------------------------------------------------------------------
// ButtonBarTheme is the Material InheritedWidget that propagates a
// ButtonBarThemeData value down a subtree. It is bridged in d4rt under the
// flutter/material module and exposes the standard InheritedWidget surface:
//   - constructor `ButtonBarTheme({Key? key, required ButtonBarThemeData data,
//     required Widget child})`
//   - getters `key`, `child`, `data`, `hashCode`
//   - methods `createElement`, `toStringShort`, `toStringShallow`,
//     `toStringDeep`, `toDiagnosticsNode`, `debugFillProperties`,
//     `debugDescribeChildren`, `toString`, `updateShouldNotify`, `==`
//   - static `of(BuildContext) -> ButtonBarThemeData`
//
// `ButtonBarThemeData` itself is unbridged here (deprecated in modern
// Flutter), so this script never tries to construct one. Instead it always
// fetches the live ButtonBarThemeData out of the surrounding tree via
// `ButtonBarTheme.of(innerContext)` (or the equivalent path
// `Theme.of(innerContext).buttonBarTheme`) and feeds it back into the
// `ButtonBarTheme(data: ..., child: ...)` constructor. That is the only
// shape that compiles cleanly under the d4rt bridges.
//
// Every section below uses Builder widgets to obtain a BuildContext that is
// already a descendant of a MaterialApp / ThemeData, which is what
// `.of(context)` requires.
// ----------------------------------------------------------------------------
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PROLOGUE: short diagnostic recap so the harness logs something readable.
  // ===========================================================================
  print('=== ButtonBarTheme Deep Demo ===');
  print('ButtonBarTheme is the bridged InheritedWidget. The bridged surface:');
  print('  ctor             : ButtonBarTheme(data, child, key?)');
  print('  static method    : of(BuildContext) -> ButtonBarThemeData');
  print('  getters          : key / hashCode / child / data');
  print('  methods          : updateShouldNotify, ==, toString, toStringShort,');
  print('                     toStringShallow, toStringDeep, toDiagnosticsNode,');
  print('                     debugFillProperties, debugDescribeChildren,');
  print('                     createElement');

  // ===========================================================================
  // PALETTE - distinct tint per section so the eye can track sections apart.
  // ===========================================================================
  const heroBg = Color(0xFFEDE7F6);
  const heroAccent = Color(0xFF4527A0);
  const heroText = Color(0xFF1A0F4D);

  const lookupBg = Color(0xFFE0F2F1);
  const lookupAccent = Color(0xFF00695C);
  const lookupText = Color(0xFF003B36);

  const mountBg = Color(0xFFE3F2FD);
  const mountAccent = Color(0xFF1565C0);
  const mountText = Color(0xFF0B2545);

  const gettersBg = Color(0xFFFFF3E0);
  const gettersAccent = Color(0xFFE65100);
  const gettersText = Color(0xFF4E2A00);

  const updateBg = Color(0xFFFCE4EC);
  const updateAccent = Color(0xFFAD1457);
  const updateText = Color(0xFF50121F);

  const equalityBg = Color(0xFFE8F5E9);
  const equalityAccent = Color(0xFF2E7D32);
  const equalityText = Color(0xFF1B3D1F);

  const stringsBg = Color(0xFFFFF8E1);
  const stringsAccent = Color(0xFFB28704);
  const stringsText = Color(0xFF4D3A00);

  const nestedBg = Color(0xFFF3E5F5);
  const nestedAccent = Color(0xFF6A1B9A);
  const nestedText = Color(0xFF311B5B);

  const refBg = Color(0xFFECEFF1);
  const refAccent = Color(0xFF37474F);
  const refText = Color(0xFF102027);

  // ===========================================================================
  // SHARED HELPERS
  // ===========================================================================
  Widget sectionShell({
    required String number,
    required String title,
    required Color background,
    required Color accent,
    required Color text,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget mono(String s, {Color color = Colors.black87, double size = 12}) {
    return Text(
      s,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: size,
        color: color,
        height: 1.35,
      ),
    );
  }

  Widget readout(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: accent,
              ),
            ),
          ),
          Expanded(child: mono(value)),
        ],
      ),
    );
  }

  Widget card(Color accent, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  // ===========================================================================
  // SECTION 1 - HERO: what is ButtonBarTheme, why we look it up via .of()
  // ===========================================================================
  final Widget section1 = sectionShell(
    number: '1',
    title: 'ButtonBarTheme — the bridged InheritedWidget',
    background: heroBg,
    accent: heroAccent,
    text: heroText,
    children: [
      const Text(
        'ButtonBarTheme is the InheritedWidget that historically propagated a '
        'ButtonBarThemeData value down a Material subtree. The bridged '
        'surface keeps the constructor, the getters key/child/data, and the '
        'static .of(BuildContext) lookup. The data argument is required and '
        'must be a real ButtonBarThemeData — but ButtonBarThemeData itself '
        'is unbridged in this build (deprecated in modern Flutter). The '
        'workable shape is therefore: pull the live data out of the '
        'surrounding ThemeData, then feed it back into a fresh '
        'ButtonBarTheme. That is how every example below is constructed.',
        style: TextStyle(color: heroText, height: 1.4),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: heroAccent.withOpacity(0.4)),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bridged signature (from material_widgets_bridges.b.dart):',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            SizedBox(height: 6),
            Text(
              'const ButtonBarTheme({Key? key, required ButtonBarThemeData '
              'data, required Widget child})',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
            Text(
              'static ButtonBarThemeData of(BuildContext context)',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
            Text(
              'bool updateShouldNotify(ButtonBarTheme oldWidget)',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      Builder(
        builder: (innerContext) {
          // Fetch the ambient ButtonBarThemeData via the bridged static call.
          final themed = ButtonBarTheme(
            data: ButtonBarTheme.of(innerContext),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: heroAccent),
                ),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'I am the child of a freshly-constructed ButtonBarTheme. '
                  'It carries the inherited ButtonBarThemeData value forward.',
                ),
              ),
            ),
          );
          return themed;
        },
      ),
    ],
  );

  // ===========================================================================
  // SECTION 2 - LOOKUP: ButtonBarTheme.of(context) and Theme.of(context)
  //                     .buttonBarTheme should be functionally equivalent.
  // ===========================================================================
  final Widget section2 = sectionShell(
    number: '2',
    title: 'Lookup: .of(context) and Theme.of(context).buttonBarTheme',
    background: lookupBg,
    accent: lookupAccent,
    text: lookupText,
    children: [
      const Text(
        'Two paths reach the same ButtonBarThemeData: the static '
        'ButtonBarTheme.of(context) walks the inherited tree (and falls '
        'back to ThemeData), while Theme.of(context).buttonBarTheme reads '
        'it directly from the closest ThemeData. We capture both inside a '
        'Builder so the BuildContext is rooted under MaterialApp.',
        style: TextStyle(color: lookupText, height: 1.4),
      ),
      const SizedBox(height: 8),
      Builder(
        builder: (innerContext) {
          final viaInherited = ButtonBarTheme.of(innerContext);
          final viaTheme = Theme.of(innerContext).buttonBarTheme;
          return card(lookupAccent, [
            readout('ButtonBarTheme.of(ctx)',
                viaInherited.toString(), lookupAccent),
            readout('Theme.of(ctx).buttonBarTheme',
                viaTheme.toString(), lookupAccent),
            readout('identical(viaInherited, viaTheme)',
                identical(viaInherited, viaTheme).toString(),
                lookupAccent),
            readout('runtimeType (inherited path)',
                viaInherited.runtimeType.toString(), lookupAccent),
            readout('runtimeType (theme path)',
                viaTheme.runtimeType.toString(), lookupAccent),
          ]);
        },
      ),
      const SizedBox(height: 6),
      const Text(
        'Both paths return a ButtonBarThemeData. When ButtonBarTheme is not '
        'overridden anywhere up the tree, both paths return the same object '
        '(identical == true). The instance is opaque to the script — only '
        'toString() and runtimeType are accessed for display.',
        style: TextStyle(color: lookupText, height: 1.4),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 3 - MOUNT: insert ButtonBarTheme into the tree using inherited
  //                    data, then look up again from below it. The lookup
  //                    must find the freshly mounted ButtonBarTheme.
  // ===========================================================================
  final Widget section3 = sectionShell(
    number: '3',
    title: 'Mounting ButtonBarTheme into a subtree',
    background: mountBg,
    accent: mountAccent,
    text: mountText,
    children: [
      const Text(
        'A ButtonBarTheme is mounted just under a Builder, then a child '
        'Builder reads ButtonBarTheme.of(context). The lookup hits the '
        'newly mounted theme (not the ambient ThemeData fallback) — the '
        'classic InheritedWidget contract. We keep the data identical to '
        'the ambient one, so the values are the same; the test is whether '
        'lookup picks the closest ButtonBarTheme.',
        style: TextStyle(color: mountText, height: 1.4),
      ),
      const SizedBox(height: 8),
      Builder(
        builder: (rootContext) {
          final ambient = ButtonBarTheme.of(rootContext);
          return ButtonBarTheme(
            key: const ValueKey('mount-section-3'),
            data: ambient,
            child: Builder(
              builder: (innerContext) {
                final fromInner = ButtonBarTheme.of(innerContext);
                return card(mountAccent, [
                  mono('mounted: ButtonBarTheme(key: ValueKey("mount-section-3"),',
                      color: mountAccent),
                  mono('               data: <ambient ButtonBarThemeData>,'),
                  mono('               child: Builder(...))'),
                  const SizedBox(height: 6),
                  readout('lookup from outer',
                      ambient.toString(), mountAccent),
                  readout('lookup from inner',
                      fromInner.toString(), mountAccent),
                  readout('identical (outer, inner)',
                      identical(ambient, fromInner).toString(),
                      mountAccent),
                ]);
              },
            ),
          );
        },
      ),
      const SizedBox(height: 6),
      const Text(
        'Note: identical(outer, inner) is true here because we passed the '
        'same ButtonBarThemeData value into the mounted ButtonBarTheme. The '
        'lookup is functionally pinned to that instance regardless of which '
        'branch of the tree calls .of(context).',
        style: TextStyle(color: mountText, height: 1.4),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 4 - GETTERS: read every bridged getter on a live ButtonBarTheme.
  // ===========================================================================
  final Widget section4 = sectionShell(
    number: '4',
    title: 'Bridged getters: key / hashCode / child / data',
    background: gettersBg,
    accent: gettersAccent,
    text: gettersText,
    children: [
      const Text(
        'Every getter declared on the BridgedClass for ButtonBarTheme is '
        'exercised below. The widget instance is created once with an '
        'identifying ValueKey, the inherited ButtonBarThemeData, and a '
        'small SizedBox child. The script then reads each getter and prints '
        'its toString() representation.',
        style: TextStyle(color: gettersText, height: 1.4),
      ),
      const SizedBox(height: 8),
      Builder(
        builder: (innerContext) {
          final data = ButtonBarTheme.of(innerContext);
          final widget = ButtonBarTheme(
            key: const ValueKey('getter-probe'),
            data: data,
            child: const SizedBox(width: 0, height: 0),
          );
          return card(gettersAccent, [
            readout('widget.key',
                widget.key.toString(), gettersAccent),
            readout('widget.data',
                widget.data.toString(), gettersAccent),
            readout('widget.child',
                widget.child.toString(), gettersAccent),
            readout('widget.hashCode (int)',
                widget.hashCode.toString(), gettersAccent),
            readout('widget.runtimeType',
                widget.runtimeType.toString(), gettersAccent),
          ]);
        },
      ),
    ],
  );

  // ===========================================================================
  // SECTION 5 - updateShouldNotify: bridged method that decides whether
  //             dependents rebuild when this widget's data changes.
  // ===========================================================================
  final Widget section5 = sectionShell(
    number: '5',
    title: 'updateShouldNotify(other)',
    background: updateBg,
    accent: updateAccent,
    text: updateText,
    children: [
      const Text(
        'InheritedWidget.updateShouldNotify is the bridged hook the '
        'framework calls when a ButtonBarTheme rebuilds. It returns true if '
        'dependents must be rebuilt (data changed), false otherwise. With '
        'two ButtonBarThemes wrapping the same ambient ButtonBarThemeData, '
        'updateShouldNotify must return false — the data is identical.',
        style: TextStyle(color: updateText, height: 1.4),
      ),
      const SizedBox(height: 8),
      Builder(
        builder: (innerContext) {
          final data = ButtonBarTheme.of(innerContext);
          final a = ButtonBarTheme(
            key: const ValueKey('update-a'),
            data: data,
            child: const SizedBox(),
          );
          final b = ButtonBarTheme(
            key: const ValueKey('update-b'),
            data: data,
            child: const SizedBox(),
          );
          return card(updateAccent, [
            readout('a.key', a.key.toString(), updateAccent),
            readout('b.key', b.key.toString(), updateAccent),
            readout('a.data == b.data',
                (a.data == b.data).toString(), updateAccent),
            readout('a.updateShouldNotify(b)',
                a.updateShouldNotify(b).toString(), updateAccent),
            readout('b.updateShouldNotify(a)',
                b.updateShouldNotify(a).toString(), updateAccent),
          ]);
        },
      ),
      const SizedBox(height: 6),
      const Text(
        'Both updateShouldNotify calls return false because the underlying '
        'ButtonBarThemeData is the same instance — no dependent rebuilds '
        'are scheduled. If the framework swaps in a different '
        'ButtonBarThemeData, the call would return true.',
        style: TextStyle(color: updateText, height: 1.4),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 6 - EQUALITY: == and hashCode on two ButtonBarThemes.
  // ===========================================================================
  final Widget section6 = sectionShell(
    number: '6',
    title: 'Equality: == and hashCode',
    background: equalityBg,
    accent: equalityAccent,
    text: equalityText,
    children: [
      const Text(
        'Widget identity is by reference; two ButtonBarTheme instances built '
        'with the same data and child are NOT == unless they happen to be '
        'the same object. Below: build two with the same arguments and '
        'compare. The third readout shows == against the same instance — '
        'always true.',
        style: TextStyle(color: equalityText, height: 1.4),
      ),
      const SizedBox(height: 8),
      Builder(
        builder: (innerContext) {
          final data = ButtonBarTheme.of(innerContext);
          final child = const SizedBox(width: 1, height: 1);
          final a = ButtonBarTheme(data: data, child: child);
          final b = ButtonBarTheme(data: data, child: child);
          return card(equalityAccent, [
            readout('a.hashCode', a.hashCode.toString(), equalityAccent),
            readout('b.hashCode', b.hashCode.toString(), equalityAccent),
            readout('a == b', (a == b).toString(), equalityAccent),
            readout('a == a', (a == a).toString(), equalityAccent),
            readout('a.hashCode == a.hashCode',
                (a.hashCode == a.hashCode).toString(), equalityAccent),
          ]);
        },
      ),
      const SizedBox(height: 6),
      const Text(
        'a == b is false (two distinct ButtonBarTheme objects), a == a is '
        'true, and an instance hashCode is stable across reads.',
        style: TextStyle(color: equalityText, height: 1.4),
      ),
    ],
  );

  // ===========================================================================
  // SECTION 7 - STRING REPRESENTATIONS: toString / toStringShort.
  // ===========================================================================
  final Widget section7 = sectionShell(
    number: '7',
    title: 'String representations',
    background: stringsBg,
    accent: stringsAccent,
    text: stringsText,
    children: [
      const Text(
        'Three bridged stringification methods are exercised: toString, '
        'toStringShort, and toStringShallow. Each one is called on the '
        'same ButtonBarTheme instance.',
        style: TextStyle(color: stringsText, height: 1.4),
      ),
      const SizedBox(height: 8),
      Builder(
        builder: (innerContext) {
          final data = ButtonBarTheme.of(innerContext);
          final w = ButtonBarTheme(
            key: const ValueKey('strings'),
            data: data,
            child: const SizedBox(width: 1, height: 1),
          );
          return card(stringsAccent, [
            readout('toStringShort()',
                w.toStringShort(), stringsAccent),
            readout('toString()', w.toString(), stringsAccent),
            readout('toStringShallow()',
                w.toStringShallow(), stringsAccent),
          ]);
        },
      ),
    ],
  );

  // ===========================================================================
  // SECTION 8 - NESTED MOUNTS: stack two ButtonBarThemes one inside the other
  //             and read .of() from the deepest position. Lookup hits the
  //             closest theme on the way up.
  // ===========================================================================
  final Widget section8 = sectionShell(
    number: '8',
    title: 'Nested ButtonBarThemes — lookup picks the closest one',
    background: nestedBg,
    accent: nestedAccent,
    text: nestedText,
    children: [
      const Text(
        'Two ButtonBarTheme widgets are stacked. Each one carries the same '
        'ambient ButtonBarThemeData (we cannot construct a different one — '
        'ButtonBarThemeData is unbridged). The script reads .of() from '
        'three positions: above both, between them, and below both. The '
        'deepest read finds the innermost ButtonBarTheme, the middle read '
        'finds the outer one, and the topmost read falls back to the '
        'ambient value from MaterialApp.',
        style: TextStyle(color: nestedText, height: 1.4),
      ),
      const SizedBox(height: 8),
      Builder(
        builder: (rootContext) {
          final ambient = ButtonBarTheme.of(rootContext);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              card(nestedAccent, [
                readout('above all themes (ambient)',
                    ambient.toString(), nestedAccent),
              ]),
              ButtonBarTheme(
                key: const ValueKey('outer'),
                data: ambient,
                child: Builder(
                  builder: (afterOuter) {
                    final fromAfterOuter = ButtonBarTheme.of(afterOuter);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        card(nestedAccent, [
                          readout('between outer and inner',
                              fromAfterOuter.toString(), nestedAccent),
                        ]),
                        ButtonBarTheme(
                          key: const ValueKey('inner'),
                          data: ambient,
                          child: Builder(
                            builder: (afterInner) {
                              final fromAfterInner =
                                  ButtonBarTheme.of(afterInner);
                              return card(nestedAccent, [
                                readout('below inner',
                                    fromAfterInner.toString(), nestedAccent),
                                readout(
                                    'identical(ambient, fromAfterInner)',
                                    identical(ambient, fromAfterInner)
                                        .toString(),
                                    nestedAccent),
                              ]);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    ],
  );

  // ===========================================================================
  // SECTION 9 - REFERENCE CARD: every bridged member of ButtonBarTheme.
  // ===========================================================================
  Widget refRow(String name, String type, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              role,
              style: const TextStyle(fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section9 = sectionShell(
    number: '9',
    title: 'Reference: bridged ButtonBarTheme members',
    background: refBg,
    accent: refAccent,
    text: refText,
    children: [
      const Text(
        'A direct catalogue of the BridgedClass entries declared in '
        'material_widgets_bridges.b.dart for ButtonBarTheme.',
        style: TextStyle(color: refText, height: 1.4),
      ),
      const SizedBox(height: 10),
      const Text(
        'Constructors:',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      ),
      const SizedBox(height: 4),
      refRow('ButtonBarTheme(...)',
          'const(Key?, ButtonBarThemeData, Widget)',
          'Default constructor; data and child are required.'),
      const SizedBox(height: 8),
      const Text(
        'Static methods:',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      ),
      const SizedBox(height: 4),
      refRow('of', 'ButtonBarThemeData of(BuildContext)',
          'Inherited lookup — falls back to Theme.of(context).buttonBarTheme.'),
      const SizedBox(height: 8),
      const Text(
        'Getters:',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      ),
      const SizedBox(height: 4),
      refRow('key', 'Key?', 'Identifying key for the widget instance.'),
      refRow('hashCode', 'int', 'Standard widget hashCode.'),
      refRow('child', 'Widget', 'The single subtree the theme wraps.'),
      refRow('data', 'ButtonBarThemeData',
          'The propagated ButtonBarThemeData — unbridged value.'),
      const SizedBox(height: 8),
      const Text(
        'Methods:',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      ),
      const SizedBox(height: 4),
      refRow('updateShouldNotify',
          'bool updateShouldNotify(ButtonBarTheme)',
          'True if dependents must rebuild — i.e. data changed.'),
      refRow('==', 'bool operator ==(Object?)',
          'Reference equality on the widget instance.'),
      refRow('toString',
          'String toString({DiagnosticLevel minLevel})',
          'Full diagnostic toString.'),
      refRow('toStringShort', 'String toStringShort()',
          'Shorter form — type and key only.'),
      refRow('toStringShallow',
          'String toStringShallow({String joiner, DiagnosticLevel})',
          'One-level diagnostic dump.'),
      refRow('toStringDeep',
          'String toStringDeep({...})',
          'Recursive diagnostic dump.'),
      refRow('toDiagnosticsNode',
          'DiagnosticsNode toDiagnosticsNode({String? name, ...})',
          'Diagnostics node for tree introspection.'),
      refRow('debugFillProperties',
          'void debugFillProperties(DiagnosticPropertiesBuilder)',
          'Populate a properties builder for the inspector.'),
      refRow('debugDescribeChildren',
          'List<DiagnosticsNode> debugDescribeChildren()',
          'Children list for the inspector.'),
      refRow('createElement',
          'InheritedElement createElement()',
          'Framework-internal element creation hook.'),
    ],
  );

  // ===========================================================================
  // FOOTER
  // ===========================================================================
  final Widget footer = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 6, bottom: 30),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(14),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Every section above feeds the live, ambient ButtonBarThemeData '
          'into a freshly-constructed ButtonBarTheme, then exercises one '
          'bridged member: the static .of(context) lookup, the getters '
          'key/child/data/hashCode, the methods updateShouldNotify, ==, '
          'toString, toStringShort, toStringShallow, and a nested '
          'InheritedWidget lookup that proves .of() walks up the tree.',
          style: TextStyle(color: Colors.white, height: 1.4),
        ),
        SizedBox(height: 8),
        Text(
          'Nothing in this script constructs a ButtonBarThemeData directly: '
          'that class is not bridged in this build. Instead the theme value '
          'is always sourced from the surrounding ThemeData — that is the '
          'idiomatic shape for working with the bridged ButtonBarTheme.',
          style: TextStyle(color: Colors.white70, height: 1.4),
        ),
      ],
    ),
  );

  // ===========================================================================
  // ROOT
  // ===========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ButtonBarTheme Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: heroAccent),
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'ButtonBarTheme — bridged InheritedWidget walkthrough',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1145),
                  ),
                ),
              ),
              section1,
              section2,
              section3,
              section4,
              section5,
              section6,
              section7,
              section8,
              section9,
              footer,
            ],
          ),
        ),
      ),
    ),
  );
}
