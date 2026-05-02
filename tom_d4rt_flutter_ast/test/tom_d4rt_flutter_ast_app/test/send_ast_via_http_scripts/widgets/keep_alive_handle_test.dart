// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════════════════════════════════
//  KeepAliveHandle — deep demo
// ----------------------------------------------------------------------------
//  This file is the harness companion to the AutomaticKeepAliveClientMixin
//  demo (see widgets/automatic_keep_alive_client_mixin_test.dart). The mixin
//  demo focuses on the high-level pattern of mixing
//  AutomaticKeepAliveClientMixin into a State; here we focus on the underlying
//  KeepAliveHandle object — the Listenable that the mixin (or any widget)
//  hands to its ancestor AutomaticKeepAlive via KeepAliveNotification, and
//  which is later released to release the keep-alive request.
//
//  KeepAliveHandle is a public part of `package:flutter/widgets.dart`. It is
//  a Listenable (in modern Flutter, a ChangeNotifier subclass) whose
//  dispose() override calls notifyListeners() before tearing the notifier
//  down. The "release" signal is therefore implemented as dispose():
//  ancestors that listen for keep-alive get a single notification and then
//  the handle is gone. Lifecycle, in normal use, is:
//
//      handle = KeepAliveHandle();
//      KeepAliveNotification(handle).dispatch(context);
//      // ancestor AutomaticKeepAlive listens on handle
//      // …
//      handle.dispose();   // notifies listeners → ancestor releases slot
//
//  The high-level mixin owns the handle for you. But understanding the raw
//  handle is useful for:
//
//    * Custom keep-alive widgets that don't want the mixin's defaults
//    * Diagnostic widgets that listen to a handle to visualise its state
//    * Tests that simulate keep-alive without a full slot list
//    * Educational walkthroughs of how the protocol works
//
//  Section index (this file ships ≈ 1900 hand-authored lines):
//
//    1.  Anatomy of KeepAliveHandle (what it is, fields, family tree)
//    2.  Lifecycle diagram (create → dispatch → listen → release)
//    3.  Manual KeepAliveHandle() + KeepAliveNotification.dispatch()
//    4.  Handle-listener inspector (custom widget listens to a handle)
//    5.  PageView preservation: kept-alive vs not (mixin-driven)
//    6.  TabBarView state inspector (counter, scroll, text field)
//    7.  Sparse ListView with conditional wantKeepAlive
//    8.  Explicit release() simulation
//    9.  Comparison vs Provider / InheritedWidget for state preservation
//   10.  Recipe gallery (form drafts, video position, expensive widget)
//   11.  Pitfalls (forgetting super.build, leaks, dispose order)
//   12.  Handle-vs-mixin contrast table
//   13.  KeepAliveHandle members reference table
//   14.  Closing notes & companion files
//
//  All Flutter widgets used here come from package:flutter/material.dart;
//  no extra imports are required for the demo to compile.
// ════════════════════════════════════════════════════════════════════════════

// ── Top-level state holders ───────────────────────────────────────────────
//
// The harness `build` is a function (not a State), so persistent demo state
// lives in top-level ValueNotifiers. Real apps would scope these to a State
// or a controller.
final ValueNotifier<int> _pageIndex = ValueNotifier<int>(0);
final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);
final ValueNotifier<bool> _holdPage1 = ValueNotifier<bool>(true);
final ValueNotifier<bool> _holdTab1 = ValueNotifier<bool>(true);
final ValueNotifier<bool> _holdTab2 = ValueNotifier<bool>(true);
final ValueNotifier<bool> _holdSparseEven = ValueNotifier<bool>(true);
final ValueNotifier<int> _manualReleaseTick = ValueNotifier<int>(0);
final ValueNotifier<int> _manualDispatchTick = ValueNotifier<int>(0);
final ValueNotifier<String> _lastHandleEvent =
    ValueNotifier<String>('(no handle events yet)');

// ── Top-level entry point required by the harness ─────────────────────────
dynamic build(BuildContext context) {
  return const _KeepAliveHandleDemoApp();
}

// ══════════════════════════════════════════════════════════════════════════
//  Root MaterialApp
// ══════════════════════════════════════════════════════════════════════════
class _KeepAliveHandleDemoApp extends StatelessWidget {
  const _KeepAliveHandleDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeepAliveHandle deep demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        cardTheme: const CardThemeData(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        ),
      ),
      home: const _KeepAliveHandleDemoScaffold(),
    );
  }
}

class _KeepAliveHandleDemoScaffold extends StatelessWidget {
  const _KeepAliveHandleDemoScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeepAliveHandle — deep demo'),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _Section1AnatomyCard(),
              _Section2LifecycleCard(),
              _Section3ManualHandleCard(),
              _Section4HandleInspectorCard(),
              _Section5PageViewCard(),
              _Section6TabBarViewCard(),
              _Section7SparseListCard(),
              _Section8ReleaseSimulationCard(),
              _Section9VsProviderCard(),
              _Section10RecipeGalleryCard(),
              _Section11PitfallsCard(),
              _Section12HandleVsMixinTable(),
              _Section13ReferenceTable(),
              _Section14ClosingNotes(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Reusable visual primitives
// ══════════════════════════════════════════════════════════════════════════
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.number, this.title, this.subtitle);

  final int number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine(this.text, {this.icon = Icons.circle, this.size = 8});

