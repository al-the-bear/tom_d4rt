// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// Visual Deep Demo: ObserverList<T> & HashedObserverList<T>
// =====================================================================
//
// Subject: package:flutter/foundation.dart — `ObserverList<T>` and
// `HashedObserverList<T>`. These are list-like collections optimized for
// the *add / remove / iterate* pattern used by listener registries
// (most notably the internal listener storage of `ChangeNotifier`).
//
// This file is a single-page hand-authored visual reference. It is
// rendered once via `build(BuildContext)` and never updates; there is
// no state, no controller, no async work, and no `runApp`.
//
// Sections:
//   1.  Hero card — "ObserverList: when iteration is the hot path"
//   2.  Anatomy — side-by-side memory layout diagrams
//   3.  Big-O complexity table
//   4.  Worked example — instantiate, add 8, render contents
//   5.  Decision flow — when to use which
//   6.  Listener-registry use case — ChangeNotifier internals
//   7.  Mutation-during-iteration semantics
//   8.  Realistic listener pattern (code listing)
//   9.  Pitfalls
//   10. Footer
//
// =====================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// =====================================================================
// PALETTE
// =====================================================================

class _PrivatePalette {
  // Base canvas
  static const Color canvas = Color(0xFF0F1218);
  static const Color panel = Color(0xFF161B24);
  static const Color panelAlt = Color(0xFF1C2230);
  static const Color panelHi = Color(0xFF222A3A);
  static const Color border = Color(0xFF2C3548);
  static const Color borderHi = Color(0xFF3D4A66);

  // Text
  static const Color textPrimary = Color(0xFFE6ECF5);
  static const Color textSecondary = Color(0xFFA8B3C7);
  static const Color textMuted = Color(0xFF6B7894);
  static const Color textDim = Color(0xFF4A5468);

  // Accents
  static const Color accentTeal = Color(0xFF40D9C7);
  static const Color accentAmber = Color(0xFFE8B45A);
  static const Color accentMagenta = Color(0xFFD970C8);
  static const Color accentBlue = Color(0xFF5AA3F0);
  static const Color accentGreen = Color(0xFF6BCF7F);
  static const Color accentRed = Color(0xFFE56B6F);
  static const Color accentPurple = Color(0xFFB58FF0);

  // Code
  static const Color codeBg = Color(0xFF0A0D13);
  static const Color codeKw = Color(0xFFD970C8);
  static const Color codeStr = Color(0xFFE8B45A);
  static const Color codeNum = Color(0xFFB58FF0);
  static const Color codeFn = Color(0xFF5AA3F0);
  static const Color codeCmt = Color(0xFF6B7894);
  static const Color codeType = Color(0xFF40D9C7);
}

// =====================================================================
// TYPOGRAPHY
// =====================================================================

class _PrivateType {
  static const String mono = 'monospace';

  static const TextStyle heroTitle = TextStyle(
    fontSize: 34.0,
    fontWeight: FontWeight.w800,
    color: _PrivatePalette.textPrimary,
    letterSpacing: -0.6,
    height: 1.1,
  );

  static const TextStyle heroSubtitle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: _PrivatePalette.textSecondary,
    height: 1.4,
  );

  static const TextStyle sectionEyebrow = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w700,
    color: _PrivatePalette.accentTeal,
    letterSpacing: 2.2,
    fontFamily: mono,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    color: _PrivatePalette.textPrimary,
    letterSpacing: -0.3,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: _PrivatePalette.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 13.0,
    color: _PrivatePalette.textSecondary,
    height: 1.55,
  );

  static const TextStyle small = TextStyle(
    fontSize: 11.5,
    color: _PrivatePalette.textMuted,
    height: 1.5,
  );

  static const TextStyle code = TextStyle(
    fontSize: 12.5,
    fontFamily: mono,
    color: _PrivatePalette.textPrimary,
    height: 1.55,
  );

  static const TextStyle codeSmall = TextStyle(
    fontSize: 11.5,
    fontFamily: mono,
    color: _PrivatePalette.textPrimary,
    height: 1.5,
  );

  static const TextStyle tableHeader = TextStyle(
    fontSize: 11.5,
    fontWeight: FontWeight.w700,
    color: _PrivatePalette.textPrimary,
    letterSpacing: 0.6,
  );

  static const TextStyle tableCell = TextStyle(
    fontSize: 12.0,
    color: _PrivatePalette.textSecondary,
    fontFamily: mono,
  );

  static const TextStyle bigO = TextStyle(
    fontSize: 13.5,
    fontFamily: mono,
    fontWeight: FontWeight.w700,
    color: _PrivatePalette.accentAmber,
  );

  static const TextStyle pillText = TextStyle(
    fontSize: 10.5,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
    fontFamily: mono,
  );
}

// =====================================================================
// SHARED PRIMITIVES
// =====================================================================

class _PrivateCard extends StatelessWidget {
  const _PrivateCard({
    required this.child,
    this.padding = const EdgeInsets.all(20.0),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _PrivatePalette.panel,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: _PrivatePalette.border, width: 1.0),
      ),
      child: child,
    );
  }
}

