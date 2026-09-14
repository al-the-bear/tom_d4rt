// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: HeroMode Deep Visual Demo
// ---------------------------------------------------------------
// HeroMode is a Flutter widget that wraps a subtree and exposes
// an `enabled` flag to the surrounding HeroController. When the
// flag is false, Hero widgets inside the subtree are inert during
// route transitions. When true, Hero widgets participate in the
// flight animation as usual.
//
// Demonstrated topics:
//   1. Anatomy of HeroMode (properties, role, mental model)
//   2. Baseline: enabled = true with a single Hero
//   3. Inert: enabled = false with a single Hero
//   4. Side-by-side comparison panel (enabled vs disabled)
//   5. Hero child variations (Container, Card, Icon, CircleAvatar,
//      faux Image.network, custom shape)
//   6. Tag discipline (good and commented bad examples)
//   7. flightShuttleBuilder + placeholderBuilder demonstration
//   8. Nested HeroMode (inner overrides outer)
//   9. Real-world: product grid with selective participation
//  10. Conditional opt-in patterns (theme-aware, route-scoped)
//  11. Footguns and caveats
//  12. Decision matrix and summary
//
// D4rt constraints honored:
//   - Single build() entry point, no setState, no AnimationController
//   - All iterations use native Dart Lists
//   - .withValues(alpha: x) instead of .withOpacity
//   - Hero widgets are constructed but no actual route flights fire
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HeroMode Deep Demo executing');

  // Shared palette and helpers used across sections. These are local
  // const-like values rather than top-level constants to keep the
  // demo confined to build() per the contract.
  final accentEnabled = Colors.teal.shade600;
  final accentDisabled = Colors.deepOrange.shade400;
  final accentNeutral = Colors.indigo.shade500;
  final accentWarn = Colors.amber.shade700;
  final accentDanger = Colors.red.shade400;
  final accentInfo = Colors.cyan.shade600;

  // ============================================================
  // SECTION 1: Anatomy of HeroMode
  // ============================================================
  print('=== Section 1: Anatomy ===');

  final anatomyHeader = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accentNeutral.withValues(alpha: 0.85),
          accentNeutral.withValues(alpha: 0.55),
          Colors.purple.shade400.withValues(alpha: 0.55),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: accentNeutral.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HeroMode — Anatomy',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A scope-level on/off switch for Hero animations.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.92),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'HeroMode wraps any subtree. The HeroController consults the '
          'nearest enclosing HeroMode for each Hero widget; if `enabled` '
          'is false, that Hero is excluded from route transitions even if '
          'it is otherwise valid. Use HeroMode to silence Heroes inside '
          'list items, modal sheets, embedded navigators, or any subtree '
          'where flight animations would be visually noisy or wrong.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.97),
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  // Anatomy diagram: a labeled, box-drawn rendition of the widget tree.
  final anatomyDiagram = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Widget Diagram',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: accentNeutral.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: accentNeutral, width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.flight_takeoff, color: accentNeutral, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    'HeroMode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: accentNeutral,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                'enabled: bool   (default true)',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'child: Widget   (the wrapped subtree)',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 12.0),
              Padding(
                padding: EdgeInsets.only(left: 22.0),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: accentEnabled.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: accentEnabled, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.subdirectory_arrow_right,
                              color: accentEnabled, size: 16.0),
                          SizedBox(width: 4.0),
                          Text(
                            'Hero',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: accentEnabled,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        'tag: Object   (must be unique in scope)',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        'child: Widget   (the actual visual)',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Properties summary:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          '• enabled: when false, all enclosed Heroes are inert.\n'
          '• child: any widget subtree containing zero or more Heroes.\n'
          '• It is an InheritedWidget under the hood — Heroes look it up.',
          style: TextStyle(fontSize: 12.5, height: 1.5),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Baseline — enabled = true
  // ============================================================
  print('=== Section 2: Baseline enabled=true ===');

  final baselineHeader = _sectionHeader(
    title: 'Section 2 · Baseline (enabled = true)',
    subtitle:
        'A Hero wrapped in HeroMode(enabled: true) participates in route '
        'transitions normally. The HeroMode here is essentially a no-op '
        'because true is the default — but writing it explicitly documents '
        'intent at the boundary of a reusable widget.',
    color: accentEnabled,
    icon: Icons.flight_takeoff,
  );

  final baselineHero = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'demo-baseline-hero',
      child: Container(
        width: 110.0,
        height: 110.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accentEnabled, Colors.tealAccent.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: accentEnabled.withValues(alpha: 0.55),
              blurRadius: 14.0,
              offset: Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Center(
          child: Icon(Icons.rocket_launch,
              color: Colors.white, size: 44.0),
        ),
      ),
    ),
  );

  final baselineBody = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accentEnabled.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: accentEnabled.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      children: [
        baselineHero,
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'tag: demo-baseline-hero',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: accentEnabled),
              ),
              SizedBox(height: 6.0),
              Text(
                'When the surrounding Navigator pushes a route that '
                'also contains a Hero with the same tag, the framework '
                'will lift this child into the overlay and animate it '
                'to the destination. With enabled = true (the default), '
                'this is the standard behaviour.',
                style: TextStyle(fontSize: 12.5, height: 1.45),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Inert — enabled = false
  // ============================================================
  print('=== Section 3: Inert enabled=false ===');

  final inertHeader = _sectionHeader(
    title: 'Section 3 · Inert (enabled = false)',
    subtitle:
        'Setting enabled to false silences the Hero. The widget still '
        'renders normally in place, but it is excluded from any route '
        'flight animation. Use this when a subtree is shown above a '
        'sheet, in a fade transition, or otherwise must not animate.',
    color: accentDisabled,
    icon: Icons.flight_land,
  );

  final inertHero = HeroMode(
    enabled: false,
    child: Hero(
      tag: 'demo-inert-hero',
      child: Container(
        width: 110.0,
        height: 110.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accentDisabled, Colors.orange.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: accentDisabled.withValues(alpha: 0.55),
              blurRadius: 14.0,
              offset: Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Center(
          child: Icon(Icons.do_not_disturb_on_outlined,
              color: Colors.white, size: 44.0),
        ),
      ),
    ),
  );

  final inertBody = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accentDisabled.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: accentDisabled.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      children: [
        inertHero,
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'tag: demo-inert-hero',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: accentDisabled),
              ),
              SizedBox(height: 6.0),
              Text(
                'enabled = false means the HeroController will skip this '
                'Hero entirely. The Hero widget is still legal, still '
                'painted, still keyed in the tree — but no flight will '
                'be scheduled for it on push/pop.',
                style: TextStyle(fontSize: 12.5, height: 1.45),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Side-by-side comparison
  // ============================================================
  print('=== Section 4: Comparison panel ===');

  final comparisonHeader = _sectionHeader(
    title: 'Section 4 · enabled=true vs enabled=false',
    subtitle:
        'The two panels below contain structurally identical Hero '
        'widgets. The only difference is the enclosing HeroMode.enabled '
        'flag. Visually at rest they look the same; the difference is '
        'observable only during a Navigator transition.',
    color: accentNeutral,
    icon: Icons.compare_arrows,
  );

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #114, P1):
  // The comparison row uses CrossAxisAlignment.stretch so the two
  // _comparisonPanel cards visually equalise their heights. The page root
  // wraps everything in a SingleChildScrollView → the row's parent gives it
  // unbounded vertical constraints, and Row(stretch) propagates that
  // unbounded height down to each Expanded child's _comparisonPanel Container
  // → "BoxConstraints forces an infinite height." Wrapping in IntrinsicHeight
  // forces a finite tight height derived from the tallest child, preserving
  // the visual intent (matched heights) without the unbounded-height assert.
  final comparisonRow = IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _comparisonPanel(
            color: accentEnabled,
            title: 'enabled: true',
            subtitle: 'will fly on transition',
            icon: Icons.check_circle,
            tag: 'cmp-enabled-hero',
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: _comparisonPanel(
            color: accentDisabled,
            title: 'enabled: false',
            subtitle: 'will NOT fly on transition',
            icon: Icons.block,
            tag: 'cmp-disabled-hero',
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Hero child variations
  // ============================================================
  print('=== Section 5: Hero child variations ===');

  final variationsHeader = _sectionHeader(
    title: 'Section 5 · Hero child variations',
    subtitle:
        'Hero is shape-agnostic. Anything renderable can be a Hero '
        'child: Containers, Cards, Icons, CircleAvatars, images, '
        'custom-painted shapes. HeroMode behaves the same regardless '
        'of what child the Hero wraps.',
    color: accentInfo,
    icon: Icons.widgets,
  );

  final variationContainer = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'var-container',
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.45),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
      ),
    ),
  );

  final variationCard = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'var-card',
      child: Card(
        elevation: 6.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.purple.shade300, width: 1.5),
        ),
        child: Container(
          width: 80.0,
          height: 80.0,
          alignment: Alignment.center,
          child: Icon(Icons.style, size: 36.0, color: Colors.purple),
        ),
      ),
    ),
  );

  final variationIcon = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'var-icon',
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: accentWarn.withValues(alpha: 0.5),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Icon(Icons.star, size: 48.0, color: accentWarn),
      ),
    ),
  );

  final variationAvatar = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'var-avatar',
      child: CircleAvatar(
        radius: 40.0,
        backgroundColor: Colors.pink.shade300,
        child: Text(
          'AB',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );

  // Faux Image.network — we use a gradient Container with an icon to
  // avoid network or asset fetches inside the interpreter sandbox.
  final variationImage = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'var-image',
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade400,
              Colors.lightGreen.shade200,
              Colors.lime.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.green.shade700, width: 2.0),
        ),
        child: Center(
          child: Icon(Icons.image, size: 36.0, color: Colors.white),
        ),
      ),
    ),
  );

  final variationCustom = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'var-custom',
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
        ),
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.red.shade300, Colors.deepPurple.shade400],
              center: Alignment.topLeft,
              radius: 1.2,
            ),
          ),
          child: Center(
            child: Icon(Icons.auto_awesome, color: Colors.white, size: 36.0),
          ),
        ),
      ),
    ),
  );

  final variationsRow = Wrap(
    spacing: 16.0,
    runSpacing: 16.0,
    children: [
      _variationTile('Container', variationContainer, Colors.blue),
      _variationTile('Card', variationCard, Colors.purple),
      _variationTile('Icon', variationIcon, accentWarn),
      _variationTile('CircleAvatar', variationAvatar, Colors.pink),
      _variationTile('Image (faux)', variationImage, Colors.green.shade700),
      _variationTile('Custom shape', variationCustom, Colors.deepPurple),
    ],
  );

  // ============================================================
  // SECTION 6: Tag discipline
  // ============================================================
  print('=== Section 6: Tag discipline ===');

  final tagHeader = _sectionHeader(
    title: 'Section 6 · Tag discipline',
    subtitle:
        'Hero tags must be unique within a Navigator subtree at any '
        'given time. Duplicate tags are the #1 cause of Hero crashes. '
        'Use stable, descriptive tags and prefix them when in doubt.',
    color: accentWarn,
    icon: Icons.label_important,
  );

  // Good: distinct, descriptive tags.
  final goodTagsList = <Widget>[];
  final goodTags = ['user-42-avatar', 'product-17-thumb', 'cart-icon-main'];
  for (final tag in goodTags) {
    goodTagsList.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.green.shade400),
        ),
        child: Row(
          children: [
            Icon(Icons.check, color: Colors.green.shade700, size: 16.0),
            SizedBox(width: 8.0),
            Text(
              "Hero(tag: '$tag', ...)",
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bad examples (rendered as text — actual duplicate tags would throw
  // at transition time, not at construction time).
  final badTagsList = <Widget>[];
  final badTagComments = [
    "// BAD: tag is null  -> Hero(tag: null, ...)",
    "// BAD: same tag twice in scope  -> tag: 'photo' (x2)",
    "// BAD: tag depends on index but list re-orders  -> tag: i",
    "// BAD: tag uses Object identity that rebuilds  -> tag: Object()",
  ];
  for (final txt in badTagComments) {
    badTagsList.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.red.shade400),
        ),
        child: Row(
          children: [
            Icon(Icons.close, color: Colors.red.shade700, size: 16.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                txt,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final tagBody = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accentWarn.withValues(alpha: 0.5)),
      boxShadow: [
        BoxShadow(
          color: accentWarn.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good tags (unique, descriptive, stable):',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green.shade800),
        ),
        SizedBox(height: 6.0),
        Column(children: goodTagsList),
        SizedBox(height: 14.0),
        Text(
          'Bad tag patterns (avoid):',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.red.shade800),
        ),
        SizedBox(height: 6.0),
        Column(children: badTagsList),
        SizedBox(height: 10.0),
        Text(
          'HeroMode interaction: when enabled = false, duplicate tags '
          'inside the disabled subtree no longer trigger conflicts, '
          'because the controller treats them as absent. This is one '
          'reason HeroMode is useful around dynamic content.',
          style: TextStyle(
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade800,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: flightShuttleBuilder + placeholderBuilder
  // ============================================================
  print('=== Section 7: Hero builders ===');

  final buildersHeader = _sectionHeader(
    title: 'Section 7 · flightShuttleBuilder & placeholderBuilder',
    subtitle:
        'Hero offers two optional builders that customize what is shown '
        'mid-flight (flightShuttleBuilder) and what is left in the '
        'source location while the flight is in progress '
        '(placeholderBuilder). HeroMode does not change their meaning, '
        'but disabling HeroMode means neither builder will ever fire.',
    color: Colors.deepPurple,
    icon: Icons.architecture,
  );

  final shuttleHero = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'shuttle-demo',
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        // Custom mid-flight visual: a glowing ring. Not actually shown
        // in this static demo since no transition fires, but the
        // closure is constructed and referenced by Hero.
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.white, Colors.deepPurple.shade300],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withValues(alpha: 0.6),
                blurRadius: 20.0,
              ),
            ],
          ),
          child: Icon(Icons.flight, color: Colors.white, size: 36.0),
        );
      },
      placeholderBuilder: (
        BuildContext context,
        Size heroSize,
        Widget child,
      ) {
        // Placeholder shown at the source while the flight is active.
        return Container(
          width: heroSize.width,
          height: heroSize.height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.grey.shade600,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          child: Center(
            child: Text(
              '...',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withValues(alpha: 0.5),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Center(
          child: Icon(Icons.flight_takeoff,
              color: Colors.white, size: 40.0),
        ),
      ),
    ),
  );

  final buildersBody = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shuttleHero,
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'flightShuttleBuilder',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                'Receives flightContext, animation, direction, and the '
                'two endpoint contexts. Return a custom widget that is '
                'painted in the overlay during the flight.',
                style: TextStyle(fontSize: 12.0, height: 1.4),
              ),
              SizedBox(height: 8.0),
              Text(
                'placeholderBuilder',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                'Receives the source size and the child. Return what '
                'should occupy the source slot while the Hero is in '
                'transit; default leaves an empty hole.',
                style: TextStyle(fontSize: 12.0, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Nested HeroMode
  // ============================================================
  print('=== Section 8: Nested HeroMode ===');

  final nestedHeader = _sectionHeader(
    title: 'Section 8 · Nested HeroMode',
    subtitle:
        'HeroMode reads its setting from the *nearest* enclosing '
        'HeroMode. An inner HeroMode therefore overrides the outer one. '
        'This lets you globally enable Heroes for a screen but punch '
        'out specific subtrees that should remain inert.',
    color: Colors.indigo,
    icon: Icons.layers,
  );

  final nestedDemo = HeroMode(
    enabled: true,
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flight_takeoff,
                  color: Colors.indigo, size: 18.0),
              SizedBox(width: 6.0),
              Text(
                'Outer HeroMode (enabled: true)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: HeroMode(
                  enabled: true,
                  child: Hero(
                    tag: 'nested-outer-only',
                    child: Container(
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade300,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'inner=true\nflies',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: HeroMode(
                  enabled: false,
                  child: Hero(
                    tag: 'nested-inner-disabled',
                    child: Container(
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.grey.shade700, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          'inner=false\nINERT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'The outer HeroMode allows flights for everything in the '
            'subtree. The inner HeroMode(enabled: false) blocks the '
            'right-hand Hero only. Other Heroes outside this subtree '
            'remain governed by the outer HeroMode.',
            style: TextStyle(
                fontSize: 12.0, height: 1.4, color: Colors.grey.shade800),
          ),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 9: Real-world product grid
  // ============================================================
  print('=== Section 9: Product grid ===');

  final gridHeader = _sectionHeader(
    title: 'Section 9 · Real-world: product grid',
    subtitle:
        'A common pattern: a grid of cards where the first three are '
        '"featured" and animate via Hero into a detail screen, while '
        'the remaining cards are "secondary" and intentionally do not '
        'animate. HeroMode wraps each card individually so the '
        'decision is local and obvious.',
    color: Colors.teal.shade800,
    icon: Icons.grid_view,
  );

  final products = <_Product>[
    _Product('Mountain Bike', 'BIKE-01', Colors.red.shade400, true,
        Icons.directions_bike),
    _Product('Tent 4P', 'TENT-04', Colors.green.shade500, true,
        Icons.holiday_village),
    _Product('Stove', 'STOVE-12', Colors.orange.shade500, true,
        Icons.local_fire_department),
    _Product('Bottle', 'BOTL-77', Colors.blue.shade400, false,
        Icons.water_drop),
    _Product('Map', 'MAP-09', Colors.brown.shade400, false, Icons.map),
    _Product('Compass', 'CMPS-22', Colors.indigo.shade400, false,
        Icons.explore),
  ];

  final productCards = <Widget>[];
  for (final p in products) {
    final card = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: p.color.withValues(alpha: 0.30),
            blurRadius: 10.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
        border: Border.all(
          color: p.featured
              ? p.color.withValues(alpha: 0.7)
              : Colors.grey.shade300,
          width: p.featured ? 2.0 : 1.0,
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroMode(
            enabled: p.featured,
            child: Hero(
              tag: 'product-${p.sku}',
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [p.color, p.color.withValues(alpha: 0.5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Icon(p.icon, color: Colors.white, size: 32.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            p.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: Colors.grey.shade900,
            ),
          ),
          Text(
            p.sku,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 4.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: p.featured
                  ? Colors.green.shade100
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              p.featured ? 'HeroMode: ON' : 'HeroMode: OFF',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: p.featured
                    ? Colors.green.shade800
                    : Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
    productCards.add(SizedBox(width: 130.0, child: card));
  }

  final productGrid = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: productCards,
  );

  // ============================================================
  // SECTION 10: Conditional opt-in patterns
  // ============================================================
  print('=== Section 10: Conditional patterns ===');

  final conditionalHeader = _sectionHeader(
    title: 'Section 10 · Conditional opt-in patterns',
    subtitle:
        'HeroMode.enabled is a plain bool, so it composes with any '
        'condition: feature flags, route arguments, theme settings, '
        'animation-reduce accessibility flags, or even the result of '
        'a Provider lookup. Three idiomatic patterns are shown below.',
    color: Colors.cyan.shade700,
    icon: Icons.tune,
  );

  // Pattern A: feature flag.
  final featureFlagOn = true;
  final patternA = HeroMode(
    enabled: featureFlagOn,
    child: Hero(
      tag: 'pattern-a-flag',
      child: _patternBox(
          'feature flag = $featureFlagOn', Colors.cyan.shade600),
    ),
  );

  // Pattern B: reduce-motion accessibility.
  final reduceMotion = false;
  final patternB = HeroMode(
    enabled: !reduceMotion,
    child: Hero(
      tag: 'pattern-b-reduce',
      child: _patternBox(
          'reduceMotion = $reduceMotion', Colors.cyan.shade700),
    ),
  );

  // Pattern C: route argument.
  final allowFlight = true;
  final patternC = HeroMode(
    enabled: allowFlight,
    child: Hero(
      tag: 'pattern-c-arg',
      child:
          _patternBox('routeArg.allowFlight', Colors.cyan.shade800),
    ),
  );

  final conditionalRow = Row(
    children: [
      Expanded(child: patternA),
      SizedBox(width: 8.0),
      Expanded(child: patternB),
      SizedBox(width: 8.0),
      Expanded(child: patternC),
    ],
  );

  // ============================================================
  // SECTION 11: Footguns and caveats
  // ============================================================
  print('=== Section 11: Footguns ===');

  final footgunHeader = _sectionHeader(
    title: 'Section 11 · Footguns & caveats',
    subtitle:
        'HeroMode is a thin wrapper but it surfaces the entire family '
        'of Hero gotchas. The list below collects the failure modes we '
        'see most often in code review.',
    color: accentDanger,
    icon: Icons.warning_amber,
  );

  final footgunItems = <Widget>[];
  final footguns = [
    _Footgun(
      'Disabling at the wrong scope',
      'HeroMode reads from the nearest enclosing scope. If you wrap '
          'the wrong subtree (too narrow / too broad), Heroes will fly '
          'or freeze unexpectedly.',
    ),
    _Footgun(
      'Forgetting that disabling skips placeholder builders too',
      'placeholderBuilder runs only during a flight. If HeroMode is '
          'false, no flight, no placeholder.',
    ),
    _Footgun(
      'Toggling enabled mid-route',
      'Changing enabled while a transition is in flight has undefined '
          'visual results. Decide before push, not during.',
    ),
    _Footgun(
      'Duplicate tags hidden behind enabled=false',
      'Disabling avoids the conflict, but as soon as you re-enable, '
          'the duplicate tag will throw. Audit tags regardless.',
    ),
    _Footgun(
      'HeroMode without a HeroController',
      'If there is no HeroController above (no MaterialApp/Navigator '
          'with hero observer), HeroMode is decorative — Heroes never '
          'fly and the flag has no observable effect.',
    ),
    _Footgun(
      'Wrapping a Navigator with HeroMode(enabled: false)',
      'Disables hero animations for the entire nested navigator. '
          'Often what you want, sometimes not — be explicit.',
    ),
  ];
  for (final f in footguns) {
    footgunItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: accentDanger, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: accentDanger.withValues(alpha: 0.18),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline, color: accentDanger, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade900,
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    f.body,
                    style:
                        TextStyle(fontSize: 12.0, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 12: Decision matrix & summary
  // ============================================================
  print('=== Section 12: Decision matrix ===');

  final summaryHeader = _sectionHeader(
    title: 'Section 12 · Decision matrix',
    subtitle:
        'When should you reach for HeroMode? The matrix below '
        'crystallizes the most useful heuristics. The summary row at '
        'the bottom is the one-sentence takeaway.',
    color: accentNeutral,
    icon: Icons.fact_check,
  );

  final matrixRows = <Widget>[];
  final matrix = [
    _MatrixRow(
        'Cross-route hero animation needed', 'enabled: true', accentEnabled),
    _MatrixRow('Subtree shown in modal sheet only', 'enabled: false',
        accentDisabled),
    _MatrixRow('List item that may be re-keyed', 'enabled: false',
        accentDisabled),
    _MatrixRow('Route ignores hero observer entirely',
        'wrap entire route', accentDisabled),
    _MatrixRow('Reduce-motion is on', 'enabled: !reduceMotion',
        accentInfo),
    _MatrixRow(
        'Feature in beta', 'enabled: featureFlag', accentWarn),
    _MatrixRow('Default everywhere else', 'enabled: true (omit)',
        accentEnabled),
  ];
  for (final m in matrix) {
    matrixRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: m.color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: m.color.withValues(alpha: 0.55)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                m.scenario,
                style: TextStyle(fontSize: 12.5),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                m.recommendation,
                style: TextStyle(
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: m.color,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final summaryCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accentNeutral.withValues(alpha: 0.85),
          Colors.deepPurple.withValues(alpha: 0.55),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: accentNeutral.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Takeaway',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'HeroMode is the "do-the-Hero-thing-here?" knob. Default it '
          'to true wherever you want the standard cross-route flight, '
          'and switch it off whenever a subtree must stay still during '
          'transitions. Treat it as documentation, not magic.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Final assembly
  // ============================================================
  print('=== Assembling final scaffold ===');

  final allSections = <Widget>[
    anatomyHeader,
    SizedBox(height: 14.0),
    anatomyDiagram,
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    baselineHeader,
    SizedBox(height: 12.0),
    baselineBody,
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    inertHeader,
    SizedBox(height: 12.0),
    inertBody,
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    comparisonHeader,
    SizedBox(height: 12.0),
    comparisonRow,
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    variationsHeader,
    SizedBox(height: 12.0),
    variationsRow,
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    tagHeader,
    SizedBox(height: 12.0),
    tagBody,
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    buildersHeader,
    SizedBox(height: 12.0),
    buildersBody,
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    nestedHeader,
    SizedBox(height: 12.0),
    nestedDemo,
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    gridHeader,
    SizedBox(height: 12.0),
    productGrid,
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    conditionalHeader,
    SizedBox(height: 12.0),
    conditionalRow,
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    footgunHeader,
    SizedBox(height: 12.0),
    Column(children: footgunItems),
    SizedBox(height: 24.0),
    Divider(),
    SizedBox(height: 8.0),
    summaryHeader,
    SizedBox(height: 12.0),
    Column(children: matrixRows),
    SizedBox(height: 16.0),
    summaryCard,
  ];

  print('HeroMode Deep Demo assembled with ${allSections.length} entries');

  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: allSections,
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Helper builders. These are top-level functions, not classes, so
// they fit within the "no top-level classes beyond what exists"
// rule while still keeping the build() body readable.
// ----------------------------------------------------------------

Widget _sectionHeader({
  required String title,
  required String subtitle,
  required Color color,
  required IconData icon,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.95),
          color.withValues(alpha: 0.65),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.97),
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonPanel({
  required Color color,
  required String title,
  required String subtitle,
  required IconData icon,
  required String tag,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace',
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        Center(
          child: HeroMode(
            enabled: title.contains('true'),
            child: Hero(
              tag: tag,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.5),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(icon, color: Colors.white, size: 40.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'tag: $tag',
          style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget _variationTile(String label, Widget hero, Color color) {
  return Container(
    width: 110.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.55)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: hero),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _patternBox(String label, Color color) {
  return Container(
    height: 80.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11.5,
            fontFamily: 'monospace',
          ),
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Tiny const-constructible value holders. These tighten the demo
// without violating the "no top-level classes" rule (these *are*
// the small private value-holder classes the contract permits).
// ----------------------------------------------------------------

class _Product {
  final String name;
  final String sku;
  final Color color;
  final bool featured;
  final IconData icon;
  const _Product(this.name, this.sku, this.color, this.featured, this.icon);
}

class _Footgun {
  final String title;
  final String body;
  const _Footgun(this.title, this.body);
}

class _MatrixRow {
  final String scenario;
  final String recommendation;
  final Color color;
  const _MatrixRow(this.scenario, this.recommendation, this.color);
}
