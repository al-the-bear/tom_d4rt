import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level data model
// ---------------------------------------------------------------------------

class _Item {
  _Item(this.id, this.label);
  final int id;
  final String label;

  @override
  String toString() => '_Item($id, "$label")';
}

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers (STATELESS permitted)
// ---------------------------------------------------------------------------

final ValueNotifier<List<_Item>> _liveItems = ValueNotifier<List<_Item>>([
  _Item(1, 'Alpha'),
  _Item(2, 'Beta'),
  _Item(3, 'Gamma'),
  _Item(4, 'Delta'),
  _Item(5, 'Epsilon'),
]);

int _nextId = 6;

final ValueNotifier<List<_Item>> _identityItems = ValueNotifier<List<_Item>>([
  _Item(10, 'Apple'),
  _Item(11, 'Banana'),
]);

final ValueNotifier<List<_Item>> _animItems = ValueNotifier<List<_Item>>([
  _Item(20, 'Mercury'),
  _Item(21, 'Venus'),
  _Item(22, 'Earth'),
  _Item(23, 'Mars'),
]);

int _nextAnimId = 24;

// ---------------------------------------------------------------------------
// Helper builders (stateless functions returning widgets)
// ---------------------------------------------------------------------------

Widget _sectionHeader(String title, ColorScheme cs) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: cs.primaryContainer,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: cs.onPrimaryContainer,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _chip(String label, Color bg, Color fg) {
  return Chip(
    label: Text(label, style: TextStyle(color: fg, fontSize: 12)),
    backgroundColor: bg,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: const EdgeInsets.symmetric(horizontal: 4),
  );
}

Widget _infoCard(String title, String body, ColorScheme cs) {
  return Card(
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: cs.primary, fontSize: 13)),
          const SizedBox(height: 6),
          Text(body,
              style: const TextStyle(fontSize: 12, height: 1.5)),
        ],
      ),
    ),
  );
}

Widget _monoBox(String text, ColorScheme cs) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: cs.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cs.outline.withAlpha(80)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: cs.onSurface,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tab 1 — Hero banner
// ---------------------------------------------------------------------------

Widget _buildHeroBanner(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cs.primary, cs.tertiary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: cs.shadow.withAlpha(60),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.vpn_key_rounded, color: cs.onPrimary, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    'ObjectKey',
                    style: TextStyle(
                      color: cs.onPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'class ObjectKey extends LocalKey',
                style: TextStyle(
                  color: cs.onPrimary.withAlpha(200),
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'A key whose equality is determined by the equality of the '
                'wrapped value object. Internally uses == and hashCode of '
                'the value, making it ideal for tracking distinct object '
                'instances across widget rebuilds.',
                style: TextStyle(
                  color: cs.onPrimary.withAlpha(230),
                  fontSize: 13,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        _sectionHeader('When to use ObjectKey', cs),
        const SizedBox(height: 12),

        _infoCard(
          'Use ObjectKey when…',
          '• You hold a list of Dart objects and want Flutter to match '
              'widgets to the same object across rebuilds.\n'
              '• Objects may be reordered, removed, or inserted and you need '
              'stable widget-to-object binding.\n'
              '• You need to preserve widget state (e.g. scroll position, '
              'focus) when list items shuffle.\n'
              '• Two different object instances should produce different keys '
              'even if their fields happen to be equal (assuming no == '
              'override, or intentional == override for identity).',
          cs,
        ),
        const SizedBox(height: 10),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _infoCard(
                'ObjectKey vs ValueKey',
                'ValueKey uses the value itself via ==. '
                    'If two objects have equal fields but are distinct '
                    'instances, ValueKey treats them as the same key. '
                    'ObjectKey uses the value\'s == — so classes that '
                    'don\'t override == get identity semantics.',
                cs,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _infoCard(
                'ObjectKey vs UniqueKey',
                'UniqueKey is always distinct — even two keys wrapping the '
                    'same object are unequal. ObjectKey allows equality when '
                    'the same object is wrapped again. Use UniqueKey only '
                    'when you deliberately want to force a full rebuild.',
                cs,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        _infoCard(
          'Constructor',
          'const ObjectKey(Object? value)\n\n'
              'value — the object whose identity (via ==) determines key '
              'equality. May be null; ObjectKey(null) is valid and produces '
              'a key equal to any other ObjectKey(null).',
          cs,
        ),
        const SizedBox(height: 10),

        _sectionHeader('Class hierarchy', cs),
        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _monoBox('Object', cs),
            const SizedBox(width: 6),
            Icon(Icons.arrow_forward, size: 16,
                color: cs.onSurface.withAlpha(120)),
            const SizedBox(width: 6),
            _monoBox('Key', cs),
            const SizedBox(width: 6),
            Icon(Icons.arrow_forward, size: 16,
                color: cs.onSurface.withAlpha(120)),
            const SizedBox(width: 6),
            _monoBox('LocalKey', cs),
            const SizedBox(width: 6),
            Icon(Icons.arrow_forward, size: 16,
                color: cs.onSurface.withAlpha(120)),
            const SizedBox(width: 6),
            _monoBox('ObjectKey', cs),
          ],
        ),
        const SizedBox(height: 20),

        _sectionHeader('Quick API summary', cs),
        const SizedBox(height: 12),

        Table(
          border: TableBorder.all(
              color: cs.outline.withAlpha(60), borderRadius: BorderRadius.circular(8)),
          columnWidths: const {
            0: FlexColumnWidth(1.6),
            1: FlexColumnWidth(2.4),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: cs.primaryContainer),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('Member',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: cs.onPrimaryContainer,
                          fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('Description',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: cs.onPrimaryContainer,
                          fontSize: 12)),
                ),
              ],
            ),
            _tableRow('ObjectKey(value)', 'Constructor; wraps the value.', cs),
            _tableRow('value', 'The wrapped Object? instance.', cs),
            _tableRow('==', 'Delegates to value.==; two ObjectKeys equal iff their values are equal.', cs),
            _tableRow('hashCode', 'Delegates to value.hashCode.', cs),
            _tableRow('toString()', 'Returns [ObjectKey value].', cs),
          ],
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}

