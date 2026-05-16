// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// Builder — deep visual demo for the D4rt analyzer-free Flutter interpreter
// ----------------------------------------------------------------------------
// Builder is the smallest possible composition primitive in Flutter widgets.
// It does nothing but call its `builder` callback during build, passing the
// callback a BuildContext whose Element sits BELOW the Builder widget in the
// tree. That is the entire point: it manufactures a fresh BuildContext that
// has the surrounding ancestors above it, including the very widgets that
// just got wrapped around it. Without that fresh context, calls like
// Scaffold.of(context), Theme.of(context), MediaQuery.of(context) or
// DefaultTextStyle.of(context) look UP from the OUTER context and miss the
// inner Theme / Scaffold / MediaQuery wrapper that you just installed.
//
// This file demonstrates the patterns visually with explanatory paragraphs
// after each section. Read top to bottom.
// ============================================================================

// ----------------------------------------------------------------------------
// Section 1 — Header / anatomy diagram (BuildContext tree before/after)
// ----------------------------------------------------------------------------
Widget _section1Header() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFEDE7F6),
      border: Border.all(color: const Color(0xFF673AB7), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 1 — Anatomy of a Builder',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Builder is a one-liner widget whose ENTIRE job is to give you a '
          'BuildContext that lives BELOW it in the element tree. Look at the '
          'two diagrams. The left side shows the WRONG context (looking up '
          'from outside the inner Theme). The right side shows what you get '
          'when you wrap with Builder.',
          style: TextStyle(fontSize: 13.0),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _treeDiagram(withBuilder: false)),
            const SizedBox(width: 12.0),
            Expanded(child: _treeDiagram(withBuilder: true)),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'On the left, the outer build() function uses its OWN context, '
          'which sits ABOVE the inner Theme. On the right, Builder.builder '
          'receives ctx, which sits BELOW the inner Theme. Same widget tree, '
          'different lookups.',
          style: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _treeDiagram({required bool withBuilder}) {
  final lines = withBuilder
      ? <String>[
          'Theme(primary: red)',
          ' |',
          ' +-- Theme(primary: blue)',
          '      |',
          '      +-- Builder(builder: (ctx) {',
          '             ctx -> sees BLUE',
          '          })',
        ]
      : <String>[
          'Theme(primary: red)',
          ' |',
          ' +-- Theme(primary: blue)',
          '      |',
          '      +-- Container(...)',
          '   ',
          'outer context -> sees RED',
        ];
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: withBuilder ? const Color(0xFFE3F2FD) : const Color(0xFFFFEBEE),
      border: Border.all(
        color: withBuilder ? Colors.blue : Colors.red,
        width: 1.5,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          withBuilder ? 'WITH Builder' : 'WITHOUT Builder',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: withBuilder ? Colors.blue : Colors.red,
          ),
        ),
        const SizedBox(height: 6.0),
        for (final line in lines)
          Text(
            line,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
            ),
          ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 2 — Theme.of inside a Theme override
