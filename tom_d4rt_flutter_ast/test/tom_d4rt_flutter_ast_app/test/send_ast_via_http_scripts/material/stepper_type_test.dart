// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: Material `StepperType` enum.
//
// StepperType is a tiny enum, but it controls a very visible widget:
// the Material `Stepper`. Its two values, `vertical` and `horizontal`,
// switch the layout of an entire wizard. This file is a hand-authored
// catalogue entry that explains the trade-offs, draws mock screenshots,
// renders real Stepper widgets in both modes, and walks through the
// related `StepState` enum that decorates every step circle.
//
// The harness only paints a single frame, so any callbacks hand to a
// real Stepper are no-ops. `currentStep` is fixed; tapping is not
// expected. This keeps the demo fully declarative.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StepperType deep demo: starting build');
  print('StepperType has ${StepperType.values.length} values');
  for (final t in StepperType.values) {
    print('  - StepperType.${t.name} (index ${t.index})');
  }

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');

  final hero = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.purple.shade500,
          Colors.pink.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.shade900.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: const Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.pink.shade200.withValues(alpha: 0.25),
          blurRadius: 30.0,
          offset: const Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(
                Icons.linear_scale,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'StepperType',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'Material wizard layout: vertical vs horizontal',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'enum StepperType { vertical, horizontal }',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Colors.amberAccent,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of a Step
  // ============================================================
  print('=== Section 2: Anatomy of a Step ===');

  Widget anatomyRow(String field, String type, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90.0,
            child: Text(
              field,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(
            width: 120.0,
            child: Text(
              type,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.teal.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }

  final anatomy = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.shade100.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.blue.shade700),
            const SizedBox(width: 8.0),
            Text(
              'Anatomy of a Step',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'Every Step inside a Stepper is a tiny data class. The same '
          'data is rendered very differently depending on StepperType.',
          style: TextStyle(fontSize: 12.0, color: Colors.blue.shade900),
        ),
        const SizedBox(height: 12.0),
        anatomyRow('title', 'Widget', 'Headline of the step.'),
        anatomyRow('subtitle', 'Widget?', 'Optional secondary line.'),
        anatomyRow(
          'content',
          'Widget',
          'Body shown when the step is active.',
        ),
        anatomyRow(
          'state',
          'StepState',
          'Visual decoration of the leading circle.',
        ),
        anatomyRow(
          'isActive',
          'bool',
          'Whether this step is treated as currently in focus.',
        ),
        anatomyRow(
          'label',
          'Widget?',
          'Optional label rendered under horizontal connectors.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards (vertical vs horizontal)
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  Widget verticalMockScreenshot() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < 3; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: i == 1
                            ? Colors.indigo
                            : Colors.indigo.shade200,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (i < 2)
                      Container(
                        width: 2.0,
                        height: 32.0,
                        color: Colors.indigo.shade100,
                      ),
                  ],
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 8.0,
                        width: 80.0,
                        color: Colors.indigo.shade200,
                      ),
                      const SizedBox(height: 4.0),
                      if (i == 1)
                        Container(
                          height: 32.0,
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (i < 2) const SizedBox(height: 4.0),
          ],
        ],
      ),
    );
  }

  Widget horizontalMockScreenshot() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.deepOrange.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              for (int i = 0; i < 3; i++) ...[
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: i == 1
                        ? Colors.deepOrange
                        : Colors.deepOrange.shade200,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (i < 2)
                  Expanded(
                    child: Container(
                      height: 2.0,
                      color: Colors.deepOrange.shade100,
                      margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    ),
                  ),
              ],
            ],
          ),
          const SizedBox(height: 12.0),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade50,
              borderRadius: BorderRadius.circular(6.0),
            ),
            alignment: Alignment.center,
            child: Text(
              'Active step body',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget valueCard({
    required String name,
    required String tagline,
    required IconData icon,
    required Color color,
    required String whenToUse,
    required String tradeOff,
    required Widget mock,
  }) {
    return Container(
      width: 320.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 14.0,
            offset: const Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(icon, color: color, size: 28.0),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'StepperType.$name',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      tagline,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            'Mock screenshot',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 6.0),
          mock,
          const SizedBox(height: 14.0),
          Text(
            'When to use',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(whenToUse, style: const TextStyle(fontSize: 12.0)),
          const SizedBox(height: 10.0),
          Text(
            'Real-estate trade-off',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(tradeOff, style: const TextStyle(fontSize: 12.0)),
        ],
      ),
    );
  }

  final perValueCards = Wrap(
    alignment: WrapAlignment.center,
    children: [
      valueCard(
        name: 'vertical',
        tagline: 'Steps stack top-to-bottom; only the active body expands.',
        icon: Icons.swap_vert,
        color: Colors.indigo,
        whenToUse:
            'Long forms, small viewports (phones), wizards where every '
            'step needs significant vertical space for inputs or copy.',
        tradeOff:
            'Wins width; uses lots of height. Excellent on phones, '
            'awkward on wide desktops where horizontal space is wasted.',
        mock: verticalMockScreenshot(),
      ),
      valueCard(
        name: 'horizontal',
        tagline: 'Steps line up left-to-right; body sits below the rail.',
        icon: Icons.swap_horiz,
        color: Colors.deepOrange,
        whenToUse:
            'Short, scannable wizards: checkout, onboarding, dashboards. '
            'Best when each step is one screen of content.',
        tradeOff:
            'Eats horizontal space. Number of steps must be small (3-5) '
            'or labels overflow; not friendly on narrow screens.',
        mock: horizontalMockScreenshot(),
      ),
    ],
  );

  // ============================================================
  // SECTION 4: Real Stepper, vertical
  // ============================================================
  print('=== Section 4: Real vertical Stepper ===');

  // Shared 4-step demo content. Used for both real Steppers.
  final demoSteps = <Step>[
    Step(
      title: const Text('Account'),
      subtitle: const Text('Email and password'),
      state: StepState.complete,
      isActive: false,
      content: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check, size: 16.0, color: Colors.green.shade800),
                const SizedBox(width: 6.0),
                Text(
                  'jane@example.com',
                  style: TextStyle(color: Colors.green.shade900),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              'Password set, 2FA enabled.',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
    ),
    Step(
      title: const Text('Personal'),
      subtitle: const Text('Name, address, phone'),
      state: StepState.editing,
      isActive: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Full name'),
          SizedBox(height: 4.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              hintText: 'Jane Doe',
            ),
          ),
          SizedBox(height: 8.0),
          Text('Phone'),
          SizedBox(height: 4.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              hintText: '+1 555 0100',
            ),
          ),
        ],
      ),
    ),
    Step(
      title: const Text('Review'),
      subtitle: const Text('Confirm details'),
      state: StepState.indexed,
      isActive: false,
      content: const Text(
        'A summary of the previous steps will appear here so the '
        'user can confirm before submission.',
      ),
    ),
    Step(
      title: const Text('Done'),
      subtitle: const Text('Welcome aboard'),
      state: StepState.indexed,
      isActive: false,
      content: const Text('Account is ready. The wizard closes here.'),
    ),
  ];

  // Constant no-op callbacks. Harness paints one frame; no taps occur.
  void noopOnTap(int _) {}
  void noopOnContinue() {}
  void noopOnCancel() {}

  final verticalStepper = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.shade100.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: SizedBox(
        // Bound the height so the inner ListView can lay out.
        height: 620.0,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: 1,
          onStepTapped: noopOnTap,
          onStepContinue: noopOnContinue,
          onStepCancel: noopOnCancel,
          steps: demoSteps,
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 5: Real Stepper, horizontal
  // ============================================================
  print('=== Section 5: Real horizontal Stepper ===');

  final horizontalStepper = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepOrange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.shade100.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: SizedBox(
        height: 360.0,
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: 1,
          onStepTapped: noopOnTap,
          onStepContinue: noopOnContinue,
          onStepCancel: noopOnCancel,
          steps: demoSteps,
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 6: StepState walkthrough
  // ============================================================
  print('=== Section 6: StepState walkthrough ===');

  Widget miniStepCircle(StepState state) {
    Color color;
    IconData? icon;
    String fallback = '1';
    switch (state) {
      case StepState.indexed:
        color = Colors.blueGrey;
        fallback = '1';
        break;
      case StepState.editing:
        color = Colors.blue;
        icon = Icons.edit;
        break;
      case StepState.complete:
        color = Colors.green;
        icon = Icons.check;
        break;
      case StepState.disabled:
        color = Colors.grey;
        fallback = '1';
        break;
      case StepState.error:
        color = Colors.red;
        icon = Icons.priority_high;
        break;
    }
    final isDisabled = state == StepState.disabled;
    return Container(
      width: 88.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: isDisabled ? Colors.grey.shade300 : color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 6.0,
                  offset: const Offset(0.0, 3.0),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: icon != null
                ? Icon(icon, color: Colors.white, size: 18.0)
                : Text(
                    fallback,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          const SizedBox(height: 8.0),
          Text(
            state.name,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  final stateWalkthrough = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.green.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.radio_button_checked, color: Colors.teal.shade700),
            const SizedBox(width: 8.0),
            Text(
              'StepState walkthrough',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'StepState decorates the leading circle of each Step. The '
          'StepperType controls layout; StepState controls colour and '
          'icon. They compose freely.',
          style: TextStyle(fontSize: 12.0, color: Colors.teal.shade900),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            for (final s in StepState.values) miniStepCircle(s),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Recipes (use cases)
  // ============================================================
  print('=== Section 7: Recipes ===');

  Widget recipeCard({
    required String title,
    required String suggestedType,
    required Color color,
    required IconData icon,
    required List<String> bullets,
  }) {
    return Container(
      width: 280.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.14),
            color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'Suggested: StepperType.$suggestedType',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          for (final b in bullets)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyle(color: color)),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  final recipes = Wrap(
    alignment: WrapAlignment.center,
    children: [
      recipeCard(
        title: 'Sign-up wizard',
        suggestedType: 'vertical',
        color: Colors.indigo,
        icon: Icons.person_add,
        bullets: [
          'Many fields per step.',
          'Mobile-first audience.',
          'Validation messages need room to render.',
        ],
      ),
      recipeCard(
        title: 'Checkout flow',
        suggestedType: 'horizontal',
        color: Colors.deepOrange,
        icon: Icons.shopping_cart_checkout,
        bullets: [
          'Few high-level phases (cart, ship, pay).',
          'Wide layout, often desktop.',
          'Progress should feel scannable at a glance.',
        ],
      ),
      recipeCard(
        title: 'Onboarding',
        suggestedType: 'horizontal',
        color: Colors.purple,
        icon: Icons.celebration,
        bullets: [
          'Short, motivating sequence.',
          'Each step is mostly visual or copy.',
          'Horizontal rail invites forward motion.',
        ],
      ),
    ],
  );

  // ============================================================
  // SECTION 8: Pitfalls
  // ============================================================
  print('=== Section 8: Pitfalls ===');

  Widget pitfall(String title, String body, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(body, style: const TextStyle(fontSize: 12.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final pitfalls = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.red.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange.shade800),
            const SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        pitfall(
          'Unbounded height',
          'Stepper internally uses a ListView. Place it inside a '
              'SizedBox with a fixed height, or an Expanded inside a '
              'Column, or it will throw a layout error.',
          Icons.height,
          Colors.red,
        ),
        pitfall(
          'Surprising scroll behaviour',
          'StepperType.vertical scrolls the whole rail; horizontal '
              'scrolls only the body. Pick the type that matches '
              'how much content each step holds.',
          Icons.swap_vert,
          Colors.deepOrange,
        ),
        pitfall(
          'Accessibility',
          'Step circles should not be the only progress signal. '
              'Provide subtitle text and StepState.error for failures '
              'so screen readers announce status, not just colour.',
          Icons.accessibility_new,
          Colors.indigo,
        ),
        pitfall(
          'Too many horizontal steps',
          'StepperType.horizontal renders labels under tiny circles. '
              'Beyond ~5 steps the rail crowds; switch to vertical '
              'or split the wizard.',
          Icons.format_list_numbered,
          Colors.purple,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footer
  // ============================================================
  print('=== Section 9: Footer ===');

  const filePath =
      'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/'
      'send_ast_via_http_scripts/material/stepper_type_test.dart';

  final footer = Container(
    margin: const EdgeInsets.only(top: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.insert_drive_file, color: Colors.cyan.shade300),
            const SizedBox(width: 8.0),
            Text(
              'File',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          filePath,
          style: TextStyle(
            color: Colors.amberAccent,
            fontFamily: 'monospace',
            fontSize: 11.0,
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          '+----------------------------------------------------+\n'
          '|  StepperType :: vertical | horizontal              |\n'
          '|  Layout switch for Material Stepper widget.        |\n'
          '|  Pair with StepState for per-step decoration.      |\n'
          '+----------------------------------------------------+',
          style: TextStyle(
            color: Colors.greenAccent,
            fontFamily: 'monospace',
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );

  print('StepperType deep demo: build complete');

  // ============================================================
  // Final layout
  // ============================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        const SizedBox(height: 24.0),
        const Text(
          '1. Anatomy of a Step',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        anatomy,
        const SizedBox(height: 24.0),
        const Text(
          '2. The two values',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        perValueCards,
        const SizedBox(height: 24.0),
        const Text(
          '3. Real Stepper - vertical',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        verticalStepper,
        const SizedBox(height: 24.0),
        const Text(
          '4. Real Stepper - horizontal',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        horizontalStepper,
        const SizedBox(height: 24.0),
        const Text(
          '5. StepState walkthrough',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        stateWalkthrough,
        const SizedBox(height: 24.0),
        const Text(
          '6. Recipes',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        recipes,
        const SizedBox(height: 24.0),
        const Text(
          '7. Pitfalls',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        pitfalls,
        const SizedBox(height: 24.0),
        const Text(
          '8. File reference',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        footer,
      ],
    ),
  );
}
