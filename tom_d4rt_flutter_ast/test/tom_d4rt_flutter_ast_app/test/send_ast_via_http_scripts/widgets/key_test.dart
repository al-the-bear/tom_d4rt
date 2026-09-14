// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Module-level GlobalKeys.
//
// GlobalKeys must remain stable across rebuilds. The canonical way to achieve
// this is to declare them at module scope (or as fields on a long-lived
// object) so they survive every call to build().
// ---------------------------------------------------------------------------
final GlobalKey<FormState> kFormGlobalKey = GlobalKey<FormState>(
  debugLabel: 'kFormGlobalKey',
);
final GlobalKey kFindableContainerKey = GlobalKey(
  debugLabel: 'kFindableContainerKey',
);
final LabeledGlobalKey<State> kLabeledStateKey = LabeledGlobalKey<State>(
  'kLabeledStateKey',
);

// A long-lived identity used by GlobalObjectKey demonstrations. We want the
// SAME instance to back the key on every rebuild, so we declare it at module
// scope rather than inside build().
final Object kProfileIdentity = Object();
final GlobalObjectKey kProfileGlobalObjectKey = GlobalObjectKey(
  kProfileIdentity,
);

// A simple data class used in the list demos. We deliberately do NOT override
// operator== so that two structurally equal instances are not "equal" by
// default. This lets ObjectKey behave the way we expect when comparing by
// identity, and ValueKey('id-1') compare by value of the id string.
class Todo {
  final String id;
  final String label;
  const Todo(this.id, this.label);

  @override
  String toString() => 'Todo(id: $id, label: $label)';
}

// Stable list, declared at module scope so each rebuild reuses the same
// underlying Todo objects (helps illustrate ObjectKey identity semantics).
final List<Todo> kTodoList = <Todo>[
  Todo('t-001', 'Buy milk'),
  Todo('t-002', 'Walk the dog'),
  Todo('t-003', 'Read 30 pages'),
  Todo('t-004', 'Practice scales'),
  Todo('t-005', 'Pay rent'),
];

// A constant for the visual demo palette so colors stay legible.
const Color kPanelBg = Color(0xFFF6F7FB);
const Color kPanelBorder = Color(0xFFCBD2DC);
const Color kAccent = Color(0xFF2D6CDF);
const Color kAccentSoft = Color(0xFFD9E5FA);
const Color kGood = Color(0xFF1F8F4E);
const Color kGoodSoft = Color(0xFFC8EAD4);
const Color kBad = Color(0xFFB23A48);
const Color kBadSoft = Color(0xFFF3CFD3);
const Color kMuted = Color(0xFF60697A);

// ---------------------------------------------------------------------------
// Top-level helper functions (no Stateful/Stateless subclasses).
// ---------------------------------------------------------------------------

Widget buildPanelTitle(String title, {String? subtitle}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B2440),
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12.5,
                color: kMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget buildPanelShell({required String title, String? subtitle, required Widget child}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 18.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kPanelBg,
      border: Border.all(color: kPanelBorder),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildPanelTitle(title, subtitle: subtitle),
        child,
      ],
    ),
  );
}

Widget buildBadge(String label, {Color bg = kAccentSoft, Color fg = kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: fg,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget buildCaption(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 12.5, color: kMuted),
    ),
  );
}

Widget buildKvRow(String k, String v) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130.0,
          child: Text(
            k,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B2440),
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: Color(0xFF1B2440),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildGoodBadCard({
  required String title,
  required String verdict,
  required bool good,
  required String snippet,
  required String why,
}) {
  final Color bg = good ? kGoodSoft : kBadSoft;
  final Color fg = good ? kGood : kBad;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: bg,
      border: Border.all(color: fg),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: fg,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                good ? 'GOOD' : 'BAD',
                style: const TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: fg.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            snippet,
            style: const TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Color(0xFF1B2440),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'verdict: $verdict',
          style: TextStyle(
            fontSize: 12.0,
            color: fg,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          why,
          style: const TextStyle(fontSize: 12.0, color: Color(0xFF1B2440)),
        ),
      ],
    ),
  );
}

