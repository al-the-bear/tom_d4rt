// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

// ---------------------------------------------------------------------------
// SynchronousFuture<T> - Visual Deep Demo
// ---------------------------------------------------------------------------
//
// SynchronousFuture is a Future subclass from package:flutter/foundation.dart
// that completes synchronously, bypassing the normal microtask scheduling that
// asynchronous futures use. Callbacks registered with .then() or
// .whenComplete() are invoked immediately, in the same synchronous turn.
//
// This makes it the preferred way for Flutter framework code to fast-path
// already-known values through Future-typed APIs without paying a microtask
// dispatch cost (which would force a frame split or input event yield).
//
// Typical Flutter call sites that return SynchronousFuture:
//   - ImageProvider.obtainKey()         - cached image key lookups
//   - AssetBundle.loadStructuredData()  - cached structured asset reads
//   - SynchronousFuture.value(...)      - explicit fast-paths in app code
//
// Anti-pattern: using SynchronousFuture for genuinely async work, or when
// downstream code assumes microtask ordering. Doing so will violate the
// "Future means async" contract and break code that relies on it.
//
// This demo constructs SynchronousFuture instances at build time, chains
// .then()/.whenComplete() over them, records the execution order into String
// buffers, and renders the captured traces as numbered timelines so that the
// difference vs Future.value is visually obvious.
//
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------

const Color _kBackground = Color(0xFFF4F6FB);
const Color _kPanel = Color(0xFFFFFFFF);
const Color _kBorder = Color(0xFFD7DEEA);
const Color _kAccent = Color(0xFF1565C0);
const Color _kAccentDark = Color(0xFF0D3D78);
const Color _kSync = Color(0xFF2E7D32);
const Color _kAsync = Color(0xFFE65100);
const Color _kWarn = Color(0xFFC62828);
const Color _kCode = Color(0xFF1B1B2A);
const Color _kCodeText = Color(0xFFE0E6F1);
const Color _kMuted = Color(0xFF5B6478);
const Color _kHeading = Color(0xFF131A29);
const Color _kPillBg = Color(0xFFE3ECFB);
const Color _kPillFg = Color(0xFF0D3D78);
const Color _kStepBg = Color(0xFFEFF4FB);

// ---------------------------------------------------------------------------
// Trace recording helpers (used at build-time, not async)
// ---------------------------------------------------------------------------
//
// Each "trace" is a numbered list of step strings. We record into a List<String>
// and then render that list as a vertical timeline. This makes the order of
// execution legible without needing main() or any async test infrastructure.
//
// We exercise SynchronousFuture by constructing it inside the build() method
// and registering callbacks that append into the trace list. Because
// SynchronousFuture completes synchronously, all callbacks fire before the
// chain expression returns, which means by the time we read the buffer, the
// trace is complete.
//
// ---------------------------------------------------------------------------

class _Trace {
  _Trace(this.label);

  final String label;
  final List<String> steps = <String>[];

  void log(String step) {
    steps.add(step);
  }

  int get length => steps.length;
}

_Trace _traceSyncThen() {
  final _Trace trace = _Trace('SynchronousFuture chain');
  trace.log('A: before chain expression');
  final SynchronousFuture<int> sf = SynchronousFuture<int>(42);
  trace.log('B: SynchronousFuture<int>(42) constructed');
  sf.then((int value) {
    trace.log('C: .then((42)) invoked synchronously, value=$value');
  });
  trace.log('D: after .then(...) registration');
  sf.whenComplete(() {
    trace.log('E: .whenComplete() invoked synchronously');
  });
  trace.log('F: after .whenComplete(...) registration');
  return trace;
}

_Trace _traceSyncChained() {
  final _Trace trace = _Trace('Chained .then() returning SynchronousFuture');
  trace.log('A: start chain');
  SynchronousFuture<int>(1)
      .then<int>((int v) {
    trace.log('B: first .then() got $v, returning SynchronousFuture(v+1)');
    return SynchronousFuture<int>(v + 1);
  }).then<int>((int v) {
    trace.log('C: second .then() got $v, returning SynchronousFuture(v*10)');
    return SynchronousFuture<int>(v * 10);
  }).then<int>((int v) {
    trace.log('D: third .then() got $v (final synchronous value)');
    return SynchronousFuture<int>(v);
  });
  trace.log('E: chain expression has returned to caller');
  return trace;
}

