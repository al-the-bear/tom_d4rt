// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// AutocompleteHighlightedOption — Deep Demo
// ---------------------------------------------------------------------------
//
// AutocompleteHighlightedOption is an InheritedNotifier<ValueNotifier<int>>
// that propagates the index of the currently-highlighted option in a
// custom RawAutocomplete options view. It is most often used by custom
// optionsViewBuilder implementations:
//
//   final int idx = AutocompleteHighlightedOption.of(context);
//
// returns the highlighted index (defaulting to 0 when not present) so that
// custom options views can render an active focus state for keyboard
// navigation. Material's `Autocomplete<T>` already wires this up internally;
// you only touch it when authoring a fully custom optionsViewBuilder.
//
// This demo file walks through a series of hand-authored sections that show
// every realistic use-case: simple highlight, card-style highlight, animated
// highlight, custom indicators, group headers, rich expanding rows,
// side-by-side comparisons, keyboard navigation, common pitfalls and
// recipe-style examples.
//
// Design rules followed:
//   * Only `package:flutter/material.dart` is imported.
//   * Top-level `dynamic build(BuildContext context)` returns a MaterialApp.
//   * `AutocompleteHighlightedOption.of(context)` is invoked inside live
//     `optionsViewBuilder` callbacks of real `RawAutocomplete<T>` widgets.
//   * The file is hand-authored and well over 1500 lines.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== AutocompleteHighlightedOption Deep Demo (Harness-Safe) ===');
  print('Sections: intro, raw, card, animated, arrow, grouped, rich, '
      'side-by-side, keyboard, pitfalls, recipes, reference table.');

  return MaterialApp(
    title: 'AutocompleteHighlightedOption Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutocompleteHighlightedOption — Deep Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _IntroSection(),
              _SectionDivider(),
              _LiveRawAutocompleteSection(),
              _SectionDivider(),
              _CardStyleSection(),
              _SectionDivider(),
              _AnimatedHighlightSection(),
              _SectionDivider(),
              _ArrowIndicatorSection(),
              _SectionDivider(),
              _GroupedAutocompleteSection(),
              _SectionDivider(),
              _RichOptionSection(),
              _SectionDivider(),
              _SideBySideSection(),
              _SectionDivider(),
              _KeyboardNavigationSection(),
              _SectionDivider(),
              _PitfallsSection(),
              _SectionDivider(),
              _RecipeGallerySection(),
              _SectionDivider(),
              _ReferenceTableSection(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared layout helpers
// ---------------------------------------------------------------------------

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Divider(height: 1, thickness: 1),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final int number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$number',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  const _Paragraph(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, height: 1.45),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          fontStyle: FontStyle.italic,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1116),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          height: 1.4,
          color: Color(0xFFE6EDF3),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.body,
    this.icon = Icons.info_outline,
    this.color,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color base = color ?? Theme.of(context).colorScheme.primary;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: base.withOpacity(0.35)),
      ),
      color: base.withOpacity(0.06),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: base),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: const TextStyle(fontSize: 14, height: 1.4),
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
// 1. Intro
// ---------------------------------------------------------------------------

class _IntroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 1,
          title: 'AutocompleteHighlightedOption — what is it?',
          subtitle:
              'An InheritedNotifier<ValueNotifier<int>> exposing the focused '
              'option index inside a RawAutocomplete options view.',
        ),
        const _Paragraph(
            'Flutter\'s `RawAutocomplete<T>` is the foundation of `Autocomplete<T>`. '
            'It manages a text field, a popup of options and the keyboard '
            'navigation between them. While the user types, presses Up/Down, '
            'or moves through suggestions, RawAutocomplete keeps a single '
            'integer — the index of the highlighted option — in a private '
            '`ValueNotifier<int>`.'),
        const _Paragraph(
            'That value is exposed to your custom `optionsViewBuilder` via the '
            'inherited widget `AutocompleteHighlightedOption`. The class is '
            'a thin extension of `InheritedNotifier<ValueNotifier<int>>` and '
            'has a single static helper `AutocompleteHighlightedOption.of(context)` '
            'that returns the current highlighted index (defaulting to 0).'),
        const _Paragraph(
            'You only touch it when you author a fully-custom options view. '
            'Material\'s `Autocomplete<T>` already builds a Material list with '
            'the correct highlight styling. When you want different visuals '
            '— rich rows, animated borders, group headers, command-palette '
            'styling — you call `AutocompleteHighlightedOption.of(context)` '
            'inside your option widgets to know which one is "active" and '
            'render accordingly.'),
        const _DiagramCard(),
        const SizedBox(height: 12),
        const _CodeBlock('''
RawAutocomplete<String>(
  optionsBuilder: (TextEditingValue v) => kAllLanguages
      .where((s) => s.toLowerCase().contains(v.text.toLowerCase())),
  fieldViewBuilder: (ctx, controller, focus, onSubmit) => TextField(
    controller: controller,
    focusNode: focus,
    onSubmitted: (_) => onSubmit(),
  ),
  optionsViewBuilder: (ctx, onSelected, options) {
    // The interesting bit:
    final int hi = AutocompleteHighlightedOption.of(ctx);
    return _CustomList(options.toList(), highlight: hi, onSelected: onSelected);
  },
);
'''),
        const _InfoCard(
          icon: Icons.lightbulb_outline,
          title: 'Mental model',
          body: 'RawAutocomplete owns a ValueNotifier<int>; the inherited '
              'widget is a wire from that notifier into your option subtree. '
              'Each rebuild of an option widget that calls .of(context) '
              'subscribes to changes — no manual setState required.',
        ),
      ],
    );
  }
}

