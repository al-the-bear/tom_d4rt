import 'package:flutter/material.dart';

Widget _panel({
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
      border: Border.all(color: const Color(0xFFDCCFF8)),
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
            color: Color(0xFF4A2A8C),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: Color(0xFF5C4F76)),
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

Widget _gridBox({
  required Offset translation,
  required Color color,
  required String label,
}) {
  return Container(
    width: 250,
    height: 110,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xFFF6F1FF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFCEBDF4)),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 20,
          top: 18,
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF8D82A8)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Origin',
                style: TextStyle(fontSize: 10, color: Color(0xFF72678D)),
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 18,
          child: FractionalTranslation(
            translation: translation,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
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
      colorSchemeSeed: const Color(0xFF6636D4),
      scaffoldBackgroundColor: const Color(0xFFF7F4FF),
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
                colors: [Color(0xFF45208D), Color(0xFF6A42CC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RenderFractionalTranslation Deep Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'FractionalTranslation shifts child paint coordinates by fractions '
                  'of child size, useful for badges, overlays, and custom micro-layouts.',
                  style: TextStyle(color: Color(0xFFE8DEFF), fontSize: 13),
                ),
              ],
            ),
          ),
          _panel(
            title: 'Scenario 1 — Horizontal Fraction Offsets',
            description:
                'Moving right and left by fractions of child width while preserving source position.',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _gridBox(
                  translation: const Offset(0.25, 0),
                  color: const Color(0xFF4CAF50),
                  label: '+0.25x',
                ),
                _gridBox(
                  translation: const Offset(0.5, 0),
                  color: const Color(0xFF2196F3),
                  label: '+0.5x',
                ),
                _gridBox(
                  translation: const Offset(-0.5, 0),
                  color: const Color(0xFFE53935),
                  label: '-0.5x',
                ),
              ],
            ),
          ),
          _panel(
            title: 'Scenario 2 — Vertical and Diagonal Placement',
            description:
                'Combining dx and dy fractions for badges and floating contextual markers.',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _gridBox(
                  translation: const Offset(0, 0.5),
                  color: const Color(0xFFFB8C00),
                  label: '0,+0.5',
                ),
                _gridBox(
                  translation: const Offset(0.5, 0.5),
                  color: const Color(0xFF8E24AA),
                  label: '+0.5,+0.5',
                ),
                _gridBox(
                  translation: const Offset(-0.5, -0.5),
                  color: const Color(0xFF00897B),
                  label: '-0.5,-0.5',
                ),
              ],
            ),
          ),
          _panel(
            title: 'Scenario 3 — Notification Badge Composition',
            description:
                'A practical UI where translation places badges without changing parent constraints.',
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEEE8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6A42CC),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: FractionalTranslation(
                          translation: const Offset(0.4, -0.4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE53935),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Text(
                              '9+',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3556D4),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: FractionalTranslation(
                          translation: const Offset(0.6, -0.2),
                          child: const CircleAvatar(
                            radius: 11,
                            backgroundColor: Color(0xFFFFA000),
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _panel(
            title: 'Scenario 4 — Hit Test Guidance',
            description:
                'FractionalTranslation can keep or shift hit tests based on transformHitTests.',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(Icons.touch_app, color: Color(0xFF6A42CC)),
                  title: Text(
                    'Default transformHitTests=true: taps follow visual position.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.gps_not_fixed, color: Color(0xFFE53935)),
                  title: Text(
                    'Use transformHitTests=false for paint-only offset effects.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.design_services,
                    color: Color(0xFF00897B),
                  ),
                  title: Text(
                    'Great for badges, emphasis chips, and callout layers.',
                  ),
                ),
              ],
            ),
          ),
          _panel(
            title: 'Scenario 5 — Corner Badge Recipes',
            description:
                'Common offset recipes for top-right, bottom-right, and center-hover badges.',
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _gridBox(
                  translation: const Offset(0.35, -0.35),
                  color: const Color(0xFF26A69A),
                  label: 'TR',
                ),
                _gridBox(
                  translation: const Offset(0.35, 0.35),
                  color: const Color(0xFF5C6BC0),
                  label: 'BR',
                ),
                _gridBox(
                  translation: const Offset(0.0, -0.6),
                  color: const Color(0xFFEF5350),
                  label: 'Top',
                ),
              ],
            ),
          ),
          _panel(
            title: 'Scenario 6 — Translation Review Checklist',
            description:
                'Quality checklist for micro-layout translation patterns in production UIs.',
            child: const Column(
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(Icons.grid_on, color: Color(0xFF6A42CC)),
                  title: Text(
                    'Compare translated element with origin ghost outline.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.pan_tool_alt, color: Color(0xFFE53935)),
                  title: Text(
                    'Verify tap regions when using transformHitTests variations.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.aspect_ratio, color: Color(0xFF00897B)),
                  title: Text(
                    'Validate behavior on different icon and chip sizes.',
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.layers_outlined,
                    color: Color(0xFFFB8C00),
                  ),
                  title: Text(
                    'Check overlap/stack order against adjacent UI components.',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Deep demo completed: multiple visual scenarios show how fractional offsets '
            'change perceived position while preserving parent sizing behavior.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF655A7C),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );
}