TableRow _tableRow(String col1, String col2, ColorScheme cs) {
  return TableRow(children: [
    Padding(
      padding: const EdgeInsets.all(8),
      child: Text(col1,
          style: TextStyle(
              fontFamily: 'monospace', fontSize: 11, color: cs.primary)),
    ),
    Padding(
      padding: const EdgeInsets.all(8),
      child: Text(col2, style: const TextStyle(fontSize: 11, height: 1.4)),
    ),
  ]);
}

// ---------------------------------------------------------------------------
// Tab 2 — Live list reordering demo
// ---------------------------------------------------------------------------

Widget _buildLiveListDemo(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  final colors = [
    cs.primaryContainer,
    cs.secondaryContainer,
    cs.tertiaryContainer,
    cs.errorContainer,
    Colors.teal.shade100,
    Colors.amber.shade100,
    Colors.purple.shade100,
  ];

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('Live List Reordering with ObjectKey', cs),
            const SizedBox(height: 10),
            Text(
              'Each tile uses key: ObjectKey(item) where item is a _Item '
              'instance. When the list is shuffled Flutter uses the key to '
              'match existing widget elements to the new positions, '
              'preserving state and animating efficiently instead of '
              'rebuilding everything from scratch.',
              style: const TextStyle(fontSize: 12, height: 1.5),
            ),
            const SizedBox(height: 10),
            _monoBox(
              'ListView.builder(\n'
              '  itemBuilder: (ctx, i) => ListTile(\n'
              '    key: ObjectKey(items[i]),  // <-- identity binding\n'
              '    ...\n'
              '  ),\n'
              ')',
              cs,
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<List<_Item>>(
              valueListenable: _liveItems,
              builder: (context, items, _) {
                return Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          final shuffled = List<_Item>.from(items)..shuffle();
                          _liveItems.value = shuffled;
                        },
                        icon: const Icon(Icons.shuffle, size: 16),
                        label: const Text('Shuffle'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: () {
                          _liveItems.value = [
                            ...items,
                            _Item(_nextId++, 'Item-$_nextId'),
                          ];
                        },
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: items.isEmpty
                            ? null
                            : () {
                                final copy = List<_Item>.from(items);
                                copy.removeLast();
                                _liveItems.value = copy;
                              },
                        icon: const Icon(Icons.remove, size: 16),
                        label: const Text('Remove'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      Expanded(
        child: ValueListenableBuilder<List<_Item>>(
          valueListenable: _liveItems,
          builder: (context, items, _) {
            if (items.isEmpty) {
              return Center(
                child: Text('List is empty — tap Add',
                    style: TextStyle(color: cs.onSurfaceVariant)),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                final item = items[i];
                return Card(
                  key: ObjectKey(item),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: colors[item.id % colors.length],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: cs.primary,
                      child: Text(
                        '${item.id}',
                        style: TextStyle(
                            color: cs.onPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(item.label,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('ObjectKey(item${item.id})',
                        style: const TextStyle(
                            fontFamily: 'monospace', fontSize: 11)),
                    trailing: Icon(Icons.drag_indicator,
                        color: cs.onSurface.withAlpha(100)),
                  ),
                );
              },
            );
          },
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Tab 3 — Identity vs equality
// ---------------------------------------------------------------------------

Widget _buildIdentityVsEquality(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Identity vs Equality', cs),
        const SizedBox(height: 12),
        Text(
          'Add two items with the same label. The left panel uses '
          'ValueKey(item.label) — it sees duplicates as the same key and '
          'may confuse Flutter. The right panel uses ObjectKey(item) — '
          'each instance is a distinct key regardless of label.',
          style: const TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 12),

        ValueListenableBuilder<List<_Item>>(
          valueListenable: _identityItems,
          builder: (context, items, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          _identityItems.value = [
                            ...items,
                            _Item(100 + items.length, 'Apple'),
                          ];
                        },
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add "Apple"'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: () {
                          _identityItems.value = [
                            ...items,
                            _Item(200 + items.length, 'Unique-${items.length}'),
                          ];
                        },
                        icon: const Icon(Icons.add_circle_outline, size: 16),
                        label: const Text('Add Unique'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: items.isEmpty
                          ? null
                          : () {
                              final copy = List<_Item>.from(items);
                              copy.removeLast();
                              _identityItems.value = copy;
                            },
                      child: const Text('Remove'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT — ValueKey panel
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: cs.errorContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.warning_amber_rounded,
                                    color: cs.error, size: 16),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text('ValueKey(item.label)',
                                      style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 11,
                                          color: cs.onErrorContainer,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...items.map((item) {
                            return Card(
                              key: ValueKey(item.label),
                              color: cs.errorContainer.withAlpha(80),
                              margin: const EdgeInsets.only(bottom: 4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.label,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13)),
                                    Text('id=${item.id}',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: cs.onSurface.withAlpha(140))),
                                    _monoBox(
                                        'ValueKey("${item.label}")', cs),
                                  ],
                                ),
                              ),
                            );
                          }),
                          if (items
                              .where((x) => x.label == 'Apple')
                              .length > 1)
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: cs.error.withAlpha(30),
                                borderRadius: BorderRadius.circular(6),
                                border:
                                    Border.all(color: cs.error.withAlpha(80)),
                              ),
                              child: Text(
                                'Duplicate ValueKey("Apple") detected! '
                                'Flutter cannot distinguish these tiles '
                                'and may exhibit undefined behavior.',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: cs.error,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),

                    // RIGHT — ObjectKey panel
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: cs.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle_rounded,
                                    color: cs.primary, size: 16),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text('ObjectKey(item)',
                                      style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 11,
                                          color: cs.onPrimaryContainer,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...items.map((item) {
                            return Card(
                              key: ObjectKey(item),
                              color: cs.primaryContainer.withAlpha(80),
                              margin: const EdgeInsets.only(bottom: 4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.label,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13)),
                                    Text('id=${item.id}',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color:
                                                cs.onSurface.withAlpha(140))),
                                    _monoBox('ObjectKey(item${item.id})', cs),
                                  ],
                                ),
                              ),
                            );
                          }),
                          if (items
                              .where((x) => x.label == 'Apple')
                              .length > 1)
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: cs.primary.withAlpha(20),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: cs.primary.withAlpha(80)),
                              ),
                              child: Text(
                                'Two "Apple" items — ObjectKey keeps them '
                                'distinct because they are different '
                                '_Item instances.',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: cs.primary,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Tab 4 — Key equality demo
// ---------------------------------------------------------------------------

class _EqObject {
  _EqObject(this.value);
  final int value;

  @override
  bool operator ==(Object other) =>
      other is _EqObject && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => '_EqObject($value)';
}

Widget _buildKeyEqualityDemo(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  final objA1 = _EqObject(42);
  final objA2 = _EqObject(42);
  final objB = _EqObject(99);
  final rawMapX = {'id': 7};
  final rawMapY = {'id': 7};

  final kA1 = ObjectKey(objA1);
  final kA2 = ObjectKey(objA2);
  final kB = ObjectKey(objB);
  final kNull1 = const ObjectKey(null);
  final kNull2 = const ObjectKey(null);
  final kMapX = ObjectKey(rawMapX);
  final kMapY = ObjectKey(rawMapY);

  Widget row(String expr, bool result, String note) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _monoBox(expr, cs),
          ),
          const SizedBox(width: 8),
          _chip(
            result ? 'true' : 'false',
            result ? cs.primaryContainer : cs.errorContainer,
            result ? cs.onPrimaryContainer : cs.onErrorContainer,
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(note,
                style: const TextStyle(fontSize: 11, height: 1.4)),
          ),
        ],
      ),
    );
  }

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Key Equality Rules', cs),
        const SizedBox(height: 12),
        Text(
          'ObjectKey equality delegates entirely to the wrapped value\'s '
          '== operator. Objects that override == for value semantics will '
          'produce equal ObjectKeys even for distinct instances. Objects '
          'that do NOT override == use identity (default Object ==).',
          style: const TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 14),

        _sectionHeader('Scenario A — class with == override', cs),
        const SizedBox(height: 8),
        _monoBox(
          'class _EqObject {\n'
          '  final int value;\n'
          '  // overrides == and hashCode\n'
          '}',
          cs,
        ),
        const SizedBox(height: 10),
        row(
          'ObjectKey(_EqObject(42)) == ObjectKey(_EqObject(42))',
          kA1 == kA2,
          'TRUE — both wrappers have value.== returning true',
        ),
        row(
          'ObjectKey(_EqObject(42)) == ObjectKey(_EqObject(99))',
          kA1 == kB,
          'FALSE — different value',
        ),
        row(
          'ObjectKey(_EqObject(42)).hashCode == ObjectKey(_EqObject(42)).hashCode',
          kA1.hashCode == kA2.hashCode,
          'TRUE — hashCode consistent with ==',
        ),
        const SizedBox(height: 14),

        _sectionHeader('Scenario B — plain Map (== is identity)', cs),
        const SizedBox(height: 8),
        _monoBox(
          'final mapX = {\'id\': 7};\n'
          'final mapY = {\'id\': 7}; // different instance',
          cs,
        ),
        const SizedBox(height: 10),
        row(
          'ObjectKey(mapX) == ObjectKey(mapX)',
          ObjectKey(rawMapX) == ObjectKey(rawMapX),
          'TRUE — same instance',
        ),
        row(
          'ObjectKey(mapX) == ObjectKey(mapY)',
          kMapX == kMapY,
          'FALSE — Map does not override == (identity)',
        ),
        const SizedBox(height: 14),

        _sectionHeader('Scenario C — null value', cs),
        const SizedBox(height: 8),
        row(
          'ObjectKey(null) == ObjectKey(null)',
          kNull1 == kNull2,
          'TRUE — both wrap null; null == null',
        ),
        row(
          'ObjectKey(null).hashCode == ObjectKey(null).hashCode',
          kNull1.hashCode == kNull2.hashCode,
          'TRUE — consistent',
        ),
        const SizedBox(height: 14),

        _sectionHeader('toString samples', cs),
        const SizedBox(height: 8),
        _monoBox('ObjectKey(_EqObject(42)).toString() → $kA1', cs),
        const SizedBox(height: 4),
        _monoBox('ObjectKey(null).toString() → $kNull1', cs),
        const SizedBox(height: 20),

        Card(
          color: cs.tertiaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Key insight',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: cs.onTertiaryContainer)),
                const SizedBox(height: 6),
                Text(
                  'ObjectKey is NOT the same as "identity key". It forwards '
                  'to value.==. If your class overrides == for value '
                  'equality, two distinct instances with the same data '
                  'produce equal ObjectKeys — just like ValueKey would. '
                  'For true identity semantics, ensure the class does NOT '
                  'override ==.',
                  style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: cs.onTertiaryContainer),
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

// ---------------------------------------------------------------------------
// Tab 5 — Key comparison table
// ---------------------------------------------------------------------------

Widget _buildComparisonTable(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  const headers = ['Feature', 'ObjectKey', 'ValueKey', 'UniqueKey', 'GlobalKey'];
  const rows = [
    [
      'Equality rule',
      'Delegates to\nvalue.==',
      'Compares\nvalue via ==',
      'Never equal\nto anything',
      'Only equal\nto itself',
    ],
    [
      'Reuse across\nrebuilds',
      'Yes — wrap same\nvalue again',
      'Yes — wrap equal\nvalue again',
      'No — each call\ncreates new key',
      'Yes — keep\nreference',
    ],
    [
      'Suitable for',
      'Lists of model\nobjects',
      'Lists keyed by\nprimitive/value',
      'Forcing full\nrebuild',
      'Cross-subtree\naccess',
    ],
    [
      'Created from',
      'Any Object?\ninstance',
      'Any comparable\nvalue',
      'Nothing (no\nargs)',
      'Typed on\nState subclass',
    ],
    [
      'Cross-widget\ntree',
      'Local subtree\nonly',
      'Local subtree\nonly',
      'Local subtree\nonly',
      'Entire widget\ntree',
    ],
  ];

  final colColors = [
    cs.surfaceContainerHighest,
    cs.primaryContainer,
    cs.secondaryContainer,
    cs.tertiaryContainer,
    cs.errorContainer,
  ];

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Key Type Comparison', cs),
        const SizedBox(height: 14),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            defaultColumnWidth: const FixedColumnWidth(130),
            border: TableBorder.all(
                color: cs.outline.withAlpha(60),
                borderRadius: BorderRadius.circular(8)),
            children: [
              // Header row
              TableRow(
                children: List.generate(headers.length, (ci) {
                  return Container(
                    color: colColors[ci],
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      headers[ci],
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: cs.onSurface),
                    ),
                  );
                }),
              ),
              // Data rows
              ...rows.map((row) {
                return TableRow(
                  children: List.generate(row.length, (ci) {
                    return Container(
                      color: ci == 1
                          ? cs.primaryContainer.withAlpha(50)
                          : null,
                      padding: const EdgeInsets.all(9),
                      child: Text(
                        row[ci],
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.4,
                          fontWeight: ci == 0
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  }),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 20),

        _sectionHeader('Decision flowchart', cs),
        const SizedBox(height: 14),

        _decisionCard(
          'Do you need to access the widget/state from outside?',
          'YES → GlobalKey',
          'NO → continue',
          cs,
          cs.errorContainer,
        ),
        _decisionArrow(cs),
        _decisionCard(
          'Do you want every rebuild to produce a new, distinct key?',
          'YES → UniqueKey',
          'NO → continue',
          cs,
          cs.tertiaryContainer,
        ),
        _decisionArrow(cs),
        _decisionCard(
          'Is your key based on a primitive or a value type (int, String, enum)?',
          'YES → ValueKey',
          'NO → continue',
          cs,
          cs.secondaryContainer,
        ),
        _decisionArrow(cs),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cs.primary),
          ),
          child: Text(
            'You have a Dart object instance → ObjectKey',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: cs.onPrimaryContainer,
                fontSize: 13),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}

Widget _decisionCard(
    String q, String yes, String no, ColorScheme cs, Color bg) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(q,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
        const SizedBox(height: 6),
        Row(
          children: [
            _chip(yes, Colors.green.shade100, Colors.green.shade900),
            const SizedBox(width: 8),
            _chip(no, Colors.grey.shade200, Colors.grey.shade800),
          ],
        ),
      ],
    ),
  );
}

