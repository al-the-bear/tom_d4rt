import 'package:flutter/material.dart';

Widget _boxLab({
  required String title,
  required String intro,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFD7E0F5)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x12000000),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF1E3C82),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          intro,
          style: const TextStyle(fontSize: 12, color: Color(0xFF4D5B7D)),
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

Widget _factorSample({
  required String label,
  required double widthFactor,
  required double heightFactor,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF4F7FF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFC8D4F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          width: 250,
          height: 90,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF8EA2D3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            heightFactor: heightFactor,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  '${(widthFactor * 100).toStringAsFixed(0)}% × ${(heightFactor * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF2E5AA8),
      scaffoldBackgroundColor: const Color(0xFFF3F7FF),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1C3D87), Color(0xFF4272D8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RenderFractionallySizedOverflowBox Deep Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Visual lab for FractionallySizedBox behavior: proportional sizing, '
                  'alignment, and overflow when factors exceed 1.0.',
                  style: TextStyle(color: Color(0xFFE4ECFF), fontSize: 13),
                ),
              ],
            ),
          ),
          _boxLab(
            title: 'Scenario 1 — Balanced Factors',
            intro: 'The child scales proportionally inside parent constraints.',
            child: Column(
              children: [
                _factorSample(
                  label: 'Half width, 80% height',
                  widthFactor: 0.5,
                  heightFactor: 0.8,
                  color: const Color(0xFF4CAF50),
                ),
                _factorSample(
                  label: '75% width, 60% height',
                  widthFactor: 0.75,
                  heightFactor: 0.6,
                  color: const Color(0xFF1E88E5),
                ),
              ],
            ),
          ),
          _boxLab(
            title: 'Scenario 2 — Full-size and Expanded Feel',
            intro:
                'Using factors of 1.0 or near 1.0 to fill available room cleanly.',
            child: Column(
              children: [
                _factorSample(
                  label: '100% width, 100% height',
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  color: const Color(0xFF8E24AA),
                ),
                _factorSample(
                  label: '95% width with centered breathing room',
                  widthFactor: 0.95,
                  heightFactor: 0.9,
                  color: const Color(0xFFEF6C00),
                ),
              ],
            ),
          ),
          _boxLab(
            title: 'Scenario 3 — Overflow Exploration',
            intro:
                'Factors above 1.0 intentionally produce oversize paint area relative to parent.',
            child: Column(
              children: [
                _factorSample(
                  label: '120% width, 100% height',
                  widthFactor: 1.2,
                  heightFactor: 1.0,
                  color: const Color(0xFFE53935),
                ),
                _factorSample(
                  label: '140% width, 130% height',
                  widthFactor: 1.4,
                  heightFactor: 1.3,
                  color: const Color(0xFF6D4C41),
                ),
              ],
            ),
          ),
          _boxLab(
            title: 'Scenario 4 — Alignment as Layout Tool',
            intro:
                'Alignment controls where the fractional child anchors when available space remains.',
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC9D5F8)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 250,
                    height: 90,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF8EA2D3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.45,
                      heightFactor: 0.65,
                      alignment: Alignment.topLeft,
                      child: Container(color: const Color(0xFF26A69A)),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 90,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF8EA2D3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.45,
                      heightFactor: 0.65,
                      alignment: Alignment.center,
                      child: Container(color: const Color(0xFF5C6BC0)),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF8EA2D3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.45,
                      heightFactor: 0.65,
                      alignment: Alignment.bottomRight,
                      child: Container(color: const Color(0xFFFF7043)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _boxLab(
            title: 'Scenario 5 — Practical Guidance',
            intro: 'When and why to choose fractional sizing patterns.',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.dashboard_customize,
                    color: Color(0xFF1C3D87),
                  ),
                  title: Text(
                    'Use for responsive cards that scale by parent size.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.open_in_full, color: Color(0xFFE53935)),
                  title: Text(
                    'Use factors > 1.0 only when intentional overflow is acceptable.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.center_focus_strong,
                    color: Color(0xFF5C6BC0),
                  ),
                  title: Text(
                    'Pair with alignment to control anchor and visual rhythm.',
                  ),
                ),
              ],
            ),
          ),
          _boxLab(
            title: 'Scenario 6 — Layout Pair Comparisons',
            intro:
                'Comparing FractionallySizedBox to fixed sizing for responsive behavior understanding.',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFB7C8EE)),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: 0.65,
                          heightFactor: 0.7,
                          alignment: Alignment.center,
                          child: Container(color: const Color(0xFF42A5F5)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFB7C8EE)),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 90,
                            height: 50,
                            child: Container(color: const Color(0xFFEF5350)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Left scales with parent constraints; right stays fixed and may feel inconsistent.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4D5B7D)),
                ),
              ],
            ),
          ),
          _boxLab(
            title: 'Scenario 7 — Overflow Safety Checklist',
            intro:
                'A practical checklist when using widthFactor/heightFactor > 1.0.',
            child: const Column(
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(Icons.visibility, color: Color(0xFF1C3D87)),
                  title: Text(
                    'Confirm clipping/overflow behavior is intentionally chosen.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.format_line_spacing,
                    color: Color(0xFF5C6BC0),
                  ),
                  title: Text(
                    'Check neighboring widget spacing under enlarged factors.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.warning_amber, color: Color(0xFFE53935)),
                  title: Text(
                    'Avoid accidental overflow in narrow form factor screens.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.phonelink_setup,
                    color: Color(0xFF26A69A),
                  ),
                  title: Text(
                    'Validate proportions on mobile, tablet, and desktop widths.',
                  ),
                ),
              ],
            ),
          ),
          _boxLab(
            title: 'Scenario 8 — Final Constraint Audit',
            intro:
                'Closing prompt to ensure proportional layout intent is explicit.',
            child: const ListTile(
              dense: true,
              leading: Icon(Icons.rule_folder, color: Color(0xFF1C3D87)),
              title: Text(
                'Document expected parent constraints beside each factor profile.',
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Deep demo completed: proportional sizing and overflow behavior are shown '
            'with multiple visual constraint scenarios.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF5A6784),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );
}
