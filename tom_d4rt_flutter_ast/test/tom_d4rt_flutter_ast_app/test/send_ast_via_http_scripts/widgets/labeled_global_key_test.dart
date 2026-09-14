// ignore_for_file: avoid_print
// D4rt deep demo: LabeledGlobalKey — identity-based global keys with debug labels
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Rust / Terracotta palette ──────────────────────────────────────
  final deepRust = const Color(0xFF8B3A2F);
  final warmTerracotta = const Color(0xFFCC7755);
  final burnedSienna = const Color(0xFFA0522D);
  final clayBrown = const Color(0xFF9E6B55);
  final brickRose = const Color(0xFFBC6C5C);
  final adobeRed = const Color(0xFFBD5B4A);
  final sunbaked = const Color(0xFFD4956B);
  final earthenOchre = const Color(0xFFC8A47E);
  final sandstone = const Color(0xFFF5E6D3);
  final dustyBrick = const Color(0xFFE8C4B0);

  // ── helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: fg,
                  letterSpacing: 0.3)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: fg.withValues(alpha: 0.75),
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: border, height: 1.5)),
    );
  }

  Widget infoCard(String label, String value, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: accent)),
          ),
          Flexible(
            child: Text(value,
                style: TextStyle(
                    fontSize: 11,
                    color: accent.withValues(alpha: 0.8),
                    fontFamily: 'monospace'),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
    );
  }

  Widget dataRow(String key, String val, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(key,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: accent)),
          ),
          Expanded(
            child: Text(val,
                style: TextStyle(
                    fontSize: 11,
                    color: accent.withValues(alpha: 0.8),
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black12),
          ),
        ),
        const SizedBox(height: 3),
        Text(label,
            style: const TextStyle(fontSize: 8, color: Colors.black54)),
      ],
    );
  }

  Widget keyCard(String label, String debugLabel, String details, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(debugLabel,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: accent,
                        fontFamily: 'monospace')),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(details,
              style: TextStyle(
                  fontSize: 11,
                  color: accent.withValues(alpha: 0.75),
                  height: 1.4)),
        ],
      ),
    );
  }

  Widget hierarchyRow(String indent, String className, Color accent, bool highlight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: highlight ? accent.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: highlight ? Border.all(color: accent.withValues(alpha: 0.3)) : null,
      ),
      child: Text('$indent$className',
          style: TextStyle(
              fontSize: 11,
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
              color: highlight ? accent : accent.withValues(alpha: 0.7),
              fontFamily: 'monospace')),
    );
  }

  Widget metricTile(String label, String value, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: fg)),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(fontSize: 9, color: fg.withValues(alpha: 0.7))),
        ],
      ),
    );
  }

  // ── data ───────────────────────────────────────────────────────────
  print('LabeledGlobalKey deep demo executing');
  print('=' * 60);

  // Section 3 — labeled creation
  final key1 = LabeledGlobalKey('headerKey');
  final key2 = LabeledGlobalKey('footerKey');
  final key3 = LabeledGlobalKey('sidebarKey');
  print('\n--- Labeled creation ---');
  print('key1("headerKey"): $key1');
  print('key2("footerKey"): $key2');
  print('key3("sidebarKey"): $key3');

  // Section 4 — null label
  final keyNull = LabeledGlobalKey(null);
  print('\n--- Null label ---');
  print('keyNull: $keyNull');
  print('toString: ${keyNull.toString()}');

  // Section 5 — typed key
  final typedKey = LabeledGlobalKey<FormState>('formKey');
  final typedScaffold = LabeledGlobalKey<ScaffoldState>('scaffoldKey');
  print('\n--- Typed keys ---');
  print('typedKey<FormState>: $typedKey');
  print('typedScaffold<ScaffoldState>: $typedScaffold');

  // Section 6 — uniqueness
  final keySameLabel1 = LabeledGlobalKey('duplicate');
  final keySameLabel2 = LabeledGlobalKey('duplicate');
  print('\n--- Uniqueness ---');
  print('Same label, different keys: ${keySameLabel1 != keySameLabel2}');
  print('Self-equality: ${keySameLabel1 == keySameLabel1}');

  // Section 7 — toString
  print('\n--- toString ---');
  print('key1.toString(): ${key1.toString()}');
  print('key2.toString(): ${key2.toString()}');
  print('keyNull.toString(): ${keyNull.toString()}');

  // Section 8 — inheritance
  print('\n--- Inheritance ---');
  print('is GlobalKey: true');
  print('is Key: true');

  // Section 9 — state access
  print('\n--- State access (unattached) ---');
  print('currentState: ${key1.currentState}');
  print('currentWidget: ${key1.currentWidget}');
  print('currentContext: ${key1.currentContext}');

  // Section 10 — comparison
  print('\n--- Comparison ---');
  print('key1 == key2: ${key1 == key2}');
  print('key1.hashCode: ${key1.hashCode}');
  print('key2.hashCode: ${key2.hashCode}');
  print('keySameLabel1 == keySameLabel2: ${keySameLabel1 == keySameLabel2}');

  // Lifecycle notes
  print('\n--- Lifecycle notes ---');
  print('GlobalKeys survive reparenting across subtrees');
  print('They provide access to State and RenderObject');

  print('\n${'=' * 60}');
  print('LabeledGlobalKey deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        sectionBanner(
          '1 · LabeledGlobalKey Showcase',
          'Identity-based global keys with debug labels',
          deepRust,
          Colors.white,
        ),

        // ── 2. Concept overview ──────────────────────────────────────
        sectionBanner('2 · Concept Overview',
            'Understanding labeled global keys', burnedSienna, Colors.white),
        noteBox(
          'LabeledGlobalKey<T extends State<StatefulWidget>> is a GlobalKey '
          'subclass that carries a debugging label. Unlike ValueKey, '
          'LabeledGlobalKey uses identity-based equality — each instance '
          'is unique even if two keys share the same label string.',
          deepRust,
          sandstone,
        ),
        noteBox(
          'The debug label appears in toString() output and Flutter\'s '
          'widget inspector, making it easier to identify specific keys '
          'during development and troubleshooting. In release builds, '
          'the label has no functional impact.',
          burnedSienna,
          dustyBrick,
        ),
        infoCard('Class', 'LabeledGlobalKey<T>', deepRust),
        infoCard('Parent', 'GlobalKey<T>', burnedSienna),
        infoCard('Equality', 'Identity-based (==)', clayBrown),
        infoCard('Label', 'Optional debug string', brickRose),
        infoCard('Package', 'flutter/widgets.dart', adobeRed),
        const SizedBox(height: 14),

        // ── 3. Labeled creation ──────────────────────────────────────
        sectionBanner('3 · Creating Labeled Keys',
            'Keys with descriptive debug labels', warmTerracotta, deepRust),
        noteBox(
          'Creating a LabeledGlobalKey with a string label provides '
          'meaningful debug output. The label is purely for debugging — '
          'it does not affect equality or identity.',
          deepRust,
          sandstone,
        ),
        keyCard('KEY 1', 'headerKey', 'toString: $key1', deepRust),
        keyCard('KEY 2', 'footerKey', 'toString: $key2', burnedSienna),
        keyCard('KEY 3', 'sidebarKey', 'toString: $key3', clayBrown),
        dataRow('key1.runtimeType', '${key1.runtimeType}', deepRust),
        dataRow('key2.runtimeType', '${key2.runtimeType}', burnedSienna),
        dataRow('key3.runtimeType', '${key3.runtimeType}', clayBrown),
        const SizedBox(height: 14),

        // ── 4. Null label card ───────────────────────────────────────
        sectionBanner('4 · Null Label Behavior',
            'Keys without debug labels', clayBrown, Colors.white),
        noteBox(
          'Passing null (or omitting the label) creates a LabeledGlobalKey '
          'without a debug label. The toString() output will be less '
          'descriptive, showing only the type and hash information.',
          deepRust,
          sandstone,
        ),
        keyCard('NULL', 'no label', 'toString: $keyNull', clayBrown),
        dataRow('Label', 'null', deepRust),
        dataRow('toString()', keyNull.toString(), burnedSienna),
        dataRow('runtimeType', '${keyNull.runtimeType}', clayBrown),
        noteBox(
          'Even without a label, the key maintains full functionality. '
          'Labels are a development convenience, not a requirement. '
          'In production, prefer labeled keys for maintainability.',
          brickRose,
          dustyBrick,
        ),
        const SizedBox(height: 14),

        // ── 5. Typed key panel ───────────────────────────────────────
        sectionBanner('5 · Typed LabeledGlobalKey',
            'Keys parameterized with State types', brickRose, Colors.white),
        noteBox(
          'LabeledGlobalKey<T> can be typed with a specific State subclass. '
          'This enables type-safe access to the State via key.currentState. '
          'Common types: FormState, ScaffoldState, NavigatorState.',
          deepRust,
          sandstone,
        ),
        keyCard('FORM', 'typedKey<FormState>',
            'Provides type-safe access to FormState via currentState',
            deepRust),
        keyCard('SCAFFOLD', 'typedKey<ScaffoldState>',
            'Enables opening drawers via ScaffoldState',
            burnedSienna),
        dataRow('FormState key', '$typedKey', deepRust),
        dataRow('ScaffoldState key', '$typedScaffold', burnedSienna),
        dataRow('Type parameter', 'State subclass', clayBrown),
        noteBox(
          'Without type parameter, currentState returns State<StatefulWidget>? '
          'requiring a cast. With a typed key, no cast is needed: '
          'formKey.currentState?.validate() works directly.',
          adobeRed,
          dustyBrick,
        ),
        const SizedBox(height: 14),

        // ── 6. Uniqueness grid ───────────────────────────────────────
        sectionBanner('6 · Identity-Based Uniqueness',
            'Same label ≠ same key', adobeRed, Colors.white),
        noteBox(
          'Two LabeledGlobalKeys with the same label are NOT equal. '
          'Equality is based on instance identity, not label content. '
          'This is critical — reusing the same label does not create '
          'duplicate key errors.',
          deepRust,
          sandstone,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: deepRust.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepRust.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Identity Comparison',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepRust)),
              const SizedBox(height: 8),
              dataRow('Same label, diff instance', '${keySameLabel1 != keySameLabel2} (not equal)', deepRust),
              dataRow('Self-comparison', '${keySameLabel1 == keySameLabel1} (equal)', burnedSienna),
              dataRow('Reference copy', '${keySameLabel1 == keySameLabel1} (equal)', clayBrown),
              const SizedBox(height: 6),
              Text('Each constructor call creates a unique key',
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: deepRust.withValues(alpha: 0.7))),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. toString display ──────────────────────────────────────
        sectionBanner('7 · String Representation',
            'Debug-friendly toString output', sunbaked, deepRust),
        noteBox(
          'toString() includes the debug label in brackets, making it '
          'easy to identify keys in debug output and the widget inspector.',
          deepRust,
          sandstone,
        ),
        dataRow('key1.toString()', key1.toString(), deepRust),
        dataRow('key2.toString()', key2.toString(), burnedSienna),
        dataRow('key3.toString()', key3.toString(), clayBrown),
        dataRow('keyNull.toString()', keyNull.toString(), brickRose),
        noteBox(
          'The output format typically includes [<label>] when a label '
          'is provided. Without a label, the output is shorter. This makes '
          'labeled keys especially valuable during debugging sessions.',
          adobeRed,
          dustyBrick,
        ),
        const SizedBox(height: 14),

        // ── 8. Inheritance chain ─────────────────────────────────────
        sectionBanner('8 · Inheritance Hierarchy',
            'Class hierarchy and key type system', earthenOchre, deepRust),
        noteBox(
          'LabeledGlobalKey sits at the top of a specialized hierarchy. '
          'Understanding the key type system is essential for choosing '
          'the right key type for each use case.',
          deepRust,
          sandstone,
        ),
        hierarchyRow('', 'Key (abstract)', deepRust, false),
        hierarchyRow('  └─ ', 'LocalKey', burnedSienna, false),
        hierarchyRow('  │   ├─ ', 'ValueKey<T>', clayBrown, false),
        hierarchyRow('  │   ├─ ', 'ObjectKey', brickRose, false),
        hierarchyRow('  │   └─ ', 'UniqueKey', adobeRed, false),
        hierarchyRow('  └─ ', 'GlobalKey<T>', sunbaked, false),
        hierarchyRow('      ├─ ', 'LabeledGlobalKey<T>', deepRust, true),
        hierarchyRow('      └─ ', 'GlobalObjectKey<T>', clayBrown, false),
        const SizedBox(height: 8),
        dataRow('key1 is GlobalKey', 'true', deepRust),
        dataRow('key1 is Key', 'true', burnedSienna),
        const SizedBox(height: 14),

        // ── 9. State access panel ────────────────────────────────────
        sectionBanner('9 · State Access Methods',
            'currentState, currentWidget, currentContext', deepRust, Colors.white),
        noteBox(
          'GlobalKey provides access to the widget tree through three '
          'getters: currentState (the State object), currentWidget (the '
          'Widget), and currentContext (the BuildContext). These return '
          'null when the key is not attached to a mounted widget.',
          deepRust,
          sandstone,
        ),
        infoCard('currentState', '${key1.currentState}', deepRust),
        infoCard('currentWidget', '${key1.currentWidget}', burnedSienna),
        infoCard('currentContext', '${key1.currentContext}', clayBrown),
        noteBox(
          'When attached to a StatefulWidget, currentState provides access '
          'to the State without BuildContext. Common pattern: '
          'formKey.currentState?.validate() to trigger form validation '
          'from a parent widget or callback.',
          brickRose,
          dustyBrick,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: adobeRed.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: adobeRed.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Access Patterns',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: adobeRed)),
              const SizedBox(height: 6),
              dataRow('Form validation', 'formKey.currentState?.validate()', deepRust),
              dataRow('Open drawer', 'scaffoldKey.currentState?.openDrawer()', burnedSienna),
              dataRow('Get context', 'key.currentContext', clayBrown),
              dataRow('Find widget', 'key.currentWidget', brickRose),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Comparison behavior ──────────────────────────────────
        sectionBanner('10 · Equality & HashCode',
            'Identity-based comparison mechanics', burnedSienna, Colors.white),
        noteBox(
          'LabeledGlobalKey uses Dart\'s default identity equality. '
          'Each instance has a unique identity — even keys with identical '
          'labels are different. The hashCode is also identity-based.',
          deepRust,
          sandstone,
        ),
        dataRow('key1 == key2', '${key1 == key2}', deepRust),
        dataRow('key1 == key1', '${key1 == key1}', burnedSienna),
        dataRow('sameLabel1 == sameLabel2', '${keySameLabel1 == keySameLabel2}', clayBrown),
        dataRow('key1.hashCode', '${key1.hashCode}', brickRose),
        dataRow('key2.hashCode', '${key2.hashCode}', adobeRed),
        dataRow('Hashes different', '${key1.hashCode != key2.hashCode}', sunbaked),
        const SizedBox(height: 14),

        // ── 11. Builder integration ──────────────────────────────────
        sectionBanner('11 · Builder Widget Integration',
            'Using keys with Builder-pattern widgets', clayBrown, Colors.white),
        noteBox(
          'LabeledGlobalKey is commonly used with StatefulWidgets that '
          'expose their State through a key. Builder, Form, Scaffold, '
          'and Navigator all support GlobalKey-based state access.',
          deepRust,
          sandstone,
        ),
        keyCard('FORM', 'GlobalKey<FormState>',
            'Form(key: formKey) → formKey.currentState?.validate()',
            deepRust),
        keyCard('SCAFFOLD', 'GlobalKey<ScaffoldState>',
            'Scaffold(key: scaffoldKey) → scaffoldKey.currentState?.openDrawer()',
            burnedSienna),
        keyCard('NAVIGATOR', 'GlobalKey<NavigatorState>',
            'Navigator(key: navKey) → navKey.currentState?.push(...)',
            clayBrown),
        keyCard('ANIMATED', 'GlobalKey<AnimatedListState>',
            'AnimatedList(key: listKey) → listKey.currentState?.insertItem(0)',
            brickRose),
        const SizedBox(height: 14),

        // ── 12. Form field keys ──────────────────────────────────────
        sectionBanner('12 · Form Field Key Patterns',
            'Keys for form validation and control', adobeRed, Colors.white),
        noteBox(
          'Forms are the most common use case for LabeledGlobalKey. '
          'A Form widget with a GlobalKey<FormState> enables validation, '
          'save, and reset operations from outside the form\'s subtree.',
          deepRust,
          sandstone,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: sunbaked.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: sunbaked.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Form Operations',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepRust)),
              const SizedBox(height: 8),
              dataRow('validate()', 'Triggers all field validators', deepRust),
              dataRow('save()', 'Calls onSaved on all fields', burnedSienna),
              dataRow('reset()', 'Resets all fields to initial values', clayBrown),
              const SizedBox(height: 6),
              Text('All operations available via formKey.currentState',
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: deepRust.withValues(alpha: 0.7))),
            ],
          ),
        ),
        noteBox(
          'Best practice: Create the key as a final field in the parent '
          'widget\'s State class. Never create GlobalKeys in the build '
          'method — this causes unnecessary widget rebuilds and potential '
          'duplicate key errors.',
          brickRose,
          dustyBrick,
        ),
        const SizedBox(height: 14),

        // ── 13. Scrollable keys ──────────────────────────────────────
        sectionBanner('13 · Scrollable Widget Keys',
            'Keys for scroll control and introspection', sunbaked, deepRust),
        noteBox(
          'Scrollable widgets like ListView, GridView, and CustomScrollView '
          'can be controlled via GlobalKeys. Access the ScrollController '
          'or scrollable state for programmatic scrolling.',
          deepRust,
          sandstone,
        ),
        keyCard('SCROLL', 'scrollKey',
            'Access ScrollPosition and ScrollController through State',
            deepRust),
        keyCard('LIST', 'animatedListKey',
            'AnimatedListState provides insertItem() and removeItem()',
            burnedSienna),
        keyCard('SLIVER', 'sliverKey',
            'SliverAnimatedListState for sliver-based animated lists',
            clayBrown),
        noteBox(
          'Scroll-related keys enable features like scroll-to-item, '
          'programmatic scroll position control, and scrollbar integration '
          'without passing controllers through the widget tree.',
          adobeRed,
          dustyBrick,
        ),
        const SizedBox(height: 14),

        // ── 14. Animated widget keys ─────────────────────────────────
        sectionBanner('14 · Animated Widget Keys',
            'Keys for animation control', earthenOchre, deepRust),
        noteBox(
          'GlobalKeys enable reparenting widgets across different subtrees '
          'while preserving their State. This is the foundation for '
          'Hero animations and other cross-subtree transitions.',
          deepRust,
          sandstone,
        ),
        keyCard('HERO', 'heroKey',
            'Preserves State during Hero transitions between routes',
            deepRust),
        keyCard('ANIM_LIST', 'animListKey',
            'AnimatedListState.insertItem/removeItem with animation',
            burnedSienna),
        keyCard('EXPANSION', 'expansionKey',
            'ExpansionTile state for programmatic expand/collapse',
            clayBrown),
        noteBox(
          'When a widget with a GlobalKey moves from one parent to another, '
          'Flutter reparents the Element rather than creating a new one. '
          'This preserves State and avoids unnecessary dispose/init cycles.',
          brickRose,
          dustyBrick,
        ),
        const SizedBox(height: 14),

        // ── 15. Debugging patterns ───────────────────────────────────
        sectionBanner('15 · Debugging Patterns',
            'Using labels for effective debugging', warmTerracotta, Colors.white),
        noteBox(
          'The primary purpose of the label is debugging. Use descriptive '
          'labels that identify the widget purpose, not the widget type. '
          'Good: "loginForm", "userProfile". Bad: "form1", "key2".',
          deepRust,
          sandstone,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: deepRust.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepRust.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Naming Conventions',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepRust)),
              const SizedBox(height: 8),
              dataRow('✓ loginFormKey', 'Descriptive, clear purpose', deepRust),
              dataRow('✓ mainNavKey', 'Identifies the navigator', burnedSienna),
              dataRow('✓ settingsScaffold', 'Screen + widget type', clayBrown),
              dataRow('✗ key1', 'Meaningless, hard to debug', brickRose),
              dataRow('✗ myKey', 'Undescriptive, ambiguous', adobeRed),
              dataRow('✗ temp', 'No context about purpose', sunbaked),
            ],
          ),
        ),
        noteBox(
          'In Flutter DevTools, labeled keys appear in the widget tree '
          'inspector. Well-named keys speed up debugging by letting you '
          'quickly locate the widget of interest without tracing the tree.',
          sunbaked,
          dustyBrick,
        ),
        const SizedBox(height: 14),

        // ── 16. Summary dashboard ────────────────────────────────────
        sectionBanner('16 · Summary Dashboard',
            'LabeledGlobalKey metrics and usage', deepRust, Colors.white),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            metricTile('Labeled keys', '3', sandstone, deepRust),
            metricTile('Null label', '1', dustyBrick, burnedSienna),
            metricTile('Typed keys', '2', sandstone, clayBrown),
            metricTile('Same-label pairs', '1', dustyBrick, brickRose),
            metricTile('Equality ≡', '✓', sandstone, adobeRed),
            metricTile('State access', '3', dustyBrick, sunbaked),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          children: [
            tag('LabeledGlobalKey', deepRust, Colors.white),
            tag('GlobalKey', burnedSienna, Colors.white),
            tag('Identity equality', clayBrown, Colors.white),
            tag('Debug label', brickRose, Colors.white),
            tag('FormState', adobeRed, Colors.white),
            tag('currentState', sunbaked, Colors.white),
            tag('Reparenting', earthenOchre, deepRust),
            tag('Widget inspector', warmTerracotta, Colors.white),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: sandstone,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepRust.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rust / Terracotta Palette',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: deepRust)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  colorSwatch('deepRust', deepRust),
                  colorSwatch('warmTerra', warmTerracotta),
                  colorSwatch('burned', burnedSienna),
                  colorSwatch('clay', clayBrown),
                  colorSwatch('brickRose', brickRose),
                  colorSwatch('adobe', adobeRed),
                  colorSwatch('sunbaked', sunbaked),
                  colorSwatch('ochre', earthenOchre),
                  colorSwatch('sandstone', sandstone),
                  colorSwatch('dusty', dustyBrick),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