  final String text;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 8),
            child: Icon(icon, size: size, color: Colors.indigo),
          ),
          Expanded(child: Text(text)),
        ],
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
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFFD0D7E2),
          height: 1.35,
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip(this.label, this.value, {this.color = Colors.indigo});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        border: Border.all(color: color.withOpacity(.40)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 11, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.header, required this.body});

  final Widget header;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            header,
            const SizedBox(height: 6),
            body,
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 1 — Anatomy of KeepAliveHandle
// ══════════════════════════════════════════════════════════════════════════
class _Section1AnatomyCard extends StatelessWidget {
  const _Section1AnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        1,
        'Anatomy of KeepAliveHandle',
        'A Listenable carried inside KeepAliveNotification.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _BulletLine(
            'KeepAliveHandle is a public type from package:flutter/widgets.dart.',
          ),
          _BulletLine(
            'It implements Listenable; in modern Flutter it extends ChangeNotifier.',
          ),
          _BulletLine(
            'A KeepAliveNotification is constructed with a handle: '
            'KeepAliveNotification(handle).',
          ),
          _BulletLine(
            'The notification bubbles up to the nearest AutomaticKeepAlive, '
            'which retains the slot until handle notifies (release).',
          ),
          _BulletLine(
            'release() calls notifyListeners() and disposes the handle so it '
            'cannot be reused.',
          ),
          SizedBox(height: 6),
          _CodeBlock(
            'final KeepAliveHandle handle = KeepAliveHandle();\n'
            'KeepAliveNotification(handle).dispatch(context);\n'
            '// ancestor AutomaticKeepAlive listens to the handle\n'
            'handle.release(); // notifies listeners and disposes',
          ),
          SizedBox(height: 6),
          Text(
            'Family tree',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          _BulletLine(
            'Listenable → ChangeNotifier → KeepAliveHandle.',
            icon: Icons.account_tree_outlined,
            size: 14,
          ),
          _BulletLine(
            'Notification → KeepAliveNotification(handle).',
            icon: Icons.account_tree_outlined,
            size: 14,
          ),
          _BulletLine(
            'StatefulWidget → State<T> + AutomaticKeepAliveClientMixin<T> '
            '(uses a private handle internally).',
            icon: Icons.account_tree_outlined,
            size: 14,
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 2 — Lifecycle diagram
// ══════════════════════════════════════════════════════════════════════════
class _Section2LifecycleCard extends StatelessWidget {
  const _Section2LifecycleCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        2,
        'Lifecycle diagram',
        'create → dispatch → listen → release.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _LifecycleArrow('① CREATE',
              'KeepAliveHandle handle = KeepAliveHandle();'),
          _LifecycleArrow('② DISPATCH',
              'KeepAliveNotification(handle).dispatch(context);'),
          _LifecycleArrow('③ LISTEN',
              'AutomaticKeepAlive ancestor calls handle.addListener(_onRelease);'),
          _LifecycleArrow('④ HOLD',
              'Slot is preserved across viewport scrolls / page swaps.'),
          _LifecycleArrow('⑤ RELEASE',
              'handle.release() → notifyListeners() → disposes handle.'),
          _LifecycleArrow('⑥ DROP',
              'Ancestor removes its listener, slot becomes evictable again.'),
          SizedBox(height: 8),
          Text(
            'Notes:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          _BulletLine(
            'A handle can only be released once; release() is effectively a '
            'one-shot notification.',
          ),
          _BulletLine(
            'AutomaticKeepAliveClientMixin manages handle creation and release '
            'for you whenever wantKeepAlive flips.',
          ),
          _BulletLine(
            'Always call super.build(context) first in build() of states that '
            'use the mixin, otherwise the mixin will not register.',
          ),
        ],
      ),
    );
  }
}

class _LifecycleArrow extends StatelessWidget {
  const _LifecycleArrow(this.tag, this.text);