Widget _decisionArrow(ColorScheme cs) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 60),
    child: Icon(Icons.arrow_downward, color: cs.onSurface.withAlpha(100)),
  );
}

// ---------------------------------------------------------------------------
// Tab 6 — AnimatedList with ObjectKey
// ---------------------------------------------------------------------------

final GlobalKey<AnimatedListState> _animListKey =
    GlobalKey<AnimatedListState>();

Widget _buildAnimatedListTab(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  final itemColors = [
    cs.primaryContainer,
    cs.secondaryContainer,
    cs.tertiaryContainer,
    cs.errorContainer,
    Colors.teal.shade100,
    Colors.purple.shade100,
  ];

  Widget buildItem(BuildContext ctx, _Item item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        key: ObjectKey(item),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        color: itemColors[item.id % itemColors.length],
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: cs.primary,
            child: Text('${item.id}',
                style: TextStyle(color: cs.onPrimary, fontSize: 12)),
          ),
          title: Text(item.label,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('key: ObjectKey(item${item.id})',
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            onPressed: () {
              final idx = _animItems.value.indexOf(item);
              if (idx < 0) return;
              final removed = item;
              final copy = List<_Item>.from(_animItems.value);
              copy.removeAt(idx);
              _animItems.value = copy;
              _animListKey.currentState?.removeItem(
                idx,
                (context, animation) => buildItem(context, removed, animation),
              );
            },
          ),
        ),
      ),
    );
  }

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('AnimatedList + ObjectKey', cs),
            const SizedBox(height: 10),
            Text(
              'ObjectKey on each AnimatedList item ensures Flutter animates '
              'only the inserted/removed item. Without keys Flutter cannot '
              'determine which physical widget to transition and may apply '
              'the animation to the wrong position.',
              style: const TextStyle(fontSize: 12, height: 1.5),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      final newItem = _Item(_nextAnimId++, 'Planet-$_nextAnimId');
                      final idx = _animItems.value.length;
                      _animItems.value = [..._animItems.value, newItem];
                      _animListKey.currentState?.insertItem(idx);
                    },
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Insert'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () {
                      if (_animItems.value.isEmpty) return;
                      final copy = List<_Item>.from(_animItems.value);
                      copy.insert(0, _Item(_nextAnimId++, 'First-$_nextAnimId'));
                      _animItems.value = copy;
                      _animListKey.currentState?.insertItem(0);
                    },
                    icon: const Icon(Icons.vertical_align_top, size: 16),
                    label: const Text('Prepend'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Expanded(
        child: ValueListenableBuilder<List<_Item>>(
          valueListenable: _animItems,
          builder: (context, items, _) {
            return AnimatedList(
              key: _animListKey,
              initialItemCount: items.length,
              itemBuilder: (ctx, index, animation) {
                if (index >= items.length) return const SizedBox.shrink();
                return buildItem(ctx, items[index], animation);
              },
            );
          },
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Tab 7 — Widget matching diagram (CustomPainter)
// ---------------------------------------------------------------------------

class _MatchingDiagramPainter extends CustomPainter {
  const _MatchingDiagramPainter({
    required this.withKeys,
    required this.cs,
  });

  final bool withKeys;
  final ColorScheme cs;

  static const _labels = ['A', 'B', 'C'];
  static const _labelsReordered = ['C', 'A', 'B'];

  @override
  void paint(Canvas canvas, Size size) {
    final boxW = size.width * 0.22;
    final boxH = 36.0;
    final gap = (size.width - 3 * boxW) / 4;
    final topY = 20.0;
    final botY = size.height - boxH - 20;

    final colors = [
      cs.primaryContainer,
      cs.secondaryContainer,
      cs.tertiaryContainer,
    ];
    final colorsReordered = [
      cs.tertiaryContainer,
      cs.primaryContainer,
      cs.secondaryContainer,
    ];

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = cs.outline.withAlpha(120);

    void drawBox(double x, double y, String label, Color fill) {
      final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, boxW, boxH),
        const Radius.circular(8),
      );
      canvas.drawRRect(rrect, Paint()..color = fill);
      canvas.drawRRect(rrect, borderPaint);
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
              color: cs.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 14),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
          canvas,
          Offset(x + boxW / 2 - tp.width / 2,
              y + boxH / 2 - tp.height / 2));
    }

    void drawLabel(String text, double y) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
              color: cs.onSurface.withAlpha(160), fontSize: 11),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(4, y));
    }

    // Draw frame 1 (top)
    drawLabel('Frame 1: [A, B, C]', topY - 16);
    for (var i = 0; i < 3; i++) {
      final x = gap + i * (boxW + gap);
      drawBox(x, topY, _labels[i], colors[i]);
    }

    // Draw frame 2 (bottom)
    drawLabel('Frame 2: [C, A, B]', botY - 16);
    for (var i = 0; i < 3; i++) {
      final x = gap + i * (boxW + gap);
      final label = _labelsReordered[i];
      final origIdx = _labels.indexOf(label);
      drawBox(x, botY, label, colorsReordered[i]);

      // Draw lines between frames
      final topX = gap + origIdx * (boxW + gap) + boxW / 2;
      final botX = x + boxW / 2;

      if (withKeys) {
        // Curved, colored lines showing correct match
        final linePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = colors[origIdx].withAlpha(220);
        final path = Path();
        path.moveTo(topX, topY + boxH);
        path.cubicTo(
          topX, topY + boxH + 40,
          botX, botY - 40,
          botX, botY,
        );
        canvas.drawPath(path, linePaint);

        // Tick mark
        final tickPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.green.shade600;
        canvas.drawLine(
            Offset(x + 4, botY - 8),
            Offset(x + 10, botY - 2),
            tickPaint);
        canvas.drawLine(
            Offset(x + 10, botY - 2),
            Offset(x + boxW - 4, botY - 14),
            tickPaint);
      } else {
        // Straight dashed lines — no matching, rebuilds all
        final dashPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = cs.error.withAlpha(160);
        final midX = gap + i * (boxW + gap) + boxW / 2;
        _drawDashedLine(canvas, Offset(topX, topY + boxH),
            Offset(midX, botY), dashPaint);

        // X mark
        final xPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = cs.error;
        canvas.drawLine(
            Offset(x + 4, botY - 14), Offset(x + 12, botY - 6), xPaint);
        canvas.drawLine(
            Offset(x + 4, botY - 6), Offset(x + 12, botY - 14), xPaint);
      }
    }

    // Legend
    final legY = size.height - 14.0;
    final legLabel = withKeys
        ? 'ObjectKey: Flutter matches & moves widgets'
        : 'No key: Flutter rebuilds all widgets from scratch';
    final tp = TextPainter(
      text: TextSpan(
        text: legLabel,
        style: TextStyle(
            color: withKeys ? cs.primary : cs.error,
            fontSize: 10,
            fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, legY));
  }

  void _drawDashedLine(
      Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashLen = 6.0;
    const gapLen = 4.0;
    final d = (end - start);
    final len = d.distance;
    final dir = d / len;
    double pos = 0;
    while (pos < len) {
      final a = start + dir * pos;
      final b = start + dir * (pos + dashLen).clamp(0, len);
      canvas.drawLine(a, b, paint);
      pos += dashLen + gapLen;
    }
  }

  @override
  bool shouldRepaint(_MatchingDiagramPainter old) =>
      old.withKeys != withKeys;
}