_Trace _traceSyncThenReturnsAsync() {
  final _Trace trace = _Trace('SynchronousFuture.then returning a Future');
  trace.log('A: before chain');
  SynchronousFuture<int>(7).then<int>((int v) {
    trace.log('B: .then() got $v, returning Future.value(...)');
    // Returning a non-Synchronous Future degrades the chain to async.
    return Future<int>.value(v + 100);
  }).then((int v) {
    trace.log('D: second .then() got $v (this fires asynchronously)');
  });
  trace.log('C: chain expression returned (microtask not yet drained)');
  return trace;
}

_Trace _traceFutureValue() {
  final _Trace trace = _Trace('Future.value chain (asynchronous)');
  trace.log('A: before chain');
  Future<int>.value(42).then((int v) {
    trace.log('C: .then() of Future.value (microtask) got $v');
  });
  trace.log('B: after .then() registration (microtask pending)');
  return trace;
}

_Trace _traceWhenCompleteOrder() {
  final _Trace trace = _Trace('whenComplete + then ordering');
  trace.log('A: start');
  final SynchronousFuture<String> sf = SynchronousFuture<String>('hello');
  sf.whenComplete(() {
    trace.log('B: whenComplete fired');
  });
  sf.then((String s) {
    trace.log('C: then fired with "$s"');
  });
  sf.whenComplete(() {
    trace.log('D: second whenComplete fired');
  });
  trace.log('E: end');
  return trace;
}

_Trace _traceAsStream() {
  final _Trace trace = _Trace('SynchronousFuture.asStream()');
  trace.log('A: before asStream()');
  final SynchronousFuture<int> sf = SynchronousFuture<int>(99);
  final Stream<int> stream = sf.asStream();
  trace.log('B: stream obtained');
  // Per Future contract, asStream emits the value to a listener; it is
  // delivered via the stream subscription, which itself is asynchronous.
  stream.listen((int v) {
    trace.log('D: stream listener got $v (asynchronously, via stream pump)');
  });
  trace.log('C: listener registered (events still pending)');
  return trace;
}

_Trace _traceCatchError() {
  final _Trace trace = _Trace('SynchronousFuture.catchError pass-through');
  trace.log('A: start');
  final SynchronousFuture<int> sf = SynchronousFuture<int>(11);
  sf.catchError((Object e) {
    trace.log('X: catchError invoked (should NOT happen for value future)');
    return -1;
  }).then((int v) {
    trace.log('B: .then() after catchError got $v');
  });
  trace.log('C: end');
  return trace;
}

_Trace _traceImageProviderObtainKey() {
  // Simulates the pattern from ImageProvider.obtainKey() / AssetBundle.
  final _Trace trace = _Trace('Fast-path: obtainKey returning SynchronousFuture');
  trace.log('A: caller invokes provider.obtainKey(config)');
  final SynchronousFuture<_FakeImageKey> keyFuture =
      _FakeImageProvider().obtainKey(_FakeConfig('mango.png'));
  trace.log('B: obtainKey returned (key available synchronously)');
  keyFuture.then((_FakeImageKey key) {
    trace.log('C: caller .then() observes key=${key.assetName}');
  });
  trace.log('D: caller continues without microtask split');
  return trace;
}

_Trace _traceFastPathFutureApi() {
  final _Trace trace = _Trace('Fast-path inside a Future-returning API');
  trace.log('A: app calls cache.loadOrFetch("greeting")');
  final Future<String> f = _FakeCache().loadOrFetch('greeting');
  trace.log('B: returned future inspected');
  f.then((String s) {
    trace.log('C: .then() fired with "$s"');
  });
  trace.log('D: app continues');
  return trace;
}