class _PrivatePill extends StatelessWidget {
  const _PrivatePill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
      ),
      child: Text(label, style: _PrivateType.pillText.copyWith(color: color)),
    );
  }
}

class _PrivateSectionHeader extends StatelessWidget {
  const _PrivateSectionHeader({
    required this.eyebrow,
    required this.title,
  });

  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eyebrow, style: _PrivateType.sectionEyebrow),
                const SizedBox(height: 4.0),
                Text(title, style: _PrivateType.sectionTitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateGlyph extends StatelessWidget {
  const _PrivateGlyph({required this.glyph, required this.color, this.size = 18.0});

  final String glyph;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 8.0,
      height: size + 8.0,
      child: Center(
        child: Text(
          glyph,
          style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 1 — HERO
// =====================================================================

class _PrivateHero extends StatelessWidget {
  const _PrivateHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _PrivatePalette.panelHi,
            _PrivatePalette.panel,
          ],
        ),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: _PrivatePalette.borderHi, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _PrivatePill(
                label: 'FOUNDATION',
                color: _PrivatePalette.accentTeal,
              ),
              const SizedBox(width: 8.0),
              _PrivatePill(
                label: 'COLLECTIONS',
                color: _PrivatePalette.accentMagenta,
              ),
              const SizedBox(width: 8.0),
              _PrivatePill(
                label: 'LISTENER REGISTRY',
                color: _PrivatePalette.accentAmber,
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          Text(
            'ObserverList<T>',
            style: _PrivateType.heroTitle.copyWith(
              color: _PrivatePalette.accentTeal,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'when iteration is the hot path',
            style: _PrivateType.heroTitle.copyWith(
              fontWeight: FontWeight.w400,
              color: _PrivatePalette.textPrimary,
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: 720.0,
            child: Text(
              'Flutter\'s ObserverList is a list-like collection tuned for the '
              'add/remove/iterate cycle that drives every listener registry in the '
              'framework. It accepts duplicates, preserves insertion order, and is '
              'tolerant of removal during iteration. Its sibling, HashedObserverList, '
              'pays a small memory tax to make membership checks O(1) when the '
              'listener count is large.',
              style: _PrivateType.heroSubtitle,
            ),
          ),
          const SizedBox(height: 22.0),
          Row(
            children: [
              _PrivateHeroStat(
                label: 'add',
                value: 'O(1)',
                color: _PrivatePalette.accentGreen,
              ),
              const SizedBox(width: 12.0),
              _PrivateHeroStat(
                label: 'iter',
                value: 'O(N)',
                color: _PrivatePalette.accentBlue,
              ),
              const SizedBox(width: 12.0),
              _PrivateHeroStat(
                label: 'contains',
                value: 'O(N)',
                color: _PrivatePalette.accentAmber,
              ),
              const SizedBox(width: 12.0),
              _PrivateHeroStat(
                label: 'remove',
                value: 'O(N)',
                color: _PrivatePalette.accentRed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateHeroStat extends StatelessWidget {
  const _PrivateHeroStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: _PrivatePalette.canvas,
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              fontFamily: _PrivateType.mono,
              color: _PrivatePalette.textMuted,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              fontFamily: _PrivateType.mono,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 2 — ANATOMY (memory layout diagrams)
// =====================================================================

class _PrivateAnatomySection extends StatelessWidget {
  const _PrivateAnatomySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PrivateSectionHeader(
          eyebrow: '02 / ANATOMY',
          title: 'Memory layout, side by side',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _PrivateObserverListLayout()),
            const SizedBox(width: 16.0),
            Expanded(child: _PrivateHashedObserverListLayout()),
          ],
        ),
      ],
    );
  }
}

class _PrivateObserverListLayout extends StatelessWidget {
  const _PrivateObserverListLayout();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _PrivatePill(
                label: 'OBSERVERLIST',
                color: _PrivatePalette.accentTeal,
              ),
              const SizedBox(width: 8.0),
              _PrivatePill(
                label: 'LINEAR',
                color: _PrivatePalette.accentBlue,
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            'A growable List<T> under the hood, plus a "dirty" flag used to '
            'detect mutation during iteration. Insertion order is preserved. '
            'Duplicates are allowed. There is no side-table.',
            style: _PrivateType.body,
          ),
          const SizedBox(height: 16.0),
          _PrivateMemoryRow(
            label: '_list',
            cells: const ['cb0', 'cb1', 'cb2', 'cb3', 'cb4', '...'],
            cellColor: _PrivatePalette.accentTeal,
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: _PrivatePalette.codeBg,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: _PrivatePalette.border),
            ),
            child: Text(
              'class ObserverList<T> extends Iterable<T> {\n'
              '  final List<T> _list = <T>[];\n'
              '  bool _isDirty = false;\n'
              '}',
              style: _PrivateType.codeSmall,
            ),
          ),
          const SizedBox(height: 12.0),
          _PrivateBulletItem(
            color: _PrivatePalette.accentGreen,
            text: 'add: _list.add(item) — pure O(1) amortized.',
          ),
          _PrivateBulletItem(
            color: _PrivatePalette.accentAmber,
            text: 'contains/remove: linear scan over _list.',
          ),
          _PrivateBulletItem(
            color: _PrivatePalette.accentBlue,
            text: 'iterator: walks _list in insertion order.',
          ),
        ],
      ),
    );
  }
}

