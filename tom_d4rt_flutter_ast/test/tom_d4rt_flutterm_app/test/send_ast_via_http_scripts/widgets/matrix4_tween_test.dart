// ignore_for_file: avoid_print
// D4rt deep demo: Matrix4Tween — interpolation between 4x4 transformation matrices
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Emerald / Malachite ───────────────────────────────────
  const deepEmerald = Color(0xFF064E3B);
  const malachite = Color(0xFF065F46);
  const forestGreen = Color(0xFF047857);
  const emerald = Color(0xFF059669);
  const brightGreen = Color(0xFF10B981);
  const paleJade = Color(0xFFA7F3D0);
  const mintCream = Color(0xFFECFDF5);
  const darkTeal = Color(0xFF0F766E);
  const amberContrast = Color(0xFFD97706);
  const roseContrast = Color(0xFFE11D48);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: deepEmerald)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: deepEmerald)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  String matrixRow(Matrix4 m, int row) {
    return '[ ${m.entry(row, 0).toStringAsFixed(3)}, '
        '${m.entry(row, 1).toStringAsFixed(3)}, '
        '${m.entry(row, 2).toStringAsFixed(3)}, '
        '${m.entry(row, 3).toStringAsFixed(3)} ]';
  }

  Widget matrixCard(String label, Matrix4 m, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: mintCream,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: accent)),
          const SizedBox(height: 4),
          for (var r = 0; r < 4; r++)
            Text(matrixRow(m, r),
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: deepEmerald)),
        ],
      ),
    );
  }

  // ── Create tweens ──────────────────────────────────────────────────
  print('Matrix4Tween deep demo executing');
  print('=' * 60);

  final begin = Matrix4.identity();
  final end = Matrix4.identity()
    ..translateByDouble(200.0, 100.0, 0.0, 1.0)
    ..rotateZ(0.785398) // 45 degrees
    ..scaleByDouble(2.0, 2.0, 1.0, 1.0);

  final tween = Matrix4Tween(begin: begin, end: end);

  // Sample at different t values
  final t00 = tween.lerp(0.0);
  final t25 = tween.lerp(0.25);
  final t50 = tween.lerp(0.5);
  final t75 = tween.lerp(0.75);
  final t100 = tween.lerp(1.0);

  // Section 1
  print('\n--- What is Matrix4Tween ---');
  print('Interpolates between two Matrix4 values by decomposing into');
  print('translation, rotation, and scale components');

  // Section 2
  print('\n--- Begin matrix ---');
  for (var r = 0; r < 4; r++) {
    print(matrixRow(begin, r));
  }

  // Section 3
  print('\n--- End matrix ---');
  for (var r = 0; r < 4; r++) {
    print(matrixRow(end, r));
  }

  // Section 4
  print('\n--- Lerp at t=0.5 ---');
  for (var r = 0; r < 4; r++) {
    print(matrixRow(t50, r));
  }

  print('\n${'=' * 60}');
  print('Matrix4Tween deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepEmerald, malachite, forestGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.transform, size: 28, color: paleJade),
                  const SizedBox(width: 10),
                  const Text('Matrix4Tween',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              Text('Interpolation between 4\u00d74 transformation matrices',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('extends Tween<Matrix4>', forestGreen, Colors.white),
                tag('Decompose \u2192 Lerp \u2192 Recompose', emerald, Colors.white),
                tag('Implicit Animations', paleJade, deepEmerald),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is Matrix4Tween',
            'Smart interpolation via decomposition',
            deepEmerald, Colors.white),
        noteBox(
          'Matrix4Tween extends Tween<Matrix4> and overrides the lerp() '
          'method to decompose begin and end matrices into their translation, '
          'rotation (Quaternion), and scale components. Each component is '
          'interpolated independently, then recomposed into a new Matrix4 '
          'via Matrix4.compose(). This produces visually correct transitions '
          'instead of the distortion that naive element-by-element '
          'interpolation would cause.',
          emerald,
          mintCream,
        ),
        dataRow('Extends', 'Tween<Matrix4>', forestGreen),
        dataRow('Constructor', 'Matrix4Tween({begin, end})', emerald),
        dataRow('Key method', 'lerp(double t) \u2192 Matrix4', malachite),
        dataRow('Defined in', 'widgets/implicit_animations.dart', deepEmerald),
        const SizedBox(height: 14),

        // ── 3. Begin and end matrices ────────────────────────────────
        sectionBanner('2 \u00b7 Begin & End Matrices',
            'The two endpoints of the interpolation',
            malachite, Colors.white),
        matrixCard('begin: identity()', begin, forestGreen),
        noteBox(
          'Begin is the identity matrix — no translation, no rotation, '
          'no scaling. This represents the original untransformed state.',
          emerald,
          mintCream,
        ),
        matrixCard('end: translate + rotate(45\u00b0) + scale(2x)', end, amberContrast),
        noteBox(
          'End matrix combines: translate(200, 100), rotateZ(45\u00b0), and '
          'scale(2x, 2x). The matrix stores all three transformations as '
          'a single 4\u00d74 matrix.',
          amberContrast,
          mintCream,
        ),
        const SizedBox(height: 14),

        // ── 4. Decomposition explained ───────────────────────────────
        sectionBanner('3 \u00b7 Decomposition Strategy',
            'How lerp() breaks down the matrix',
            forestGreen, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Decompose begin', 'Extract translation, rotation, scale from begin matrix',
                    emerald),
                (2, 'Decompose end', 'Extract same three components from end matrix',
                    forestGreen),
                (3, 'Lerp translation', 'Vector3.lerp(beginT, endT, t) — linear interpolation',
                    malachite),
                (4, 'Slerp rotation', 'Quaternion.slerp(beginQ, endQ, t) — spherical linear interpolation',
                    deepEmerald),
                (5, 'Lerp scale', 'Vector3.lerp(beginS, endS, t) — linear interpolation',
                    darkTeal),
                (6, 'Recompose', 'Matrix4.compose(translation, rotation, scale) — build final matrix',
                    amberContrast),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: step.$4,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${step.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: deepEmerald)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 11, color: malachite)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Five t-values side by side ────────────────────────────
        sectionBanner('4 \u00b7 Lerp at Different t Values',
            'The matrix at t = 0.0, 0.25, 0.50, 0.75, 1.0',
            emerald, Colors.white),
        for (final entry in [
          ('t = 0.00', t00, forestGreen),
          ('t = 0.25', t25, emerald),
          ('t = 0.50', t50, malachite),
          ('t = 0.75', t75, darkTeal),
          ('t = 1.00', t100, amberContrast),
        ])
          matrixCard(entry.$1, entry.$2, entry.$3),
        const SizedBox(height: 14),

        // ── 6. Visual transform progression ──────────────────────────
        sectionBanner('5 \u00b7 Visual Transform Progression',
            'How a box looks at each step',
            malachite, Colors.white),
        Container(
          width: double.infinity,
          height: 160,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleJade),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final item in [
                (0.0, 'identity', 0.0, 1.0, forestGreen),
                (0.25, 'quarter', 0.196, 1.25, emerald),
                (0.50, 'half', 0.393, 1.5, malachite),
                (0.75, '3/4', 0.589, 1.75, darkTeal),
                (1.0, 'end', 0.785, 2.0, amberContrast),
              ])
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateZ(item.$3)
                        ..scaleByDouble(item.$4 * 0.5, item.$4 * 0.5, 1.0, 1.0),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: item.$5.withValues(alpha: 0.3),
                          border: Border.all(color: item.$5, width: 2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: Text('A',
                            style: TextStyle(
                                color: item.$5,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('t=${item.$1}',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: item.$5)),
                    Text(item.$2,
                        style: TextStyle(
                            fontSize: 8,
                            color: deepEmerald.withValues(alpha: 0.7))),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Why decompose instead of element lerp ─────────────────
        sectionBanner('6 \u00b7 Why Decompose?',
            'What goes wrong with naive element-by-element interpolation',
            deepEmerald, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepEmerald),
                children: [
                  for (final h in ['Aspect', 'Naive Lerp', 'Decomposed Lerp'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('Rotation', 'Distorts mid-way', 'Smooth arc (slerp)'),
                ('Scale', 'Can collapse to zero', 'Monotonic progression'),
                ('Translation', 'Correct', 'Correct (same method)'),
                ('Combined', 'Shearing artifacts', 'Clean composition'),
                ('At t=0.5', 'Possibly singular', 'Always valid matrix'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: forestGreen)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: roseContrast)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: emerald)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Three component types ─────────────────────────────────
        sectionBanner('7 \u00b7 The Three Transform Components',
            'Translation, rotation, and scale — each interpolated differently',
            forestGreen, Colors.white),
        for (final comp in [
          ('Translation', 'Vector3',
              'Position offset — lerped linearly between begin and end Vector3',
              'begin: (0,0,0)  end: (200,100,0)',
              Icons.open_with, emerald),
          ('Rotation', 'Quaternion',
              'Orientation — slerped (spherical linear) for smooth arc rotation',
              'begin: identity  end: 45\u00b0 around Z',
              Icons.rotate_right, forestGreen),
          ('Scale', 'Vector3',
              'Size factors — lerped linearly between begin and end scale Vector3',
              'begin: (1,1,1)  end: (2,2,1)',
              Icons.zoom_out_map, malachite),
        ])
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: mintCream,
              borderRadius: BorderRadius.circular(10),
              border: Border(
                  left: BorderSide(color: comp.$6, width: 4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: comp.$6.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(comp.$5, size: 22, color: comp.$6),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(comp.$1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: deepEmerald)),
                          const SizedBox(width: 6),
                          tag(comp.$2, comp.$6.withValues(alpha: 0.12),
                              comp.$6),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(comp.$3,
                          style: TextStyle(
                              fontSize: 12, color: malachite)),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: comp.$6.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(comp.$4,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: comp.$6)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 14),

        // ── 9. Tween superclass features ─────────────────────────────
        sectionBanner('8 \u00b7 Tween<Matrix4> Inheritance',
            'Properties and methods inherited from Tween',
            emerald, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final member in [
                ('begin', 'Matrix4?', 'Start matrix (set in constructor or later)',
                    'Getter/Setter', forestGreen),
                ('end', 'Matrix4?', 'End matrix (set in constructor or later)',
                    'Getter/Setter', emerald),
                ('lerp(t)', 'Matrix4', 'Decompose \u2192 interpolate \u2192 recompose (overridden)',
                    'Method', malachite),
                ('transform(t)', 'Matrix4', 'Calls lerp(t) — inherited from Tween',
                    'Method', darkTeal),
                ('evaluate(anim)', 'Matrix4', 'Calls transform(anim.value) — from Animatable',
                    'Method', deepEmerald),
                ('animate(parent)', 'Animation<Matrix4>', 'Creates driven animation from controller',
                    'Method', amberContrast),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: member.$5, width: 3)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(member.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: member.$5)),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(member.$2,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: deepEmerald)),
                      ),
                      Expanded(
                        child: Text(member.$3,
                            style: TextStyle(
                                fontSize: 10, color: forestGreen)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Usage with AnimatedContainer ─────────────────────────
        sectionBanner('9 \u00b7 Usage with Implicit Animations',
            'Where Matrix4Tween is commonly used',
            malachite, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final usage in [
                ('AnimatedContainer', 'transform property',
                    'Animates between two Matrix4 transform values automatically',
                    Icons.widgets, emerald),
                ('TweenAnimationBuilder', 'tween parameter',
                    'Pass Matrix4Tween directly for build-based control',
                    Icons.construction, forestGreen),
                ('AnimationController', '.drive(tween)',
                    'Drive the tween explicitly for frame-by-frame access',
                    Icons.tune, malachite),
                ('CurvedAnimation', 'curved input',
                    'Combine with curves — easeIn, easeOut, bounce, etc.',
                    Icons.show_chart, darkTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: usage.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: usage.$5, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(usage.$4, size: 22, color: usage.$5),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(usage.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: deepEmerald)),
                                const SizedBox(width: 6),
                                tag(usage.$2,
                                    usage.$5.withValues(alpha: 0.12),
                                    usage.$5),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(usage.$3,
                                style: TextStyle(
                                    fontSize: 11, color: malachite)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Transform component comparison ───────────────────────
        sectionBanner('10 \u00b7 Component Values at Each t',
            'How translation, rotation, scale change over t',
            deepEmerald, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2.5),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepEmerald),
                children: [
                  for (final h in ['t', 'Translation (x,y)', 'Rotation (\u00b0)', 'Scale (x,y)'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('0.00', '(0, 0)', '0\u00b0', '(1.0, 1.0)'),
                ('0.25', '(50, 25)', '11.25\u00b0', '(1.25, 1.25)'),
                ('0.50', '(100, 50)', '22.5\u00b0', '(1.5, 1.5)'),
                ('0.75', '(150, 75)', '33.75\u00b0', '(1.75, 1.75)'),
                ('1.00', '(200, 100)', '45\u00b0', '(2.0, 2.0)'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              color: forestGreen)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: emerald)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: malachite)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$4,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: darkTeal)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Other matrix tweens in Flutter ───────────────────────
        sectionBanner('11 \u00b7 Related Tween Types',
            'Other tweens for transform-related animation',
            forestGreen, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final related in [
                ('Matrix4Tween', 'Full 4\u00d74 matrix decomposition interpolation', emerald),
                ('Tween<double>', 'Single value (rotation angle, scale factor)', forestGreen),
                ('Tween<Offset>', 'Translation only (without rotation/scale)', malachite),
                ('AlignmentTween', 'Alignment interpolation for positioned transforms', darkTeal),
                ('DecorationTween', 'BoxDecoration interpolation (borders, shadows)', deepEmerald),
                ('ColorTween', 'Color interpolation (often combined with transforms)', amberContrast),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(related.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: related.$3)),
                      ),
                      Expanded(
                        child: Text(related.$2,
                            style: TextStyle(
                                fontSize: 11, color: deepEmerald)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Transform widget showcase ────────────────────────────
        sectionBanner('12 \u00b7 Transform Widget Showcase',
            'The Transform widget applies Matrix4 values to children',
            emerald, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleJade),
          ),
          child: Column(
            children: [
              for (final scenario in [
                ('Transform.translate', Matrix4.identity()..translateByDouble(40.0, 0.0, 0.0, 1.0),
                    'Moved 40px right', forestGreen),
                ('Transform.rotate', Matrix4.identity()..rotateZ(0.3),
                    'Rotated ~17\u00b0', emerald),
                ('Transform.scale', Matrix4.identity()..scaleByDouble(1.5, 1.5, 1.0, 1.0),
                    'Scaled 1.5\u00d7', malachite),
                ('Combined', Matrix4.identity()
                    ..translateByDouble(20.0, 0.0, 0.0, 1.0)..rotateZ(0.2)..scaleByDouble(1.2, 1.2, 1.0, 1.0),
                    'All three combined', darkTeal),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: scenario.$2,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: scenario.$4.withValues(alpha: 0.3),
                              border: Border.all(
                                  color: scenario.$4, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            alignment: Alignment.center,
                            child: Text('\u25a0',
                                style: TextStyle(
                                    color: scenario.$4, fontSize: 14)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scenario.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: scenario.$4)),
                            Text(scenario.$3,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: deepEmerald.withValues(alpha: 0.7))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Matrix4.compose explanation ───────────────────────────
        sectionBanner('13 \u00b7 Matrix4.compose()',
            'How the recomposed matrix is built',
            darkTeal, Colors.white),
        noteBox(
          'Matrix4.compose(translation, rotation, scale) constructs a 4\u00d74 '
          'matrix from the three separate components. The order matters: scale '
          'is applied first (bottom-right of the matrix), then rotation (the '
          '3\u00d73 upper-left block), then translation (the last column). This '
          'matches the standard model-view convention where transformations '
          'are applied right-to-left.',
          darkTeal,
          mintCream,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Composition order in the matrix:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: deepEmerald)),
              const SizedBox(height: 8),
              for (final part in [
                ('[0,0]..[2,2]', 'Rotation \u00d7 Scale', '3\u00d73 block',
                    emerald),
                ('[0,3]..[2,3]', 'Translation', 'Right column',
                    forestGreen),
                ('[3,3]', '1.0', 'Homogeneous coordinate',
                    malachite),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(part.$1,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                color: part.$4)),
                      ),
                      SizedBox(
                        width: 110,
                        child: Text(part.$2,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: deepEmerald)),
                      ),
                      Text(part.$3,
                          style: TextStyle(
                              fontSize: 10,
                              color: deepEmerald.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Inheritance ──────────────────────────────────────────
        sectionBanner('14 \u00b7 Class Hierarchy',
            'Where Matrix4Tween sits', deepEmerald, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', 0, Colors.grey),
                ('\u2514\u2500 Animatable<Matrix4>', 1, malachite),
                ('    \u2514\u2500 Tween<Matrix4>', 2, forestGreen),
                ('        \u2514\u2500 Matrix4Tween', 3, emerald),
              ])
                Padding(
                  padding: EdgeInsets.only(
                      left: level.$2 * 4.0, top: 4, bottom: 4),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          fontWeight: level.$2 == 3
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: level.$3)),
                ),
              const SizedBox(height: 6),
              Text(
                  'Inherits all animation driving from Animatable and value '
                  'storage from Tween. Only overrides lerp() for matrix-specific '
                  'decomposition interpolation.',
                  style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: malachite)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepEmerald, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepEmerald, malachite],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Matrix4Tween extends Tween<Matrix4> for smart matrix interpolation',
                'Overrides lerp() to decompose \u2192 interpolate \u2192 recompose',
                'Translation: Vector3.lerp — linear interpolation',
                'Rotation: Quaternion.slerp — spherical interpolation for smooth arcs',
                'Scale: Vector3.lerp — linear interpolation',
                'Recomposed via Matrix4.compose(translation, rotation, scale)',
                'Avoids distortion artifacts of naive element-wise matrix lerp',
                'Used with AnimatedContainer, TweenAnimationBuilder, AnimationController',
                'Inherits from Animatable \u2192 Tween \u2192 Matrix4Tween',
                'Defined in widgets/implicit_animations.dart',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: brightGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