// ---------------------------------------------------------------------------
// Fake support objects for the recipe demos
// ---------------------------------------------------------------------------

class _FakeConfig {
  const _FakeConfig(this.name);
  final String name;
}

class _FakeImageKey {
  const _FakeImageKey(this.assetName);
  final String assetName;
}

class _FakeImageProvider {
  /// Mirrors the actual signature pattern in ImageProvider:
  /// `Future<T> obtainKey(ImageConfiguration configuration);`
  /// Most concrete providers return SynchronousFuture<T> because the key is
  /// known immediately.
  SynchronousFuture<_FakeImageKey> obtainKey(_FakeConfig config) {
    return SynchronousFuture<_FakeImageKey>(_FakeImageKey(config.name));
  }
}

class _FakeCache {
  final Map<String, String> _hot = <String, String>{
    'greeting': 'hello world',
  };

  Future<String> loadOrFetch(String key) {
    final String? hit = _hot[key];
    if (hit != null) {
      // Fast-path: no microtask hop.
      return SynchronousFuture<String>(hit);
    }
    // Slow-path: real async work.
    return Future<String>.delayed(
      const Duration(milliseconds: 1),
      () => 'fetched:$key',
    );
  }
}

// ---------------------------------------------------------------------------
// Build entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // Pre-compute all traces at build time. Because SynchronousFuture completes
  // immediately, all the relevant steps for the synchronous demos are already
  // present in these lists before they reach the widget tree.
  final _Trace traceSync = _traceSyncThen();
  final _Trace traceChained = _traceSyncChained();
  final _Trace traceSyncReturnsAsync = _traceSyncThenReturnsAsync();
  final _Trace traceFutureValue = _traceFutureValue();
  final _Trace traceWhenComplete = _traceWhenCompleteOrder();
  final _Trace traceAsStream = _traceAsStream();
  final _Trace traceCatchError = _traceCatchError();
  final _Trace traceObtainKey = _traceImageProviderObtainKey();
  final _Trace traceFastPath = _traceFastPathFutureApi();

  return Scaffold(
    backgroundColor: _kBackground,
    appBar: AppBar(
      backgroundColor: _kAccentDark,
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text('SynchronousFuture<T> — Deep Visual Demo'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // -----------------------------------------------------------------
          // Dossier
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '01',
            title: 'Dossier',
            subtitle:
                'SynchronousFuture<T> — a Future that completes in the same '
                'synchronous turn it was created in.',
          ),
          const _Dossier(),
          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // Anatomy
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '02',
            title: 'Anatomy',
            subtitle:
                'Constructor, .then(), .whenComplete(), .asStream(), .catchError().',
          ),
          const _Anatomy(),
          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // Synchronous trace
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '03',
            title: 'Execution trace — synchronous chain',
            subtitle:
                'then() and whenComplete() fire BEFORE the chain expression '
                'returns to the surrounding code.',
          ),
          _TraceCard(
            trace: traceSync,
            color: _kSync,
            badge: 'SYNC',
            explanation:
                'Notice that steps C and E (the callbacks) execute between '
                'B (constructor) and the end of the build() body — there is '
                'no microtask hop in between.',
          ),
          const SizedBox(height: 16),
          _TraceCard(
            trace: traceChained,
            color: _kSync,
            badge: 'SYNC CHAIN',
            explanation:
                'A chain of .then() handlers that each return another '
                'SynchronousFuture stays fully synchronous. Step E (chain '
                'returned) is the LAST entry in the trace.',
          ),
          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // Async trace - comparison
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '04',
            title: 'Comparison — Future.value (microtask)',
            subtitle:
                'Future.value(...) defers .then() callbacks to the microtask '
                'queue. Order of registration and execution differs.',
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _TraceCard(
                  trace: traceSync,
                  color: _kSync,
                  badge: 'SYNC',
                  explanation:
                      'SynchronousFuture: callback (C/E) interleaves between '
                      'B and the trailing log statements.',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _TraceCard(
                  trace: traceFutureValue,
                  color: _kAsync,
                  badge: 'MICROTASK',
                  explanation:
                      'Future.value: the .then() callback (would-be C) is not '
                      'present yet at the end of the build pass — it runs '
                      'after the current synchronous turn finishes.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // Mixed chain
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '05',
            title: 'Mixed chain — returning a non-Synchronous future',
            subtitle:
                'If a .then() handler returns a regular Future, the rest of '
                'the chain becomes asynchronous from that point.',
          ),
          _TraceCard(
            trace: traceSyncReturnsAsync,
            color: _kAsync,
            badge: 'DEGRADES',
            explanation:
                'Step B fires synchronously, but step D is missing from the '
                'trace because the inner Future.value defers the next .then() '
                'to a microtask. Hence "C: chain returned" appears before D.',
          ),
          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // whenComplete and asStream
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '06',
            title: 'whenComplete / asStream / catchError',
            subtitle: 'Behaviours of the other Future surface methods.',
          ),
          _TraceCard(
            trace: traceWhenComplete,
            color: _kSync,
            badge: 'SYNC',
            explanation:
                'Multiple whenComplete and then handlers all fire in '
                'registration order, synchronously.',
          ),
          const SizedBox(height: 16),
          _TraceCard(
            trace: traceAsStream,
            color: _kAsync,
            badge: 'STREAM',
            explanation:
                'asStream() returns a Stream. Stream delivery uses event-loop '
                'scheduling regardless of source, so the listener (D) fires '
                'AFTER C, asynchronously.',
          ),
          const SizedBox(height: 16),
          _TraceCard(
            trace: traceCatchError,
            color: _kSync,
            badge: 'SYNC',
            explanation:
                'catchError on a SynchronousFuture that is not failed simply '
                'passes the value through, synchronously.',
          ),
          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // Recipes
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '07',
            title: 'Recipes',
            subtitle: 'Realistic Flutter framework usage patterns.',
          ),
          const _RecipeCard(
            title: 'Recipe 1 — ImageProvider.obtainKey() fast path',
            description:
                'When the key is computable synchronously (which is almost '
                'always), the provider returns SynchronousFuture so the '
                'painting pipeline can resolve images without yielding.',
            code: _kRecipeObtainKey,
          ),
          _TraceCard(
            trace: traceObtainKey,
            color: _kSync,
            badge: 'OBTAIN KEY',
            explanation:
                'Steps A→B→C→D all run in the same synchronous turn. The '
                'caller can read the key in the very next instruction.',
          ),
          const SizedBox(height: 24),
          const _RecipeCard(
            title: 'Recipe 2 — Fast path in a Future-returning API',
            description:
                'A cache exposes Future<T> publicly so callers can await it, '
                'but when there is a cache hit it returns SynchronousFuture '
                'to skip the microtask hop.',
            code: _kRecipeCache,
          ),
          _TraceCard(
            trace: traceFastPath,
            color: _kSync,
            badge: 'CACHE HIT',
            explanation:
                'Step C runs between B and D — the caller sees the cached '
                'value without yielding to the event loop.',
          ),
          const SizedBox(height: 24),
          const _RecipeCard(
            title: 'Recipe 3 — Synchronous resource resolution',
            description:
                'Resource resolvers that already have the data (asset bundles '
                'that cached a manifest, registries with pre-parsed entries) '
                'should expose SynchronousFuture-returning methods, while '
                'keeping the public type as Future<T> for compatibility.',
            code: _kRecipeResource,
          ),
          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // Pitfalls
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '08',
            title: 'Common pitfalls',
            subtitle:
                'Where SynchronousFuture violates implicit Future assumptions.',
          ),
          const _PitfallList(),
          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // Call sites in the Flutter framework
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '09',
            title: 'Flutter framework call sites',
            subtitle:
                'Where SynchronousFuture appears inside Flutter and why.',
          ),
          const _CallSiteList(),
          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // Glossary
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '10',
            title: 'Glossary',
            subtitle: 'Terms used throughout this demo.',
          ),
          const _Glossary(),
          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // Recap
          // -----------------------------------------------------------------
          const _SectionHeader(
            number: '11',
            title: 'Recap',
            subtitle: 'Quick mental model for SynchronousFuture<T>.',
          ),
          const _Recap(),
          const SizedBox(height: 32),
          const _Footer(),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Code blocks (string literals)