class _PrivateHashedObserverListLayout extends StatelessWidget {
  const _PrivateHashedObserverListLayout();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _PrivatePill(
                label: 'HASHEDOBSERVERLIST',
                color: _PrivatePalette.accentMagenta,
              ),
              const SizedBox(width: 8.0),
              _PrivatePill(
                label: 'LINEAR + SET',
                color: _PrivatePalette.accentPurple,
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            'A LinkedHashMap<T, int> behind a List-like facade. Iteration order '
            'is still insertion order; membership and remove become O(1) at the '
            'cost of an extra hash entry per item.',
            style: _PrivateType.body,
          ),
          const SizedBox(height: 16.0),
          _PrivateMemoryRow(
            label: '_map.keys',
            cells: const ['cb0', 'cb1', 'cb2', 'cb3', 'cb4', '...'],
            cellColor: _PrivatePalette.accentMagenta,
          ),
          const SizedBox(height: 8.0),
          _PrivateMemoryRow(
            label: '_map.vals',
            cells: const ['1', '1', '1', '1', '1', '...'],
            cellColor: _PrivatePalette.accentPurple,
            dim: true,
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: _PrivatePalette.codeBg,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: _PrivatePalette.border),
            ),
            child: Text(
              'class HashedObserverList<T> extends Iterable<T> {\n'
              '  final LinkedHashMap<T,int> _map\n'
              '      = LinkedHashMap<T,int>();\n'
              '}',
              style: _PrivateType.codeSmall,
            ),
          ),
          const SizedBox(height: 12.0),
          _PrivateBulletItem(
            color: _PrivatePalette.accentGreen,
            text: 'add: _map[item] = (_map[item] ?? 0) + 1 — O(1).',
          ),
          _PrivateBulletItem(
            color: _PrivatePalette.accentGreen,
            text: 'contains/remove: hashed — O(1).',
          ),
          _PrivateBulletItem(
            color: _PrivatePalette.accentBlue,
            text: 'iterator: walks _map.keys (insertion order).',
          ),
        ],
      ),
    );
  }
}

class _PrivateMemoryRow extends StatelessWidget {
  const _PrivateMemoryRow({
    required this.label,
    required this.cells,
    required this.cellColor,
    this.dim = false,
  });

  final String label;
  final List<String> cells;
  final Color cellColor;
  final bool dim;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 78.0,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: _PrivateType.mono,
              fontSize: 11.0,
              color: _PrivatePalette.textMuted,
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        Expanded(
          child: Row(
            children: cells.map((c) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  height: 32.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: cellColor.withValues(alpha: dim ? 0.08 : 0.18),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: cellColor.withValues(alpha: dim ? 0.3 : 0.7),
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    c,
                    style: TextStyle(
                      fontFamily: _PrivateType.mono,
                      fontSize: 11.0,
                      color: dim
                          ? _PrivatePalette.textMuted
                          : _PrivatePalette.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _PrivateBulletItem extends StatelessWidget {
  const _PrivateBulletItem({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6.0, right: 10.0),
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Expanded(child: Text(text, style: _PrivateType.body)),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 3 — BIG-O TABLE
// =====================================================================

class _PrivateComplexitySection extends StatelessWidget {
  const _PrivateComplexitySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PrivateSectionHeader(
          eyebrow: '03 / COMPLEXITY',
          title: 'Big-O at a glance',
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              _PrivateComplexityHeader(),
              _PrivateComplexityRow(
                op: 'add(item)',
                obs: 'O(1)',
                hashed: 'O(1)',
                list: 'O(1)',
                set: 'O(1)',
                obsOk: true,
                hashedOk: true,
                listOk: true,
                setOk: true,
                note: 'Amortized append.',
              ),
              _PrivateComplexityRow(
                op: 'remove(item)',
                obs: 'O(N)',
                hashed: 'O(1)',
                list: 'O(N)',
                set: 'O(1)',
                obsOk: false,
                hashedOk: true,
                listOk: false,
                setOk: true,
                note: 'ObserverList scans linearly.',
              ),
              _PrivateComplexityRow(
                op: 'contains(item)',
                obs: 'O(N)',
                hashed: 'O(1)',
                list: 'O(N)',
                set: 'O(1)',
                obsOk: false,
                hashedOk: true,
                listOk: false,
                setOk: true,
                note: 'Set/Hashed use hashing.',
              ),
              _PrivateComplexityRow(
                op: 'iterator',
                obs: 'O(N)',
                hashed: 'O(N)',
                list: 'O(N)',
                set: 'O(N)',
                obsOk: true,
                hashedOk: true,
                listOk: true,
                setOk: true,
                note: 'All linear; ObserverList is fastest in practice.',
                last: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateComplexityHeader extends StatelessWidget {
  const _PrivateComplexityHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _PrivatePalette.panelAlt,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(13.0),
          topRight: Radius.circular(13.0),
        ),
        border: Border(
          bottom: BorderSide(color: _PrivatePalette.border),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('OPERATION', style: _PrivateType.tableHeader)),
          Expanded(flex: 2, child: Text('ObserverList', style: _PrivateType.tableHeader)),
          Expanded(flex: 2, child: Text('Hashed', style: _PrivateType.tableHeader)),
          Expanded(flex: 2, child: Text('List<T>', style: _PrivateType.tableHeader)),
          Expanded(flex: 2, child: Text('Set<T>', style: _PrivateType.tableHeader)),
          Expanded(flex: 5, child: Text('NOTE', style: _PrivateType.tableHeader)),
        ],
      ),
    );
  }
}

class _PrivateComplexityRow extends StatelessWidget {
  const _PrivateComplexityRow({
    required this.op,
    required this.obs,
    required this.hashed,
    required this.list,
    required this.set,
    required this.obsOk,
    required this.hashedOk,
    required this.listOk,
    required this.setOk,
    required this.note,
    this.last = false,
  });

  final String op;
  final String obs;
  final String hashed;
  final String list;
  final String set;
  final bool obsOk;
  final bool hashedOk;
  final bool listOk;
  final bool setOk;
  final String note;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(bottom: BorderSide(color: _PrivatePalette.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              op,
              style: TextStyle(
                fontFamily: _PrivateType.mono,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
                color: _PrivatePalette.accentBlue,
              ),
            ),
          ),
          Expanded(flex: 2, child: _PrivateBigOCell(value: obs, ok: obsOk)),
          Expanded(flex: 2, child: _PrivateBigOCell(value: hashed, ok: hashedOk)),
          Expanded(flex: 2, child: _PrivateBigOCell(value: list, ok: listOk)),
          Expanded(flex: 2, child: _PrivateBigOCell(value: set, ok: setOk)),
          Expanded(flex: 5, child: Text(note, style: _PrivateType.small)),
        ],
      ),
    );
  }
}

class _PrivateBigOCell extends StatelessWidget {
  const _PrivateBigOCell({required this.value, required this.ok});