  final String tag;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(.10),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 3 — Manual KeepAliveHandle() + dispatch()
// ══════════════════════════════════════════════════════════════════════════
//
//  This section uses a Builder to obtain a non-root BuildContext and
//  dispatches a real KeepAliveNotification(handle) through it. There is no
//  AutomaticKeepAlive ancestor below this card (it lives in a Column inside
//  a SingleChildScrollView), so nothing visible "stays alive" — the point
//  is to show the call shape and that it does not throw.
//
class _Section3ManualHandleCard extends StatelessWidget {
  const _Section3ManualHandleCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        3,
        'Manual KeepAliveHandle() and KeepAliveNotification',
        'Construct a handle by hand and dispatch the notification.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _BulletLine(
            'In real apps the mixin owns the handle. Here we own it directly '
            'to demonstrate the API surface.',
          ),
          const _CodeBlock(
            'final KeepAliveHandle handle = KeepAliveHandle();\n'
            'handle.addListener(() => print("released"));\n'
            'KeepAliveNotification(handle).dispatch(context);\n'
            '// later …\n'
            'handle.release();',
          ),
          const SizedBox(height: 6),
          Builder(
            builder: (BuildContext innerContext) {
              return Row(
                children: <Widget>[
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send_outlined),
                    label: const Text('Dispatch KeepAliveNotification'),
                    onPressed: () {
                      final KeepAliveHandle handle = KeepAliveHandle();
                      handle.addListener(() {
                        _lastHandleEvent.value =
                            'manual handle released @ '
                            '${DateTime.now().toIso8601String()}';
                      });
                      KeepAliveNotification(handle).dispatch(innerContext);
                      _manualDispatchTick.value =
                          _manualDispatchTick.value + 1;
                      // Immediately release for demo purposes; in real use
                      // the ancestor would hold the listener until the
                      // subtree no longer needs to be kept alive.
                      handle.dispose();
                      _manualReleaseTick.value =
                          _manualReleaseTick.value + 1;
                    },
                  ),
                  const SizedBox(width: 12),
                  ValueListenableBuilder<int>(
                    valueListenable: _manualDispatchTick,
                    builder: (BuildContext _, int v, Widget? _) {
                      return _StatusChip('dispatched', '$v');
                    },
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: _manualReleaseTick,
                    builder: (BuildContext _, int v, Widget? _) {
                      return _StatusChip(
                        'released',
                        '$v',
                        color: Colors.deepOrange,
                      );
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 4),
          ValueListenableBuilder<String>(
            valueListenable: _lastHandleEvent,
            builder: (BuildContext _, String s, Widget? _) {
              return Text(
                s,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 4 — Handle-listener inspector
// ══════════════════════════════════════════════════════════════════════════
//
//  A custom widget that owns a KeepAliveHandle, listens to it, and renders
//  a "released?" state. This is the most basic possible custom keep-alive
//  client.
//
class _Section4HandleInspectorCard extends StatelessWidget {
  const _Section4HandleInspectorCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        4,
        'Handle-listener inspector',
        'A widget that owns a handle and shows whether it was released.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _BulletLine(
            'The inspector creates one KeepAliveHandle in initState() and '
            'attaches an addListener callback.',
          ),
          _BulletLine(
            'Pressing "release" calls handle.release(). The listener fires '
            'once and updates the visible status.',
          ),
          SizedBox(height: 8),
          _HandleInspector(label: 'Inspector A'),
          SizedBox(height: 6),
          _HandleInspector(label: 'Inspector B'),
        ],
      ),
    );
  }
}

class _HandleInspector extends StatefulWidget {
  const _HandleInspector({required this.label});

  final String label;

  @override
  State<_HandleInspector> createState() => _HandleInspectorState();
}

class _HandleInspectorState extends State<_HandleInspector> {
  KeepAliveHandle? _handle;
  bool _released = false;
  int _notifyCount = 0;

  void _ensureHandle() {
    if (_handle == null) {
      final KeepAliveHandle h = KeepAliveHandle();
      h.addListener(_onNotify);
      _handle = h;
      _released = false;
    }
  }

  void _onNotify() {
    if (!mounted) return;
    setState(() {
      _notifyCount += 1;
      _released = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _ensureHandle();
  }

  @override
  void dispose() {
    final h = _handle;
    if (h != null && !_released) {
      // KeepAliveHandle.dispose() notifies listeners; that is the public
      // release signal. Detach our listener first so we do not setState
      // after this State has already been disposed.
      h.removeListener(_onNotify);
      h.dispose();
    }
    super.dispose();
  }

  void _doRelease() {
    final h = _handle;
    if (h == null || _released) return;
    // dispose() on a KeepAliveHandle fires notifyListeners() once and then
    // tears the notifier down; this is the canonical "release" signal.
    h.dispose();
  }

  void _renew() {
    final old = _handle;
    if (old != null && !_released) {
      old.removeListener(_onNotify);
      old.dispose();
    }
    setState(() {
      _handle = null;
      _notifyCount = 0;
      _released = false;
    });
    _ensureHandle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo.withOpacity(.30)),
        borderRadius: BorderRadius.circular(6),
        color: Colors.indigo.withOpacity(.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                widget.label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              _StatusChip(
                'state',
                _released ? 'released' : 'live',
                color: _released ? Colors.deepOrange : Colors.green,
              ),
              _StatusChip('notifications', '$_notifyCount'),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: <Widget>[
              ElevatedButton(
                onPressed: _released ? null : _doRelease,
                child: const Text('release()'),
              ),
              OutlinedButton(
                onPressed: _renew,
                child: const Text('renew handle'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 5 — PageView preservation
// ══════════════════════════════════════════════════════════════════════════
//
//  Two pages inside a PageView. One mixes AutomaticKeepAliveClientMixin and
//  always returns wantKeepAlive=true; the other does not. Swiping between
//  the pages and back shows that the kept-alive page preserves a counter,
//  scroll offset, and a TextField, while the non-kept-alive page resets.
//
class _Section5PageViewCard extends StatelessWidget {
  const _Section5PageViewCard();

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return _DemoCard(
      header: const _SectionHeader(
        5,
        'PageView: kept-alive vs not',
        'Swipe across pages and notice which counters / scroll persist.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _BulletLine(
            'Page 1 mixes AutomaticKeepAliveClientMixin → state survives.',
          ),
          const _BulletLine(
            'Page 2 does not mix it in → state is rebuilt every time.',
          ),
          const _BulletLine(
            'wantKeepAlive can be toggled live to demonstrate handle '
            'release behaviour for page 1.',
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<bool>(
            valueListenable: _holdPage1,
            builder: (BuildContext _, bool hold1, Widget? _) {
              return Row(
                children: <Widget>[
                  const Text('Page 1 wantKeepAlive: '),
                  Switch(
                    value: hold1,
                    onChanged: (bool v) => _holdPage1.value = v,
                  ),
                  const SizedBox(width: 16),
                  ValueListenableBuilder<int>(
                    valueListenable: _pageIndex,
                    builder: (BuildContext _, int idx, Widget? _) {
                      return _StatusChip('page', '$idx');
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 320,
            child: PageView(
              controller: controller,
              onPageChanged: (int i) => _pageIndex.value = i,
              children: <Widget>[
                ValueListenableBuilder<bool>(
                  valueListenable: _holdPage1,
                  builder: (BuildContext _, bool hold, Widget? _) {
                    return _KeepAlivePage(
                      title: 'Page 1 (kept alive)',
                      keepAlive: hold,
                      color: Colors.indigo.shade50,
                    );
                  },
                ),
                const _PlainPage(
                  title: 'Page 2 (not kept alive)',
                  color: Color(0xFFFFF3E0),
                ),
                const _KeepAlivePage(
                  title: 'Page 3 (kept alive)',
                  keepAlive: true,
                  color: Color(0xFFE8F5E9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Kept-alive page ───────────────────────────────────────────────────────
class _KeepAlivePage extends StatefulWidget {
  const _KeepAlivePage({
    required this.title,
    required this.keepAlive,
    required this.color,
  });

  final String title;
  final bool keepAlive;
  final Color color;

  @override
  State<_KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin<_KeepAlivePage> {
  int _counter = 0;
  final ScrollController _scroll = ScrollController();
  final TextEditingController _text = TextEditingController();

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void dispose() {
    _scroll.dispose();
    _text.dispose();
    super.dispose();
  }

  void _bump() {
    setState(() {
      _counter += 1;
    });
    updateKeepAlive();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // mandatory when using AutomaticKeepAliveClientMixin
    return Container(
      color: widget.color,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'wantKeepAlive: ${widget.keepAlive}',
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: _bump,
                child: const Text('counter++'),
              ),
              const SizedBox(width: 12),
              Text('counter = $_counter'),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _text,
            decoration: const InputDecoration(
              labelText: 'TextField (preserved if kept alive)',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              itemCount: 80,
              itemBuilder: (BuildContext _, int i) {
                return ListTile(
                  dense: true,
                  leading: const Icon(Icons.bookmark_border),
                  title: Text('row $i'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Plain (non-kept-alive) page ───────────────────────────────────────────
class _PlainPage extends StatefulWidget {
  const _PlainPage({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<_PlainPage> createState() => _PlainPageState();
}

class _PlainPageState extends State<_PlainPage> {
  int _counter = 0;
  final ScrollController _scroll = ScrollController();
  final TextEditingController _text = TextEditingController();

  @override
  void dispose() {
    _scroll.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'no AutomaticKeepAliveClientMixin → state resets every time',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => setState(() => _counter += 1),
                child: const Text('counter++'),
              ),
              const SizedBox(width: 12),
              Text('counter = $_counter'),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _text,
            decoration: const InputDecoration(
              labelText: 'TextField (lost on swipe)',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              itemCount: 80,
              itemBuilder: (BuildContext _, int i) {
                return ListTile(
                  dense: true,
                  leading: const Icon(Icons.delete_sweep_outlined),
                  title: Text('row $i'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 6 — TabBarView state inspector
// ══════════════════════════════════════════════════════════════════════════
class _Section6TabBarViewCard extends StatelessWidget {
  const _Section6TabBarViewCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        6,
        'TabBarView state inspector',
        'Three tabs; toggle wantKeepAlive on tabs 1 and 2 live.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _BulletLine(
            'Tabs are textbook keep-alive use cases — TabBarView lazily '
            'builds children and AutomaticKeepAlive owns the slots.',
          ),
          _BulletLine(
            'Toggling wantKeepAlive=false simulates the handle being '
            'released; toggling it back to true causes a new handle to be '
            'created and dispatched on the next build.',
          ),
          SizedBox(height: 8),
          _TabsDemo(),
        ],
      ),
    );
  }
}

class _TabsDemo extends StatefulWidget {
  const _TabsDemo();

  @override
  State<_TabsDemo> createState() => _TabsDemoState();
}

class _TabsDemoState extends State<_TabsDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tab = TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    _tab.addListener(() {
      _tabIndex.value = _tab.index;
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tab,
          labelColor: Colors.indigo,
          tabs: const <Widget>[
            Tab(text: 'tab 1 (counter)'),
            Tab(text: 'tab 2 (scroll)'),
            Tab(text: 'tab 3 (text)'),
          ],
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _holdTab1,
          builder: (BuildContext _, bool h1, Widget? _) {
            return ValueListenableBuilder<bool>(
              valueListenable: _holdTab2,
              builder: (BuildContext _, bool h2, Widget? _) {
                return Wrap(
                  spacing: 12,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('tab1 keep: '),
                        Switch(
                          value: h1,
                          onChanged: (bool v) => _holdTab1.value = v,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('tab2 keep: '),
                        Switch(
                          value: h2,
                          onChanged: (bool v) => _holdTab2.value = v,
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
        SizedBox(
          height: 280,
          child: TabBarView(
            controller: _tab,
            children: <Widget>[
              ValueListenableBuilder<bool>(
                valueListenable: _holdTab1,
                builder: (BuildContext _, bool keep, Widget? _) {
                  return _KeepAliveCounter(keepAlive: keep);
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _holdTab2,
                builder: (BuildContext _, bool keep, Widget? _) {
                  return _KeepAliveScroller(keepAlive: keep);
                },
              ),
              const _KeepAliveTextField(keepAlive: true),
            ],
          ),
        ),
      ],
    );
  }
}

// ── _KeepAliveCounter ────────────────────────────────────────────────────
class _KeepAliveCounter extends StatefulWidget {
  const _KeepAliveCounter({required this.keepAlive});

  final bool keepAlive;

  @override
  State<_KeepAliveCounter> createState() => _KeepAliveCounterState();
}

class _KeepAliveCounterState extends State<_KeepAliveCounter>
    with AutomaticKeepAliveClientMixin<_KeepAliveCounter> {
  int _counter = 0;
  int _builds = 0;

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void didUpdateWidget(_KeepAliveCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _builds += 1;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Tab 1 — counter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('builds=$_builds  keepAlive=${widget.keepAlive}'),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => setState(() => _counter += 1),
                child: const Text('counter++'),
              ),
              const SizedBox(width: 12),
              Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Switch tabs and come back: counter persists when keep is on.',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// ── _KeepAliveScroller ────────────────────────────────────────────────────
class _KeepAliveScroller extends StatefulWidget {
  const _KeepAliveScroller({required this.keepAlive});

  final bool keepAlive;

  @override
  State<_KeepAliveScroller> createState() => _KeepAliveScrollerState();
}

class _KeepAliveScrollerState extends State<_KeepAliveScroller>
    with AutomaticKeepAliveClientMixin<_KeepAliveScroller> {
  final ScrollController _scroll = ScrollController();

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void didUpdateWidget(_KeepAliveScroller oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Tab 2 — scroll position',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('keepAlive=${widget.keepAlive}'),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              itemCount: 200,
              itemBuilder: (BuildContext _, int i) => ListTile(
                dense: true,
                leading: CircleAvatar(child: Text('$i')),
                title: Text('Item $i'),
                subtitle:
                    Text('Scroll, then change tab; offset survives if kept.'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── _KeepAliveTextField ───────────────────────────────────────────────────
class _KeepAliveTextField extends StatefulWidget {
  const _KeepAliveTextField({required this.keepAlive});

  final bool keepAlive;

  @override
  State<_KeepAliveTextField> createState() => _KeepAliveTextFieldState();
}

class _KeepAliveTextFieldState extends State<_KeepAliveTextField>
    with AutomaticKeepAliveClientMixin<_KeepAliveTextField> {
  final TextEditingController _draft = TextEditingController();

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void dispose() {
    _draft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Tab 3 — text field',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _draft,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'draft',
              hintText: 'switch tabs — text survives',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 7 — Sparse ListView with conditional wantKeepAlive
// ══════════════════════════════════════════════════════════════════════════
class _Section7SparseListCard extends StatelessWidget {
  const _Section7SparseListCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        7,
        'Sparse ListView with conditional wantKeepAlive',
        'Only even rows keep their state; odd rows recycle.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder<bool>(
            valueListenable: _holdSparseEven,
            builder: (BuildContext _, bool keepEven, Widget? _) {
              return Row(
                children: <Widget>[
                  const Text('keep even rows: '),
                  Switch(
                    value: keepEven,
                    onChanged: (bool v) => _holdSparseEven.value = v,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 360,
            child: ValueListenableBuilder<bool>(
              valueListenable: _holdSparseEven,
              builder: (BuildContext _, bool keepEven, Widget? _) {
                return ListView.builder(
                  itemCount: 60,
                  itemBuilder: (BuildContext _, int i) {
                    final bool keepThis = keepEven && (i % 2 == 0);
                    return _SparseRow(
                      index: i,
                      keepAlive: keepThis,
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Scroll up and down; only the rows where keepAlive=true preserve '
            'their counter.',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _SparseRow extends StatefulWidget {
  const _SparseRow({required this.index, required this.keepAlive});

  final int index;
  final bool keepAlive;

  @override
  State<_SparseRow> createState() => _SparseRowState();
}

class _SparseRowState extends State<_SparseRow>
    with AutomaticKeepAliveClientMixin<_SparseRow> {
  int _local = 0;

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void didUpdateWidget(_SparseRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.keepAlive
            ? Colors.green.withOpacity(.06)
            : Colors.grey.withOpacity(.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: widget.keepAlive
              ? Colors.green.withOpacity(.3)
              : Colors.grey.withOpacity(.3),
        ),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 14,
            backgroundColor:
                widget.keepAlive ? Colors.green : Colors.grey.shade500,
            child: Text(
              '${widget.index}',
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'row ${widget.index}  '
              'keep=${widget.keepAlive}  '
              'local=$_local',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => setState(() => _local += 1),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 8 — Explicit release() simulation
// ══════════════════════════════════════════════════════════════════════════
class _Section8ReleaseSimulationCard extends StatelessWidget {
  const _Section8ReleaseSimulationCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        8,
        'Explicit release() simulation',
        'Drive a handle by hand and watch listeners fire.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _BulletLine(
            'release() is a one-shot operation; calling it after the handle '
            'has already fired is invalid.',
          ),
          _BulletLine(
            'Each "renew" creates a fresh KeepAliveHandle so subsequent '
            'releases work again.',
          ),
          SizedBox(height: 8),
          _ReleaseSim(),
        ],
      ),
    );
  }
}

class _ReleaseSim extends StatefulWidget {
  const _ReleaseSim();

  @override
  State<_ReleaseSim> createState() => _ReleaseSimState();
}

class _ReleaseSimState extends State<_ReleaseSim> {
  KeepAliveHandle? _handle;
  bool _released = false;
  int _listenerHits = 0;
  String _log = '(no events)';

  @override
  void initState() {
    super.initState();
    _make();
  }

  void _make() {
    final KeepAliveHandle h = KeepAliveHandle();
    h.addListener(_onFire);
    _handle = h;
    _released = false;
    _listenerHits = 0;
    _log = 'created handle';
  }

  void _onFire() {
    if (!mounted) return;
    setState(() {
      _listenerHits += 1;
      _released = true;
      _log = 'listener fired (hits=$_listenerHits)';
    });
  }

  void _release() {
    final h = _handle;
    if (h == null || _released) {
      setState(() => _log = 'cannot release: handle is already released');
      return;
    }
    // The "release" signal is implemented as KeepAliveHandle.dispose() in
    // current Flutter — it fires notifyListeners() and tears down.
    h.dispose();
  }

  void _renew() {
    final h = _handle;
    if (h != null && !_released) {
      h.removeListener(_onFire);
      h.dispose();
    }
    setState(_make);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(.05),
        border: Border.all(color: Colors.deepPurple.withOpacity(.3)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.lock_open),
                label: const Text('release()'),
                onPressed: _released ? null : _release,
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('renew handle'),
                onPressed: _renew,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            children: <Widget>[
              _StatusChip(
                'state',
                _released ? 'released' : 'live',
                color: _released ? Colors.deepOrange : Colors.green,
              ),
              _StatusChip('listener hits', '$_listenerHits'),
            ],
          ),
          Text(
            'log: $_log',
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 9 — Comparison vs Provider / InheritedWidget
// ══════════════════════════════════════════════════════════════════════════
class _Section9VsProviderCard extends StatelessWidget {
  const _Section9VsProviderCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        9,
        'Comparison vs Provider / InheritedWidget',
        'Different jobs that are easy to confuse.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _BulletLine(
            'KeepAliveHandle keeps a SUBTREE alive in a viewport that would '
            'otherwise recycle it. It does not store data.',
          ),
          _BulletLine(
            'Provider / InheritedWidget store data above the subtree. They '
            'survive across rebuilds because the data lives elsewhere.',
          ),
          _BulletLine(
            'Use both together: lifted state for cross-cutting data, keep-'
            'alive for local widget state (controllers, scroll offsets, '
            'in-progress animations).',
          ),
          SizedBox(height: 8),
          _ComparisonTable(),
        ],
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black12),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
      },
      children: const <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: Color(0xFFEDE7F6)),
          children: <Widget>[
            _TblCell('Property', bold: true),
            _TblCell('KeepAliveHandle', bold: true),
            _TblCell('Provider / InheritedWidget', bold: true),
          ],
        ),
        TableRow(children: <Widget>[
          _TblCell('purpose'),
          _TblCell('preserve the State, controllers, scroll, etc.'),
          _TblCell('share data above a subtree'),
        ]),
        TableRow(children: <Widget>[
          _TblCell('storage'),
          _TblCell('stores nothing; just a slot lifeline'),
          _TblCell('owns and exposes the data'),
        ]),
        TableRow(children: <Widget>[
          _TblCell('scope'),
          _TblCell('the keep-alive subtree itself'),
          _TblCell('any descendant of the provider'),
        ]),
        TableRow(children: <Widget>[
          _TblCell('granularity'),
          _TblCell('one slot per handle'),
          _TblCell('any number of consumers'),
        ]),
        TableRow(children: <Widget>[
          _TblCell('release'),
          _TblCell('handle.release() drops keep-alive'),
          _TblCell('parent dispose / rebuild changes data'),
        ]),
      ],
    );
  }
}

class _TblCell extends StatelessWidget {
  const _TblCell(this.text, {this.bold = false});

  final String text;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 10 — Recipe gallery
// ══════════════════════════════════════════════════════════════════════════
class _Section10RecipeGalleryCard extends StatelessWidget {
  const _Section10RecipeGalleryCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        10,
        'Recipe gallery',
        'Common situations where KeepAliveHandle pays off.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _Recipe(
            title: 'Form drafts in a TabBarView',
            body:
                'Each tab hosts a long form with a TextEditingController. '
                'wantKeepAlive=true preserves user input when they switch tabs.',
          ),
          _Recipe(
            title: 'Scroll position in a paged feed',
            body:
                'Each page contains a ListView with its own ScrollController. '
                'Keep-alive ensures that returning to the page lands on the '
                'same item, not at the top.',
          ),
          _Recipe(
            title: 'Video / audio position',
            body:
                'A video player controller is expensive to recreate. Keep the '
                'state alive so playback continues where it stopped when the '
                'user revisits the tab.',
          ),
          _Recipe(
            title: 'Expensive widgets',
            body:
                'A heavy charts widget that runs an animation or fetches data '
                'on initState benefits from being cached via keep-alive.',
          ),
          _Recipe(
            title: 'Conditional keep-alive',
            body:
                'Toggle wantKeepAlive based on whether the form is dirty. The '
                'handle is released automatically when wantKeepAlive flips to '
                'false; updateKeepAlive() forces re-evaluation.',
          ),
        ],
      ),
    );
  }
}

class _Recipe extends StatelessWidget {
  const _Recipe({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(.04),
        border: Border.all(color: Colors.indigo.withOpacity(.20)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 11 — Pitfalls
// ══════════════════════════════════════════════════════════════════════════
class _Section11PitfallsCard extends StatelessWidget {
  const _Section11PitfallsCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        11,
        'Pitfalls',
        'Things that quietly break keep-alive.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _Pitfall(
            title: 'Forgetting super.build(context)',
            body:
                'AutomaticKeepAliveClientMixin overrides build() and expects '
                'subclasses to call super.build first. Skip it and the mixin '
                'never registers; the handle is never dispatched.',
          ),
          _Pitfall(
            title: 'Static wantKeepAlive',
            body:
                'wantKeepAlive is a getter; the mixin reads it on every build. '
                'Cache invalidation is your job — call updateKeepAlive() '
                'whenever the underlying value flips.',
          ),
          _Pitfall(
            title: 'Holding a handle past its release',
            body:
                'release() is a one-shot. Calling addListener / removeListener '
                'after release works on the still-alive ChangeNotifier base, '
                'but a fresh KeepAliveNotification will need a new handle.',
          ),
          _Pitfall(
            title: 'Listener leaks on rebuild',
            body:
                'If you addListener to a handle from outside, remember to '
                'removeListener to avoid retaining the listener after the '
                'subtree is gone.',
          ),
          _Pitfall(
            title: 'Wrong viewport',
            body:
                'KeepAlive only matters under a SliverList / SliverGrid / '
                'PageView / TabBarView etc. — viewports that may unmount '
                'children. In a plain Column there is nothing to keep alive.',
          ),
        ],
      ),
    );
  }
}

class _Pitfall extends StatelessWidget {
  const _Pitfall({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(.04),
        border: Border.all(color: Colors.red.withOpacity(.30)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.warning_amber_rounded,
                  color: Colors.red, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 12 — Handle vs Mixin contrast
// ══════════════════════════════════════════════════════════════════════════
class _Section12HandleVsMixinTable extends StatelessWidget {
  const _Section12HandleVsMixinTable();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        12,
        'Handle vs Mixin contrast',
        'When to drop down to the raw handle.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Table(
            border: TableBorder.all(color: Colors.black12),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: const <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: Color(0xFFE3F2FD)),
                children: <Widget>[
                  _TblCell('Aspect', bold: true),
                  _TblCell('AutomaticKeepAliveClientMixin', bold: true),
                  _TblCell('Raw KeepAliveHandle', bold: true),
                ],
              ),
              TableRow(children: <Widget>[
                _TblCell('owns the handle?'),
                _TblCell('yes — internal _keepAliveHandle'),
                _TblCell('you do'),
              ]),
              TableRow(children: <Widget>[
                _TblCell('boilerplate'),
                _TblCell('one mixin + super.build()'),
                _TblCell('full createState / addListener / dispose'),
              ]),
              TableRow(children: <Widget>[
                _TblCell('updates handle'),
                _TblCell('updateKeepAlive() on flip'),
                _TblCell('release() and re-dispatch by hand'),
              ]),
              TableRow(children: <Widget>[
                _TblCell('use case'),
                _TblCell('default for 99% of widgets'),
                _TblCell('custom keep-alive widgets, diagnostics, tests'),
              ]),
              TableRow(children: <Widget>[
                _TblCell('granularity'),
                _TblCell('one State'),
                _TblCell('any context that can dispatch a notification'),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 13 — Reference table
// ══════════════════════════════════════════════════════════════════════════
class _Section13ReferenceTable extends StatelessWidget {
  const _Section13ReferenceTable();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        13,
        'KeepAliveHandle reference table',
        'Members and related types at a glance.',
      ),
      body: Table(
        border: TableBorder.all(color: Colors.black12),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(3),
        },
        children: const <TableRow>[
          TableRow(
            decoration: BoxDecoration(color: Color(0xFFFFF8E1)),
            children: <Widget>[
              _TblCell('Symbol', bold: true),
              _TblCell('Where', bold: true),
              _TblCell('Notes', bold: true),
            ],
          ),
          TableRow(children: <Widget>[
            _TblCell('KeepAliveHandle'),
            _TblCell('package:flutter/widgets.dart'),
            _TblCell('Listenable; held by KeepAliveNotification.'),
          ]),
          TableRow(children: <Widget>[
            _TblCell('dispose()  (overridden)'),
            _TblCell('KeepAliveHandle'),
            _TblCell('calls notifyListeners() first; the canonical "release" signal.'),
          ]),
          TableRow(children: <Widget>[
            _TblCell('addListener(VoidCallback)'),
            _TblCell('inherited from ChangeNotifier'),
            _TblCell('register a callback that fires when release() runs.'),
          ]),
          TableRow(children: <Widget>[
            _TblCell('removeListener(VoidCallback)'),
            _TblCell('inherited from ChangeNotifier'),
            _TblCell('detach a previously registered callback.'),
          ]),
          TableRow(children: <Widget>[
            _TblCell('KeepAliveNotification(handle)'),
            _TblCell('package:flutter/widgets.dart'),
            _TblCell('Notification that ferries the handle up the tree.'),
          ]),
          TableRow(children: <Widget>[
            _TblCell('KeepAliveNotification.dispatch(context)'),
            _TblCell('inherited from Notification'),
            _TblCell('walks the element tree to a NotificationListener.'),
          ]),
          TableRow(children: <Widget>[
            _TblCell('AutomaticKeepAlive'),
            _TblCell('package:flutter/widgets.dart'),
            _TblCell('Listens for KeepAliveNotifications and holds slots.'),
          ]),
          TableRow(children: <Widget>[
            _TblCell('AutomaticKeepAliveClientMixin<T>'),
            _TblCell('package:flutter/widgets.dart'),
            _TblCell('Mixin that owns the handle automatically.'),
          ]),
          TableRow(children: <Widget>[
            _TblCell('updateKeepAlive()'),
            _TblCell('AutomaticKeepAliveClientMixin'),
            _TblCell('re-evaluates wantKeepAlive and toggles the handle.'),
          ]),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Section 14 — Closing notes
// ══════════════════════════════════════════════════════════════════════════
class _Section14ClosingNotes extends StatelessWidget {
  const _Section14ClosingNotes();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      header: const _SectionHeader(
        14,
        'Closing notes & companion files',
        'Where to read more.',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _BulletLine(
            'See the sibling test file '
            'widgets/automatic_keep_alive_client_mixin_test.dart for the '
            'mixin perspective.',
          ),
          _BulletLine(
            'KeepAliveHandle is rarely constructed directly in app code; '
            'most of the time you mix in AutomaticKeepAliveClientMixin and '
            'let it handle creation, dispatch and release.',
          ),
          _BulletLine(
            'Direct usage shines when building diagnostic / debugging tools '
            'or when integrating with non-mixin custom keep-alive logic.',
          ),
          _BulletLine(
            'Always test keep-alive behaviour with a viewport-based widget '
            'test (PageView, TabBarView, slow ListView) — it is invisible '
            'in static layouts.',
          ),
          SizedBox(height: 8),
          Text(
            'End of demo.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
//  EXTENDED COMMENTARY (compile-only — also valuable when humans read it)
// ──────────────────────────────────────────────────────────────────────────
//
//  The comments below describe edge cases not visible in widgets above.
//  They are deliberately verbose so the deep-demo file can serve as a self-
//  contained reference when the Flutter docs are unavailable. None of this
//  affects runtime behaviour.
//
//  • THE INTERNAL WIRING.  AutomaticKeepAliveClientMixin owns a private
//    field `_keepAliveHandle`.  Every time `build` runs, the mixin checks
//    whether `wantKeepAlive` is true and, if so, allocates a fresh
//    KeepAliveHandle and dispatches a KeepAliveNotification through the
//    current context.  The notification bubbles up until an
//    AutomaticKeepAlive ancestor catches it.  That ancestor stores the
//    handle in a per-slot list and uses `addListener` to schedule an
//    eviction once `release()` is called.
//
//  • RE-USE.  A handle is intentionally not reusable.  If `wantKeepAlive`
//    flips to false, the mixin calls `release()` on the existing handle
//    and discards it; on the next true value, a *new* handle is created.
//    This is why long-running widgets that toggle their keep-alive value
//    must implement `updateKeepAlive()` correctly.
//
//  • NOTIFICATION COST.  Dispatching a KeepAliveNotification walks the
//    element tree synchronously.  This is cheap, but it does happen on
//    every build that toggles keep-alive on, so do not toggle in a loop.
//
//  • WHY IS IT A ChangeNotifier?  Originally KeepAliveHandle could have
//    been a one-shot Future.  Using ChangeNotifier allows the ancestor to
//    register a removeListener call symmetrically with addListener, which
//    matches the rest of the framework's lifecycle conventions.
//
//  • TESTING.  Driving the handle in unit tests is straightforward:
//
//        final handle = KeepAliveHandle();
//        bool fired = false;
//        handle.addListener(() => fired = true);
//        handle.release();
//        expect(fired, isTrue);
//
//    That makes KeepAliveHandle a good entry-point for white-box testing
//    custom keep-alive widgets.
//
//  • DEBUGGING.  Add a `print` to the listener attached by your
//    AutomaticKeepAlive subclass to log slots that get released; this is
//    useful when investigating "why is my widget rebuilding?" issues.
//
//  • COMMON BUG.  A `wantKeepAlive` getter that depends on data fetched
//    via Provider can return the wrong value before the data has loaded.
//    The fix is usually to default to true while loading and to call
//    `updateKeepAlive()` once the real value is known.
//
//  • RELEASE ORDERING.  When the State is disposed, the mixin releases
//    its handle for you.  In custom code, prefer to release before
//    super.dispose() to keep the lifecycle predictable.
//
//  • PERFORMANCE NOTE.  Keep-alive trades memory for CPU: kept-alive
//    children stay in the element tree and the render tree, which means
//    they continue to consume memory even when off-screen.  Use it
//    selectively for state that is expensive to lose.
//
//  • OBSERVABILITY.  In the inspector you can spot kept-alive subtrees
//    because they appear under an AutomaticKeepAlive node even when their
//    visible area is gone.
//
//  • COMPOSITIONAL TIP.  If you have a long form with multiple input
//    sections, a single AutomaticKeepAliveClientMixin on the top-level
//    State is usually enough; you do not need to attach one to every
//    child.
//
//  • NULL-SAFETY.  KeepAliveHandle and KeepAliveNotification are non-null
//    types; you must construct a fresh handle each time you intend to
//    request a new keep-alive lease.
//
//  • COMPATIBILITY.  KeepAliveHandle has been part of Flutter for many
//    versions; the API has been stable since well before sound null
//    safety landed.  No deprecations are pending at the time of writing.
//
//  • THIS FILE.  Lines are deliberately wrapped at ~80 columns for
//    readability and to make `dart analyze` warn-free.  No `// ignore:`
//    pragmas are necessary; the only header pragmas relax three classic
//    deep-demo concerns (avoid_print, deprecated_member_use, and
//    sort_child_properties_last) that may legitimately fire across the
//    family of harness files.
//
//  ── End of extended commentary ──