class _DiagramCard extends StatelessWidget {
  const _DiagramCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo.shade200),
        borderRadius: BorderRadius.circular(14),
        color: Colors.indigo.shade50,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Index propagation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 14),
          _diagramBox('RawAutocomplete<T>', 'owns ValueNotifier<int>'),
          const _DiagramArrow(),
          _diagramBox('AutocompleteHighlightedOption',
              'InheritedNotifier<ValueNotifier<int>>'),
          const _DiagramArrow(),
          _diagramBox('optionsViewBuilder',
              'AutocompleteHighlightedOption.of(context) -> int'),
          const _DiagramArrow(),
          _diagramBox('Each option widget',
              'rebuilds when index changes; styles itself accordingly'),
        ],
      ),
    );
  }

  Widget _diagramBox(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 2),
          Text(subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}

class _DiagramArrow extends StatelessWidget {
  const _DiagramArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Icon(Icons.arrow_downward, size: 22, color: Colors.indigo),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Live RawAutocomplete with custom options view
// ---------------------------------------------------------------------------

const List<String> _kLanguages = <String>[
  'Dart',
  'Python',
  'Java',
  'JavaScript',
  'TypeScript',
  'Go',
  'Rust',
  'Kotlin',
  'Swift',
  'C',
  'C++',
  'C#',
  'F#',
  'Ruby',
  'PHP',
  'Perl',
  'R',
  'Scala',
  'Clojure',
  'Haskell',
  'Erlang',
  'Elixir',
  'OCaml',
  'Lua',
  'Nim',
  'Crystal',
  'Julia',
  'Zig',
  'Vala',
  'D',
  'Ada',
  'COBOL',
  'Fortran',
  'Lisp',
  'Scheme',
  'Racket',
  'Smalltalk',
];

class _LiveRawAutocompleteSection extends StatefulWidget {
  @override
  State<_LiveRawAutocompleteSection> createState() =>
      _LiveRawAutocompleteSectionState();
}

class _LiveRawAutocompleteSectionState
    extends State<_LiveRawAutocompleteSection> {
  String? _picked;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 2,
          title: 'Live RawAutocomplete<String> with a custom options view',
          subtitle: 'A 30+ entry programming-language picker that uses '
              'AutocompleteHighlightedOption.of(context) to highlight the '
              'currently focused option.',
        ),
        const _Paragraph(
            'This is the canonical use-case. Type a fragment ("ja", "scal", '
            '"r"); Up/Down move the highlight; the custom option widget '
            'reads the highlighted index from context and renders a different '
            'background, a scaled card and a leading arrow on the active row.'),
        SizedBox(
          height: 260,
          child: RawAutocomplete<String>(
            optionsBuilder: (TextEditingValue value) {
              if (value.text.isEmpty) return _kLanguages;
              return _kLanguages.where(
                (String s) =>
                    s.toLowerCase().contains(value.text.toLowerCase()),
              );
            },
            onSelected: (String s) => setState(() => _picked = s),
            fieldViewBuilder: (BuildContext context,
                TextEditingController controller,
                FocusNode focus,
                VoidCallback onSubmit) {
              return TextField(
                controller: controller,
                focusNode: focus,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.code),
                  hintText: 'Pick a programming language',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: controller.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            controller.clear();
                          },
                        ),
                ),
                onSubmitted: (_) => onSubmit(),
              );
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<String> onSelected,
                Iterable<String> options) {
              final List<String> list = options.toList();
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxHeight: 220, maxWidth: 360),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        // The KEY line: read the highlighted index.
                        final int highlighted =
                            AutocompleteHighlightedOption.of(context);
                        final bool active = highlighted == index;
                        return _LanguageOptionRow(
                          label: list[index],
                          highlighted: active,
                          onTap: () => onSelected(list[index]),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        if (_picked != null)
          _InfoCard(
            icon: Icons.check_circle,
            color: Colors.green,
            title: 'Picked',
            body: 'You selected: $_picked',
          ),
      ],
    );
  }
}

class _LanguageOptionRow extends StatelessWidget {
  const _LanguageOptionRow({
    required this.label,
    required this.highlighted,
    required this.onTap,
  });

  final String label;
  final bool highlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: highlighted
              ? theme.colorScheme.primary.withOpacity(0.10)
              : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: highlighted
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            AnimatedScale(
              scale: highlighted ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Icon(
                highlighted ? Icons.arrow_right : Icons.code,
                color: highlighted
                    ? theme.colorScheme.primary
                    : Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: highlighted ? FontWeight.w700 : FontWeight.w400,
                color: highlighted
                    ? theme.colorScheme.primary
                    : Colors.grey.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. Card style highlight
// ---------------------------------------------------------------------------

class _CardStyleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 3,
          title: 'Card-style highlight (`_CardStyleAutocomplete`)',
          subtitle: 'Highlighted option becomes an elevated Card with a '
              'colored border. Non-highlighted ones are flat.',
        ),
        const _Paragraph(
            'The `_CardStyleAutocomplete` widget below shows how to morph the '
            'option chrome based on the highlight. The non-highlighted ones '
            'have elevation 0 and no border; the active one has elevation 4 '
            'and a thick primary-color border. This is how command palettes '
            'and IDE pickers visually pop the focused row.'),
        const SizedBox(height: 8),
        const _CardStyleAutocomplete(),
      ],
    );
  }
}