  final String value;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    final Color tone = ok
        ? _PrivatePalette.accentGreen
        : _PrivatePalette.accentAmber;
    return Row(
      children: [
        Text(
          ok ? 'OK' : '!',
          style: TextStyle(
            color: tone,
            fontWeight: FontWeight.w800,
            fontSize: 12.0,
            fontFamily: _PrivateType.mono,
          ),
        ),
        const SizedBox(width: 6.0),
        Text(value, style: _PrivateType.bigO.copyWith(color: tone)),
      ],
    );
  }
}

// =====================================================================
// SECTION 4 — WORKED EXAMPLE
// =====================================================================

class _PrivateWorkedExample extends StatelessWidget {
  const _PrivateWorkedExample();

  @override
  Widget build(BuildContext context) {
    // Build the actual ObserverList / HashedObserverList here for
    // illustration. We render their `.toList()` text — we never try
    // to bind them to a ListenableBuilder.
    final ObserverList<String> obs = ObserverList<String>();
    final HashedObserverList<String> hashed = HashedObserverList<String>();

    const List<String> seed = <String>[
      'rebuildOnTick',
      'logFrame',
      'persistScrollOffset',
      'updateMiniMap',
      'reportTelemetry',
      'animateBadge',
      'syncToServer',
      'audit',
    ];

    for (final String s in seed) {
      obs.add(s);
      hashed.add(s);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PrivateSectionHeader(
          eyebrow: '04 / WORKED EXAMPLE',
          title: 'Insertion order is preserved by both',
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We instantiate one of each, push the same eight callback names '
                'in, then dump them through .toList(). Notice that the order is '
                'identical — and that the duplicate insertion would diverge '
                '(ObserverList keeps it; HashedObserverList collapses it).',
                style: _PrivateType.body,
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _PrivateConsole(
                      title: 'observer_list.toList()',
                      titleColor: _PrivatePalette.accentTeal,
                      lines: <String>[
                        '> ObserverList<String>()',
                        ...obs.toList().asMap().entries.map(
                          (e) => '  [${e.key}] ${e.value}',
                        ),
                        '> length: ${obs.length}',
                        '> isEmpty: ${obs.isEmpty}',
                        '> isNotEmpty: ${obs.isNotEmpty}',
                      ],
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  Expanded(
                    child: _PrivateConsole(
                      title: 'hashed_observer_list.toList()',
                      titleColor: _PrivatePalette.accentMagenta,
                      lines: <String>[
                        '> HashedObserverList<String>()',
                        ...hashed.toList().asMap().entries.map(
                          (e) => '  [${e.key}] ${e.value}',
                        ),
                        '> length: ${hashed.length}',
                        '> isEmpty: ${hashed.isEmpty}',
                        '> isNotEmpty: ${hashed.isNotEmpty}',
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: _PrivatePalette.accentBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: _PrivatePalette.accentBlue.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PrivateGlyph(
                      glyph: 'i',
                      color: _PrivatePalette.accentBlue,
                      size: 14.0,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'Both implement Iterable<T>, so anywhere you can use a '
                        'for-in loop on a List, you can use one of these.',
                        style: _PrivateType.small.copyWith(
                          color: _PrivatePalette.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateConsole extends StatelessWidget {
  const _PrivateConsole({
    required this.title,
    required this.titleColor,
    required this.lines,
  });

  final String title;
  final Color titleColor;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _PrivatePalette.codeBg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: _PrivatePalette.panelAlt,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
              border: Border(
                bottom: BorderSide(color: _PrivatePalette.border),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: titleColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: _PrivateType.mono,
                    color: titleColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: lines
                  .map(
                    (l) => Text(
                      l,
                      style: TextStyle(
                        fontFamily: _PrivateType.mono,
                        fontSize: 11.5,
                        color: l.startsWith('>')
                            ? _PrivatePalette.accentTeal
                            : _PrivatePalette.textPrimary,
                        height: 1.55,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 5 — DECISION FLOW
// =====================================================================

class _PrivateDecisionSection extends StatelessWidget {
  const _PrivateDecisionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PrivateSectionHeader(
          eyebrow: '05 / DECISION',
          title: 'Which one should you reach for?',
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PrivateDecisionStep(
                index: 1,
                question: 'Is the collection a listener registry (i.e. you '
                    'iterate it on every event)?',
                yes: 'Continue.',
                no: 'Use a plain List<T> or Set<T>; ObserverList is overkill.',
              ),
              const SizedBox(height: 14.0),
              _PrivateDecisionStep(
                index: 2,
                question: 'Will the registry routinely hold > ~10 entries, '
                    'and do you call .contains() or .remove() inside hot paths?',
                yes: 'Use HashedObserverList<T> — O(1) membership wins.',
                no: 'Use ObserverList<T> — smaller footprint, fastest iteration.',
              ),
              const SizedBox(height: 14.0),
              _PrivateDecisionStep(
                index: 3,
                question: 'Do you need to *remove the same listener* during '
                    'iteration (e.g. one-shot listeners)?',
                yes: 'Either works; ObserverList is widely battle-tested for this.',
                no: 'Pick by the rule above.',
              ),
              const SizedBox(height: 18.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  color: _PrivatePalette.accentAmber.withValues(alpha: 0.08),
                  border: Border.all(
                    color: _PrivatePalette.accentAmber.withValues(alpha: 0.45),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PrivateGlyph(
                      glyph: '!',
                      color: _PrivatePalette.accentAmber,
                      size: 14.0,
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Rule of thumb: ChangeNotifier itself uses ObserverList '
                        'until the listener count grows large; that is a strong '
                        'hint about the framework default.',
                        style: _PrivateType.small.copyWith(
                          color: _PrivatePalette.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateDecisionStep extends StatelessWidget {
  const _PrivateDecisionStep({
    required this.index,
    required this.question,
    required this.yes,
    required this.no,
  });

  final int index;
  final String question;
  final String yes;
  final String no;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: _PrivatePalette.panelAlt,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.0,
            height: 28.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _PrivatePalette.accentTeal.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: _PrivatePalette.accentTeal.withValues(alpha: 0.6),
              ),
            ),
            child: Text(
              '$index',
              style: TextStyle(
                fontFamily: _PrivateType.mono,
                color: _PrivatePalette.accentTeal,
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: _PrivateType.cardTitle.copyWith(fontSize: 13.5),
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PrivatePill(
                      label: 'YES',
                      color: _PrivatePalette.accentGreen,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(child: Text(yes, style: _PrivateType.small)),
                  ],
                ),
                const SizedBox(height: 6.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PrivatePill(
                      label: 'NO',
                      color: _PrivatePalette.accentRed,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(child: Text(no, style: _PrivateType.small)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 6 — LISTENER REGISTRY (ChangeNotifier internals)
// =====================================================================

class _PrivateListenerRegistry extends StatelessWidget {
  const _PrivateListenerRegistry();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PrivateSectionHeader(
          eyebrow: '06 / USE CASE',
          title: 'ChangeNotifier — the canonical client',
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ChangeNotifier — the bedrock of Provider, ValueNotifier, '
                'TextEditingController, ScrollController, and roughly half of '
                'Flutter\'s reactive surface area — stores its callbacks in an '
                'ObserverList<VoidCallback>. The diagram below sketches the '
                'pieces.',
                style: _PrivateType.body,
              ),
              const SizedBox(height: 18.0),
              _PrivateChangeNotifierDiagram(),
              const SizedBox(height: 18.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: _PrivatePalette.codeBg,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _PrivatePalette.border),
                ),
                child: Text(
                  '// Roughly:\n'
                  'class ChangeNotifier implements Listenable {\n'
                  '  ObserverList<VoidCallback>? _listeners =\n'
                  '      ObserverList<VoidCallback>();\n'
                  '\n'
                  '  void addListener(VoidCallback listener) {\n'
                  '    _listeners!.add(listener);\n'
                  '  }\n'
                  '\n'
                  '  void removeListener(VoidCallback listener) {\n'
                  '    _listeners?.remove(listener);\n'
                  '  }\n'
                  '\n'
                  '  void notifyListeners() {\n'
                  '    final ls = _listeners?.toList(growable: false);\n'
                  '    if (ls == null) return;\n'
                  '    for (final l in ls) {\n'
                  '      if (_listeners!.contains(l)) l();\n'
                  '    }\n'
                  '  }\n'
                  '}',
                  style: _PrivateType.codeSmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateChangeNotifierDiagram extends StatelessWidget {
  const _PrivateChangeNotifierDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: _PrivatePalette.panelAlt,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _PrivateDiagramNode(
              title: 'ChangeNotifier',
              subtitle: 'mixin / class',
              color: _PrivatePalette.accentBlue,
            ),
          ),
          _PrivateDiagramArrow(label: 'owns'),
          Expanded(
            flex: 2,
            child: _PrivateDiagramNode(
              title: 'ObserverList<VoidCallback>',
              subtitle: '_listeners',
              color: _PrivatePalette.accentTeal,
              accent: true,
            ),
          ),
          _PrivateDiagramArrow(label: 'iter'),
          Expanded(
            child: _PrivateDiagramNode(
              title: 'VoidCallback',
              subtitle: 'rebuild / notify',
              color: _PrivatePalette.accentMagenta,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateDiagramNode extends StatelessWidget {
  const _PrivateDiagramNode({
    required this.title,
    required this.subtitle,
    required this.color,
    this.accent = false,
  });

  final String title;
  final String subtitle;
  final Color color;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: accent
            ? color.withValues(alpha: 0.15)
            : _PrivatePalette.panel,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: color.withValues(alpha: accent ? 0.7 : 0.5),
          width: accent ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: _PrivateType.mono,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: _PrivateType.small.copyWith(fontFamily: _PrivateType.mono),
          ),
        ],
      ),
    );
  }
}

class _PrivateDiagramArrow extends StatelessWidget {
  const _PrivateDiagramArrow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: _PrivateType.mono,
              fontSize: 10.0,
              color: _PrivatePalette.textMuted,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            width: 32.0,
            height: 1.6,
            color: _PrivatePalette.borderHi,
          ),
          Container(
            margin: const EdgeInsets.only(top: 0.0),
            child: Text(
              '>',
              style: TextStyle(
                fontFamily: _PrivateType.mono,
                fontSize: 14.0,
                color: _PrivatePalette.borderHi,
                fontWeight: FontWeight.w900,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 7 — MUTATION DURING ITERATION
// =====================================================================

class _PrivateMutationSection extends StatelessWidget {
  const _PrivateMutationSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PrivateSectionHeader(
          eyebrow: '07 / SEMANTICS',
          title: 'Mutation during iteration',
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A normal List<T> throws ConcurrentModificationError if you '
                'remove an item while iterating it. ObserverList is gentler:',
                style: _PrivateType.body,
              ),
              const SizedBox(height: 14.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _PrivateMutationCard(
                      title: 'List<T>',
                      tone: _PrivatePalette.accentRed,
                      verdict: 'THROWS',
                      lines: const <String>[
                        'final l = <int>[1, 2, 3];',
                        'for (final x in l) {',
                        '  if (x == 2) l.remove(x); // boom',
                        '}',
                        '// ConcurrentModificationError',
                      ],
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  Expanded(
                    child: _PrivateMutationCard(
                      title: 'ObserverList<T>',
                      tone: _PrivatePalette.accentGreen,
                      verdict: 'TOLERATES',
                      lines: const <String>[
                        'final ol = ObserverList<int>()',
                        '  ..add(1)..add(2)..add(3);',
                        '// safe pattern: snapshot then check',
                        'for (final x in ol.toList(',
                        '    growable: false)) {',
                        '  if (ol.contains(x)) call(x);',
                        '}',
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  color: _PrivatePalette.accentBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: _PrivatePalette.accentBlue.withValues(alpha: 0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How ChangeNotifier does it',
                      style: _PrivateType.cardTitle.copyWith(
                        color: _PrivatePalette.accentBlue,
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'It iterates a snapshot (toList(growable: false)) and '
                      'guards each invocation with contains(listener). That '
                      'way a listener that removes itself mid-notify is '
                      'simply skipped from the in-flight pass — no crash, '
                      'no ghost calls.',
                      style: _PrivateType.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateMutationCard extends StatelessWidget {
  const _PrivateMutationCard({
    required this.title,
    required this.tone,
    required this.verdict,
    required this.lines,
  });

  final String title;
  final Color tone;
  final String verdict;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _PrivatePalette.codeBg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: tone.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
              border: Border(
                bottom: BorderSide(color: tone.withValues(alpha: 0.5)),
              ),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: _PrivateType.mono,
                    color: tone,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.0,
                  ),
                ),
                const Spacer(),
                _PrivatePill(label: verdict, color: tone),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: lines
                  .map((l) => Text(l, style: _PrivateType.codeSmall))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 8 — REALISTIC LISTENER PATTERN
// =====================================================================

class _PrivateRealisticPattern extends StatelessWidget {
  const _PrivateRealisticPattern();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PrivateSectionHeader(
          eyebrow: '08 / PATTERN',
          title: 'A realistic custom listener registry',
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When you build your own typed event bus, ObserverList<T> is '
                'almost always the right shape. The snippet below shows a '
                'minimal, safe FrameTickRegistry. Note the snapshot-and-guard '
                'pattern in dispatch() — exactly what ChangeNotifier does.',
                style: _PrivateType.body,
              ),
              const SizedBox(height: 16.0),
              _PrivateCodeListing(
                fileName: 'frame_tick_registry.dart',
                lines: const <_PrivateCodeLine>[
                  _PrivateCodeLine(
                    n: 1,
                    text: "import 'package:flutter/foundation.dart';",
                    color: _PrivatePalette.codeKw,
                  ),
                  _PrivateCodeLine(n: 2, text: ''),
                  _PrivateCodeLine(
                    n: 3,
                    text: 'typedef FrameTickListener = void Function(Duration t);',
                  ),
                  _PrivateCodeLine(n: 4, text: ''),
                  _PrivateCodeLine(
                    n: 5,
                    text: 'class FrameTickRegistry {',
                    color: _PrivatePalette.codeKw,
                  ),
                  _PrivateCodeLine(
                    n: 6,
                    text: '  final ObserverList<FrameTickListener> _ls =',
                  ),
                  _PrivateCodeLine(
                    n: 7,
                    text: '      ObserverList<FrameTickListener>();',
                  ),
                  _PrivateCodeLine(n: 8, text: ''),
                  _PrivateCodeLine(
                    n: 9,
                    text: '  void add(FrameTickListener l) => _ls.add(l);',
                  ),
                  _PrivateCodeLine(
                    n: 10,
                    text: '  void remove(FrameTickListener l) => _ls.remove(l);',
                  ),
                  _PrivateCodeLine(n: 11, text: ''),
                  _PrivateCodeLine(
                    n: 12,
                    text: '  void dispatch(Duration t) {',
                  ),
                  _PrivateCodeLine(
                    n: 13,
                    text: '    final snap = _ls.toList(growable: false);',
                  ),
                  _PrivateCodeLine(
                    n: 14,
                    text: '    for (final l in snap) {',
                  ),
                  _PrivateCodeLine(
                    n: 15,
                    text: '      if (_ls.contains(l)) l(t);',
                  ),
                  _PrivateCodeLine(n: 16, text: '    }'),
                  _PrivateCodeLine(n: 17, text: '  }'),
                  _PrivateCodeLine(n: 18, text: '}'),
                ],
              ),
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  _PrivateAnnotatedTag(
                    label: 'snapshot before iterate',
                    color: _PrivatePalette.accentBlue,
                  ),
                  _PrivateAnnotatedTag(
                    label: 'contains() guards reentrancy',
                    color: _PrivatePalette.accentGreen,
                  ),
                  _PrivateAnnotatedTag(
                    label: 'no Set side-table needed at low N',
                    color: _PrivatePalette.accentTeal,
                  ),
                  _PrivateAnnotatedTag(
                    label: 'private field — never expose raw',
                    color: _PrivatePalette.accentAmber,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateAnnotatedTag extends StatelessWidget {
  const _PrivateAnnotatedTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: _PrivateType.mono,
          fontSize: 11.0,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PrivateCodeLine {
  const _PrivateCodeLine({required this.n, required this.text, this.color});

  final int n;
  final String text;
  final Color? color;
}

class _PrivateCodeListing extends StatelessWidget {
  const _PrivateCodeListing({required this.fileName, required this.lines});

  final String fileName;
  final List<_PrivateCodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _PrivatePalette.codeBg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: _PrivatePalette.panelAlt,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
              border: Border(
                bottom: BorderSide(color: _PrivatePalette.border),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    color: _PrivatePalette.accentRed,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    color: _PrivatePalette.accentAmber,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    color: _PrivatePalette.accentGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 14.0),
                Text(
                  fileName,
                  style: TextStyle(
                    fontFamily: _PrivateType.mono,
                    color: _PrivatePalette.textPrimary,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: lines.map((l) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 28.0,
                      child: Text(
                        '${l.n}',
                        style: TextStyle(
                          fontFamily: _PrivateType.mono,
                          fontSize: 11.0,
                          color: _PrivatePalette.textDim,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        l.text,
                        style: _PrivateType.codeSmall.copyWith(
                          color: l.color ?? _PrivatePalette.textPrimary,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 9 — PITFALLS
// =====================================================================

class _PrivatePitfallsSection extends StatelessWidget {
  const _PrivatePitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PrivateSectionHeader(
          eyebrow: '09 / PITFALLS',
          title: 'Things that look right but bite later',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _PrivatePitfallCard(
                tone: _PrivatePalette.accentRed,
                title: 'Do not expose raw',
                body:
                    'Never make an ObserverList part of your public API. Wrap '
                    'it in addX/removeX methods so consumers can\'t mutate or '
                    'iterate it directly. The container is an implementation '
                    'detail — exposing it leaks ordering and reentrancy '
                    'guarantees you may want to change later.',
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _PrivatePitfallCard(
                tone: _PrivatePalette.accentAmber,
                title: 'Profile before switching',
                body:
                    'HashedObserverList is not a strict upgrade. Below ~10 '
                    'listeners the linear scan in ObserverList is faster than '
                    'a hash lookup, and you save one Map allocation per '
                    'instance. Measure with Timeline before flipping.',
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _PrivatePitfallCard(
                tone: _PrivatePalette.accentMagenta,
                title: 'Iterate a snapshot',
                body:
                    'Direct for-in is fine when nothing mutates. Inside a '
                    'dispatch, always iterate `.toList(growable: false)` and '
                    'guard with `.contains(listener)`; a listener that '
                    'removes itself otherwise lingers in the loop.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _PrivatePitfallCard(
                tone: _PrivatePalette.accentBlue,
                title: 'Equality matters',
                body:
                    'For HashedObserverList, T must have a stable, value-'
                    'consistent hashCode/== — otherwise contains() and '
                    'remove() mis-fire. Function tear-offs are stable; '
                    'closures captured each call are not.',
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _PrivatePitfallCard(
                tone: _PrivatePalette.accentGreen,
                title: 'Disposal is on you',
                body:
                    'These collections do not call dispose() on their '
                    'elements. If you store closures that capture '
                    'controllers, clear the registry in your owner\'s '
                    'dispose() to break the retain chain.',
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _PrivatePitfallCard(
                tone: _PrivatePalette.accentTeal,
                title: 'Order is insertion',
                body:
                    'Both types iterate in insertion order. If your '
                    'subscribers must run in priority order, sort a snapshot '
                    'before dispatch — the underlying container does not '
                    'know about priority.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PrivatePitfallCard extends StatelessWidget {
  const _PrivatePitfallCard({
    required this.tone,
    required this.title,
    required this.body,
  });

  final Color tone;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _PrivatePalette.panel,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tone.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 26.0,
                height: 26.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: tone.withValues(alpha: 0.6)),
                ),
                child: Text(
                  '!',
                  style: TextStyle(
                    fontFamily: _PrivateType.mono,
                    color: tone,
                    fontWeight: FontWeight.w900,
                    fontSize: 13.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: _PrivateType.cardTitle.copyWith(color: tone),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(body, style: _PrivateType.body),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 10 — FOOTER
// =====================================================================

class _PrivateFooter extends StatelessWidget {
  const _PrivateFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: _PrivatePalette.panel,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PALETTE', style: _PrivateType.sectionEyebrow),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: const <Widget>[
                    _PrivateSwatch(
                      label: 'teal',
                      color: _PrivatePalette.accentTeal,
                    ),
                    _PrivateSwatch(
                      label: 'magenta',
                      color: _PrivatePalette.accentMagenta,
                    ),
                    _PrivateSwatch(
                      label: 'amber',
                      color: _PrivatePalette.accentAmber,
                    ),
                    _PrivateSwatch(
                      label: 'blue',
                      color: _PrivatePalette.accentBlue,
                    ),
                    _PrivateSwatch(
                      label: 'green',
                      color: _PrivatePalette.accentGreen,
                    ),
                    _PrivateSwatch(
                      label: 'red',
                      color: _PrivatePalette.accentRed,
                    ),
                    _PrivateSwatch(
                      label: 'purple',
                      color: _PrivatePalette.accentPurple,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('VERSION', style: _PrivateType.sectionEyebrow),
                const SizedBox(height: 10.0),
                Text(
                  'observer_list_test.dart',
                  style: _PrivateType.code.copyWith(
                    color: _PrivatePalette.accentTeal,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'visual deep demo / r2 / 2026',
                  style: _PrivateType.small,
                ),
                const SizedBox(height: 12.0),
                Text(
                  'Subject: ObserverList<T>, HashedObserverList<T> '
                  '(package:flutter/foundation.dart). All examples are '
                  'authored by hand and rendered statically — no controllers, '
                  'no async work, no setState. The collections are real '
                  'instances; their .toList() output is what you see in the '
                  'console panels above.',
                  style: _PrivateType.small,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateSwatch extends StatelessWidget {
  const _PrivateSwatch({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(
              fontFamily: _PrivateType.mono,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PAGE
// =====================================================================

class _PrivatePage extends StatelessWidget {
  const _PrivatePage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _PrivatePalette.canvas,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _PrivateHero(),
              SizedBox(height: 28.0),
              _PrivateAnatomySection(),
              SizedBox(height: 28.0),
              _PrivateComplexitySection(),
              SizedBox(height: 28.0),
              _PrivateWorkedExample(),
              SizedBox(height: 28.0),
              _PrivateDecisionSection(),
              SizedBox(height: 28.0),
              _PrivateListenerRegistry(),
              SizedBox(height: 28.0),
              _PrivateMutationSection(),
              SizedBox(height: 28.0),
              _PrivateRealisticPattern(),
              SizedBox(height: 28.0),
              _PrivatePitfallsSection(),
              SizedBox(height: 28.0),
              _PrivateFooter(),
              SizedBox(height: 28.0),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// ENTRY POINT
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ObserverList Visual Deep Demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _PrivatePalette.canvas,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _PrivatePalette.textPrimary),
      ),
    ),
    home: Scaffold(
      backgroundColor: _PrivatePalette.canvas,
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #18, P1):
      // _PrivatePage already wraps its content in a SingleChildScrollView.
      // Nesting it inside another vertical SingleChildScrollView left the
      // inner one with unbounded height, collapsing the page to a zero-area
      // surface and tripping the SemanticsNode(Rect 0,0,0,0) assertion.
      body: _PrivatePage(),
    ),
  );
}