Widget buildArrow(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: <Widget>[
        const Text(
          'v',
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: 'monospace',
            color: kMuted,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(fontSize: 12.0, color: kMuted),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 — Header / anatomy of where Key lives in the widget element tree.
// ---------------------------------------------------------------------------
Widget buildSection1Anatomy() {
  return buildPanelShell(
    title: '1. Anatomy — where Key lives',
    subtitle:
        'Key is a property on Widget. Flutter uses it during reconciliation '
        'to decide whether an Element keeps its child State or rebuilds it.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kPanelBorder),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Text(
            'Widget(key: Key?)\n'
            '   |\n'
            '   v\n'
            'Element  <- holds (runtimeType, key) to match Widgets across builds\n'
            '   |\n'
            '   v\n'
            'State    <- preserved iff Element matches in BOTH runtimeType AND key',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFF1B2440),
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 6.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: kAccentSoft,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  'Without a Key, Flutter matches by runtimeType + position. '
                  'Two siblings of the same type at index 0 and 1 are '
                  'interchangeable.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF1B2440)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 6.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: kGoodSoft,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  'With a Key, Flutter can identify the SAME logical widget '
                  'even after siblings move. State follows the key, not the '
                  'index.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF1B2440)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        buildCaption(
          'Conceptual story: widgets need identity beyond runtimeType because '
          'collections of same-typed siblings (TodoTile, TodoTile, TodoTile) '
          'all look identical to the framework. Key answers "which one is which?"',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 — ValueKey vs UniqueKey vs ObjectKey, side-by-side.
// ---------------------------------------------------------------------------
Widget buildKeyRow(int i, Todo t) {
  final ValueKey<String> vKey = ValueKey<String>(t.id);
  final UniqueKey uKey = UniqueKey();
  final ObjectKey oKey = ObjectKey(t);
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: kPanelBorder),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 24.0,
              height: 24.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kAccent,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                t.label,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1B2440),
                ),
              ),
            ),
            buildBadge('id=${t.id}'),
          ],
        ),
        const SizedBox(height: 6.0),
        buildKvRow('ValueKey expr', "ValueKey<String>('${t.id}')"),
        buildKvRow('ValueKey value', vKey.toString()),
        buildKvRow('ValueKey type', vKey.runtimeType.toString()),
        const SizedBox(height: 2.0),
        buildKvRow('UniqueKey expr', 'UniqueKey()'),
        buildKvRow('UniqueKey value', uKey.toString()),
        buildKvRow('UniqueKey type', uKey.runtimeType.toString()),
        const SizedBox(height: 2.0),
        buildKvRow('ObjectKey expr', 'ObjectKey(todo)'),
        buildKvRow('ObjectKey value', oKey.toString()),
        buildKvRow('ObjectKey type', oKey.runtimeType.toString()),
      ],
    ),
  );
}

