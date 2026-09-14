import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ToolbarOptionsDemo();
}

const Color _kPrimary = Color(0xFF0D47A1);
const Color _kAccent = Color(0xFFFFB300);
const Color _kSurface = Color(0xFFE3F2FD);
const Color _kCard = Colors.white;

class _ToolbarOptionsDemo extends StatefulWidget {
  const _ToolbarOptionsDemo();

  @override
  State<_ToolbarOptionsDemo> createState() => _ToolbarOptionsDemoState();
}

class _ToolbarOptionsDemoState extends State<_ToolbarOptionsDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: const Text('ToolbarOptions Legacy Model'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'Option Matrix'),
            Tab(text: 'Interaction Lab'),
            Tab(text: 'Migration Guide'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _OptionMatrixTab(),
          _InteractionLabTab(),
          _MigrationGuideTab(),
        ],
      ),
    );
  }
}

class _OptionMatrixTab extends StatelessWidget {
  const _OptionMatrixTab();

  static const List<_LegacyToolbarProfile> _profiles = [
    _LegacyToolbarProfile(
      name: 'All disabled baseline',
      copy: false,
      cut: false,
      paste: false,
      selectAll: false,
      context: 'Locked field or custom policy gate',
    ),
    _LegacyToolbarProfile(
      name: 'Read-only text',
      copy: true,
      cut: false,
      paste: false,
      selectAll: true,
      context: 'Documentation viewers and transcript panes',
    ),
    _LegacyToolbarProfile(
      name: 'Standard editor',
      copy: true,
      cut: true,
      paste: true,
      selectAll: true,
      context: 'Default text input with full editing rights',
    ),
    _LegacyToolbarProfile(
      name: 'Clipboard restricted',
      copy: true,
      cut: false,
      paste: false,
      selectAll: true,
      context: 'Sensitive fields where outbound data is controlled',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Legacy ToolbarOptions Semantics',
          body:
              'This demo models the four legacy boolean capabilities (copy, cut, '
              'paste, selectAll) and shows how policy combinations affect the '
              'resulting command surface.',
        ),
        const SizedBox(height: 12),
        const _Heading('Preset Matrix'),
        const SizedBox(height: 8),
        for (final profile in _profiles)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _ProfileMatrixCard(profile: profile),
          ),
        const SizedBox(height: 12),
        const _Heading('Interpretation Notes'),
        const SizedBox(height: 8),
        const _NoteCard(
          lines: [
            'Legacy booleans are easy to reason about but rigid in extension.',
            'Custom actions (for example Translate or Summarize) do not fit naturally.',
            'Boolean-only configuration cannot rank actions by context priority.',
            'Modern builder APIs support richer menu composition and adaptive layout.',
          ],
        ),
      ],
    );
  }
}

class _InteractionLabTab extends StatefulWidget {
  const _InteractionLabTab();

  @override
  State<_InteractionLabTab> createState() => _InteractionLabTabState();
}

class _InteractionLabTabState extends State<_InteractionLabTab> {
  bool _copy = true;
  bool _cut = true;
  bool _paste = true;
  bool _selectAll = true;
  bool _isReadOnly = false;
  bool _hasSelection = true;
  bool _clipboardHasData = true;

  @override
  Widget build(BuildContext context) {
    final actions = _deriveActions(
      options: _LegacyToolbarProfile(
        name: 'live',
        copy: _copy,
        cut: _cut,
        paste: _paste,
        selectAll: _selectAll,
        context: 'live',
      ),
      readOnly: _isReadOnly,
      hasSelection: _hasSelection,
      clipboardHasData: _clipboardHasData,
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Live Interaction Lab',
          body:
              'Tune option booleans and context state to observe resulting toolbar '
              'actions. This highlights why command rendering depends on both '
              'configuration and runtime conditions.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: const Text('copy'),
                  selected: _copy,
                  onSelected: (v) => setState(() => _copy = v),
                ),
                FilterChip(
                  label: const Text('cut'),
                  selected: _cut,
                  onSelected: (v) => setState(() => _cut = v),
                ),
                FilterChip(
                  label: const Text('paste'),
                  selected: _paste,
                  onSelected: (v) => setState(() => _paste = v),
                ),
                FilterChip(
                  label: const Text('selectAll'),
                  selected: _selectAll,
                  onSelected: (v) => setState(() => _selectAll = v),
                ),
                const SizedBox(width: 14),
                FilterChip(
                  label: const Text('readOnly'),
                  selected: _isReadOnly,
                  onSelected: (v) => setState(() => _isReadOnly = v),
                ),
                FilterChip(
                  label: const Text('hasSelection'),
                  selected: _hasSelection,
                  onSelected: (v) => setState(() => _hasSelection = v),
                ),
                FilterChip(
                  label: const Text('clipboardHasData'),
                  selected: _clipboardHasData,
                  onSelected: (v) => setState(() => _clipboardHasData = v),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rendered Command Surface',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final action in actions)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: action.color,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(action.icon, size: 16, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              action.label,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    if (actions.isEmpty)
                      const Text('No commands are currently eligible.'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Decision Explanation',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _RuleLine(
                  satisfied: _copy && _hasSelection,
                  text: 'Copy requires option enabled and active selection.',
                ),
                _RuleLine(
                  satisfied: _cut && _hasSelection && !_isReadOnly,
                  text: 'Cut requires selection and writable context.',
                ),
                _RuleLine(
                  satisfied: _paste && _clipboardHasData && !_isReadOnly,
                  text: 'Paste requires clipboard content and writable context.',
                ),
                _RuleLine(
                  satisfied: _selectAll,
                  text: 'Select all is independent from current selection.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MigrationGuideTab extends StatelessWidget {
  const _MigrationGuideTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _IntroCard(
          title: 'Migration to Context Menu Builder',
          body:
              'Modern toolbar customization should be expressed through '
              'context-menu builders and button item composition rather than '
              'fixed legacy booleans.',
        ),
        SizedBox(height: 12),
        _MigrationStepCard(
          title: 'Step 1: Capture editing context',
          body:
              'Use selection state, editability, and platform to derive command '
              'eligibility dynamically.',
        ),
        _MigrationStepCard(
          title: 'Step 2: Build adaptive item list',
          body:
              'Compose items in priority order and include custom actions '
              'specific to your product domain.',
        ),
        _MigrationStepCard(
          title: 'Step 3: Handle overflow explicitly',
          body:
              'Use menu sections and overflow affordances for small viewports '
              'instead of dropping commands unexpectedly.',
        ),
        _MigrationStepCard(
          title: 'Step 4: Document policy presets',
          body:
              'Define named policy profiles (for example read-only, secure, '
              'full-edit) to keep behavior consistent across editors.',
        ),
        SizedBox(height: 12),
        _CodeCard(),
      ],
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );
  }
}

