// D4rt test script: Tests Card from package:flutter/material.dart
// Deep Demo: Visual demonstration of Material Card, Card.filled, and
// Card.outlined variants. Covers every public Card constructor parameter
// (color, shadowColor, surfaceTintColor, elevation, shape, borderOnForeground,
// margin, clipBehavior, semanticContainer, child) plus pragmatic recipes.
//
// The Card widget is the cornerstone of Material surface elevation. It wraps
// content in a rounded, elevated rectangle that sits on a parent surface and
// communicates grouping. Material 3 introduces the .filled and .outlined
// factories which adopt different elevation/tint defaults from the active
// CardTheme.
//
// This file is intentionally hand-authored (no generators). The build()
// function returns a Scaffold whose body is a SingleChildScrollView; the
// d4rt-AST harness wraps it in a MaterialApp.
//
// Palette: slate (background scaffold + structural lines), deep teal (hero
// gradient + section accents), cobalt (interactive callouts).
import 'package:flutter/material.dart';

// Static toggle values used by the settings card section. We avoid
// StatefulWidget per the build contract; switches simply render their
// initial state.
const bool kSettingsNotificationsEnabled = true;
const bool kSettingsAutoSyncEnabled = false;
const bool kSettingsHapticFeedbackEnabled = true;
const bool kSettingsTelemetryEnabled = false;

