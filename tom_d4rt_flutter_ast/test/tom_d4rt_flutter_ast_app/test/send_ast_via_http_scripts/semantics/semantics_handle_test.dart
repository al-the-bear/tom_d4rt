// ignore_for_file: avoid_print
// D4rt deep demo: SemanticsHandle
// Demonstrates how SemanticsHandle keeps the semantics pipeline active,
// reference-counting lifecycle, and its role in accessibility tooling.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Amber / Honey palette ───
  const Color amber = Color(0xFFFFBF00);
  const Color honey = Color(0xFFEB9E34);
  const Color beeswax = Color(0xFFFFF8DC);
  const Color darkAmber = Color(0xFF7A5C00);
  const Color goldenrod = Color(0xFFDAA520);
  const Color honeycomb = Color(0xFFF5C842);
  const Color warmBrown = Color(0xFF8B6914);
  const Color paleGold = Color(0xFFFAEBCD);
  const Color royalGold = Color(0xFFCDA000);
  const Color caramel = Color(0xFFC68E17);

  // ─── Helper builders ───
  Widget shHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkAmber, honey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: darkAmber.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 3),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12, color: Colors.white.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget shCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: beeswax,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: goldenrod.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: honey.withValues(alpha: 0.12),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget shLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: darkAmber.withValues(alpha: 0.9))),
    );
  }

  Widget shDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              amber.withValues(alpha: 0.0),
              amber.withValues(alpha: 0.5),
              amber.withValues(alpha: 0.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget shBadge(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white)),
    );
  }

  Widget shCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: darkAmber.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: darkAmber.withValues(alpha: 0.2)),
      ),
      child: Text(code,
          style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: darkAmber.withValues(alpha: 0.85),
              height: 1.5)),
    );
  }

  Widget shFlowBox(String text, Color bg, {double width = 140}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: darkAmber.withValues(alpha: 0.3)),
      ),
      child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget shArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.arrow_forward, size: 16, color: Colors.black54),
    );
  }

  Widget shDownArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Icon(Icons.arrow_downward, size: 16, color: Colors.black54),
    );
  }

  // ─────────────────────────────────────────────────────────
  // Section 1: What Is SemanticsHandle?
  // ─────────────────────────────────────────────────────────
  print('sh01 | Section 1: What Is SemanticsHandle?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('1. What Is SemanticsHandle?',
          'The reference-counted token that keeps semantics alive'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Purpose'),
        const Text(
          'SemanticsHandle is a lightweight object returned by '
          'SemanticsBinding.instance.ensureSemantics(). While at least one '
          'handle exists, the semantics tree is kept active — the framework '
          'compiles semantic data every frame and sends it to the platform.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 12),
        shLabel('Key Characteristics'),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: amber.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.token, size: 28, color: Color(0xFF7A5C00)),
                    SizedBox(height: 6),
                    Text('Reference Token',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(height: 3),
                    Text('Acts as a keep-alive\nfor the semantics tree',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: honeycomb.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.recycling, size: 28, color: Color(0xFF7A5C00)),
                    SizedBox(height: 6),
                    Text('Disposable',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(height: 3),
                    Text('Call dispose() when\nsemantics no longer needed',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: paleGold.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.countertops, size: 28, color: Color(0xFF7A5C00)),
                    SizedBox(height: 6),
                    Text('Ref-Counted',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(height: 3),
                    Text('Multiple handles can\ncoexist independently',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
      shCard([
        shLabel('API Surface'),
        shCodeBlock(
          'class SemanticsHandle {\n'
          '  /// Callback invoked when the handle\n'
          '  /// is disposed.\n'
          '  final VoidCallback? _onDispose;\n'
          '\n'
          '  /// Releases this handle. When the last\n'
          '  /// handle is disposed, semantics may\n'
          '  /// be deactivated.\n'
          '  void dispose();\n'
          '}',
        ),
        const SizedBox(height: 8),
        const Text(
          'SemanticsHandle is intentionally minimal — it has a single '
          'method: dispose(). Its power comes from the reference-counting '
          'mechanism it participates in within SemanticsBinding.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
      ]),
    ],
  );

  print('sh01 | Section 1 complete');

  // ─────────────────────────────────────────────────────────
  // Section 2: The ensureSemantics() Lifecycle
  // ─────────────────────────────────────────────────────────
  print('sh02 | Section 2: ensureSemantics() Lifecycle');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('2. The ensureSemantics() Lifecycle',
          'How handles are created and what they trigger'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Creation Flow'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              shFlowBox('Call\nensureSemantics()', amber.withValues(alpha: 0.2)),
              shArrow(),
              shFlowBox('SemanticsHandle\ncreated', honeycomb.withValues(alpha: 0.3)),
              shArrow(),
              shFlowBox('Ref count\nincremented', goldenrod.withValues(alpha: 0.2)),
              shArrow(),
              shFlowBox('Semantics\nactivated', paleGold),
            ],
          ),
        ),
        const SizedBox(height: 12),
        shCodeBlock(
          '// Typical usage:\n'
          'final handle = SemanticsBinding\n'
          '    .instance.ensureSemantics();\n'
          '\n'
          '// ... use semantics ...\n'
          '\n'
          'handle.dispose(); // release when done',
        ),
      ]),
      shCard([
        shLabel('What Happens Internally'),
        const Text(
          'When ensureSemantics() is called:\n'
          '1. A new SemanticsHandle is allocated\n'
          '2. The internal reference counter increments\n'
          '3. If this is the first handle, the semantics\n'
          '   pipeline is activated — the PipelineOwner begins\n'
          '   compiling SemanticsNode trees each frame\n'
          '4. Semantic data flows to the platform (for\n'
          '   screen readers, accessibility services)',
          style: TextStyle(fontSize: 12, height: 1.6),
        ),
        const SizedBox(height: 10),
        // Visual: activation state
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.block, size: 24, color: Colors.red),
                    SizedBox(height: 4),
                    Text('Before ensureSemantics',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    Text('Semantics pipeline IDLE',
                        style: TextStyle(fontSize: 10, color: Colors.red)),
                    Text('No tree compilation',
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.double_arrow, color: Colors.orange, size: 24),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.check_circle, size: 24, color: Colors.green),
                    SizedBox(height: 4),
                    Text('After ensureSemantics',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    Text('Semantics pipeline ACTIVE',
                        style: TextStyle(fontSize: 10, color: Colors.green)),
                    Text('Tree compiled every frame',
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    ],
  );

  print('sh02 | Section 2 complete');

  // ─────────────────────────────────────────────────────────
  // Section 3: dispose() — Releasing a Handle
  // ─────────────────────────────────────────────────────────
  print('sh03 | Section 3: dispose() Flow');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('3. dispose() — Releasing a Handle',
          'What happens when a handle is disposed'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Disposal Flow'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              shFlowBox('handle.dispose()', Colors.orange.withValues(alpha: 0.2)),
              shArrow(),
              shFlowBox('Ref count\ndecremented', amber.withValues(alpha: 0.2)),
              shArrow(),
              shFlowBox('Count == 0?', honeycomb.withValues(alpha: 0.25)),
              shArrow(),
              shFlowBox('Deactivate\nsemantics', Colors.red.withValues(alpha: 0.15)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Disposing a handle does NOT immediately disable semantics — '
          'it only decrements the reference count. Semantics are only '
          'deactivated when the LAST handle is disposed AND no platform '
          'accessibility service requested semantics.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
      ]),
      shCard([
        shLabel('Dispose vs Deactivate Decision Tree'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: warmBrown.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              shFlowBox('handle.dispose() called', amber.withValues(alpha: 0.15), width: 200),
              shDownArrow(),
              shFlowBox('refCount -= 1', goldenrod.withValues(alpha: 0.15), width: 200),
              shDownArrow(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('refCount > 0',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 4),
                      const Text('Semantics stay\nactive',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: Colors.green)),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('refCount == 0',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 4),
                      const Text('Check platform\nrequest...',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: Colors.orange)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
      shCard([
        shLabel('The _onDispose Callback'),
        const Text(
          'SemanticsHandle stores an optional VoidCallback (_onDispose) '
          'that is invoked exactly once when dispose() is called. This '
          'callback allows SemanticsBinding to perform cleanup logic — '
          'such as scheduling a check of whether the semantics pipeline '
          'should be torn down.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 8),
        shCodeBlock(
          '// Inside SemanticsBinding:\n'
          'SemanticsHandle ensureSemantics() {\n'
          '  _outstandingHandles++;\n'
          '  _semanticsEnabled = true;\n'
          '  return SemanticsHandle._(\n'
          '    _onDispose: _handleSemanticsHandleDisposed,\n'
          '  );\n'
          '}\n'
          '\n'
          'void _handleSemanticsHandleDisposed() {\n'
          '  _outstandingHandles--;\n'
          '  _updateSemantics();\n'
          '}',
        ),
      ]),
    ],
  );

  print('sh03 | Section 3 complete');

  // ─────────────────────────────────────────────────────────
  // Section 4: Reference Counting with Multiple Handles
  // ─────────────────────────────────────────────────────────
  print('sh04 | Section 4: Reference Counting');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('4. Reference Counting — Multiple Handles',
          'Each consumer independently keeps semantics alive'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Multiple Handle Scenario'),
        const Text(
          'Different parts of your app may need semantics independently. '
          'Each call to ensureSemantics() returns a unique handle. The '
          'semantics pipeline remains active until ALL handles are disposed.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 12),
        // Visual timeline of handles
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: warmBrown.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Handle Timeline',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              // Time axis
              Row(
                children: [
                  const Text('t=0', style: TextStyle(fontSize: 10)),
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      color: Colors.black26,
                    ),
                  ),
                  const Text('t=5', style: TextStyle(fontSize: 10)),
                ],
              ),
              const SizedBox(height: 8),
              // Handle A bar
              Row(
                children: [
                  const SizedBox(
                      width: 60,
                      child: Text('Handle A',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600))),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: amber.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: const Text('active (t=0 → t=3)',
                          style: TextStyle(fontSize: 9)),
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                ],
              ),
              const SizedBox(height: 4),
              // Handle B bar
              Row(
                children: [
                  const SizedBox(
                      width: 60,
                      child: Text('Handle B',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600))),
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: honeycomb.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: const Text('active (t=1 → t=5)',
                          style: TextStyle(fontSize: 9)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Semantics state bar
              Row(
                children: [
                  const SizedBox(
                      width: 60,
                      child: Text('Semantics',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600))),
                  Expanded(
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: const Text('pipeline active entire span (t=0 → t=5)',
                          style: TextStyle(fontSize: 9)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Even though Handle A is disposed at t=3, Handle B keeps '
                'semantics running until t=5.',
                style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ]),
      shCard([
        shLabel('Reference Count Transitions'),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    const Text('t=0', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: amber.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text('1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 4),
                    const Text('+A', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: honeycomb.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    const Text('t=1', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: honeycomb.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text('2', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 4),
                    const Text('+B', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: goldenrod.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    const Text('t=3', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: goldenrod.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text('1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 4),
                    const Text('-A', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    const Text('t=5', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text('0', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 4),
                    const Text('-B', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    ],
  );

  print('sh04 | Section 4 complete');

  // ─────────────────────────────────────────────────────────
  // Section 5: When Semantics Get Enabled / Disabled
  // ─────────────────────────────────────────────────────────
  print('sh05 | Section 5: Semantics Enabled / Disabled');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('5. When Semantics Get Enabled / Disabled',
          'Two paths to semantic activation'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Two Activation Paths'),
        const Text(
          'Semantics can be activated by two independent mechanisms:',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: amber.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: amber.withValues(alpha: 0.4)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.code, size: 26, color: Color(0xFF7A5C00)),
                    SizedBox(height: 6),
                    Text('Path 1: App Code',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(
                      'Explicit call to\n'
                      'ensureSemantics()\n'
                      'returns a handle',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: honeycomb.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: honeycomb.withValues(alpha: 0.5)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.accessibility_new, size: 26, color: Color(0xFF7A5C00)),
                    SizedBox(height: 6),
                    Text('Path 2: Platform',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(
                      'Screen reader\n'
                      '(TalkBack/VoiceOver)\n'
                      'requests semantics',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Both paths set _semanticsEnabled = true. Semantics stay active '
          'as long as EITHER path is still requesting them. Only when both '
          'all handles are disposed AND the platform stops requesting '
          'semantics will the pipeline be deactivated.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
      ]),
      shCard([
        shLabel('Deactivation Conditions'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('handle count == 0',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('AND', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('platform not requesting',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Icon(Icons.arrow_downward, size: 18, color: Colors.red),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('Semantics DEACTIVATED',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)),
              ),
            ],
          ),
        ),
      ]),
    ],
  );

  print('sh05 | Section 5 complete');

  // ─────────────────────────────────────────────────────────
  // Section 6: Relationship to SemanticsBinding
  // ─────────────────────────────────────────────────────────
  print('sh06 | Section 6: SemanticsBinding Relationship');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('6. Relationship to SemanticsBinding',
          'The binding that creates and manages handles'),
      const SizedBox(height: 10),
      shCard([
        shLabel('SemanticsBinding Members for Handle Management'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: darkAmber.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              // Table header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: darkAmber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    Expanded(flex: 3, child: Text('Member',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                    Expanded(flex: 5, child: Text('Role',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              _shTableRow('ensureSemantics()', 'Creates & returns a new handle'),
              _shTableRow('_outstandingHandles', 'Internal counter of active handles'),
              _shTableRow('_semanticsEnabled', 'Master flag for pipeline'),
              _shTableRow('_updateSemantics()', 'Evaluates if pipeline should toggle'),
              _shTableRow('semanticsEnabled', 'Public getter for pipeline state'),
            ],
          ),
        ),
      ]),
      shCard([
        shLabel('Binding ↔ Handle Interaction Visual'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: amber.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: honey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: honey.withValues(alpha: 0.4)),
                ),
                child: Column(
                  children: [
                    const Text('SemanticsBinding',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        shBadge('_outstandingHandles: 2', warmBrown),
                        shBadge('_semanticsEnabled: true', Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.arrow_upward, size: 14, color: Colors.grey),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: amber.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Handle 1\n(Widget A)',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.arrow_upward, size: 14, color: Colors.grey),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: honeycomb.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Handle 2\n(Test Suite)',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    ],
  );

  print('sh06 | Section 6 complete');

  // ─────────────────────────────────────────────────────────
  // Section 7: SemanticsOwner Role
  // ─────────────────────────────────────────────────────────
  print('sh07 | Section 7: SemanticsOwner');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('7. SemanticsOwner Role',
          'The object that manages the semantics tree once activated'),
      const SizedBox(height: 10),
      shCard([
        shLabel('What Does SemanticsOwner Do?'),
        const Text(
          'When semantics are activated (via handles or platform request), '
          'a SemanticsOwner is created within the PipelineOwner. It:\n'
          '\n'
          '• Manages the root SemanticsNode\n'
          '• Processes dirty nodes during flushSemantics()\n'
          '• Sends the compiled SemanticsUpdate to the engine\n'
          '• Handles dispose of the semantics tree',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              shFlowBox('SemanticsHandle\nkeeps alive', amber.withValues(alpha: 0.15)),
              shArrow(),
              shFlowBox('SemanticsBinding\nactivates', honeycomb.withValues(alpha: 0.2)),
              shArrow(),
              shFlowBox('PipelineOwner\ncreates', goldenrod.withValues(alpha: 0.15)),
              shArrow(),
              shFlowBox('SemanticsOwner\nmanages tree', paleGold),
            ],
          ),
        ),
      ]),
      shCard([
        shLabel('SemanticsOwner vs SemanticsHandle'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Column(
                  children: [
                    Text('SemanticsHandle',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('• Lightweight token\n'
                        '• No tree access\n'
                        '• Only has dispose()\n'
                        '• Consumer-facing\n'
                        '• Can be many',
                        style: TextStyle(fontSize: 10, height: 1.4)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: honeycomb.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Column(
                  children: [
                    Text('SemanticsOwner',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('• Heavy-weight manager\n'
                        '• Owns the tree root\n'
                        '• Flushes/compiles\n'
                        '• Framework internal\n'
                        '• Singleton per pipeline',
                        style: TextStyle(fontSize: 10, height: 1.4)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    ],
  );

  print('sh07 | Section 7 complete');

  // ─────────────────────────────────────────────────────────
  // Section 8: Handle Creation Patterns
  // ─────────────────────────────────────────────────────────
  print('sh08 | Section 8: Handle Creation Patterns');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('8. Handle Creation Patterns',
          'Common patterns for using SemanticsHandle in practice'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Pattern 1: Widget Lifecycle'),
        shCodeBlock(
          'class _MyAccessibleWidgetState\n'
          '    extends State<MyAccessibleWidget> {\n'
          '  late SemanticsHandle _handle;\n'
          '\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    _handle = SemanticsBinding\n'
          '        .instance.ensureSemantics();\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  void dispose() {\n'
          '    _handle.dispose();\n'
          '    super.dispose();\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 6),
        const Text(
          'Tie the handle to initState/dispose for widgets that need '
          'guaranteed semantic data during their entire lifetime.',
          style: TextStyle(fontSize: 11, height: 1.4),
        ),
      ]),
      shCard([
        shLabel('Pattern 2: Test Setup'),
        shCodeBlock(
          'void main() {\n'
          '  late SemanticsHandle handle;\n'
          '\n'
          '  setUp(() {\n'
          '    handle = WidgetsBinding.instance\n'
          '        .ensureSemantics();\n'
          '  });\n'
          '\n'
          '  tearDown(() {\n'
          '    handle.dispose();\n'
          '  });\n'
          '\n'
          '  testWidgets(\'check a11y\',\n'
          '    (tester) async {\n'
          '      // semantics guaranteed active\n'
          '    },\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 6),
        const Text(
          'In widget tests, acquire a handle in setUp() and dispose in '
          'tearDown() so every test in the group runs with semantics active.',
          style: TextStyle(fontSize: 11, height: 1.4),
        ),
      ]),
      shCard([
        shLabel('Pattern 3: Scoped Access'),
        shCodeBlock(
          'Future<void> analyzeSemanticsTree() {\n'
          '  final handle = SemanticsBinding\n'
          '      .instance.ensureSemantics();\n'
          '  try {\n'
          '    // read semantics tree...\n'
          '    return Future.value();\n'
          '  } finally {\n'
          '    handle.dispose();\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 6),
        const Text(
          'For short-lived access, use try/finally to guarantee the handle '
          'is always disposed, even if an exception occurs.',
          style: TextStyle(fontSize: 11, height: 1.4),
        ),
      ]),
      shCard([
        shLabel('Pattern Comparison'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: darkAmber.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: darkAmber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    Expanded(flex: 2, child: Text('Pattern',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text('Lifetime',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                    Expanded(flex: 3, child: Text('Best For',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              _shPatternRow('Widget', 'Widget lifecycle', 'A11y-critical UI'),
              _shPatternRow('Test', 'Test group scope', 'Widget testing'),
              _shPatternRow('Scoped', 'Single operation', 'Diagnostics'),
            ],
          ),
        ),
      ]),
    ],
  );

  print('sh08 | Section 8 complete');

  // ─────────────────────────────────────────────────────────
  // Section 9: Real-World — Screen Readers & Testing
  // ─────────────────────────────────────────────────────────
  print('sh09 | Section 9: Screen Readers & Testing');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('9. Real-World: Screen Readers & Testing',
          'Where SemanticsHandle matters most in practice'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Screen Reader Integration'),
        const Text(
          'When a screen reader (VoiceOver on iOS, TalkBack on Android) '
          'is active, the platform itself requests semantics — no handle '
          'needed from app code. The framework detects this via '
          'AccessibilityFeatures and activates the pipeline automatically.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.phone_iphone, size: 28, color: Color(0xFF2196F3)),
                    SizedBox(height: 6),
                    Text('iOS / VoiceOver',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    Text('Platform → accessibility\nflags → auto-enable',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.phone_android, size: 28, color: Colors.green),
                    SizedBox(height: 6),
                    Text('Android / TalkBack',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    Text('Platform → accessibility\nflags → auto-enable',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.bug_report, size: 28, color: Color(0xFF7A5C00)),
                    SizedBox(height: 6),
                    Text('Testing / Debug',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    Text('App code →\nensureSemantics() →\nhandle',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
      shCard([
        shLabel('When You NEED a Handle'),
        const Text(
          '• Widget tests that check semantics (find.bySemanticsLabel)\n'
          '• SemanticsDebugger overlay\n'
          '• Accessibility auditing tools\n'
          '• Custom screen-reader simulation\n'
          '• Semantic tree dumping for debugging\n'
          '• Golden-file tests comparing semantics',
          style: TextStyle(fontSize: 12, height: 1.6),
        ),
      ]),
    ],
  );

  print('sh09 | Section 9 complete');

  // ─────────────────────────────────────────────────────────
  // Section 10: AccessibilityFeatures Flags
  // ─────────────────────────────────────────────────────────
  print('sh10 | Section 10: AccessibilityFeatures');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('10. AccessibilityFeatures Flags',
          'Platform signals that affect semantics activation'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Key Feature Flags'),
        const Text(
          'AccessibilityFeatures reports which accessibility services the '
          'platform currently has enabled. These flags influence whether '
          'the semantics pipeline is auto-activated.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _shFeatureChip('accessibleNavigation', amber),
            _shFeatureChip('invertColors', honey),
            _shFeatureChip('disableAnimations', goldenrod),
            _shFeatureChip('boldText', caramel),
            _shFeatureChip('reduceMotion', warmBrown),
            _shFeatureChip('highContrast', royalGold),
            _shFeatureChip('onOffSwitchLabels', darkAmber),
          ],
        ),
      ]),
      shCard([
        shLabel('How Flags Relate to Handles'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: amber.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.settings_accessibility, size: 24, color: Colors.blue),
                        SizedBox(height: 4),
                        Text('accessibleNavigation',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        Text('= true',
                            style: TextStyle(fontSize: 10, color: Colors.blue)),
                      ],
                    ),
                  ),
                  const Icon(Icons.add_circle_outline, size: 20, color: Colors.grey),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: amber.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.token, size: 24, color: Color(0xFF7A5C00)),
                        SizedBox(height: 4),
                        Text('App Handles',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        Text('= 2 active',
                            style: TextStyle(fontSize: 10, color: Color(0xFF7A5C00))),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Icon(Icons.arrow_downward, size: 18, color: Colors.grey),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('Semantics ACTIVE (both contribute)',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ),
            ],
          ),
        ),
      ]),
    ],
  );

  print('sh10 | Section 10 complete');

  // ─────────────────────────────────────────────────────────
  // Section 11: Semantics Tree Activation Flow
  // ─────────────────────────────────────────────────────────
  print('sh11 | Section 11: Activation Flow');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('11. Semantics Tree Activation Flow',
          'Step-by-step from handle creation to semantic data'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Full Pipeline Flow'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: warmBrown.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _shStepBox('1', 'ensureSemantics() called', amber.withValues(alpha: 0.12)),
              shDownArrow(),
              _shStepBox('2', '_outstandingHandles++', honeycomb.withValues(alpha: 0.15)),
              shDownArrow(),
              _shStepBox('3', '_semanticsEnabled = true', goldenrod.withValues(alpha: 0.12)),
              shDownArrow(),
              _shStepBox('4', 'PipelineOwner notified', paleGold),
              shDownArrow(),
              _shStepBox('5', 'SemanticsOwner created', amber.withValues(alpha: 0.1)),
              shDownArrow(),
              _shStepBox('6', 'RenderObjects mark dirty', honeycomb.withValues(alpha: 0.12)),
              shDownArrow(),
              _shStepBox('7', 'flushSemantics() each frame', goldenrod.withValues(alpha: 0.1)),
              shDownArrow(),
              _shStepBox('8', 'SemanticsUpdate sent to engine', paleGold),
            ],
          ),
        ),
      ]),
      shCard([
        shLabel('Deactivation Flow'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _shStepBox('1', 'Last handle.dispose() called', Colors.orange.withValues(alpha: 0.12)),
              shDownArrow(),
              _shStepBox('2', '_outstandingHandles == 0', Colors.orange.withValues(alpha: 0.1)),
              shDownArrow(),
              _shStepBox('3', 'Check platformRequestedSemantics', Colors.red.withValues(alpha: 0.08)),
              shDownArrow(),
              _shStepBox('4', 'If false → _semanticsEnabled = false', Colors.red.withValues(alpha: 0.1)),
              shDownArrow(),
              _shStepBox('5', 'SemanticsOwner disposed', Colors.red.withValues(alpha: 0.12)),
              shDownArrow(),
              _shStepBox('6', 'No more flushSemantics() calls', Colors.red.withValues(alpha: 0.15)),
            ],
          ),
        ),
      ]),
    ],
  );

  print('sh11 | Section 11 complete');

  // ─────────────────────────────────────────────────────────
  // Section 12: Semantics in the Rendering Pipeline
  // ─────────────────────────────────────────────────────────
  print('sh12 | Section 12: Rendering Pipeline Integration');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('12. Semantics in the Rendering Pipeline',
          'Where flushSemantics fits in the frame lifecycle'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Frame Phases (with Semantics)'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: warmBrown.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _shPhaseRow('1. Animation', 'Tick animations',
                  Colors.purple.withValues(alpha: 0.1), false),
              _shPhaseRow('2. Build', 'Rebuild widgets',
                  Colors.blue.withValues(alpha: 0.1), false),
              _shPhaseRow('3. Layout', 'Compute sizes/positions',
                  Colors.teal.withValues(alpha: 0.1), false),
              _shPhaseRow('4. Paint', 'Record display lists',
                  Colors.green.withValues(alpha: 0.1), false),
              _shPhaseRow('5. Semantics', 'Compile accessibility tree',
                  amber.withValues(alpha: 0.2), true),
              _shPhaseRow('6. Compositing', 'Send to GPU',
                  Colors.orange.withValues(alpha: 0.1), false),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'flushSemantics() runs AFTER paint, just before compositing. '
          'It only runs if semantics are enabled (via handles or platform). '
          'This phase walks dirty RenderObjects, collects their '
          'describeSemanticsConfiguration() data, and packages it into '
          'a SemanticsUpdate for the engine.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
      ]),
      shCard([
        shLabel('Cost of Semantics'),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.speed, size: 22, color: Colors.green),
                    SizedBox(height: 4),
                    Text('Active', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    Text('~0.5-2 ms/frame\n(tree compilation)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.pause_circle, size: 22, color: Colors.grey),
                    SizedBox(height: 4),
                    Text('Inactive', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    Text('0 ms/frame\n(skipped entirely)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'This is exactly why SemanticsHandle uses reference counting — '
          'semantics have a real per-frame cost, so they should only be '
          'active when something actually needs them.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
      ]),
    ],
  );

  print('sh12 | Section 12 complete');

  // ─────────────────────────────────────────────────────────
  // Section 13: Handle vs Listener Comparison
  // ─────────────────────────────────────────────────────────
  print('sh13 | Section 13: Handle vs Listener Comparison');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('13. Handle vs Listener — Patterns Compared',
          'Two different keep-alive patterns in Flutter'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Handle Pattern (SemanticsHandle)'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: amber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: amber.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              const Text('Create → Hold → Dispose',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text(
                '• Opaque token — no callbacks\n'
                '• Reference-counted\n'
                '• Binary: held or disposed\n'
                '• Used: SemanticsHandle, KeepAliveHandle',
                style: TextStyle(fontSize: 11, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        shLabel('Listener Pattern (ChangeNotifier)'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: honeycomb.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: honeycomb.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              const Text('Add → React → Remove',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text(
                '• Callback-based — notified on change\n'
                '• Observer list (not counted)\n'
                '• Active: receives notifications\n'
                '• Used: Listenable, ValueNotifier',
                style: TextStyle(fontSize: 11, height: 1.4),
              ),
            ],
          ),
        ),
      ]),
      shCard([
        shLabel('Why Handles for Semantics?'),
        const Text(
          'Semantics consumers do not need to react to changes — they just '
          'need the pipeline running. A handle is the perfect abstraction: '
          'it says "I need this resource" without coupling to any specific '
          'notification mechanism. The binding decides when to compile and '
          'send updates on its own schedule (once per frame).',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
      ]),
    ],
  );

  print('sh13 | Section 13 complete');

  // ─────────────────────────────────────────────────────────
  // Section 14: SemanticsDebugger Integration
  // ─────────────────────────────────────────────────────────
  print('sh14 | Section 14: SemanticsDebugger');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('14. SemanticsDebugger Integration',
          'How the debugger overlay uses handles internally'),
      const SizedBox(height: 10),
      shCard([
        shLabel('SemanticsDebugger Needs Semantics'),
        const Text(
          'SemanticsDebugger is a widget that overlays the semantics tree '
          'on top of the app. It paints colored outlines showing which '
          'regions have semantic annotations. Internally, it calls '
          'ensureSemantics() to guarantee the tree is active.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 10),
        shCodeBlock(
          '// Simplified from Flutter source:\n'
          'class _SemanticsDebuggerState\n'
          '    extends State<SemanticsDebugger> {\n'
          '  late SemanticsHandle _handle;\n'
          '\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    _handle = RendererBinding\n'
          '        .instance.ensureSemantics();\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  void dispose() {\n'
          '    _handle.dispose();\n'
          '    super.dispose();\n'
          '  }\n'
          '}',
        ),
      ]),
      shCard([
        shLabel('Debugger Overlay Visual'),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black26),
          ),
          child: Stack(
            children: [
              // Simulated app content
              Positioned(
                left: 20, top: 20, right: 20,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: amber.withValues(alpha: 0.2),
                    border: Border.all(color: amber, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: const Text('AppBar: "My App"',
                      style: TextStyle(fontSize: 10)),
                ),
              ),
              Positioned(
                left: 20, top: 75,
                child: Container(
                  width: 120, height: 50,
                  decoration: BoxDecoration(
                    color: honeycomb.withValues(alpha: 0.15),
                    border: Border.all(color: honeycomb, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Button:\n"Submit"',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10)),
                ),
              ),
              Positioned(
                left: 160, top: 75,
                child: Container(
                  width: 140, height: 50,
                  decoration: BoxDecoration(
                    color: goldenrod.withValues(alpha: 0.12),
                    border: Border.all(color: goldenrod, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Text:\n"Hello World"',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10)),
                ),
              ),
              Positioned(
                left: 20, top: 140,
                child: Container(
                  width: 280, height: 40,
                  decoration: BoxDecoration(
                    color: caramel.withValues(alpha: 0.1),
                    border: Border.all(color: caramel, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: const Text('TextField: "Enter name"',
                      style: TextStyle(fontSize: 10)),
                ),
              ),
              // Debug overlay label
              Positioned(
                bottom: 4, right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('SemanticsDebugger ON',
                      style: TextStyle(fontSize: 9, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Each colored outline represents a semantics node. The debugger '
          'renders these ONLY because it holds a SemanticsHandle.',
          style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
        ),
      ]),
    ],
  );

  print('sh14 | Section 14 complete');

  // ─────────────────────────────────────────────────────────
  // Section 15: Best Practices
  // ─────────────────────────────────────────────────────────
  print('sh15 | Section 15: Best Practices');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('15. Best Practices',
          'Tips for working with SemanticsHandle'),
      const SizedBox(height: 10),
      shCard([
        shLabel('Do'),
        Column(
          children: [
            _shPracticeRow(Icons.check_circle, Colors.green,
                'Always dispose handles when done'),
            _shPracticeRow(Icons.check_circle, Colors.green,
                'Use try/finally for scoped handles'),
            _shPracticeRow(Icons.check_circle, Colors.green,
                'One handle per logical consumer'),
            _shPracticeRow(Icons.check_circle, Colors.green,
                'Acquire in initState, dispose in dispose'),
            _shPracticeRow(Icons.check_circle, Colors.green,
                'Use in tests that check semantics'),
          ],
        ),
      ]),
      shCard([
        shLabel('Do Not'),
        Column(
          children: [
            _shPracticeRow(Icons.cancel, Colors.red,
                'Never keep a handle without disposing it'),
            _shPracticeRow(Icons.cancel, Colors.red,
                'Do not create handles in build()'),
            _shPracticeRow(Icons.cancel, Colors.red,
                'Avoid disposing others\u0027 handles'),
            _shPracticeRow(Icons.cancel, Colors.red,
                'Do not call dispose() twice'),
            _shPracticeRow(Icons.cancel, Colors.red,
                'Never assume semantics are always active'),
          ],
        ),
      ]),
      shCard([
        shLabel('Common Mistakes'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Leak: forgetting dispose',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
                      color: Colors.red)),
              shCodeBlock(
                '// BAD — handle leaks!\n'
                'void onTap() {\n'
                '  SemanticsBinding.instance\n'
                '      .ensureSemantics();\n'
                '  // no dispose → pipeline stays\n'
                '  // active forever!\n'
                '}',
              ),
              const SizedBox(height: 8),
              const Text('Fix: store and dispose',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
                      color: Colors.green)),
              shCodeBlock(
                '// GOOD — handle properly managed\n'
                'SemanticsHandle? _handle;\n'
                '\n'
                'void onTap() {\n'
                '  _handle = SemanticsBinding\n'
                '      .instance.ensureSemantics();\n'
                '}\n'
                '\n'
                'void onDone() {\n'
                '  _handle?.dispose();\n'
                '  _handle = null;\n'
                '}',
              ),
            ],
          ),
        ),
      ]),
    ],
  );

  print('sh15 | Section 15 complete');

  // ─────────────────────────────────────────────────────────
  // Section 16: Summary Dashboard
  // ─────────────────────────────────────────────────────────
  print('sh16 | Section 16: Summary Dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      shHeader('16. Summary Dashboard',
          'Complete SemanticsHandle quick reference'),
      const SizedBox(height: 10),
      shCard([
        shLabel('SemanticsHandle at a Glance'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                amber.withValues(alpha: 0.08),
                honeycomb.withValues(alpha: 0.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _shStatBox('Methods', '1', 'dispose()', amber),
                  _shStatBox('Created By', '1', 'ensureSemantics()', honey),
                  _shStatBox('Pattern', '1', 'Ref-counting', goldenrod),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _shStatBox('Relationship', '1', 'SemanticsBinding', caramel),
                  _shStatBox('Lifecycle', '1', 'Create → Dispose', warmBrown),
                  _shStatBox('Purpose', '1', 'Keep semantics on', royalGold),
                ],
              ),
            ],
          ),
        ),
      ]),
      shCard([
        shLabel('Key Takeaways'),
        const Text(
          '1. SemanticsHandle is a disposable token that keeps the '
             'accessibility pipeline active.\n'
          '2. Created via SemanticsBinding.instance.ensureSemantics().\n'
          '3. Uses reference counting — semantics stay active until ALL '
             'handles are disposed.\n'
          '4. Platform screen readers can also activate semantics '
             'independently of handles.\n'
          '5. The pipeline has a real per-frame cost (~0.5-2ms), so '
             'handles should be disposed promptly.\n'
          '6. Common usage: widget tests, accessibility debugger, '
             'and diagnostic tools.\n'
          '7. Always dispose in a finally block or widget dispose() method.\n'
          '8. SemanticsDebugger is the canonical example of handle usage.',
          style: TextStyle(fontSize: 12, height: 1.6),
        ),
      ]),
      // Amber/Honey themed footer
      Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7A5C00), Color(0xFFEB9E34)],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.token, color: Colors.white, size: 22),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'SemanticsHandle — the lightweight gatekeeper\n'
                'of the accessibility pipeline',
                style: TextStyle(color: Colors.white, fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Amber / Honey',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ],
        ),
      ),
    ],
  );

  print('sh16 | Section 16: Summary Dashboard complete');
  print('sh   | All 16 sections rendered');

  // ─── Assemble all sections ───
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF7A5C00), Color(0xFFDAA520), Color(0xFFEB9E34)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: darkAmber.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Column(
            children: [
              Icon(Icons.token, size: 42, color: Colors.white),
              SizedBox(height: 10),
              Text('SemanticsHandle',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(height: 4),
              Text('Deep Demo — Amber / Honey Theme',
                  style: TextStyle(fontSize: 13, color: Colors.white70)),
              SizedBox(height: 4),
              Text('The reference-counted gatekeeper of the accessibility pipeline',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: Colors.white60)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        section1, shDivider(),
        section2, shDivider(),
        section3, shDivider(),
        section4, shDivider(),
        section5, shDivider(),
        section6, shDivider(),
        section7, shDivider(),
        section8, shDivider(),
        section9, shDivider(),
        section10, shDivider(),
        section11, shDivider(),
        section12, shDivider(),
        section13, shDivider(),
        section14, shDivider(),
        section15, shDivider(),
        section16,
      ],
    ),
  );
}