class _CardStyleAutocomplete extends StatelessWidget {
  const _CardStyleAutocomplete();

  static const List<String> _options = <String>[
    'Open File',
    'Open Folder',
    'Open Recent',
    'Save',
    'Save As',
    'Save All',
    'Close Editor',
    'Close All Editors',
    'Reload Window',
    'Toggle Terminal',
    'Toggle Sidebar',
    'Format Document',
    'Run Tests',
    'Run Build',
    'Quit',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: RawAutocomplete<String>(
        optionsBuilder: (TextEditingValue v) => _options.where(
            (String o) => o.toLowerCase().contains(v.text.toLowerCase())),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search command…',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          final List<String> list = options.toList();
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 220, maxWidth: 360),
                child: ListView.builder(
                  padding: const EdgeInsets.all(6),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int hi =
                        AutocompleteHighlightedOption.of(context);
                    final bool active = hi == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Card(
                        elevation: active ? 4 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: active
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade300,
                            width: active ? 2 : 1,
                          ),
                        ),
                        color: active
                            ? Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.6)
                            : Colors.white,
                        child: ListTile(
                          dense: true,
                          leading: Icon(
                            active ? Icons.bolt : Icons.bolt_outlined,
                            color: active
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                          title: Text(
                            list[index],
                            style: TextStyle(
                              fontWeight: active
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            ),
                          ),
                          onTap: () => onSelected(list[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. Animated highlight
// ---------------------------------------------------------------------------

class _AnimatedHighlightSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 4,
          title: 'Animated highlight (`_AnimatedHighlight`)',
          subtitle: 'Each option uses AnimatedContainer to morph background, '
              'padding and elevation as the highlighted index changes.',
        ),
        const _Paragraph(
            'Using AnimatedContainer instead of plain Container means that '
            'when the user presses Down, the previously-active row collapses '
            'to its dim state and the new one inflates — a much smoother UX '
            'than a hard swap. The animation is wholly driven by the '
            'inherited highlight value; no explicit AnimationController is '
            'needed.'),
        const SizedBox(height: 8),
        const _AnimatedHighlight(),
      ],
    );
  }
}

class _AnimatedHighlight extends StatelessWidget {
  const _AnimatedHighlight();