// ----------------------------------------------------------------------------
Widget _section2ThemeOverride(BuildContext outerContext) {
  // The OUTER context is read first so we can show the contrast.
  final outerTheme = Theme.of(outerContext);
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      border: Border.all(color: const Color(0xFFFFA000), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 2 — Theme.of inside a Theme override',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Outer Theme.primaryColor (read with outerContext): '
          '0x${outerTheme.primaryColor.value.toRadixString(16)}',
          style: const TextStyle(fontSize: 13.0),
        ),
        const SizedBox(height: 12.0),
        // Inner Theme override. The trick: if we tried Theme.of(outerContext)
        // INSIDE the Theme below, it would still return the OUTER theme.
        // Builder gives us a context BELOW the inner Theme.
        Theme(
          data: ThemeData(
            primaryColor: Colors.deepPurple,
            colorScheme: const ColorScheme.light(
              primary: Colors.deepPurple,
              secondary: Colors.deepOrange,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          child: Builder(
            builder: (ctx) {
              final innerTheme = Theme.of(ctx);
              return Container(
                padding: const EdgeInsets.all(10.0),
                color: innerTheme.primaryColor.withOpacity(0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INNER Theme.of(ctx).primaryColor = '
                      '0x${innerTheme.primaryColor.value.toRadixString(16)}',
                      style: TextStyle(
                        color: innerTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Same lookup with the outer context would have returned '
                      'the OUTER primaryColor — wrong for this subtree.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: innerTheme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'What Builder buys you: the inner Theme widget is now an ancestor '
          'of the context you read from. Without Builder, the code inside '
          'this method would still hold outerContext and would happily skip '
          'right past the Theme override you just installed.',
          style: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 3 — MediaQuery.of under a MediaQuery override
// ----------------------------------------------------------------------------
Widget _section3MediaQuery(BuildContext outerContext) {
  final outer = MediaQuery.of(outerContext);
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE0F7FA),
      border: Border.all(color: const Color(0xFF00838F), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 3 — MediaQuery.of below an override',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006064),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Outer size: '
          '${outer.size.width.toStringAsFixed(0)} x '
          '${outer.size.height.toStringAsFixed(0)} | '
          'textScaler: ${outer.textScaler}',
          style: const TextStyle(fontSize: 13.0),
        ),
        const SizedBox(height: 12.0),
        MediaQuery(
          data: outer.copyWith(
            textScaler: const TextScaler.linear(1.8),
            viewInsets: const EdgeInsets.only(bottom: 240.0),
          ),
          child: Builder(
            builder: (ctx) {
              final inner = MediaQuery.of(ctx);
              return Container(
                padding: const EdgeInsets.all(10.0),
                color: const Color(0xFFB2EBF2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inner textScaler (read via ctx): ${inner.textScaler}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Inner viewInsets.bottom: '
                      '${inner.viewInsets.bottom.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'This text size respects the inner textScaler.',
                      style: TextStyle(
                        fontSize: 14.0 * inner.textScaler.scale(1.0),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Without Builder, reading MediaQuery.of(outerContext) inside this '
          'function would never see the override — the override widget is a '
          'CHILD of the build method that called us. Builder shifts the '
          'lookup point downward.',
          style: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 4 — DefaultTextStyle.of cascade
// ----------------------------------------------------------------------------
Widget _section4DefaultTextStyle() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFCE4EC),
      border: Border.all(color: const Color(0xFFC2185B), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 4 — DefaultTextStyle cascade',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        const SizedBox(height: 12.0),
        // Outer default style.
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 14.0,
            color: Color(0xFFAD1457),
            fontStyle: FontStyle.italic,
          ),
          child: Builder(
            builder: (outerCtx) {
              final outerDts = DefaultTextStyle.of(outerCtx);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OUTER DefaultTextStyle: '
                    'size=${outerDts.style.fontSize}, '
                    'italic=${outerDts.style.fontStyle == FontStyle.italic}',
                  ),
                  const SizedBox(height: 8.0),
                  // Inner override.
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF6A1B9A),
                      fontWeight: FontWeight.bold,
                    ),
                    child: Builder(
                      builder: (innerCtx) {
                        final innerDts = DefaultTextStyle.of(innerCtx);
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          color: const Color(0xFFF3E5F5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'INNER DefaultTextStyle: '
                                'size=${innerDts.style.fontSize}, '
                                'weight=${innerDts.style.fontWeight}',
                              ),
                              const Text('I inherit the inner style.'),
                              // Local override per Text widget.
                              const Text(
                                'I override locally with TextStyle.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Each Builder reads DefaultTextStyle.of at its own depth. Children '
          'of the inner DefaultTextStyle inherit the inner style; the outer '
          'Builder sees only the outer one. The cascade flows top-down, the '
          'lookups travel bottom-up.',
          style: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 5 — IconTheme.of through three nested themes
// ----------------------------------------------------------------------------
Widget _section5IconTheme() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5E9),
      border: Border.all(color: const Color(0xFF2E7D32), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 5 — IconTheme nested three deep',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        const SizedBox(height: 12.0),
        IconTheme(
          data: const IconThemeData(color: Colors.red, size: 24.0),
          child: Builder(
            builder: (ctxA) {
              final a = IconTheme.of(ctxA);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _iconRow('Level A', a),
                  IconTheme(
                    data: const IconThemeData(color: Colors.blue, size: 28.0),
                    child: Builder(
                      builder: (ctxB) {
                        final b = IconTheme.of(ctxB);
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _iconRow('Level B', b),
                              IconTheme(
                                data: const IconThemeData(
                                  color: Colors.green,
                                  size: 32.0,
                                ),
                                child: Builder(
                                  builder: (ctxC) {
                                    final c = IconTheme.of(ctxC);
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16.0,
                                      ),
                                      child: _iconRow('Level C', c),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Each level reads IconTheme.of with a context underneath its own '
          'IconTheme. The colors and sizes therefore reflect the LOCAL '
          'override, not whichever lookup the top-level build method would '
          'have produced.',
          style: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _iconRow(String label, IconThemeData data) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(Icons.star, color: data.color, size: data.size),
        const SizedBox(width: 8.0),
        Text(
          '$label — color=0x${data.color!.value.toRadixString(16)} '
          'size=${data.size}',
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 6 — Directionality
// ----------------------------------------------------------------------------
Widget _section6Directionality() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      border: Border.all(color: const Color(0xFFEF6C00), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 6 — Directionality flipped via Builder',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 12.0),
        // LTR side.
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (ctx) {
              final dir = Directionality.of(ctx);
              return _directionRow(dir, 'LTR row from Builder under LTR');
            },
          ),
        ),
        const SizedBox(height: 8.0),
        // RTL side.
        Directionality(
          textDirection: TextDirection.rtl,
          child: Builder(
            builder: (ctx) {
              final dir = Directionality.of(ctx);
              return _directionRow(dir, 'RTL row from Builder under RTL');
            },
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Directionality.of(ctx) is read inside each Builder. The arrow and '
          'row layout reverse depending on the inner Directionality, which '
          'is the entire ergonomic story behind RTL-aware composition.',
          style: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _directionRow(TextDirection dir, String label) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    color: dir == TextDirection.rtl
        ? const Color(0xFFFFE0B2)
        : const Color(0xFFFFCC80),
    child: Row(
      children: [
        Icon(
          dir == TextDirection.rtl
              ? Icons.arrow_back
              : Icons.arrow_forward,
        ),
        const SizedBox(width: 8.0),
        Expanded(child: Text(label)),
        Text('[${dir.name}]'),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 7 — Scaffold.of-style pattern (maybeOf)
// ----------------------------------------------------------------------------
Widget _section7ScaffoldOf(BuildContext outerContext) {
  final outerScaffold = Scaffold.maybeOf(outerContext);
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE1F5FE),
      border: Border.all(color: const Color(0xFF0277BD), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 7 — Scaffold.of via Builder',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF01579B),
          ),
        ),
        const SizedBox(height: 12.0),
        _scaffoldBadge(
          'Outer context (above any local Scaffold)',
          outerScaffold,
        ),
        const SizedBox(height: 12.0),
        // Build a SMALL local Scaffold to demonstrate the lookup. We wrap it
        // in a SizedBox to keep the visual area small — we are not using
        // the AppBar / body etc. as a full app, just a context source.
        SizedBox(
          height: 140.0,
          child: Scaffold(
            backgroundColor: const Color(0xFFB3E5FC),
            body: Center(
              child: Builder(
                builder: (innerCtx) {
                  final innerScaffold = Scaffold.maybeOf(innerCtx);
                  return _scaffoldBadge(
                    'Inner Builder under Scaffold',
                    innerScaffold,
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Scaffold.of(context) is the classic Builder use case: the canonical '
          'mistake is calling Scaffold.of from the OUTER build method that '
          'created the Scaffold, which fails because that context is ABOVE '
          'the Scaffold. Wrapping the consumer in a Builder is the canonical '
          'fix; the alternative is extracting the consumer into a separate '
          'widget so it gets its own BuildContext naturally.',
          style: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _scaffoldBadge(String label, ScaffoldState? state) {
  final ok = state != null;
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: ok ? const Color(0xFFC8E6C9) : const Color(0xFFFFCDD2),
      border: Border.all(
        color: ok ? Colors.green : Colors.red,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      children: [
        Icon(
          ok ? Icons.check_circle : Icons.cancel,
          color: ok ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            '$label — Scaffold.maybeOf = ${ok ? "FOUND" : "null"}',
            style: const TextStyle(fontSize: 13.0),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 8 — Refactor counter-example (lift state instead of Builder)
// ----------------------------------------------------------------------------
Widget _section8Refactor() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF3E5F5),
      border: Border.all(color: const Color(0xFF6A1B9A), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 8 — Builder vs. lifting / extracting',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _refactorPanelBuilder()),
            const SizedBox(width: 12.0),
            Expanded(child: _refactorPanelLifted()),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Pros of Builder: minimal ceremony, keeps everything inline, no '
          'extra widget class, perfect when the consumer is small.\n'
          'Cons of Builder: indents grow fast; the closure captures locals, '
          'which can leak state into the build phase.\n'
          'Pros of extracting / lifting: each piece is independently testable, '
          'has its own debug name in the widget inspector, and forces you '
          'to be explicit about the data flowing in.\n'
          'Cons of extracting: more files, more parameter plumbing, harder to '
          'iterate while exploring.',
          style: TextStyle(fontSize: 12.5),
        ),
      ],
    ),
  );
}

Widget _refactorPanelBuilder() {
  return Container(
    padding: const EdgeInsets.all(10.0),
    color: const Color(0xFFE1BEE7),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'A) Inline Builder',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6.0),
        Theme(
          data: ThemeData(primaryColor: Colors.purple),
          child: Builder(
            builder: (ctx) {
              final color = Theme.of(ctx).primaryColor;
              return Container(
                height: 40.0,
                color: color,
                alignment: Alignment.center,
                child: const Text(
                  'reads inner theme',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget _refactorPanelLifted() {
  return Container(
    padding: const EdgeInsets.all(10.0),
    color: const Color(0xFFCE93D8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'B) Extracted helper',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6.0),
        Theme(
          data: ThemeData(primaryColor: Colors.purple),
          child: _extractedColorBox(),
        ),
      ],
    ),
  );
}

Widget _extractedColorBox() {
  // This helper is itself a function and will be called such that its
  // produced widget tree is BELOW the Theme above — but the function reads
  // a context-free signature, so we need a Builder OR we should pass the
  // color in. Show the pass-in pattern using yet another helper.
  return Builder(
    builder: (ctx) {
      final color = Theme.of(ctx).primaryColor;
      return _coloredBox(color, 'extracted via param');
    },
  );
}

Widget _coloredBox(Color color, String label) {
  return Container(
    height: 40.0,
    color: color,
    alignment: Alignment.center,
    child: Text(label, style: const TextStyle(color: Colors.white)),
  );
}

// ----------------------------------------------------------------------------
// Section 9 — Three levels of nested Builders inside a Card
// ----------------------------------------------------------------------------
Widget _section9Nested() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFECEFF1),
      border: Border.all(color: const Color(0xFF455A64), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 9 — Three nested Builders inside a Card',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
        const SizedBox(height: 12.0),
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Theme(
              data: ThemeData(primaryColor: Colors.indigo),
              child: Builder(
                builder: (ctx1) {
                  final t1 = Theme.of(ctx1);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _level('Level 1', t1.primaryColor),
                      const SizedBox(height: 8.0),
                      Theme(
                        data: ThemeData(primaryColor: Colors.teal),
                        child: Builder(
                          builder: (ctx2) {
                            final t2 = Theme.of(ctx2);
                            return Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _level('Level 2', t2.primaryColor),
                                  const SizedBox(height: 8.0),
                                  Theme(
                                    data: ThemeData(
                                      primaryColor: Colors.brown,
                                    ),
                                    child: Builder(
                                      builder: (ctx3) {
                                        final t3 = Theme.of(ctx3);
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: _level(
                                            'Level 3',
                                            t3.primaryColor,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Each Builder sees its own local Theme. The visible colors prove '
          'that the lookup is scoped to whichever ancestor sits closest in '
          'the element tree. Drop any one of these Builders and that level '
          'collapses to whichever Theme is currently active outside.',
          style: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _level(String label, Color color) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      border: Border.all(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      children: [
        Container(width: 16.0, height: 16.0, color: color),
        const SizedBox(width: 8.0),
        Text(
          '$label — 0x${color.value.toRadixString(16)}',
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 10 — Anti-pattern: wrapping the root in a Builder for no reason
// ----------------------------------------------------------------------------
Widget _section10AntiPattern() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFEBEE),
      border: Border.all(color: const Color(0xFFC62828), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 10 — Anti-pattern callout',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB71C1C),
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _doDontPanel(isDo: false)),
            const SizedBox(width: 12.0),
            Expanded(child: _doDontPanel(isDo: true)),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'The DON\'T panel wraps the entire build output in a Builder even '
          'though nothing inside it depends on a fresh context. Every rebuild '
          'still calls the closure, you trade clarity for nothing, and any '
          'reader of the code now wonders what inherited widget you are '
          'guarding against. If the answer is "none" — delete the Builder.',
          style: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _doDontPanel({required bool isDo}) {
  final color = isDo ? Colors.green : Colors.red;
  final title = isDo ? 'DO' : 'DON\'T';
  final body = isDo
      ? 'Wrap with Builder only when something INSIDE needs a context that '
            'has the just-wrapped ancestor above it. Otherwise: no Builder.'
      : 'Builder(builder: (_) => Column(children: [ ... ]))\n'
            'with NO inherited-widget lookup inside. Pure ceremony.';
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isDo ? Icons.thumb_up : Icons.thumb_down,
              color: color,
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(body, style: const TextStyle(fontSize: 12.5)),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 11 — Performance note (Builder is cheap but does NOT memoise)
// ----------------------------------------------------------------------------
Widget _section11Performance() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F8E9),
      border: Border.all(color: const Color(0xFF558B2F), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 11 — Performance note',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF33691E),
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Builder is essentially a StatelessWidget with a single field. Its '
          'build cost is the cost of one closure call. No internal state, '
          'no caching, no dependency tracking beyond what the builder '
          'function itself reads.',
          style: TextStyle(fontSize: 13.0),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'However: Builder does NOT memoise its output. Each rebuild of the '
          'enclosing widget invokes the builder closure again. If the '
          'closure creates an expensive subtree, that subtree is recreated '
          'every time. For memoisation you want a separate StatelessWidget '
          'with explicit, hashable fields so Flutter can short-circuit the '
          'rebuild with operator==, or you want to lift the expensive child '
          'into a const widget where possible.',
          style: TextStyle(fontSize: 13.0),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Rule of thumb: reach for Builder when the subtree is cheap and '
          'context-sensitive. Reach for a real widget class when the subtree '
          'is expensive or independently reusable.',
          style: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 12 — Recap table
// ----------------------------------------------------------------------------
Widget _section12Recap() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      border: Border.all(color: const Color(0xFF283593), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 12 — Recap',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        const SizedBox(height: 12.0),
        _recapRow('Theme.of', 'use Builder under a Theme override'),
        _recapRow('MediaQuery.of', 'use Builder under a MediaQuery override'),
        _recapRow('Scaffold.of', 'use Builder under the Scaffold'),
        _recapRow(
          'DefaultTextStyle.of',
          'each Builder reads the local cascade level',
        ),
        _recapRow('IconTheme.of', 'nested Builders see nested icon themes'),
        _recapRow(
          'Directionality.of',
          'flip with Directionality + Builder',
        ),
        _recapRow(
          'Anti-pattern',
          'wrapping root in Builder with no .of inside',
        ),
        _recapRow(
          'Alternative',
          'extract to a widget so it has its own context',
        ),
        _recapRow(
          'Cost',
          'one closure call per rebuild, no memoisation',
        ),
      ],
    ),
  );
}

Widget _recapRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            key,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Entry point — single top-level build(context) returning a Container
// ----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('Builder visual demo build() begin');

  // Each section is a top-level helper function. The OUTER context is passed
  // to sections that want to demonstrate the contrast between "look up from
  // here" vs "look up from inside a Builder".
  final sections = <Widget>[
    _section1Header(),
    _section2ThemeOverride(context),
    _section3MediaQuery(context),
    _section4DefaultTextStyle(),
    _section5IconTheme(),
    _section6Directionality(),
    _section7ScaffoldOf(context),
    _section8Refactor(),
    _section9Nested(),
    _section10AntiPattern(),
    _section11Performance(),
    _section12Recap(),
  ];

  print('Builder visual demo build() composed ${sections.length} sections');

  return Container(
    color: const Color(0xFFFAFAFA),
    padding: const EdgeInsets.all(12.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Builder — Deep Visual Demo',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Twelve sections covering anatomy, Theme.of, MediaQuery.of, '
              'DefaultTextStyle.of, IconTheme.of, Directionality.of, '
              'Scaffold.of-style lookups, refactor counter-examples, '
              'nested Builders, the anti-pattern, performance notes, '
              'and a recap.',
              style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            ),
          ),
          for (int i = 0; i < sections.length; i++) ...[
            sections[i],
            const SizedBox(height: 16.0),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'End of Builder visual demo.',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF424242),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
