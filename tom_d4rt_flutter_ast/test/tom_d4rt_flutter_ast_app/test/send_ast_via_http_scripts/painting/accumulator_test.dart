// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for Accumulator from painting library
// Accumulator is a small mutable integer counter used internally by text
// painters when stepping through nested InlineSpan trees. This demo lays out
// its API, semantics, use cases, footguns, and reference behaviour.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Accumulator Deep Demo executing');

  // -----------------------------------------------------------------
  // Theme palette: amber + steel-blue accents to evoke "counting" and
  // "utility" simultaneously. We lock these once so every section can
  // reuse the same gradients and shadows.
  // -----------------------------------------------------------------
  const Color amberDeep = Color(0xFFE65100);
  const Color amberMid = Color(0xFFFB8C00);
  const Color amberSoft = Color(0xFFFFE0B2);
  const Color steelDeep = Color(0xFF263238);
  const Color steelMid = Color(0xFF455A64);
  const Color steelSoft = Color(0xFFCFD8DC);
  const Color cardSurface = Color(0xFFFFFDF7);
  const Color codeBg = Color(0xFF1E1E2E);
  const Color codeFg = Color(0xFFE0E0E0);
  const Color codeKw = Color(0xFFFFB74D);
  const Color codeNum = Color(0xFF80DEEA);
  const Color codeCmt = Color(0xFF6E7681);

  // -----------------------------------------------------------------
  // Reusable shadow catalog.
  // -----------------------------------------------------------------
  final BoxShadow shadowAmberSoft = BoxShadow(
    color: amberMid.withValues(alpha: 0.25),
    blurRadius: 14.0,
    offset: const Offset(0.0, 6.0),
  );
  final BoxShadow shadowAmberHard = BoxShadow(
    color: amberDeep.withValues(alpha: 0.35),
    blurRadius: 22.0,
    offset: const Offset(0.0, 10.0),
  );
  final BoxShadow shadowSteelSoft = BoxShadow(
    color: steelDeep.withValues(alpha: 0.18),
    blurRadius: 12.0,
    offset: const Offset(0.0, 4.0),
  );
  final BoxShadow shadowAccent = BoxShadow(
    color: const Color(0xFF00ACC1).withValues(alpha: 0.30),
    blurRadius: 16.0,
    offset: const Offset(0.0, 7.0),
  );
  final BoxShadow shadowDark = BoxShadow(
    color: Colors.black.withValues(alpha: 0.40),
    blurRadius: 18.0,
    offset: const Offset(0.0, 8.0),
  );

  // -----------------------------------------------------------------
  // Helper builders. Pure functions returning Widgets — no state.
  // -----------------------------------------------------------------
  Widget sectionHeader(String number, String title, IconData icon, Color tint) {
    return Container(
      margin: const EdgeInsets.only(top: 28.0, bottom: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tint.withValues(alpha: 0.95), tint.withValues(alpha: 0.65)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [shadowSteelSoft],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'SECTION $number',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                color: tint,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Icon(icon, color: Colors.white, size: 22.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chip(String text, Color color, {Color? textColor}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: textColor ?? color,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget valueChip(int value, Color color) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: 56.0,
      height: 56.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: 8.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        '$value',
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget paragraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13.0,
          height: 1.45,
          color: Color(0xFF37474F),
        ),
      ),
    );
  }

  Widget bullet(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6.0, right: 8.0),
            width: 7.0,
            height: 7.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.4,
                color: Color(0xFF37474F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget codeLine(List<TextSpan> spans) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.5,
            color: codeFg,
            height: 1.45,
          ),
          children: spans,
        ),
      ),
    );
  }

  TextSpan kw(String s) =>
      TextSpan(text: s, style: const TextStyle(color: codeKw));
  TextSpan num0(String s) =>
      TextSpan(text: s, style: const TextStyle(color: codeNum));
  TextSpan cmt(String s) => TextSpan(
    text: s,
    style: const TextStyle(color: codeCmt, fontStyle: FontStyle.italic),
  );
  TextSpan plain(String s) => TextSpan(text: s);

  Widget codeBlock(List<Widget> lines) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [codeBg, Color(0xFF11111B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFF313244), width: 1.0),
        boxShadow: [shadowDark],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: lines,
      ),
    );
  }

  Widget cardShell({
    required Widget child,
    required List<Color> gradient,
    required List<BoxShadow> shadows,
    Color? border,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: border != null
            ? Border.all(color: border, width: 1.4)
            : null,
        boxShadow: shadows,
      ),
      child: child,
    );
  }

  // ============ SECTION 1: Title banner ============
  print('=== Section 1: Title banner ===');

  final Widget section1 = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [amberDeep, amberMid, Color(0xFFFFB74D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [shadowAmberHard, shadowAmberSoft],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [shadowAmberSoft],
              ),
              child: const Icon(
                Icons.calculate_outlined,
                size: 36.0,
                color: amberDeep,
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Accumulator',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 4.0,
                          offset: const Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'package:flutter/painting.dart',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontFamily: 'monospace',
                      color: Colors.white.withValues(alpha: 0.92),
                      letterSpacing: 0.3,
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
            color: Colors.white.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.45),
              width: 1.0,
            ),
          ),
          child: const Text(
            'A minimal mutable integer counter used by text painters when '
            'stepping through nested InlineSpan trees. One field, one method, '
            'one job: keep adding.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.4,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: [
            chip('value : int', Colors.white, textColor: Colors.white),
            chip('increment(int)', Colors.white, textColor: Colors.white),
            chip('mutable', Colors.white, textColor: Colors.white),
            chip('reference type', Colors.white, textColor: Colors.white),
            chip('no constructor args', Colors.white, textColor: Colors.white),
          ],
        ),
      ],
    ),
  );

  // ============ SECTION 2: Anatomy diagram ============
  print('=== Section 2: Anatomy diagram ===');

  final Widget anatomyBox = Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFE0B2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: amberMid, width: 1.6),
      boxShadow: [shadowAmberSoft],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: amberDeep,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'class Accumulator',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            const Icon(Icons.tag, size: 18.0, color: amberDeep),
            const SizedBox(width: 6.0),
            const Text(
              'int value',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: steelDeep,
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: steelSoft,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'getter',
                style: TextStyle(fontSize: 10.0, color: steelDeep),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Row(
          children: [
            const Icon(Icons.arrow_circle_up, size: 18.0, color: amberDeep),
            const SizedBox(width: 6.0),
            const Text(
              'void increment(int addend)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: steelDeep,
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: amberMid,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'method',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            valueChip(0, amberMid),
            const Icon(Icons.arrow_forward, color: amberDeep),
            valueChip(7, amberDeep),
            const Icon(Icons.arrow_forward, color: amberDeep),
            valueChip(12, steelMid),
            const Icon(Icons.arrow_forward, color: amberDeep),
            valueChip(22, steelDeep),
          ],
        ),
        const SizedBox(height: 6.0),
        const Center(
          child: Text(
            'state transitions: 0 → +7 → +5 → +10',
            style: TextStyle(
              fontSize: 11.0,
              fontStyle: FontStyle.italic,
              color: steelMid,
            ),
          ),
        ),
      ],
    ),
  );

  final Widget section2 = cardShell(
    gradient: const [cardSurface, Color(0xFFFFF3E0)],
    shadows: [shadowAmberSoft],
    border: amberSoft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'Accumulator is a stripped-down counter. One mutable int field, '
          'one mutator method, no constructor args, no listeners. '
          'Below is the conceptual layout:',
        ),
        const SizedBox(height: 8.0),
        anatomyBox,
      ],
    ),
  );

  // ============ SECTION 3: Construction example ============
  print('=== Section 3: Construction ===');

  final Accumulator s3a = Accumulator();
  final Accumulator s3b = Accumulator();
  final int s3aInitial = s3a.value;
  final int s3bInitial = s3b.value;
  print('s3a initial: $s3aInitial');
  print('s3b initial: $s3bInitial');

  final Widget section3 = cardShell(
    gradient: const [cardSurface, Color(0xFFFFE0B2)],
    shadows: [shadowAmberSoft, shadowSteelSoft],
    border: amberMid,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'Construction is trivial. The default constructor takes nothing '
          'and produces an Accumulator whose value starts at 0.',
        ),
        codeBlock([
          codeLine([cmt('// Construct an Accumulator')]),
          codeLine([
            kw('final '),
            plain('a = '),
            kw('Accumulator'),
            plain('();'),
          ]),
          codeLine([
            kw('final '),
            plain('b = '),
            kw('Accumulator'),
            plain('();'),
          ]),
          codeLine([cmt('// Both start at 0')]),
          codeLine([
            plain('print(a.value); '),
            cmt('// '),
            num0('0'),
          ]),
          codeLine([
            plain('print(b.value); '),
            cmt('// '),
            num0('0'),
          ]),
        ]),
        const SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'a',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: amberDeep,
                  ),
                ),
                valueChip(s3aInitial, amberMid),
              ],
            ),
            const SizedBox(width: 24.0),
            Column(
              children: [
                Text(
                  'b',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: amberDeep,
                  ),
                ),
                valueChip(s3bInitial, steelMid),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ============ SECTION 4: Increment chain demo ============
  print('=== Section 4: Increment chain ===');

  // Build a deterministic series and capture snapshots after each step.
  // Snapshots are simple ints — we never iterate over Accumulator itself.
  final Accumulator chainAcc = Accumulator();
  final List<int> chainAddends = <int>[1, 2, 3, 5, 10];
  final List<int> chainSnapshots = <int>[];
  chainSnapshots.add(chainAcc.value);
  for (int i = 0; i < chainAddends.length; i++) {
    final int addend = chainAddends[i];
    chainAcc.increment(addend);
    chainSnapshots.add(chainAcc.value);
    print('after +$addend => ${chainAcc.value}');
  }

  final List<Widget> chainNodes = <Widget>[];
  for (int i = 0; i < chainSnapshots.length; i++) {
    final Color tint = i.isEven ? amberMid : steelMid;
    chainNodes.add(
      Column(
        children: [
          Text(
            i == 0 ? 'init' : '+${chainAddends[i - 1]}',
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: steelDeep,
              fontFamily: 'monospace',
            ),
          ),
          valueChip(chainSnapshots[i], tint),
        ],
      ),
    );
    if (i < chainSnapshots.length - 1) {
      chainNodes.add(
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(
            Icons.east,
            color: amberDeep,
            size: 22.0,
          ),
        ),
      );
    }
  }

  final Widget section4 = cardShell(
    gradient: const [cardSurface, Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
    shadows: [shadowAmberHard, shadowSteelSoft],
    border: amberDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'Apply a deterministic series of addends and capture the value '
          'at each step. Note: snapshots are plain ints — Accumulator is '
          'mutable, so we cannot keep references to the "old" object.',
        ),
        const SizedBox(height: 6.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: chainNodes,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: amberDeep.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: amberDeep.withValues(alpha: 0.40),
            ),
          ),
          child: Text(
            'Final value after applying $chainAddends: ${chainAcc.value}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: amberDeep,
            ),
          ),
        ),
      ],
    ),
  );

  // ============ SECTION 5: Why accumulators? ============
  print('=== Section 5: Rationale ===');

  final Widget section5 = cardShell(
    gradient: const [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
    shadows: [shadowAccent, shadowSteelSoft],
    border: const Color(0xFF1976D2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.psychology_outlined,
              color: Color(0xFF0D47A1),
              size: 20.0,
            ),
            const SizedBox(width: 6.0),
            const Text(
              'Why a class for a single int?',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        paragraph(
          'In Dart, primitive int values are immutable and copied by value. '
          'When you traverse a deep tree (e.g. nested InlineSpans) and need '
          'each branch to contribute to one running total, passing an int '
          'around is awkward — every recursion would have to return the '
          'updated value and the caller would have to thread it back in.',
        ),
        paragraph(
          'Accumulator solves this by being a tiny boxed counter. Pass the '
          'same instance into every recursive call and let each branch '
          'increment it freely. The mutability is the feature.',
        ),
        const SizedBox(height: 4.0),
        bullet(
          'Counting characters across nested InlineSpan trees',
          const Color(0xFF1976D2),
        ),
        bullet(
          'Accumulating widget pixel offsets while walking children',
          const Color(0xFF1976D2),
        ),
        bullet(
          'Tracking a global sequence index during a recursive layout',
          const Color(0xFF1976D2),
        ),
        bullet(
          'Sharing a counter between siblings without a return-value chain',
          const Color(0xFF1976D2),
        ),
      ],
    ),
  );

  // ============ SECTION 6: Reference vs value semantics ============
  print('=== Section 6: Reference semantics ===');

  final Accumulator refSource = Accumulator();
  refSource.increment(42);
  // Aliasing: refAlias points to the same Accumulator object.
  final Accumulator refAlias = refSource;
  refAlias.increment(8);
  print('refSource.value = ${refSource.value}');
  print('refAlias.value  = ${refAlias.value}');
  // The int value is copied (value semantics).
  final int copiedInt = refSource.value;
  print('copiedInt = $copiedInt');

  final Widget section6 = cardShell(
    gradient: const [Color(0xFFFFFDF7), Color(0xFFFFE0B2)],
    shadows: [shadowAmberSoft, shadowSteelSoft],
    border: amberMid,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'Accumulator is a regular Dart object. Variables holding it are '
          'references; assigning one variable to another does not copy the '
          'underlying counter. Reading .value, on the other hand, gives '
          'you a plain int — a value type.',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(right: 6.0),
                decoration: BoxDecoration(
                  color: amberSoft.withValues(alpha: 0.60),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: amberDeep, width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'reference (Accumulator)',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: amberDeep,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'refSource = $refSource\n'
                      'refAlias  → same object\n'
                      'refSource.value = ${refSource.value}\n'
                      'refAlias.value  = ${refAlias.value}\n'
                      'identical(a, b) ? ${identical(refSource, refAlias)}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        height: 1.45,
                        color: steelDeep,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(left: 6.0),
                decoration: BoxDecoration(
                  color: steelSoft.withValues(alpha: 0.60),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: steelDeep, width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'value (int copy)',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: steelDeep,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'copiedInt = $copiedInt\n'
                      '... future increments\n'
                      'on refSource will NOT\n'
                      'change copiedInt.',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        height: 1.45,
                        color: steelDeep,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============ SECTION 7: Plain int vs Accumulator ============
  print('=== Section 7: Comparison ===');

  // Demonstrate both styles producing the same total.
  int rollingInt = 0;
  rollingInt += 1;
  rollingInt += 2;
  rollingInt += 3;
  rollingInt += 5;
  rollingInt += 10;

  final Accumulator rollingAcc = Accumulator();
  rollingAcc.increment(1);
  rollingAcc.increment(2);
  rollingAcc.increment(3);
  rollingAcc.increment(5);
  rollingAcc.increment(10);
  print('rollingInt=$rollingInt rollingAcc=${rollingAcc.value}');

  final Widget section7 = cardShell(
    gradient: const [cardSurface, Color(0xFFECEFF1)],
    shadows: [shadowSteelSoft, shadowAmberSoft],
    border: steelMid,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'When the running total is local, a plain int is simpler. When '
          'the same counter must be threaded through deep recursion or '
          'shared between collaborators, Accumulator avoids return-value '
          'plumbing.',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 6.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFCFD8DC), Color(0xFFB0BEC5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: steelDeep, width: 1.2),
                  boxShadow: [shadowSteelSoft],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'plain int',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: steelDeep,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'int total = 0;\n'
                      'total += 1;\n'
                      'total += 2;\n'
                      'total += 3;\n'
                      'total += 5;\n'
                      'total += 10;',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        height: 1.4,
                        color: steelDeep,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'result = $rollingInt',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: steelDeep,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 6.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFE0B2), Color(0xFFFFB74D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: amberDeep, width: 1.2),
                  boxShadow: [shadowAmberSoft],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Accumulator',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: amberDeep,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'final a = Accumulator();\n'
                      'a.increment(1);\n'
                      'a.increment(2);\n'
                      'a.increment(3);\n'
                      'a.increment(5);\n'
                      'a.increment(10);',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        height: 1.4,
                        color: amberDeep,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'a.value = ${rollingAcc.value}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: amberDeep,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: [
            chip('local sums → int', steelDeep),
            chip('deep recursion → Accumulator', amberDeep),
            chip('multiple collaborators → Accumulator', amberDeep),
            chip('one-line totals → int', steelDeep),
          ],
        ),
      ],
    ),
  );

  // ============ SECTION 8: Use cases ============
  print('=== Section 8: Use cases ===');

  // Real callers (illustrative): paint character indices, semantic offsets,
  // accumulate child sizes during a custom layout pass.
  final List<Map<String, String>> useCases = <Map<String, String>>[
    <String, String>{
      'icon': 'text',
      'title': 'TextPainter / InlineSpan',
      'desc':
          'Internal callers walk InlineSpan trees and pass an Accumulator '
          'down to count plain-text characters across nested spans.',
    },
    <String, String>{
      'icon': 'layers',
      'title': 'Semantic offset tracking',
      'desc':
          'When emitting accessibility nodes, an Accumulator can be used '
          'to assign monotonically increasing offsets across a subtree.',
    },
    <String, String>{
      'icon': 'sum',
      'title': 'Recursive size sums',
      'desc':
          'Custom layout code can pass an Accumulator into a recursive '
          'visitor that contributes pixel widths or item counts.',
    },
    <String, String>{
      'icon': 'tag',
      'title': 'Sequence numbering',
      'desc':
          'Walk a tree and stamp each leaf with the next id without '
          'plumbing the next id back up the call stack.',
    },
  ];

  final List<Widget> useCaseCards = <Widget>[];
  for (int i = 0; i < useCases.length; i++) {
    final Map<String, String> u = useCases[i];
    final Color tint = i.isEven ? amberDeep : steelDeep;
    final IconData icon = i == 0
        ? Icons.text_fields
        : i == 1
        ? Icons.layers_outlined
        : i == 2
        ? Icons.functions
        : Icons.tag;
    useCaseCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tint.withValues(alpha: 0.08),
              tint.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: tint.withValues(alpha: 0.45)),
          boxShadow: [
            BoxShadow(
              color: tint.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: tint.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: tint, size: 22.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    u['title']!,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: tint,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    u['desc']!,
                    style: const TextStyle(
                      fontSize: 12.0,
                      height: 1.4,
                      color: steelDeep,
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

  final Widget section8 = cardShell(
    gradient: const [cardSurface, Color(0xFFFFF8E1)],
    shadows: [shadowAmberSoft, shadowSteelSoft],
    border: amberSoft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: useCaseCards,
    ),
  );

  // ============ SECTION 9: Code snippets ============
  print('=== Section 9: Code snippets ===');

  final Widget snippetBasic = codeBlock([
    codeLine([cmt('// 1. basic usage')]),
    codeLine([
      kw('final '),
      plain('a = '),
      kw('Accumulator'),
      plain('();'),
    ]),
    codeLine([plain('a.increment('), num0('1'), plain(');')]),
    codeLine([plain('a.increment('), num0('4'), plain(');')]),
    codeLine([plain('a.increment('), num0('9'), plain(');')]),
    codeLine([plain('print(a.value); '), cmt('// '), num0('14')]),
  ]);

  final Widget snippetThread = codeBlock([
    codeLine([cmt('// 2. thread one Accumulator through recursion')]),
    codeLine([
      kw('void '),
      plain('walk('),
      kw('Node '),
      plain('n, '),
      kw('Accumulator '),
      plain('total) {'),
    ]),
    codeLine([plain('  total.increment(n.weight);')]),
    codeLine([
      kw('  for '),
      plain('('),
      kw('final '),
      plain('child '),
      kw('in '),
      plain('n.children) {'),
    ]),
    codeLine([plain('    walk(child, total);')]),
    codeLine([plain('  }')]),
    codeLine([plain('}')]),
    codeLine([plain('')]),
    codeLine([
      kw('final '),
      plain('total = '),
      kw('Accumulator'),
      plain('();'),
    ]),
    codeLine([plain('walk(root, total);')]),
    codeLine([plain('print(total.value);')]),
  ]);

  final Widget snippetReuse = codeBlock([
    codeLine([cmt('// 3. reuse the same Accumulator across passes')]),
    codeLine([
      kw('final '),
      plain('a = '),
      kw('Accumulator'),
      plain('();'),
    ]),
    codeLine([plain('a.increment('), num0('5'), plain(');')]),
    codeLine([plain('print(a.value); '), cmt('// '), num0('5')]),
    codeLine([plain('a.increment('), num0('5'), plain(');')]),
    codeLine([plain('print(a.value); '), cmt('// '), num0('10')]),
    codeLine([cmt('// (no .reset() — make a new Accumulator() instead)')]),
  ]);

  final Widget section9 = cardShell(
    gradient: const [cardSurface, Color(0xFFECEFF1)],
    shadows: [shadowDark, shadowSteelSoft],
    border: steelMid,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'Three short snippets covering the most common shapes of code '
          'you will write when using Accumulator.',
        ),
        snippetBasic,
        snippetThread,
        snippetReuse,
      ],
    ),
  );

  // ============ SECTION 10: Footguns ============
  print('=== Section 10: Footguns ===');

  final List<Map<String, String>> footguns = <Map<String, String>>[
    <String, String>{
      'title': 'Forgetting to share the same instance',
      'desc':
          'Each recursion level must receive the SAME Accumulator. Creating '
          'a new one inside the recursive function silently breaks the sum '
          'and you will only count one level.',
    },
    <String, String>{
      'title': 'Treating it as immutable',
      'desc':
          'Accumulator does not make a copy when assigned. If you store an '
          'Accumulator now and read .value later, the value will reflect '
          'every increment that happened in between.',
    },
    <String, String>{
      'title': 'No reset method',
      'desc':
          'Accumulator has no zero() or reset(). When a fresh count is '
          'needed, allocate a new Accumulator() — do not try to subtract '
          'value back to zero.',
    },
    <String, String>{
      'title': 'Negative addends',
      'desc':
          'increment(-1) is allowed. Sometimes useful (e.g. unwinding), '
          'but if your invariant is "monotonically increasing", a stray '
          'minus sign will silently break it.',
    },
    <String, String>{
      'title': 'Confusing it with ValueNotifier',
      'desc':
          'Accumulator is NOT a ChangeNotifier. Mutating its value will '
          'not trigger any rebuild. Use a ValueNotifier<int> if you need '
          'reactive UI updates.',
    },
  ];

  final List<Widget> footgunRows = <Widget>[];
  for (int i = 0; i < footguns.length; i++) {
    final Map<String, String> f = footguns[i];
    footgunRows.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: const Color(0xFFC62828), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFC62828).withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(7.0),
              decoration: const BoxDecoration(
                color: Color(0xFFC62828),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.white,
                size: 16.0,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f['title']!,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    f['desc']!,
                    style: const TextStyle(
                      fontSize: 12.0,
                      height: 1.4,
                      color: Color(0xFF4A148C),
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

  // Show a small worked example for the negative-addend case.
  final Accumulator negDemo = Accumulator();
  negDemo.increment(10);
  negDemo.increment(-3);
  negDemo.increment(-2);
  print('negDemo = ${negDemo.value}');

  final Widget section10 = cardShell(
    gradient: const [cardSurface, Color(0xFFFFEBEE)],
    shadows: [shadowAmberSoft, shadowSteelSoft],
    border: const Color(0xFFC62828),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'Pitfalls. Most are about Accumulator being a deliberately tiny, '
          'unopinionated mutable container — it has no guardrails.',
        ),
        ...footgunRows,
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: amberDeep, width: 1.2),
          ),
          child: Text(
            'Negative addend demo: 10 + (-3) + (-2) = ${negDemo.value}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: amberDeep,
            ),
          ),
        ),
      ],
    ),
  );

  // ============ SECTION 11: Recap ============
  print('=== Section 11: Recap ===');

  final List<Map<String, String>> recap = <Map<String, String>>[
    <String, String>{'k': 'Library', 'v': 'package:flutter/painting.dart'},
    <String, String>{'k': 'Constructor', 'v': 'Accumulator() — no args'},
    <String, String>{'k': 'Initial value', 'v': '0'},
    <String, String>{'k': 'Field', 'v': 'int value (read-only getter)'},
    <String, String>{'k': 'Method', 'v': 'void increment(int addend)'},
    <String, String>{'k': 'Mutability', 'v': 'mutable, reference-typed'},
    <String, String>{'k': 'Reactivity', 'v': 'none — not a ChangeNotifier'},
    <String, String>{'k': 'Reset?', 'v': 'no — allocate a new instance'},
    <String, String>{'k': 'Negative addends', 'v': 'allowed'},
    <String, String>{'k': 'Typical caller', 'v': 'TextPainter / InlineSpan'},
  ];

  final List<Widget> recapRows = <Widget>[];
  for (int i = 0; i < recap.length; i++) {
    final Map<String, String> r = recap[i];
    final bool zebra = i.isEven;
    recapRows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
        color: zebra
            ? Colors.white.withValues(alpha: 0.85)
            : amberSoft.withValues(alpha: 0.45),
        child: Row(
          children: [
            SizedBox(
              width: 130.0,
              child: Text(
                r['k']!,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  color: amberDeep,
                ),
              ),
            ),
            Expanded(
              child: Text(
                r['v']!,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: steelDeep,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section11 = cardShell(
    gradient: const [cardSurface, Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
    shadows: [shadowAmberHard, shadowSteelSoft, shadowAccent],
    border: amberDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.fact_check_outlined,
              color: amberDeep,
              size: 22.0,
            ),
            const SizedBox(width: 6.0),
            const Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w800,
                color: amberDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(children: recapRows),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: [
            chip('1 field', amberDeep),
            chip('1 method', amberDeep),
            chip('0 events', steelDeep),
            chip('0 surprises', steelDeep),
          ],
        ),
      ],
    ),
  );

  // -----------------------------------------------------------------
  // Final layout
  // -----------------------------------------------------------------
  print('Accumulator Deep Demo build complete');

  return Scaffold(
    backgroundColor: const Color(0xFFFFFBF2),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          section1,
          sectionHeader(
            '2',
            'Anatomy: one field, one method',
            Icons.account_tree_outlined,
            amberDeep,
          ),
          section2,
          sectionHeader(
            '3',
            'Construction: zero-arg constructor',
            Icons.build_outlined,
            amberMid,
          ),
          section3,
          sectionHeader(
            '4',
            'Increment chain: deterministic series',
            Icons.timeline,
            amberDeep,
          ),
          section4,
          sectionHeader(
            '5',
            'Why accumulators?',
            Icons.psychology_outlined,
            const Color(0xFF1976D2),
          ),
          section5,
          sectionHeader(
            '6',
            'Reference vs value semantics',
            Icons.swap_horiz,
            amberMid,
          ),
          section6,
          sectionHeader(
            '7',
            'Plain int vs Accumulator',
            Icons.compare_arrows,
            steelMid,
          ),
          section7,
          sectionHeader(
            '8',
            'Use cases in the framework',
            Icons.apps,
            amberDeep,
          ),
          section8,
          sectionHeader('9', 'Code snippets', Icons.code, steelDeep),
          section9,
          sectionHeader(
            '10',
            'Footguns and edge cases',
            Icons.warning_amber_rounded,
            const Color(0xFFC62828),
          ),
          section10,
          sectionHeader(
            '11',
            'Recap and quick reference',
            Icons.fact_check_outlined,
            amberDeep,
          ),
          section11,
          const SizedBox(height: 24.0),
          Center(
            child: Text(
              'End of Accumulator Deep Demo',
              style: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                color: steelMid.withValues(alpha: 0.85),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    ),
  );
}