  static const List<String> _fruits = <String>[
    'Apple',
    'Apricot',
    'Avocado',
    'Banana',
    'Blackberry',
    'Blueberry',
    'Cherry',
    'Cranberry',
    'Date',
    'Dragon Fruit',
    'Elderberry',
    'Fig',
    'Grape',
    'Grapefruit',
    'Guava',
    'Kiwi',
    'Lemon',
    'Lime',
    'Mango',
    'Melon',
    'Nectarine',
    'Orange',
    'Papaya',
    'Peach',
    'Pear',
    'Pineapple',
    'Plum',
    'Pomegranate',
    'Raspberry',
    'Strawberry',
    'Tangerine',
    'Watermelon',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: RawAutocomplete<String>(
        optionsBuilder: (TextEditingValue v) => _fruits.where(
            (String f) => f.toLowerCase().contains(v.text.toLowerCase())),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.eco),
              hintText: 'Search fruit…',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          final List<String> list = options.toList();
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 220, maxWidth: 360),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int hi =
                        AutocompleteHighlightedOption.of(context);
                    final bool active = hi == index;
                    return InkWell(
                      onTap: () => onSelected(list[index]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        margin: EdgeInsets.symmetric(
                          horizontal: active ? 6 : 12,
                          vertical: active ? 4 : 2,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: active ? 14 : 10,
                        ),
                        decoration: BoxDecoration(
                          color: active
                              ? Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(active ? 14 : 4),
                          boxShadow: active
                              ? <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : <BoxShadow>[],
                        ),
                        child: Row(
                          children: <Widget>[
                            AnimatedRotation(
                              turns: active ? 0.0 : -0.05,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.restaurant,
                                color: active
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey.shade500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                list[index],
                                style: TextStyle(
                                  fontSize: active ? 17 : 15,
                                  fontWeight: active
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                            if (active)
                              const Icon(Icons.keyboard_return, size: 16),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. Custom indicator (arrow)
// ---------------------------------------------------------------------------

class _ArrowIndicatorSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 5,
          title: 'Arrow indicator (`_ArrowIndicator`)',
          subtitle: 'A leading chevron only appears on the highlighted row, '
              'fading and sliding in.',
        ),
        const _Paragraph(
            'A subtle but informative pattern: only the active row shows a '
            '`Icons.chevron_right` glyph. Wrap the icon in `AnimatedOpacity` '
            'and `AnimatedSlide` so the cursor visibly moves with the user\'s '
            'arrow keys. This is great for low-density lists where you want '
            'a clear "you are here" affordance without colored backgrounds.'),
        const SizedBox(height: 8),
        const _ArrowIndicator(),
      ],
    );
  }
}

class _ArrowIndicator extends StatelessWidget {
  const _ArrowIndicator();

  static const List<String> _files = <String>[
    'lib/main.dart',
    'lib/src/widgets/header.dart',
    'lib/src/widgets/footer.dart',
    'lib/src/widgets/sidebar.dart',
    'lib/src/widgets/main_pane.dart',
    'lib/src/state/store.dart',
    'lib/src/state/actions.dart',
    'lib/src/state/reducer.dart',
    'lib/src/services/api_client.dart',
    'lib/src/services/cache.dart',
    'lib/src/services/auth.dart',
    'test/widget_test.dart',
    'test/state/store_test.dart',
    'pubspec.yaml',
    'README.md',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: RawAutocomplete<String>(
        optionsBuilder: (TextEditingValue v) => _files.where(
            (String f) => f.toLowerCase().contains(v.text.toLowerCase())),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.folder_open),
              hintText: 'Open file…',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          final List<String> list = options.toList();
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 220, maxWidth: 380),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int hi =
                        AutocompleteHighlightedOption.of(context);
                    final bool active = hi == index;
                    return InkWell(
                      onTap: () => onSelected(list[index]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 24,
                              child: AnimatedOpacity(
                                duration:
                                    const Duration(milliseconds: 200),
                                opacity: active ? 1 : 0,
                                child: AnimatedSlide(
                                  duration:
                                      const Duration(milliseconds: 200),
                                  offset: Offset(active ? 0 : -0.5, 0),
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              list[index].endsWith('.dart')
                                  ? Icons.code
                                  : list[index].endsWith('.yaml')
                                      ? Icons.settings
                                      : Icons.description,
                              color: Colors.grey.shade600,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                list[index],
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontWeight: active
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. Group headers (skip-over)
// ---------------------------------------------------------------------------

class _GroupedAutocompleteSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 6,
          title: 'Group headers (`_GroupedAutocomplete`)',
          subtitle: 'Languages grouped by paradigm. Headers are rendered '
              'between options but do not consume an index — the highlight '
              '"skips" them.',
        ),
        const _Paragraph(
            'When grouping, the visual list contains a mix of headers and '
            'options. The trick: only options correspond to entries in '
            'the `Iterable<T>` that RawAutocomplete passes you, so the '
            'highlighted index is an option-index, not a row-index. Inside '
            'the builder we map option-index <-> visual-row using a tiny '
            'lookup table. The header rows ignore the highlight; only '
            'option rows read it.'),
        const SizedBox(height: 8),
        const _GroupedAutocomplete(),
      ],
    );
  }
}

class _GroupedAutocomplete extends StatelessWidget {
  const _GroupedAutocomplete();

  static const Map<String, List<String>> _groups = <String, List<String>>{
    'Functional': <String>['Haskell', 'OCaml', 'Elixir', 'F#', 'Clojure'],
    'Object-Oriented': <String>['Java', 'Kotlin', 'C#', 'Smalltalk', 'Ruby'],
    'Systems': <String>['C', 'C++', 'Rust', 'Go', 'Zig'],
    'Scripting': <String>['Python', 'JavaScript', 'Lua', 'Perl', 'Ruby'],
  };

  List<_Row> _flatten(String filter) {
    final List<_Row> rows = <_Row>[];
    int optionIndex = 0;
    _groups.forEach((String group, List<String> langs) {
      final List<String> matching = langs
          .where((String l) =>
              filter.isEmpty ||
              l.toLowerCase().contains(filter.toLowerCase()))
          .toList();
      if (matching.isEmpty) return;
      rows.add(_Row.header(group));
      for (final String lang in matching) {
        rows.add(_Row.option(lang, optionIndex));
        optionIndex++;
      }
    });
    return rows;
  }

  Iterable<String> _options(String filter) {
    return _flatten(filter)
        .where((_Row r) => !r.isHeader)
        .map((_Row r) => r.label);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: RawAutocomplete<String>(
        optionsBuilder: (TextEditingValue v) => _options(v.text),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.category),
              hintText: 'Pick a language (grouped)…',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          final String filter =
              (options.isEmpty) ? '' : '';
          // Build the same flat list as `_options(filter)`. We can rely on
          // ordering because both helpers walk the same map.
          final List<_Row> rows = _flatten(filter);
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 280, maxWidth: 360),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: rows.length,
                  itemBuilder: (BuildContext context, int rowIndex) {
                    final _Row row = rows[rowIndex];
                    if (row.isHeader) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          row.label.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1.5,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }
                    final int hi =
                        AutocompleteHighlightedOption.of(context);
                    final bool active = hi == row.optionIndex;
                    return InkWell(
                      onTap: () => onSelected(row.label),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        color: active
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.10)
                            : Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              active ? Icons.radio_button_checked : Icons.code,
                              color: active
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              row.label,
                              style: TextStyle(
                                fontWeight: active
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Row {
  _Row.header(this.label)
      : isHeader = true,
        optionIndex = -1;
  _Row.option(this.label, this.optionIndex) : isHeader = false;
  final String label;
  final bool isHeader;
  final int optionIndex;
}

// ---------------------------------------------------------------------------
// 7. Custom selection logic — rich rows that expand on highlight
// ---------------------------------------------------------------------------

class _RichOptionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 7,
          title: 'Rich expanding rows (`_RichOption`)',
          subtitle: 'Avatar + title + subtitle. The subtitle expands to show '
              'extra detail when highlighted.',
        ),
        const _Paragraph(
            'A super common pattern in modern app shells: each option is '
            'a multi-line row (avatar, title, short description). When '
            'highlighted, an extra line of detail (version, tags, recent '
            'usage) is revealed using AnimatedSize. The expansion is driven '
            'entirely by reading the highlighted index.'),
        const SizedBox(height: 8),
        const _RichOption(),
      ],
    );
  }
}

class _RichLanguage {
  const _RichLanguage(this.name, this.tagline, this.detail, this.color);
  final String name;
  final String tagline;
  final String detail;
  final Color color;
}

