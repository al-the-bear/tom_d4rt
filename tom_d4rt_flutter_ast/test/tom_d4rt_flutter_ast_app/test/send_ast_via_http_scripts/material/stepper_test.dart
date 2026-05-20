// D4rt test script: Deep Demo - Stepper, Step, StepState, StepperType
// Comprehensive visual demonstration of the Material Stepper widget family.
// Covers vertical/horizontal layouts, every StepState variant, custom
// controlsBuilder, stepIconBuilder, connectorColor/thickness, icon sizing,
// margins, elevation, physics, and a narrative checkout flow.
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  // ===========================================================================
  // SHARED DESIGN TOKENS
  // ===========================================================================

  final Color tokenInk = const Color(0xFF1A1C2E);
  final Color tokenInkSoft = const Color(0xFF4A4E69);
  final Color tokenAccent = const Color(0xFF6750A4);
  final Color tokenAccentSoft = const Color(0xFFEADDFF);
  final Color tokenSuccess = const Color(0xFF1B873F);
  final Color tokenSuccessSoft = const Color(0xFFD7F5DC);
  final Color tokenWarn = const Color(0xFFB36100);
  final Color tokenWarnSoft = const Color(0xFFFFE6C2);
  final Color tokenDanger = const Color(0xFFB3261E);
  final Color tokenDangerSoft = const Color(0xFFFADBD8);
  final Color tokenSurface = const Color(0xFFFAFAFC);
  final Color tokenSurfaceAlt = const Color(0xFFEDE9F4);
  final Color tokenOutline = const Color(0xFFD9D5E3);

  // ===========================================================================
  // SECTION HEADER BUILDER (manually composed widget factory)
  // ===========================================================================

  Widget buildSectionHeader({
    required int number,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 4.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.92),
            color.withValues(alpha: 0.62),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 18.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56.0,
            height: 56.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.5),
                width: 1.4,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 30.0),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'SECTION ${number.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 11.0,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNarrative(String text, {Color? color}) {
    return Container(
      margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 10.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: (color ?? tokenSurfaceAlt).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(
          left: BorderSide(color: tokenAccent, width: 4.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: tokenInk,
          fontSize: 13.0,
          height: 1.5,
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 14.0, bottom: 6.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 6.0,
            height: 18.0,
            decoration: BoxDecoration(
              color: tokenAccent,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
              color: tokenInk,
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStepperFrame({
    required Widget child,
    required double height,
    Color? accent,
  }) {
    final Color frameAccent = accent ?? tokenAccent;
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: tokenOutline, width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: frameAccent.withValues(alpha: 0.10),
            blurRadius: 14.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: child,
      ),
    );
  }

  Widget buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 1 - INTRO BANNER
  // ===========================================================================

  final Widget heroBanner = Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          const Color(0xFF231942),
          const Color(0xFF5E548E),
          const Color(0xFFBE95C4),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 22.0,
          offset: const Offset(0, 12),
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
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(
                Icons.timeline,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Material Stepper — Deep Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Step, StepState, StepperType, controls and connectors — '
                    'all interpreted through D4rt at runtime.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            buildBadge('Stepper', Colors.white),
            buildBadge('Step', Colors.white),
            buildBadge('StepState', Colors.white),
            buildBadge('StepperType', Colors.white),
            buildBadge('ControlsDetails', Colors.white),
            buildBadge('stepIconBuilder', Colors.white),
            buildBadge('connectorColor', Colors.white),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2 - STEPSTATE CATALOG (visual chips)
  // ===========================================================================

  final List<Map<String, dynamic>> stateCatalog = <Map<String, dynamic>>[
    <String, dynamic>{
      'state': StepState.indexed,
      'name': 'indexed',
      'icon': Icons.format_list_numbered,
      'color': tokenAccent,
      'soft': tokenAccentSoft,
      'blurb':
          'Default representation: shows the 1-based step index inside a '
          'circle. The standard look for a freshly initialised wizard.',
    },
    <String, dynamic>{
      'state': StepState.editing,
      'name': 'editing',
      'icon': Icons.edit_note,
      'color': const Color(0xFF1976D2),
      'soft': const Color(0xFFD9EBFF),
      'blurb':
          'The step the user is currently filling in. Stepper renders a pencil '
          'glyph to invite further input.',
    },
    <String, dynamic>{
      'state': StepState.complete,
      'name': 'complete',
      'icon': Icons.check_circle,
      'color': tokenSuccess,
      'soft': tokenSuccessSoft,
      'blurb':
          'A checkmark replaces the index when the step has been finished '
          'successfully and validated.',
    },
    <String, dynamic>{
      'state': StepState.disabled,
      'name': 'disabled',
      'icon': Icons.do_disturb_alt,
      'color': const Color(0xFF757575),
      'soft': const Color(0xFFEFEFEF),
      'blurb':
          'Reachable only after preconditions are met. Tapping is ignored, '
          'and the colour is muted to convey unavailability.',
    },
    <String, dynamic>{
      'state': StepState.error,
      'name': 'error',
      'icon': Icons.error,
      'color': tokenDanger,
      'soft': tokenDangerSoft,
      'blurb':
          'Validation failure on this step — the icon turns into an "!" and '
          'the connector before it picks up the error colour.',
    },
  ];

  final List<Widget> stateChips = List<Widget>.generate(stateCatalog.length, (
    int i,
  ) {
    final Map<String, dynamic> spec = stateCatalog[i];
    final Color color = spec['color'] as Color;
    final Color soft = spec['soft'] as Color;
    final String name = spec['name'] as String;
    final IconData icon = spec['icon'] as IconData;
    final String blurb = spec['blurb'] as String;
    return Container(
      width: 220.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: soft.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 8.0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 20.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'StepState.$name',
                  style: TextStyle(
                    color: color,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            blurb,
            style: TextStyle(
              color: tokenInk,
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  });

  // ===========================================================================
  // SECTION 3 - BASIC VERTICAL STEPPER
  // ===========================================================================

  final List<Step> verticalIntroSteps = <Step>[
    Step(
      title: const Text('Discover'),
      subtitle: const Text('Browse curated collections'),
      content: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: tokenAccentSoft.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Text(
          'Glance through the catalogue, save favourites and compare options. '
          'Nothing is committed until later.',
        ),
      ),
      state: StepState.complete,
      isActive: true,
    ),
    Step(
      title: const Text('Configure'),
      subtitle: const Text('Tune the experience'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Choose a plan that fits the team size.'),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: tokenAccent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'Pro',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: tokenSurfaceAlt,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text('Team'),
              ),
            ],
          ),
        ],
      ),
      state: StepState.editing,
      isActive: true,
    ),
    Step(
      title: const Text('Activate'),
      subtitle: const Text('Press the big green button'),
      content: const Text(
        'Once activated, your workspace will spin up and we will email a '
        'welcome guide to the primary contact.',
      ),
      state: StepState.indexed,
      isActive: false,
    ),
  ];

  final Stepper section3Stepper = Stepper(
    currentStep: 1,
    steps: verticalIntroSteps,
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  // ===========================================================================
  // SECTION 4 - HORIZONTAL STEPPER GALLERY
  // ===========================================================================

  final List<Step> horizontalDeliverySteps = <Step>[
    Step(
      title: const Text('Cart'),
      content: Container(
        height: 80.0,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.shopping_cart, size: 32.0),
            SizedBox(width: 10.0),
            Text('3 items, total \$148.00'),
          ],
        ),
      ),
      state: StepState.complete,
      isActive: true,
    ),
    Step(
      title: const Text('Shipping'),
      content: Container(
        height: 80.0,
        alignment: Alignment.center,
        child: const Text('221B Baker Street, London'),
      ),
      state: StepState.complete,
      isActive: true,
    ),
    Step(
      title: const Text('Payment'),
      content: Container(
        height: 80.0,
        alignment: Alignment.center,
        child: const Text('VISA •••• 4242'),
      ),
      state: StepState.editing,
      isActive: true,
    ),
    Step(
      title: const Text('Done'),
      content: Container(
        height: 80.0,
        alignment: Alignment.center,
        child: const Text('Awaiting confirmation'),
      ),
      state: StepState.indexed,
      isActive: false,
    ),
  ];

  final Stepper section4HorizontalA = Stepper(
    type: StepperType.horizontal,
    currentStep: 2,
    steps: horizontalDeliverySteps,
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  final Stepper section4HorizontalB = Stepper(
    type: StepperType.horizontal,
    currentStep: 0,
    steps: <Step>[
      Step(
        title: const Text('Draft'),
        content: const Text('Sketch the initial outline of the document.'),
        state: StepState.editing,
        isActive: true,
      ),
      Step(
        title: const Text('Review'),
        content: const Text('Internal review by editorial team.'),
        state: StepState.indexed,
        isActive: false,
      ),
      Step(
        title: const Text('Publish'),
        content: const Text('Go live and announce to subscribers.'),
        state: StepState.indexed,
        isActive: false,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  final Stepper section4HorizontalC = Stepper(
    type: StepperType.horizontal,
    currentStep: 3,
    steps: <Step>[
      Step(
        title: const Text('Apply'),
        content: const Text('Application submitted.'),
        state: StepState.complete,
        isActive: true,
      ),
      Step(
        title: const Text('Screen'),
        content: const Text('Phone screen completed.'),
        state: StepState.complete,
        isActive: true,
      ),
      Step(
        title: const Text('Interview'),
        content: const Text('Onsite scheduled for Friday.'),
        state: StepState.complete,
        isActive: true,
      ),
      Step(
        title: const Text('Offer'),
        content: const Text('Pending hiring manager decision.'),
        state: StepState.editing,
        isActive: true,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  // ===========================================================================
  // SECTION 5 - STEP STATE LIVE STEPPER
  // ===========================================================================

  final List<Step> liveStateSteps = List<Step>.generate(stateCatalog.length, (
    int i,
  ) {
    final Map<String, dynamic> spec = stateCatalog[i];
    final StepState state = spec['state'] as StepState;
    final String name = spec['name'] as String;
    final IconData icon = spec['icon'] as IconData;
    final Color color = spec['color'] as Color;
    final Color soft = spec['soft'] as Color;
    final String blurb = spec['blurb'] as String;
    return Step(
      title: Text(
        'StepState.$name',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text('Rendered in the $name visual state'),
      content: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: soft.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: color.withValues(alpha: 0.4),
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 18.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                blurb,
                style: TextStyle(
                  color: tokenInk,
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
      state: state,
      isActive: state != StepState.disabled,
    );
  });

  final Stepper section5StatesStepper = Stepper(
    currentStep: 2,
    steps: liveStateSteps,
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  // ===========================================================================
  // SECTION 6 - CUSTOM controlsBuilder
  // ===========================================================================

  final List<Step> controlsSteps = <Step>[
    Step(
      title: const Text('Compose'),
      subtitle: const Text('Write the first draft'),
      content: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'Use the workspace to capture your thoughts. The controls below '
          'are fully custom — note the pill-shaped buttons.',
        ),
      ),
      isActive: true,
      state: StepState.editing,
    ),
    Step(
      title: const Text('Refine'),
      subtitle: const Text('Polish prose and structure'),
      content: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'Re-read the draft, tighten the language and add references where '
          'helpful.',
        ),
      ),
      isActive: true,
      state: StepState.indexed,
    ),
    Step(
      title: const Text('Publish'),
      subtitle: const Text('Send the work into the world'),
      content: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'Click "Publish" — the article gets pushed to the CMS and the '
          'newsletter scheduler picks it up.',
        ),
      ),
      isActive: false,
      state: StepState.indexed,
    ),
  ];

  final Stepper section6ControlsStepper = Stepper(
    currentStep: 0,
    steps: controlsSteps,
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
    controlsBuilder: (BuildContext ctx, ControlsDetails details) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[tokenAccent, const Color(0xFF8E7CC3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: tokenAccent.withValues(alpha: 0.35),
                    blurRadius: 10.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextButton.icon(
                onPressed: details.onStepContinue,
                icon: const Icon(Icons.east, color: Colors.white, size: 18.0),
                label: Text(
                  'Continue — step ${details.stepIndex + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            OutlinedButton.icon(
              onPressed: details.onStepCancel,
              icon: const Icon(Icons.west, size: 16.0),
              label: const Text('Back'),
              style: OutlinedButton.styleFrom(
                foregroundColor: tokenInkSoft,
                side: BorderSide(color: tokenOutline, width: 1.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: tokenSurfaceAlt,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'Active: ${details.stepIndex + 1}/${controlsSteps.length}',
                style: TextStyle(
                  color: tokenInk,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  // Alternative controlsBuilder — minimalist icon-only
  final Stepper section6IconControls = Stepper(
    currentStep: 1,
    steps: <Step>[
      Step(
        title: const Text('Mine'),
        content: const Text('Mining raw materials from the asteroid belt.'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Refine'),
        content: const Text('Refining ore into usable alloys.'),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: const Text('Manufacture'),
        content: const Text('Assembling components into finished products.'),
        isActive: false,
        state: StepState.indexed,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
    controlsBuilder: (BuildContext ctx, ControlsDetails details) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: details.onStepCancel,
              icon: const Icon(Icons.arrow_back_ios_new),
              color: tokenInkSoft,
              tooltip: 'Previous',
            ),
            const SizedBox(width: 8.0),
            IconButton(
              onPressed: details.onStepContinue,
              icon: const Icon(Icons.arrow_forward_ios),
              color: tokenAccent,
              tooltip: 'Next',
            ),
          ],
        ),
      );
    },
  );

  // controlsBuilder that returns SizedBox.shrink (no controls)
  final Stepper section6NoControls = Stepper(
    currentStep: 1,
    steps: <Step>[
      Step(
        title: const Text('Auto step A'),
        content: const Text('Driven externally — no user-visible controls.'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Auto step B'),
        content: const Text('Progress dictated by background workers.'),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: const Text('Auto step C'),
        content: const Text('Last automated step before completion.'),
        isActive: false,
        state: StepState.indexed,
      ),
    ],
    onStepTapped: (int _) {},
    controlsBuilder: (BuildContext ctx, ControlsDetails details) {
      return const SizedBox.shrink();
    },
  );

  // ===========================================================================
  // SECTION 7 - stepIconBuilder gallery
  // ===========================================================================

  final List<Step> iconBuilderSteps = <Step>[
    Step(
      title: const Text('Brewing'),
      content: const Text('Hot water passes through the freshly ground beans.'),
      isActive: true,
      state: StepState.complete,
    ),
    Step(
      title: const Text('Steaming'),
      content: const Text('Milk is steamed and microfoam is built.'),
      isActive: true,
      state: StepState.editing,
    ),
    Step(
      title: const Text('Pouring'),
      content: const Text('Final art is poured onto the espresso.'),
      isActive: true,
      state: StepState.indexed,
    ),
    Step(
      title: const Text('Serving'),
      content: const Text('Coffee is presented to the customer.'),
      isActive: false,
      state: StepState.disabled,
    ),
    Step(
      title: const Text('Refunding'),
      content: const Text('Something went wrong — issuing a refund.'),
      isActive: false,
      state: StepState.error,
    ),
  ];

  Widget? barista(int index, StepState state) {
    switch (state) {
      case StepState.complete:
        return const Icon(Icons.local_cafe, color: Colors.white, size: 18.0);
      case StepState.editing:
        return const Icon(Icons.coffee_maker, color: Colors.white, size: 18.0);
      case StepState.error:
        return const Icon(Icons.report, color: Colors.white, size: 18.0);
      case StepState.disabled:
        return const Icon(Icons.lock_outline, color: Colors.white, size: 18.0);
      case StepState.indexed:
        return Text(
          String.fromCharCode(0x2460 + index),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        );
    }
  }

  final Stepper section7IconStepper = Stepper(
    currentStep: 1,
    steps: iconBuilderSteps,
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
    stepIconBuilder: barista,
  );

  // Glyph-based icon builder (uses dart:math.Random for spice)
  final math.Random rng = math.Random(42);
  final List<IconData> glyphPool = <IconData>[
    Icons.star,
    Icons.flash_on,
    Icons.public,
    Icons.eco,
    Icons.water_drop,
  ];

  Widget? glyphIconBuilder(int index, StepState state) {
    if (state == StepState.complete) {
      return const Icon(Icons.verified, color: Colors.white, size: 18.0);
    }
    if (state == StepState.error) {
      return const Icon(Icons.bug_report, color: Colors.white, size: 18.0);
    }
    final IconData glyph = glyphPool[index % glyphPool.length];
    return Icon(glyph, color: Colors.white, size: 18.0);
  }

  // Pre-build glyph titles so the random number generator is exercised once.
  final List<String> glyphSuffixes = List<String>.generate(4, (int i) {
    return rng.nextInt(99).toString().padLeft(2, '0');
  });

  final Stepper section7GlyphStepper = Stepper(
    type: StepperType.horizontal,
    currentStep: 2,
    steps: <Step>[
      Step(
        title: Text('Spark ${glyphSuffixes[0]}'),
        content: const Text('Ignition phase — initial sparks recorded.'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: Text('Surge ${glyphSuffixes[1]}'),
        content: const Text('Power surges through the conduit.'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: Text('Stabilise ${glyphSuffixes[2]}'),
        content: const Text('Energy levels stabilise at the target output.'),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: Text('Sustain ${glyphSuffixes[3]}'),
        content: const Text('Maintain output for the configured window.'),
        isActive: false,
        state: StepState.indexed,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
    stepIconBuilder: glyphIconBuilder,
  );

  // ===========================================================================
  // SECTION 8 - CONNECTOR COLOR / THICKNESS / ICON SIZE
  // ===========================================================================

  final Stepper section8ConnectorStepper = Stepper(
    currentStep: 1,
    connectorColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return tokenAccent;
      }
      if (states.contains(WidgetState.disabled)) {
        return tokenOutline;
      }
      return tokenSuccess;
    }),
    connectorThickness: 4.0,
    stepIconHeight: 44.0,
    stepIconWidth: 44.0,
    stepIconMargin: const EdgeInsets.symmetric(horizontal: 6.0),
    steps: <Step>[
      Step(
        title: const Text('Plan'),
        subtitle: const Text('Sketch the architecture'),
        content: const Text('Whiteboard sessions and ADRs.'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Build'),
        subtitle: const Text('Write the code'),
        content: const Text('Implementation across packages and tests.'),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: const Text('Ship'),
        subtitle: const Text('Release to production'),
        content: const Text('Tagged release with changelog.'),
        isActive: false,
        state: StepState.indexed,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  final Stepper section8ThinStepper = Stepper(
    type: StepperType.horizontal,
    currentStep: 1,
    connectorColor: WidgetStateProperty.all<Color>(const Color(0xFF8E7CC3)),
    connectorThickness: 1.0,
    stepIconHeight: 28.0,
    stepIconWidth: 28.0,
    steps: <Step>[
      Step(
        title: const Text('Tap'),
        content: const Text('User initiates the gesture.'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Hold'),
        content: const Text('Pressure sustained beyond threshold.'),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: const Text('Release'),
        content: const Text('Gesture lifts and event fires.'),
        isActive: false,
        state: StepState.indexed,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  final Stepper section8ChunkyStepper = Stepper(
    type: StepperType.horizontal,
    currentStep: 1,
    connectorColor: WidgetStateProperty.all<Color>(tokenWarn),
    connectorThickness: 8.0,
    stepIconHeight: 56.0,
    stepIconWidth: 56.0,
    stepIconMargin: const EdgeInsets.symmetric(horizontal: 12.0),
    steps: <Step>[
      Step(
        title: const Text('Earth'),
        content: const Text('Departure from low Earth orbit.'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Transit'),
        content: const Text('Cruise phase across the void.'),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: const Text('Mars'),
        content: const Text('Aerobraking and landing burn.'),
        isActive: false,
        state: StepState.indexed,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  // ===========================================================================
  // SECTION 9 - PHYSICS / ELEVATION / MARGIN VARIANTS
  // ===========================================================================

  final List<Step> longList = List<Step>.generate(8, (int i) {
    final List<String> names = <String>[
      'Inception',
      'Discovery',
      'Definition',
      'Design',
      'Development',
      'Delivery',
      'Documentation',
      'Decommission',
    ];
    final List<String> blurbs = <String>[
      'Project is conceived.',
      'Stakeholders aligned, requirements gathered.',
      'Acceptance criteria documented.',
      'Architecture and UX defined.',
      'Code, tests, integrations.',
      'Release management and deployment.',
      'Docs polished, knowledge transferred.',
      'Project formally retired.',
    ];
    StepState s;
    if (i < 3) {
      s = StepState.complete;
    } else if (i == 3) {
      s = StepState.editing;
    } else if (i == 5) {
      s = StepState.error;
    } else {
      s = StepState.indexed;
    }
    return Step(
      title: Text(names[i]),
      subtitle: Text('Phase ${i + 1} of ${names.length}'),
      content: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: tokenSurfaceAlt.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(blurbs[i]),
      ),
      isActive: i <= 5,
      state: s,
    );
  });

  final Stepper section9PhysicsStepper = Stepper(
    physics: const BouncingScrollPhysics(),
    currentStep: 3,
    steps: longList,
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  final Stepper section9ElevationStepper = Stepper(
    elevation: 12.0,
    currentStep: 1,
    steps: <Step>[
      Step(
        title: const Text('Lift-off'),
        content: const Text('Engines at full thrust.'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Orbit'),
        content: const Text('Burning into stable orbit.'),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: const Text('Dock'),
        content: const Text('Approach and docking manoeuvre.'),
        isActive: false,
        state: StepState.indexed,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  final Stepper section9MarginStepper = Stepper(
    margin: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
    currentStep: 0,
    steps: <Step>[
      Step(
        title: const Text('Compact A'),
        content: const Text('Custom margin tightens the side gutters.'),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: const Text('Compact B'),
        content: const Text('Useful when embedded in a narrow column.'),
        isActive: true,
        state: StepState.indexed,
      ),
      Step(
        title: const Text('Compact C'),
        content: const Text('Last step in the compact-margin demo.'),
        isActive: false,
        state: StepState.indexed,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  // ===========================================================================
  // SECTION 10 - REAL-WORLD CHECKOUT FLOW
  // ===========================================================================

  Widget checkoutCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: Colors.white, size: 22.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: tokenInkSoft,
                    fontSize: 11.5,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  value,
                  style: TextStyle(
                    color: tokenInk,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget summaryRow(String label, String value, {bool emphasise = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: emphasise ? tokenInk : tokenInkSoft,
                fontSize: emphasise ? 14.0 : 13.0,
                fontWeight: emphasise ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: emphasise ? tokenAccent : tokenInk,
              fontSize: emphasise ? 16.0 : 13.0,
              fontWeight: emphasise ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  final List<Step> checkoutSteps = <Step>[
    Step(
      title: const Text('Account'),
      subtitle: const Text('Identify the buyer'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          checkoutCard(
            icon: Icons.alternate_email,
            title: 'EMAIL',
            value: 'irene.adler@bsi.example',
            color: tokenAccent,
          ),
          checkoutCard(
            icon: Icons.badge_outlined,
            title: 'ACCOUNT TIER',
            value: 'Pro — verified since 2024',
            color: tokenSuccess,
          ),
        ],
      ),
      isActive: true,
      state: StepState.complete,
    ),
    Step(
      title: const Text('Shipping address'),
      subtitle: const Text('Where the parcel travels'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          checkoutCard(
            icon: Icons.location_on,
            title: 'PRIMARY ADDRESS',
            value: '221B Baker Street, London NW1 6XE',
            color: const Color(0xFF1976D2),
          ),
          checkoutCard(
            icon: Icons.local_shipping,
            title: 'COURIER',
            value: 'Royal Mail — Special Delivery Guaranteed',
            color: const Color(0xFFB36100),
          ),
        ],
      ),
      isActive: true,
      state: StepState.complete,
    ),
    Step(
      title: const Text('Payment method'),
      subtitle: const Text('Securely captured at checkout'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          checkoutCard(
            icon: Icons.credit_card,
            title: 'CARD',
            value: 'VISA •••• 4242 — expires 09/29',
            color: tokenAccent,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: tokenWarnSoft,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: tokenWarn.withValues(alpha: 0.45)),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.shield_moon, color: tokenWarn, size: 20.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    '3-D Secure challenge will be required if the issuer '
                    'flags this transaction.',
                    style: TextStyle(color: tokenWarn, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      isActive: true,
      state: StepState.editing,
    ),
    Step(
      title: const Text('Review & confirm'),
      subtitle: const Text('Last chance to change your mind'),
      content: Container(
        padding: const EdgeInsets.all(14.0),
        margin: const EdgeInsets.only(top: 8.0),
        decoration: BoxDecoration(
          color: tokenSurface,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: tokenOutline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Order summary',
              style: TextStyle(
                color: tokenInk,
                fontSize: 15.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8.0),
            summaryRow('Items subtotal', '\$142.00'),
            summaryRow('Shipping', '\$6.00'),
            summaryRow('Taxes (estimated)', '\$11.20'),
            Divider(color: tokenOutline, height: 22.0),
            summaryRow('Total', '\$159.20', emphasise: true),
          ],
        ),
      ),
      isActive: false,
      state: StepState.indexed,
    ),
  ];

  final Stepper section10CheckoutStepper = Stepper(
    currentStep: 2,
    steps: checkoutSteps,
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
    controlsBuilder: (BuildContext ctx, ControlsDetails details) {
      final bool isLast = details.stepIndex == checkoutSteps.length - 1;
      return Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: Row(
          children: <Widget>[
            FilledButton.icon(
              onPressed: details.onStepContinue,
              icon: Icon(
                isLast ? Icons.lock : Icons.east,
                size: 18.0,
              ),
              label: Text(isLast ? 'Pay \$159.20' : 'Continue'),
              style: FilledButton.styleFrom(
                backgroundColor: isLast ? tokenSuccess : tokenAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 12.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            TextButton(
              onPressed: details.onStepCancel,
              child: const Text('Edit previous'),
            ),
            const Spacer(),
            Icon(Icons.lock, size: 14.0, color: tokenInkSoft),
            const SizedBox(width: 4.0),
            Text(
              'Secured by 256-bit TLS',
              style: TextStyle(color: tokenInkSoft, fontSize: 11.5),
            ),
          ],
        ),
      );
    },
  );

  // ===========================================================================
  // SECTION 11 - HORIZONTAL ORDER TRACKER (real-world)
  // ===========================================================================

  final Stepper section11OrderTracker = Stepper(
    type: StepperType.horizontal,
    currentStep: 2,
    connectorColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return tokenAccent;
      }
      return tokenSuccess;
    }),
    connectorThickness: 5.0,
    stepIconHeight: 44.0,
    stepIconWidth: 44.0,
    stepIconBuilder: (int idx, StepState state) {
      switch (state) {
        case StepState.complete:
          return const Icon(Icons.done, color: Colors.white, size: 20.0);
        case StepState.editing:
          return const Icon(
            Icons.local_shipping,
            color: Colors.white,
            size: 20.0,
          );
        case StepState.error:
          return const Icon(Icons.warning, color: Colors.white, size: 20.0);
        case StepState.disabled:
          return const Icon(Icons.schedule, color: Colors.white, size: 20.0);
        case StepState.indexed:
          return Text(
            (idx + 1).toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          );
      }
    },
    steps: <Step>[
      Step(
        title: const Text('Ordered'),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text('Order #A-77291 placed at 09:42'),
        ),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Packed'),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text('Packed by warehouse 3 at 11:15'),
        ),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('In transit'),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text('Currently in Birmingham depot'),
        ),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: const Text('Delivered'),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text('Estimated arrival tomorrow 16:00'),
        ),
        isActive: false,
        state: StepState.disabled,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
    controlsBuilder: (BuildContext ctx, ControlsDetails details) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: <Widget>[
            OutlinedButton.icon(
              onPressed: details.onStepContinue,
              icon: const Icon(Icons.refresh, size: 16.0),
              label: const Text('Refresh tracker'),
            ),
            const SizedBox(width: 8.0),
            TextButton.icon(
              onPressed: details.onStepCancel,
              icon: const Icon(Icons.support_agent, size: 16.0),
              label: const Text('Contact support'),
            ),
          ],
        ),
      );
    },
  );

  // ===========================================================================
  // SECTION 12 - LABELS (vertical stepper with label slot)
  // ===========================================================================

  final Stepper section12LabelStepper = Stepper(
    currentStep: 1,
    steps: <Step>[
      Step(
        title: const Text('Configure campaign'),
        subtitle: const Text('Audiences and budgets'),
        label: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: tokenAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Text(
            'STEP 1',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
        content: const Text(
          'Pick the audience segments and configure the budgets for the '
          'upcoming campaign.',
        ),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Create ad group'),
        subtitle: const Text('Creative assets and copy'),
        label: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: tokenAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Text(
            'STEP 2',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
        content: const Text(
          'Assemble the creative kit — images, headlines and CTA buttons.',
        ),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: const Text('Schedule'),
        subtitle: const Text('Pick start and end dates'),
        label: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: tokenAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Text(
            'STEP 3',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
        content: const Text(
          'Define the time window where the campaign should be active.',
        ),
        isActive: false,
        state: StepState.indexed,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  // ===========================================================================
  // SECTION 13 - DENSE FORM IN STEPS
  // ===========================================================================

  Widget formField(String label, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          isDense: true,
        ),
      ),
    );
  }

  final Stepper section13FormStepper = Stepper(
    currentStep: 0,
    steps: <Step>[
      Step(
        title: const Text('Personal details'),
        subtitle: const Text('We need a few basics'),
        content: Column(
          children: <Widget>[
            formField('Full name', 'Sherlock Holmes', Icons.person),
            formField('Phone', '+44 ...', Icons.phone),
            formField('Email', 'you@example.com', Icons.email),
          ],
        ),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: const Text('Company'),
        subtitle: const Text('Business information'),
        content: Column(
          children: <Widget>[
            formField('Company name', 'Acme Ltd.', Icons.business),
            formField('Tax ID', 'VAT/GST number', Icons.numbers),
            formField('Industry', 'e.g. Software', Icons.category),
          ],
        ),
        isActive: false,
        state: StepState.indexed,
      ),
      Step(
        title: const Text('Confirmation'),
        subtitle: const Text('Verify before submission'),
        content: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: tokenSurfaceAlt,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Please confirm the information above is accurate before '
            'submitting the registration request.',
          ),
        ),
        isActive: false,
        state: StepState.indexed,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  // ===========================================================================
  // SECTION 14 - ERROR HIGHLIGHT WALK-THROUGH
  // ===========================================================================

  final Stepper section14ErrorStepper = Stepper(
    currentStep: 2,
    connectorColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.error)) {
        return tokenDanger;
      }
      if (states.contains(WidgetState.selected)) {
        return tokenDanger;
      }
      return tokenSuccess;
    }),
    connectorThickness: 3.0,
    steps: <Step>[
      Step(
        title: const Text('Validate inputs'),
        content: const Text('All required fields supplied.'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Run preflight checks'),
        content: const Text('System health and quota verified.'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Persist to database'),
        subtitle: Text(
          'Insertion failed — unique constraint violated',
          style: TextStyle(color: tokenDanger),
        ),
        content: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: tokenDangerSoft,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: tokenDanger.withValues(alpha: 0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.report, color: tokenDanger),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'duplicate key value violates unique constraint '
                      '"orders_external_id_key"',
                      style: TextStyle(
                        color: tokenDanger,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.0,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Retry with an idempotency key or reuse the existing '
                      'record id.',
                      style: TextStyle(
                        color: tokenDanger,
                        fontSize: 12.0,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        isActive: true,
        state: StepState.error,
      ),
      Step(
        title: const Text('Notify caller'),
        content: const Text('Will be reached once the previous step recovers.'),
        isActive: false,
        state: StepState.disabled,
      ),
    ],
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );

  // ===========================================================================
  // SECTION 15 - CONTROLSBUILDER USING ControlsDetails APIs
  // ===========================================================================

  final List<String> ctaPhrases = <String>[
    'Begin onboarding',
    'Verify your identity',
    'Pick a workspace',
    'Invite teammates',
    'Launch the workspace',
  ];

  final Stepper section15DynamicCtaStepper = Stepper(
    currentStep: 2,
    steps: List<Step>.generate(ctaPhrases.length, (int i) {
      StepState st;
      if (i < 2) {
        st = StepState.complete;
      } else if (i == 2) {
        st = StepState.editing;
      } else {
        st = StepState.indexed;
      }
      return Step(
        title: Text(ctaPhrases[i]),
        subtitle: Text('Stage ${i + 1} of ${ctaPhrases.length}'),
        content: Container(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: tokenSurfaceAlt.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Describe stage ${i + 1}. The CTA renders the phrase verbatim '
            'thanks to ControlsDetails.stepIndex routing.',
            style: TextStyle(color: tokenInk, fontSize: 12.5),
          ),
        ),
        isActive: i <= 2,
        state: st,
      );
    }),
    onStepTapped: (int _) {},
    onStepContinue: () {},
    onStepCancel: () {},
    controlsBuilder: (BuildContext ctx, ControlsDetails details) {
      final String label = details.stepIndex < ctaPhrases.length
          ? ctaPhrases[details.stepIndex]
          : 'Continue';
      final bool isLast = details.stepIndex == ctaPhrases.length - 1;
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: details.onStepContinue,
              icon: Icon(
                isLast ? Icons.flag : Icons.east,
                size: 18.0,
              ),
              label: Text(label),
              style: ElevatedButton.styleFrom(
                backgroundColor: isLast ? tokenSuccess : tokenAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            if (details.stepIndex > 0)
              TextButton(
                onPressed: details.onStepCancel,
                child: const Text('Back'),
              ),
            const Spacer(),
            Text(
              '${details.stepIndex + 1} / ${ctaPhrases.length}',
              style: TextStyle(
                color: tokenInkSoft,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    },
  );

  // ===========================================================================
  // SECTION 16 - LEGEND / API SUMMARY
  // ===========================================================================

  Widget apiRow(String name, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: tokenSurface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: tokenOutline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: tokenAccent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: tokenAccent,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                color: tokenInk,
                fontSize: 12.0,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section16Legend = Container(
    padding: const EdgeInsets.all(14.0),
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: tokenSurfaceAlt.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tokenOutline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: tokenAccent, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Stepper API at a glance',
              style: TextStyle(
                color: tokenInk,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        apiRow(
          'steps',
          'The ordered list of Step entries the stepper renders.',
        ),
        apiRow(
          'type',
          'StepperType.vertical (default) or StepperType.horizontal.',
        ),
        apiRow(
          'currentStep',
          'Zero-based index of the active step.',
        ),
        apiRow(
          'onStepTapped',
          'Called with the tapped index — return path for tap-based navigation.',
        ),
        apiRow(
          'onStepContinue',
          'Invoked by the default continue button or by your controlsBuilder.',
        ),
        apiRow(
          'onStepCancel',
          'Invoked by the default cancel button or by your controlsBuilder.',
        ),
        apiRow(
          'controlsBuilder',
          'Returns the widget below each step content; receives ControlsDetails.',
        ),
        apiRow(
          'stepIconBuilder',
          'Returns the inner widget of the step circle for a given (index, state).',
        ),
        apiRow(
          'connectorColor',
          'WidgetStateProperty<Color> applied to the lines between steps.',
        ),
        apiRow(
          'connectorThickness',
          'Width of the connector line in logical pixels.',
        ),
        apiRow(
          'stepIconHeight / stepIconWidth',
          'Size of the leading step indicator circle.',
        ),
        apiRow(
          'stepIconMargin',
          'EdgeInsets surrounding the indicator circle.',
        ),
        apiRow(
          'elevation',
          'Material elevation underneath the stepper (vertical type only).',
        ),
        apiRow(
          'margin',
          'Outer padding applied around the stepper.',
        ),
        apiRow(
          'physics',
          'ScrollPhysics for the underlying scrollable.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 17 - DESIGN TOKEN PALETTE
  // ===========================================================================

  Widget paletteSwatch(String name, Color color) {
    return Container(
      width: 116.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tokenOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 38.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: color.withValues(alpha: 0.35),
                  blurRadius: 6.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            name,
            style: TextStyle(
              color: tokenInk,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  final Widget section17Palette = Wrap(
    children: <Widget>[
      paletteSwatch('accent', tokenAccent),
      paletteSwatch('accent-soft', tokenAccentSoft),
      paletteSwatch('success', tokenSuccess),
      paletteSwatch('warn', tokenWarn),
      paletteSwatch('danger', tokenDanger),
      paletteSwatch('ink', tokenInk),
      paletteSwatch('ink-soft', tokenInkSoft),
      paletteSwatch('surface', tokenSurface),
      paletteSwatch('surface-alt', tokenSurfaceAlt),
      paletteSwatch('outline', tokenOutline),
    ],
  );

  // ===========================================================================
  // FINAL ASSEMBLY
  // ===========================================================================

  return Scaffold(
    backgroundColor: tokenSurface,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroBanner,
          buildSectionHeader(
            number: 1,
            title: 'StepState catalogue',
            subtitle:
                'The five visual states a Step can present, side by side.',
            icon: Icons.palette,
            color: tokenAccent,
          ),
          buildNarrative(
            'A Step renders differently depending on its StepState. Use this '
            'gallery as the source of truth when reasoning about icon glyphs '
            'and the colours used by the connectors that lead into a step.',
          ),
          Wrap(children: stateChips),

          buildSectionHeader(
            number: 2,
            title: 'Vertical stepper — guided tour',
            subtitle:
                'The default StepperType.vertical with rich step content.',
            icon: Icons.format_list_bulleted,
            color: const Color(0xFF1976D2),
          ),
          buildNarrative(
            'In the vertical layout the active step expands inline, revealing '
            'its content widget along with the continue / cancel buttons. '
            'Subtitles let you offer hints without expanding the step.',
          ),
          buildLabel('Default vertical stepper'),
          buildStepperFrame(child: section3Stepper, height: 520.0),

          buildSectionHeader(
            number: 3,
            title: 'Horizontal stepper gallery',
            subtitle:
                'Three flavours of StepperType.horizontal for different flows.',
            icon: Icons.view_week,
            color: const Color(0xFF00897B),
          ),
          buildNarrative(
            'Horizontal steppers are compact and read very well on wide '
            'screens. Below: a checkout (4 steps), a publishing flow '
            '(3 steps) and a hiring funnel (4 steps).',
          ),
          buildLabel('Checkout — currently on Payment'),
          buildStepperFrame(child: section4HorizontalA, height: 240.0),
          buildLabel('Publishing — fresh draft'),
          buildStepperFrame(child: section4HorizontalB, height: 220.0),
          buildLabel('Hiring funnel — offer phase'),
          buildStepperFrame(child: section4HorizontalC, height: 240.0),

          buildSectionHeader(
            number: 4,
            title: 'Step state live walkthrough',
            subtitle:
                'A single Stepper that contains all five StepState values.',
            icon: Icons.layers,
            color: const Color(0xFF6A1B9A),
          ),
          buildNarrative(
            'This is the easiest way to see how Material draws each state: '
            'the icon inside the circle, the connector colour leading into '
            'the step and the title colour.',
          ),
          buildStepperFrame(child: section5StatesStepper, height: 760.0),

          buildSectionHeader(
            number: 5,
            title: 'controlsBuilder — own the navigation',
            subtitle:
                'Replace the default Continue / Cancel pair with custom UI.',
            icon: Icons.tune,
            color: tokenAccent,
          ),
          buildNarrative(
            'controlsBuilder receives ControlsDetails with stepIndex, '
            'currentStep, isActive plus the original onStepContinue / '
            'onStepCancel callbacks. Anything you return is rendered below '
            'each step content.',
          ),
          buildLabel('Pill-shaped CTA with active step pill'),
          buildStepperFrame(child: section6ControlsStepper, height: 520.0),
          buildLabel('Icon-only minimal controls'),
          buildStepperFrame(child: section6IconControls, height: 420.0),
          buildLabel('Zero controls (SizedBox.shrink)'),
          buildStepperFrame(child: section6NoControls, height: 380.0),

          buildSectionHeader(
            number: 6,
            title: 'stepIconBuilder — design the indicator',
            subtitle: 'Return any widget for the leading circle.',
            icon: Icons.donut_small,
            color: const Color(0xFFD81B60),
          ),
          buildNarrative(
            'stepIconBuilder is called for every step with the index and the '
            'current state. Returning null falls back to the default icon, '
            'so you can selectively override only the states you care about.',
          ),
          buildLabel('Barista flow (vertical)'),
          buildStepperFrame(child: section7IconStepper, height: 640.0),
          buildLabel('Glyph rotation (horizontal)'),
          buildStepperFrame(child: section7GlyphStepper, height: 260.0),

          buildSectionHeader(
            number: 7,
            title: 'Connectors and icon sizing',
            subtitle:
                'connectorColor, connectorThickness, stepIcon* properties.',
            icon: Icons.linear_scale,
            color: tokenWarn,
          ),
          buildNarrative(
            'Connectors are the lines between the indicators. Use '
            'WidgetStateProperty.resolveWith to pick a colour per state '
            '(selected, disabled, error...). Increase connectorThickness '
            'for a heavier visual weight, decrease for elegance.',
          ),
          buildLabel('Resolver-based connector colour'),
          buildStepperFrame(child: section8ConnectorStepper, height: 520.0),
          buildLabel('Thin horizontal connectors'),
          buildStepperFrame(child: section8ThinStepper, height: 240.0),
          buildLabel('Chunky horizontal connectors'),
          buildStepperFrame(child: section8ChunkyStepper, height: 260.0),

          buildSectionHeader(
            number: 8,
            title: 'Physics, elevation, margin',
            subtitle: 'Vertical stepper scrolling and box-model tuning.',
            icon: Icons.tune,
            color: const Color(0xFF455A64),
          ),
          buildNarrative(
            'In the vertical layout the stepper hosts its own scroll view. '
            'You can swap the ScrollPhysics, set a Material elevation that '
            'shows through the Card-like background, and tighten the margin '
            'when embedding inside a narrow column.',
          ),
          buildLabel('Bouncing physics, eight steps'),
          buildStepperFrame(child: section9PhysicsStepper, height: 720.0),
          buildLabel('Elevation 12'),
          buildStepperFrame(child: section9ElevationStepper, height: 440.0),
          buildLabel('Custom margin'),
          buildStepperFrame(child: section9MarginStepper, height: 460.0),

          buildSectionHeader(
            number: 9,
            title: 'Real-world checkout flow',
            subtitle:
                'A four-step checkout combining everything we have seen.',
            icon: Icons.shopping_bag,
            color: tokenSuccess,
          ),
          buildNarrative(
            'This composite example shows how Stepper carries a real '
            'workflow. Custom controls switch from "Continue" to a '
            'green "Pay" button at the final step, and a security strip '
            'is rendered on the right of the controls row.',
          ),
          buildStepperFrame(child: section10CheckoutStepper, height: 820.0),

          buildSectionHeader(
            number: 10,
            title: 'Horizontal order tracker',
            subtitle: 'A real-time order-status visualisation.',
            icon: Icons.local_shipping,
            color: const Color(0xFF1976D2),
          ),
          buildNarrative(
            'Order trackers are the canonical use-case for the horizontal '
            'stepper: each step has a clear state, the connectors are bold, '
            'and the controls strip becomes secondary actions.',
          ),
          buildStepperFrame(child: section11OrderTracker, height: 320.0),

          buildSectionHeader(
            number: 11,
            title: 'Label slot',
            subtitle: 'The optional Step.label widget for chip-style markers.',
            icon: Icons.label_important,
            color: const Color(0xFF5E35B1),
          ),
          buildNarrative(
            'Step has an additional "label" slot that is rendered next to '
            'the title in some layouts. Use it for compact stage badges or '
            'shortcodes — useful in dashboards full of similar wizards.',
          ),
          buildStepperFrame(child: section12LabelStepper, height: 540.0),

          buildSectionHeader(
            number: 12,
            title: 'Dense form steps',
            subtitle:
                'TextFields, OutlineInputBorder and isDense inside steps.',
            icon: Icons.assignment_ind,
            color: const Color(0xFF2E7D32),
          ),
          buildNarrative(
            'Stepper works great with TextField content. Wrap fields in a '
            'Column inside the step content and let the controls below '
            'drive submission. The inputs are not wired here — they exist '
            'to show how the layout breathes.',
          ),
          buildStepperFrame(child: section13FormStepper, height: 620.0),

          buildSectionHeader(
            number: 13,
            title: 'Error highlight walk-through',
            subtitle:
                'StepState.error + connector colour for trouble shooting.',
            icon: Icons.error_outline,
            color: tokenDanger,
          ),
          buildNarrative(
            'When a step fails, set its state to StepState.error and reuse '
            'connectorColor to colour the lines that lead into / out of the '
            'failing step. Combine with a dedicated error card inside '
            'content for actionable diagnostics.',
          ),
          buildStepperFrame(child: section14ErrorStepper, height: 600.0),

          buildSectionHeader(
            number: 14,
            title: 'Per-step controls via ControlsDetails',
            subtitle:
                'Use details.stepIndex to render dynamic call-to-action labels.',
            icon: Icons.flag,
            color: tokenAccent,
          ),
          buildNarrative(
            'ControlsDetails carries the index of the step the controls '
            'belong to. Use it to swap the CTA copy as the user advances — '
            'the final step becomes the conclusive action ("Launch the '
            'workspace"), not a generic "Continue".',
          ),
          buildStepperFrame(child: section15DynamicCtaStepper, height: 760.0),

          buildSectionHeader(
            number: 15,
            title: 'API quick-reference',
            subtitle:
                'Every constructor parameter you saw, summarised in one place.',
            icon: Icons.menu_book,
            color: const Color(0xFF455A64),
          ),
          section16Legend,

          buildSectionHeader(
            number: 16,
            title: 'Design tokens',
            subtitle:
                'The palette used throughout this demo for easy reproduction.',
            icon: Icons.palette,
            color: const Color(0xFF8E24AA),
          ),
          section17Palette,

          const SizedBox(height: 32.0),

          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  tokenAccent.withValues(alpha: 0.85),
                  const Color(0xFF8E7CC3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.check_circle, color: Colors.white, size: 30.0),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Demo complete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Stepper, Step, StepState, StepperType, ControlsDetails, '
                        'controlsBuilder, stepIconBuilder, connectorColor, '
                        'connectorThickness, stepIconHeight/Width, '
                        'stepIconMargin, elevation, margin and physics — all '
                        'demonstrated above.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}