Widget buildSection2Trio() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < kTodoList.length; i++) {
    rows.add(buildKeyRow(i, kTodoList[i]));
  }
  return buildPanelShell(
    title: '2. ValueKey vs UniqueKey vs ObjectKey',
    subtitle:
        'Each row shows the same Todo with all three key constructions and '
        'their runtimeType. Notice ValueKey carries the id literally, UniqueKey '
        'is opaque, ObjectKey wraps the object reference.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 — ValueKey identity: equal-by-value, contrast UniqueKey.
// ---------------------------------------------------------------------------
Widget buildSection3ValueKeyIdentity() {
  final ValueKey<String> a1 = const ValueKey<String>('a');
  final ValueKey<String> a2 = const ValueKey<String>('a');
  final ValueKey<String> b1 = const ValueKey<String>('b');
  final UniqueKey u1 = UniqueKey();
  final UniqueKey u2 = UniqueKey();

  final bool aEqA = a1 == a2;
  final bool aEqB = a1 == b1;
  final bool uEqU = u1 == u2;

  return buildPanelShell(
    title: "3. ValueKey identity — equal by VALUE",
    subtitle:
        "Two ValueKey('a') instances are == because they wrap the same value. "
        "UniqueKey() makes a fresh identity every time.",
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kPanelBorder),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKvRow('a1', a1.toString()),
              buildKvRow('a2', a2.toString()),
              buildKvRow('b1', b1.toString()),
              buildKvRow('a1 == a2', '$aEqA  (expected: true)'),
              buildKvRow('a1 == b1', '$aEqB  (expected: false)'),
              const Divider(height: 14.0),
              buildKvRow('u1', u1.toString()),
              buildKvRow('u2', u2.toString()),
              buildKvRow('u1 == u2', '$uEqU  (expected: false)'),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        buildCaption(
          "When you want 'this is the same logical widget across rebuilds', "
          "use ValueKey of a stable id. When you want 'force this widget to be "
          "treated as brand new every time', use UniqueKey.",
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 — ObjectKey: identity, not structural equality.
// ---------------------------------------------------------------------------
Widget buildSection4ObjectKeyIdentity() {
  final Todo same = kTodoList[0];
  final ObjectKey ok1 = ObjectKey(same);
  final ObjectKey ok2 = ObjectKey(same);

  final Todo clone = Todo(same.id, same.label); // equal-looking, different instance
  final ObjectKey okClone = ObjectKey(clone);

  final bool sameEq = ok1 == ok2;
  final bool cloneEq = ok1 == okClone;

  return buildPanelShell(
    title: '4. ObjectKey identity — same REFERENCE only',
    subtitle:
        'ObjectKey hashes by identityHashCode of the wrapped object. '
        'Two ObjectKeys are equal only when they wrap the SAME instance.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kPanelBorder),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKvRow('same instance', same.toString()),
              buildKvRow('ok1', ok1.toString()),
              buildKvRow('ok2', ok2.toString()),
              buildKvRow('ok1 == ok2', '$sameEq  (expected: true)'),
              const Divider(height: 14.0),
              buildKvRow('clone (new instance)', clone.toString()),
              buildKvRow('okClone', okClone.toString()),
              buildKvRow('ok1 == okClone', '$cloneEq  (expected: false)'),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        buildCaption(
          'Use ObjectKey when the natural identity of your item IS its object '
          'reference — e.g. when you carry the same data object through the '
          'app and care about that exact instance.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 — PageStorageKey: preserved scroll position across rebuilds.
// ---------------------------------------------------------------------------
Widget buildScrollPositionCard(String label, double offset) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: kPanelBorder),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kAccentSoft,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Text(
            '||',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: kAccent,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1B2440),
                ),
              ),
              Text(
                'scrollOffset stored under this PageStorageKey: ${offset.toStringAsFixed(1)} px',
                style: const TextStyle(fontSize: 12.0, color: kMuted),
              ),
            ],
          ),
        ),
        buildBadge('PageStorage'),
      ],
    ),
  );
}