// ─── Top-level helper functions ───

Widget _shTableRow(String member, String role) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(member,
              style: const TextStyle(fontSize: 10, fontFamily: 'monospace')),
        ),
        Expanded(
          flex: 5,
          child: Text(role, style: const TextStyle(fontSize: 10)),
        ),
      ],
    ),
  );
}

Widget _shPatternRow(String pattern, String lifetime, String bestFor) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(pattern,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          flex: 2,
          child: Text(lifetime, style: const TextStyle(fontSize: 10)),
        ),
        Expanded(
          flex: 3,
          child: Text(bestFor, style: const TextStyle(fontSize: 10)),
        ),
      ],
    ),
  );
}

Widget _shFeatureChip(String label, Color bg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: bg.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: bg.withValues(alpha: 0.4)),
    ),
    child: Text(label,
        style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.w600,
            color: bg.withValues(alpha: 1.0))),
  );
}

Widget _shStepBox(String step, String label, Color bg) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Container(
          width: 24, height: 24,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(step,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ),
      ],
    ),
  );
}

Widget _shPhaseRow(String phase, String desc, Color bg, bool highlight) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2),
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(4),
      border: highlight
          ? Border.all(color: const Color(0xFFDAA520), width: 2)
          : null,
    ),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(phase,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: highlight ? FontWeight.bold : FontWeight.w500)),
        ),
        Expanded(
          child: Text(desc, style: const TextStyle(fontSize: 10)),
        ),
        if (highlight)
          const Text('← SemanticsHandle activates this',
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold,
                  color: Color(0xFF7A5C00))),
      ],
    ),
  );
}

Widget _shPracticeRow(IconData icon, Color color, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _shStatBox(String title, String count, String desc, Color bg) {
  return Container(
    width: 100,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: bg.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(desc,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9)),
      ],
    ),
  );
}