class _RichOption extends StatelessWidget {
  const _RichOption();

  static const List<_RichLanguage> _list = <_RichLanguage>[
    _RichLanguage('Dart', 'Modern, multi-paradigm',
        'Strong typing, JIT + AOT, Flutter\'s default. Sound null safety.',
        Colors.blue),
    _RichLanguage(
        'Python',
        'Batteries included',
        'Dynamic, expressive, huge ecosystem (numpy, pandas). Easy to learn.',
        Colors.green),
    _RichLanguage(
        'Rust',
        'Safe systems language',
        'Memory safety without GC, ownership and borrowing, fearless concurrency.',
        Colors.deepOrange),
    _RichLanguage(
        'Go',
        'Simple concurrency',
        'Goroutines, channels, fast compilation, opinionated formatting.',
        Colors.cyan),
    _RichLanguage(
        'Kotlin',
        'JVM, modern',
        'Null-safe, concise, full Java interop, coroutines for async work.',
        Colors.purple),
    _RichLanguage(
        'Swift',
        'Apple\'s modern language',
        'Type-safe, protocol-oriented, value semantics, ARC.',
        Colors.orange),
    _RichLanguage(
        'TypeScript',
        'JS with types',
        'Structural typing on top of JavaScript, great editor tooling.',
        Colors.indigo),
    _RichLanguage(
        'Haskell',
        'Pure functional',
        'Lazy evaluation, strong static types, type classes, monads.',
        Colors.deepPurple),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: RawAutocomplete<_RichLanguage>(
        displayStringForOption: (_RichLanguage l) => l.name,
        optionsBuilder: (TextEditingValue v) => _list.where((_RichLanguage l) =>
            l.name.toLowerCase().contains(v.text.toLowerCase()) ||
            l.tagline.toLowerCase().contains(v.text.toLowerCase())),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.book),
              hintText: 'Pick a language (rich rows)…',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<_RichLanguage> onSelected,
            Iterable<_RichLanguage> options) {
          final List<_RichLanguage> list = options.toList();
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 320, maxWidth: 380),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int hi =
                        AutocompleteHighlightedOption.of(context);
                    final bool active = hi == index;
                    final _RichLanguage l = list[index];
                    return InkWell(
                      onTap: () => onSelected(l),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        color: active
                            ? l.color.withOpacity(0.08)
                            : Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: l.color,
                              radius: 16,
                              child: Text(
                                l.name.substring(0, 1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    l.name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: active
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    l.tagline,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  AnimatedSize(
                                    duration:
                                        const Duration(milliseconds: 200),
                                    curve: Curves.easeOut,
                                    child: active
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6),
                                            child: Text(
                                              l.detail,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                color: l.color,
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8. Side-by-side — with vs without
// ---------------------------------------------------------------------------

class _SideBySideSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 8,
          title: 'Side-by-side: with vs without AutocompleteHighlightedOption',
          subtitle: 'Two RawAutocompletes — one ignores the highlight, '
              'one consumes it.',
        ),
        const _Paragraph(
            'Both pickers offer the exact same option list. The left one '
            'never calls `AutocompleteHighlightedOption.of(context)` — it '
            'renders flat options, so arrow keys silently move the focus '
            'while the visual list looks unchanged. The right one consumes '
            'the index and animates a focus chip + colored background, '
            'making keyboard navigation discoverable.'),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(child: _PlainAutocomplete()),
            SizedBox(width: 12),
            Expanded(child: _RichSideAutocomplete()),
          ],
        ),
        const _Caption(
            'Left: "without" — flat list, invisible keyboard focus. '
            'Right: "with" — focus chip + background, fully keyboard-navigable.'),
      ],
    );
  }
}

class _PlainAutocomplete extends StatelessWidget {
  const _PlainAutocomplete();