Widget buildSection5PageStorage() {
  final PageStorageKey<String> tabANewsKey =
      const PageStorageKey<String>('tab-A-news-list');
  final PageStorageKey<String> tabBChatKey =
      const PageStorageKey<String>('tab-B-chat-list');
  final PageStorageKey<String> tabCSettingsKey =
      const PageStorageKey<String>('tab-C-settings-list');

  final ListView demoList = ListView(
    key: tabANewsKey,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: <Widget>[
      Container(height: 50.0, color: const Color(0xFFFCE4EC)),
      Container(height: 50.0, color: const Color(0xFFE1F5FE)),
      Container(height: 50.0, color: const Color(0xFFE8F5E9)),
    ],
  );

  return buildPanelShell(
    title: '5. PageStorageKey — survives swap between tabs',
    subtitle:
        'When a Scrollable carries a PageStorageKey, Flutter writes its '
        'scrollOffset into the enclosing PageStorage bucket. After leaving '
        'and returning, the same key restores the offset.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildScrollPositionCard("PageStorageKey<String>('tab-A-news-list')", 482.0),
        buildScrollPositionCard("PageStorageKey<String>('tab-B-chat-list')", 117.5),
        buildScrollPositionCard("PageStorageKey<String>('tab-C-settings-list')", 0.0),
        const SizedBox(height: 8.0),
        Text(
          'Key A: ${tabANewsKey.toString()}',
          style: const TextStyle(fontSize: 11.5, fontFamily: 'monospace'),
        ),
        Text(
          'Key B: ${tabBChatKey.toString()}',
          style: const TextStyle(fontSize: 11.5, fontFamily: 'monospace'),
        ),
        Text(
          'Key C: ${tabCSettingsKey.toString()}',
          style: const TextStyle(fontSize: 11.5, fontFamily: 'monospace'),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kPanelBorder),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Demo ListView wired with a PageStorageKey:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1B2440),
                ),
              ),
              const SizedBox(height: 6.0),
              SizedBox(height: 150.0, child: demoList),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        buildCaption(
          'Without PageStorageKey, swapping tabs causes a fresh Scrollable and '
          'scrollOffset resets to 0. Add the key and Flutter remembers where '
          'each list was, per key, inside the same PageStorage scope.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 — GlobalKey<FormState>: stable handle to imperative state.
// ---------------------------------------------------------------------------
Widget buildSection6GlobalKey() {
  final Form demoForm = Form(
    key: kFormGlobalKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'you@example.com',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
      ],
    ),
  );

  return buildPanelShell(
    title: '6. GlobalKey<FormState> — reach into State imperatively',
    subtitle:
        'GlobalKey is declared at module scope so it survives every build. '
        'Inside event handlers we can call kFormGlobalKey.currentState?.validate().',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kPanelBorder),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKvRow('declared at', 'module top-level'),
              buildKvRow('debugLabel', "'kFormGlobalKey'"),
              buildKvRow('runtimeType', kFormGlobalKey.runtimeType.toString()),
              buildKvRow('toString()', kFormGlobalKey.toString()),
              buildKvRow('currentState', 'GlobalKey<FormState>.currentState?'),
              buildKvRow(
                'usage',
                'kFormGlobalKey.currentState?.validate()',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        demoForm,
        const SizedBox(height: 6.0),
        buildCaption(
          'GlobalKey lets you bridge declarative Widgets with imperative '
          'commands — validate a Form, openDrawer() on a Scaffold, push '
          'routes from a top-level NavigatorState. Use it sparingly.',
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: kAccentSoft,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'LabeledGlobalKey: ${kLabeledStateKey.toString()}\n'
            'Use LabeledGlobalKey<T>("name") to get a GlobalKey whose '
            'toString() includes a human-readable tag for debugging.',
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(0xFF1B2440),
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 — GlobalObjectKey: identity-driven global key.
// ---------------------------------------------------------------------------
Widget buildSection7GlobalObjectKey() {
  final GlobalObjectKey sameAgain = GlobalObjectKey(kProfileIdentity);
  final GlobalObjectKey other = GlobalObjectKey(Object());

  final bool sameEq = kProfileGlobalObjectKey == sameAgain;
  final bool otherEq = kProfileGlobalObjectKey == other;

  final Container demo = Container(
    key: kProfileGlobalObjectKey,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kAccentSoft,
      border: Border.all(color: kAccent),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: const Text(
      'I am attached to kProfileGlobalObjectKey.\n'
      'My identity == identity of kProfileIdentity (a long-lived Object()).',
      style: TextStyle(fontSize: 12.5, color: Color(0xFF1B2440)),
    ),
  );

  return buildPanelShell(
    title: '7. GlobalObjectKey — global key, keyed by object identity',
    subtitle:
        'Like GlobalKey but its identity equals the identity of an object you '
        'already keep alive (e.g. a model). Two GlobalObjectKeys are equal '
        'when they wrap the same instance.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kPanelBorder),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKvRow('kProfileIdentity', 'a module-level Object() instance'),
              buildKvRow('kProfileGlobalObjectKey', kProfileGlobalObjectKey.toString()),
              buildKvRow('sameAgain', sameAgain.toString()),
              buildKvRow('== same identity', '$sameEq  (expected: true)'),
              buildKvRow('other (new Object())', other.toString()),
              buildKvRow('== different identity', '$otherEq  (expected: false)'),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        demo,
        const SizedBox(height: 6.0),
        buildCaption(
          'Useful when you already have a stable domain object (User, Doc) '
          'that you can use as the natural identity for a global handle.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 — Reorderable list illustration: with vs without keys.
// ---------------------------------------------------------------------------
Widget buildTodoTile(Todo t, {Key? key, required bool keyed}) {
  return Container(
    key: key,
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: keyed ? kGoodSoft : kBadSoft,
      border: Border.all(color: keyed ? kGood : kBad),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 22.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: keyed ? kGood : kBad,
            borderRadius: BorderRadius.circular(11.0),
          ),
          alignment: Alignment.center,
          child: const Text(
            '*',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12.0,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            t.label,
            style: const TextStyle(
              fontSize: 13.0,
              color: Color(0xFF1B2440),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          key == null ? '(no key)' : 'key: ${key.toString()}',
          style: const TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: kMuted,
          ),
        ),
      ],
    ),
  );
}

Widget buildOrderedColumn(String header, List<Todo> order, {required bool keyed}) {
  final List<Widget> children = <Widget>[
    Text(
      header,
      style: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w700,
        color: keyed ? kGood : kBad,
      ),
    ),
    const SizedBox(height: 6.0),
  ];
  for (int i = 0; i < order.length; i++) {
    final Todo t = order[i];
    children.add(buildTodoTile(
      t,
      key: keyed ? ValueKey<String>(t.id) : null,
      keyed: keyed,
    ));
  }
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: kPanelBorder),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

Widget buildSection8Reorder() {
  final List<Todo> orig = kTodoList;
  final List<Todo> shuffled = <Todo>[
    kTodoList[2],
    kTodoList[0],
    kTodoList[4],
    kTodoList[1],
    kTodoList[3],
  ];

  return buildPanelShell(
    title: '8. Reordering — state without keys evaporates',
    subtitle:
        'Imagine each tile holds private State (animation, expanded flag, '
        'cached scroll). With no key, position drives matching: moving items '
        'around steals State from the wrong tile. With ValueKey(todo.id), '
        'State follows the row no matter where it lands.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: buildOrderedColumn(
                  'BEFORE (initial order)',
                  orig,
                  keyed: false,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: buildOrderedColumn(
                  'AFTER reorder, NO keys (state mixes up)',
                  shuffled,
                  keyed: false,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: buildOrderedColumn(
                  'BEFORE (initial order)',
                  orig,
                  keyed: true,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: buildOrderedColumn(
                  'AFTER reorder, WITH ValueKey(id) — state follows',
                  shuffled,
                  keyed: true,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        buildArrow('Reconcile by position: element 0 still maps to slot 0.'),
        buildArrow('Reconcile by key: element with key="t-003" maps wherever t-003 is now.'),
        buildCaption(
          'This is the classic motivation for keys: reorderable lists, '
          'AnimatedList, swappable tabs, draggable cards.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 — Key in a collection: each child labelled by its key.
// ---------------------------------------------------------------------------
Widget buildLabeledChild(String label, Color color, Key key) {
  return Expanded(
    child: Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      padding: const EdgeInsets.all(8.0),
      height: 70.0,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: kPanelBorder),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2440),
            ),
          ),
          Text(
            'key: ${key.toString()}',
            style: const TextStyle(
              fontSize: 10.5,
              fontFamily: 'monospace',
              color: kMuted,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildSection9Collection() {
  return buildPanelShell(
    title: '9. Keys in a collection — each child labelled',
    subtitle:
        'A Row of four children, each one labelled with the actual Key value '
        'attached to it.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            buildLabeledChild('Red', const Color(0xFFFFCDD2), const ValueKey<String>('red')),
            buildLabeledChild('Green', const Color(0xFFC8E6C9), const ValueKey<String>('green')),
            buildLabeledChild('Blue', const Color(0xFFBBDEFB), const ValueKey<String>('blue')),
            buildLabeledChild('Yellow', const Color(0xFFFFF9C4), const ValueKey<String>('yellow')),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            buildLabeledChild('U-1', const Color(0xFFE1BEE7), UniqueKey()),
            buildLabeledChild('U-2', const Color(0xFFD1C4E9), UniqueKey()),
            buildLabeledChild('U-3', const Color(0xFFB39DDB), UniqueKey()),
            buildLabeledChild('U-4', const Color(0xFF9FA8DA), UniqueKey()),
          ],
        ),
        const SizedBox(height: 6.0),
        buildCaption(
          'First row uses ValueKey<String> with stable labels — those keys '
          'are == across rebuilds. Second row uses UniqueKey — each rebuild '
          'changes the key, so the framework treats them as new widgets.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 — Anti-patterns: good vs bad uses of Key.
// ---------------------------------------------------------------------------
Widget buildSection10AntiPatterns() {
  return buildPanelShell(
    title: '10. Anti-patterns — good vs bad',
    subtitle:
        'Keys cost nothing when used right and cause subtle bugs when misused. '
        'Here are the canonical mistakes vs their good counterparts.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildGoodBadCard(
          title: "Same UniqueKey reused on multiple children",
          verdict: "Flutter throws 'multiple widgets used the same GlobalKey' "
              "if it's a GlobalKey, and the LocalKey version causes both "
              "subtrees to be treated as one — state goes to the first match.",
          good: false,
          snippet:
              'final k = UniqueKey();\n'
              'return Column(children: [\n'
              '  TileA(key: k),\n'
              '  TileB(key: k), // BAD: same key, two children\n'
              ']);',
          why:
              'Keys must be unique among siblings of the same parent. '
              'Use a new key per child.',
        ),
        buildGoodBadCard(
          title: "Distinct ValueKeys per item id",
          verdict: "Correct. Each child has a stable, unique key tied to its "
              "data id.",
          good: true,
          snippet:
              'children: items\n'
              '    .map((t) => Tile(key: ValueKey(t.id), todo: t))\n'
              '    .toList(),',
          why:
              "Stable id => same key across rebuilds => Flutter preserves the "
              "matching Element and its State.",
        ),
        buildGoodBadCard(
          title: "ValueKey('') for every item",
          verdict: "All items collide on the empty-string key. Reorder/insert "
              "behavior becomes effectively unkeyed (or worse, depending on "
              "framework version).",
          good: false,
          snippet:
              "children: items\n"
              "    .map((t) => Tile(key: ValueKey(''), todo: t))\n"
              "    .toList(),",
          why:
              'A "constant" key for many siblings defeats the purpose of '
              'having keys at all. Make the key vary per logical item.',
        ),
        buildGoodBadCard(
          title: "UniqueKey() recreated every build",
          verdict: "Every rebuild produces a fresh UniqueKey, so Flutter "
              "tears down and reconstructs the subtree. State is lost on "
              "every frame.",
          good: false,
          snippet:
              "Widget build(ctx) {\n"
              "  return MyTile(key: UniqueKey(), ...); // BAD\n"
              "}",
          why:
              'If you intend stability, lift the UniqueKey out of build, or '
              'use ValueKey of a stable id instead.',
        ),
        buildGoodBadCard(
          title: "GlobalKey declared at module scope",
          verdict: "Stable across rebuilds, debugLabel makes errors easier "
              "to trace.",
          good: true,
          snippet:
              "final kFormKey = GlobalKey<FormState>(debugLabel: 'login-form');\n"
              "// later, inside build():\n"
              "Form(key: kFormKey, child: ...);",
          why:
              'GlobalKeys MUST keep the same identity across rebuilds. '
              "Module scope or a long-lived owner is the right place.",
        ),
        buildGoodBadCard(
          title: "GlobalKey created inside build()",
          verdict: "Each frame allocates a new GlobalKey, so currentState "
              "is always the freshly mounted one or null. Common cause of "
              '"why is currentState null?" bugs.',
          good: false,
          snippet:
              "Widget build(ctx) {\n"
              "  final k = GlobalKey<FormState>(); // BAD: new each build\n"
              "  return Form(key: k, ...);\n"
              "}",
          why:
              'A GlobalKey created in build cannot bridge frames. Hoist it '
              'out, or replace it with a Builder + Form.of(context).',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 11 — Decision table: which key when.
// ---------------------------------------------------------------------------
Widget buildDecisionRow({
  required String keyType,
  required String useWhen,
  required String equality,
  required String scope,
  Color rowColor = Colors.white,
}) {
  return Container(
    decoration: BoxDecoration(
      color: rowColor,
      border: Border(bottom: BorderSide(color: kPanelBorder)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            keyType,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              color: kAccent,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            useWhen,
            style: const TextStyle(fontSize: 12.0, color: Color(0xFF1B2440)),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            equality,
            style: const TextStyle(fontSize: 12.0, color: Color(0xFF1B2440)),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            scope,
            style: const TextStyle(
              fontSize: 12.0,
              color: kMuted,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDecisionHeader() {
  return Container(
    color: const Color(0xFF1B2440),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: Row(
      children: const <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            'Key type',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Use when',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Equality',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Scope',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSection11Decision() {
  return buildPanelShell(
    title: '11. Decision table — pick the right key',
    subtitle:
        'A quick reference of the entire Key family with their typical use '
        'cases, equality semantics, and scope.',
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: kPanelBorder),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          buildDecisionHeader(),
          buildDecisionRow(
            keyType: 'ValueKey<T>',
            useWhen:
                'You have a stable id (string, int) per list item; you want '
                'state to follow the id through reorders.',
            equality: 'Equal when wrapped value is ==',
            scope: 'Local',
            rowColor: const Color(0xFFFAFBFE),
          ),
          buildDecisionRow(
            keyType: 'ObjectKey',
            useWhen:
                'Identity of the item IS the object reference (you carry the '
                'same instance around).',
            equality: 'Equal only for same instance (identical)',
            scope: 'Local',
          ),
          buildDecisionRow(
            keyType: 'UniqueKey',
            useWhen:
                'You want to force a NEW Element/State; e.g. swap implementations '
                'and explicitly discard the previous subtree.',
            equality: 'Never equal to anything but itself',
            scope: 'Local',
            rowColor: const Color(0xFFFAFBFE),
          ),
          buildDecisionRow(
            keyType: 'PageStorageKey<T>',
            useWhen:
                'Persist scroll position (or any PageStorage-stored value) '
                'across rebuilds and route swaps.',
            equality: 'Like ValueKey but used by PageStorage bucket',
            scope: 'Local',
          ),
          buildDecisionRow(
            keyType: 'GlobalKey',
            useWhen:
                'You need .currentState / .currentContext from outside the '
                'subtree; e.g. validate a Form, openDrawer().',
            equality: 'Identity-based; one widget at a time',
            scope: 'Global',
            rowColor: const Color(0xFFFAFBFE),
          ),
          buildDecisionRow(
            keyType: 'GlobalKey<T extends State>',
            useWhen:
                'Same as GlobalKey but typed to a specific State subclass '
                '(FormState, ScaffoldState, NavigatorState, ...).',
            equality: 'Identity-based',
            scope: 'Global',
          ),
          buildDecisionRow(
            keyType: 'LabeledGlobalKey<T>',
            useWhen:
                'Like GlobalKey<T> but with a human-readable debugLabel for '
                'easier debugging.',
            equality: 'Identity-based',
            scope: 'Global',
            rowColor: const Color(0xFFFAFBFE),
          ),
          buildDecisionRow(
            keyType: 'GlobalObjectKey',
            useWhen:
                'You already have a long-lived domain object you can use as '
                'natural identity for a global handle.',
            equality: 'Identity of wrapped object',
            scope: 'Global',
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 12 — Closing recap: the why, in one panel.
// ---------------------------------------------------------------------------
Widget buildSection12Recap() {
  return buildPanelShell(
    title: '12. Recap — why widgets need identity beyond runtimeType',
    subtitle:
        'A widget tree is rebuilt every frame. The framework needs a way to '
        'decide whether each new Widget instance corresponds to the SAME '
        'logical thing as before, so it can keep Elements (and State) alive.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kPanelBorder),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Rule of reconciliation:',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1B2440),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                "An Element keeps its child Element if the new Widget's "
                'runtimeType AND key match the old one. Otherwise it disposes '
                'the child and inflates a new one.',
                style: TextStyle(fontSize: 12.5, color: Color(0xFF1B2440)),
              ),
              SizedBox(height: 8.0),
              Text(
                'Without keys, that match is positional. With keys, the match '
                'is keyed — the SAME logical widget can move around in its '
                'parent and still retain its Element + State.',
                style: TextStyle(fontSize: 12.5, color: Color(0xFF1B2440)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        buildCaption(
          'TL;DR: Use a key whenever Flutter cannot tell two same-typed '
          'siblings apart on its own AND you care about preserving their '
          'state through changes in order or structure.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('Key test executing — deep visual demo');

  // Touch a few values so the test output mentions them explicitly.
  final ValueKey<String> sampleValueKey = const ValueKey<String>('sample');
  final UniqueKey sampleUniqueKey = UniqueKey();
  final ObjectKey sampleObjectKey = ObjectKey(kTodoList[0]);
  final PageStorageKey<String> samplePageStorageKey =
      const PageStorageKey<String>('sample-scroll');

  print('sampleValueKey      : $sampleValueKey');
  print('sampleUniqueKey     : $sampleUniqueKey');
  print('sampleObjectKey     : $sampleObjectKey');
  print('samplePageStorageKey: $samplePageStorageKey');
  print('kFormGlobalKey      : $kFormGlobalKey');
  print('kFindableContainerKey: $kFindableContainerKey');
  print('kLabeledStateKey    : $kLabeledStateKey');
  print('kProfileGlobalObjectKey: $kProfileGlobalObjectKey');

  final Widget header = Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF1B2440), Color(0xFF2D6CDF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Flutter Key family — visual deep-dive',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Key, ValueKey<T>, ObjectKey, UniqueKey, PageStorageKey, GlobalKey, '
          'LabeledGlobalKey, GlobalObjectKey',
          style: TextStyle(fontSize: 12.5, color: Color(0xFFD9E5FA)),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            buildBadge('LocalKey', bg: const Color(0xFFD9E5FA), fg: kAccent),
            const SizedBox(width: 6.0),
            buildBadge('GlobalKey', bg: const Color(0xFFFFE3B0), fg: const Color(0xFF8A5A00)),
            const SizedBox(width: 6.0),
            buildBadge('PageStorage', bg: const Color(0xFFCFEFD9), fg: kGood),
          ],
        ),
      ],
    ),
  );

  // Stash a Container under the findable global key so it has a current
  // element when looked up. (No setState / no observer required — we just
  // wire it into the tree once per build.)
  final Container findable = Container(
    key: kFindableContainerKey,
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      border: Border.all(color: const Color(0xFFB26A00)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      'Findable Container attached under kFindableContainerKey '
      '(${kFindableContainerKey.toString()}). Anywhere in your app you can do '
      'kFindableContainerKey.currentContext to grab this element.',
      style: const TextStyle(fontSize: 12.5, color: Color(0xFF1B2440)),
    ),
  );

  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          header,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                findable,
                buildSection1Anatomy(),
                buildSection2Trio(),
                buildSection3ValueKeyIdentity(),
                buildSection4ObjectKeyIdentity(),
                buildSection5PageStorage(),
                buildSection6GlobalKey(),
                buildSection7GlobalObjectKey(),
                buildSection8Reorder(),
                buildSection9Collection(),
                buildSection10AntiPatterns(),
                buildSection11Decision(),
                buildSection12Recap(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