Widget _buildMatchingDiagram(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Widget Matching Diagram', cs),
        const SizedBox(height: 12),
        Text(
          'When a list reorders, Flutter reconciles old widget elements with '
          'new widget configurations by comparing keys. With ObjectKey Flutter '
          'can move the existing element (preserving state). Without a key '
          'Flutter matches by position and rebuilds everything.',
          style: const TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle,
                            color: cs.primary, size: 14),
                        const SizedBox(width: 4),
                        Text('With ObjectKey',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: cs.onPrimaryContainer,
                                fontSize: 12)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: CustomPaint(
                      painter:
                          _MatchingDiagramPainter(withKeys: true, cs: cs),
                      size: const Size(double.infinity, 200),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: cs.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.cancel, color: cs.error, size: 14),
                        const SizedBox(width: 4),
                        Text('Without Key',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: cs.onErrorContainer,
                                fontSize: 12)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: CustomPaint(
                      painter:
                          _MatchingDiagramPainter(withKeys: false, cs: cs),
                      size: const Size(double.infinity, 200),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        _sectionHeader('Why this matters', cs),
        const SizedBox(height: 12),
        _infoCard(
          'State preservation',
          'Widgets like TextField, Checkbox, or any StatefulWidget carry '
              'their State with them when Flutter moves elements. Without a '
              'key the old state is discarded and a new State is created at '
              'the new position — losing user input, scroll offsets, etc.',
          cs,
        ),
        const SizedBox(height: 8),
        _infoCard(
          'Performance',
          'Moving an existing element is O(1). Rebuilding from scratch '
              'involves layout, paint, and (for stateful widgets) initState '
              'calls for every item. For large lists the difference is '
              'significant.',
          cs,
        ),
        const SizedBox(height: 8),
        _infoCard(
          'Animations',
          'AnimatedList, AnimatedGrid, and hero transitions all rely on '
              'stable keys to identify which physical widget to animate. '
              'ObjectKey provides that stability when your data is a list '
              'of model objects.',
          cs,
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Tab 8 — Null value key
// ---------------------------------------------------------------------------

Widget _buildNullValueTab(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  const k1 = ObjectKey(null);
  const k2 = ObjectKey(null);
  final k3 = ObjectKey('hello');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('ObjectKey(null)', cs),
        const SizedBox(height: 12),
        Text(
          'Passing null to ObjectKey is valid and fully supported. The '
          'resulting key is equal to any other ObjectKey(null) because '
          'null == null evaluates to true in Dart. It can be useful as a '
          '"no object" sentinel key.',
          style: const TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 14),

        _monoBox('const ObjectKey(null)', cs),
        const SizedBox(height: 10),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _equalityRow('k1 = ObjectKey(null)', 'k2 = ObjectKey(null)',
                    'k1 == k2', k1 == k2, cs),
                const SizedBox(height: 8),
                _equalityRow('k1 = ObjectKey(null)',
                    'k3 = ObjectKey("hello")', 'k1 == k3', k1 == k3, cs),
                const SizedBox(height: 8),
                _equalityRow(
                    'k1.hashCode',
                    'k2.hashCode',
                    '${k1.hashCode} == ${k2.hashCode}',
                    k1.hashCode == k2.hashCode,
                    cs),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        _sectionHeader('Visual demo — null key widget', cs),
        const SizedBox(height: 10),
        Container(
          key: k1,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.tertiaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Widget with key: ObjectKey(null)',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: cs.onTertiaryContainer)),
              const SizedBox(height: 4),
              Text('This widget carries key $k1',
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: cs.onTertiaryContainer.withAlpha(200))),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          key: k2,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Another widget with key: ObjectKey(null)',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: cs.onPrimaryContainer)),
              const SizedBox(height: 4),
              Text('Also key $k2 — equals k1 (same null)',
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: cs.onPrimaryContainer.withAlpha(200))),
            ],
          ),
        ),
        const SizedBox(height: 14),

        Card(
          color: cs.errorContainer,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: cs.error, size: 18),
                    const SizedBox(width: 8),
                    Text('Caution',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: cs.onErrorContainer,
                            fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Using ObjectKey(null) on two sibling widgets in the same '
                  'parent causes a duplicate key error at runtime. Flutter '
                  'requires all sibling keys to be unique within a parent '
                  'widget. Only use ObjectKey(null) when you are certain at '
                  'most one sibling will have a null value.',
                  style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: cs.onErrorContainer),
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

