import 'package:flutter/material.dart';

Widget _a11yCard({
  required String title,
  required String description,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFD8E8F0)),
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
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0E4A63),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: Color(0xFF4B5F69)),
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

Widget _badge(String text, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.35)),
    ),
    child: Text(
      text,
      style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
    ),
  );
}

dynamic build(BuildContext context) {
  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF0A6C86),
      scaffoldBackgroundColor: const Color(0xFFF2FAFD),
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
                colors: [Color(0xFF0B5E75), Color(0xFF1691B3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RenderExcludeSemantics Deep Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Visualizes how decorative layers can stay visible while being '
                  'removed from the accessibility semantics tree.',
                  style: TextStyle(color: Color(0xFFE2F8FF), fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: [
              _badge('Green: announced semantics', const Color(0xFF2E7D32)),
              _badge('Red: excluded from semantics', const Color(0xFFC62828)),
              _badge('Blue: compositional patterns', const Color(0xFF1565C0)),
            ],
          ),
          _a11yCard(
            title: 'Scenario 1 — Decorative Banner Excluded',
            description:
                'The stars and separators remain visible but are intentionally hidden '
                'from assistive announcements.',
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6F6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF2CACA)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Product Celebration Banner',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6D1B1B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ExcludeSemantics(
                    excluding: true,
                    child: Row(
                      children: const [
                        Icon(Icons.star, color: Color(0xFFFFA726), size: 28),
                        SizedBox(width: 6),
                        Icon(Icons.star, color: Color(0xFFFFA726), size: 28),
                        SizedBox(width: 6),
                        Icon(Icons.star, color: Color(0xFFFFA726), size: 28),
                        SizedBox(width: 10),
                        Text('Decorative only'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Assistive tech should ignore stars and only announce meaningful text.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          _a11yCard(
            title: 'Scenario 2 — Meaningful Action Included',
            description:
                'Primary status and action remain in the semantics tree.',
            child: Semantics(
              label: 'Payment completed, button opens invoice details',
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7EF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFBEE3C7)),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Color(0xFF2E7D32),
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Payment completed successfully',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
          _a11yCard(
            title: 'Scenario 3 — Mixed Row (Included + Excluded)',
            description:
                'A composite tile with decorative avatar ring excluded but title and '
                'metadata still announced.',
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFEFF5FF),
                border: Border.all(color: const Color(0xFFC7D7F7)),
              ),
              child: Row(
                children: [
                  ExcludeSemantics(
                    excluding: true,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF3569D6),
                          width: 3,
                        ),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFBCD1FF), Color(0xFFE2EAFF)],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Semantics(
                      label: 'Project Apollo, due tomorrow, high priority',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Project Apollo',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Due tomorrow • High priority',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _a11yCard(
            title: 'Scenario 4 — Form Hint Decoration',
            description:
                'Hint icons can be excluded while helper text and field labels remain announced.',
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Email address',
                    helperText: 'Used for delivery notifications',
                    prefixIcon: ExcludeSemantics(
                      excluding: true,
                      child: const Icon(Icons.alternate_email),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Tracking code',
                    helperText: '8-character code from receipt',
                    suffixIcon: ExcludeSemantics(
                      excluding: true,
                      child: const Icon(Icons.qr_code_scanner),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _a11yCard(
            title: 'Scenario 5 — Practical Guidance',
            description: 'How to decide when exclusion is appropriate.',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.do_not_disturb_alt,
                    color: Color(0xFFC62828),
                  ),
                  title: Text(
                    'Exclude decorative repetition, separators, and purely visual flair.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.record_voice_over,
                    color: Color(0xFF2E7D32),
                  ),
                  title: Text(
                    'Keep all actionable and informational elements included.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.layers, color: Color(0xFF1565C0)),
                  title: Text(
                    'Compose semantics intentionally for grouped summary announcements.',
                  ),
                ),
              ],
            ),
          ),
          _a11yCard(
            title: 'Scenario 6 — Comparison Grid: Included vs Excluded',
            description:
                'Each row contrasts a semantically meaningful element with a decorative peer.',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        label: 'Order total 129 euros',
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9F6EC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Order total: €129',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ExcludeSemantics(
                        excluding: true,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0F0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '★★★★★',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        label: 'Delivery expected tomorrow by 4 PM',
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F3FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'ETA: Tomorrow 16:00',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ExcludeSemantics(
                        excluding: true,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF7E8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.local_shipping_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _a11yCard(
            title: 'Scenario 7 — Team Accessibility Checklist',
            description:
                'Operational checklist for reviewing semantics quality in UI reviews.',
            child: const Column(
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(Icons.remove_red_eye, color: Color(0xFF1565C0)),
                  title: Text('Mark purely decorative layers for exclusion.'),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.campaign, color: Color(0xFF2E7D32)),
                  title: Text(
                    'Preserve all actionable controls in semantics tree.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.group_work, color: Color(0xFF8E24AA)),
                  title: Text(
                    'Group complex cards with summary labels where useful.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.devices, color: Color(0xFFEF6C00)),
                  title: Text(
                    'Validate with screen reader on both mobile and desktop.',
                  ),
                ),
              ],
            ),
          ),
          _a11yCard(
            title: 'Scenario 8 — Final A11y Pass',
            description:
                'Last-step validation prompt for semantics exclusions.',
            child: const ListTile(
              dense: true,
              leading: Icon(
                Icons.fact_check_outlined,
                color: Color(0xFF1565C0),
              ),
              title: Text(
                'Verify excluded nodes are decorative only, never actionable.',
              ),
            ),
          ),
          _a11yCard(
            title: 'Scenario 9 — Release Gate',
            description:
                'Team sign-off reminder before shipping accessibility changes.',
            child: const ListTile(
              dense: true,
              leading: Icon(Icons.verified_outlined, color: Color(0xFF2E7D32)),
              title: Text(
                'Run screen reader walkthrough for each excluded region.',
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Deep demo completed: visual and accessibility behavior are both demonstrated '
            'with realistic UI compositions.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF5D6D74),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );
}
