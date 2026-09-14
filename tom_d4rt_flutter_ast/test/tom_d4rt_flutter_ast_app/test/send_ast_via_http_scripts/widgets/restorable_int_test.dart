// Deep visual demo for Flutter's `RestorableInt`.
//
// `RestorableInt` is a `RestorableProperty<int>` that persists a non-null
// integer across state restoration. The key contrast with `RestorableIntN`
// is that `RestorableInt` never holds null — there is always a value. That
// makes it ideal for counters, indices, step numbers and small enum-like
// integers where "no value" is never a meaningful state.
//
// Under the hood, `RestorableInt` serialises a single `int` into the
// restoration bucket managed by the surrounding `RestorationMixin`. When
// the engine re-inflates the widget tree, `restoreState` is called with the
// old bucket and the property re-reads its stored int. Because ints round-
// trip cleanly through the platform channel, there is no encoding story to
// worry about — just a register / unregister dance on the mixin.
//
// This demo stitches FIVE genuinely different integer use-cases into one
// stateful widget, each with its own visual grammar:
//   1. Shopping cart badge count (pure magnitude, discrete events).
//   2. Multi-step wizard progress index (bounded enum-like integer).
//   3. Image carousel selected index (bounded index with wrap-around).
//   4. Custom +/- counter with wide stride (signed arithmetic).
//   5. Leaderboard ordinal rank (interpretation: 1st, 2nd, 3rd, ...).
//
// Each scenario reads and writes a single `RestorableInt`. None of them
// touch nullability — they are all about *interpretation* of numbers.

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// Entry point for the d4rt harness. Returns a `MaterialApp` directly so the
// runner can mount it without needing a `main()`.
dynamic build(BuildContext context) {
  // `kDebugMode` comes from `package:flutter/foundation.dart` and is used
  // here so that the extra import pulls its weight under a strict analyzer.
  if (kDebugMode) {
    debugPrint('[RestorableInt demo] Building...');
  }
  return MaterialApp(
    title: 'RestorableInt Deep Demo',
    theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
    restorationScopeId: 'restorable_int_demo',
    home: const AppStateDemo(),
  );
}

// Top-level stateful shell. Everything interesting lives in the state class
// which mixes in `RestorationMixin` — that is the contract every
// `RestorableProperty` needs in order to be registered with a bucket.
class AppStateDemo extends StatefulWidget {
  const AppStateDemo({super.key});

  @override
  State<AppStateDemo> createState() => _AppStateDemoState();
}