// ---------------------------------------------------------------------------

const String _kRecipeObtainKey = '''
class AssetImage extends ImageProvider<AssetImage> {
  const AssetImage(this.assetName);
  final String assetName;

  @override
  Future<AssetImage> obtainKey(ImageConfiguration configuration) {
    // No I/O is required to know the key — it is just the receiver.
    return SynchronousFuture<AssetImage>(this);
  }
}
''';

const String _kRecipeCache = '''
class StringCache {
  final Map<String, String> _hot = <String, String>{};

  Future<String> loadOrFetch(String key) {
    final String? hit = _hot[key];
    if (hit != null) {
      // Fast-path: no microtask hop.
      return SynchronousFuture<String>(hit);
    }
    return _slowFetch(key);
  }

  Future<String> _slowFetch(String key) async {
    final String value = await _readFromDisk(key);
    _hot[key] = value;
    return value;
  }
}
''';

const String _kRecipeResource = '''
class Registry<T> {
  Registry(this._entries);
  final Map<String, T> _entries;

  Future<T> resolve(String id) {
    final T? entry = _entries[id];
    if (entry == null) {
      return Future<T>.error(StateError('unknown: \$id'));
    }
    // Fast-path: synchronous lookup.
    return SynchronousFuture<T>(entry);
  }
}
''';