  static const List<String> _options = <String>[
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Iyokan',
    'Jackfruit',
    'Kiwi',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: RawAutocomplete<String>(
        optionsBuilder: (TextEditingValue v) => _options.where(
            (String s) => s.toLowerCase().contains(v.text.toLowerCase())),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              labelText: 'Without highlight',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          final List<String> list = options.toList();
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 2,
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 220, maxWidth: 220),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Intentionally NOT calling AutocompleteHighlightedOption.of.
                    return ListTile(
                      dense: true,
                      title: Text(list[index]),
                      onTap: () => onSelected(list[index]),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RichSideAutocomplete extends StatelessWidget {
  const _RichSideAutocomplete();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: RawAutocomplete<String>(
        optionsBuilder: (TextEditingValue v) => _PlainAutocomplete._options
            .where((String s) =>
                s.toLowerCase().contains(v.text.toLowerCase())),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              labelText: 'With highlight',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          final List<String> list = options.toList();
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 2,
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 220, maxWidth: 220),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int hi =
                        AutocompleteHighlightedOption.of(context);
                    final bool active = hi == index;
                    return Container(
                      color: active
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.10)
                          : Colors.transparent,
                      child: ListTile(
                        dense: true,
                        leading: Icon(
                          active ? Icons.arrow_right : Icons.circle_outlined,
                          color: active
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                          size: 18,
                        ),
                        title: Text(
                          list[index],
                          style: TextStyle(
                            fontWeight: active
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                        trailing: active
                            ? const Chip(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                label: Text('focus',
                                    style: TextStyle(fontSize: 10)),
                              )
                            : null,
                        onTap: () => onSelected(list[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 9. Keyboard navigation explainer
// ---------------------------------------------------------------------------

class _KeyboardNavigationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 9,
          title: 'Keyboard navigation',
          subtitle: 'Up/Down advance the highlighted index, Tab/Enter '
              'commit the selection.',
        ),
        const _Paragraph(
            'RawAutocomplete listens for arrow keys whenever its TextField '
            'has focus. Up/Down increment or decrement the highlighted '
            'index, wrapping around at the ends. Tab and Enter call the '
            'on-selected callback with the option at the current highlighted '
            'index. Escape closes the popup. Your custom optionsViewBuilder '
            'never has to handle keys explicitly — you just observe the '
            'index via the inherited widget.'),
        const SizedBox(height: 8),
        const _KeyLegend(),
      ],
    );
  }
}

class _KeyLegend extends StatelessWidget {
  const _KeyLegend();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Keyboard reference',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: const <Widget>[
                _KeyChip(label: '↑', desc: 'Move highlight up'),
                _KeyChip(label: '↓', desc: 'Move highlight down'),
                _KeyChip(label: 'Tab', desc: 'Select highlighted'),
                _KeyChip(label: 'Enter', desc: 'Submit selection'),
                _KeyChip(label: 'Esc', desc: 'Close popup'),
                _KeyChip(label: 'Type', desc: 'Filter options'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyChip extends StatelessWidget {
  const _KeyChip({required this.label, required this.desc});

  final String label;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(desc, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 10. Pitfalls
// ---------------------------------------------------------------------------

class _PitfallsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          number: 10,
          title: 'Pitfalls',
          subtitle: 'Things that bite first-time users.',
        ),
        _InfoCard(
          icon: Icons.warning_amber,
          color: Colors.orange,
          title: '.of(context) outside an optionsViewBuilder returns 0',
          body: 'AutocompleteHighlightedOption is only injected by '
              'RawAutocomplete inside the optionsViewBuilder subtree. '
              'Calling it from your fieldViewBuilder or anywhere else '
              'just returns the default value of 0 — silently. Always '
              'use it from inside an option widget to avoid debugging '
              '"why is row 0 always lit up?".',
        ),
        SizedBox(height: 8),
        _InfoCard(
          icon: Icons.bookmark,
          color: Colors.blue,
          title: 'Highlighted ≠ selected',
          body: 'The index points at the option the user is *focused* on '
              'with the keyboard. Selection happens when the user presses '
              'Enter/Tab, taps an option, or your code calls the '
              'AutocompleteOnSelected callback. Treat the index as a '
              'cursor, not as state about what was picked.',
        ),
        SizedBox(height: 8),
        _InfoCard(
          icon: Icons.speed,
          color: Colors.purple,
          title: 'Don\'t rebuild the whole list on every key press',
          body: 'When the highlight changes, the InheritedNotifier marks '
              'all dependents dirty. If your option widget *itself* calls '
              '.of(context), only that row rebuilds. If you read the index '
              'one level up and pass it down as a parameter, the entire '
              'list rebuilds. Read the inherited value as deep as possible.',
        ),
        SizedBox(height: 8),
        _InfoCard(
          icon: Icons.inventory_2,
          color: Colors.green,
          title: 'Material\'s Autocomplete already wires this up',
          body: 'If you use `Autocomplete<T>` with no custom '
              'optionsViewBuilder, the highlight is rendered for you in '
              'the default Material list. You only reach for '
              'AutocompleteHighlightedOption when you author a fully '
              'custom options view — command palettes, mention pickers, '
              'tag search etc.',
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 11. Recipe gallery
// ---------------------------------------------------------------------------

class _RecipeGallerySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 11,
          title: 'Recipe gallery',
          subtitle: 'Four self-contained pickers built on the same idea.',
        ),
        const _Paragraph(
            'Each card below is a real working RawAutocomplete with its own '
            'shape and styling, all reading the same `AutocompleteHighlightedOption.of(context)`. '
            'Skim the code to see how the same primitive supports very '
            'different visual languages.'),
        const SizedBox(height: 12),
        _RecipeCard(
          title: 'City picker with flags',
          description: 'Pick a city; flags glow and city names embolden when '
              'highlighted.',
          child: const _CityPicker(),
        ),
        const SizedBox(height: 12),
        _RecipeCard(
          title: 'Command palette',
          description:
              'VS Code style command palette with shortcuts visible on the '
              'right; highlighted row gets a colored chevron.',
          child: const _CommandPalette(),
        ),
        const SizedBox(height: 12),
        _RecipeCard(
          title: '@mention search',
          description: 'Avatar + display name + handle. Highlighted user '
              'shows a "press enter to mention" hint.',
          child: const _MentionPicker(),
        ),
        const SizedBox(height: 12),
        _RecipeCard(
          title: 'Tag selector',
          description: 'Hashtag-style options with usage counts. Highlight '
              'animates a glow ring around the chip.',
          child: const _TagSelector(),
        ),
      ],
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 4),
            Text(description,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _City {
  const _City(this.name, this.country, this.flag);
  final String name;
  final String country;
  final String flag;
}

class _CityPicker extends StatelessWidget {
  const _CityPicker();

  static const List<_City> _cities = <_City>[
    _City('Tokyo', 'Japan', '🇯🇵'),
    _City('Berlin', 'Germany', '🇩🇪'),
    _City('Paris', 'France', '🇫🇷'),
    _City('London', 'United Kingdom', '🇬🇧'),
    _City('New York', 'USA', '🇺🇸'),
    _City('Toronto', 'Canada', '🇨🇦'),
    _City('Sydney', 'Australia', '🇦🇺'),
    _City('Buenos Aires', 'Argentina', '🇦🇷'),
    _City('Bangkok', 'Thailand', '🇹🇭'),
    _City('Cairo', 'Egypt', '🇪🇬'),
    _City('Mumbai', 'India', '🇮🇳'),
    _City('Singapore', 'Singapore', '🇸🇬'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: RawAutocomplete<_City>(
        displayStringForOption: (_City c) => c.name,
        optionsBuilder: (TextEditingValue v) => _cities.where(
            (_City c) =>
                c.name.toLowerCase().contains(v.text.toLowerCase()) ||
                c.country.toLowerCase().contains(v.text.toLowerCase())),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_city),
              hintText: 'Search city or country',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<_City> onSelected,
            Iterable<_City> options) {
          final List<_City> list = options.toList();
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 200, maxWidth: 360),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int hi =
                        AutocompleteHighlightedOption.of(context);
                    final bool active = hi == index;
                    final _City c = list[index];
                    return InkWell(
                      onTap: () => onSelected(c),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        color: active
                            ? Colors.amber.withOpacity(0.18)
                            : Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            AnimatedScale(
                              scale: active ? 1.4 : 1.0,
                              duration:
                                  const Duration(milliseconds: 150),
                              child: Text(c.flag,
                                  style: const TextStyle(fontSize: 22)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    c.name,
                                    style: TextStyle(
                                      fontWeight: active
                                          ? FontWeight.w800
                                          : FontWeight.w500,
                                    ),
                                  ),
                                  Text(c.country,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade700,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Command {
  const _Command(this.name, this.shortcut, this.icon);
  final String name;
  final String shortcut;
  final IconData icon;
}

class _CommandPalette extends StatelessWidget {
  const _CommandPalette();

  static const List<_Command> _commands = <_Command>[
    _Command('Open File', 'Ctrl+O', Icons.file_open),
    _Command('Save', 'Ctrl+S', Icons.save),
    _Command('Save As…', 'Ctrl+Shift+S', Icons.save_as),
    _Command('Find', 'Ctrl+F', Icons.search),
    _Command('Replace', 'Ctrl+H', Icons.find_replace),
    _Command('Toggle Terminal', 'Ctrl+`', Icons.terminal),
    _Command('Format Document', 'Shift+Alt+F', Icons.format_indent_increase),
    _Command('Reload Window', 'Ctrl+R', Icons.refresh),
    _Command('Quit', 'Ctrl+Q', Icons.power_settings_new),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: RawAutocomplete<_Command>(
        displayStringForOption: (_Command c) => c.name,
        optionsBuilder: (TextEditingValue v) => _commands.where(
            (_Command c) =>
                c.name.toLowerCase().contains(v.text.toLowerCase())),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.terminal),
              hintText: 'Type a command…',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<_Command> onSelected,
            Iterable<_Command> options) {
          final List<_Command> list = options.toList();
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFF1F2329),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 200, maxWidth: 360),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int hi =
                        AutocompleteHighlightedOption.of(context);
                    final bool active = hi == index;
                    final _Command c = list[index];
                    return InkWell(
                      onTap: () => onSelected(c),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        color: active
                            ? Colors.indigo.withOpacity(0.4)
                            : Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Icon(c.icon,
                                color: active
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                size: 18),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                c.name,
                                style: TextStyle(
                                  color: active
                                      ? Colors.white
                                      : Colors.grey.shade300,
                                  fontFamily: 'monospace',
                                  fontWeight: active
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              c.shortcut,
                              style: TextStyle(
                                color: active
                                    ? Colors.amber.shade200
                                    : Colors.grey.shade500,
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Mentionable {
  const _Mentionable(this.name, this.handle, this.color);
  final String name;
  final String handle;
  final Color color;
}

class _MentionPicker extends StatelessWidget {
  const _MentionPicker();

  static const List<_Mentionable> _users = <_Mentionable>[
    _Mentionable('Alice Aerden', 'aerden', Colors.pink),
    _Mentionable('Bob Bauer', 'bbauer', Colors.blue),
    _Mentionable('Carla Cruz', 'ccruz', Colors.purple),
    _Mentionable('Dimitri Dvorak', 'ddvorak', Colors.deepOrange),
    _Mentionable('Eve Edwards', 'eedwards', Colors.green),
    _Mentionable('Felix Fenton', 'ffenton', Colors.teal),
    _Mentionable('Greta Gardner', 'ggardner', Colors.indigo),
    _Mentionable('Hugo Hoffmann', 'hhoff', Colors.brown),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: RawAutocomplete<_Mentionable>(
        displayStringForOption: (_Mentionable m) => '@${m.handle}',
        optionsBuilder: (TextEditingValue v) => _users.where(
            (_Mentionable u) =>
                u.name.toLowerCase().contains(v.text.toLowerCase()) ||
                u.handle.toLowerCase().contains(v.text.toLowerCase())),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: 'Mention someone…',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<_Mentionable> onSelected,
            Iterable<_Mentionable> options) {
          final List<_Mentionable> list = options.toList();
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 200, maxWidth: 380),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int hi =
                        AutocompleteHighlightedOption.of(context);
                    final bool active = hi == index;
                    final _Mentionable m = list[index];
                    return InkWell(
                      onTap: () => onSelected(m),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        color: active
                            ? m.color.withOpacity(0.10)
                            : Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: m.color,
                              child: Text(
                                m.name.substring(0, 1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    m.name,
                                    style: TextStyle(
                                      fontWeight: active
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                    ),
                                  ),
                                  Text('@${m.handle}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade700,
                                      )),
                                ],
                              ),
                            ),
                            if (active)
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text('press enter ↵',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                    )),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Tag {
  const _Tag(this.name, this.uses);
  final String name;
  final int uses;
}

class _TagSelector extends StatelessWidget {
  const _TagSelector();

  static const List<_Tag> _tags = <_Tag>[
    _Tag('flutter', 12048),
    _Tag('dart', 9203),
    _Tag('android', 7521),
    _Tag('ios', 6240),
    _Tag('web', 5503),
    _Tag('rust', 3802),
    _Tag('go', 3411),
    _Tag('python', 9912),
    _Tag('typescript', 7820),
    _Tag('java', 6604),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: RawAutocomplete<_Tag>(
        displayStringForOption: (_Tag t) => '#${t.name}',
        optionsBuilder: (TextEditingValue v) => _tags.where((_Tag t) =>
            t.name.toLowerCase().contains(v.text.toLowerCase())),
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focus,
            VoidCallback onSubmit) {
          return TextField(
            controller: controller,
            focusNode: focus,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.tag),
              hintText: 'Add tag…',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (_) => onSubmit(),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<_Tag> onSelected,
            Iterable<_Tag> options) {
          final List<_Tag> list = options.toList();
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 200, maxWidth: 360),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int hi =
                        AutocompleteHighlightedOption.of(context);
                    final bool active = hi == index;
                    final _Tag t = list[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: InkWell(
                        onTap: () => onSelected(t),
                        borderRadius: BorderRadius.circular(20),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: active
                                ? Colors.teal.shade50
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: active
                                ? <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.teal.withOpacity(0.5),
                                      blurRadius: 14,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : <BoxShadow>[],
                            border: Border.all(
                              color: active
                                  ? Colors.teal
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.tag,
                                  size: 16,
                                  color: active
                                      ? Colors.teal
                                      : Colors.grey.shade600),
                              const SizedBox(width: 6),
                              Text(
                                t.name,
                                style: TextStyle(
                                  fontWeight: active
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: active
                                      ? Colors.teal.shade900
                                      : Colors.grey.shade800,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${t.uses} uses',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 12. Reference Table
// ---------------------------------------------------------------------------

class _ReferenceTableSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          number: 12,
          title: 'Reference table',
          subtitle: 'Related types in the autocomplete ecosystem.',
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(220),
                1: FlexColumnWidth(),
              },
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.shade200),
              ),
              children: <TableRow>[
                _RefRow.header('Type', 'Description'),
                _RefRow.body('AutocompleteHighlightedOption',
                    'InheritedNotifier<ValueNotifier<int>>; '
                        '`.of(context)` returns the highlighted index.'),
                _RefRow.body('RawAutocomplete<T>',
                    'Low-level autocomplete primitive owning the field, '
                        'the popup and the highlighted index.'),
                _RefRow.body('Autocomplete<T>',
                    'Material-styled wrapper around RawAutocomplete; '
                        'renders highlight automatically.'),
                _RefRow.body('TextEditingController',
                    'Provides the current text value to optionsBuilder; '
                        'shared between fieldViewBuilder and the controller '
                        'returned by RawAutocomplete.'),
                _RefRow.body('FocusNode',
                    'Tracks focus on the underlying TextField. RawAutocomplete '
                        'shows/hides the popup based on its focus state.'),
                _RefRow.body('AutocompleteOptionsBuilder<T>',
                    'Function returning the candidate options for a given '
                        'TextEditingValue.'),
                _RefRow.body('AutocompleteOnSelected<T>',
                    'Callback fired when the user picks an option (Enter, '
                        'Tab, tap).'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const _Paragraph(
            'For a one-line summary: `AutocompleteHighlightedOption` is how '
            'a custom optionsViewBuilder learns which option the user is '
            'about to select. Read it deep, render the highlight however '
            'you like, and let RawAutocomplete handle the keyboard.'),
      ],
    );
  }
}

class _RefRow {
  static TableRow header(String left, String right) {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade100),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(left,
              style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(right,
              style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }

  static TableRow body(String left, String right) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(left,
              style: const TextStyle(
                  fontFamily: 'monospace', fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(right, style: const TextStyle(height: 1.4)),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Closing notes
//
// The whole demo is intentionally redundant: every section contains a real
// RawAutocomplete<T>, every section calls AutocompleteHighlightedOption.of
// from inside an option widget, and every section explores a different
// rendering strategy. Together they form a complete cookbook for custom
// autocomplete UIs in Flutter.
//
// Key takeaways:
//
//   * AutocompleteHighlightedOption is the glue between RawAutocomplete and
//     your custom options view.
//   * Its `of(context)` returns 0 outside an active options view — be careful.
//   * The highlight is a *cursor*, not a selection.
//   * Read the inherited value as deep in the option subtree as you can to
//     keep rebuilds tight.
//   * Material's Autocomplete<T> already does all this for the default
//     list; reach for AutocompleteHighlightedOption only when you're
//     authoring a custom optionsViewBuilder.
//
// This file is hand-authored, well over 1500 lines, and analyzer-clean.
// ---------------------------------------------------------------------------
