// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// ---------------------------------------------------------------------------
// BitField<T extends dynamic> deep visual demo
// ---------------------------------------------------------------------------
//
// `BitField` is a small helper that lives in `package:flutter/foundation.dart`.
// It stores a compact bitmask indexed by enum values, intended for very small
// fixed-size flag sets where memory and access cost matter (semantics flags,
// feature toggles, small permission bags). It is not a general-purpose
// bitmask: it tops out at 62 bits, cannot be resized, and only accepts enum
// values for indexing.
//
// This file is hand-written, oversized on purpose, and intended to be parsed
// and visualized by the Tom D4rt flutter_ast pipeline. There is intentionally
// no `main`, no `runApp`, no `testWidgets`, no `Timer`, no `Future`, no
// `Stream`, no `AnimationController`, and no root-level `setState`. All
// interactivity happens inside a `StatefulBuilder` body further down.
//
// Visual goals:
//   - many gradient-and-shadow section cards
//   - an anatomy diagram for a single bitmap row
//   - a decision matrix comparing BitField / Set<Enum> / Map<Enum,bool>
//   - a real interactive demo over a custom `_Permission` enum, where each
//     bit can be toggled by tapping a chip
//   - a wrap palette of preset combinations
//   - a closing reference card with constructors and constraints
// ---------------------------------------------------------------------------

// ----------------------------- palette -------------------------------------

const Color _kInk = Color(0xFF101622);
const Color _kInkSoft = Color(0xFF394155);
const Color _kInkMuted = Color(0xFF6B7390);
const Color _kSurface = Color(0xFFF7F9FF);
const Color _kSurfaceAlt = Color(0xFFEEF2FB);
const Color _kBorder = Color(0xFFD7DEF0);

const Color _kBitOn = Color(0xFF2E7D32);
const Color _kBitOnDeep = Color(0xFF1B5E20);
const Color _kBitOff = Color(0xFFC62828);
const Color _kBitOffDeep = Color(0xFF8E0000);

const Color _kIndigo = Color(0xFF3F51B5);
const Color _kIndigoDeep = Color(0xFF1A237E);
const Color _kTeal = Color(0xFF00897B);
const Color _kTealDeep = Color(0xFF004D40);
const Color _kAmber = Color(0xFFFFA000);
const Color _kAmberDeep = Color(0xFFE65100);
const Color _kViolet = Color(0xFF6A1B9A);
const Color _kVioletDeep = Color(0xFF38006B);
const Color _kRose = Color(0xFFAD1457);
const Color _kRoseDeep = Color(0xFF560027);
const Color _kSlate = Color(0xFF455A64);
const Color _kSlateDeep = Color(0xFF1C313A);

// ----------------------------- enums ---------------------------------------

// Custom permission enum used to drive a `BitField<_Permission>`. Each value
// represents one bit. The order in the enum declaration determines the bit
// index (`_Permission.read.index == 0`, etc).
enum _Permission {
  read,
  write,
  delete,
  share,
  edit,
  admin,
  audit,
  invite,
}

const Map<_Permission, String> _kPermissionLabel = <_Permission, String>{
  _Permission.read: 'read',
  _Permission.write: 'write',
  _Permission.delete: 'delete',
  _Permission.share: 'share',
  _Permission.edit: 'edit',
  _Permission.admin: 'admin',
  _Permission.audit: 'audit',
  _Permission.invite: 'invite',
};

const Map<_Permission, IconData> _kPermissionIcon = <_Permission, IconData>{
  _Permission.read: Icons.visibility_outlined,
  _Permission.write: Icons.edit_note,
  _Permission.delete: Icons.delete_outline,
  _Permission.share: Icons.share_outlined,
  _Permission.edit: Icons.edit_outlined,
  _Permission.admin: Icons.admin_panel_settings_outlined,
  _Permission.audit: Icons.fact_check_outlined,
  _Permission.invite: Icons.person_add_alt_outlined,
};

// Tiny enum used to show that the type parameter is generic across any enum,
// and that a `BitField` over a 3-value enum is just as legitimate as one over
// the larger `_Permission` set.
enum _Channel { audio, video, haptics }