// ---------------------------------------------------------------------------
// Section header
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _kAccentDark,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: _kHeading,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _kMuted,
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
}

// ---------------------------------------------------------------------------
// Dossier panel
// ---------------------------------------------------------------------------

class _Dossier extends StatelessWidget {
  const _Dossier();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _KeyValueRow(
            label: 'Type',
            value: 'class SynchronousFuture<T> implements Future<T>',
          ),
          _KeyValueRow(
            label: 'Library',
            value: 'package:flutter/foundation.dart',
          ),
          _KeyValueRow(
            label: 'Purpose',
            value:
                'Bypass microtask scheduling for known values that must flow '
                'through Future-typed APIs.',
          ),
          _KeyValueRow(
            label: 'Constructor',
            value: 'SynchronousFuture(T value)',
          ),
          _KeyValueRow(
            label: 'Completes',
            value:
                'Synchronously, in the same turn the future was created. '
                'No microtask is enqueued.',
          ),
          _KeyValueRow(
            label: 'When to use',
            value:
                'Fast paths through Future-typed APIs (caches, registries, '
                'image keys, asset manifests already resolved).',
          ),
          _KeyValueRow(
            label: 'When NOT to use',
            value:
                'Anything that actually awaits I/O, timers, isolates, or any '
                'work whose duration is not known up front. Anything where '
                'downstream code depends on the microtask-ordering contract.',
          ),
          _KeyValueRow(
            label: 'Used by',
            value:
                'ImageProvider.obtainKey, AssetBundle.loadStructuredData, '
                'BinaryMessenger cached paths, certain Diagnosticable lookups.',
          ),
          SizedBox(height: 4),
          _Callout(
            color: _kAccent,
            text:
                'Mental model: "I know the answer right now, but my API '
                'signature has to return Future<T> — so I want a Future that '
                'lies about being async."',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Anatomy panel
// ---------------------------------------------------------------------------

class _Anatomy extends StatelessWidget {
  const _Anatomy();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _AnatomyEntry(
            signature: 'SynchronousFuture(T value)',
            description:
                'Wraps an immediately known value. There is no error '
                'constructor — failure paths must come from somewhere else.',
          ),
          _AnatomyEntry(
            signature:
                'Future<R> then<R>(FutureOr<R> onValue(T value), '
                '{Function? onError})',
            description:
                'Invokes onValue synchronously with the stored value. If '
                'onValue returns another SynchronousFuture, the chain stays '
                'synchronous; if it returns a regular Future, the chain '
                'degrades to async from that point on.',
          ),
          _AnatomyEntry(
            signature: 'Future<T> whenComplete(FutureOr<void> action())',
            description:
                'Invokes action synchronously. The returned future is again '
                'a SynchronousFuture<T> with the same value (unless action '
                'returns a real Future, in which case the chain becomes '
                'async).',
          ),
          _AnatomyEntry(
            signature: 'Stream<T> asStream()',
            description:
                'Returns a Stream that emits the value. Stream delivery is '
                'always scheduled, so listeners do NOT receive the value '
                'synchronously even though the source future is synchronous.',
          ),
          _AnatomyEntry(
            signature:
                'Future<T> catchError(Function onError, '
                '{bool Function(Object)? test})',
            description:
                'SynchronousFuture has no error state from its constructor, '
                'so catchError is effectively a pass-through. The returned '
                'future is still a SynchronousFuture<T>.',
          ),
          _AnatomyEntry(
            signature: 'Future<R> timeout<R>(Duration timeLimit, ...)',
            description:
                'Returns a regular Future; the SynchronousFuture itself does '
                'not implement timeout in a synchronous way.',
          ),
        ],
      ),
    );
  }
}