dynamic build(BuildContext context) {
  // ============================================================
  // SHARED PALETTE
  // ============================================================
  // The whole demo uses a slate / teal / cobalt key. Slate gives a calm
  // page background that exposes Card elevation shadows clearly. Teal is
  // used for hero gradients and structural accents. Cobalt (indigo) is
  // reserved for interactive callouts and highlighted shadow demos.
  const Color slate50 = Color(0xFFF1F5F9);
  const Color slate100 = Color(0xFFE2E8F0);
  const Color slate200 = Color(0xFFCBD5E1);
  const Color slate600 = Color(0xFF475569);
  const Color slate700 = Color(0xFF334155);
  const Color slate800 = Color(0xFF1E293B);
  const Color slate900 = Color(0xFF0F172A);
  const Color teal400 = Color(0xFF2DD4BF);
  const Color teal600 = Color(0xFF0D9488);
  const Color teal700 = Color(0xFF0F766E);
  const Color teal800 = Color(0xFF115E59);
  const Color teal900 = Color(0xFF134E4A);
  const Color cobalt400 = Color(0xFF60A5FA);
  const Color cobalt600 = Color(0xFF2563EB);
  const Color cobalt700 = Color(0xFF1D4ED8);
  const Color amber400 = Color(0xFFFBBF24);
  const Color amber700 = Color(0xFFB45309);
  const Color rose400 = Color(0xFFFB7185);
  const Color rose600 = Color(0xFFE11D48);
  const Color emerald500 = Color(0xFF10B981);
  const Color violet500 = Color(0xFF8B5CF6);

  // ============================================================
  // SECTION 1 — HERO HEADER
  // ============================================================
  // The hero introduces the topic. A vertical gradient from slate900 to
  // teal700 provides a deep, technical mood. A custom card-stack icon is
  // drawn from three nested Containers offset diagonally to suggest the
  // "stacked surfaces" metaphor that Material elevation models.
  final Widget heroIconStack = SizedBox(
    width: 96.0,
    height: 96.0,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 18.0,
          top: 18.0,
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: teal400.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 8.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 9.0,
          top: 9.0,
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: teal400.withValues(alpha: 0.78),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 8.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          top: 0.0,
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.45),
                  blurRadius: 12.0,
                  offset: const Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Icon(Icons.dashboard_rounded, size: 32.0, color: teal800),
          ),
        ),
      ],
    ),
  );

  final Widget heroHeader = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[slate900, slate800, teal800, teal600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: <double>[0.0, 0.4, 0.75, 1.0],
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: teal900.withValues(alpha: 0.45),
          blurRadius: 22.0,
          spreadRadius: 1.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        heroIconStack,
        const SizedBox(width: 24.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Material Card — deep demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Card · Card.filled · Card.outlined',
                style: TextStyle(
                  color: teal400.withValues(alpha: 0.95),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Elevation, shadow, tint, shape, clip, margin, semantics — '
                    'every Card knob in one scrollable canvas.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 13.5,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: <Widget>[
                  _heroChip('elevation', teal400),
                  _heroChip('shadowColor', cobalt400),
                  _heroChip('surfaceTintColor', amber400),
                  _heroChip('shape', rose400),
                  _heroChip('clipBehavior', Colors.white),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 — ANATOMY DIAGRAM
  // ============================================================
  // A single large Card sits in the centre of a stylised diagram. Around
  // it, labelled callouts point at elevation, shadowColor, surfaceTintColor,
  // shape, margin, and child. We use a Stack with Positioned children to
  // place arrows. The arrows are simple Containers with rotated transforms
  // would be ideal, but to stay analyzer-clean and const-friendly we draw
  // them as horizontal/vertical lines with corner dots.
  final Widget anatomyCard = Card(
    color: Colors.white,
    shadowColor: teal700,
    surfaceTintColor: teal400,
    elevation: 6.0,
    margin: const EdgeInsets.all(0.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    ),
    clipBehavior: Clip.antiAlias,
    semanticContainer: true,
    borderOnForeground: true,
    child: Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: teal600,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.style_rounded,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                'Anatomy',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: slate800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Text(
            'A Card is a Material surface with elevation, an optional '
                'tinted overlay, and a clipped shape.',
            style: TextStyle(
              fontSize: 13.0,
              color: slate600,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

  final Widget anatomyDiagram = Container(
    height: 360.0,
    decoration: BoxDecoration(
      color: slate100,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: slate200, width: 1.0),
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 80.0,
          right: 80.0,
          top: 90.0,
          height: 180.0,
          child: anatomyCard,
        ),
        Positioned(
          left: 12.0,
          top: 28.0,
          child: _calloutLabel('elevation', teal700, Icons.layers_rounded),
        ),
        Positioned(
          right: 12.0,
          top: 28.0,
          child: _calloutLabel('shadowColor', cobalt700, Icons.cloud_rounded),
        ),
        Positioned(
          left: 12.0,
          bottom: 28.0,
          child:
              _calloutLabel('shape', rose600, Icons.rounded_corner_rounded),
        ),
        Positioned(
          right: 12.0,
          bottom: 28.0,
          child: _calloutLabel(
            'surfaceTintColor',
            amber700,
            Icons.invert_colors_rounded,
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 4.0,
          child: Center(
            child: _calloutLabel(
              'margin',
              slate700,
              Icons.crop_free_rounded,
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 6.0,
          child: Center(
            child: _calloutLabel(
              'child',
              slate800,
              Icons.account_tree_rounded,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3 — VARIANT CATALOG
  // ============================================================
  // Three side-by-side previews show the three Card factory variants.
  // - Card               : default elevated, themed surface tint.
  // - Card.filled        : low-elevation, pre-tinted secondaryContainer.
  // - Card.outlined      : zero elevation, visible border, transparent fill.
  // Each variant displays the same dummy "Project Aurora" content so visual
  // differences (border, fill, shadow) are isolated.
  final Widget variantClassic = _variantTile(
    title: 'Card (default)',
    accent: teal600,
    body: const Card(
      elevation: 2.0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: _ProjectAurora(),
      ),
    ),
    note: 'Elevated surface, theme-tinted background, soft drop shadow.',
  );

  final Widget variantFilled = _variantTile(
    title: 'Card.filled',
    accent: cobalt600,
    body: const Card.filled(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: _ProjectAurora(),
      ),
    ),
    note: 'Filled with secondaryContainer color; near-zero elevation.',
  );

  final Widget variantOutlined = _variantTile(
    title: 'Card.outlined',
    accent: rose600,
    body: const Card.outlined(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: _ProjectAurora(),
      ),
    ),
    note: 'Zero elevation, hairline outline; flat, low-emphasis surface.',
  );

  final Widget variantCatalog = _sectionShell(
    title: '3 · Variant catalog',
    subtitle: 'The three factory constructors compared side-by-side.',
    accent: teal600,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: variantClassic),
        const SizedBox(width: 14.0),
        Expanded(child: variantFilled),
        const SizedBox(width: 14.0),
        Expanded(child: variantOutlined),
      ],
    ),
  );

  // ============================================================
  // SECTION 4 — ELEVATION SWEEP
  // ============================================================
  // Seven cards stepping through elevation values. Each card is the same
  // size and color so the only varying factor is the rendered shadow.
  // This makes the elevation curve immediately visible.
  final List<double> sweepValues = const <double>[
    0.0,
    1.0,
    2.0,
    4.0,
    8.0,
    12.0,
    24.0,
  ];

  final Widget elevationSweep = _sectionShell(
    title: '4 · Elevation sweep',
    subtitle:
        'Identical cards rendered at elevation 0, 1, 2, 4, 8, 12, 24. '
        'Same size, same color — only shadow changes.',
    accent: teal700,
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Wrap(
        spacing: 18.0,
        runSpacing: 22.0,
        alignment: WrapAlignment.spaceBetween,
        children: <Widget>[
          for (final double e in sweepValues) _elevationTile(e, teal600),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 5 — SHAPE SHOWCASE
  // ============================================================
  // Six shapes including 4 RoundedRectangleBorder radii, one StadiumBorder,
  // and one BeveledRectangleBorder. Each card displays its shape's name
  // beneath, and the body is identical so the silhouette dominates.
  final Widget shapeShowcase = _sectionShell(
    title: '5 · Shape showcase',
    subtitle: 'shape: drives both clip and outline. The painter follows it.',
    accent: rose600,
    body: Wrap(
      spacing: 14.0,
      runSpacing: 14.0,
      children: <Widget>[
        _shapeTile(
          'radius 0',
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        _shapeTile(
          'radius 4',
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        _shapeTile(
          'radius 12',
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
        _shapeTile(
          'radius 24',
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
          ),
        ),
        _shapeTile('stadium', const StadiumBorder()),
        _shapeTile(
          'beveled',
          const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6 — SHADOW + SURFACE TINT
  // ============================================================
  // Two clusters. First, four cards with strongly coloured shadowColor
  // values (blue, red, green, purple). Second, three cards with explicit
  // surfaceTintColor overlays (amber, cobalt, emerald).
  final Widget shadowCluster = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: <Widget>[
      _shadowTile('blue', cobalt600),
      _shadowTile('red', rose600),
      _shadowTile('green', emerald500),
      _shadowTile('purple', violet500),
    ],
  );

  final Widget tintCluster = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: <Widget>[
      _tintTile('amber tint', amber400),
      _tintTile('cobalt tint', cobalt400),
      _tintTile('emerald tint', emerald500),
    ],
  );

  final Widget shadowSurfaceShowcase = _sectionShell(
    title: '6 · shadowColor & surfaceTintColor',
    subtitle:
        'shadowColor paints the drop-shadow. surfaceTintColor tints the '
        'body proportionally to elevation.',
    accent: cobalt600,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _MicroLabel('shadowColor'),
        const SizedBox(height: 8.0),
        shadowCluster,
        const SizedBox(height: 18.0),
        const _MicroLabel('surfaceTintColor'),
        const SizedBox(height: 8.0),
        tintCluster,
      ],
    ),
  );

  // ============================================================
  // SECTION 7 — CLIP BEHAVIOR SHOWCASE
  // ============================================================
  // Three cards each containing a deliberately oversized "image-like"
  // child that overshoots the card bounds. clipBehavior: Clip.none lets
  // the child spill out, hardEdge clips with aliased pixels, and
  // antiAlias clips smoothly along rounded corners.
  final Widget clipShowcase = _sectionShell(
    title: '7 · clipBehavior',
    subtitle:
        'How the Card treats children that exceed its bounds. Notice the '
        'top-right "image" overshoot in each tile.',
    accent: violet500,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _clipTile('Clip.none', Clip.none, slate600)),
        const SizedBox(width: 14.0),
        Expanded(child: _clipTile('Clip.hardEdge', Clip.hardEdge, slate600)),
        const SizedBox(width: 14.0),
        Expanded(
          child: _clipTile('Clip.antiAlias', Clip.antiAlias, slate600),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8 — MARGIN SHOWCASE
  // ============================================================
  // Four cards rendered inside a tinted container so external margin
  // becomes immediately visible as breathing space around each card.
  final Widget marginShowcase = _sectionShell(
    title: '8 · margin',
    subtitle:
        'Card.margin is *external* whitespace. The tinted slab makes it '
        'visible. Padding for *internal* whitespace lives in the child.',
    accent: amber700,
    body: Column(
      children: <Widget>[
        _marginRow('EdgeInsets.zero', EdgeInsets.zero),
        const SizedBox(height: 10.0),
        _marginRow('EdgeInsets.all(8)', const EdgeInsets.all(8.0)),
        const SizedBox(height: 10.0),
        _marginRow('EdgeInsets.all(16)', const EdgeInsets.all(16.0)),
        const SizedBox(height: 10.0),
        _marginRow(
          'EdgeInsets.symmetric(h: 24, v: 8)',
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9 — REAL-WORLD EXAMPLES
  // ============================================================
  // Four fully-populated cards demonstrating common product patterns:
  //   1. Media card    — header image, title, subtitle, action row.
  //   2. Pricing card  — plan name, price, feature list, CTA.
  //   3. List card     — list of ListTiles with leading icons.
  //   4. Settings card — switches with static bool values.
  final Widget mediaCard = Card(
    elevation: 4.0,
    surfaceTintColor: teal400,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 110.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[teal700, teal400, cobalt400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.terrain_rounded,
              color: Colors.white,
              size: 46.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Atlas of high places',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: slate800,
                ),
              ),
              const SizedBox(height: 4.0),
              const Text(
                'Curated routes through ten alpine ridges.',
                style: TextStyle(fontSize: 13.0, color: slate600),
              ),
              const SizedBox(height: 14.0),
              Row(
                children: <Widget>[
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_outline_rounded, size: 16.0),
                    label: const Text('Save'),
                  ),
                  const SizedBox(width: 8.0),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_rounded, size: 16.0),
                    label: const Text('Open'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final Widget pricingCard = Card.outlined(
    margin: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
      side: BorderSide(color: teal600, width: 1.5),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: teal600.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  'PRO',
                  style: TextStyle(
                    color: teal700,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '\$24',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w800,
                  color: slate900,
                ),
              ),
              SizedBox(width: 4.0),
              Padding(
                padding: EdgeInsets.only(bottom: 6.0),
                child: Text(
                  '/ month',
                  style: TextStyle(fontSize: 13.0, color: slate600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          _featureRow(Icons.check_circle_rounded, 'Unlimited workspaces'),
          _featureRow(Icons.check_circle_rounded, 'Priority sync'),
          _featureRow(Icons.check_circle_rounded, 'Offline export'),
          const SizedBox(height: 14.0),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              child: const Text('Choose Pro'),
            ),
          ),
        ],
      ),
    ),
  );

  final Widget listCard = Card.filled(
    margin: EdgeInsets.zero,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 6.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Recent contacts',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: slate800,
              ),
            ),
          ),
        ),
        const ListTile(
          leading: CircleAvatar(
            backgroundColor: teal400,
            foregroundColor: Colors.white,
            child: Text('LM'),
          ),
          title: Text('Léa Moreau'),
          subtitle: Text('Sent the routing diagram'),
          trailing: Icon(Icons.chevron_right_rounded),
        ),
        const ListTile(
          leading: CircleAvatar(
            backgroundColor: cobalt400,
            foregroundColor: Colors.white,
            child: Text('OK'),
          ),
          title: Text('Owen Kato'),
          subtitle: Text('Reviewed the migration plan'),
          trailing: Icon(Icons.chevron_right_rounded),
        ),
        const ListTile(
          leading: CircleAvatar(
            backgroundColor: rose400,
            foregroundColor: Colors.white,
            child: Text('NS'),
          ),
          title: Text('Nora Sayid'),
          subtitle: Text('Closed the API audit ticket'),
          trailing: Icon(Icons.chevron_right_rounded),
        ),
        const SizedBox(height: 6.0),
      ],
    ),
  );

  final Widget settingsCard = Card(
    elevation: 1.0,
    margin: EdgeInsets.zero,
    surfaceTintColor: cobalt400,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 4.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Preferences',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: slate800,
              ),
            ),
          ),
        ),
        SwitchListTile(
          value: kSettingsNotificationsEnabled,
          onChanged: null,
          title: const Text('Push notifications'),
          subtitle: const Text('Tickets, mentions, daily digest'),
          secondary: const Icon(Icons.notifications_active_rounded),
        ),
        SwitchListTile(
          value: kSettingsAutoSyncEnabled,
          onChanged: null,
          title: const Text('Auto-sync on cellular'),
          subtitle: const Text('Off by default to save data'),
          secondary: const Icon(Icons.sync_rounded),
        ),
        SwitchListTile(
          value: kSettingsHapticFeedbackEnabled,
          onChanged: null,
          title: const Text('Haptic feedback'),
          secondary: const Icon(Icons.vibration_rounded),
        ),
        SwitchListTile(
          value: kSettingsTelemetryEnabled,
          onChanged: null,
          title: const Text('Anonymous telemetry'),
          secondary: const Icon(Icons.privacy_tip_rounded),
        ),
        const SizedBox(height: 6.0),
      ],
    ),
  );

  final Widget realWorldShowcase = _sectionShell(
    title: '9 · Real-world examples',
    subtitle:
        'Four populated cards: media tile, pricing plan, list group, and '
        'preferences panel.',
    accent: emerald500,
    body: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: mediaCard),
            const SizedBox(width: 14.0),
            Expanded(child: pricingCard),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: listCard),
            const SizedBox(width: 14.0),
            Expanded(child: settingsCard),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10 — COMPARISON PANEL
  // ============================================================
  // Card vs Material vs Container vs Ink. Each column shows: a thumbnail,
  // a one-line description, and a list of properties highlighting where
  // the four widgets diverge in capability.
  final Widget comparisonPanel = _sectionShell(
    title: '10 · Card vs Material vs Container vs Ink',
    subtitle:
        'Four ways to draw a rectangular surface. They differ in elevation, '
        'ink response, theming, and composability.',
    accent: slate700,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _comparisonColumn(
            'Card',
            teal600,
            'Themed elevated surface.',
            <String>[
              'theme defaults',
              'shadowColor',
              'surfaceTintColor',
              'shape clip',
              'no ink response',
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _comparisonColumn(
            'Material',
            cobalt600,
            'Low-level ink-aware surface.',
            <String>[
              'elevation',
              'ink ripples',
              'shape',
              'manual color',
              'no margin',
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _comparisonColumn(
            'Container',
            amber700,
            'Generic decorated box.',
            <String>[
              'BoxDecoration',
              'manual shadow',
              'no ink',
              'margin/padding',
              'no theming',
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _comparisonColumn(
            'Ink',
            rose600,
            'Paints into nearest Material.',
            <String>[
              'requires Material',
              'background image',
              'splash hosting',
              'no shadow',
              'no shape clip',
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11 — CAVEATS
  // ============================================================
  // Five quick warning cards covering subtle behaviors that surprise
  // newcomers: theme-driven defaults, .filled tinting, hit-test passthrough,
  // borderOnForeground, and semanticContainer accessibility implications.
  final Widget caveats = _sectionShell(
    title: '11 · Caveats',
    subtitle: 'Five things you only notice once they bite you.',
    accent: rose600,
    body: Column(
      children: <Widget>[
        _caveatTile(
          Icons.palette_rounded,
          teal700,
          'Theme-driven defaults',
          'When color, elevation, shape, or shadowColor is null, Card pulls '
              'them from the active CardTheme. Override the theme to retune '
              'the entire app at once.',
        ),
        const SizedBox(height: 10.0),
        _caveatTile(
          Icons.format_color_fill_rounded,
          cobalt700,
          'Card.filled is not "primary tinted"',
          'Card.filled uses ColorScheme.surfaceContainerHighest by default. '
              'It is *not* the primary color. If you want primary-tinted, set '
              'color explicitly or use a custom CardTheme.',
        ),
        const SizedBox(height: 10.0),
        _caveatTile(
          Icons.touch_app_rounded,
          amber700,
          'Hit-testing passes through',
          'Card itself is not interactive. Wrap with InkWell or '
              'GestureDetector if you need taps. Place the InkWell *inside* '
              'the Card so its splash is clipped by the card shape.',
        ),
        const SizedBox(height: 10.0),
        _caveatTile(
          Icons.layers_rounded,
          violet500,
          'borderOnForeground',
          'When true (default), the shape\'s side border is painted on top of '
              'the child. Set false if you want the child to paint over the '
              'border (e.g. full-bleed media).',
        ),
        const SizedBox(height: 10.0),
        _caveatTile(
          Icons.accessibility_new_rounded,
          emerald500,
          'semanticContainer',
          'When true (default), Card collapses its descendants into a single '
              'semantics node. Set false for cards whose children expose '
              'individual actions to assistive tech.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12 — FOOTER
  // ============================================================
  // Three concise takeaways and a closing line. The footer mirrors the
  // hero gradient inverted (teal → slate) so the page feels visually
  // balanced top-to-bottom.
  final Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[teal700, slate800, slate900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: slate900.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'Takeaways',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _footerBullet(
          'Pick the variant by emphasis: Card for emphasis, Card.filled '
              'for low-emphasis grouping, Card.outlined for hairline lists.',
        ),
        _footerBullet(
          'Theme once, reuse everywhere: most Card knobs respect '
              'CardTheme. Set defaults globally, override locally.',
        ),
        _footerBullet(
          'Card is a surface, not a button. Add InkWell inside for taps; '
              'add Semantics for accessibility tweaks.',
        ),
        const SizedBox(height: 14.0),
        Text(
          'Material 3 · Card · deep demo · slate / teal / cobalt',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.65),
            fontSize: 11.5,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLY
  // ============================================================
  return Scaffold(
    backgroundColor: slate50,
    appBar: AppBar(
      backgroundColor: slate900,
      foregroundColor: Colors.white,
      elevation: 0.0,
      title: const Text('Card · deep demo'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroHeader,
          const SizedBox(height: 24.0),
          _sectionShell(
            title: '2 · Anatomy',
            subtitle:
                'A single card surrounded by labelled callouts. Each label '
                'names a Card constructor parameter.',
            accent: teal700,
            body: anatomyDiagram,
          ),
          const SizedBox(height: 24.0),
          variantCatalog,
          const SizedBox(height: 24.0),
          elevationSweep,
          const SizedBox(height: 24.0),
          shapeShowcase,
          const SizedBox(height: 24.0),
          shadowSurfaceShowcase,
          const SizedBox(height: 24.0),
          clipShowcase,
          const SizedBox(height: 24.0),
          marginShowcase,
          const SizedBox(height: 24.0),
          realWorldShowcase,
          const SizedBox(height: 24.0),
          comparisonPanel,
          const SizedBox(height: 24.0),
          caveats,
          const SizedBox(height: 24.0),
          footer,
          const SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================
// Each helper builds one repeated visual primitive. They are top-level
// functions (not StatelessWidget classes, except where const constructors
// require it) so the whole demo composes via plain function calls.

Widget _heroChip(String label, Color dotColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.25),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _calloutLabel(String text, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14.0, color: color),
        const SizedBox(width: 6.0),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ],
    ),
  );
}

Widget _sectionShell({
  required String title,
  required String subtitle,
  required Color accent,
  required Widget body,
}) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(
        color: const Color(0xFFE2E8F0),
        width: 1.0,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 4.0,
              height: 22.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13.0,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        body,
      ],
    ),
  );
}

Widget _variantTile({
  required String title,
  required Color accent,
  required Widget body,
  required String note,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: accent,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      ),
      const SizedBox(height: 10.0),
      body,
      const SizedBox(height: 10.0),
      Text(
        note,
        style: const TextStyle(
          fontSize: 11.5,
          color: Color(0xFF475569),
          height: 1.4,
        ),
      ),
    ],
  );
}

class _ProjectAurora extends StatelessWidget {
  const _ProjectAurora();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.auto_awesome_rounded,
              size: 16.0,
              color: Color(0xFF0F766E),
            ),
            SizedBox(width: 6.0),
            Text(
              'Aurora',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'A small project demoing the three Card variants.',
          style: TextStyle(
            fontSize: 11.5,
            color: Color(0xFF475569),
            height: 1.35,
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Icon(Icons.bolt_rounded, size: 13.0, color: Color(0xFFB45309)),
            SizedBox(width: 4.0),
            Text(
              '12 active',
              style: TextStyle(fontSize: 11.0, color: Color(0xFF334155)),
            ),
            SizedBox(width: 12.0),
            Icon(
              Icons.people_alt_rounded,
              size: 13.0,
              color: Color(0xFF1D4ED8),
            ),
            SizedBox(width: 4.0),
            Text(
              '4 collaborators',
              style: TextStyle(fontSize: 11.0, color: Color(0xFF334155)),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _elevationTile(double e, Color accent) {
  return SizedBox(
    width: 96.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Card(
          elevation: e,
          shadowColor: accent.withValues(alpha: 0.7),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          margin: EdgeInsets.zero,
          child: SizedBox(
            width: 80.0,
            height: 56.0,
            child: Center(
              child: Text(
                e.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: accent,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'elev ${e.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 11.0,
            color: Color(0xFF475569),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _shapeTile(String label, ShapeBorder shape) {
  return SizedBox(
    width: 110.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Card(
          elevation: 3.0,
          shape: shape,
          margin: EdgeInsets.zero,
          child: const SizedBox(width: 100.0, height: 64.0),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            color: Color(0xFF475569),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _shadowTile(String label, Color color) {
  return SizedBox(
    width: 110.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Card(
          elevation: 10.0,
          shadowColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          margin: const EdgeInsets.all(6.0),
          child: SizedBox(
            width: 96.0,
            height: 64.0,
            child: Center(
              child: Container(
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            color: Color(0xFF475569),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _tintTile(String label, Color tint) {
  return SizedBox(
    width: 130.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Card(
          elevation: 8.0,
          surfaceTintColor: tint,
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          margin: EdgeInsets.zero,
          child: SizedBox(
            width: 120.0,
            height: 70.0,
            child: Center(
              child: Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            color: Color(0xFF475569),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _clipTile(String label, Clip clip, Color textColor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        height: 130.0,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Card(
          elevation: 3.0,
          clipBehavior: clip,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          margin: EdgeInsets.zero,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: -20.0,
                top: -20.0,
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFFFB7185), Color(0xFFF59E0B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const Positioned(
                left: 12.0,
                bottom: 12.0,
                child: Text(
                  'overflow →',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.0,
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

Widget _marginRow(String label, EdgeInsetsGeometry margin) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFF7ED),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFFED7AA), width: 1.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 200.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFFB45309),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              margin: margin,
              elevation: 2.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'card with margin',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF334155)),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _featureRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 16.0, color: const Color(0xFF0F766E)),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.0, color: Color(0xFF334155)),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonColumn(
  String title,
  Color accent,
  String desc,
  List<String> bullets,
) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          desc,
          style: const TextStyle(
            fontSize: 12.0,
            color: Color(0xFF334155),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 10.0),
        for (final String b in bullets)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Icon(
                    Icons.fiber_manual_record,
                    size: 7.0,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    b,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF475569),
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _caveatTile(
  IconData icon,
  Color accent,
  String title,
  String body,
) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.35),
        width: 1.0,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(9.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: accent, size: 18.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF334155),
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

Widget _footerBullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 13.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

class _MicroLabel extends StatelessWidget {
  const _MicroLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11.0,
          color: Color(0xFF334155),
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
