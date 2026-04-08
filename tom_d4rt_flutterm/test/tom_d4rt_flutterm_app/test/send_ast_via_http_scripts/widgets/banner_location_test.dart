// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — BannerLocation
// Demonstrates BannerLocation, the enum controlling where the Banner
// widget places its diagonal ribbon overlay. Covers all four locations
// (topStart, topEnd, bottomStart, bottomEnd), live gallery, real-world
// use cases, text directionality impact, and Banner anatomy.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BannerLocation Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is BannerLocation?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.flag,
      'title': 'The Banner Widget',
      'body': 'A Banner is a diagonal ribbon overlay that sits on top of '
          'its child widget. It displays a short text message (like '
          '"DEBUG", "SALE", "BETA") across a corner of the widget. '
          'Material\'s Banner widget draws this diagonal strip at one '
          'of four corners defined by BannerLocation.',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.crop_square,
      'title': 'Four Corners',
      'body': 'BannerLocation has four values: topStart, topEnd, '
          'bottomStart, bottomEnd. "Start" and "End" are directionality-'
          'aware — in LTR layout start=left, end=right. In RTL, '
          'start=right, end=left. This makes banners work correctly '
          'in all text directions.',
      'accent': Colors.indigo[800]!,
    },
    {
      'icon': Icons.star_outline,
      'title': 'Real-World Banner Usage',
      'body': 'Banners are common in debug overlays (the red "DEBUG" '
          'stripe in Flutter debug mode), e-commerce sale tags, beta / '
          'preview indicators, environment markers (DEV, STAGING, PROD), '
          'and feature flags. They give a quick visual signal without '
          'disrupting the layout.',
      'accent': Colors.deepPurple[700]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Overlay, Not Layout',
      'body': 'Banner doesn\'t affect layout sizing — it paints the ribbon '
          'on top using a custom painter. The child widget renders at '
          'full size underneath. The banner clips to the child\'s bounds.',
      'accent': Colors.indigo[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  final conceptWidgets = conceptCards.map<Widget>((card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (card['accent'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (card['accent'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(card['icon'] as IconData,
              color: card['accent'] as Color, size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: card['accent'] as Color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  card['body'] as String,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 2: API Surface — The Four Enum Values
  // ============================================================
  print('=== Section 2: API Surface ===');

  final bannerLocations = <Map<String, dynamic>>[
    {
      'value': 'BannerLocation.topStart',
      'position': 'Top-left (LTR) / Top-right (RTL)',
      'icon': Icons.north_west,
      'color': Colors.indigo[700]!,
      'desc': 'Places the banner in the top-start corner. This is the '
          'most common location — Flutter\'s debug banner uses topEnd by '
          'default, but topStart is great for left-aligned indicators.',
    },
    {
      'value': 'BannerLocation.topEnd',
      'position': 'Top-right (LTR) / Top-left (RTL)',
      'icon': Icons.north_east,
      'color': Colors.blue[700]!,
      'desc': 'Places the banner in the top-end corner. This is Flutter\'s '
          'default for the debug banner. Common for sale / discount tags '
          'in card-based e-commerce layouts.',
    },
    {
      'value': 'BannerLocation.bottomStart',
      'position': 'Bottom-left (LTR) / Bottom-right (RTL)',
      'icon': Icons.south_west,
      'color': Colors.deepPurple[700]!,
      'desc': 'Places the banner in the bottom-start corner. Less common '
          'but useful for status indicators that shouldn\'t compete with '
          'header/title content at the top.',
    },
    {
      'value': 'BannerLocation.bottomEnd',
      'position': 'Bottom-right (LTR) / Bottom-left (RTL)',
      'icon': Icons.south_east,
      'color': Colors.purple[700]!,
      'desc': 'Places the banner in the bottom-end corner. Good for '
          '"NEW" or version badges that should be noticed but not dominate.',
    },
  ];

  final apiCards = bannerLocations.map<Widget>((loc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (loc['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (loc['color'] as Color).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (loc['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(loc['icon'] as IconData,
                    color: loc['color'] as Color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc['value'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: loc['color'] as Color,
                      ),
                    ),
                    Text(
                      loc['position'] as String,
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            loc['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: Live Banner Gallery — All Four Corners
  // ============================================================
  print('=== Section 3: Live Banner Gallery ===');

  // Helper builds a Banner + child card
  Widget buildBannerDemo({
    required BannerLocation location,
    required String label,
    required String message,
    required Color bannerColor,
    required Color background,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Banner(
          message: message,
          location: location,
          color: bannerColor,
          textStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: bannerColor.withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(icon, color: bannerColor, size: 36),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: bannerColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Banner message: "$message"',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final topStartBanner = buildBannerDemo(
    location: BannerLocation.topStart,
    label: 'topStart',
    message: 'DEBUG',
    bannerColor: Colors.indigo[700]!,
    background: Colors.indigo.withOpacity(0.04),
    icon: Icons.north_west,
  );

  final topEndBanner = buildBannerDemo(
    location: BannerLocation.topEnd,
    label: 'topEnd',
    message: 'SALE',
    bannerColor: Colors.red[600]!,
    background: Colors.red.withOpacity(0.04),
    icon: Icons.north_east,
  );

  final bottomStartBanner = buildBannerDemo(
    location: BannerLocation.bottomStart,
    label: 'bottomStart',
    message: 'BETA',
    bannerColor: Colors.deepPurple[600]!,
    background: Colors.deepPurple.withOpacity(0.04),
    icon: Icons.south_west,
  );

  final bottomEndBanner = buildBannerDemo(
    location: BannerLocation.bottomEnd,
    label: 'bottomEnd',
    message: 'NEW',
    bannerColor: Colors.green[700]!,
    background: Colors.green.withOpacity(0.04),
    icon: Icons.south_east,
  );

  // ============================================================
  // SECTION 4: Banner Anatomy
  // ============================================================
  print('=== Section 4: Banner Anatomy ===');

  final anatomyProperties = <Map<String, dynamic>>[
    {
      'name': 'message',
      'type': 'String',
      'desc': 'The text displayed on the diagonal ribbon. Keep short '
          '(4-8 characters) for readability.',
      'icon': Icons.text_fields,
    },
    {
      'name': 'location',
      'type': 'BannerLocation',
      'desc': 'Which corner the ribbon is placed in. One of the four '
          'enum values (topStart, topEnd, bottomStart, bottomEnd).',
      'icon': Icons.place,
    },
    {
      'name': 'color',
      'type': 'Color',
      'desc': 'Background color of the ribbon strip. Defaults to a '
          'red color. Use contrasting colors for visibility.',
      'icon': Icons.palette,
    },
    {
      'name': 'textStyle',
      'type': 'TextStyle',
      'desc': 'Style for the message text. Typically bold, white, and '
          'small (10-12 sp). Default is white bold text.',
      'icon': Icons.format_size,
    },
    {
      'name': 'textDirection',
      'type': 'TextDirection?',
      'desc': 'Overrides the ambient text direction for resolving '
          '"start" and "end" locations. Usually inherited from context.',
      'icon': Icons.format_textdirection_l_to_r,
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The widget below the banner overlay. The child renders '
          'at full size; the ribbon paints on top.',
      'icon': Icons.child_care,
    },
  ];

  final anatomyWidgets = anatomyProperties.map<Widget>((prop) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: Colors.indigo[600]!,
            width: 3,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(prop['icon'] as IconData,
              color: Colors.indigo[600], size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      prop['name'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[700],
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        prop['type'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.indigo[400],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  prop['desc'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 5: Real-World Use Cases
  // ============================================================
  print('=== Section 5: Real-World Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Debug / Development Indicator',
      'location': 'topEnd',
      'message': 'DEBUG',
      'color': Colors.red[700]!,
      'icon': Icons.bug_report,
      'desc': 'Flutter\'s default debug banner uses topEnd. Shows this is '
          'a debug build. Typically removed in release mode via '
          'MaterialApp(debugShowCheckedModeBanner: false).',
    },
    {
      'title': 'Environment Indicator',
      'location': 'topStart',
      'message': 'DEV / STAGING',
      'color': Colors.orange[700]!,
      'icon': Icons.cloud,
      'desc': 'Show which environment the app is running against. '
          'Use different colors per environment: green=prod, orange='
          'staging, red=dev. topStart avoids clashing with debug banner.',
    },
    {
      'title': 'E-Commerce Sale Tag',
      'location': 'topEnd',
      'message': 'SALE / 50% OFF',
      'color': Colors.pink[600]!,
      'icon': Icons.local_offer,
      'desc': 'Product cards with sale banners in the corner. topEnd '
          'is natural for LTR layouts, catching the eye as the user '
          'scans left to right.',
    },
    {
      'title': 'Feature Preview / Beta',
      'location': 'bottomStart',
      'message': 'BETA',
      'color': Colors.deepPurple[600]!,
      'icon': Icons.science,
      'desc': 'Mark experimental features with a subtle beta indicator. '
          'bottomStart is less intrusive than top corners, showing the '
          'feature works but isn\'t finalized.',
    },
    {
      'title': 'Version / New Badge',
      'location': 'bottomEnd',
      'message': 'NEW / v2.0',
      'color': Colors.green[700]!,
      'icon': Icons.new_releases,
      'desc': 'Highlight newly added items or recently updated cards. '
          'bottomEnd is subtle — users notice it without it competing '
          'with the main content.',
    },
  ];

  final useCaseWidgets = useCases.map<Widget>((uc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (uc['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (uc['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(uc['icon'] as IconData,
                  color: uc['color'] as Color, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  uc['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: uc['color'] as Color,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (uc['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  uc['location'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: uc['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            uc['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 6),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (uc['color'] as Color).withOpacity(0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Banner message: "${uc['message']}"',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: uc['color'] as Color,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 6: Banner Styling Showcase
  // ============================================================
  print('=== Section 6: Styling Showcase ===');

  final stylingExamples = <Map<String, dynamic>>[
    {
      'label': 'Default (red)',
      'bannerColor': Colors.red,
      'bgColor': Colors.red.withOpacity(0.04),
      'msg': 'DEFAULT',
    },
    {
      'label': 'Indigo theme',
      'bannerColor': Colors.indigo[700]!,
      'bgColor': Colors.indigo.withOpacity(0.04),
      'msg': 'INDIGO',
    },
    {
      'label': 'Dark (almost black)',
      'bannerColor': Colors.grey[850]!,
      'bgColor': Colors.grey.withOpacity(0.06),
      'msg': 'DARK',
    },
    {
      'label': 'Amber accent',
      'bannerColor': Colors.amber[800]!,
      'bgColor': Colors.amber.withOpacity(0.04),
      'msg': 'AMBER',
    },
    {
      'label': 'Teal subtle',
      'bannerColor': Colors.teal[600]!,
      'bgColor': Colors.teal.withOpacity(0.04),
      'msg': 'TEAL',
    },
    {
      'label': 'Pink vibrant',
      'bannerColor': Colors.pink[600]!,
      'bgColor': Colors.pink.withOpacity(0.04),
      'msg': 'PINK',
    },
  ];

  final stylingGrid = Wrap(
    spacing: 10,
    runSpacing: 10,
    children: stylingExamples.map<Widget>((style) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Banner(
          message: style['msg'] as String,
          location: BannerLocation.topEnd,
          color: style['bannerColor'] as Color,
          textStyle: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              color: style['bgColor'] as Color,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color:
                    (style['bannerColor'] as Color).withOpacity(0.2),
              ),
            ),
            child: Center(
              child: Text(
                style['label'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: style['bannerColor'] as Color,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );

  // ============================================================
  // SECTION 7: Text Directionality Impact
  // ============================================================
  print('=== Section 7: Text Directionality ===');

  final directionalityData = <Map<String, dynamic>>[
    {
      'value': 'topStart',
      'ltr': 'Top-Left',
      'rtl': 'Top-Right',
      'icon': Icons.north_west,
    },
    {
      'value': 'topEnd',
      'ltr': 'Top-Right',
      'rtl': 'Top-Left',
      'icon': Icons.north_east,
    },
    {
      'value': 'bottomStart',
      'ltr': 'Bottom-Left',
      'rtl': 'Bottom-Right',
      'icon': Icons.south_west,
    },
    {
      'value': 'bottomEnd',
      'ltr': 'Bottom-Right',
      'rtl': 'Bottom-Left',
      'icon': Icons.south_east,
    },
  ];

  final dirTableHeader = Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.indigo[700],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 120,
          child: Text('BannerLocation',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
        const Expanded(
          child: Text('LTR Position',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
        const Expanded(
          child: Text('RTL Position',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
      ],
    ),
  );

  final dirTableRows =
      directionalityData.asMap().entries.map<Widget>((entry) {
    final i = entry.key;
    final d = entry.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: i.isEven
            ? Colors.indigo.withOpacity(0.03)
            : Colors.indigo.withOpacity(0.07),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Row(
              children: [
                Icon(d['icon'] as IconData,
                    size: 16, color: Colors.indigo[600]),
                const SizedBox(width: 6),
                Text(d['value'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo[700],
                    )),
              ],
            ),
          ),
          Expanded(
            child: Text(d['ltr'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12)),
          ),
          Expanded(
            child: Text(d['rtl'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }).toList();

  // Explanation note
  final dirNote = Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.indigo.withOpacity(0.06),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: Colors.indigo[600], size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Directionality-Aware Positioning',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.indigo[700],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '"Start" and "End" resolve based on the ambient '
                'TextDirection (from Directionality widget or MaterialApp '
                'locale). This ensures banners appear in the correct '
                'corner for both LTR and RTL languages. You can override '
                'with the textDirection parameter on Banner.',
                style: TextStyle(fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Patterns & Pitfalls
  // ============================================================
  print('=== Section 8: Patterns & Pitfalls ===');

  final tips = <Map<String, dynamic>>[
    {
      'type': 'pattern',
      'title': 'Wrap with ClipRRect for rounded corners',
      'detail': 'Banner\'s ribbon can extend beyond rounded container '
          'borders. Wrap the Banner in ClipRRect with the same border '
          'radius so the ribbon clips cleanly at the corners.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Short messages only (4-8 chars)',
      'detail': 'The diagonal ribbon has limited space. Keep messages '
          'short: "SALE", "NEW", "BETA", "DEV". Longer text gets '
          'squeezed and becomes unreadable.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Environment-based banner visibility',
      'detail': 'Show banners conditionally: use kDebugMode or an '
          'environment variable to decide whether to wrap the child '
          'in a Banner or pass it through unwrapped.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Color contrast for accessibility',
      'detail': 'Ensure the banner color has good contrast with the '
          'white text. Dark saturated colors (indigo, red, green 800+) '
          'work best. Avoid yellow or light grey.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pitfall',
      'title': 'Banner on small widgets',
      'detail': 'On very small widgets (< 60x60), the banner can cover '
          'most of the content. Banner is designed for medium to large '
          'areas like full-screen app or product cards.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
    {
      'type': 'pitfall',
      'title': 'Stacking multiple banners',
      'detail': 'Nesting Banner(Banner(child)) creates two ribbons on '
          'different corners. While technically possible, it looks '
          'cluttered. Prefer a single banner with the most important '
          'message.',
      'icon': Icons.error_outline,
      'color': Colors.red,
    },
    {
      'type': 'pitfall',
      'title': 'Ignoring RTL in hardcoded positions',
      'detail': 'If you hardcode topStart thinking it means "top-left", '
          'it will flip in RTL locales. If you need always-left, set '
          'textDirection: TextDirection.ltr on the Banner.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
  ];

  final tipWidgets = tips.map<Widget>((tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (tip['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: tip['color'] as Color,
            width: 4,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(tip['icon'] as IconData,
              color: tip['color'] as Color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (tip['color'] as Color).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (tip['type'] as String).toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: tip['color'] as Color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        tip['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: tip['color'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tip['detail'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 9: Summary Dashboard
  // ============================================================
  print('=== Section 9: Summary Dashboard ===');

  final summaryItems = <Map<String, dynamic>>[
    {'label': 'Locations', 'value': '4', 'icon': Icons.place},
    {'label': 'Live banners', 'value': '4', 'icon': Icons.flag},
    {'label': 'Properties', 'value': '${anatomyProperties.length}', 'icon': Icons.list},
    {'label': 'Use cases', 'value': '${useCases.length}', 'icon': Icons.cases},
    {'label': 'Style demos', 'value': '${stylingExamples.length}', 'icon': Icons.palette},
    {'label': 'Tips & pitfalls', 'value': '${tips.length}', 'icon': Icons.lightbulb},
  ];

  final summaryGrid = Wrap(
    spacing: 10,
    runSpacing: 10,
    children: summaryItems.map<Widget>((item) {
      return Container(
        width: 155,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo.withOpacity(0.15),
              Colors.indigo.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(item['icon'] as IconData,
                color: Colors.indigo[700], size: 24),
            const SizedBox(height: 6),
            Text(
              item['value'] as String,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[900],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }).toList(),
  );

  // ============================================================
  // Helper: Section header
  // ============================================================
  Widget blSectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 28, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo[800]!, Colors.indigo[500]!],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  print('BannerLocation Deep Demo — building final layout');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('BannerLocation'),
      backgroundColor: Colors.indigo[700],
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo[800]!, Colors.indigo[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.flag, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                const Text(
                  'BannerLocation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'An enum defining the four corners where a Banner '
                  'widget places its diagonal ribbon overlay: topStart, '
                  'topEnd, bottomStart, bottomEnd. Start/End resolve '
                  'based on text directionality (LTR/RTL).',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Section 1
          blSectionHeader('1', 'Concept', Icons.lightbulb),
          ...conceptWidgets,

          // Section 2
          blSectionHeader('2', 'The Four Locations', Icons.place),
          ...apiCards,

          // Section 3
          blSectionHeader('3', 'Live Banner Gallery', Icons.grid_view),
          topStartBanner,
          topEndBanner,
          bottomStartBanner,
          bottomEndBanner,

          // Section 4
          blSectionHeader('4', 'Banner Anatomy', Icons.account_tree),
          ...anatomyWidgets,

          // Section 5
          blSectionHeader('5', 'Real-World Use Cases', Icons.cases),
          ...useCaseWidgets,

          // Section 6
          blSectionHeader('6', 'Styling Showcase', Icons.palette),
          stylingGrid,

          // Section 7
          blSectionHeader('7', 'Text Directionality', Icons.swap_horiz),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Colors.indigo.withOpacity(0.2)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                dirTableHeader,
                ...dirTableRows,
              ],
            ),
          ),
          dirNote,

          // Section 8
          blSectionHeader('8', 'Patterns & Pitfalls', Icons.lightbulb_outline),
          ...tipWidgets,

          // Section 9
          blSectionHeader('9', 'Summary Dashboard', Icons.dashboard),
          summaryGrid,
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