// ----------------------------- entry point ---------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'BitField Visual Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kIndigo),
      useMaterial3: true,
      scaffoldBackgroundColor: _kSurface,
    ),
    home: Scaffold(
      backgroundColor: _kSurface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeroBanner(),
              const SizedBox(height: 24),
              _buildIntroCard(),
              const SizedBox(height: 22),
              _buildConstructorsCard(),
              const SizedBox(height: 22),
              _buildAnatomyCard(),
              const SizedBox(height: 22),
              _buildIndexingCard(),
              const SizedBox(height: 22),
              _buildInteractiveDemo(),
              const SizedBox(height: 22),
              _buildPresetsCard(),
              const SizedBox(height: 22),
              _buildLimitsCard(),
              const SizedBox(height: 22),
              _buildDecisionMatrixCard(),
              const SizedBox(height: 22),
              _buildCodeSnippetCard(),
              const SizedBox(height: 22),
              _buildPatternsCard(),
              const SizedBox(height: 22),
              _buildSemanticsCard(),
              const SizedBox(height: 22),
              _buildReferenceCard(),
              const SizedBox(height: 28),
              _buildFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

// ----------------------------- hero ----------------------------------------

Widget _buildHeroBanner() {
  // A bold introduction card with stacked shadows and a sweeping gradient.
  // This is the first visual the reader sees, so we put the type signature
  // right at the top in a monospace block.
  return Container(
    padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kIndigoDeep, _kIndigo, _kViolet],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kIndigoDeep.withValues(alpha: 0.32),
          blurRadius: 26,
          offset: const Offset(0, 16),
        ),
        BoxShadow(
          color: _kViolet.withValues(alpha: 0.18),
          blurRadius: 60,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
              child: const Icon(
                Icons.grid_view_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Text(
                'BitField<T extends dynamic>',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'A compact, enum-keyed bitmask helper from '
          'package:flutter/foundation.dart. Designed for very small fixed-size '
          'flag sets — semantics flags, feature toggles, permission bags — '
          'where every byte and every access counts. This page walks through '
          'its constructors, indexing semantics, limits, and a fully '
          'interactive worked example over a custom permissions enum.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 13.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            _heroPill('foundation.dart', Icons.layers_outlined),
            const SizedBox(width: 10),
            _heroPill('≤ 62 bits', Icons.straighten),
            const SizedBox(width: 10),
            _heroPill('enum keys only', Icons.label_outline),
          ],
        ),
      ],
    ),
  );
}

