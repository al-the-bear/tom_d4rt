import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Airline-ticket aesthetic palette. We stay in an indigo / sky-blue / gold
// space with white neutrals. No greens, no ambers — the brief forbids them.
// ---------------------------------------------------------------------------
const Color _kInkIndigo = Color(0xFF1A237E); // indigo-800 — primary ink
const Color _kDeepIndigo = Color(0xFF283593); // indigo-700 — heading tint
const Color _kMidIndigo = Color(0xFF3949AB); // indigo-600 — accent strokes
const Color _kSkyBlue = Color(0xFF4FC3F7); // sky-300 — progress highlight
const Color _kDeepSky = Color(0xFF0288D1); // sky-700 — ribbon base
const Color _kGold = Color(0xFFFFC107); // gold — confirmation badge
const Color _kSoftGold = Color(0xFFFFE082); // soft gold — hero accent
const Color _kTicketCream = Color(0xFFFFFDF5); // near-white ticket body
const Color _kTicketPaper = Color(0xFFF4F1E6); // secondary paper tone
const Color _kInkMuted = Color(0xFF546E7A); // blue-grey — secondary text

// ---------------------------------------------------------------------------
// Top-level entry expected by the harness. Builds a MaterialApp with an
// onGenerateRoute so that Navigator.restorablePushNamed can dispatch to the
// three picker pages that the wizard relies on.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('=== RestorableRouteFuture Deep Demo — Travel Booking Wizard ===');
  debugPrint('Mounting MaterialApp with restorationScopeId "travel_booking_app".');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RestorableRouteFuture — Travel Booking Wizard',
    restorationScopeId: 'travel_booking_app',
    theme: _buildTheme(),
    home: const TravelBookingDemo(),
    onGenerateRoute: (RouteSettings settings) {
      debugPrint('onGenerateRoute -> "${settings.name}"');
      switch (settings.name) {
        case '/pick_destination':
          return MaterialPageRoute<String>(
            settings: settings,
            builder: (_) => const DestinationPickerPage(),
          );
        case '/pick_passengers':
          return MaterialPageRoute<int>(
            settings: settings,
            builder: (_) => const PassengerCountPage(),
          );
        case '/pick_class':
          return MaterialPageRoute<String>(
            settings: settings,
            builder: (_) => const ClassPickerPage(),
          );
        default:
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => const _UnknownRoutePage(),
          );
      }
    },
  );
}