class _AppStateDemoState extends State<AppStateDemo>
    with RestorationMixin {
  // Five `RestorableInt` properties, one per scenario. Each one owns its own
  // restoration key. The initial values below are the ones the user will see
  // on first launch, before any restoration has happened.
  final RestorableInt _cartItems = RestorableInt(3);
  final RestorableInt _wizardStep = RestorableInt(1);
  final RestorableInt _carouselIndex = RestorableInt(0);
  final RestorableInt _customCounter = RestorableInt(0);
  final RestorableInt _rank = RestorableInt(7);

  // The restoration id is the key under which this widget's bucket is
  // stored. Keep it stable across hot reloads or you will lose state.
  @override
  String? get restorationId => 'app_state_demo';

  // Register every property on the bucket with a unique id. The mixin takes
  // care of re-reading the value from the bucket on the first call and of
  // writing any subsequent changes back.
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_cartItems, 'cart_items');
    registerForRestoration(_wizardStep, 'wizard_step');
    registerForRestoration(_carouselIndex, 'carousel_index');
    registerForRestoration(_customCounter, 'custom_counter');
    registerForRestoration(_rank, 'rank');
  }

  // Every `RestorableProperty` must be disposed to avoid leaking listeners.
  @override
  void dispose() {
    _cartItems.dispose();
    _wizardStep.dispose();
    _carouselIndex.dispose();
    _customCounter.dispose();
    _rank.dispose();
    super.dispose();
  }

  // Small helper so the five scenarios can share a title row without
  // duplicating decoration. Each scenario still draws its own body.
  Widget _sectionHeader(String number, String title, IconData icon,
      Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestorableInt Deep Demo'),
        backgroundColor: Colors.green.shade100,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            _sectionHeader('1', 'Shopping cart badge',
                Icons.shopping_cart, Colors.red),
            _buildCartSection(),
            const Divider(height: 32),
            _sectionHeader('2', 'Multi-step wizard progress',
                Icons.linear_scale, Colors.blue),
            _buildWizardSection(),
            const Divider(height: 32),
            _sectionHeader('3', 'Image carousel selected index',
                Icons.photo_library, Colors.purple),
            _buildCarouselSection(),
            const Divider(height: 32),
            _sectionHeader('4', 'Custom +/- 5 counter',
                Icons.exposure, Colors.orange),
            _buildCounterSection(),
            const Divider(height: 32),
            _sectionHeader('5', 'Leaderboard ordinal rank',
                Icons.emoji_events, Colors.amber),
            _buildLeaderboardSection(),
            const Divider(height: 32),
            _buildTeachingFooter(),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------
  // Scenario 1 — Shopping cart badge
  //
  // A cart icon with a red badge, plus a product-tile grid showing a mock
  // preview of the items. The integer here is pure magnitude: it never goes
  // negative because the UI disables the minus button at zero.
  // --------------------------------------------------------------------
  Widget _buildCartSection() {
    final int count = _cartItems.value;

    // Six fake product tiles cycled by index. Real apps would pull these
    // from a model; here we just want distinct colored blocks.
    const List<List<Color>> productGradients = <List<Color>>[
      <Color>[Color(0xFFE57373), Color(0xFFC62828)],
      <Color>[Color(0xFF64B5F6), Color(0xFF1565C0)],
      <Color>[Color(0xFF81C784), Color(0xFF2E7D32)],
      <Color>[Color(0xFFFFB74D), Color(0xFFE65100)],
      <Color>[Color(0xFFBA68C8), Color(0xFF6A1B9A)],
      <Color>[Color(0xFF4DB6AC), Color(0xFF00695C)],
    ];

    final int visibleTiles = count > 12 ? 12 : count;
    final int overflow = count - visibleTiles;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.shade200),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart icon with overlaid badge. When the count is zero the
            // badge is hidden so the chrome stays calm.
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.shopping_cart,
                        size: 40,
                        color: Colors.red.shade700,
                      ),
                    ),
                    if (count > 0)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.shade600,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.white, width: 2),
                          ),
                          child: Text(
                            count > 99 ? '99+' : '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 20),
                // Big number readout — the hero value for this scenario.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$count',
                        style: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade900,
                        ),
                      ),
                      Text(
                        count == 1 ? 'item in cart' : 'items in cart',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Plus / Minus pair. The minus button is disabled when the
            // integer is already zero to keep it non-negative.
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: count > 0
                        ? () => setState(() => _cartItems.value--)
                        : null,
                    icon: const Icon(Icons.remove),
                    label: const Text('Minus'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() => _cartItems.value++),
                    icon: const Icon(Icons.add),
                    label: const Text('Plus'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Four quick-add buttons. These write the new number directly,
            // demonstrating that you can mutate the value however you want —
            // it will still round-trip through the bucket on the next save.
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _cartQuickChip('+1', Colors.red.shade400,
                    () => _cartItems.value += 1),
                _cartQuickChip('+5', Colors.red.shade500,
                    () => _cartItems.value += 5),
                _cartQuickChip('+10', Colors.red.shade600,
                    () => _cartItems.value += 10),
                _cartQuickChip('Clear', Colors.grey.shade700,
                    () => _cartItems.value = 0),
              ],
            ),
            const SizedBox(height: 16),
            // Product preview. If the cart is empty we show a friendly
            // placeholder; otherwise we draw up to 12 little gradient tiles
            // and a "+N more" pill for anything beyond that.
            if (count == 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.grey.shade300, style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    Icon(Icons.remove_shopping_cart,
                        color: Colors.grey.shade400, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      'Your cart is empty',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
            else
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (int i = 0; i < visibleTiles; i++)
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: productGradients[i % productGradients.length],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (overflow > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text(
                        '+$overflow more',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _cartQuickChip(String label, Color color, VoidCallback onTap) {
    return ActionChip(
      label: Text(label),
      backgroundColor: color.withValues(alpha: 0.15),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
      side: BorderSide(color: color),
      onPressed: () => setState(onTap),
    );
  }

  // --------------------------------------------------------------------
  // Scenario 2 — Multi-step wizard progress
  //
  // A classic 0..4 index where the integer has enum-like semantics. The
  // UI is a horizontal step bar plus a content card that switches on the
  // value. This is a perfect fit for `RestorableInt`: the step is always
  // set, and it survives rotation / process death so the user does not
  // have to redo filled-in steps.
  // --------------------------------------------------------------------
  Widget _buildWizardSection() {
    final int step = _wizardStep.value;
    const int stepCount = 5;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress bar: five circles connected by lines. Completed steps
          // are green with a check, the current one is blue and enlarged,
          // and anything ahead is greyed out.
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                for (int i = 0; i < stepCount; i++) ...[
                  _buildWizardDot(i, step),
                  if (i < stepCount - 1)
                    Expanded(
                      child: Container(
                        height: 3,
                        color: i < step
                            ? Colors.green.shade400
                            : Colors.grey.shade300,
                      ),
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Content card that switches on the integer. A `switch` on a
          // bounded integer like this is a very common pattern in wizards.
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: _buildWizardStepContent(step),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: step > 0
                      ? () => setState(() => _wizardStep.value--)
                      : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: step < stepCount - 1
                      ? () => setState(() => _wizardStep.value++)
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWizardDot(int index, int currentStep) {
    final bool isComplete = index < currentStep;
    final bool isCurrent = index == currentStep;

    Color fill;
    Color border;
    Widget? child;
    double size = 32;

    if (isComplete) {
      fill = Colors.green.shade400;
      border = Colors.green.shade600;
      child = const Icon(Icons.check, color: Colors.white, size: 18);
    } else if (isCurrent) {
      fill = Colors.blue.shade500;
      border = Colors.blue.shade800;
      size = 40;
      child = Text(
        '${index + 1}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      fill = Colors.grey.shade200;
      border = Colors.grey.shade400;
      child = Text(
        '${index + 1}',
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: fill,
        shape: BoxShape.circle,
        border: Border.all(color: border, width: 2),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.4),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _buildWizardStepContent(int step) {
    switch (step) {
      case 0:
        return _wizardCardContent(
          icon: Icons.waving_hand,
          iconColor: Colors.orange,
          title: 'Welcome',
          subtitle: "Let's get started",
          body: 'This wizard shows how `RestorableInt` keeps your progress '
              'even if the process is killed and restored.',
        );
      case 1:
        return _wizardCardContent(
          icon: Icons.keyboard,
          iconColor: Colors.indigo,
          title: 'Enter your name',
          subtitle: 'Step 2 of 5',
          body: 'Imagine a text field here. The wizard step index is stored '
              'as a plain int in the restoration bucket.',
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.layers, color: Colors.teal),
                SizedBox(width: 8),
                Text('Choose a plan',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _planCard('Free', Colors.grey),
                const SizedBox(width: 8),
                _planCard('Pro', Colors.blue),
                const SizedBox(width: 8),
                _planCard('Team', Colors.purple),
              ],
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.credit_card, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text('Payment details',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade800, Colors.indigo.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('RESTORABLE BANK',
                          style: TextStyle(
                              color: Colors.white70,
                              letterSpacing: 2)),
                      Icon(Icons.contactless, color: Colors.white70),
                    ],
                  ),
                  Text('**** **** **** 4242',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('CARDHOLDER',
                          style: TextStyle(color: Colors.white70)),
                      Text('12/29', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      case 4:
        return _wizardCardContent(
          icon: Icons.celebration,
          iconColor: Colors.pink,
          title: 'All done!',
          subtitle: 'Thanks for walking through',
          body: "Your wizard step survived the entire flow — and it would "
              'survive a restart too thanks to `RestorableInt`.',
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _wizardCardContent({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String body,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: iconColor.withValues(alpha: 0.15),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(height: 8),
              Text(body),
            ],
          ),
        ),
      ],
    );
  }

  Widget _planCard(String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------
  // Scenario 3 — Image carousel selected index
  //
  // A bounded index into a fixed list of six themed items. The left and
  // right arrows wrap with modulo arithmetic, which is a nice fit for a
  // `RestorableInt` because the value never needs to be null.
  // --------------------------------------------------------------------
  Widget _buildCarouselSection() {
    const int count = 6;
    final int index = _carouselIndex.value.abs() % count;

    const themes = <_CarouselTheme>[
      _CarouselTheme(Colors.red, Icons.local_fire_department, 'Blaze'),
      _CarouselTheme(Colors.blue, Icons.water_drop, 'Tide'),
      _CarouselTheme(Colors.green, Icons.eco, 'Forest'),
      _CarouselTheme(Colors.amber, Icons.wb_sunny, 'Sunrise'),
      _CarouselTheme(Colors.purple, Icons.auto_awesome, 'Nebula'),
      _CarouselTheme(Colors.teal, Icons.waves, 'Lagoon'),
    ];

    final theme = themes[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Big hero preview with a gradient keyed off the current index.
          Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.color.shade200,
                  theme.color.shade600,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: theme.color.withValues(alpha: 0.3),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(theme.icon, size: 72, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  theme.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Row of six thumbnails. The currently-selected one has a thick
          // border and a "selected" chip.
          SizedBox(
            height: 76,
            child: Row(
              children: [
                for (int i = 0; i < count; i++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _carouselIndex.value = i),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Container(
                          decoration: BoxDecoration(
                            color: themes[i].color.shade300.withValues(
                                alpha: i == index ? 1.0 : 0.4),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: i == index
                                  ? themes[i].color.shade900
                                  : Colors.transparent,
                              width: i == index ? 3 : 0,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(themes[i].icon,
                                  color: Colors.white, size: 28),
                              if (i == index)
                                Positioned(
                                  top: -10,
                                  right: -6,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: themes[i].color.shade900,
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      '●',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Left / Right navigation with wrap-around. Because the integer
          // is non-null, we never have to guard against a missing value.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton.filled(
                onPressed: () => setState(() =>
                    _carouselIndex.value = (index - 1 + count) % count),
                icon: const Icon(Icons.chevron_left),
                iconSize: 32,
              ),
              // Page-indicator dots.
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < count; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == index ? 14 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == index
                            ? themes[i].color.shade700
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                ],
              ),
              IconButton.filled(
                onPressed: () => setState(
                    () => _carouselIndex.value = (index + 1) % count),
                icon: const Icon(Icons.chevron_right),
                iconSize: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------
  // Scenario 4 — Custom +/- 5 counter
  //
  // A signed counter with wide strides. The interesting bit is the visual
  // "halo" whose size tracks `|value|`, plus a 10-bead abacus that maps
  // `value % 10` to a strip of lit beads. This scenario really shows off
  // how an integer can drive live visual rendering.
  // --------------------------------------------------------------------
  Widget _buildCounterSection() {
    final int value = _customCounter.value;
    // Halo size grows with magnitude but caps out so we don't explode.
    final double haloSize =
        100 + (value.abs().clamp(0, 200) * 0.5).toDouble();

    Color haloColor;
    if (value > 0) {
      haloColor = Colors.green;
    } else if (value < 0) {
      haloColor = Colors.red;
    } else {
      haloColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Big number with halo. The halo is a fading outer ring scaled by
          // the absolute value of the integer.
          SizedBox(
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: haloSize + 40,
                  height: haloSize + 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: haloColor.withValues(alpha: 0.08),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: haloSize,
                  height: haloSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: haloColor.withValues(alpha: 0.18),
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange.shade50,
                    border: Border.all(
                        color: Colors.orange.shade400, width: 3),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$value',
                    style: TextStyle(
                      fontSize: value.abs() > 999 ? 24 : 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Sign indicator pill.
          _signPill(value),
          const SizedBox(height: 16),
          // 2x3 grid of signed-stride buttons. Note how a `RestorableInt`
          // makes the arithmetic feel like plain local state — the mixin
          // will call `notifyListeners` under the hood on assignment.
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2.2,
            children: [
              _counterButton('-10', Colors.red.shade700,
                  () => _customCounter.value -= 10),
              _counterButton('-5', Colors.red.shade500,
                  () => _customCounter.value -= 5),
              _counterButton('-1', Colors.red.shade300,
                  () => _customCounter.value -= 1),
              _counterButton('+1', Colors.green.shade300,
                  () => _customCounter.value += 1),
              _counterButton('+5', Colors.green.shade500,
                  () => _customCounter.value += 5),
              _counterButton('+10', Colors.green.shade700,
                  () => _customCounter.value += 10),
            ],
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () => setState(() => _customCounter.value = 0),
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reset to 0'),
          ),
          const SizedBox(height: 12),
          // Abacus strip: 10 beads, first N lit up based on `value % 10`.
          _buildAbacus(value),
        ],
      ),
    );
  }

  Widget _counterButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: () => setState(onPressed),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label,
          style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _signPill(int value) {
    IconData icon;
    Color color;
    String label;
    if (value > 0) {
      icon = Icons.arrow_upward;
      color = Colors.green.shade600;
      label = 'positive';
    } else if (value < 0) {
      icon = Icons.arrow_downward;
      color = Colors.red.shade600;
      label = 'negative';
    } else {
      icon = Icons.remove;
      color = Colors.grey.shade600;
      label = 'zero';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAbacus(int value) {
    // How many "lit" beads do we have for the current value? We use the
    // absolute value so negative numbers also light up something.
    final int lit = value.abs() % 10;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 10; i++) ...[
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < lit
                    ? Colors.orange.shade600
                    : Colors.grey.shade300,
                boxShadow: i < lit
                    ? [
                        BoxShadow(
                          color: Colors.orange.withValues(alpha: 0.4),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
            ),
            if (i < 9) const SizedBox(width: 4),
          ],
        ],
      ),
    );
  }

  // --------------------------------------------------------------------
  // Scenario 5 — Leaderboard ordinal rank
  //
  // Finally, a scenario that turns a plain int into an *ordinal* display.
  // The helper `_ordinal` converts 1 -> "1st", 2 -> "2nd", 21 -> "21st",
  // and so on. Medal icons appear for ranks 1-3, a ribbon for 4-10 and a
  // simple chip for 11 and above. This is a nice reminder that the value
  // stored in `RestorableInt` is just a number — the interesting part is
  // what your widget does with it.
  // --------------------------------------------------------------------
  String _ordinal(int n) {
    if (n >= 11 && n <= 13) return '${n}th';
    switch (n % 10) {
      case 1:
        return '${n}st';
      case 2:
        return '${n}nd';
      case 3:
        return '${n}rd';
      default:
        return '${n}th';
    }
  }

  Widget _buildLeaderboardSection() {
    final int rank = _rank.value;

    // Pick backdrop colours and badge widget based on the rank tier.
    final List<Color> gradient;
    final Widget medal;
    if (rank == 1) {
      gradient = [Colors.amber.shade300, Colors.orange.shade700];
      medal = _medal(Icons.emoji_events, Colors.amber.shade700, 'Gold');
    } else if (rank == 2) {
      gradient = [Colors.grey.shade300, Colors.blueGrey.shade500];
      medal = _medal(Icons.emoji_events, Colors.grey.shade600, 'Silver');
    } else if (rank == 3) {
      gradient = [
        const Color(0xFFD7A16A),
        const Color(0xFF8B5A2B),
      ];
      medal = _medal(Icons.emoji_events, const Color(0xFF8B5A2B), 'Bronze');
    } else if (rank >= 4 && rank <= 10) {
      gradient = [Colors.blue.shade200, Colors.indigo.shade500];
      medal = _medal(Icons.military_tech, Colors.indigo.shade700, 'Ribbon');
    } else {
      gradient = [Colors.grey.shade200, Colors.grey.shade500];
      medal = _medal(Icons.label, Colors.grey.shade700, 'Chip');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: gradient.last.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Row(
              children: [
                medal,
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _ordinal(rank),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black45,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'place',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.6)),
                  ),
                  child: Text(
                    '#$rank',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Five buttons to quickly demonstrate the ordinal branches. The
          // integers below were chosen to exercise every branch in
          // `_ordinal`: 1st, 3rd, 11th (teens edge-case), 21st, 42nd.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _rankSetButton(1),
              _rankSetButton(3),
              _rankSetButton(11),
              _rankSetButton(21),
              _rankSetButton(42),
            ],
          ),
          const SizedBox(height: 12),
          // Fine control: step by one in either direction. Ranks are
          // clamped to a sensible range so we stay on-screen.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.outlined(
                onPressed: rank > 1
                    ? () => setState(() => _rank.value--)
                    : null,
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 16),
              Text(_ordinal(rank),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(width: 16),
              IconButton.outlined(
                onPressed: rank < 999
                    ? () => setState(() => _rank.value++)
                    : null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _medal(IconData icon, Color color, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: color, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 40, color: color),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _rankSetButton(int value) {
    return ElevatedButton(
      onPressed: () => setState(() => _rank.value = value),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber.shade100,
        foregroundColor: Colors.amber.shade900,
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      child: Text('Set to $value',
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  // --------------------------------------------------------------------
  // Teaching footer
  //
  // A compact summary of the contract of `RestorableInt`, plus the list
  // of concrete use-cases demonstrated above. Keep this near the bottom
  // of the scroll so a reader can glance back at it after exploring the
  // scenarios.
  // --------------------------------------------------------------------
  Widget _buildTeachingFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.shade200),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.school, color: Colors.green.shade700),
                const SizedBox(width: 8),
                const Text(
                  'About RestorableInt',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _bullet('Non-null: always has a value — no null-checks needed.'),
            _bullet('Serialised as a plain int in the restoration bucket.'),
            _bullet('Registered on a RestorationMixin with a unique id.'),
            _bullet('Reads and writes go through `.value` like any '
                'ValueListenable.'),
            const SizedBox(height: 8),
            Text(
              'Concrete use-cases in this demo:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
            const SizedBox(height: 4),
            _bullet('Cart badge count — pure magnitude.'),
            _bullet('Wizard step — bounded enum-like int.'),
            _bullet('Carousel index — bounded with wrap-around.'),
            _bullet('Custom counter — signed arithmetic with wide strides.'),
            _bullet('Leaderboard rank — integer with ordinal interpretation.'),
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// Small immutable descriptor used by the carousel scenario. Kept outside the
// state class so it can live as a top-level `const`.
class _CarouselTheme {
  const _CarouselTheme(this.color, this.icon, this.name);
  final MaterialColor color;
  final IconData icon;
  final String name;
}
