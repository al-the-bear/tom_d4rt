// D4rt test script: Tests Key, LocalKey, ValueKey, ObjectKey, UniqueKey,
// GlobalKey, GlobalObjectKey, LabeledGlobalKey, PageStorageKey from foundation
// Deep Demo: "Keys — how Flutter decides who's who across rebuilds"
//
// Flutter's Key system is one of the most subtle pieces of the framework.
// Most of the time you can ignore it, but the moment widgets *move around*
// in a list, or you want to keep state when a subtree is rebuilt, keys
// become the deciding factor in whether `State` objects follow the widget
// or stay rooted at a slot.  This script visually walks through every
// concrete subtype, the equality rules each one obeys, the canonical
// "reorder a list" failure mode, and the right tool for each job.

import 'dart:async';
import 'package:flutter/material.dart';

// ============================================================================
// Tiny helper widgets — used everywhere below to keep the build tree readable.
// ============================================================================

Widget _sectionTitle(String index, String title, Color color) {
  return Container(
    margin: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[color.withValues(alpha: 0.85), color.withValues(alpha: 0.55)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION $index',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _narrative(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13.0,
        height: 1.45,
        color: Colors.grey.shade800,
      ),
    ),
  );
}

Widget _chip(String label, Color color, {IconData? icon}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.55)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Icon(icon, size: 14.0, color: color),
          const SizedBox(width: 4.0),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _codeLine(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: Color(0xFFC0CAF5),
      ),
    ),
  );
}

Widget _bullet(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5.0, right: 8.0),
          child: Icon(Icons.fiber_manual_record, size: 8.0, color: color),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.grey.shade800,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// A fake "stateful list item" we can use to demonstrate state preservation.
// In the d4rt environment a `StatefulBuilder` is friendlier than authoring
// a brand new `StatefulWidget` subclass, but the semantic story is identical:
// each item paints with its assigned color and shows a tap-count, so when we
// reorder items we can immediately see whether the `State` (count, color)
// follows the item or stays anchored to the slot.
class _FakeItem {
  _FakeItem(this.id, this.label, this.color, {this.taps = 0});
  final int id;
  final String label;
  final Color color;
  int taps;
}

Widget _fakeListTile(_FakeItem item, {Key? key}) {
  return Container(
    key: key,
    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: item.color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: item.color.withValues(alpha: 0.7), width: 1.5),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 22.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(11.0),
          ),
          alignment: Alignment.center,
          child: Text(
            '${item.id}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            item.label,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: item.color.withValues(alpha: 0.95),
            ),
          ),
        ),
        _chip('taps ${item.taps}', item.color, icon: Icons.touch_app),
      ],
    ),
  );
}

