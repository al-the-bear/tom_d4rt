// ignore_for_file: avoid_print
// InheritedElement – comprehensive deep demo
// Cerulean / Sky palette – the Element behind InheritedWidget that manages
// dependency tracking and propagation of shared data down the widget tree.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color ieCerulean = Color(0xFF0277BD);
  const Color ieSky = Color(0xFFE1F5FE);
  const Color ieOnCerulean = Color(0xFFFFFFFF);
  const Color ieDark = Color(0xFF004C8C);
  const Color ieLightSky = Color(0xFFF0FAFF);
  const Color ieTextDark = Color(0xFF0D2137);
  const Color ieAccent = Color(0xFF03A9F4);
  const Color ieMuted = Color(0xFF81D4FA);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget ieHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ieCerulean, ieDark],
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
                  color: ieOnCerulean)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: ieOnCerulean.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget ieSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: ieLightSky,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ieCerulean.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: ieCerulean.withValues(alpha: 0.07),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ieCerulean)),
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

  Widget ieBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('▸ ',
              style: TextStyle(color: ieAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: ieTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget ieCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF001B30),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: ieSky,
              height: 1.5)),
    );
  }

  Widget ieKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: ieDark)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ieTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ieHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ieAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ieAccent.withValues(alpha: 0.2)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: ieDark,
              height: 1.4)),
    );
  }

  Widget ieDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: ieMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget ieCompare(String label, String desc) {
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
              color: ieCerulean,
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
                          color: ieDark)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: ieTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ieInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ieCerulean.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: ieCerulean)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ieDark)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ieTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ieFlowStep(String step, String desc, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(step,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(desc,
                style: const TextStyle(fontSize: 11, color: ieTextDark)),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: ieSky,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          ieHeader(
            'InheritedElement',
            'The Element behind InheritedWidget — manages the dependency '
                'map, tracks which descendants depend on shared data, and '
                'triggers rebuilds when that data changes',
          ),

          // ── 1. class identity ──
          ieSection('1 · Class Identity & Hierarchy', [
            ieKeyValue('Class', 'InheritedElement'),
            ieKeyValue('Extends', 'ProxyElement'),
            ieKeyValue('ProxyElement extends', 'ComponentElement'),
            ieKeyValue('Widget type', 'InheritedWidget'),
            ieKeyValue('Library', 'package:flutter/widgets.dart'),
            ieDivider(),
            ieBullet(
                'InheritedElement is the element counterpart of '
                'InheritedWidget. Every InheritedWidget in the tree '
                'creates one InheritedElement.'),
            ieBullet(
                'Its key job: maintain a map of dependent elements and '
                'notify them when the inherited data changes.'),
          ]),

          // ── 2. element hierarchy ──
          ieSection('2 · Element Type Hierarchy', [
            ieCodeBlock(
                '// Element\n'
                '//   └─ ComponentElement\n'
                '//       └─ ProxyElement\n'
                '//           └─ InheritedElement      ← this class\n'
                '//               └─ InheritedModelElement\n'
                '//\n'
                '// InheritedWidget → creates → InheritedElement\n'
                '// InheritedModel  → creates → InheritedModelElement'),
            ieDivider(),
            ieBullet(
                'ProxyElement is a ComponentElement that delegates its '
                'build to the widget. It wraps a single child and '
                'provides a notification mechanism.'),
          ]),

          // ── 3. the _dependents map ──
          ieSection('3 · The _dependents Map', [
            ieHighlight(
                'The heart of InheritedElement is a Map<Element, Object?> '
                'called _dependents. It maps each dependent element to '
                'an optional "aspect" value used for selective rebuilds.'),
            ieCodeBlock(
                '// Internal state:\n'
                'final Map<Element, Object?> _dependents = {};\n'
                '\n'
                '// When a widget calls:\n'
                '// context.dependOnInheritedWidgetOfExactType<MyData>()\n'
                '//\n'
                '// The framework calls:\n'
                '// inheritedElement.updateDependencies(dependent, null);\n'
                '//\n'
                '// Which by default does:\n'
                '// _dependents[dependent] = null;'),
            ieDivider(),
            ieKeyValue('Key', 'Element (the dependent)'),
            ieKeyValue('Value',
                'Object? (aspect — null for full dependency)'),
          ]),

          // ── 4. dependency registration flow ──
          ieSection('4 · Dependency Registration Flow', [
            ieFlowStep('1', 'Descendant calls '
                'context.dependOnInheritedWidgetOfExactType<T>()',
                const Color(0xFF0277BD)),
            ieFlowStep('2', 'Framework looks up InheritedElement of type T '
                'in the ancestor chain',
                const Color(0xFF1B5E20)),
            ieFlowStep('3', 'Calls inheritedElement.updateDependencies('
                'dependent, aspect)',
                const Color(0xFFE65100)),
            ieFlowStep('4', 'Default: _dependents[dependent] = aspect '
                '(stores the dependency)',
                const Color(0xFF6A1B9A)),
            ieFlowStep('5', 'Returns the InheritedWidget so the caller '
                'can read data from it',
                const Color(0xFF880E4F)),
            ieDivider(),
            ieCodeBlock(
                '// Example: Theme.of(context)\n'
                '//\n'
                '// 1. Theme.of calls:\n'
                '//    context.dependOnInheritedWidgetOfExactType<_InheritedTheme>()\n'
                '//\n'
                '// 2. Framework finds the _InheritedTheme element\n'
                '//\n'
                '// 3. Registers calling element as dependent\n'
                '//\n'
                '// 4. Returns _InheritedTheme widget\n'
                '//\n'
                '// 5. Theme.of extracts ThemeData from the widget'),
          ]),

          // ── 5. notification flow ──
          ieSection('5 · Notification Flow (Data Changes)', [
            ieFlowStep('1', 'Parent rebuilds InheritedWidget with new data',
                const Color(0xFF0277BD)),
            ieFlowStep('2', 'Framework calls updated(oldWidget) on '
                'InheritedElement',
                const Color(0xFF1B5E20)),
            ieFlowStep('3', 'updated() calls widget.updateShouldNotify('
                'oldWidget)',
                const Color(0xFFE65100)),
            ieFlowStep('4', 'If true → calls notifyClients(oldWidget)',
                const Color(0xFF6A1B9A)),
            ieFlowStep('5', 'notifyClients iterates _dependents and calls '
                'notifyDependent for each',
                const Color(0xFF880E4F)),
            ieFlowStep('6', 'notifyDependent calls dependent.'
                'didChangeDependencies()',
                const Color(0xFF283593)),
            ieFlowStep('7', 'Dependent element is marked dirty → rebuilds '
                'in next frame',
                const Color(0xFF004D40)),
            ieDivider(),
            ieCodeBlock(
                '// Notification chain:\n'
                'void updated(InheritedWidget oldWidget) {\n'
                '  if (widget.updateShouldNotify(oldWidget)) {\n'
                '    super.updated(oldWidget);\n'
                '    // → calls notifyClients(oldWidget)\n'
                '  }\n'
                '}\n'
                '\n'
                'void notifyClients(InheritedWidget oldWidget) {\n'
                '  for (final dependent in _dependents.keys) {\n'
                '    notifyDependent(oldWidget, dependent);\n'
                '  }\n'
                '}\n'
                '\n'
                'void notifyDependent(\n'
                '    InheritedWidget oldWidget, Element dependent) {\n'
                '  dependent.didChangeDependencies();\n'
                '}'),
          ]),

          // ── 6. updateShouldNotify ──
          ieSection('6 · updateShouldNotify', [
            ieBullet(
                'updateShouldNotify is defined on the InheritedWidget '
                '(not on InheritedElement). It decides whether dependents '
                'should be notified.'),
            ieCodeBlock(
                '// Typical implementation:\n'
                'class MyInheritedData extends InheritedWidget {\n'
                '  final int value;\n'
                '  // ...\n'
                '\n'
                '  @override\n'
                '  bool updateShouldNotify(MyInheritedData oldWidget) {\n'
                '    return value != oldWidget.value;\n'
                '  }\n'
                '}\n'
                '\n'
                '// If returns false → no dependents are notified\n'
                '// If returns true  → all dependents rebuild'),
            ieDivider(),
            ieHighlight(
                'updateShouldNotify is all-or-nothing. Either ALL '
                'dependents are notified or NONE are. For selective '
                'notification (per-aspect), use InheritedModel instead.'),
          ]),

          // ── 7. _inheritedElements lookup map ──
          ieSection('7 · The _inheritedElements Lookup', [
            ieBullet(
                'Every Element maintains a Map<Type, InheritedElement> '
                'called _inheritedElements (inherited from parent).'),
            ieBullet(
                'When an InheritedElement activates, it inserts itself '
                'into this map under its widget type.'),
            ieCodeBlock(
                '// _updateInheritance:\n'
                'void _updateInheritance() {\n'
                '  final incomingMap = _parent?._inheritedElements;\n'
                '  _inheritedElements = HashMap.from(incomingMap ?? {});\n'
                '  _inheritedElements[widget.runtimeType] = this;\n'
                '}\n'
                '\n'
                '// This is why dependOnInheritedWidgetOfExactType<T>\n'
                '// is O(1) — it just does a map lookup by Type.'),
            ieDivider(),
            ieBullet(
                'Each InheritedElement shadows any ancestor of the same '
                'type. The nearest InheritedWidget of a given type wins.'),
          ]),

          // ── 8. common InheritedWidget examples ──
          ieSection('8 · Common InheritedWidget Examples', [
            ieCompare('Theme',
                '_InheritedTheme → ThemeData for styling'),
            ieCompare('MediaQuery',
                'MediaQuery → screen size, orientation, padding'),
            ieCompare('Directionality',
                'Directionality → TextDirection (LTR/RTL)'),
            ieCompare('DefaultTextStyle',
                '_InheritedDefaultTextStyle → fallback text style'),
            ieCompare('Localizations',
                '_LocalizationsScope → locale and translated strings'),
            ieCompare('Navigator',
                'NavigatorState accessible via Navigator.of(context)'),
            ieCompare('Scaffold',
                'ScaffoldMessenger for SnackBars via context'),
            ieDivider(),
            ieBullet(
                'All of these use InheritedWidget + InheritedElement '
                'under the hood. The "of(context)" pattern is a '
                'convention for accessing inherited data.'),
          ]),

          // ── 9. the of(context) pattern ──
          ieSection('9 · The of(context) Pattern', [
            ieCodeBlock(
                '// Standard pattern:\n'
                'class MyData extends InheritedWidget {\n'
                '  final String value;\n'
                '  const MyData({required this.value, required super.child});\n'
                '\n'
                '  // The "of" accessor:\n'
                '  static MyData of(BuildContext context) {\n'
                '    final result = context\n'
                '        .dependOnInheritedWidgetOfExactType<MyData>();\n'
                '    assert(result != null, "No MyData in tree");\n'
                '    return result!;\n'
                '  }\n'
                '\n'
                '  // Optional: maybeOf for nullable access\n'
                '  static MyData? maybeOf(BuildContext context) {\n'
                '    return context\n'
                '        .dependOnInheritedWidgetOfExactType<MyData>();\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  bool updateShouldNotify(MyData oldWidget) {\n'
                '    return value != oldWidget.value;\n'
                '  }\n'
                '}'),
            ieDivider(),
            ieBullet(
                'of(context) calls dependOnInheritedWidgetOfExactType, '
                'which registers a dependency AND returns the widget.'),
            ieBullet(
                'maybeOf returns null instead of asserting, useful when '
                'the inherited widget might not be in the tree.'),
          ]),

          // ── 10. InheritedModel extension ──
          ieSection('10 · InheritedModel & Aspect-Based Updates', [
            ieBullet(
                'InheritedModel extends InheritedWidget and uses '
                'InheritedModelElement (extends InheritedElement).'),
            ieBullet(
                'It adds aspect-based selective notification — only '
                'dependents that care about changed aspects rebuild.'),
            ieCodeBlock(
                '// InheritedModel adds:\n'
                '//  - isSupportedAspect(aspect)\n'
                '//  - updateShouldNotifyDependent(old, dependencies)\n'
                '//\n'
                '// Dependent registers with aspect:\n'
                '// InheritedModel.inheritFrom<MyModel>(\n'
                '//   context,\n'
                '//   aspect: "color",  // only rebuilds for color\n'
                '// );\n'
                '//\n'
                '// When data changes:\n'
                '// - Checks which aspects changed\n'
                '// - Only notifies dependents whose aspects match'),
            ieDivider(),
            ieHighlight(
                'InheritedModel solves the "too many rebuilds" problem. '
                'With plain InheritedWidget, changing ANY field notifies '
                'ALL dependents. With InheritedModel, only dependents '
                'interested in the changed aspect rebuild.'),
          ]),

          // ── 11. didChangeDependencies ──
          ieSection('11 · didChangeDependencies Lifecycle', [
            ieBullet(
                'When InheritedElement notifies a dependent, it calls '
                'dependent.didChangeDependencies().'),
            ieBullet(
                'For StatefulWidget elements, this calls the State '
                'method didChangeDependencies(), which marks the '
                'element as needing build.'),
            ieCodeBlock(
                '// In State<T>:\n'
                '@override\n'
                'void didChangeDependencies() {\n'
                '  super.didChangeDependencies();\n'
                '  // Called when inherited data changes.\n'
                '  // Use to re-read inherited data and react.\n'
                '  // Avoid heavy work — this fires every update.\n'
                '}'),
            ieDivider(),
            ieBullet(
                'didChangeDependencies is also called after initState. '
                'It is safe to call of(context) here.'),
          ]),

          // ── 12. deactivation cleanup ──
          ieSection('12 · Deactivation & Dependency Cleanup', [
            ieBullet(
                'When a dependent element is removed from the tree, '
                'its dependencies are cleaned up: it is removed from '
                'all InheritedElement _dependents maps.'),
            ieCodeBlock(
                '// Cleanup sequence:\n'
                '// 1. Element.deactivate() called on dependent\n'
                '// 2. For each InheritedElement in _dependencies:\n'
                '//    inheritedElement._dependents.remove(this);\n'
                '// 3. _dependencies.clear()\n'
                '//\n'
                '// InheritedElement.deactivate():\n'
                '// Asserts _dependents is empty (debug only)'),
          ]),

          // ── 13. performance characteristics ──
          ieSection('13 · Performance Characteristics', [
            ieInfoRow('O', 'Lookup:', 'O(1) map access by Type'),
            ieInfoRow('O', 'Register:', 'O(1) map insert'),
            ieInfoRow('N', 'Notify:', 'O(N) — N is number of dependents'),
            ieDivider(),
            ieBullet(
                'The lookup is O(1) because _inheritedElements is a '
                'HashMap. This is why Theme.of(context) is fast.'),
            ieBullet(
                'Notification scales with dependents. A Theme at the '
                'root with 100 dependent widgets will visit all 100 '
                'when the theme changes.'),
            ieBullet(
                'To minimize rebuild cost, place InheritedWidgets as '
                'deep as possible (nearest common ancestor) or use '
                'InheritedModel for aspect-based filtering.'),
          ]),

          // ── 14. visual: tree propagation ──
          ieSection('14 · Tree Propagation Diagram', [
            ieCodeBlock(
                '// Widget tree with InheritedWidget:\n'
                '//\n'
                '// MaterialApp\n'
                '//   └─ Theme (InheritedWidget)\n'
                '//       └─ _InheritedTheme\n'
                '//           └─ Scaffold\n'
                '//               ├─ AppBar\n'
                '//               │   └─ Text  ← depends on Theme\n'
                '//               └─ Body\n'
                '//                   ├─ Card ← depends on Theme\n'
                '//                   └─ Button ← depends on Theme\n'
                '//\n'
                '// InheritedElement._dependents =\n'
                '//   { TextElement, CardElement, ButtonElement }\n'
                '//\n'
                '// Theme change → all 3 notified → all 3 rebuild'),
          ]),

          // ── 15. Provider pattern ──
          ieSection('15 · Relation to Provider / Riverpod', [
            ieBullet(
                'The Provider package wraps InheritedWidget with a '
                'simpler API and adds features like lazy initialization '
                'and automatic disposal.'),
            ieBullet(
                'Under the hood, Provider creates an InheritedWidget '
                'and uses the same InheritedElement dependency system.'),
            ieCodeBlock(
                '// Provider under the hood:\n'
                '//\n'
                '// Provider<T>       → InheritedProvider<T>\n'
                '//                     → InheritedWidget\n'
                '//                       → InheritedElement\n'
                '//\n'
                '// Provider.of<T>(context)\n'
                '//   ≡ context.dependOnInheritedWidgetOfExactType<...>()\n'
                '//\n'
                '// context.read<T>()  → no dependency registration\n'
                '// context.watch<T>() → with dependency registration'),
            ieDivider(),
            ieBullet(
                'context.read() uses getElementForInheritedWidgetOfExactType '
                'which does NOT register a dependency — the widget will '
                'not rebuild when the value changes.'),
          ]),

          // ── 16. quick reference ──
          ieSection('16 · Quick API Reference', [
            ieKeyValue('Class', 'InheritedElement'),
            ieKeyValue('Extends', 'ProxyElement'),
            ieKeyValue('_dependents', 'Map<Element, Object?>'),
            ieKeyValue('getDependencies', '(Element) → Object?'),
            ieKeyValue('setDependencies', '(Element, Object?) → void'),
            ieKeyValue('updateDependencies', '(Element, Object?) → void'),
            ieKeyValue('notifyClients', '(InheritedWidget) → void'),
            ieKeyValue('notifyDependent',
                '(InheritedWidget, Element) → void'),
            ieDivider(),
            ieCodeBlock(
                '// Summary:\n'
                '// InheritedElement is the bridge between\n'
                '// InheritedWidget (data) and dependent Elements.\n'
                '//\n'
                '// Registration: dependOnInheritedWidgetOfExactType\n'
                '// Notification: updateShouldNotify → notifyClients\n'
                '// Cleanup: dependencies removed on deactivate\n'
                '//\n'
                '// The foundation for Theme.of, MediaQuery.of,\n'
                '// Provider, and all context-based data sharing.'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: ieCerulean.withValues(alpha: 0.06),
            child: const Text(
              'InheritedElement · Cerulean Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: ieMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
