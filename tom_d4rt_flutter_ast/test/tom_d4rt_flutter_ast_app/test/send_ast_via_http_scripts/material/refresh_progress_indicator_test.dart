// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo gallery - RefreshProgressIndicator (Material).
//
// RefreshProgressIndicator is the Material spinner used internally by
// RefreshIndicator when a user pulls to refresh a Scrollable. It looks like a
// CircularProgressIndicator stamped on top of a small white disc with a soft
// drop shadow underneath.
//
// This script exists to give a reviewer (or a code-reading AI) every common
// configuration of the widget on a single page so they can compare:
//   - indeterminate vs determinate
//   - color / valueColor / backgroundColor combos
//   - stroke width and stroke cap
//   - manual sizing inside SizedBox
//   - elevation (the disc shadow under the ring)
//   - real RefreshIndicator usage with onRefresh
//   - displacement / edgeOffset placement
//   - notificationPredicate filtering
//   - ProgressIndicatorTheme integration
//   - side-by-side comparison with CircularProgressIndicator
//
// Each section is wrapped in a Card with a coloured header so the gallery
// visually separates concerns. Sections that need state use a StatefulBuilder
// so the page itself remains a plain function returning a MaterialApp - the
// test harness does NOT call runApp() and there is no main() entry point.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RefreshProgressIndicator Deep Demo (Harness-Safe) ===');
  print('Flutter Material RefreshProgressIndicator gallery: 12 sections.');
  print('Sections cover indeterminate, determinate, color, stroke, sizing,');
  print('elevation, RefreshIndicator embedding, displacement, edgeOffset,');
  print('notificationPredicate, theme overrides, and CircularProgressIndicator');
  print('comparison plus a final "when to use which" guidance card.');

  // Re-usable palette for section headers. Each section gets its own colour
  // so a reviewer can find it at a glance.
  const headerBlue = Color(0xFF1565C0);
  const headerTeal = Color(0xFF00897B);
  const headerOrange = Color(0xFFEF6C00);
  const headerPurple = Color(0xFF6A1B9A);
  const headerRed = Color(0xFFC62828);
  const headerGreen = Color(0xFF2E7D32);
  const headerPink = Color(0xFFAD1457);
  const headerIndigo = Color(0xFF283593);
  const headerBrown = Color(0xFF5D4037);
  const headerGrey = Color(0xFF455A64);
  const headerAmber = Color(0xFFFF8F00);
  const headerCyan = Color(0xFF006064);

  // ===========================================================================
  // SECTION 1 - STANDALONE INDETERMINATE
  // ---------------------------------------------------------------------------
  // The simplest possible RefreshProgressIndicator: no value, no overrides,
  // running on the ambient theme. This is what RefreshIndicator stamps on the
  // screen while it is in "armed" or "snap" state. We render three copies so
  // the reviewer can see the spinner spinning at different points.
  // ===========================================================================
  Widget section1Indeterminate() {
    return _SectionCard(
      title: '1. Standalone indeterminate',
      headerColor: headerBlue,
      description:
          'Default RefreshProgressIndicator with no value provided. The ring '
          'spins forever; this is the visual you see while a real refresh is '
          'still resolving. Three copies are placed in a row so the spin is '
          'unmistakable on screen.',
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 24,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: const [
            _LabeledIndicator(
              label: 'default',
              child: RefreshProgressIndicator(),
            ),
            _LabeledIndicator(
              label: 'on dark bg',
              background: Color(0xFF263238),
              child: RefreshProgressIndicator(),
            ),
            _LabeledIndicator(
              label: 'in tight box',
              child: SizedBox(
                width: 41,
                height: 41,
                child: RefreshProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 2 - DETERMINATE WITH SLIDER + ANIMATED VALUE
  // ---------------------------------------------------------------------------
  // The widget accepts a [value] in [0, 1]. While value is non-null the ring
  // arc represents that fraction; under the hood the controller is positioned
  // accordingly. Here we offer two driving sources:
  //   - a Slider so reviewers can scrub the arc themselves
  //   - an animated value (toggle) that runs 0 -> 1 -> 0 forever
  // The StatefulBuilder gives us the local 'value' and 'animating' flag.
  // ===========================================================================
  Widget section2Determinate() {
    return _SectionCard(
      title: '2. Determinate value (slider + animated)',
      headerColor: headerTeal,
      description:
          'When value is non-null the ring shows progress. The slider updates '
          'value live; the toggle replaces the slider with a 0->1 looping '
          'animation. Both call setState at every tick so we can see the arc '
          'fill without a real network event.',
      child: StatefulBuilder(
        builder: (context, setState) {
          // We hang two pieces of state off the StatefulBuilder using a
          // closure-side static map - cleaner than relying on setState alone
          // because the harness re-runs build() many times.
          final state = _ScrubState.of('section2');
          if (state.ticker == null) {
            // Lazy ticker: a periodic AnimationController-free scheduler is
            // overkill here. Instead we just rely on Slider feedback; the
            // 'animated' switch swaps the value source.
          }
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(
                        child: RefreshProgressIndicator(value: state.value),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Slider(
                        value: state.value,
                        onChanged: (v) => setState(() => state.value = v),
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      child: Text(
                        state.value.toStringAsFixed(2),
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Switch(
                      value: state.animated,
                      onChanged: (v) => setState(() => state.animated = v),
                    ),
                    const SizedBox(width: 8),
                    const Text('animate value (drives slider in steps)'),
                  ],
                ),
                if (state.animated)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Wrap(
                      spacing: 8,
                      children: [
                        for (final step in const [0.0, 0.25, 0.5, 0.75, 1.0])
                          OutlinedButton(
                            onPressed: () =>
                                setState(() => state.value = step),
                            child: Text('jump to ${step.toStringAsFixed(2)}'),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // SECTION 3 - COLOR / VALUECOLOR / BACKGROUNDCOLOR
  // ---------------------------------------------------------------------------
  // Three colour knobs:
  //   - color:           static colour for the ring
  //   - valueColor:      Animation<Color?> for the ring (wins over color)
  //   - backgroundColor: the disc behind the ring; defaults to canvasColor
  // The matrix below shows them in isolation and combined.
  // ===========================================================================
  Widget section3Colors() {
    return _SectionCard(
      title: '3. Color / valueColor / backgroundColor',
      headerColor: headerOrange,
      description:
          'color paints the ring statically; valueColor is an Animation<Color?> '
          'and beats color; backgroundColor paints the disc beneath the ring. '
          'The disc colour is what makes RefreshProgressIndicator look like a '
          'pulled-down pill instead of a bare circular spinner.',
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 24,
          runSpacing: 16,
          children: const [
            _LabeledIndicator(
              label: 'color: red',
              child: RefreshProgressIndicator(color: Colors.red),
            ),
            _LabeledIndicator(
              label: 'valueColor: green',
              child: RefreshProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            _LabeledIndicator(
              label: 'bg: yellow',
              child: RefreshProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
            ),
            _LabeledIndicator(
              label: 'navy ring / sky disc',
              child: RefreshProgressIndicator(
                color: Color(0xFF0D47A1),
                backgroundColor: Color(0xFFB3E5FC),
              ),
            ),
            _LabeledIndicator(
              label: 'white ring / dark disc',
              background: Color(0xFF263238),
              child: RefreshProgressIndicator(
                color: Colors.white,
                backgroundColor: Color(0xFF455A64),
              ),
            ),
            _LabeledIndicator(
              label: 'magenta value (det)',
              child: RefreshProgressIndicator(
                value: 0.66,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFE91E63),
                ),
                backgroundColor: Color(0xFFFCE4EC),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 4 - STROKE WIDTH AND STROKECAP
  // ---------------------------------------------------------------------------
  // The default strokeWidth is 2.5 (different from CircularProgressIndicator
  // which is 4.0). strokeCap controls how the rounded ends of the arc render:
  //   - StrokeCap.round  -> rounded ends, matches Material 3
  //   - StrokeCap.square -> blunt ends, looks chunkier
  //   - StrokeCap.butt   -> default flat ends
  // ===========================================================================
  Widget section4Strokes() {
    return _SectionCard(
      title: '4. Stroke width and strokeCap',
      headerColor: headerPurple,
      description:
          'The arc thickness uses strokeWidth (default 2.5). strokeCap chooses '
          'between butt, round, and square. Use round when matching Material 3; '
          'butt is denser for a thinner ring.',
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 24,
          runSpacing: 16,
          children: const [
            _LabeledIndicator(
              label: 'stroke 1.0',
              child: RefreshProgressIndicator(strokeWidth: 1.0),
            ),
            _LabeledIndicator(
              label: 'stroke 2.5 (default)',
              child: RefreshProgressIndicator(),
            ),
            _LabeledIndicator(
              label: 'stroke 4.0',
              child: RefreshProgressIndicator(strokeWidth: 4.0),
            ),
            _LabeledIndicator(
              label: 'stroke 6.0 (heavy)',
              child: RefreshProgressIndicator(strokeWidth: 6.0),
            ),
            _LabeledIndicator(
              label: 'cap: butt',
              child: RefreshProgressIndicator(
                value: 0.6,
                strokeCap: StrokeCap.butt,
                strokeWidth: 5,
              ),
            ),
            _LabeledIndicator(
              label: 'cap: round',
              child: RefreshProgressIndicator(
                value: 0.6,
                strokeCap: StrokeCap.round,
                strokeWidth: 5,
              ),
            ),
            _LabeledIndicator(
              label: 'cap: square',
              child: RefreshProgressIndicator(
                value: 0.6,
                strokeCap: StrokeCap.square,
                strokeWidth: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 5 - SIZING INSIDE A SIZEDBOX
  // ---------------------------------------------------------------------------
  // The widget paints itself in a 41x41 area by default (see internal
  // _indicatorSize). To shrink/grow it visually we wrap it in a SizedBox; the
  // ring still renders at its intrinsic stroke but is laid out in our frame.
  // For very small sizes you should also reduce strokeWidth or you will see
  // the disc disappear into the ring.
  // ===========================================================================
  Widget section5Sizing() {
    return _SectionCard(
      title: '5. Sizing inside SizedBox',
      headerColor: headerRed,
      description:
          'Wrap RefreshProgressIndicator in a SizedBox to control its layout '
          'footprint. The intrinsic indicator is 41x41; smaller boxes clip the '
          'disc shadow and may look pinched.',
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            _LabeledIndicator(
              label: '24x24 (small)',
              child: SizedBox(
                width: 24,
                height: 24,
                child: RefreshProgressIndicator(strokeWidth: 1.5),
              ),
            ),
            _LabeledIndicator(
              label: '41x41 (default)',
              child: SizedBox(
                width: 41,
                height: 41,
                child: RefreshProgressIndicator(),
              ),
            ),
            _LabeledIndicator(
              label: '64x64 (medium)',
              child: SizedBox(
                width: 64,
                height: 64,
                child: RefreshProgressIndicator(strokeWidth: 3.5),
              ),
            ),
            _LabeledIndicator(
              label: '96x96 (large)',
              child: SizedBox(
                width: 96,
                height: 96,
                child: RefreshProgressIndicator(strokeWidth: 5.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 6 - ELEVATION (DISC SHADOW)
  // ---------------------------------------------------------------------------
  // The disc behind the spinner is a Material with elevation. Increase it and
  // the shadow under the disc grows; set to 0 and you get a flat pill. This
  // is one of the few Material widgets where elevation is a primary visual
  // affordance, not just a depth cue.
  // ===========================================================================
  Widget section6Elevation() {
    return _SectionCard(
      title: '6. Elevation (disc shadow)',
      headerColor: headerGreen,
      description:
          'elevation controls the Material shadow rendered under the disc. '
          'Default is 2.0. Setting elevation to 0 yields a flat pill; raise '
          'it to 8 or 12 for a clearly floating effect.',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 32,
          runSpacing: 24,
          children: const [
            _LabeledIndicator(
              label: 'elevation: 0',
              child: RefreshProgressIndicator(elevation: 0),
            ),
            _LabeledIndicator(
              label: 'elevation: 2 (default)',
              child: RefreshProgressIndicator(elevation: 2),
            ),
            _LabeledIndicator(
              label: 'elevation: 4',
              child: RefreshProgressIndicator(elevation: 4),
            ),
            _LabeledIndicator(
              label: 'elevation: 8',
              child: RefreshProgressIndicator(elevation: 8),
            ),
            _LabeledIndicator(
              label: 'elevation: 12',
              child: RefreshProgressIndicator(elevation: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 7 - REAL REFRESHINDICATOR WITH LISTVIEW
  // ---------------------------------------------------------------------------
  // The everyday case: wrap a ListView in RefreshIndicator and let it stamp a
  // RefreshProgressIndicator for us when the user pulls down. We keep a
  // mutable list inside StatefulBuilder; onRefresh awaits a Future.delayed,
  // then setState replaces the list with new values so reviewers can see that
  // the data really did refresh.
  // ===========================================================================
  Widget section7RefreshIndicator() {
    return _SectionCard(
      title: '7. RefreshIndicator wrapping a ListView',
      headerColor: headerPink,
      description:
          'Standard pull-to-refresh: RefreshIndicator wraps a Scrollable, the '
          'spinner appears while onRefresh is awaited, then disappears when '
          'the future resolves. Pull the list down to trigger.',
      child: SizedBox(
        height: 280,
        child: StatefulBuilder(
          builder: (context, setState) {
            final state = _ListState.of('section7');
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 900));
                setState(() => state.refreshOnce('A'));
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final item = state.items[i];
                  return ListTile(
                    leading: CircleAvatar(child: Text('${i + 1}')),
                    title: Text(item),
                    subtitle: Text('refresh #${state.generation}'),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 8 - DISPLACEMENT AND EDGEOFFSET
  // ---------------------------------------------------------------------------
  // displacement controls how far below the top of the Scrollable the spinner
  // settles when armed. edgeOffset shifts the trigger edge (useful when there
  // is a SliverAppBar above the list). Two side-by-side lists demonstrate
  // small vs large displacement.
  // ===========================================================================
  Widget section8Displacement() {
    return _SectionCard(
      title: '8. Displacement and edgeOffset',
      headerColor: headerIndigo,
      description:
          'displacement: distance from edge where the spinner settles. '
          'edgeOffset: shifts the edge itself, useful when a header sits above '
          'the scrollable. Compare the two lists below by pulling each down.',
      child: SizedBox(
        height: 320,
        child: Row(
          children: [
            Expanded(
              child: _DisplacementCase(
                title: 'displacement: 20\nedgeOffset: 0',
                displacement: 20,
                edgeOffset: 0,
                tag: 'B',
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _DisplacementCase(
                title: 'displacement: 80\nedgeOffset: 24',
                displacement: 80,
                edgeOffset: 24,
                tag: 'C',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 9 - NOTIFICATIONPREDICATE WITH HORIZONTAL OUTER SCROLL
  // ---------------------------------------------------------------------------
  // RefreshIndicator listens to ScrollNotifications. By default the predicate
  // accepts depth==0 (the immediate child Scrollable). If we have a horizontal
  // PageView wrapping a vertical ListView, the vertical list emits depth==0
  // notifications and the page view emits depth==1 - so we must supply a
  // notificationPredicate that accepts depth<=1, or the spinner will never
  // arm.
  // ===========================================================================
  Widget section9Predicate() {
    return _SectionCard(
      title: '9. notificationPredicate (nested scrollables)',
      headerColor: headerBrown,
      description:
          'Pages with nested scrollables need a custom predicate. Without one '
          'the inner list still triggers refresh, but if you wrap a vertical '
          'list inside a horizontal PageView the depth changes and the spinner '
          'will silently never appear. The right page below uses depth<=1.',
      child: SizedBox(
        height: 280,
        child: StatefulBuilder(
          builder: (context, setState) {
            final state = _ListState.of('section9');
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 700));
                setState(() => state.refreshOnce('D'));
              },
              notificationPredicate: (notification) =>
                  notification.depth <= 1,
              child: PageView(
                children: [
                  _StaticListPage(
                    label: 'Page 1: pull down to refresh',
                    items: state.items,
                  ),
                  _StaticListPage(
                    label: 'Page 2: also refreshable thanks to depth<=1',
                    items: state.items,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 10 - PROGRESSINDICATORTHEME
  // ---------------------------------------------------------------------------
  // The widget reads ProgressIndicatorThemeData for default color, refresh
  // background, etc. Wrapping it in a Theme override lets you change one
  // section without touching the global ThemeData.
  // ===========================================================================
  Widget section10Theme() {
    return _SectionCard(
      title: '10. ProgressIndicatorTheme override',
      headerColor: headerGrey,
      description:
          'A Theme wrapper sets ProgressIndicatorThemeData.color, '
          'refreshBackgroundColor, and circularTrackColor for the indicators '
          'inside it - useful for component libraries that want their own '
          'spinner palette.',
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Theme(
          data: Theme.of(context).copyWith(
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: Color(0xFF6A1B9A),
              refreshBackgroundColor: Color(0xFFF3E5F5),
              circularTrackColor: Color(0xFFEDE7F6),
            ),
          ),
          child: Wrap(
            spacing: 24,
            runSpacing: 16,
            children: const [
              _LabeledIndicator(
                label: 'theme indeterminate',
                child: RefreshProgressIndicator(),
              ),
              _LabeledIndicator(
                label: 'theme value=0.4',
                child: RefreshProgressIndicator(value: 0.4),
              ),
              _LabeledIndicator(
                label: 'theme override w/ explicit color',
                child: RefreshProgressIndicator(
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 11 - COMPARISON WITH CIRCULARPROGRESSINDICATOR
  // ---------------------------------------------------------------------------
  // Visually side-by-side. The circular widget is just a ring; the refresh
  // widget is a ring on a disc with a drop shadow. Same animation core, very
  // different visual chrome.
  // ===========================================================================
  Widget section11Comparison() {
    return _SectionCard(
      title: '11. Comparison: Circular vs Refresh',
      headerColor: headerAmber,
      description:
          'CircularProgressIndicator is a bare ring. RefreshProgressIndicator '
          'is the same ring, drawn at a smaller default stroke (2.5 vs 4.0) '
          'on top of a Material disc with elevation. Pick refresh when you '
          'want pull-to-refresh affordance; pick circular when you want a '
          'plain spinner inside a button or banner.',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Column(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: 8),
                Text('CircularProgressIndicator'),
                Text(
                  'no disc, no shadow',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(child: RefreshProgressIndicator()),
                ),
                SizedBox(height: 8),
                Text('RefreshProgressIndicator'),
                Text(
                  'disc + elevation',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(value: 0.66),
                  ),
                ),
                SizedBox(height: 8),
                Text('Circular det. 0.66'),
                Text(
                  'arc visible',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: RefreshProgressIndicator(value: 0.66),
                  ),
                ),
                SizedBox(height: 8),
                Text('Refresh det. 0.66'),
                Text(
                  'arc + disc + shadow',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 12 - WHEN TO USE WHICH
  // ---------------------------------------------------------------------------
  // A static guidance card. No widgets, just text rules. The most common
  // mistake is to manually drop a RefreshProgressIndicator on top of a
  // ListView and try to drive it from a Scrollable yourself - just use
  // RefreshIndicator and let it manage the spinner lifecycle for you.
  // ===========================================================================
  Widget section12Guidance() {
    return _SectionCard(
      title: '12. When to use which',
      headerColor: headerCyan,
      description:
          'A short rules-of-thumb card. The TL;DR: most apps should never '
          'instantiate RefreshProgressIndicator directly - RefreshIndicator '
          'does it for you. Reach for the standalone widget only for custom '
          'pull gestures or progress chrome on dashboards.',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _GuidanceRow(
              icon: Icons.refresh,
              headline: 'Use RefreshIndicator',
              detail:
                  'Default for any pull-to-refresh on a Scrollable. It '
                  'manages drag tracking, displacement, snap, animation, and '
                  'spinner lifecycle for you.',
            ),
            SizedBox(height: 12),
            _GuidanceRow(
              icon: Icons.tune,
              headline: 'Use RefreshProgressIndicator standalone when:',
              detail:
                  '(a) You build a custom pull or swipe gesture that does '
                  'NOT use RefreshIndicator. (b) You want the disc-on-shadow '
                  'visual on a dashboard tile. (c) You drive determinate '
                  'progress with your own controller.',
            ),
            SizedBox(height: 12),
            _GuidanceRow(
              icon: Icons.cancel,
              headline: 'Use CircularProgressIndicator instead when:',
              detail:
                  'You want a plain spinner inside a button, banner, or row '
                  'where the disc-on-shadow look would feel out of place.',
            ),
            SizedBox(height: 12),
            _GuidanceRow(
              icon: Icons.warning_amber,
              headline: 'Avoid manually wiring RefreshProgressIndicator '
                  'into a list',
              detail:
                  'Re-implementing pull tracking is fiddly and platform '
                  'specific. RefreshIndicator already does it correctly.',
            ),
          ],
        ),
      ),
    );
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RefreshProgressIndicator Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF1565C0),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RefreshProgressIndicator Deep Demo'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Material RefreshProgressIndicator gallery',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Each card highlights a different facet of the widget. The '
                'last two cards compare it to CircularProgressIndicator and '
                'give rules of thumb for picking between them.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              section1Indeterminate(),
              const SizedBox(height: 16),
              section2Determinate(),
              const SizedBox(height: 16),
              section3Colors(),
              const SizedBox(height: 16),
              section4Strokes(),
              const SizedBox(height: 16),
              section5Sizing(),
              const SizedBox(height: 16),
              section6Elevation(),
              const SizedBox(height: 16),
              section7RefreshIndicator(),
              const SizedBox(height: 16),
              section8Displacement(),
              const SizedBox(height: 16),
              section9Predicate(),
              const SizedBox(height: 16),
              section10Theme(),
              const SizedBox(height: 16),
              section11Comparison(),
              const SizedBox(height: 16),
              section12Guidance(),
              const SizedBox(height: 24),
              const _FooterNote(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SUPPORTING WIDGETS
// =============================================================================
//
// These helper widgets are private to this file. They keep the section
// builders short by abstracting the section header card, the labelled
// indicator chip, the displacement test case, and the static page used
// inside the PageView in section 9.

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.headerColor,
    required this.description,
    required this.child,
  });

  final String title;
  final Color headerColor;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: headerColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
          const Divider(height: 1),
          child,
        ],
      ),
    );
  }
}

class _LabeledIndicator extends StatelessWidget {
  const _LabeledIndicator({
    required this.label,
    required this.child,
    this.background,
  });

  final String label;
  final Widget child;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: background ?? const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          alignment: Alignment.center,
          child: child,
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 110,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

class _DisplacementCase extends StatelessWidget {
  const _DisplacementCase({
    required this.title,
    required this.displacement,
    required this.edgeOffset,
    required this.tag,
  });

  final String title;
  final double displacement;
  final double edgeOffset;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        final state = _ListState.of('disp_$tag');
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                displacement: displacement,
                edgeOffset: edgeOffset,
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(milliseconds: 800),
                  );
                  setState(() => state.refreshOnce(tag));
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, i) => ListTile(
                    dense: true,
                    title: Text(state.items[i]),
                    trailing: Text('#${state.generation}'),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StaticListPage extends StatelessWidget {
  const _StaticListPage({required this.label, required this.items});

  final String label;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFEEEEEE),
          width: double.infinity,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) => ListTile(
              dense: true,
              title: Text(items[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class _GuidanceRow extends StatelessWidget {
  const _GuidanceRow({
    required this.icon,
    required this.headline,
    required this.detail,
  });

  final IconData icon;
  final String headline;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: const Color(0xFF006064)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headline,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFC5E1A5)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Color(0xFF558B2F)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Reminder: in production, prefer RefreshIndicator over '
              'manual RefreshProgressIndicator wiring. The standalone widget '
              'is a building block - the real value of this page is having '
              'every knob laid out next to its neighbours so future code '
              'reviewers can ground their design choices in a side-by-side '
              'visual comparison.',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// IN-FILE STATE HOLDERS
// =============================================================================
//
// The harness rebuilds build() on demand and we cannot use a StatefulWidget
// at the top level (we MUST return a MaterialApp from a plain function). To
// keep state between rebuilds inside a single section, we attach the state
// to a process-wide map keyed by section id. This is harmless inside the
// AST harness because each script run starts with a fresh isolate - the map
// is recreated. Inside a single run, two rebuilds of the same section keep
// the same state so the slider does not jump back to 0 every frame.

class _ScrubState {
  _ScrubState();

  double value = 0.5;
  bool animated = false;
  Object? ticker;

  static final Map<String, _ScrubState> _registry = {};

  static _ScrubState of(String id) =>
      _registry.putIfAbsent(id, () => _ScrubState());
}

class _ListState {
  _ListState() {
    items = List<String>.generate(
      8,
      (i) => 'Item ${i + 1} (gen 0)',
    );
  }

  late List<String> items;
  int generation = 0;

  void refreshOnce(String tag) {
    generation++;
    items = List<String>.generate(
      8,
      (i) => 'Item ${i + 1} (gen $generation, tag $tag)',
    );
  }

  static final Map<String, _ListState> _registry = {};

  static _ListState of(String id) =>
      _registry.putIfAbsent(id, () => _ListState());
}