class _AnatomyEntry extends StatelessWidget {
  const _AnatomyEntry({required this.signature, required this.description});

  final String signature;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _kCode,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              signature,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _kCodeText,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13.5,
              color: _kHeading,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Trace card — numbered timeline with colored markers
// ---------------------------------------------------------------------------

class _TraceCard extends StatelessWidget {
  const _TraceCard({
    required this.trace,
    required this.color,
    required this.badge,
    required this.explanation,
  });

  final _Trace trace;
  final Color color;
  final String badge;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  trace.label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kHeading,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  border: Border.all(color: color.withOpacity(0.45)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: _kStepBg,
              border: Border.all(color: _kBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < trace.steps.length; i++)
                  _TraceStep(
                    index: i + 1,
                    text: trace.steps[i],
                    color: color,
                    isLast: i == trace.steps.length - 1,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            explanation,
            style: const TextStyle(
              fontSize: 13,
              color: _kMuted,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _TraceStep extends StatelessWidget {
  const _TraceStep({
    required this.index,
    required this.text,
    required this.color,
    required this.isLast,
  });

  final int index;
  final String text;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color.withOpacity(0.4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 10, top: 3),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: _kHeading,
                  height: 1.45,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Recipe card
// ---------------------------------------------------------------------------

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.title,
    required this.description,
    required this.code,
  });

  final String title;
  final String description;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _Panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _kHeading,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(
                fontSize: 13.5,
                color: _kMuted,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kCode,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                code.trim(),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: _kCodeText,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pitfalls
// ---------------------------------------------------------------------------

class _PitfallList extends StatelessWidget {
  const _PitfallList();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _PitfallEntry(
            symbol: 'P1',
            title: 'Mixing sync and async semantics',
            body:
                'A callsite that does var f = ...; f.then(a); foo(); '
                'expects "foo" to run before "a". Under SynchronousFuture, '
                'the order is reversed: "a" runs immediately inside the call '
                'to .then(), and "foo" runs afterward. Be intentional.',
          ),
          _PitfallEntry(
            symbol: 'P2',
            title: 'Breaking microtask-ordering expectations',
            body:
                'Code that relies on "all pending microtasks drain before my '
                'next .then() callback runs" will see surprising behavior — '
                'a SynchronousFuture callback can run in the middle of '
                'another synchronous block, before unrelated microtasks.',
          ),
          _PitfallEntry(
            symbol: 'P3',
            title: 'Using SynchronousFuture for real I/O',
            body:
                'If the work is genuinely async, do NOT use SynchronousFuture '
                'as a shortcut. It will appear to work in the constructor and '
                'then deadlock or starve other microtasks downstream.',
          ),
          _PitfallEntry(
            symbol: 'P4',
            title: 'Returning Future from inside a sync then()',
            body:
                'SynchronousFuture<T>.then((v) => Future.value(...)) breaks '
                'the chain. Everything after that boundary is async. This is '
                'a frequent source of "why did my widget rebuild twice?" '
                'investigations.',
          ),
          _PitfallEntry(
            symbol: 'P5',
            title: 'Re-entrant exceptions',
            body:
                'Because callbacks run synchronously, an exception thrown '
                'inside .then() propagates up the synchronous call stack — '
                'not into the Future error channel as one might expect for '
                'a regular Future. Wrap in try/catch deliberately.',
          ),
          _PitfallEntry(
            symbol: 'P6',
            title: 'Stream listeners are still async',
            body:
                'sf.asStream().listen(...) does NOT call the listener '
                'synchronously. The stream subscription event delivery is '
                'always scheduled.',
          ),
          _PitfallEntry(
            symbol: 'P7',
            title: 'await still yields',
            body:
                'await sf in an async function still yields control to the '
                'event loop the same way "await null" does — because the '
                'awaiter is async, not the awaited.',
          ),
        ],
      ),
    );
  }
}

class _PitfallEntry extends StatelessWidget {
  const _PitfallEntry({
    required this.symbol,
    required this.title,
    required this.body,
  });

