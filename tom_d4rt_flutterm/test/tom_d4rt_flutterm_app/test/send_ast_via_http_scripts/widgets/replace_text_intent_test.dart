import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers (stateless pattern — no StatefulWidget)
// ---------------------------------------------------------------------------

final ValueNotifier<TextEditingValue> _editorValue = ValueNotifier<TextEditingValue>(
  const TextEditingValue(
    text: 'The quick brown fox jumps over the lazy dog.',
    selection: TextSelection(baseOffset: 4, extentOffset: 9),
  ),
);

final ValueNotifier<String> _logNotifier = ValueNotifier<String>('');

final ValueNotifier<SelectionChangedCause> _causeNotifier =
    ValueNotifier<SelectionChangedCause>(SelectionChangedCause.keyboard);

final ValueNotifier<String> _replacementText =
    ValueNotifier<String>('speedy');

// ---------------------------------------------------------------------------
// Entry point required by harness
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return _ReplaceTextIntentDemoApp();
}

// ---------------------------------------------------------------------------
// Root app widget
// ---------------------------------------------------------------------------

class _ReplaceTextIntentDemoApp extends StatelessWidget {
  const _ReplaceTextIntentDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReplaceTextIntent Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A90D9)),
      ),
      home: const _ReplaceTextIntentHome(),
    );
  }
}

// ---------------------------------------------------------------------------
// Home scaffold with DefaultTabController (~9 tabs)
// ---------------------------------------------------------------------------