Widget _equalityRow(
    String lhs, String rhs, String expr, bool result, ColorScheme cs) {
  return Row(
    children: [
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _monoBox(lhs, cs),
            const SizedBox(height: 2),
            _monoBox(rhs, cs),
          ],
        ),
      ),
      const SizedBox(width: 8),
      Icon(Icons.arrow_forward, size: 14,
          color: cs.onSurface.withAlpha(120)),
      const SizedBox(width: 8),
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _monoBox(expr, cs),
            const SizedBox(height: 4),
            _chip(
              result ? 'true' : 'false',
              result ? cs.primaryContainer : cs.errorContainer,
              result ? cs.onPrimaryContainer : cs.onErrorContainer,
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Tab 9 — Pitfalls
// ---------------------------------------------------------------------------

Widget _buildPitfalls(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Common Pitfalls', cs),
        const SizedBox(height: 14),

        _pitfallCard(
          index: 1,
          title: 'Value-equal objects where identity uniqueness is expected',
          problem:
              'If your class overrides == for value semantics but you want '
              'each instance to have a distinct key, ObjectKey will behave '
              'like ValueKey — two objects with the same data produce the '
              'same key.',
          badCode: 'class Product {\n'
              '  final String sku;\n'
              '  // overrides == by sku\n'
              '}\n'
              '// Two Product("SKU-1") → same ObjectKey!\n'
              'key: ObjectKey(product)',
          fix:
              'Remove the == override, or use a UniqueKey stored on the '
              'object, or compare by identity explicitly (e.g. store a '
              'unique int id and use ValueKey(product.id)).',
          cs: cs,
        ),
        const SizedBox(height: 12),

        _pitfallCard(
          index: 2,
          title: 'GlobalKey vs ObjectKey scope confusion',
          problem:
              'ObjectKey is a LocalKey — it is only meaningful within its '
              'parent widget\'s child list. It does NOT allow you to access '
              'a widget\'s BuildContext or State from outside that subtree. '
              'Trying to read currentContext on an ObjectKey will fail at '
              'compile time (ObjectKey has no such member).',
          badCode: 'final k = ObjectKey(myObj);\n'
              '// WRONG — ObjectKey has no currentContext\n'
              'k.currentContext; // compile error',
          fix:
              'Use GlobalKey<MyWidgetState> when you need to reach across '
              'the widget tree. Reserve ObjectKey for list-item keying.',
          cs: cs,
        ),
        const SizedBox(height: 12),

        _pitfallCard(
          index: 3,
          title: 'Key confusion in nested lists',
          problem:
              'ObjectKey is local to its parent. Two widgets deep in '
              'different subtrees may share the same ObjectKey without '
              'conflict. However, within the same parent all children must '
              'have unique keys. Mixing ObjectKey and ValueKey in the same '
              'sibling list can produce unexpected duplicate key errors if '
              'an ObjectKey happens to equal a ValueKey\'s value (they are '
              'different types so this cannot actually happen — but mixing '
              'key types in one list makes debugging hard).',
          badCode: '// Avoid mixing key types in one list:\n'
              'Column(children: [\n'
              '  Widget(key: ValueKey(1)),\n'
              '  Widget(key: ObjectKey(someObj)),\n'
              '  Widget(key: UniqueKey()),\n'
              '])',
          fix:
              'Use a single consistent key strategy per list. ObjectKey '
              'throughout, or ValueKey throughout. Mixing is allowed but '
              'complicates mental model and debugging.',
          cs: cs,
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}

Widget _pitfallCard({
  required int index,
  required String title,
  required String problem,
  required String badCode,
  required String fix,
  required ColorScheme cs,
}) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: cs.error,
                child: Text('$index',
                    style: TextStyle(
                        color: cs.onError,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: cs.error,
                        fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text('Problem',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                  fontSize: 12)),
          const SizedBox(height: 4),
          Text(problem,
              style: const TextStyle(fontSize: 12, height: 1.5)),
          const SizedBox(height: 10),
          Text('Illustrative code',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                  fontSize: 12)),
          const SizedBox(height: 4),
          _monoBox(badCode, cs),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cs.primaryContainer.withAlpha(80),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cs.primary.withAlpha(60)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, color: cs.primary, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(fix,
                      style: TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: cs.onSurface)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tab 10 — API cheat sheet
// ---------------------------------------------------------------------------

Widget _buildApiCheatSheet(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('API Cheat Sheet', cs),
        const SizedBox(height: 14),

        _apiSection('Constructor', cs, [
          _ApiEntry(
            'ObjectKey(Object? value)',
            'Creates a key that is equal to another ObjectKey only if both '
                'wrap values that are == to each other.',
          ),
        ]),
        const SizedBox(height: 12),

        _apiSection('Properties', cs, [
          _ApiEntry(
            'Object? value',
            'The object used to determine key equality. Exposed as final '
                'field. Can be null.',
          ),
        ]),
        const SizedBox(height: 12),

        _apiSection('Overridden operators / methods', cs, [
          _ApiEntry(
            'bool operator ==(Object other)',
            'Returns true iff other is an ObjectKey and other.value == '
                'this.value. Uses the value\'s own == implementation.',
          ),
          _ApiEntry(
            'int get hashCode',
            'Returns Object.hashAll([value]) so that equal keys have equal '
                'hash codes, consistent with the == contract.',
          ),
          _ApiEntry(
            'String toString()',
            'Returns a debug string in the form [ObjectKey value], e.g. '
                '[ObjectKey _Item(1, "Alpha")].',
          ),
        ]),
        const SizedBox(height: 12),

        _apiSection('Class hierarchy', cs, [
          _ApiEntry(
            'Object → Key → LocalKey → ObjectKey',
            'ObjectKey is a concrete final implementation of LocalKey. '
                'It cannot be subclassed.',
          ),
        ]),
        const SizedBox(height: 12),

        _apiSection('Related classes', cs, [
          _ApiEntry(
            'ValueKey<T>',
            'Uses the value directly for equality. Comparable to ObjectKey '
                'when the value overrides ==; equivalent to identity when it '
                'does not.',
          ),
          _ApiEntry(
            'UniqueKey',
            'No-arg constructor; always distinct. Useful for forcing rebuild '
                'of a widget subtree.',
          ),
          _ApiEntry(
            'GlobalKey<S>',
            'Typed key giving access to State, BuildContext, and Widget from '
                'anywhere in the tree. More expensive than LocalKey.',
          ),
          _ApiEntry(
            'GlobalObjectKey',
            'Like ObjectKey but global in scope. Allows cross-subtree lookup '
                'via currentContext / currentWidget / currentState.',
          ),
          _ApiEntry(
            'PageStorageKey<T>',
            'Subtype of ValueKey used to persist scroll positions and other '
                'ephemeral page state in the PageStorage bucket.',
          ),
        ]),
        const SizedBox(height: 14),

        _sectionHeader('Usage pattern reference', cs),
        const SizedBox(height: 10),

        _monoBox(
          '// Model class — no == override → identity semantics\n'
          'class Item { final int id; final String label; }\n\n'
          '// In ListView.builder\n'
          'itemBuilder: (ctx, i) => Tile(\n'
          '  key: ObjectKey(items[i]),\n'
          '  ...\n'
          '),\n\n'
          '// Test equality\n'
          'final a = Item(1, "x");\n'
          'ObjectKey(a) == ObjectKey(a)  // true\n'
          'ObjectKey(a) == ObjectKey(Item(1, "x"))  // false (diff instance)',
          cs,
        ),
        const SizedBox(height: 20),

        _sectionHeader('Equality contract summary', cs),
        const SizedBox(height: 10),

        Table(
          border: TableBorder.all(
              color: cs.outline.withAlpha(60),
              borderRadius: BorderRadius.circular(8)),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1.8),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: cs.primaryContainer),
              children: [
                _th('Scenario', cs),
                _th('Result', cs),
                _th('Reason', cs),
              ],
            ),
            _tr3('Same instance, no == override',
                'true', 'identity == identity', cs),
            _tr3('Different instances, no == override',
                'false', 'identity != identity', cs),
            _tr3('Different instances, == override, same data',
                'true', 'value.== returns true', cs),
            _tr3('Different instances, == override, diff data',
                'false', 'value.== returns false', cs),
            _tr3('ObjectKey(null) vs ObjectKey(null)',
                'true', 'null == null', cs),
            _tr3('ObjectKey(x) vs ObjectKey(null)',
                'false', 'x != null', cs),
          ],
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}