// ============================================================================
// build() entry point — the d4rt host calls this with a live BuildContext.
// ============================================================================
dynamic build(BuildContext context) {
  debugPrint('Foundation key deep-demo executing');

  // Shared "users" the demos refer to.  Using real objects matters for
  // `ObjectKey`/`GlobalObjectKey` — their identity is `identical(value, other)`.
  final List<_FakeItem> demoItems = <_FakeItem>[
    _FakeItem(1, 'Alpha', Colors.red, taps: 3),
    _FakeItem(2, 'Bravo', Colors.green, taps: 7),
    _FakeItem(3, 'Charlie', Colors.blue, taps: 2),
    _FakeItem(4, 'Delta', Colors.orange, taps: 5),
  ];

  final List<Widget> sections = <Widget>[];

  // --------------------------------------------------------------------------
  // SECTION 1: Hero header — keys explained
  // --------------------------------------------------------------------------
  sections.add(
    Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1A237E), Color(0xFF512DA8), Color(0xFFAD1457)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 16.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.vpn_key, color: Colors.white, size: 36.0),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Keys',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'how Flutter decides who is who across rebuilds',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'When Flutter rebuilds a parent, it walks the new widget list and '
              'matches each new widget against the existing Element in the same '
              'slot. The match rule is roughly: same runtimeType AND same key. '
              'No key means "match by position". A key means "match by identity '
              'of this widget no matter where it ended up in the list".',
              style: TextStyle(color: Colors.white, fontSize: 13.0, height: 1.5),
            ),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              _chip('Element matching', Colors.white, icon: Icons.link),
              _chip('State preservation', Colors.white, icon: Icons.save),
              _chip('Reconciliation', Colors.white, icon: Icons.compare_arrows),
              _chip('Identity vs position', Colors.white, icon: Icons.compare),
            ],
          ),
        ],
      ),
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 2: Anatomy of the Key hierarchy
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('2', 'Anatomy of the Key hierarchy', Colors.indigo));
  sections.add(_narrative(
    'Key is abstract.  Concrete keys split into two families: LocalKey — only '
    'unique inside the immediate parent — and GlobalKey — globally unique and '
    'capable of giving you access to the State/Element/Widget at the other end.',
  ));

  final List<Map<String, Object>> anatomy = <Map<String, Object>>[
    <String, Object>{
      'name': 'Key (abstract)',
      'desc': 'Root of the hierarchy. Factory `Key(\'x\')` returns a ValueKey<String>.',
      'color': Colors.blueGrey,
      'icon': Icons.account_tree,
    },
    <String, Object>{
      'name': 'LocalKey (abstract)',
      'desc': 'Identifies widgets within a sibling list. Scope = immediate parent.',
      'color': Colors.teal,
      'icon': Icons.folder_special,
    },
    <String, Object>{
      'name': 'ValueKey<T>',
      'desc': 'Equality based on a value of type T (Strings, ints, ids).',
      'color': Colors.green,
      'icon': Icons.tag,
    },
    <String, Object>{
      'name': 'ObjectKey',
      'desc': 'Equality based on identical() of an arbitrary object reference.',
      'color': Colors.lime,
      'icon': Icons.scatter_plot,
    },
    <String, Object>{
      'name': 'UniqueKey',
      'desc': 'Equal only to itself. Regenerating it forces fresh Element + State.',
      'color': Colors.amber,
      'icon': Icons.fingerprint,
    },
    <String, Object>{
      'name': 'GlobalKey<T extends State>',
      'desc': 'Globally unique. Exposes currentState / currentContext / currentWidget.',
      'color': Colors.deepOrange,
      'icon': Icons.public,
    },
    <String, Object>{
      'name': 'LabeledGlobalKey<T>',
      'desc': 'Concrete GlobalKey subtype carrying a debug label.',
      'color': Colors.red,
      'icon': Icons.label,
    },
    <String, Object>{
      'name': 'GlobalObjectKey<T>',
      'desc': 'GlobalKey whose identity is tied to an Object via identical().',
      'color': Colors.pink,
      'icon': Icons.link,
    },
    <String, Object>{
      'name': 'PageStorageKey<T>',
      'desc': 'Special LocalKey read by PageStorage to persist scroll positions.',
      'color': Colors.purple,
      'icon': Icons.save_alt,
    },
  ];

  for (final Map<String, Object> entry in anatomy) {
    final Color c = entry['color'] as Color;
    sections.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: c.withValues(alpha: 0.45)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Icon(entry['icon'] as IconData, color: c, size: 22.0),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    entry['name'] as String,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: c,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    entry['desc'] as String,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 3: The classic reorder-list problem
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('3', 'The classic reorder-list problem', Colors.deepPurple));
  sections.add(_narrative(
    'Two side-by-side stateful lists hold identical coloured items.  A timer '
    'swaps positions 0 and 1 every two seconds.  In the LEFT column the items '
    'have no keys: Flutter matches by position, so the State (the colour you '
    'see on the chip) stays welded to the slot — colours appear to stay still.  '
    'In the RIGHT column we attach ValueKey(id): Flutter now matches by key, '
    'so the State follows the item — colours swap with the items.',
  ));

  sections.add(
    StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        // Local mutable copies so the demo can be "live".
        final List<_FakeItem> leftItems = <_FakeItem>[
          _FakeItem(1, 'Red', Colors.red),
          _FakeItem(2, 'Green', Colors.green),
          _FakeItem(3, 'Blue', Colors.blue),
          _FakeItem(4, 'Orange', Colors.orange),
        ];
        final List<_FakeItem> rightItems = <_FakeItem>[
          _FakeItem(1, 'Red', Colors.red),
          _FakeItem(2, 'Green', Colors.green),
          _FakeItem(3, 'Blue', Colors.blue),
          _FakeItem(4, 'Orange', Colors.orange),
        ];

        // We do not actually run a timer in the static demo render — d4rt's
        // analyzer-clean snapshot favours a deterministic frame — but the
        // visual encoding is the same: position 0 and 1 are pre-swapped on the
        // right list to dramatise that "state followed the item".
        final _FakeItem tmp = rightItems[0];
        rightItems[0] = rightItems[1];
        rightItems[1] = tmp;

        return Container(
          margin: const EdgeInsets.all(12.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    _chip('NO KEYS — match by position', Colors.red, icon: Icons.close),
                    const SizedBox(height: 6.0),
                    ...leftItems.map<Widget>((_FakeItem it) => _fakeListTile(it)),
                    const SizedBox(height: 8.0),
                    Text(
                      'state stays in slot',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  children: <Widget>[
                    _chip('ValueKey(id) — match by identity', Colors.green, icon: Icons.check),
                    const SizedBox(height: 6.0),
                    ...rightItems.map<Widget>(
                      (_FakeItem it) => _fakeListTile(it, key: ValueKey<int>(it.id)),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'state follows the widget',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  sections.add(_codeLine("ListView(children: items.map((i) => Tile(key: ValueKey(i.id), item: i)).toList())"));

  // --------------------------------------------------------------------------
  // SECTION 4: ValueKey + ObjectKey — equality semantics
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('4', 'ValueKey & ObjectKey — equality semantics', Colors.green));

  final ValueKey<int> vkA1 = const ValueKey<int>(42);
  final ValueKey<int> vkA2 = const ValueKey<int>(42);
  final ValueKey<int> vkB = const ValueKey<int>(43);
  final ValueKey<String> vkAlice = const ValueKey<String>('alice');
  final ValueKey<double> vkPi = const ValueKey<double>(3.14);
  final ValueKey<bool> vkTrue = const ValueKey<bool>(true);

  final Map<String, Object> userAlice = <String, Object>{'name': 'alice'};
  final Map<String, Object> userBob = <String, Object>{'name': 'bob'};
  final ObjectKey okAlice1 = ObjectKey(userAlice);
  final ObjectKey okAlice2 = ObjectKey(userAlice); // same instance
  final ObjectKey okBob = ObjectKey(userBob);

  sections.add(_narrative(
    'ValueKey<T> uses operator== on the wrapped value.  Two ValueKey<int>(42) '
    'instances are equal even though they were constructed separately.  '
    'ObjectKey uses identical() on the wrapped reference — two ObjectKeys are '
    'equal only when they wrap the *same* Dart object.',
  ));

  sections.add(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Live values',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              _chip('ValueKey<int>(42)', Colors.green, icon: Icons.numbers),
              _chip('ValueKey<String>("alice")', Colors.green, icon: Icons.text_fields),
              _chip('ValueKey<double>(3.14)', Colors.green, icon: Icons.percent),
              _chip('ValueKey<bool>(true)', Colors.green, icon: Icons.check_box),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            'vkA1 == vkA2 ➜ ${vkA1 == vkA2}  (both wrap 42)',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
          ),
          Text(
            'vkA1 == vkB  ➜ ${vkA1 == vkB}   (42 vs 43)',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
          ),
          Text(
            'vkA1.value   ➜ ${vkA1.value}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
          ),
          Text(
            'vkAlice.value ➜ ${vkAlice.value}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
          ),
          Text(
            'vkPi == vkTrue ➜ ${(vkPi as Key) == (vkTrue as Key)} (different T)',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
          ),
          const Divider(),
          Text(
            'okAlice1 == okAlice2 ➜ ${okAlice1 == okAlice2}  (same instance)',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
          ),
          Text(
            'okAlice1 == okBob   ➜ ${okAlice1 == okBob}   (different objects)',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
          ),
        ],
      ),
    ),
  );

  sections.add(
    Row(
      children: <Widget>[
        Expanded(
          child: Container(
            key: vkAlice,
            margin: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.green.shade400, width: 2.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Card A', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900)),
                const SizedBox(height: 4.0),
                const Text("ValueKey('alice')", style: TextStyle(fontFamily: 'monospace', fontSize: 11.5)),
                const SizedBox(height: 6.0),
                const Text('Will collapse with any other ValueKey wrapping "alice".', style: TextStyle(fontSize: 11.5)),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            key: okAlice1,
            margin: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.lime.shade100,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.lime.shade700, width: 2.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Card B', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lime.shade900)),
                const SizedBox(height: 4.0),
                const Text('ObjectKey(userAlice)', style: TextStyle(fontFamily: 'monospace', fontSize: 11.5)),
                const SizedBox(height: 6.0),
                const Text('Equal only to another ObjectKey wrapping the *same* userAlice instance.', style: TextStyle(fontSize: 11.5)),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 5: UniqueKey — state is always lost
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('5', 'UniqueKey — state is always lost', Colors.amber));
  sections.add(_narrative(
    'UniqueKey is equal only to itself.  Re-creating UniqueKey() in build() '
    'guarantees that the previous Element cannot match the new widget — Flutter '
    'tears it down and constructs a fresh State.  Useful when you *want* to '
    'force re-initialisation (think: "reset this form to defaults").',
  ));

  final UniqueKey u1 = UniqueKey();
  final UniqueKey u2 = UniqueKey();

  sections.add(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.amber.shade50, Colors.amber.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.amber.shade400, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.fingerprint, color: Colors.amber.shade800),
              const SizedBox(width: 8.0),
              Text(
                'Counter wrapped in UniqueKey',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber.shade900),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            key: u1,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: <Widget>[
                _chip('counter: 0', Colors.amber, icon: Icons.numbers),
                const SizedBox(width: 8.0),
                Text(
                  'each rebuild ➜ fresh UniqueKey ➜ fresh State ➜ counter resets',
                  style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'u1 == u2 ➜ ${u1 == u2}  (always false, even for two UniqueKeys built in the same frame)',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
          ),
        ],
      ),
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 6: GlobalKey deep-dive — currentState + validate()
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('6', 'GlobalKey<FormState> — currentState in action', Colors.deepOrange));
  sections.add(_narrative(
    'A GlobalKey is the only key type from which you can reach back into the '
    'tree.  GlobalKey<FormState> exposes currentState — Flutter populates it '
    'once the Element has been built — and validate() runs every FormField '
    'validator.  Below, the form holds a fake email field; a tap on Save '
    'asks the key to validate.  When the email is empty the error chip lights '
    'up; the data flow is: key.currentState!.validate() → state.errors[0].',
  ));

  // We do not actually drive a Form here (the d4rt environment processes a
  // single build snapshot) but we *create* a GlobalKey<FormState> so the key
  // type, constructor, and debug label are exercised exactly like in
  // production code.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'demoForm');
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'demoScaffold');
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>(debugLabel: 'demoNav');

  sections.add(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.deepOrange.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.deepOrange.shade300, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.public, color: Colors.deepOrange.shade700),
              const SizedBox(width: 8.0),
              Text(
                'Three real-world GlobalKeys',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          _codeLine("final formKey     = GlobalKey<FormState>(debugLabel: 'demoForm');"),
          _codeLine("final scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'demoScaffold');"),
          _codeLine("final navKey      = GlobalKey<NavigatorState>(debugLabel: 'demoNav');"),
          const SizedBox(height: 6.0),
          Text(
            'formKey runtimeType: ${formKey.runtimeType}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
          ),
          Text(
            'currentState (pre-mount): ${formKey.currentState}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
          ),
          Text(
            'currentContext (pre-mount): ${formKey.currentContext}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
          ),
          Text(
            'currentWidget (pre-mount): ${formKey.currentWidget}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.deepOrange.shade200),
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Fake email field', style: TextStyle(fontSize: 12.0)),
                  const SizedBox(height: 4.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: const Text('(empty)', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      _chip('Save', Colors.deepOrange, icon: Icons.save),
                      const SizedBox(width: 8.0),
                      _chip('ERROR: email required', Colors.red, icon: Icons.error),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          _codeLine("if (formKey.currentState!.validate()) { formKey.currentState!.save(); }"),
        ],
      ),
    ),
  );

  // Touch every getter and type so the analyzer sees them used.
  final State<StatefulWidget>? touchState = formKey.currentState;
  final BuildContext? touchCtx = formKey.currentContext;
  final Widget? touchWidget = formKey.currentWidget;
  debugPrint('GlobalKey pre-mount probe: '
      'state=$touchState ctx=$touchCtx widget=$touchWidget '
      'scaffold=${scaffoldKey.currentState} nav=${navKey.currentState}');

  // --------------------------------------------------------------------------
  // SECTION 7: GlobalObjectKey + LabeledGlobalKey
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('7', 'GlobalObjectKey & LabeledGlobalKey', Colors.pink));
  sections.add(_narrative(
    'GlobalObjectKey ties a global identity to an arbitrary object — two '
    'GlobalObjectKeys collide iff they wrap the same object.  LabeledGlobalKey '
    'is the concrete subtype created by `GlobalKey(debugLabel: ...)`; the label '
    'is purely for diagnostics.  If two identical GlobalKeys live in the tree '
    'at the same time Flutter throws — section 9 covers that anti-pattern.',
  ));

  final Object accountAlice = Object();
  final Object accountBob = Object();
  final GlobalObjectKey<State<StatefulWidget>> gokAlice1 =
      GlobalObjectKey<State<StatefulWidget>>(accountAlice);
  final GlobalObjectKey<State<StatefulWidget>> gokAlice2 =
      GlobalObjectKey<State<StatefulWidget>>(accountAlice);
  final GlobalObjectKey<State<StatefulWidget>> gokBob =
      GlobalObjectKey<State<StatefulWidget>>(accountBob);

  final LabeledGlobalKey<State<StatefulWidget>> labA =
      LabeledGlobalKey<State<StatefulWidget>>('panel-A');
  final LabeledGlobalKey<State<StatefulWidget>> labB =
      LabeledGlobalKey<State<StatefulWidget>>('panel-B');

  sections.add(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.pink.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'GlobalObjectKey equality',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink.shade900),
          ),
          const SizedBox(height: 4.0),
          Text('gokAlice1 == gokAlice2 ➜ ${gokAlice1 == gokAlice2}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0)),
          Text('gokAlice1 == gokBob    ➜ ${gokAlice1 == gokBob}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0)),
          const SizedBox(height: 10.0),
          Text(
            'LabeledGlobalKey identity',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink.shade900),
          ),
          const SizedBox(height: 4.0),
          Text('labA.toString() ➜ $labA', style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0)),
          Text('labB.toString() ➜ $labB', style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0)),
          Text('labA == labB    ➜ ${labA == labB}  (different instances ⇒ never equal)', style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0)),
        ],
      ),
    ),
  );

  sections.add(
    Row(
      children: <Widget>[
        Expanded(
          child: Container(
            key: gokAlice1,
            margin: const EdgeInsets.fromLTRB(16.0, 6.0, 8.0, 6.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.pink.shade400, width: 2.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.person, color: Colors.pink.shade700),
                Text('GlobalObjectKey(accountAlice)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink.shade900, fontSize: 11.5)),
                const SizedBox(height: 4.0),
                const Text('Collides with any other GOK wrapping the same account.', style: TextStyle(fontSize: 11.0)),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            key: labA,
            margin: const EdgeInsets.fromLTRB(8.0, 6.0, 16.0, 6.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.red.shade400, width: 2.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.label, color: Colors.red.shade700),
                Text('LabeledGlobalKey("panel-A")', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade900, fontSize: 11.5)),
                const SizedBox(height: 4.0),
                const Text('Debug-friendly; equality follows reference identity.', style: TextStyle(fontSize: 11.0)),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 8: PageStorageKey — scroll preservation
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('8', 'PageStorageKey — scroll-position memory', Colors.purple));
  sections.add(_narrative(
    'PageStorageKey<T> is a LocalKey that PageStorage reads to persist things '
    'like scroll offsets across rebuilds.  In a TabView, switching tabs '
    'rebuilds the body — without a PageStorageKey scroll position resets, with '
    'one it is restored.  Below: two tabs render the same list; only the '
    'left one carries `PageStorageKey("list1")`.',
  ));

  Widget buildScrollList({Key? key, required Color color, required String title}) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(8.0),
      height: 180.0,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 12.5)),
          const SizedBox(height: 6.0),
          Expanded(
            child: ListView.builder(
              key: key,
              itemCount: 30,
              itemBuilder: (BuildContext lc, int idx) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'row $idx',
                    style: TextStyle(fontSize: 11.5, color: color),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  sections.add(
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: buildScrollList(
            key: const PageStorageKey<String>('list1'),
            color: Colors.purple,
            title: 'with PageStorageKey',
          ),
        ),
        Expanded(
          child: buildScrollList(
            color: Colors.grey,
            title: 'without key',
          ),
        ),
      ],
    ),
  );

  sections.add(_codeLine("ListView(key: const PageStorageKey('list1'), children: ...)"));

  // --------------------------------------------------------------------------
  // SECTION 9: Hot-tip — when NOT to use GlobalKey
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('9', 'When NOT to reach for GlobalKey', Colors.red));
  sections.add(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.red.shade300, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber, color: Colors.red.shade700),
              const SizedBox(width: 8.0),
              Text(
                'Anti-pattern checklist',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade900),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          _bullet('Do not create a GlobalKey inside build() — every rebuild yields a new key and the Element is torn down each frame.', Colors.red),
          _bullet('Do not use GlobalKey just to read another widget\'s value: use a callback, InheritedWidget, ChangeNotifier or Provider instead.', Colors.red),
          _bullet('Do not move a GlobalKeyed widget between parents in a way that leaves two copies live at the same time — Flutter will assert "Multiple widgets used the same GlobalKey".', Colors.red),
          _bullet('Do not use GlobalKey across packages or features as a quick "service locator".', Colors.red),
          _bullet('Prefer ValueKey/ObjectKey for ordinary list reordering; reserve GlobalKey for true cross-tree identity (Form, Navigator, Scaffold).', Colors.red),
        ],
      ),
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 10: Hash & equality reference table
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('10', 'Hash & equality reference table', Colors.blueGrey));

  final List<List<String>> hashRows = <List<String>>[
    <String>['ValueKey<int>(1)', 'ValueKey<int>(1)', '${const ValueKey<int>(1) == const ValueKey<int>(1)}'],
    <String>['ValueKey<int>(1)', 'ValueKey<int>(2)', '${const ValueKey<int>(1) == const ValueKey<int>(2)}'],
    <String>['ValueKey<String>("a")', 'ValueKey<String>("a")', '${const ValueKey<String>('a') == const ValueKey<String>('a')}'],
    <String>['ObjectKey(userAlice)', 'ObjectKey(userAlice)', '${okAlice1 == okAlice2}'],
    <String>['ObjectKey(userAlice)', 'ObjectKey(userBob)', '${okAlice1 == okBob}'],
    <String>['UniqueKey()', 'UniqueKey()', '${u1 == u2}'],
    <String>['UniqueKey() ≡ self', 'self', '${u1 == u1}'],
    <String>['GlobalObjectKey(a)', 'GlobalObjectKey(a)', '${gokAlice1 == gokAlice2}'],
    <String>['GlobalObjectKey(a)', 'GlobalObjectKey(b)', '${gokAlice1 == gokBob}'],
    <String>['LabeledGlobalKey("panel-A")', 'LabeledGlobalKey("panel-A")', '${labA == LabeledGlobalKey<State<StatefulWidget>>('panel-A')}'],
  ];

  sections.add(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blueGrey.shade200),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text('A', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey.shade900))),
              Expanded(child: Text('B', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey.shade900))),
              SizedBox(width: 70.0, child: Text('a == b', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey.shade900))),
            ],
          ),
          const Divider(height: 12.0),
          ...hashRows.map<Widget>((List<String> row) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text(row[0], style: const TextStyle(fontFamily: 'monospace', fontSize: 11.5))),
                  Expanded(child: Text(row[1], style: const TextStyle(fontFamily: 'monospace', fontSize: 11.5))),
                  SizedBox(
                    width: 70.0,
                    child: _chip(
                      row[2],
                      row[2] == 'true' ? Colors.green : Colors.red,
                      icon: row[2] == 'true' ? Icons.check : Icons.close,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 11: Real-world micro-app: kanban-style 3-column board
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('11', 'Kanban board — keyed vs unkeyed reorder', Colors.cyan));
  sections.add(_narrative(
    'Three columns: TODO, DOING, DONE.  Each card represents a task with its '
    'own colour and tap-count.  The LEFT board uses unkeyed cards: when you '
    'drag a task across columns the state stays at the old position, leaking '
    'between unrelated tasks.  The RIGHT board uses ValueKey(task.id): cards '
    'preserve their identity no matter where they land — exactly what users '
    'expect from a kanban.',
  ));

  List<_FakeItem> tasksFor(String column) {
    return demoItems
        .where((_FakeItem t) => t.label.startsWith(column.substring(0, 1)) || column == 'TODO')
        .toList();
  }

  Widget buildBoard({required String name, required bool keyed, required Color accent}) {
    Widget col(String title, List<_FakeItem> tasks, Color colColor) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: colColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: colColor.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: colColor, fontSize: 11.5)),
              const SizedBox(height: 4.0),
              ...tasks.map<Widget>(
                (_FakeItem t) => _fakeListTile(t, key: keyed ? ValueKey<int>(t.id) : null),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(keyed ? Icons.check_circle : Icons.error, color: accent),
              const SizedBox(width: 6.0),
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: accent)),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              col('TODO', tasksFor('TODO').take(2).toList(), Colors.blue),
              col('DOING', tasksFor('TODO').skip(2).take(1).toList(), Colors.orange),
              col('DONE', tasksFor('TODO').skip(3).take(1).toList(), Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  sections.add(buildBoard(name: 'Unkeyed board (broken)', keyed: false, accent: Colors.red));
  sections.add(buildBoard(name: 'Keyed board (correct)', keyed: true, accent: Colors.green));

  // --------------------------------------------------------------------------
  // SECTION 12: Cheat sheet
  // --------------------------------------------------------------------------
  sections.add(_sectionTitle('12', 'Cheat sheet — pick the right key', Colors.teal));

  final List<List<String>> cheat = <List<String>>[
    <String>['ValueKey<T>', 'Reorderable list rows with a stable scalar id'],
    <String>['ObjectKey', 'Reorderable list rows whose model has no stable id field'],
    <String>['UniqueKey', 'Forcing a subtree to be torn down and recreated'],
    <String>['GlobalKey<FormState>', 'Triggering validate/save/reset from outside the form'],
    <String>['GlobalKey<NavigatorState>', 'Pushing routes from outside the Navigator'],
    <String>['GlobalKey<ScaffoldState>', 'Opening drawers / showing SnackBars from outside'],
    <String>['GlobalObjectKey', 'Cross-tree identity tied to a domain object (e.g. logged-in user)'],
    <String>['LabeledGlobalKey', 'GlobalKey with a human-readable debug label'],
    <String>['PageStorageKey', 'Persisting scroll position across tab/page switches'],
  ];

  sections.add(
    Container(
      margin: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 24.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text('Key', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal.shade900))),
              Expanded(flex: 2, child: Text('Use it when…', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal.shade900))),
            ],
          ),
          const Divider(),
          ...cheat.map<Widget>((List<String> r) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      r[0],
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(r[1], style: const TextStyle(fontSize: 12.0)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 13: Footer — quick summary + a printed report
  // --------------------------------------------------------------------------
  debugPrint('---- Key demo: equality summary ----');
  debugPrint('ValueKey(42)==ValueKey(42): ${vkA1 == vkA2}');
  debugPrint('ValueKey(42)==ValueKey(43): ${vkA1 == vkB}');
  debugPrint('ObjectKey(alice)==ObjectKey(alice): ${okAlice1 == okAlice2}');
  debugPrint('ObjectKey(alice)==ObjectKey(bob): ${okAlice1 == okBob}');
  debugPrint('UniqueKey()==UniqueKey(): ${u1 == u2}');
  debugPrint('GlobalObjectKey(a)==GlobalObjectKey(a): ${gokAlice1 == gokAlice2}');
  debugPrint('GlobalObjectKey(a)==GlobalObjectKey(b): ${gokAlice1 == gokBob}');

  // Optional: schedule a tear-down log so a real Timer use is exercised
  // (this is what we would cancel in dispose in a real StatefulWidget).
  Timer.run(() => debugPrint('Key demo: post-frame Timer fired'));

  sections.add(
    Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF263238), Color(0xFF37474F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book, color: Colors.white70),
              SizedBox(width: 8.0),
              Text(
                'Summary',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Keys are how Flutter answers the question "is this new widget the same widget as the one that was in this slot last frame?". '
            'LocalKeys (Value/Object/Unique/PageStorage) decide identity inside a parent. GlobalKeys grant the rare ability to reach back into the tree, '
            'at the cost of being a single-instance resource. Use the smallest key that does the job: most lists only need ValueKey(id).',
            style: TextStyle(color: Colors.white, fontSize: 12.5, height: 1.5),
          ),
        ],
      ),
    ),
  );

  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    appBar: AppBar(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      title: const Text('Keys — Deep Demo'),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: sections,
      ),
    ),
  );
}