class _ReplaceTextIntentHome extends StatelessWidget {
  const _ReplaceTextIntentHome();

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Hero'),
    Tab(text: 'Live Demo'),
    Tab(text: 'Construction'),
    Tab(text: 'Cause Gallery'),
    Tab(text: 'Custom Action'),
    Tab(text: 'Compare'),
    Tab(text: 'Diagram'),
    Tab(text: 'Selection'),
    Tab(text: 'Pitfalls & API'),
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(
          backgroundColor: cs.primaryContainer,
          foregroundColor: cs.onPrimaryContainer,
          title: const Text('ReplaceTextIntent Deep Demo'),
          bottom: TabBar(
            isScrollable: true,
            labelColor: cs.onPrimaryContainer,
            indicatorColor: cs.primary,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroBanner(),
            _LiveReplacementDemo(),
            _ConstructionWalkthrough(),
            _CauseGallery(),
            _CustomActionSection(),
            _CompareTable(),
            _DiagramSection(),
            _SelectionVisualization(),
            _PitfallsAndApi(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, {this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: tt.headlineSmall?.copyWith(color: cs.primary, fontWeight: FontWeight.w700)),
        if (subtitle != null) ...<Widget>[
          const SizedBox(height: 4),
          Text(subtitle!, style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          height: 1.6,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body, this.icon});
  final String title;
  final String body;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      color: cs.primaryContainer.withAlpha(80),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(icon, color: cs.primary, size: 24),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: cs.onSurface)),
                  const SizedBox(height: 4),
                  Text(body, style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(color: Theme.of(context).colorScheme.outlineVariant),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 1 — Hero Banner
// ---------------------------------------------------------------------------

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Hero card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[cs.primaryContainer, cs.secondaryContainer],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: cs.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'flutter/services.dart',
                        style: tt.labelSmall?.copyWith(color: cs.onPrimary, fontFamily: 'monospace'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: cs.secondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Intent',
                        style: tt.labelSmall?.copyWith(color: cs.onSecondary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'ReplaceTextIntent',
                  style: tt.displaySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: cs.onPrimaryContainer,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'An Intent that carries everything needed to replace a TextSelection range '
                  'inside the current TextEditingValue with new text — including the resulting '
                  'cursor position and the cause of the change.',
                  style: tt.bodyLarge?.copyWith(color: cs.onPrimaryContainer),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _SectionTitle(
            'What is ReplaceTextIntent?',
            subtitle: 'The canonical way to describe a text-replacement operation in the Actions/Intents system.',
          ),

          Text(
            'In Flutter\'s text editing pipeline, text modifications are expressed as Intents '
            'and handled by Actions. ReplaceTextIntent is the Intent designed to express '
            '"replace the bytes in this selection with this new string". Unlike direct '
            'controller.text = … mutations, it goes through the Actions/Intents dispatch '
            'mechanism, allowing any widget ancestor to intercept, modify, or block the '
            'replacement — enabling features like auto-correct, spell-check, and undo.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),

          _SectionTitle('Class Hierarchy'),
          _CodeBlock(
            'Object\n'
            '  └─ Intent                        (flutter/widgets.dart)\n'
            '       └─ ReplaceTextIntent        (flutter/services.dart)\n'
            '\n'
            'class ReplaceTextIntent extends Intent {\n'
            '  const ReplaceTextIntent(\n'
            '    this.currentTextEditingValue,   // snapshot of current state\n'
            '    this.replacementText,            // the new string\n'
            '    this.replacementSelection,       // resulting cursor/selection\n'
            '    this.cause,                      // why the change happened\n'
            '  );\n'
            '}',
          ),
          const SizedBox(height: 20),

          _SectionTitle('Where it fits in the system'),
          const _InfoCard(
            icon: Icons.keyboard,
            title: 'Input Layer',
            body: 'RawKeyboard / HardwareKeyboard events or virtual keyboard input triggers text editing shortcuts.',
          ),
          const SizedBox(height: 8),
          const _InfoCard(
            icon: Icons.send,
            title: 'Intent Dispatch',
            body: 'Actions.invoke(context, ReplaceTextIntent(...)) sends the intent up the widget tree via the Actions/Intents mechanism.',
          ),
          const SizedBox(height: 8),
          const _InfoCard(
            icon: Icons.settings,
            title: 'Action Handling',
            body: 'ReplaceTextAction (the default handler registered by EditableText) receives the intent and applies the replacement to the controller.',
          ),
          const SizedBox(height: 8),
          const _InfoCard(
            icon: Icons.edit_note,
            title: 'Controller Update',
            body: 'TextEditingController.value is updated with the new TextEditingValue, triggering a rebuild of dependent widgets.',
          ),
          const SizedBox(height: 20),

          _SectionTitle('Key benefits over direct mutation'),
          _buildBenefitRow(context, 'Interceptable', 'Ancestors can override behavior via custom Actions.'),
          const SizedBox(height: 8),
          _buildBenefitRow(context, 'Undoable', 'Undo/redo stacks can observe intents rather than raw value changes.'),
          const SizedBox(height: 8),
          _buildBenefitRow(context, 'Cause-aware', 'The SelectionChangedCause field lets handlers react differently to keyboard vs tap vs drag.'),
          const SizedBox(height: 8),
          _buildBenefitRow(context, 'Composable', 'Can be wrapped, transformed, or conditionally dispatched by custom action handlers.'),
          const SizedBox(height: 24),

          _SectionTitle('Handled by'),
          _CodeBlock(
            'class ReplaceTextAction extends Action<ReplaceTextIntent> {\n'
            '  @override\n'
            '  Object? invoke(ReplaceTextIntent intent) {\n'
            '    // Applies intent.replacementText to\n'
            '    // intent.currentTextEditingValue at\n'
            '    // intent.currentTextEditingValue.selection,\n'
            '    // then updates controller.value with\n'
            '    // intent.replacementSelection as the new cursor.\n'
            '  }\n'
            '}',
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.tertiaryContainer.withAlpha(120),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.tertiary.withAlpha(80)),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.lightbulb_outline, color: cs.tertiary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tip: ReplaceTextIntent is particularly useful for building '
                    'autocomplete, spell-check overlays, and template-expansion '
                    'features, because it lets you surgically replace a selection '
                    'without disturbing focus or the undo history in unexpected ways.',
                    style: tt.bodySmall?.copyWith(color: cs.onTertiaryContainer),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBenefitRow(BuildContext context, String label, String desc) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(label, style: tt.labelMedium?.copyWith(color: cs.primary, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(desc, style: tt.bodyMedium)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 2 — Live Replacement Demo
// ---------------------------------------------------------------------------

class _LiveReplacementDemo extends StatelessWidget {
  const _LiveReplacementDemo();

  void _replaceSelected(BuildContext context) {
    final TextEditingValue current = _editorValue.value;
    final String newText = current.selection.isValid && !current.selection.isCollapsed
        ? current.text.replaceRange(
            current.selection.start,
            current.selection.end,
            _replacementText.value,
          )
        : current.text;
    final int newCursorPos = current.selection.isValid && !current.selection.isCollapsed
        ? current.selection.start + _replacementText.value.length
        : current.text.length;
    final TextEditingValue updated = current.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newCursorPos),
    );
    final TextSelection newSelection = TextSelection.collapsed(offset: newCursorPos);
    _log('ReplaceTextIntent dispatched:\n'
        '  replacementText: "${_replacementText.value}"\n'
        '  replacementSelection: $newSelection\n'
        '  cause: ${_causeNotifier.value}');
    _editorValue.value = updated;
  }

  void _replaceAll(BuildContext context) {
    final TextEditingValue current = _editorValue.value;
    final String word = current.selection.isValid && !current.selection.isCollapsed
        ? current.text.substring(current.selection.start, current.selection.end)
        : 'fox';
    final String newText = current.text.replaceAll(word, _replacementText.value);
    final TextEditingValue updated = current.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
    _log('ReplaceTextIntent (replace-all) dispatched:\n'
        '  target word: "$word"\n'
        '  replacementText: "${_replacementText.value}"\n'
        '  cause: ${_causeNotifier.value}');
    _editorValue.value = updated;
  }

  void _reset() {
    _editorValue.value = const TextEditingValue(
      text: 'The quick brown fox jumps over the lazy dog.',
      selection: TextSelection(baseOffset: 4, extentOffset: 9),
    );
    _logNotifier.value = '';
  }

  static void _log(String msg) {
    final String timestamp = DateTime.now().toIso8601String().substring(11, 19);
    _logNotifier.value = '[$timestamp] $msg\n${_logNotifier.value}';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            'Live Replacement Demo',
            subtitle: 'Select text in the field, choose a cause, then dispatch a ReplaceTextIntent.',
          ),

          // Text field driven by ValueNotifier
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _editorValue,
            builder: (BuildContext ctx, TextEditingValue val, _) {
              return _EditableFieldCard(
                value: val,
                onChanged: (TextEditingValue v) => _editorValue.value = v,
              );
            },
          ),
          const SizedBox(height: 16),

          // Replacement text input
          Text('Replacement text:', style: tt.labelLarge),
          const SizedBox(height: 8),
          ValueListenableBuilder<String>(
            valueListenable: _replacementText,
            builder: (BuildContext ctx, String val, _) {
              return TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Type replacement text…',
                  filled: true,
                  fillColor: cs.surfaceContainerLow,
                ),
                controller: TextEditingController(text: val),
                onChanged: (String v) => _replacementText.value = v,
              );
            },
          ),
          const SizedBox(height: 16),

          // Cause selector
          Text('SelectionChangedCause:', style: tt.labelLarge),
          const SizedBox(height: 8),
          ValueListenableBuilder<SelectionChangedCause>(
            valueListenable: _causeNotifier,
            builder: (BuildContext ctx, SelectionChangedCause selected, _) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: SelectionChangedCause.values.map((SelectionChangedCause c) {
                  return ChoiceChip(
                    label: Text(c.name),
                    selected: selected == c,
                    onSelected: (_) => _causeNotifier.value = c,
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 20),

          // Action buttons
          Row(
            children: <Widget>[
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.find_replace),
                  label: const Text('Replace Selected'),
                  onPressed: () => _replaceSelected(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () => _replaceAll(context),
                  child: const Text('Replace All'),
                ),
              ),
              const SizedBox(width: 12),
              IconButton.outlined(
                icon: const Icon(Icons.refresh),
                tooltip: 'Reset',
                onPressed: _reset,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Current value display
          Text('Current TextEditingValue:', style: tt.labelLarge),
          const SizedBox(height: 8),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _editorValue,
            builder: (BuildContext ctx, TextEditingValue val, _) {
              return _CodeBlock(
                'TextEditingValue(\n'
                '  text: "${val.text}",\n'
                '  selection: TextSelection(\n'
                '    baseOffset:   ${val.selection.baseOffset},\n'
                '    extentOffset: ${val.selection.extentOffset},\n'
                '    affinity:     ${val.selection.affinity},\n'
                '  ),\n'
                ')',
              );
            },
          ),
          const SizedBox(height: 24),

          // Intent construction preview
          Text('Intent that would be constructed:', style: tt.labelLarge),
          const SizedBox(height: 8),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _editorValue,
            builder: (BuildContext ctx, TextEditingValue val, _) {
              return ValueListenableBuilder<String>(
                valueListenable: _replacementText,
                builder: (BuildContext ctx2, String rt, _) {
                  return ValueListenableBuilder<SelectionChangedCause>(
                    valueListenable: _causeNotifier,
                    builder: (BuildContext ctx3, SelectionChangedCause cause, _) {
                      final int start = val.selection.start < 0 ? 0 : val.selection.start;
                      return _CodeBlock(
                        'Actions.invoke(\n'
                        '  context,\n'
                        '  ReplaceTextIntent(\n'
                        '    controller.value,\n'
                        '    "$rt",\n'
                        '    TextRange.collapsed($start + ${rt.length}), // = offset ${start + rt.length}\n'
                        '    SelectionChangedCause.${cause.name},\n'
                        '  ),\n'
                        ');',
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),

          // Event log
          Text('Event Log:', style: tt.labelLarge),
          const SizedBox(height: 8),
          ValueListenableBuilder<String>(
            valueListenable: _logNotifier,
            builder: (BuildContext ctx, String log, _) {
              return Container(
                width: double.infinity,
                height: 180,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cs.outlineVariant),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    log.isEmpty ? '(no events yet — tap a button above)' : log,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Editable field card — pure stateless, driven by ValueNotifier
class _EditableFieldCard extends StatelessWidget {
  const _EditableFieldCard({required this.value, required this.onChanged});
  final TextEditingValue value;
  final ValueChanged<TextEditingValue> onChanged;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final TextEditingController controller = TextEditingController.fromValue(value);
    return Card(
      elevation: 1,
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('TextField (select a word, then hit Replace Selected)', style: tt.labelMedium),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type or select text here…',
              ),
              onChanged: (String text) {
                onChanged(TextEditingValue(
                  text: text,
                  selection: controller.selection,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 3 — Construction Walkthrough
// ---------------------------------------------------------------------------

class _ConstructionWalkthrough extends StatelessWidget {
  const _ConstructionWalkthrough();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            'Construction Walkthrough',
            subtitle: 'Step-by-step guide to building a ReplaceTextIntent with all 4 parameters.',
          ),

          _buildStep(
            context,
            step: '01',
            label: 'currentTextEditingValue',
            type: 'TextEditingValue',
            description:
                'A snapshot of the editing state at the moment the intent is created. '
                'Capture this from the controller BEFORE any mutation. '
                'It holds the full text string, the current selection, and any composing region.',
            code:
                'final TextEditingValue current = controller.value;\n'
                '// e.g. TextEditingValue(\n'
                '//   text: "Hello world",\n'
                '//   selection: TextSelection(baseOffset: 6, extentOffset: 11),\n'
                '//)  ← "world" is selected',
          ),
          const SizedBox(height: 20),

          _buildStep(
            context,
            step: '02',
            label: 'replacementText',
            type: 'String',
            description:
                'The new string to insert in place of the selected range. '
                'This is a plain Dart String — no TextSpan or rich formatting. '
                'To replace with nothing (i.e. delete), pass an empty string "".',
            code:
                'const String replacement = "Flutter";\n'
                '// Replaces "world" with "Flutter"\n'
                '// Result: "Hello Flutter"',
          ),
          const SizedBox(height: 20),

          _buildStep(
            context,
            step: '03',
            label: 'replacementSelection',
            type: 'TextSelection',
            description:
                'The TextSelection that should be set AFTER the replacement. '
                'Usually a collapsed selection placed at the end of the inserted text '
                '(i.e. selection.start + replacementText.length). '
                'You can also set a range if you want the new text pre-selected.',
            code:
                'final TextSelection newSel = TextSelection.collapsed(\n'
                '  offset: current.selection.start + replacement.length,\n'
                ');  // cursor after "Flutter" → offset 13',
          ),
          const SizedBox(height: 20),

          _buildStep(
            context,
            step: '04',
            label: 'cause',
            type: 'SelectionChangedCause',
            description:
                'Indicates what triggered this replacement. The handler may adjust '
                'behavior based on this. For programmatic replacements (auto-correct, '
                'template expansion) use SelectionChangedCause.keyboard. '
                'For tap-triggered replacements use SelectionChangedCause.tap.',
            code:
                'const SelectionChangedCause cause =\n'
                '    SelectionChangedCause.keyboard;',
          ),
          const SizedBox(height: 24),

          Text('Full constructor call:', style: tt.labelLarge),
          const SizedBox(height: 8),
          _CodeBlock(
            '// 1. Snapshot\n'
            'final TextEditingValue current = controller.value;\n'
            '\n'
            '// 2. Replacement string\n'
            'const String replacement = "Flutter";\n'
            '\n'
            '// 3. Resulting selection (collapsed, after inserted text)\n'
            'final TextSelection newSel = TextSelection.collapsed(\n'
            '  offset: current.selection.start + replacement.length,\n'
            ');\n'
            '\n'
            '// 4. Cause\n'
            'const SelectionChangedCause cause = SelectionChangedCause.keyboard;\n'
            '\n'
            '// 5. Construct and dispatch\n'
            'Actions.invoke(\n'
            '  context,\n'
            '  ReplaceTextIntent(\n'
            '    current,        // currentTextEditingValue\n'
            '    replacement,    // replacementText\n'
            '    newSel,         // replacementSelection\n'
            '    cause,          // cause\n'
            '  ),\n'
            ');',
          ),
          const SizedBox(height: 24),

          // Annotated parameter table
          Text('Parameter annotations:', style: tt.labelLarge),
          const SizedBox(height: 12),
          _buildParamTable(context),
          const SizedBox(height: 24),

          // Constructor signature
          Text('Constructor signature (from Flutter source):', style: tt.labelLarge),
          const SizedBox(height: 8),
          _CodeBlock(
            'const ReplaceTextIntent(\n'
            '  this.currentTextEditingValue,\n'
            '  this.replacementText,\n'
            '  this.replacementSelection,\n'
            '  this.cause,\n'
            ');\n'
            '\n'
            'final TextEditingValue currentTextEditingValue;\n'
            'final String replacementText;\n'
            'final TextSelection replacementSelection;\n'
            'final SelectionChangedCause cause;',
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.errorContainer.withAlpha(80),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.warning_amber_rounded, color: cs.error),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Important: All fields are final — ReplaceTextIntent is immutable. '
                    'The intent describes intent only; the actual mutation is performed '
                    'by the corresponding ReplaceTextAction handler.',
                    style: tt.bodySmall?.copyWith(color: cs.onErrorContainer),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required String step,
    required String label,
    required String type,
    required String description,
    required String code,
  }) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: cs.primary, width: 4)),
        color: cs.surfaceContainerLow,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
                child: Center(
                  child: Text(step, style: tt.labelSmall?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(label, style: tt.titleSmall?.copyWith(fontFamily: 'monospace', color: cs.primary)),
                  Text(type, style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant, fontFamily: 'monospace')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: tt.bodyMedium),
          const SizedBox(height: 12),
          _CodeBlock(code),
        ],
      ),
    );
  }

  Widget _buildParamTable(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    const List<List<String>> rows = <List<String>>[
      ['currentTextEditingValue', 'TextEditingValue', 'Snapshot before replacement', 'Required'],
      ['replacementText', 'String', 'The new string to insert', 'Required'],
      ['replacementSelection', 'TextSelection', 'Cursor/selection after insert', 'Required'],
      ['cause', 'SelectionChangedCause', 'What triggered the intent', 'Required'],
    ];
    return Table(
      border: TableBorder.all(color: cs.outlineVariant, borderRadius: BorderRadius.circular(8)),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2.5),
        1: FlexColumnWidth(2.5),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(1.5),
      },
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: cs.primaryContainer),
          children: <Widget>[
            _tableCell(context, 'Parameter', header: true),
            _tableCell(context, 'Type', header: true),
            _tableCell(context, 'Description', header: true),
            _tableCell(context, 'Required', header: true),
          ],
        ),
        ...rows.map((List<String> row) => TableRow(
          children: row.map((String cell) => _tableCell(context, cell)).toList(),
        )),
      ],
    );
  }

  Widget _tableCell(BuildContext context, String text, {bool header = false}) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Text(
        text,
        style: header
            ? tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: cs.onPrimaryContainer)
            : tt.bodySmall?.copyWith(fontFamily: text.contains('Value') || text.contains('Selection') || text.contains('Cause') || text.contains('String') ? 'monospace' : null),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 4 — SelectionChangedCause Gallery
// ---------------------------------------------------------------------------

class _CauseGallery extends StatelessWidget {
  const _CauseGallery();

  static const Map<SelectionChangedCause, _CauseInfo> _info = <SelectionChangedCause, _CauseInfo>{
    SelectionChangedCause.keyboard: _CauseInfo(
      icon: Icons.keyboard,
      label: 'keyboard',
      description:
          'The selection changed because the user pressed a key on the hardware or software keyboard. '
          'Most common for text insertions triggered programmatically or by shortcuts.',
      example: 'Auto-complete inserting a suggestion via keyboard shortcut.',
    ),
    SelectionChangedCause.tap: _CauseInfo(
      icon: Icons.touch_app,
      label: 'tap',
      description:
          'The selection changed because the user tapped on the text field. '
          'A single tap typically collapses the selection to the tapped position.',
      example: 'User taps between characters to reposition cursor.',
    ),
    SelectionChangedCause.toolbar: _CauseInfo(
      icon: Icons.text_fields,
      label: 'toolbar',
      description:
          'The selection changed due to an action triggered from the text selection toolbar '
          '(e.g. the Cut, Copy, Paste, or Select All buttons that appear above selected text).',
      example: 'User presses "Select All" in the selection toolbar.',
    ),
    SelectionChangedCause.doubleTap: _CauseInfo(
      icon: Icons.ads_click,
      label: 'doubleTap',
      description:
          'The selection changed because the user double-tapped. '
          'On most platforms, this selects the word under the tap position.',
      example: 'User double-taps on a word to select it.',
    ),
    SelectionChangedCause.longPress: _CauseInfo(
      icon: Icons.touch_app_outlined,
      label: 'longPress',
      description:
          'The selection changed because the user performed a long press. '
          'This typically activates the selection handles for dragging.',
      example: 'Long press to start a selection, then drag handles.',
    ),
    SelectionChangedCause.forcePress: _CauseInfo(
      icon: Icons.compress,
      label: 'forcePress',
      description:
          'The selection changed due to a force press (3D Touch on supported iOS devices). '
          'Force pressing in a text field may trigger cursor placement.',
      example: 'Force touch on iOS to position cursor precisely.',
    ),
    SelectionChangedCause.drag: _CauseInfo(
      icon: Icons.drag_handle,
      label: 'drag',
      description:
          'The selection changed because the user dragged a selection handle. '
          'Used when the user has already started a selection and is modifying its extent.',
      example: 'Dragging the blue handle to extend or shrink selected text.',
    ),
    SelectionChangedCause.stylusHandwriting: _CauseInfo(
      icon: Icons.draw,
      label: 'stylusHandwriting',
      description:
          'The selection changed due to stylus handwriting (Apple Pencil Scribble on iPadOS 14+ '
          'or Android Scribe on API 34+). Translates handwriting directly into typed text.',
      example: 'User writes with Apple Pencil and Scribble converts to text.',
    ),
  };

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            'SelectionChangedCause Gallery',
            subtitle: 'All 8 enum values that can be passed as the cause parameter.',
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.secondaryContainer.withAlpha(100),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'SelectionChangedCause describes WHY a text selection changed. '
              'It is used by the framework and by custom action handlers to apply '
              'platform-specific or context-specific behavior. For example, a toolbar '
              'action may animate differently than a keyboard-triggered replacement.',
              style: tt.bodyMedium,
            ),
          ),
          const SizedBox(height: 20),

          ..._info.entries.map((MapEntry<SelectionChangedCause, _CauseInfo> entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CauseCard(cause: entry.key, info: entry.value),
            );
          }),

          const SizedBox(height: 16),
          Text('Usage in ReplaceTextIntent:', style: tt.labelLarge),
          const SizedBox(height: 8),
          _CodeBlock(
            '// Choose the cause that reflects WHY the replacement is happening:\n'
            '\n'
            'ReplaceTextIntent(\n'
            '  controller.value,\n'
            '  "replacement",\n'
            '  newSelection,\n'
            '  SelectionChangedCause.keyboard,   // ← programmatic / shortcut\n'
            ');\n'
            '\n'
            'ReplaceTextIntent(\n'
            '  controller.value,\n'
            '  "replacement",\n'
            '  newSelection,\n'
            '  SelectionChangedCause.toolbar,    // ← toolbar button\n'
            ');',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _CauseInfo {
  const _CauseInfo({
    required this.icon,
    required this.label,
    required this.description,
    required this.example,
  });
  final IconData icon;
  final String label;
  final String description;
  final String example;
}

class _CauseCard extends StatelessWidget {
  const _CauseCard({required this.cause, required this.info});
  final SelectionChangedCause cause;
  final _CauseInfo info;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(info.icon, color: cs.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'SelectionChangedCause.${info.label}',
                        style: tt.labelLarge?.copyWith(fontFamily: 'monospace', color: cs.primary),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(info.label, style: tt.labelSmall),
                  backgroundColor: cs.secondaryContainer,
                  side: BorderSide.none,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(info.description, style: tt.bodyMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: cs.tertiaryContainer.withAlpha(100),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.lightbulb_outline, size: 16, color: cs.tertiary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Example: ${info.example}',
                      style: tt.bodySmall?.copyWith(color: cs.onSurface, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 5 — Custom ReplaceTextAction
// ---------------------------------------------------------------------------

class _AutoCorrectAction extends Action<ReplaceTextIntent> {
  @override
  Object? invoke(ReplaceTextIntent intent) {
    // Custom logic: capitalise the first letter of the replacement text.
    final String raw = intent.replacementText;
    final String capitalised = raw.isEmpty
        ? raw
        : raw[0].toUpperCase() + raw.substring(1);

    // Build the new text by applying replacement manually.
    final TextEditingValue current = intent.currentTextEditingValue;
    final String newText = current.selection.isValid
        ? current.text.replaceRange(
            current.selection.start,
            current.selection.end,
            capitalised,
          )
        : current.text;

    _logNotifier.value =
        '[AutoCorrect] Capitalised "$raw" → "$capitalised"\n${_logNotifier.value}';

    // In a real app you'd update controller.value here.
    // For demo purposes we update the shared ValueNotifier.
    // Use the replacementRange.end as the new cursor position.
    final int newCursor = intent.replacementRange.start + capitalised.length;
    _editorValue.value = current.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newCursor),
    );
    return null;
  }
}

class _CustomActionSection extends StatelessWidget {
  const _CustomActionSection();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            'Custom ReplaceTextAction',
            subtitle: 'Override the default handler to apply custom logic on every replacement.',
          ),

          Text(
            'By wrapping your widget tree in an Actions widget that maps '
            'ReplaceTextIntent to your own Action subclass, you can intercept '
            'every replacement operation — enabling features like auto-capitalisation, '
            'profanity filtering, template expansion, or emoji substitution.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),

          Text('Defining _AutoCorrectAction:', style: tt.labelLarge),
          const SizedBox(height: 8),
          _CodeBlock(
            'class _AutoCorrectAction extends Action<ReplaceTextIntent> {\n'
            '  @override\n'
            '  Object? invoke(ReplaceTextIntent intent) {\n'
            '    // Intercept the intent\n'
            '    final String raw = intent.replacementText;\n'
            '\n'
            '    // Apply custom logic: capitalise first letter\n'
            '    final String capitalised = raw.isEmpty\n'
            '        ? raw\n'
            '        : raw[0].toUpperCase() + raw.substring(1);\n'
            '\n'
            '    // Build updated TextEditingValue\n'
            '    final TextEditingValue current = intent.currentTextEditingValue;\n'
            '    final String newText = current.selection.isValid\n'
            '        ? current.text.replaceRange(\n'
            '            current.selection.start,\n'
            '            current.selection.end,\n'
            '            capitalised,\n'
            '          )\n'
            '        : current.text;\n'
            '\n'
            '    // Update controller\n'
            '    controller.value = current.copyWith(\n'
            '      text: newText,\n'
            '      selection: intent.replacementSelection,\n'
            '    );\n'
            '    return null;\n'
            '  }\n'
            '}',
          ),
          const SizedBox(height: 20),

          Text('Registering it in the widget tree:', style: tt.labelLarge),
          const SizedBox(height: 8),
          _CodeBlock(
            'Actions(\n'
            '  actions: <Type, Action<Intent>>{\n'
            '    ReplaceTextIntent: _AutoCorrectAction(),\n'
            '  },\n'
            '  child: Builder(\n'
            '    builder: (BuildContext context) {\n'
            '      return TextField(\n'
            '        controller: controller,\n'
            '        // TextField internally dispatches ReplaceTextIntent;\n'
            '        // our action intercepts it above.\n'
            '      );\n'
            '    },\n'
            '  ),\n'
            ');',
          ),
          const SizedBox(height: 24),

          Text('Live demo — dispatch via _AutoCorrectAction:', style: tt.labelLarge),
          const SizedBox(height: 12),
          _AutoCorrectDemo(),
          const SizedBox(height: 24),

          _SectionTitle('Other custom action patterns'),
          _buildPattern(
            context,
            title: 'Profanity filter',
            description: 'Check replacementText against a blocklist; if matched, replace with asterisks instead.',
            code: 'if (_blocklist.contains(raw)) return \'*\' * raw.length;',
          ),
          const SizedBox(height: 12),
          _buildPattern(
            context,
            title: 'Emoji substitution',
            description: 'Convert text emoticons like ":)" to emoji characters "😊" on the fly.',
            code: 'if (raw == \':)\') return \'😊\';',
          ),
          const SizedBox(height: 12),
          _buildPattern(
            context,
            title: 'Template expansion',
            description: 'Expand short codes like "addr" into a full address template.',
            code: 'if (raw == \'addr\') return \'123 Main St, City, State 00000\';',
          ),
          const SizedBox(height: 12),
          _buildPattern(
            context,
            title: 'Async validation',
            description: 'Invoke a server-side spell-check before committing the replacement.',
            code: '// Note: invoke() is synchronous — schedule async work separately.',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPattern(BuildContext context, {
    required String title,
    required String description,
    required String code,
  }) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(description, style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
          const SizedBox(height: 8),
          _CodeBlock(code),
        ],
      ),
    );
  }
}

class _AutoCorrectDemo extends StatelessWidget {
  _AutoCorrectDemo();

  final TextEditingController _controller = TextEditingController(text: 'hello world');

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Actions(
      actions: <Type, Action<Intent>>{
        ReplaceTextIntent: _AutoCorrectAction(),
      },
      child: Builder(
        builder: (BuildContext ctx) {
          return Card(
            elevation: 0,
            color: cs.surfaceContainerLow,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Type lowercase text and press the button — the custom action will capitalise it.',
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Text field (with _AutoCorrectAction)',
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    icon: const Icon(Icons.auto_fix_high),
                    label: const Text('Capitalise selected via _AutoCorrectAction'),
                    onPressed: () {
                      final TextEditingValue current = _controller.value;
                      if (!current.selection.isValid || current.selection.isCollapsed) return;
                      final String selectedWord = current.text.substring(
                        current.selection.start,
                        current.selection.end,
                      );
                      final TextSelection newSel = TextSelection.collapsed(
                        offset: current.selection.start + selectedWord.length,
                      );
                      Actions.invoke(
                        ctx,
                        ReplaceTextIntent(
                          current,
                          selectedWord,
                          newSel,
                          SelectionChangedCause.keyboard,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 6 — Compare with other text intents
// ---------------------------------------------------------------------------

class _CompareTable extends StatelessWidget {
  const _CompareTable();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    const List<_IntentCompareRow> rows = <_IntentCompareRow>[
      _IntentCompareRow(
        name: 'ReplaceTextIntent',
        purpose: 'Replace a TextSelection range with new text',
        params: '4 (value, text, selection, cause)',
        typical: 'Auto-complete, spell-correct, template insert',
        action: 'ReplaceTextAction',
        selectAware: true,
      ),
      _IntentCompareRow(
        name: 'DeleteCharacterIntent',
        purpose: 'Delete one character before/after the cursor',
        params: '1 (forward: bool)',
        typical: 'Backspace / Delete key',
        action: 'DeleteCharacterAction',
        selectAware: false,
      ),
      _IntentCompareRow(
        name: 'InsertTextIntent',
        purpose: 'Insert a string at the current cursor position',
        params: '2 (text, value)',
        typical: 'Regular typing, paste snippet',
        action: 'InsertTextAction',
        selectAware: false,
      ),
      _IntentCompareRow(
        name: 'ExtendSelectionByCharacterIntent',
        purpose: 'Extend/shrink the selection by one character',
        params: '2 (forward, collapseSelection)',
        typical: 'Shift+Arrow keys',
        action: 'ExtendSelectionByCharacterAction',
        selectAware: true,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            'Compare with Other Text Intents',
            subtitle: 'How ReplaceTextIntent fits alongside the other text editing intents.',
          ),

          Text(
            'Flutter\'s text editing Actions/Intents system defines a family of Intents, '
            'each targeting a specific editing operation. ReplaceTextIntent is the most '
            'expressive, because it carries a full snapshot plus the desired output state.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),

          // Comparison cards
          ...rows.map((row) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _IntentCompareCard(row: row, isHighlighted: row.name == 'ReplaceTextIntent'),
          )),

          const SizedBox(height: 24),
          Text('Side-by-side code comparison:', style: tt.labelLarge),
          const SizedBox(height: 8),
          _CodeBlock(
            '// ReplaceTextIntent — replace a selection with new text\n'
            'Actions.invoke(context, ReplaceTextIntent(\n'
            '  controller.value,\n'
            '  "replacement",\n'
            '  TextSelection.collapsed(offset: newOffset),\n'
            '  SelectionChangedCause.keyboard,\n'
            '));\n'
            '\n'
            '// DeleteCharacterIntent — delete one char\n'
            'Actions.invoke(context, DeleteCharacterIntent(forward: false));\n'
            '\n'
            '// InsertTextIntent — insert at cursor (no selection replace)\n'
            'Actions.invoke(context, InsertTextIntent(\n'
            '  "inserted text",\n'
            '  controller.value,\n'
            '));\n'
            '\n'
            '// ExtendSelectionByCharacterIntent — Shift+Right\n'
            'Actions.invoke(context, ExtendSelectionByCharacterIntent(\n'
            '  forward: true,\n'
            '  collapseSelection: false,\n'
            '));',
          ),
          const SizedBox(height: 24),

          // Decision guide
          _SectionTitle('Decision guide: which intent to use?'),
          _buildDecisionRow(context, 'Replace selected text with something', 'ReplaceTextIntent ✓'),
          const SizedBox(height: 8),
          _buildDecisionRow(context, 'Insert text at cursor (no selection)', 'InsertTextIntent'),
          const SizedBox(height: 8),
          _buildDecisionRow(context, 'Delete the character before cursor', 'DeleteCharacterIntent(forward: false)'),
          const SizedBox(height: 8),
          _buildDecisionRow(context, 'Extend selection by one char', 'ExtendSelectionByCharacterIntent'),
          const SizedBox(height: 8),
          _buildDecisionRow(context, 'Delete entire word', 'DeleteToNextWordBoundaryIntent'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDecisionRow(BuildContext context, String scenario, String answer) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final bool isHighlighted = answer.contains('✓');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isHighlighted ? cs.primaryContainer.withAlpha(120) : cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: isHighlighted ? Border.all(color: cs.primary.withAlpha(80)) : null,
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(scenario, style: tt.bodyMedium)),
          const SizedBox(width: 12),
          Text(
            answer,
            style: tt.labelSmall?.copyWith(
              fontFamily: 'monospace',
              color: isHighlighted ? cs.primary : cs.onSurfaceVariant,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _IntentCompareRow {
  const _IntentCompareRow({
    required this.name,
    required this.purpose,
    required this.params,
    required this.typical,
    required this.action,
    required this.selectAware,
  });
  final String name;
  final String purpose;
  final String params;
  final String typical;
  final String action;
  final bool selectAware;
}

class _IntentCompareCard extends StatelessWidget {
  const _IntentCompareCard({required this.row, required this.isHighlighted});
  final _IntentCompareRow row;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      color: isHighlighted ? cs.primaryContainer.withAlpha(140) : cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: isHighlighted
            ? BorderSide(color: cs.primary, width: 2)
            : BorderSide(color: cs.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    row.name,
                    style: tt.labelLarge?.copyWith(
                      fontFamily: 'monospace',
                      color: isHighlighted ? cs.primary : cs.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (isHighlighted)
                  Chip(
                    label: const Text('This intent'),
                    backgroundColor: cs.primary,
                    labelStyle: tt.labelSmall?.copyWith(color: cs.onPrimary),
                    side: BorderSide.none,
                  ),
                if (row.selectAware)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Chip(
                      label: const Text('selection-aware'),
                      backgroundColor: cs.secondaryContainer,
                      side: BorderSide.none,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            _buildRow(context, 'Purpose', row.purpose),
            _buildRow(context, 'Params', row.params),
            _buildRow(context, 'Typical use', row.typical),
            _buildRow(context, 'Default action', row.action),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(label, style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
          ),
          Expanded(child: Text(value, style: tt.bodySmall)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 7 — Diagram (CustomPainter)
// ---------------------------------------------------------------------------

class _DiagramSection extends StatelessWidget {
  const _DiagramSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            'Intent Flow Diagram',
            subtitle: 'From keyboard shortcut to TextEditingController.value update.',
          ),

          Text(
            'The diagram below shows the full lifecycle of a ReplaceTextIntent '
            'from the moment a keyboard shortcut is triggered to when the '
            'TextEditingController is updated with the new value.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cs.outlineVariant),
            ),
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 420,
              child: CustomPaint(
                painter: _FlowDiagramPainter(colorScheme: cs),
                size: const Size(double.infinity, 420),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Text('Step-by-step breakdown:', style: tt.labelLarge),
          const SizedBox(height: 12),
          _buildStep(context, '1', 'Keyboard Shortcut / Input',
              'A hardware key event or virtual keyboard input triggers a text editing shortcut.'),
          const SizedBox(height: 8),
          _buildStep(context, '2', 'DefaultTextEditingActions',
              'The built-in set of Actions registered by EditableText receives the key event and maps it to a text editing Intent.'),
          const SizedBox(height: 8),
          _buildStep(context, '3', 'ReplaceTextIntent constructed',
              'A ReplaceTextIntent is created with the current TextEditingValue, replacement text, new selection, and cause.'),
          const SizedBox(height: 8),
          _buildStep(context, '4', 'Actions.invoke()',
              'The intent is dispatched up the widget tree. Custom Action overrides are checked first.'),
          const SizedBox(height: 8),
          _buildStep(context, '5', 'ReplaceTextAction.invoke()',
              'The action applies the replacement to the TextEditingValue snapshot from the intent.'),
          const SizedBox(height: 8),
          _buildStep(context, '6', 'controller.value updated',
              'The TextEditingController.value is set to the new TextEditingValue with updated text and selection.'),
          const SizedBox(height: 8),
          _buildStep(context, '7', 'Widget rebuild',
              'All widgets listening to the controller (TextField, ValueListenableBuilder, etc.) rebuild to reflect the change.'),
          const SizedBox(height: 20),

          _CodeBlock(
            '// The sequence in code:\n'
            '\n'
            '// 1. Key event received by EditableText\n'
            '// 2. ReplaceTextIntent constructed internally:\n'
            'final intent = ReplaceTextIntent(\n'
            '  controller.value,            // snapshot\n'
            '  "new text",                  // replacement\n'
            '  TextSelection.collapsed(     // result selection\n'
            '    offset: newOffset,\n'
            '  ),\n'
            '  SelectionChangedCause.keyboard,\n'
            ');\n'
            '\n'
            '// 3. Dispatched:\n'
            'Actions.invoke(context, intent);\n'
            '\n'
            '// 4. Default (or custom) action invoked:\n'
            '// ReplaceTextAction.invoke(intent) → controller.value = newValue;\n'
            '\n'
            '// 5. Rebuild triggered automatically.',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, String num, String title, String desc) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
          child: Center(child: Text(num, style: tt.labelSmall?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
              Text(desc, style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }
}

class _FlowDiagramPainter extends CustomPainter {
  const _FlowDiagramPainter({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final Color primary = colorScheme.primary;
    final Color primaryContainer = colorScheme.primaryContainer;
    final Color secondary = colorScheme.secondary;
    final Color secondaryContainer = colorScheme.secondaryContainer;
    final Color tertiary = colorScheme.tertiary;
    final Color tertiaryContainer = colorScheme.tertiaryContainer;
    final Color onSurface = colorScheme.onSurface;

    const double boxW = 180;
    const double boxH = 48;
    const double gap = 20;
    final double centerX = size.width / 2;
    final double startY = 16;

    final List<_DiagramNode> nodes = <_DiagramNode>[
      _DiagramNode('⌨  Keyboard Shortcut', primaryContainer, primary),
      _DiagramNode('DefaultTextEditingActions', secondaryContainer, secondary),
      _DiagramNode('ReplaceTextIntent created', primaryContainer, primary),
      _DiagramNode('Actions.invoke(context, intent)', tertiaryContainer, tertiary),
      _DiagramNode('ReplaceTextAction.invoke()', secondaryContainer, secondary),
      _DiagramNode('controller.value = newValue', primaryContainer, primary),
      _DiagramNode('Widget Rebuild ✓', tertiaryContainer, tertiary),
    ];

    double y = startY;
    for (int i = 0; i < nodes.length; i++) {
      final _DiagramNode node = nodes[i];
      final RRect rRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(centerX - boxW / 2, y, boxW, boxH),
        const Radius.circular(10),
      );
      boxPaint.color = node.fill;
      borderPaint.color = node.border;
      canvas.drawRRect(rRect, boxPaint);
      canvas.drawRRect(rRect, borderPaint);

      // Label
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: node.label,
          style: TextStyle(
            color: onSurface,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxW - 16);
      tp.paint(canvas, Offset(centerX - tp.width / 2, y + (boxH - tp.height) / 2));

      // Arrow to next node
      if (i < nodes.length - 1) {
        arrowPaint.color = node.border;
        final double arrowStartY = y + boxH + 4;
        final double arrowEndY = y + boxH + gap - 4;
        final Offset start = Offset(centerX, arrowStartY);
        final Offset end = Offset(centerX, arrowEndY);
        canvas.drawLine(start, end, arrowPaint);
        // Arrowhead
        const double headSize = 6;
        final Path arrowHead = Path()
          ..moveTo(end.dx, end.dy)
          ..lineTo(end.dx - headSize, end.dy - headSize)
          ..lineTo(end.dx + headSize, end.dy - headSize)
          ..close();
        canvas.drawPath(arrowHead, Paint()..color = node.border..style = PaintingStyle.fill);
      }

      y += boxH + gap;
    }
  }

  @override
  bool shouldRepaint(_FlowDiagramPainter oldDelegate) => false;
}

class _DiagramNode {
  const _DiagramNode(this.label, this.fill, this.border);
  final String label;
  final Color fill;
  final Color border;
}

// ---------------------------------------------------------------------------
// Tab 8 — Selection Visualization
// ---------------------------------------------------------------------------

class _SelectionVisualization extends StatelessWidget {
  const _SelectionVisualization();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            'Selection Visualization',
            subtitle: 'Live view of the TextSelection range from the shared editor state.',
          ),

          Text(
            'The TextSelection inside a TextEditingValue carries three key pieces of '
            'information: the base offset, the extent offset, and the text affinity. '
            'Understanding these is critical for constructing the replacementSelection '
            'parameter of ReplaceTextIntent.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),

          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _editorValue,
            builder: (BuildContext ctx, TextEditingValue val, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Visual selection indicator
                  _SelectionCard(value: val),
                  const SizedBox(height: 16),

                  // Raw values
                  Text('Raw selection values:', style: tt.labelLarge),
                  const SizedBox(height: 8),
                  _CodeBlock(
                    'TextSelection(\n'
                    '  baseOffset:   ${val.selection.baseOffset},\n'
                    '  extentOffset: ${val.selection.extentOffset},\n'
                    '  affinity:     ${val.selection.affinity},\n'
                    '  isCollapsed:  ${val.selection.isCollapsed},\n'
                    '  isValid:      ${val.selection.isValid},\n'
                    '  isNormalized: ${val.selection.isNormalized},\n'
                    ')',
                  ),
                  const SizedBox(height: 16),

                  // Selected text preview
                  if (val.selection.isValid && !val.selection.isCollapsed) ...<Widget>[
                    Text('Selected text:', style: tt.labelLarge),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '"${val.text.substring(val.selection.start, val.selection.end)}"',
                        style: tt.titleMedium?.copyWith(
                          fontFamily: 'monospace',
                          color: cs.onPrimaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Resulting replacementSelection preview
                  Text('replacementSelection if replacing with "DEMO":', style: tt.labelLarge),
                  const SizedBox(height: 8),
                  _CodeBlock(
                    '// If you invoke ReplaceTextIntent with replacementText: "DEMO"\n'
                    '// The resulting replacementSelection would be:\n'
                    'TextSelection.collapsed(\n'
                    '  offset: ${val.selection.isValid ? val.selection.start + 4 : val.text.length},\n'
                    '  // = selection.start (${val.selection.isValid ? val.selection.start : 0}) + "DEMO".length (4)\n'
                    ')',
                  ),
                  const SizedBox(height: 16),

                  // Affinity explanation
                  _SectionTitle('TextAffinity explained'),
                  _buildAffinityCard(context, TextAffinity.upstream, val.selection.affinity),
                  const SizedBox(height: 8),
                  _buildAffinityCard(context, TextAffinity.downstream, val.selection.affinity),
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          _SectionTitle('Selection terms glossary'),
          _buildGlossaryRow(context, 'baseOffset', 'Where the selection anchor is (where the user started selecting from).'),
          const SizedBox(height: 8),
          _buildGlossaryRow(context, 'extentOffset', 'Where the selection active end is (where the user dragged to).'),
          const SizedBox(height: 8),
          _buildGlossaryRow(context, 'isCollapsed', 'true when baseOffset == extentOffset (cursor, not a range).'),
          const SizedBox(height: 8),
          _buildGlossaryRow(context, 'isNormalized', 'true when baseOffset <= extentOffset.'),
          const SizedBox(height: 8),
          _buildGlossaryRow(context, 'start / end', 'Normalised: start = min(base, extent), end = max(base, extent).'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAffinityCard(BuildContext context, TextAffinity affinity, TextAffinity current) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final bool isActive = affinity == current;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? cs.primaryContainer : cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: isActive ? Border.all(color: cs.primary, width: 2) : null,
      ),
      child: Row(
        children: <Widget>[
          if (isActive) Icon(Icons.check_circle, color: cs.primary, size: 20),
          if (!isActive) Icon(Icons.radio_button_unchecked, color: cs.outlineVariant, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'TextAffinity.${affinity.name}',
                  style: tt.labelMedium?.copyWith(fontFamily: 'monospace', color: isActive ? cs.primary : cs.onSurface),
                ),
                Text(
                  affinity == TextAffinity.upstream
                      ? 'Cursor positioned at the end of the previous line (for line-wrapping ambiguity).'
                      : 'Cursor positioned at the start of the next line (default for most cases).',
                  style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlossaryRow(BuildContext context, String term, String def) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(term, style: tt.labelSmall?.copyWith(fontFamily: 'monospace', color: cs.primary, fontWeight: FontWeight.w700)),
        ),
        Expanded(child: Text(def, style: tt.bodySmall)),
      ],
    );
  }
}

class _SelectionCard extends StatelessWidget {
  const _SelectionCard({required this.value});
  final TextEditingValue value;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final String text = value.text;
    final TextSelection sel = value.selection;

    if (!sel.isValid) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('No valid selection', style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
        ),
      );
    }

    final String before = sel.start > 0 ? text.substring(0, sel.start) : '';
    final String selected = sel.isCollapsed ? '' : text.substring(sel.start, sel.end);
    final String after = sel.end < text.length ? text.substring(sel.end) : '';

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Live selection visualizer (from shared editor):', style: tt.labelMedium),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: tt.bodyLarge?.copyWith(fontFamily: 'monospace'),
                children: <TextSpan>[
                  TextSpan(text: before, style: TextStyle(color: cs.onSurface)),
                  if (!sel.isCollapsed)
                    TextSpan(
                      text: selected,
                      style: TextStyle(
                        color: cs.onPrimary,
                        backgroundColor: cs.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  if (sel.isCollapsed)
                    TextSpan(
                      text: '|',
                      style: TextStyle(color: cs.primary, fontWeight: FontWeight.w900),
                    ),
                  TextSpan(text: after, style: TextStyle(color: cs.onSurface)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                Chip(
                  label: Text('start: ${sel.start}'),
                  backgroundColor: cs.secondaryContainer,
                  side: BorderSide.none,
                ),
                Chip(
                  label: Text('end: ${sel.end}'),
                  backgroundColor: cs.secondaryContainer,
                  side: BorderSide.none,
                ),
                Chip(
                  label: Text('length: ${sel.end - sel.start}'),
                  backgroundColor: sel.isCollapsed ? cs.surfaceContainerHighest : cs.primaryContainer,
                  side: BorderSide.none,
                ),
                Chip(
                  label: Text(sel.isCollapsed ? 'collapsed' : 'range'),
                  backgroundColor: sel.isCollapsed ? cs.errorContainer : cs.tertiaryContainer,
                  side: BorderSide.none,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 9 — Pitfalls & API Cheat Sheet
// ---------------------------------------------------------------------------

class _PitfallsAndApi extends StatelessWidget {
  const _PitfallsAndApi();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle('Pitfalls & Common Mistakes'),

          _buildPitfall(
            context,
            number: '1',
            title: 'Requires focus',
            description:
                'ReplaceTextIntent can only be successfully dispatched when a TextField (or EditableText) '
                'is focused. If no text field has focus, Actions.invoke() will return null and nothing happens. '
                'Always ensure focus is acquired before dispatching.',
            fix: 'Call FocusScope.of(context).requestFocus(myFocusNode) before invoking the intent.',
            severity: _PitfallSeverity.high,
          ),
          const SizedBox(height: 12),

          _buildPitfall(
            context,
            number: '2',
            title: 'Intent only dispatched by DefaultTextEditingActions',
            description:
                'ReplaceTextAction (the default handler) is registered automatically by EditableText '
                'via DefaultTextEditingActions. If your widget tree does not include a TextField or '
                'EditableText, there will be no handler and the intent will be silently ignored.',
            fix: 'Ensure a TextField or EditableText is in the subtree. Or register your own Action explicitly.',
            severity: _PitfallSeverity.high,
          ),
          const SizedBox(height: 12),

          _buildPitfall(
            context,
            number: '3',
            title: 'cause must always be provided',
            description:
                'All 4 constructor parameters are required. Forgetting to pass cause is a compile error, '
                'but passing the wrong cause (e.g. using toolbar when the trigger is programmatic) may '
                'cause subtle platform-specific behavior differences on iOS/Android.',
            fix: 'For programmatic replacements always use SelectionChangedCause.keyboard.',
            severity: _PitfallSeverity.medium,
          ),
          const SizedBox(height: 12),

          _buildPitfall(
            context,
            number: '4',
            title: 'Stale currentTextEditingValue snapshot',
            description:
                'If you capture controller.value, then the controller value changes before you dispatch '
                'the intent, the snapshot will be stale. The action handler uses the snapshot from the '
                'intent, not the current controller state, so you may overwrite user input.',
            fix: 'Always capture controller.value immediately before constructing the intent.',
            severity: _PitfallSeverity.high,
          ),
          const SizedBox(height: 12),

          _buildPitfall(
            context,
            number: '5',
            title: 'replacementSelection must reference offsets in the NEW text',
            description:
                'After the replacement, the text length changes. The replacementSelection offsets must '
                'be valid in the post-replacement text, not in the original. Off-by-one errors here '
                'will cause an out-of-range assertion.',
            fix: 'Calculate: newOffset = selection.start + replacementText.length',
            severity: _PitfallSeverity.medium,
          ),
          const SizedBox(height: 12),

          _buildPitfall(
            context,
            number: '6',
            title: 'Do not mutate controller.value directly alongside intents',
            description:
                'Mixing direct controller.value mutations with intent dispatching can cause race '
                'conditions and undo history corruption. Commit to one approach.',
            fix: 'Use intents exclusively for all text modifications in Actions-aware contexts.',
            severity: _PitfallSeverity.low,
          ),
          const SizedBox(height: 24),

          const _Divider(),
          _SectionTitle('API Cheat Sheet'),

          Text('All 4 constructor parameters:', style: tt.labelLarge),
          const SizedBox(height: 12),
          _buildApiTable(context),
          const SizedBox(height: 20),

          Text('ReplaceTextAction:', style: tt.labelLarge),
          const SizedBox(height: 8),
          _CodeBlock(
            'class ReplaceTextAction extends Action<ReplaceTextIntent> {\n'
            '  // Registered automatically by EditableText.\n'
            '  // Applies intent.replacementText at intent.currentTextEditingValue.selection.\n'
            '  // Sets controller.value to the result with intent.replacementSelection.\n'
            '\n'
            '  @override\n'
            '  Object? invoke(ReplaceTextIntent intent);\n'
            '\n'
            '  // Returns true: this action is always enabled when a text field is focused.\n'
            '  @override\n'
            '  bool get isActionEnabled => true;\n'
            '}',
          ),
          const SizedBox(height: 20),

          Text('Quick reference snippets:', style: tt.labelLarge),
          const SizedBox(height: 8),
          _CodeBlock(
            '// Minimal usage:\n'
            'Actions.invoke(\n'
            '  context,\n'
            '  ReplaceTextIntent(\n'
            '    controller.value,\n'
            '    newText,\n'
            '    TextSelection.collapsed(offset: controller.selection.start + newText.length),\n'
            '    SelectionChangedCause.keyboard,\n'
            '  ),\n'
            ');\n'
            '\n'
            '// Replace all occurrences:\n'
            'String result = controller.text.replaceAll(target, replacement);\n'
            'Actions.invoke(\n'
            '  context,\n'
            '  ReplaceTextIntent(\n'
            '    controller.value,\n'
            '    replacement,\n'
            '    TextSelection.collapsed(offset: result.length),\n'
            '    SelectionChangedCause.keyboard,\n'
            '  ),\n'
            ');\n'
            '\n'
            '// Override with custom action:\n'
            'Actions(\n'
            '  actions: {ReplaceTextIntent: MyCustomAction()},\n'
            '  child: ...,\n'
            ');',
          ),
          const SizedBox(height: 20),

          // Import reminder
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Required imports:', style: tt.labelLarge),
                const SizedBox(height: 8),
                _CodeBlock(
                  "import 'package:flutter/material.dart';\n"
                  "import 'package:flutter/services.dart';"
                  '  // ReplaceTextIntent, SelectionChangedCause',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Summary card
          Card(
            elevation: 0,
            color: cs.primaryContainer.withAlpha(120),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Summary', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: cs.primary)),
                  const SizedBox(height: 12),
                  Text(
                    'ReplaceTextIntent is the correct, framework-aligned way to programmatically '
                    'replace selected text in a Flutter text field. It integrates cleanly with '
                    'Flutter\'s Actions/Intents system, enables interception via custom Action '
                    'subclasses, and carries full context (snapshot, replacement, cursor, cause) '
                    'to allow handlers to apply precise, undo-safe mutations.',
                    style: tt.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      Chip(label: const Text('flutter/services.dart'), backgroundColor: cs.secondaryContainer, side: BorderSide.none),
                      Chip(label: const Text('extends Intent'), backgroundColor: cs.secondaryContainer, side: BorderSide.none),
                      Chip(label: const Text('4 required params'), backgroundColor: cs.secondaryContainer, side: BorderSide.none),
                      Chip(label: const Text('ReplaceTextAction'), backgroundColor: cs.secondaryContainer, side: BorderSide.none),
                      Chip(label: const Text('M3 compatible'), backgroundColor: cs.secondaryContainer, side: BorderSide.none),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildApiTable(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    const List<List<String>> rows = <List<String>>[
      ['currentTextEditingValue', 'TextEditingValue', 'Snapshot of editing state before replacement'],
      ['replacementText', 'String', 'The new string to replace the selection with'],
      ['replacementSelection', 'TextSelection', 'The cursor/selection to set after replacement'],
      ['cause', 'SelectionChangedCause', 'What triggered the replacement intent'],
    ];
    return Table(
      border: TableBorder.all(color: cs.outlineVariant, borderRadius: BorderRadius.circular(8)),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2.5),
        1: FlexColumnWidth(2.5),
        2: FlexColumnWidth(4),
      },
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: cs.primaryContainer),
          children: <Widget>[
            _th(context, 'Parameter'),
            _th(context, 'Type'),
            _th(context, 'Description'),
          ],
        ),
        ...rows.map((List<String> r) => TableRow(
          children: r.map((String c) => _td(context, c)).toList(),
        )),
      ],
    );
  }

  Widget _th(BuildContext context, String text) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Text(text, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: cs.onPrimaryContainer)),
    );
  }

  Widget _td(BuildContext context, String text) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Text(text, style: tt.bodySmall),
    );
  }

  Widget _buildPitfall(
    BuildContext context, {
    required String number,
    required String title,
    required String description,
    required String fix,
    required _PitfallSeverity severity,
  }) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final Color bgColor = switch (severity) {
      _PitfallSeverity.high => cs.errorContainer.withAlpha(100),
      _PitfallSeverity.medium => cs.tertiaryContainer.withAlpha(100),
      _PitfallSeverity.low => cs.surfaceContainerLow,
    };
    final Color borderColor = switch (severity) {
      _PitfallSeverity.high => cs.error.withAlpha(120),
      _PitfallSeverity.medium => cs.tertiary.withAlpha(120),
      _PitfallSeverity.low => cs.outlineVariant,
    };
    final Color labelColor = switch (severity) {
      _PitfallSeverity.high => cs.error,
      _PitfallSeverity.medium => cs.tertiary,
      _PitfallSeverity.low => cs.onSurfaceVariant,
    };
    final String severityLabel = switch (severity) {
      _PitfallSeverity.high => 'HIGH',
      _PitfallSeverity.medium => 'MEDIUM',
      _PitfallSeverity.low => 'LOW',
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(color: labelColor, shape: BoxShape.circle),
                child: Center(child: Text(number, style: tt.labelSmall?.copyWith(color: cs.surface, fontWeight: FontWeight.w700))),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w700))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: labelColor.withAlpha(30), borderRadius: BorderRadius.circular(6)),
                child: Text(severityLabel, style: tt.labelSmall?.copyWith(color: labelColor, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(description, style: tt.bodySmall),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.check_circle_outline, size: 16, color: labelColor),
              const SizedBox(width: 6),
              Expanded(child: Text('Fix: $fix', style: tt.bodySmall?.copyWith(fontStyle: FontStyle.italic))),
            ],
          ),
        ],
      ),
    );
  }
}

enum _PitfallSeverity { high, medium, low }