// ---------------------------------------------------------------------------
// Theme builder — airline-ticket aesthetic.
// ---------------------------------------------------------------------------
ThemeData _buildTheme() {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: _kInkIndigo,
    primary: _kInkIndigo,
    secondary: _kDeepSky,
    surface: _kTicketCream,
  );
  return ThemeData(
    colorScheme: scheme,
    scaffoldBackgroundColor: _kTicketPaper,
    useMaterial3: true,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: _kInkIndigo,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
      titleMedium: TextStyle(
        color: _kDeepIndigo,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(color: _kInkIndigo),
      bodySmall: TextStyle(color: _kInkMuted),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _kInkIndigo,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// TravelBookingDemo — the heart of the demo. Demonstrates three
// RestorableRouteFuture instances, each awaiting a different picker result.
// All of them plus the latched string/int values register with the mixin
// so the wizard survives full process death mid-dialogue.
// ---------------------------------------------------------------------------
class TravelBookingDemo extends StatefulWidget {
  const TravelBookingDemo({super.key});

  @override
  State<TravelBookingDemo> createState() => _TravelBookingDemoState();
}

class _TravelBookingDemoState extends State<TravelBookingDemo>
    with RestorationMixin {
  // The three RestorableRouteFuture fields. Each one wraps a named route.
  late final RestorableRouteFuture<String> _destinationFuture;
  late final RestorableRouteFuture<int> _passengerCountFuture;
  late final RestorableRouteFuture<String> _classFuture;

  // Persisted, resolved values written once onComplete fires.
  final RestorableStringN _chosenDestination = RestorableStringN(null);
  final RestorableIntN _chosenPassengers = RestorableIntN(null);
  final RestorableStringN _chosenClass = RestorableStringN(null);

  // In-memory history ring. Intentionally NOT restorable; the brief asks us
  // to keep this ephemeral so we can show the contrast.
  final List<_DecisionEntry> _history = <_DecisionEntry>[];

  @override
  String get restorationId => 'travel_booking_demo';

  @override
  void initState() {
    super.initState();
    _destinationFuture = RestorableRouteFuture<String>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        debugPrint('Presenting /pick_destination with arguments=$arguments');
        return navigator.restorablePushNamed(
          '/pick_destination',
          arguments: arguments,
        );
      },
      onComplete: _onDestinationPicked,
    );
    _passengerCountFuture = RestorableRouteFuture<int>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        debugPrint('Presenting /pick_passengers with arguments=$arguments');
        return navigator.restorablePushNamed(
          '/pick_passengers',
          arguments: arguments,
        );
      },
      onComplete: _onPassengersPicked,
    );
    _classFuture = RestorableRouteFuture<String>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        debugPrint('Presenting /pick_class with arguments=$arguments');
        return navigator.restorablePushNamed(
          '/pick_class',
          arguments: arguments,
        );
      },
      onComplete: _onClassPicked,
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    debugPrint('restoreState(initial=$initialRestore) — re-attaching futures');
    registerForRestoration(_destinationFuture, 'destination_future');
    registerForRestoration(_passengerCountFuture, 'passenger_future');
    registerForRestoration(_classFuture, 'class_future');
    registerForRestoration(_chosenDestination, 'chosen_destination');
    registerForRestoration(_chosenPassengers, 'chosen_passengers');
    registerForRestoration(_chosenClass, 'chosen_class');
  }

  @override
  void dispose() {
    _destinationFuture.dispose();
    _passengerCountFuture.dispose();
    _classFuture.dispose();
    _chosenDestination.dispose();
    _chosenPassengers.dispose();
    _chosenClass.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Completion callbacks. Each one narrates the transition so that when the
  // demo is inspected under `flutter run -d chrome` we can follow the flow
  // in the devtools console.
  // -------------------------------------------------------------------------
  void _onDestinationPicked(String value) {
    debugPrint('onComplete(destination) -> "$value"');
    setState(() {
      _chosenDestination.value = value;
      _history.insert(
        0,
        _DecisionEntry(
          stage: _WizardStage.destination,
          value: value,
          when: DateTime.now(),
        ),
      );
    });
  }

  void _onPassengersPicked(int value) {
    debugPrint('onComplete(passengers) -> $value');
    setState(() {
      _chosenPassengers.value = value;
      _history.insert(
        0,
        _DecisionEntry(
          stage: _WizardStage.passengers,
          value: value.toString(),
          when: DateTime.now(),
        ),
      );
    });
  }

  void _onClassPicked(String value) {
    debugPrint('onComplete(class) -> "$value"');
    setState(() {
      _chosenClass.value = value;
      _history.insert(
        0,
        _DecisionEntry(
          stage: _WizardStage.cabin,
          value: value,
          when: DateTime.now(),
        ),
      );
    });
  }

  // Booking completeness — used to unlock the "Confirm booking" call to
  // action and colour the hero card's checkmark.
  bool get _allResolved =>
      _chosenDestination.value != null &&
      _chosenPassengers.value != null &&
      _chosenClass.value != null;

  int get _completedSteps {
    int count = 0;
    if (_chosenDestination.value != null) count++;
    if (_chosenPassengers.value != null) count++;
    if (_chosenClass.value != null) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _kInkIndigo,
        foregroundColor: Colors.white,
        title: const Text('Travel Booking Wizard'),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Step $_completedSteps / 3',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
            final bool wide = constraints.maxWidth > 900;
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              children: <Widget>[
                _buildTicketHero(),
                const SizedBox(height: 24),
                _buildPickerActionRow(),
                const SizedBox(height: 24),
                _buildProgressStrip(),
                const SizedBox(height: 24),
                if (wide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: _buildHistoryLog()),
                      const SizedBox(width: 24),
                      Expanded(child: _buildTeachingPanel()),
                    ],
                  )
                else ...<Widget>[
                  _buildHistoryLog(),
                  const SizedBox(height: 24),
                  _buildTeachingPanel(),
                ],
                const SizedBox(height: 32),
                _buildConfirmationFooter(),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Booking summary hero — airline ticket shape with a tear line.
  // -------------------------------------------------------------------------
  Widget _buildTicketHero() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          color: _kTicketCream,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _kInkIndigo.withValues(alpha: 0.25),
              blurRadius: 26,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTicketUpperHalf(),
                _buildPerforatedTearLine(),
                _buildTicketLowerHalf(),
              ],
            ),
            Positioned(
              top: 18,
              right: 18,
              child: _buildTicketStatusBadge(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketUpperHalf() {
    return Container(
      padding: const EdgeInsets.fromLTRB(26, 26, 26, 22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kInkIndigo, _kDeepIndigo, _kMidIndigo],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.flight_takeoff,
                color: _kSoftGold,
                size: 32,
              ),
              const SizedBox(width: 12),
              Text(
                'Tom Airways — Boarding Pass Draft',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: _buildHeroSlot(
                  label: 'DESTINATION',
                  icon: Icons.location_on,
                  value: _chosenDestination.value,
                  placeholder: '--- pick destination ---',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildHeroSlot(
                  label: 'PAX',
                  icon: Icons.people_alt,
                  value: _chosenPassengers.value?.toString(),
                  placeholder: '--- pick count ---',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildHeroSlot(
            label: 'CLASS',
            icon: Icons.airline_seat_recline_extra,
            value: _chosenClass.value,
            placeholder: '--- pick cabin class ---',
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSlot({
    required String label,
    required IconData icon,
    required String? value,
    required String placeholder,
  }) {
    final bool filled = value != null && value.isNotEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: filled ? 0.55 : 0.20,
          ),
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 20,
            color: filled ? _kSoftGold : Colors.white.withValues(alpha: 0.55),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  filled ? value.toUpperCase() : placeholder,
                  style: TextStyle(
                    color: filled
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.55),
                    fontSize: filled ? 18 : 13,
                    fontWeight:
                        filled ? FontWeight.w700 : FontWeight.w400,
                    fontStyle: filled ? FontStyle.normal : FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          if (filled)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: _kGold,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 14,
                color: _kInkIndigo,
              ),
            ),
        ],
      ),
    );
  }

  // A row of tiny circles sandwiched between two thin lines gives the
  // classic "tear here" effect on the airline stub.
  Widget _buildPerforatedTearLine() {
    return Container(
      height: 22,
      color: _kDeepIndigo,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: -10,
            child: _buildPerforationHole(),
          ),
          Positioned(
            right: -10,
            child: _buildPerforationHole(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(28, (int i) {
              return Container(
                width: 6,
                height: 2,
                decoration: BoxDecoration(
                  color: _kTicketCream.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPerforationHole() {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        color: _kTicketPaper,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildTicketLowerHalf() {
    final String destination = _chosenDestination.value ?? '—';
    final String pax = _chosenPassengers.value?.toString() ?? '—';
    final String cabin = _chosenClass.value ?? '—';
    return Container(
      padding: const EdgeInsets.fromLTRB(26, 20, 26, 24),
      color: _kTicketCream,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildStubSlot('GATE', 'B-12'),
              _buildStubSlot('SEAT', cabin == '—' ? '—' : cabin[0].toUpperCase()),
              _buildStubSlot('BOARDING', '19:40'),
              _buildStubSlot('PAX', pax),
            ],
          ),
          const Divider(height: 28, color: _kTicketPaper),
          Row(
            children: <Widget>[
              const Icon(Icons.qr_code_2, size: 42, color: _kInkIndigo),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Confirmation: ${_buildConfirmationCode()}',
                      style: const TextStyle(
                        color: _kInkIndigo,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Draft route TOM → ${destination.toUpperCase()} '
                      '• state survives app death',
                      style: const TextStyle(
                        color: _kInkMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStubSlot(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: _kInkMuted,
            fontSize: 10,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: _kInkIndigo,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildTicketStatusBadge() {
    final bool ready = _allResolved;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ready ? _kGold : Colors.white.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ready ? _kSoftGold : Colors.white.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            ready ? Icons.verified : Icons.hourglass_empty,
            size: 14,
            color: ready ? _kInkIndigo : Colors.white,
          ),
          const SizedBox(width: 6),
          Text(
            ready ? 'READY' : 'DRAFT',
            style: TextStyle(
              color: ready ? _kInkIndigo : Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 11,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  String _buildConfirmationCode() {
    final String d = (_chosenDestination.value ?? '???').substring(
      0,
      _chosenDestination.value != null && _chosenDestination.value!.length >= 3
          ? 3
          : (_chosenDestination.value?.length ?? 0),
    );
    final String c = (_chosenClass.value ?? '???').substring(
      0,
      _chosenClass.value != null && _chosenClass.value!.length >= 3
          ? 3
          : (_chosenClass.value?.length ?? 0),
    );
    final String p = _chosenPassengers.value?.toString().padLeft(2, '0') ?? '00';
    final String padD = d.padRight(3, '-');
    final String padC = c.padRight(3, '-');
    return 'TOM-${padD.toUpperCase()}-${padC.toUpperCase()}-$p';
  }

  // -------------------------------------------------------------------------
  // Picker action row — three tall FilledButtons, one per RestorableRouteFuture.
  // -------------------------------------------------------------------------
  Widget _buildPickerActionRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildPickerButton(
            label: 'Pick destination',
            icon: Icons.public,
            filled: _chosenDestination.value != null,
            onPressed: () => _destinationFuture.present(),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _buildPickerButton(
            label: 'Pick passengers',
            icon: Icons.groups_2,
            filled: _chosenPassengers.value != null,
            onPressed: () => _passengerCountFuture.present(),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _buildPickerButton(
            label: 'Pick class',
            icon: Icons.airline_seat_recline_normal,
            filled: _chosenClass.value != null,
            onPressed: () => _classFuture.present(),
          ),
        ),
      ],
    );
  }

  Widget _buildPickerButton({
    required String label,
    required IconData icon,
    required bool filled,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 96,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: filled ? _kDeepSky : _kInkIndigo,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 30),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            if (filled)
              Positioned(
                top: 8,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: _kGold,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 14,
                    color: _kInkIndigo,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Per-step progress bar — 3 segments, each showing the truncated value.
  // -------------------------------------------------------------------------
  Widget _buildProgressStrip() {
    final List<_StepDescriptor> steps = <_StepDescriptor>[
      _StepDescriptor(
        label: 'Destination',
        value: _chosenDestination.value,
        icon: Icons.location_on,
      ),
      _StepDescriptor(
        label: 'Passengers',
        value: _chosenPassengers.value?.toString(),
        icon: Icons.people_alt,
      ),
      _StepDescriptor(
        label: 'Cabin class',
        value: _chosenClass.value,
        icon: Icons.airline_seat_recline_extra,
      ),
    ];
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Wizard progress',
              style: TextStyle(
                color: _kInkIndigo,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: List<Widget>.generate(steps.length, (int i) {
                final bool filled = steps[i].value != null;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: i == steps.length - 1 ? 0 : 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: filled
                                ? _kSkyBlue
                                : _kInkIndigo.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(
                              steps[i].icon,
                              color: filled ? _kDeepSky : _kInkMuted,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                steps[i].label,
                                style: TextStyle(
                                  color: filled ? _kInkIndigo : _kInkMuted,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          steps[i].value == null
                              ? 'not chosen'
                              : _truncate(steps[i].value!, 16),
                          style: TextStyle(
                            color: filled ? _kDeepIndigo : _kInkMuted,
                            fontSize: 11,
                            fontStyle: filled
                                ? FontStyle.normal
                                : FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  String _truncate(String input, int max) {
    if (input.length <= max) return input;
    return '${input.substring(0, max - 1)}…';
  }

  // -------------------------------------------------------------------------
  // Decision history log — ephemeral, ListView inside a bordered card.
  // -------------------------------------------------------------------------
  Widget _buildHistoryLog() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: _kInkIndigo.withValues(alpha: 0.18),
        ),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.history,
                  color: _kDeepSky,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Decision log',
                  style: TextStyle(
                    color: _kInkIndigo,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_history.length} entries',
                  style: const TextStyle(
                    color: _kInkMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Ephemeral — this log is not restored across app death.',
              style: TextStyle(
                color: _kInkMuted,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 14),
            if (_history.isEmpty)
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: _kTicketPaper,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: <Widget>[
                    Icon(Icons.info_outline, color: _kInkMuted),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'No decisions yet. Tap a picker above to get started.',
                        style: TextStyle(color: _kInkMuted),
                      ),
                    ),
                  ],
                ),
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 260),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _history.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    final _DecisionEntry entry = _history[index];
                    final bool isFirst = index == 0;
                    final bool isLast = index == _history.length - 1;
                    return _buildTimelineRow(entry, isFirst, isLast);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineRow(_DecisionEntry entry, bool isFirst, bool isLast) {
    final Color dotColor = switch (entry.stage) {
      _WizardStage.destination => _kDeepSky,
      _WizardStage.passengers => _kMidIndigo,
      _WizardStage.cabin => _kGold,
    };
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 2,
                height: 12,
                color: isFirst
                    ? Colors.transparent
                    : _kInkIndigo.withValues(alpha: 0.2),
              ),
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: dotColor.withValues(alpha: 0.35),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: isLast
                      ? Colors.transparent
                      : _kInkIndigo.withValues(alpha: 0.2),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${_labelForStage(entry.stage)} chosen: ${entry.value}',
                    style: const TextStyle(
                      color: _kInkIndigo,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatWhen(entry.when),
                    style: const TextStyle(
                      color: _kInkMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _labelForStage(_WizardStage stage) {
    switch (stage) {
      case _WizardStage.destination:
        return 'Destination';
      case _WizardStage.passengers:
        return 'Passenger count';
      case _WizardStage.cabin:
        return 'Cabin class';
    }
  }

  String _formatWhen(DateTime when) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${when.year}-${two(when.month)}-${two(when.day)} '
        '${two(when.hour)}:${two(when.minute)}:${two(when.second)}';
  }

  // -------------------------------------------------------------------------
  // Teaching panel — explains RestorableRouteFuture in human terms, with a
  // tiny ASCII diagram and a code block of the canonical field declaration.
  // -------------------------------------------------------------------------
  Widget _buildTeachingPanel() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: _kDeepSky.withValues(alpha: 0.35)),
      ),
      color: _kTicketCream,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.school,
                  color: _kDeepIndigo,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Why RestorableRouteFuture?',
                  style: TextStyle(
                    color: _kInkIndigo,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'A route future that survives process death. When you push a '
              'modal route to ask the user for something (a city, a count, '
              'a seat class), the caller holds a Future waiting for the pop '
              'result. If Android evicts the process while the dialog is on '
              'screen, a plain Future is lost. RestorableRouteFuture '
              're-binds the pending route and its completion callback '
              'automatically on restart.',
              style: TextStyle(color: _kInkIndigo, height: 1.4),
            ),
            const SizedBox(height: 14),
            const Text(
              'Three-callback contract',
              style: TextStyle(
                color: _kDeepIndigo,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            _buildBullet(
              'onPresent(navigator, arguments) — pushes a named route and '
              'returns its restoration id. Called when you invoke '
              'future.present().',
            ),
            _buildBullet(
              'onComplete(value) — fires once when the pushed route pops '
              'with a result. Persists resolved data into your restorable '
              'properties.',
            ),
            _buildBullet(
              'onFirstRouteAdded (optional) — called the very first time a '
              'route is attached, useful for cleaning stale UI state on '
              'fresh launches.',
            ),
            const SizedBox(height: 14),
            _buildDiagram(),
            const SizedBox(height: 14),
            _buildCodeBlock(),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kDeepSky.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _kDeepSky.withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                children: <Widget>[
                  Icon(Icons.tips_and_updates, color: _kDeepSky),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Rule of thumb: if the value you are awaiting from '
                      'a route must outlive a forced restart, use '
                      'RestorableRouteFuture. Otherwise plain '
                      'Navigator.push is fine.',
                      style: TextStyle(color: _kInkIndigo),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(
              Icons.circle,
              size: 6,
              color: _kDeepSky,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _kInkIndigo,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagram() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kInkIndigo.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'user taps button\n'
        '     │\n'
        '     ▼\n'
        ' future.present(arg)\n'
        '     │\n'
        '     ▼\n'
        ' onPresent(nav, arg) → nav.restorablePushNamed(...)\n'
        '     │\n'
        '     ▼\n'
        ' user picks a value and pops\n'
        '     │\n'
        '     ▼\n'
        ' onComplete(value) → persist into RestorableXxx\n',
        style: TextStyle(
          fontFamily: 'monospace',
          color: _kInkIndigo,
          height: 1.35,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildCodeBlock() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kInkIndigo.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'late final RestorableRouteFuture<String> _destinationFuture =\n'
        '    RestorableRouteFuture<String>(\n'
        '      onPresent: (nav, args) => nav.restorablePushNamed(\n'
        "          '/pick_destination', arguments: args),\n"
        '      onComplete: (value) =>\n'
        '          setState(() => _chosenDestination.value = value),\n'
        '    );',
        style: TextStyle(
          fontFamily: 'monospace',
          color: Colors.white,
          fontSize: 12,
          height: 1.35,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Footer — confirmation call to action once all three values are picked.
  // -------------------------------------------------------------------------
  Widget _buildConfirmationFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _allResolved
            ? _kInkIndigo
            : _kInkIndigo.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            _allResolved ? Icons.verified : Icons.info_outline,
            color: _allResolved ? _kGold : _kInkIndigo,
            size: 32,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              _allResolved
                  ? 'Booking draft complete. Confirmation code: '
                      '${_buildConfirmationCode()}'
                  : 'Complete all three pickers to confirm your booking.',
              style: TextStyle(
                color: _allResolved ? Colors.white : _kInkIndigo,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (_allResolved)
            FilledButton.icon(
              onPressed: () {
                debugPrint('Booking confirmed — ${_buildConfirmationCode()}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: _kDeepSky,
                    content: Text(
                      'Booking confirmed: '
                      '${_buildConfirmationCode()}',
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: _kGold,
                foregroundColor: _kInkIndigo,
              ),
              icon: const Icon(Icons.send),
              label: const Text('Confirm'),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Supporting types for history entries and step descriptors.
// ---------------------------------------------------------------------------
enum _WizardStage { destination, passengers, cabin }

class _DecisionEntry {
  const _DecisionEntry({
    required this.stage,
    required this.value,
    required this.when,
  });
  final _WizardStage stage;
  final String value;
  final DateTime when;
}

class _StepDescriptor {
  const _StepDescriptor({
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final String? value;
  final IconData icon;
}

// ---------------------------------------------------------------------------
// Destination picker — 2×3 grid of city cards using gradient headers. Pops
// the city name back on tap.
// ---------------------------------------------------------------------------
class DestinationPickerPage extends StatelessWidget {
  const DestinationPickerPage({super.key});

  static const List<_CityCard> _cities = <_CityCard>[
    _CityCard(
      name: 'Tokyo',
      tagline: 'Night-neon capital of Japan',
      icon: Icons.park,
      gradient: <Color>[Color(0xFFB71C1C), Color(0xFFEF5350)],
    ),
    _CityCard(
      name: 'Paris',
      tagline: 'City of light and pastries',
      icon: Icons.tour,
      gradient: <Color>[Color(0xFF1A237E), Color(0xFF5E35B1)],
    ),
    _CityCard(
      name: 'Reykjavik',
      tagline: 'Volcanic shores & aurora skies',
      icon: Icons.ac_unit,
      gradient: <Color>[Color(0xFF01579B), Color(0xFF4FC3F7)],
    ),
    _CityCard(
      name: 'Cairo',
      tagline: 'Pyramids & timeless Nile',
      icon: Icons.account_balance,
      gradient: <Color>[Color(0xFF4E342E), Color(0xFFBCAAA4)],
    ),
    _CityCard(
      name: 'Rio',
      tagline: 'Rainforest meets Atlantic coastline',
      icon: Icons.beach_access,
      gradient: <Color>[Color(0xFF00695C), Color(0xFF4DB6AC)],
    ),
    _CityCard(
      name: 'Sydney',
      tagline: 'Harbour city of opera sails',
      icon: Icons.sailing,
      gradient: <Color>[Color(0xFF0277BD), Color(0xFF81D4FA)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kTicketPaper,
      appBar: AppBar(
        backgroundColor: _kInkIndigo,
        foregroundColor: Colors.white,
        title: const Text('Pick your destination'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Where to?',
                style: TextStyle(
                  color: _kInkIndigo,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Tap a card to pop the selection back into the wizard.',
                style: TextStyle(color: _kInkMuted),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext ctx, BoxConstraints constraints) {
                    final int crossAxis = constraints.maxWidth > 700 ? 3 : 2;
                    return GridView.builder(
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxis,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: _cities.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        final _CityCard city = _cities[index];
                        return _DestinationTile(
                          city: city,
                          onTap: () {
                            debugPrint(
                              'DestinationPickerPage popping "${city.name}"',
                            );
                            Navigator.of(context).pop<String>(city.name);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CityCard {
  const _CityCard({
    required this.name,
    required this.tagline,
    required this.icon,
    required this.gradient,
  });
  final String name;
  final String tagline;
  final IconData icon;
  final List<Color> gradient;
}

class _DestinationTile extends StatelessWidget {
  const _DestinationTile({
    required this.city,
    required this.onTap,
  });
  final _CityCard city;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kInkIndigo.withValues(alpha: 0.18),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: city.gradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          right: -14,
                          top: -14,
                          child: Icon(
                            city.icon,
                            size: 110,
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                city.icon,
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                city.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          city.tagline,
                          style: const TextStyle(
                            color: _kInkMuted,
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                'Select',
                                style: TextStyle(
                                  color: _kDeepSky,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: _kDeepSky,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Passenger count picker — central giant number with ± steppers, bounded 1–6.
// ---------------------------------------------------------------------------
class PassengerCountPage extends StatefulWidget {
  const PassengerCountPage({super.key});

  @override
  State<PassengerCountPage> createState() => _PassengerCountPageState();
}

class _PassengerCountPageState extends State<PassengerCountPage> {
  int _count = 1;

  void _increment() {
    setState(() {
      if (_count < 6) _count++;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 1) _count--;
    });
  }

  void _confirm() {
    debugPrint('PassengerCountPage popping $_count');
    Navigator.of(context).pop<int>(_count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kTicketPaper,
      appBar: AppBar(
        backgroundColor: _kInkIndigo,
        foregroundColor: Colors.white,
        title: const Text('How many passengers?'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Choose a group size',
                style: TextStyle(
                  color: _kInkIndigo,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Bounded between 1 and 6 passengers.',
                style: TextStyle(color: _kInkMuted),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 48,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: _kInkIndigo.withValues(alpha: 0.15),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _buildStepperButton(
                          icon: Icons.remove,
                          onPressed: _count > 1 ? _decrement : null,
                        ),
                        const SizedBox(width: 28),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              _count.toString(),
                              style: const TextStyle(
                                color: _kInkIndigo,
                                fontSize: 110,
                                fontWeight: FontWeight.w900,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _count == 1 ? 'passenger' : 'passengers',
                              style: const TextStyle(
                                color: _kInkMuted,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 28),
                        _buildStepperButton(
                          icon: Icons.add,
                          onPressed: _count < 6 ? _increment : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildPaxHintStrip(),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _confirm,
                icon: const Icon(Icons.check_circle_outline),
                label: Text(
                  'Confirm $_count passenger${_count == 1 ? '' : 's'}',
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: _kDeepSky,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepperButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    final bool enabled = onPressed != null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: enabled
                ? _kInkIndigo
                : _kInkIndigo.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(32),
            boxShadow: enabled
                ? <BoxShadow>[
                    BoxShadow(
                      color: _kInkIndigo.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : <BoxShadow>[],
          ),
          child: Icon(
            icon,
            color: enabled ? Colors.white : _kInkIndigo,
            size: 34,
          ),
        ),
      ),
    );
  }

  Widget _buildPaxHintStrip() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kDeepSky.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.info_outline, color: _kDeepSky),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _hintForCount(_count),
              style: const TextStyle(color: _kInkIndigo),
            ),
          ),
        ],
      ),
    );
  }

  String _hintForCount(int count) {
    if (count == 1) return 'Solo traveller — single-seat assignment.';
    if (count <= 3) return 'Small group — we try to seat you together.';
    if (count <= 5) {
      return 'Medium group — rows across the aisle may be assigned.';
    }
    return 'Large group — premium-row configuration recommended.';
  }
}

// ---------------------------------------------------------------------------
// Class picker — three stacked elegant cards with icons and Select buttons.
// ---------------------------------------------------------------------------
class ClassPickerPage extends StatelessWidget {
  const ClassPickerPage({super.key});

  static const List<_CabinOption> _cabins = <_CabinOption>[
    _CabinOption(
      key: 'economy',
      title: 'Economy',
      description:
          'Smart value — reclining seats, in-flight entertainment, and '
          'complimentary snack service. Best for short and medium haul.',
      icon: Icons.airline_seat_recline_normal,
      accent: _kDeepSky,
    ),
    _CabinOption(
      key: 'business',
      title: 'Business',
      description:
          'Lie-flat seats, chef-designed menu, priority boarding, and '
          'lounge access at participating hubs.',
      icon: Icons.airline_seat_recline_extra,
      accent: _kMidIndigo,
    ),
    _CabinOption(
      key: 'first',
      title: 'First',
      description:
          'Private suites, on-board shower (select aircraft), dedicated '
          'concierge, and chauffeur transfer in most cities.',
      icon: Icons.star,
      accent: _kGold,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kTicketPaper,
      appBar: AppBar(
        backgroundColor: _kInkIndigo,
        foregroundColor: Colors.white,
        title: const Text('Pick your cabin class'),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: _cabins.length,
          separatorBuilder: (BuildContext _, int _) =>
              const SizedBox(height: 16),
          itemBuilder: (BuildContext ctx, int index) {
            final _CabinOption cabin = _cabins[index];
            return _CabinCard(
              cabin: cabin,
              onSelect: () {
                debugPrint('ClassPickerPage popping "${cabin.key}"');
                Navigator.of(context).pop<String>(cabin.key);
              },
            );
          },
        ),
      ),
    );
  }
}

class _CabinOption {
  const _CabinOption({
    required this.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.accent,
  });
  final String key;
  final String title;
  final String description;
  final IconData icon;
  final Color accent;
}

class _CabinCard extends StatelessWidget {
  const _CabinCard({
    required this.cabin,
    required this.onSelect,
  });
  final _CabinOption cabin;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: cabin.accent.withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 120,
              height: 160,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    cabin.accent,
                    cabin.accent.withValues(alpha: 0.65),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(
                cabin.icon,
                color: Colors.white,
                size: 54,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cabin.title,
                      style: const TextStyle(
                        color: _kInkIndigo,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cabin.description,
                      style: const TextStyle(
                        color: _kInkMuted,
                        height: 1.35,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton.icon(
                        onPressed: onSelect,
                        style: FilledButton.styleFrom(
                          backgroundColor: cabin.accent,
                          foregroundColor: cabin.accent == _kGold
                              ? _kInkIndigo
                              : Colors.white,
                        ),
                        icon: const Icon(Icons.check),
                        label: const Text('Select'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Safety net for unknown routes — shouldn't fire in the demo, but keeps
// Navigator happy if a restoration bucket references something we removed.
// ---------------------------------------------------------------------------
class _UnknownRoutePage extends StatelessWidget {
  const _UnknownRoutePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kTicketPaper,
      appBar: AppBar(
        backgroundColor: _kInkIndigo,
        foregroundColor: Colors.white,
        title: const Text('Unknown route'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.error_outline,
                color: _kInkIndigo,
                size: 48,
              ),
              const SizedBox(height: 12),
              const Text(
                'This route is not registered in onGenerateRoute.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kInkIndigo),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