class _ProfileMatrixCard extends StatelessWidget {
  const _ProfileMatrixCard({required this.profile});

  final _LegacyToolbarProfile profile;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(profile.name, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _BoolTag(label: 'copy', value: profile.copy),
                _BoolTag(label: 'cut', value: profile.cut),
                _BoolTag(label: 'paste', value: profile.paste),
                _BoolTag(label: 'selectAll', value: profile.selectAll),
              ],
            ),
            const SizedBox(height: 8),
            Text(profile.context),
          ],
        ),
      ),
    );
  }
}

class _BoolTag extends StatelessWidget {
  const _BoolTag({required this.label, required this.value});

  final String label;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: value ? const Color(0xFFC8E6C9) : const Color(0xFFFFCDD2),
      ),
      child: Text(
        '$label: ${value ? 'on' : 'off'}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: value ? const Color(0xFF1B5E20) : const Color(0xFFB71C1C),
        ),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final line in lines)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text('• $line'),
              ),
          ],
        ),
      ),
    );
  }
}

class _RuleLine extends StatelessWidget {
  const _RuleLine({required this.satisfied, required this.text});

  final bool satisfied;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            satisfied ? Icons.check_circle : Icons.cancel,
            color: satisfied ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _MigrationStepCard extends StatelessWidget {
  const _MigrationStepCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: _kCard,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(body),
            ],
          ),
        ),
      ),
    );
  }
}

class _CodeCard extends StatelessWidget {
  const _CodeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'contextMenuBuilder: (context, editableTextState) {\n'
            '  final items = buildMenuItems(editableTextState);\n'
            '  return AdaptiveTextSelectionToolbar.buttonItems(\n'
            '    anchors: editableTextState.contextMenuAnchors,\n'
            '    buttonItems: items,\n'
            '  );\n'
            '}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 13),
          ),
        ),
      ),
    );
  }
}

class _LegacyToolbarProfile {
  const _LegacyToolbarProfile({
    required this.name,
    required this.copy,
    required this.cut,
    required this.paste,
    required this.selectAll,
    required this.context,
  });

  final String name;
  final bool copy;
  final bool cut;
  final bool paste;
  final bool selectAll;
  final String context;
}

class _DerivedAction {
  const _DerivedAction({required this.label, required this.icon, required this.color});

  final String label;
  final IconData icon;
  final Color color;
}

List<_DerivedAction> _deriveActions({
  required _LegacyToolbarProfile options,
  required bool readOnly,
  required bool hasSelection,
  required bool clipboardHasData,
}) {
  final List<_DerivedAction> actions = [];
  if (options.copy && hasSelection) {
    actions.add(
      const _DerivedAction(
        label: 'Copy',
        icon: Icons.copy,
        color: Color(0xFF00695C),
      ),
    );
  }
  if (options.cut && hasSelection && !readOnly) {
    actions.add(
      const _DerivedAction(
        label: 'Cut',
        icon: Icons.content_cut,
        color: Color(0xFF0277BD),
      ),
    );
  }
  if (options.paste && clipboardHasData && !readOnly) {
    actions.add(
      const _DerivedAction(
        label: 'Paste',
        icon: Icons.content_paste,
        color: Color(0xFF6A1B9A),
      ),
    );
  }
  if (options.selectAll) {
    actions.add(
      const _DerivedAction(
        label: 'Select all',
        icon: Icons.select_all,
        color: Color(0xFFE65100),
      ),
    );
  }
  return actions;
}