  final String symbol;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _kWarn.withOpacity(0.12),
              border: Border.all(color: _kWarn.withOpacity(0.6)),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              symbol,
              style: const TextStyle(
                color: _kWarn,
                fontWeight: FontWeight.w800,
                fontSize: 12,
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
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: _kHeading,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 13,
                    color: _kMuted,
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
}

// ---------------------------------------------------------------------------
// Flutter call sites
// ---------------------------------------------------------------------------

class _CallSiteList extends StatelessWidget {
  const _CallSiteList();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _CallSiteEntry(
            site: 'ImageProvider.obtainKey()',
            location: 'package:flutter/src/painting/image_provider.dart',
            body:
                'Concrete providers (AssetImage, MemoryImage, FileImage) all '
                'return SynchronousFuture<T> because the key is just the '
                'provider itself or a derived value with no async work.',
          ),
          _CallSiteEntry(
            site: 'AssetBundle.loadStructuredData()',
            location: 'package:flutter/src/services/asset_bundle.dart',
            body:
                'Once a structured asset has been parsed and cached, '
                'subsequent reads return SynchronousFuture so callers do not '
                'pay a microtask hop per lookup.',
          ),
          _CallSiteEntry(
            site: 'BinaryMessenger.handlePlatformMessage()',
            location: 'package:flutter/src/services/binary_messenger.dart',
            body:
                'When a message can be handled with a precomputed reply '
                '(e.g., empty payload, cached response), it returns '
                'SynchronousFuture to avoid forcing a microtask round-trip.',
          ),
          _CallSiteEntry(
            site: 'Custom resource registries',
            location: 'Application code',
            body:
                'Any registry that wraps a sync Map<String, T> lookup in a '
                'Future<T> API is a natural candidate for SynchronousFuture, '
                'especially when called from build() pipelines.',
          ),
          _CallSiteEntry(
            site: 'Localization delegates with bundled data',
            location: 'package:flutter_localizations',
            body:
                'When translations are baked into the binary, the delegate '
                'can resolve the locale to its translations synchronously '
                'and return SynchronousFuture<LocalizedStrings>.',
          ),
        ],
      ),
    );
  }
}

class _CallSiteEntry extends StatelessWidget {
  const _CallSiteEntry({
    required this.site,
    required this.location,
    required this.body,
  });