Widget _heroPill(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white.withValues(alpha: 0.32)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ----------------------------- section frame -------------------------------

Widget _buildSectionFrame({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color accent,
  required Color accentDeep,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.white,
          accent.withValues(alpha: 0.06),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kBorder),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.10),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: accentDeep.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[accent, accentDeep],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: accentDeep.withValues(alpha: 0.32),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: _kInk,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: _kInkMuted,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

// ----------------------------- intro section -------------------------------

Widget _buildIntroCard() {
  return _buildSectionFrame(
    title: 'Why does BitField exist?',
    subtitle: 'Tiny, fixed-size, enum-keyed bitmask',
    icon: Icons.lightbulb_outline,
    accent: _kIndigo,
    accentDeep: _kIndigoDeep,
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Modern Dart already has a perfectly good `Set<Enum>` and an even '
          'more permissive `Map<Enum, bool>`. Both allocate per entry and pay '
          'hash costs to read or write. For the deepest, hottest layers of '
          'Flutter — accessibility semantics, layout flags, certain renderer '
          'caches — those costs add up. `BitField` exists to compress all of '
          'those booleans into a single integer and to expose them as if '
          'they were a normal indexed collection keyed by an enum.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        SizedBox(height: 12),
        Text(
          'The class is generic over `T extends dynamic`, but in practice the '
          'type parameter must be an enum. Internally it stores a single int '
          '("two-fiddy-six" worth of bits on a 64-bit VM, minus a couple of '
          'sign and tag bits) and uses the enum index as the bit offset. The '
          'invariant is straightforward: every operation translates to one '
          'bitwise operation against a private integer field.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        SizedBox(height: 12),
        Text(
          'Even if you never reach for it directly, knowing it is there '
          'makes some Flutter internals — `SemanticsFlag` in particular — '
          'far less surprising. The mental model is "a Set<Enum>, but with '
          'O(1) integer operations and zero allocation after construction".',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
      ],
    ),
  );
}

// ----------------------------- constructors --------------------------------

Widget _buildConstructorsCard() {
  return _buildSectionFrame(
    title: 'Constructors',
    subtitle: 'Default vs. filled — start empty or pre-populated',
    icon: Icons.api_outlined,
    accent: _kTeal,
    accentDeep: _kTealDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'There are exactly two constructors. Both take the number of bits '
          'as their first positional argument. The length must be at most '
          '62 — the upper bound that Flutter currently asserts in foundation '
          'because a Dart small integer can safely carry that many bits on '
          'every supported platform without boxing into a BigInt.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        const SizedBox(height: 14),
        _ctorRow(
          name: 'BitField<T>(int length)',
          body: 'Creates a field with `length` slots, all initialised to '
              '`false`. Use this when you plan to opt bits in one at a time.',
          tone: _kTeal,
          toneDeep: _kTealDeep,
        ),
        const SizedBox(height: 12),
        _ctorRow(
          name: 'BitField<T>.filled(int length, bool value)',
          body: 'Creates a field with `length` slots all initialised to '
              '`value`. Handy when the natural default is "everything on" '
              '(e.g. a permission preset for an admin) and you want to clear '
              'specific bits afterwards.',
          tone: _kAmber,
          toneDeep: _kAmberDeep,
        ),
        const SizedBox(height: 14),
        const Text(
          'Both constructors return a `BitField<T>` instance. The type '
          'parameter cannot be inferred from the constructor alone, so you '
          'will almost always write the type explicitly at the call site, '
          'as in `BitField<_Permission>(_Permission.values.length)`.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _ctorRow({
  required String name,
  required String body,
  required Color tone,
  required Color toneDeep,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          tone.withValues(alpha: 0.10),
          tone.withValues(alpha: 0.02),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tone.withValues(alpha: 0.32)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: toneDeep.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: toneDeep,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(
            fontSize: 12.5,
            color: _kInkSoft,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ----------------------------- anatomy diagram -----------------------------

Widget _buildAnatomyCard() {
  // Hardcoded sample byte: 1 0 1 1 0 1 0 1 (MSB first), so bit 0 == 1.
  const List<bool> sample = <bool>[
    true, // bit 0
    false, // bit 1
    true, // bit 2
    false, // bit 3
    true, // bit 4
    true, // bit 5
    false, // bit 6
    true, // bit 7
  ];
  return _buildSectionFrame(
    title: 'Anatomy of a bit row',
    subtitle: 'How the eight bits of a sample BitField line up visually',
    icon: Icons.view_column_outlined,
    accent: _kAmber,
    accentDeep: _kAmberDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A `BitField` is conceptually a row of cells. The leftmost cell is '
          'bit 0 (the lowest-significance bit, equal to `enum.values[0]`) '
          'and the rightmost cell is bit N-1. This diagram annotates each '
          'cell with its index, its current boolean value, and the name of '
          'the enum constant that would index it. Reading from left to '
          'right matches Dart `enum.values` order, which makes mental '
          'mapping trivial.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (int i = 0; i < sample.length; i++)
                    _anatomyCell(
                      index: i,
                      value: sample[i],
                      label: _kPermissionLabel[_Permission.values[i]] ?? '?',
                    ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: _kBorder),
              const SizedBox(height: 10),
              const Text(
                'Legend: green cell = bit is 1 (true), red cell = bit is 0 '
                '(false). Index above the cell is the enum index. Name '
                'below the cell is the corresponding enum value name. The '
                'underlying storage for these eight bits is a single Dart '
                'int with binary value 0b10110101.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: _kInkMuted,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyCell({
  required int index,
  required bool value,
  required String label,
}) {
  final Color top = value ? _kBitOn : _kBitOff;
  final Color bot = value ? _kBitOnDeep : _kBitOffDeep;
  return Column(
    children: <Widget>[
      Text(
        '$index',
        style: const TextStyle(
          fontSize: 11,
          color: _kInkMuted,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 4),
      Container(
        width: 32,
        height: 36,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[top, bot],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(6),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: bot.withValues(alpha: 0.35),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          value ? '1' : '0',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ),
      const SizedBox(height: 4),
      SizedBox(
        width: 44,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            color: _kInkSoft,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

// ----------------------------- indexing card -------------------------------

Widget _buildIndexingCard() {
  return _buildSectionFrame(
    title: 'Indexing semantics',
    subtitle: 'bf[someEnum] reads, bf[someEnum] = bool writes',
    icon: Icons.swap_horiz_rounded,
    accent: _kRose,
    accentDeep: _kRoseDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '`BitField` overloads `operator []` and `operator []=` so it looks '
          'identical to an indexed collection at the call site. The key is '
          'always an enum value of the type parameter `T`. Internally the '
          'enum index is converted to a bit offset, and a single mask is '
          'AND-ed or OR-ed against the backing integer. There is no '
          'iteration, no hashing, no allocation.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        const SizedBox(height: 14),
        _opRow(
          op: 'bf[_Permission.read]',
          desc: 'Reads bit 0 — returns true if the bit is set.',
          icon: Icons.south_east_outlined,
          color: _kIndigo,
        ),
        _opRow(
          op: 'bf[_Permission.admin] = true',
          desc: 'Sets the bit corresponding to admin, equivalent to '
              'storage |= (1 << admin.index).',
          icon: Icons.east_outlined,
          color: _kTeal,
        ),
        _opRow(
          op: 'bf[_Permission.audit] = false',
          desc: 'Clears the bit, equivalent to '
              'storage &= ~(1 << audit.index).',
          icon: Icons.east_outlined,
          color: _kAmber,
        ),
        _opRow(
          op: 'bf.reset(value: false)',
          desc: 'Resets every bit to the given value. Useful after recycling '
              'a BitField in a pool.',
          icon: Icons.restart_alt_outlined,
          color: _kViolet,
        ),
        const SizedBox(height: 4),
        const Text(
          'Note that `BitField` does not implement `Iterable<bool>` or '
          '`Iterable<T>`. If you need to enumerate the set bits, you do it '
          'yourself with a `for (final v in T.values) if (bf[v]) yield v;` '
          'pattern. That is intentional: iteration over indices would '
          'force an allocation that defeats the entire purpose.',
          style: TextStyle(fontSize: 12.5, color: _kInkMuted, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _opRow({
  required String op,
  required String desc,
  required IconData icon,
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                op,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kInkSoft,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ----------------------------- interactive demo ----------------------------

Widget _buildInteractiveDemo() {
  return _buildSectionFrame(
    title: 'Worked example: permissions BitField',
    subtitle: 'Tap a chip to flip a bit; the bitmap row updates live',
    icon: Icons.touch_app_outlined,
    accent: _kViolet,
    accentDeep: _kVioletDeep,
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setLocal) {
        // The BitField is captured by reference via the enclosing closure.
        // It survives across rebuilds because `StatefulBuilder` only rebuilds
        // the subtree, not its body's local state. We deliberately put the
        // single source of truth here.
        // The cached `_permissions` instance is allocated once per build of
        // the parent; that is sufficient for a demo file.
        // Initialise the persistent demo state once.
        _PermissionDemoState.ensureInitialised();
        final BitField<_Permission> bf = _PermissionDemoState.bf;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'This card stores a single `BitField<_Permission>` in module '
              'state. Each chip below corresponds to one enum value. '
              'Tapping a chip toggles its bit via the indexed setter. The '
              'visualization row underneath is recomputed every time the '
              'StatefulBuilder rebuilds. No allocations happen during '
              'toggling — the only mutation is a single bitwise operation '
              'against the internal storage integer.',
              style: TextStyle(
                fontSize: 13,
                color: _kInkSoft,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
              decoration: BoxDecoration(
                color: _kSurfaceAlt,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      for (int i = 0; i < _Permission.values.length; i++)
                        _liveCell(
                          index: i,
                          value: bf[_Permission.values[i]],
                          label: _kPermissionLabel[_Permission.values[i]]!,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: _kBorder),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.functions,
                        size: 16,
                        color: _kInkMuted,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'storage bits = ${_renderBitsForUi(bf)}',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: _kInk,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (final _Permission p in _Permission.values)
                  _toggleChip(
                    label: _kPermissionLabel[p]!,
                    icon: _kPermissionIcon[p]!,
                    value: bf[p],
                    onTap: () {
                      setLocal(() {
                        bf[p] = !bf[p];
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                _bulkButton(
                  label: 'all on',
                  icon: Icons.done_all,
                  color: _kBitOn,
                  onTap: () {
                    setLocal(() {
                      for (final _Permission p in _Permission.values) {
                        bf[p] = true;
                      }
                    });
                  },
                ),
                const SizedBox(width: 10),
                _bulkButton(
                  label: 'all off',
                  icon: Icons.remove_done,
                  color: _kBitOff,
                  onTap: () {
                    setLocal(() {
                      for (final _Permission p in _Permission.values) {
                        bf[p] = false;
                      }
                    });
                  },
                ),
                const SizedBox(width: 10),
                _bulkButton(
                  label: 'invert',
                  icon: Icons.flip,
                  color: _kAmberDeep,
                  onTap: () {
                    setLocal(() {
                      for (final _Permission p in _Permission.values) {
                        bf[p] = !bf[p];
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}

Widget _liveCell({
  required int index,
  required bool value,
  required String label,
}) {
  final Color top = value ? _kBitOn : _kBitOff;
  final Color bot = value ? _kBitOnDeep : _kBitOffDeep;
  return Column(
    children: <Widget>[
      Text(
        '$index',
        style: const TextStyle(
          fontSize: 10.5,
          color: _kInkMuted,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 3),
      Container(
        width: 34,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[top, bot],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(7),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: bot.withValues(alpha: 0.42),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          value ? '1' : '0',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 15,
          ),
        ),
      ),
      const SizedBox(height: 4),
      SizedBox(
        width: 46,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            color: _kInkSoft,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

Widget _toggleChip({
  required String label,
  required IconData icon,
  required bool value,
  required VoidCallback onTap,
}) {
  final Color base = value ? _kBitOn : _kInkMuted;
  final Color deep = value ? _kBitOnDeep : _kInkSoft;
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              base.withValues(alpha: 0.18),
              deep.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: base.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: deep),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: deep,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: value ? _kBitOn : _kBitOff,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: (value ? _kBitOn : _kBitOff)
                        .withValues(alpha: 0.45),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _bulkButton({
  required String label,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.45)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Render the BitField's logical bit string as "76543210" MSB-first using the
// public indexed getter; this never touches private fields, so it is robust
// across foundation versions.
String _renderBitsForUi(BitField<_Permission> bf) {
  final StringBuffer sb = StringBuffer('0b');
  for (int i = _Permission.values.length - 1; i >= 0; i--) {
    sb.write(bf[_Permission.values[i]] ? '1' : '0');
  }
  return sb.toString();
}

// Module-level holder so the BitField survives StatefulBuilder rebuilds
// without an `AnimationController` or a root-level State. Initialised lazily
// the first time the demo card is built.
class _PermissionDemoState {
  static BitField<_Permission>? _bf;
  static BitField<_Permission> get bf => _bf!;
  static void ensureInitialised() {
    if (_bf != null) {
      return;
    }
    final BitField<_Permission> fresh =
        BitField<_Permission>(_Permission.values.length);
    fresh[_Permission.read] = true;
    fresh[_Permission.write] = true;
    _bf = fresh;
  }
}

// ----------------------------- presets palette -----------------------------

Widget _buildPresetsCard() {
  return _buildSectionFrame(
    title: 'Preset combinations',
    subtitle: 'Common role bundles as a Wrap of chips',
    icon: Icons.palette_outlined,
    accent: _kAmber,
    accentDeep: _kAmberDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A BitField shines when you can compare entire roles by glancing at '
          'a single visualisation. Below are four preset role bundles, each '
          'rendered as a row of cells over the same eight permission slots. '
          'These were constructed with `BitField.filled` and then trimmed '
          'with the indexed setter — the canonical way to build a preset.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        const SizedBox(height: 14),
        _presetRow('guest', _buildGuest(), _kSlate, _kSlateDeep),
        const SizedBox(height: 10),
        _presetRow('viewer', _buildViewer(), _kIndigo, _kIndigoDeep),
        const SizedBox(height: 10),
        _presetRow('editor', _buildEditor(), _kTeal, _kTealDeep),
        const SizedBox(height: 10),
        _presetRow('admin', _buildAdmin(), _kRose, _kRoseDeep),
        const SizedBox(height: 14),
        const Text(
          'Notice how `admin` and `editor` differ in only two bits, '
          'whereas `guest` and `admin` are nearly each others bitwise '
          'inverse. Bitmask thinking lights up role audits.',
          style: TextStyle(
            fontSize: 12.5,
            color: _kInkMuted,
            height: 1.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _presetRow(
  String name,
  BitField<_Permission> bf,
  Color tone,
  Color toneDeep,
) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          tone.withValues(alpha: 0.12),
          tone.withValues(alpha: 0.02),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tone.withValues(alpha: 0.32)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: toneDeep.withValues(alpha: 0.08),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 60,
          child: Text(
            name,
            style: TextStyle(
              color: toneDeep,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for (int i = 0; i < _Permission.values.length; i++)
                _miniBit(bf[_Permission.values[i]]),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _miniBit(bool value) {
  return Container(
    width: 18,
    height: 22,
    decoration: BoxDecoration(
      color: value ? _kBitOn : _kBitOff,
      borderRadius: BorderRadius.circular(4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: (value ? _kBitOnDeep : _kBitOffDeep)
              .withValues(alpha: 0.32),
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      value ? '1' : '0',
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 11,
      ),
    ),
  );
}

BitField<_Permission> _buildGuest() {
  final BitField<_Permission> bf =
      BitField<_Permission>(_Permission.values.length);
  bf[_Permission.read] = true;
  return bf;
}

BitField<_Permission> _buildViewer() {
  final BitField<_Permission> bf =
      BitField<_Permission>(_Permission.values.length);
  bf[_Permission.read] = true;
  bf[_Permission.share] = true;
  return bf;
}

BitField<_Permission> _buildEditor() {
  final BitField<_Permission> bf =
      BitField<_Permission>(_Permission.values.length);
  bf[_Permission.read] = true;
  bf[_Permission.write] = true;
  bf[_Permission.edit] = true;
  bf[_Permission.share] = true;
  return bf;
}

BitField<_Permission> _buildAdmin() {
  final BitField<_Permission> bf =
      BitField<_Permission>.filled(_Permission.values.length, true);
  // Admin holds everything by default; we leave audit on but could clear it.
  return bf;
}

// ----------------------------- limits card ---------------------------------

Widget _buildLimitsCard() {
  return _buildSectionFrame(
    title: 'Limits and constraints',
    subtitle: 'Know exactly when BitField is the wrong tool',
    icon: Icons.warning_amber_rounded,
    accent: _kBitOff,
    accentDeep: _kBitOffDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'BitField is intentionally minimal. The four limits below are the '
          'whole story, and each of them rules out a particular class of '
          'use cases. If any of these is a deal breaker, reach for a '
          '`Set<T>` or `Map<T, bool>` instead.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        const SizedBox(height: 12),
        _limitRow(
          icon: Icons.straighten,
          title: 'Maximum 62 bits',
          body: 'The length passed to the constructor is asserted to be '
              '≤ 62, matching the safely-tagged small-integer range on every '
              'Dart VM target.',
        ),
        _limitRow(
          icon: Icons.lock_outline,
          title: 'Fixed size, no resize',
          body: 'Length is set once at construction. There is no `add`, no '
              '`grow`, no `resize`. Pool and reuse instead.',
        ),
        _limitRow(
          icon: Icons.label_outline,
          title: 'Enum keys only (in practice)',
          body: 'Although `T extends dynamic`, the implementation uses '
              '`.index`, so non-enum types will throw at runtime.',
        ),
        _limitRow(
          icon: Icons.do_not_disturb_alt,
          title: 'No iteration, no equality, no JSON',
          body: 'No `Iterable` interface, no `==`/`hashCode` overrides, no '
              'built-in serialization. Provide those yourself if needed.',
        ),
      ],
    ),
  );
}

Widget _limitRow({
  required IconData icon,
  required String title,
  required String body,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _kBitOff.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kBitOff.withValues(alpha: 0.35)),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 16, color: _kBitOffDeep),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: _kInkSoft,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ----------------------------- decision matrix -----------------------------

Widget _buildDecisionMatrixCard() {
  return _buildSectionFrame(
    title: 'Decision matrix',
    subtitle: 'BitField vs Set<Enum> vs Map<Enum,bool>',
    icon: Icons.table_chart_outlined,
    accent: _kSlate,
    accentDeep: _kSlateDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Use this matrix as a quick mental check when reaching for a '
          'flag-bag type. Rows are use cases, columns are the three '
          'candidates. Each cell is a short verdict, not a benchmark — the '
          'point is to keep you from accidentally using `BitField` where '
          'iteration ergonomics matter, or `Set<Enum>` where you actually '
          'wanted a stable integer payload.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Table(
            border: const TableBorder(
              horizontalInside: BorderSide(color: _kBorder),
              verticalInside: BorderSide(color: _kBorder),
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.6),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(1.2),
              3: FlexColumnWidth(1.5),
            },
            children: <TableRow>[
              _matrixHeader(),
              _matrixRow(
                'Hot path, fixed enum',
                'best',
                'allocates',
                'allocates more',
              ),
              _matrixRow(
                'Need set algebra',
                'manual',
                'best',
                'verbose',
              ),
              _matrixRow(
                'Need nullable / tri-state',
                'no',
                'no',
                'best',
              ),
              _matrixRow(
                'Serialize as int',
                'natural',
                'manual',
                'manual',
              ),
              _matrixRow(
                'Iterate values',
                'manual',
                'natural',
                'natural',
              ),
              _matrixRow(
                '> 62 entries',
                'unsafe',
                'fine',
                'fine',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

TableRow _matrixHeader() {
  return TableRow(
    decoration: BoxDecoration(
      color: _kSlateDeep.withValues(alpha: 0.92),
    ),
    children: <Widget>[
      _matrixCell('Scenario', isHeader: true),
      _matrixCell('BitField', isHeader: true),
      _matrixCell('Set<Enum>', isHeader: true),
      _matrixCell('Map<Enum,bool>', isHeader: true),
    ],
  );
}

TableRow _matrixRow(String a, String b, String c, String d) {
  return TableRow(
    children: <Widget>[
      _matrixCell(a),
      _matrixCell(b),
      _matrixCell(c),
      _matrixCell(d),
    ],
  );
}

Widget _matrixCell(String text, {bool isHeader = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Text(
      text,
      style: TextStyle(
        color: isHeader ? Colors.white : _kInk,
        fontWeight: isHeader ? FontWeight.w800 : FontWeight.w600,
        fontSize: isHeader ? 12.5 : 12,
        height: 1.35,
      ),
    ),
  );
}

// ----------------------------- code snippet card ---------------------------

Widget _buildCodeSnippetCard() {
  return _buildSectionFrame(
    title: 'Real declaration and usage',
    subtitle: 'A copy-pasteable snippet that mirrors this demo',
    icon: Icons.code_rounded,
    accent: _kIndigo,
    accentDeep: _kIndigoDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'The snippet below is exactly what you would write in a real '
          'production file to declare an enum, a `BitField` over that enum, '
          'and a couple of helpers to read/write/clear it. Notice that the '
          'enum length is taken from `_Permission.values.length`, never '
          'hardcoded — that way adding a new enum value never desynchronises '
          'with the BitField length.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF0F1A2C), Color(0xFF1B2A48)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kIndigoDeep.withValues(alpha: 0.30),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Text(
            '''enum Permission {
  read, write, delete, share, edit, admin, audit, invite,
}

final BitField<Permission> perms =
    BitField<Permission>(Permission.values.length);

perms[Permission.read]  = true;
perms[Permission.write] = true;

bool canDelete = perms[Permission.delete]; // false
perms.reset(value: false);                 // clear all

// "filled" preset for an admin role:
final adminPerms = BitField<Permission>.filled(
  Permission.values.length, true,
);
''',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFFE8EEF8),
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'In a real codebase you would expose the field through a wrapper '
          'class with named getters/setters so that callers never see '
          'BitField directly. That keeps the bitmask an implementation '
          'detail you can swap out if your enum ever grows past 62.',
          style: TextStyle(
            fontSize: 12.5,
            color: _kInkMuted,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ----------------------------- patterns card -------------------------------

Widget _buildPatternsCard() {
  return _buildSectionFrame(
    title: 'Common patterns',
    subtitle: 'Where BitField shows up in real-world Flutter code',
    icon: Icons.auto_awesome_outlined,
    accent: _kTeal,
    accentDeep: _kTealDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'BitField is rarely the star of the show. Instead, it usually '
          'lives inside a wrapper that exposes a friendlier API. Below are '
          'three patterns that appear over and over in the Flutter source '
          'tree and in performance-sensitive plugins.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        const SizedBox(height: 14),
        _patternRow(
          name: 'Feature flags',
          tone: _kIndigo,
          toneDeep: _kIndigoDeep,
          body: 'A handful of compile-time-known boolean toggles wrapped in '
              'a class with named accessors. The BitField is private; the '
              'wrapper exposes `isExperimentalRouterOn`, etc.',
        ),
        _patternRow(
          name: 'Semantics flag sets',
          tone: _kTeal,
          toneDeep: _kTealDeep,
          body: 'Flutters semantics layer keeps per-node flags in a compact '
              'integer-backed structure. BitField is the textbook tool for '
              'that representation, and the official `SemanticsFlag` machinery '
              'is built around the same idea.',
        ),
        _patternRow(
          name: 'Custom permission bags',
          tone: _kViolet,
          toneDeep: _kVioletDeep,
          body: 'Small role models — guest/viewer/editor/admin — that have '
              'to be transferred over the wire as a single integer payload, '
              'then expanded back into a typed API on the receiving end.',
        ),
        _patternRow(
          name: 'Per-frame dirty bits',
          tone: _kAmber,
          toneDeep: _kAmberDeep,
          body: 'A render object that tracks which of its sub-aspects '
              '("needs paint", "needs layout", "needs compositing bits '
              'update") are dirty during a frame. BitField turns the check '
              'into a single comparison.',
        ),
      ],
    ),
  );
}

Widget _patternRow({
  required String name,
  required Color tone,
  required Color toneDeep,
  required String body,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            tone.withValues(alpha: 0.10),
            tone.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 8,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[tone, toneDeep],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: toneDeep,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _kInkSoft,
                    height: 1.45,
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

// ----------------------------- semantics card ------------------------------

Widget _buildSemanticsCard() {
  // Quick visualisation of a `BitField<_Channel>` to drive home that the
  // type parameter can be any enum — a 3-slot BitField is perfectly valid.
  final BitField<_Channel> channels =
      BitField<_Channel>(_Channel.values.length);
  channels[_Channel.audio] = true;
  channels[_Channel.haptics] = true;
  return _buildSectionFrame(
    title: 'A second worked example',
    subtitle: 'A 3-bit BitField<_Channel> for an A/V/H feedback bag',
    icon: Icons.surround_sound_outlined,
    accent: _kRose,
    accentDeep: _kRoseDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'To show that BitField is genuinely generic, here is a separate '
          'example over a different enum. We declare `_Channel { audio, '
          'video, haptics }` and construct a `BitField<_Channel>` of length '
          '3. Audio and haptics are on, video is off. The same indexing '
          'rules apply, just with a smaller bitmask.',
          style: TextStyle(fontSize: 13, color: _kInkSoft, height: 1.5),
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            for (int i = 0; i < _Channel.values.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: _channelCell(
                  index: i,
                  value: channels[_Channel.values[i]],
                  channel: _Channel.values[i],
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'Notice that the same `[]`/`[]=` API works without any change. '
          'The choice of enum is purely a type-level concern; at runtime '
          'the only thing that matters is the enum index. That uniformity '
          'is what makes BitField a useful low-level primitive.',
          style: TextStyle(
            fontSize: 12.5,
            color: _kInkMuted,
            height: 1.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _channelCell({
  required int index,
  required bool value,
  required _Channel channel,
}) {
  final IconData icon = channel == _Channel.audio
      ? Icons.volume_up_outlined
      : channel == _Channel.video
          ? Icons.videocam_outlined
          : Icons.vibration;
  final Color top = value ? _kBitOn : _kBitOff;
  final Color bot = value ? _kBitOnDeep : _kBitOffDeep;
  return Column(
    children: <Widget>[
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[top, bot],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: bot.withValues(alpha: 0.40),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 26),
      ),
      const SizedBox(height: 6),
      Text(
        channel.name,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: _kInkSoft,
        ),
      ),
      Text(
        'bit $index = ${value ? '1' : '0'}',
        style: const TextStyle(fontSize: 10.5, color: _kInkMuted),
      ),
    ],
  );
}

// ----------------------------- reference card ------------------------------

Widget _buildReferenceCard() {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0E1B33), Color(0xFF1A2D55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kIndigoDeep.withValues(alpha: 0.35),
          blurRadius: 22,
          offset: const Offset(0, 12),
        ),
        BoxShadow(
          color: _kViolet.withValues(alpha: 0.18),
          blurRadius: 50,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.menu_book_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Reference summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _refLine(
          'Library',
          'package:flutter/foundation.dart',
        ),
        _refLine(
          'Type parameter',
          '<T extends dynamic> — must be an enum at runtime',
        ),
        _refLine(
          'Constructors',
          'BitField<T>(length) and BitField<T>.filled(length, value)',
        ),
        _refLine(
          'Indexing',
          'bf[enumValue] and bf[enumValue] = bool',
        ),
        _refLine(
          'Reset',
          'bf.reset(value: false) clears (or fills) every bit',
        ),
        _refLine(
          'Hard limit',
          'length ≤ 62 bits — asserted in foundation',
        ),
        _refLine(
          'Allocation',
          'one int per BitField, zero allocation per read/write',
        ),
        _refLine(
          'Iteration',
          'manual: for (final v in T.values) if (bf[v]) ...',
        ),
        const SizedBox(height: 14),
        Text(
          'When in doubt: BitField is a tightly scoped optimisation. Reach '
          'for it only when you can articulate why a Set<Enum> is too '
          'expensive. The rest of the time, the standard collections will '
          'serve you just fine and read more naturally.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 12.5,
            height: 1.55,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _refLine(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(
            key,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.70),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------- footer --------------------------------------

Widget _buildFooter() {
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kIndigo.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.bolt_outlined,
            size: 14,
            color: _kIndigoDeep.withValues(alpha: 0.85),
          ),
          const SizedBox(width: 6),
          Text(
            'BitField demo · flutter_ast corpus',
            style: TextStyle(
              fontSize: 11.5,
              color: _kInkSoft.withValues(alpha: 0.85),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    ),
  );
}