Widget _th(String text, ColorScheme cs) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(text,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: cs.onPrimaryContainer)),
  );
}

TableRow _tr3(String c1, String c2, String c3, ColorScheme cs) {
  return TableRow(children: [
    Padding(
        padding: const EdgeInsets.all(8),
        child: Text(c1, style: const TextStyle(fontSize: 11, height: 1.3))),
    Padding(
      padding: const EdgeInsets.all(8),
      child: _chip(
        c2,
        c2 == 'true' ? cs.primaryContainer : cs.errorContainer,
        c2 == 'true' ? cs.onPrimaryContainer : cs.onErrorContainer,
      ),
    ),
    Padding(
        padding: const EdgeInsets.all(8),
        child:
            Text(c3, style: const TextStyle(fontSize: 11, height: 1.3))),
  ]);
}

class _ApiEntry {
  const _ApiEntry(this.signature, this.description);
  final String signature;
  final String description;
}

Widget _apiSection(String title, ColorScheme cs, List<_ApiEntry> entries) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: cs.primary)),
      const SizedBox(height: 8),
      ...entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              elevation: 0,
              color: cs.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.signature,
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: cs.primary,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(e.description,
                        style: const TextStyle(
                            fontSize: 12, height: 1.4)),
                  ],
                ),
              ),
            ),
          )),
    ],
  );
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ObjectKey Deep Demo',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(icon: Icon(Icons.home_outlined), text: 'Intro'),
              Tab(icon: Icon(Icons.list_alt), text: 'Live List'),
              Tab(icon: Icon(Icons.compare_arrows), text: 'Identity'),
              Tab(icon: Icon(Icons.code), text: 'Equality'),
              Tab(icon: Icon(Icons.table_chart_outlined), text: 'Table'),
              Tab(icon: Icon(Icons.animation), text: 'AnimList'),
              Tab(icon: Icon(Icons.account_tree_outlined), text: 'Diagram'),
              Tab(icon: Icon(Icons.do_not_disturb_alt_outlined), text: 'Null'),
              Tab(icon: Icon(Icons.warning_amber_outlined), text: 'Pitfalls'),
              Tab(icon: Icon(Icons.menu_book_outlined), text: 'API'),
            ],
          ),
        ),
        body: Builder(
          builder: (context) {
            return TabBarView(
              children: [
                _buildHeroBanner(context),
                _buildLiveListDemo(context),
                _buildIdentityVsEquality(context),
                _buildKeyEqualityDemo(context),
                _buildComparisonTable(context),
                _buildAnimatedListTab(context),
                _buildMatchingDiagram(context),
                _buildNullValueTab(context),
                _buildPitfalls(context),
                _buildApiCheatSheet(context),
              ],
            );
          },
        ),
      ),
    ),
  );
}