  final String site;
  final String location;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.dataset_outlined, size: 18, color: _kAccent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  site,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kHeading,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Text(
              location,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: _kMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Text(
              body,
              style: const TextStyle(
                fontSize: 13,
                color: _kHeading,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Glossary
// ---------------------------------------------------------------------------

class _Glossary extends StatelessWidget {
  const _Glossary();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _GlossaryEntry(
            term: 'Future<T>',
            definition:
                'The Dart abstraction for a value-or-error that becomes '
                'available later. Standard semantics defer callbacks to the '
                'microtask queue.',
          ),
          _GlossaryEntry(
            term: 'Microtask',
            definition:
                'A unit of work scheduled by the Dart runtime to run after '
                'the current synchronous code completes, but before any '
                'I/O or timer events are processed.',
          ),
          _GlossaryEntry(
            term: 'Synchronous turn',
            definition:
                'A single uninterrupted run of synchronous code, from when '
                'the event loop calls into your code to when control returns '
                'to it. SynchronousFuture stays inside one turn.',
          ),
          _GlossaryEntry(
            term: 'Microtask queue',
            definition:
                'FIFO queue of microtasks. Drained completely between event '
                'loop iterations. Future.value defers to this queue; '
                'SynchronousFuture does not touch it.',
          ),
          _GlossaryEntry(
            term: 'Fast path',
            definition:
                'A code path used when work can be completed without I/O. '
                'SynchronousFuture is the canonical fast-path representation '
                'inside Future-typed APIs.',
          ),
          _GlossaryEntry(
            term: 'Chain degradation',
            definition:
                'When a .then() in a SynchronousFuture chain returns a '
                'regular Future, the rest of the chain becomes asynchronous. '
                'Synchronicity is not preserved across the boundary.',
          ),
          _GlossaryEntry(
            term: 'asStream()',
            definition:
                'Future API that produces a Stream emitting the future\'s '
                'value (or error). Stream delivery is always scheduled, '
                'regardless of the source future\'s synchronicity.',
          ),
          _GlossaryEntry(
            term: 'await yield',
            definition:
                'Even when awaiting a SynchronousFuture, the awaiter (the '
                'async function calling await) yields control to the event '
                'loop. The synchronicity property is about the future, not '
                'the awaiter.',
          ),
        ],
      ),
    );
  }
}

class _GlossaryEntry extends StatelessWidget {
  const _GlossaryEntry({required this.term, required this.definition});

  final String term;
  final String definition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              term,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: _kAccentDark,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              definition,
              style: const TextStyle(
                fontSize: 13,
                color: _kHeading,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Recap
// ---------------------------------------------------------------------------

class _Recap extends StatelessWidget {
  const _Recap();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _RecapItem(
            number: '1',
            text:
                'SynchronousFuture<T> implements Future<T> but completes '
                'synchronously — no microtask is scheduled.',
          ),
          _RecapItem(
            number: '2',
            text:
                'Callbacks registered with .then() and .whenComplete() are '
                'invoked immediately, in registration order, in the same '
                'synchronous turn.',
          ),
          _RecapItem(
            number: '3',
            text:
                'Returning a non-Synchronous Future from a .then() handler '
                'degrades the rest of the chain to asynchronous semantics.',
          ),
          _RecapItem(
            number: '4',
            text:
                'asStream() always delivers via the stream pump and is '
                'therefore asynchronous regardless of the source future.',
          ),
          _RecapItem(
            number: '5',
            text:
                'Use it for fast paths through Future-typed APIs, especially '
                'in Flutter framework code where microtask hops can cause '
                'frame splits or rebuild flicker.',
          ),
          _RecapItem(
            number: '6',
            text:
                'Never use it for genuinely async work or where downstream '
                'code depends on microtask ordering.',
          ),
        ],
      ),
    );
  }
}

class _RecapItem extends StatelessWidget {
  const _RecapItem({required this.number, required this.text});

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _kAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                color: _kHeading,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared layout primitives
// ---------------------------------------------------------------------------

class _Panel extends StatelessWidget {
  const _Panel({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kPanel,
        border: Border.all(color: _kBorder),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0F1B2A3F),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: _kMuted,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13.5,
                color: _kHeading,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Callout extends StatelessWidget {
  const _Callout({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border(
          left: BorderSide(color: color, width: 3),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.5,
          color: _kHeading,
          height: 1.45,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'SynchronousFuture<T> — bypass the microtask, keep the contract.',
          style: TextStyle(
            color: _kMuted,
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
