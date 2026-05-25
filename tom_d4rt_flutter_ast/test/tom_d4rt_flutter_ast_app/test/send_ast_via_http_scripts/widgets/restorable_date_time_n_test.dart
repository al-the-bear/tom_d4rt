import 'package:flutter/material.dart';

// =============================================================================
// RestorableDateTimeN — Deep Visual Demo: "Optional Deadline Tracker"
// =============================================================================
//
// `RestorableDateTimeN` is a `RestorableProperty<DateTime?>` that stores a
// nullable DateTime across a widget's state restoration lifecycle. The `N`
// suffix stands for "nullable" — its sibling `RestorableDateTime` requires a
// non-null value and therefore cannot represent the "not set yet" state.
//
// This demo is organized around ONE StatefulWidget using `RestorationMixin`
// that owns several `RestorableDateTimeN` fields. Each scenario visually
// contrasts the two possible states of the property:
//
//     value == null          — "not yet provided" / "optional" / "cleared"
//     value is DateTime      — "set" / "scheduled" / "active"
//
// Why `RestorableDateTimeN` rather than `RestorableDateTime`?
//
//   - Many domain concepts are genuinely optional: a task MAY have a deadline,
//     a user MAY have logged in previously, a reminder MAY be configured.
//   - The null state carries meaning distinct from "epoch zero" — using a
//     sentinel DateTime like `DateTime.fromMillisecondsSinceEpoch(0)` hides
//     intent and leaks into countdown math.
//   - `RestorableDateTimeN.value` is `DateTime?`. The restoration bucket
//     persists either a millisecond timestamp (int) or a null marker and
//     faithfully rebuilds that nullable value on cold restart.
//
// Real wiring pattern used throughout this file:
//
//     final RestorableDateTimeN _deadline = RestorableDateTimeN(null);
//
//     @override
//     String? get restorationId => 'deadline_tracker_demo';
//
//     @override
//     void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//       registerForRestoration(_deadline, 'deadline');
//     }
//
//     @override
//     void dispose() {
//       _deadline.dispose();
//       super.dispose();
//     }
//
// =============================================================================

dynamic build(BuildContext context) {
  debugPrint('[RestorableDateTimeN demo] Building...');
  return MaterialApp(
    title: 'RestorableDateTimeN Deep Demo',
    theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
    restorationScopeId: 'restorable_date_time_n_demo',
    home: const DeadlineTrackerDemo(),
  );
}

// -----------------------------------------------------------------------------
// DeadlineTrackerDemo
// -----------------------------------------------------------------------------
// A single stateful widget that demonstrates RestorableDateTimeN across five
// very different visual scenarios. Each RestorableDateTimeN field below is
// registered in `restoreState` with a unique bucket key, so the nullable
// DateTime value of each is independently preserved.
// -----------------------------------------------------------------------------

class DeadlineTrackerDemo extends StatefulWidget {
  const DeadlineTrackerDemo({super.key});

  @override
  State<DeadlineTrackerDemo> createState() => _DeadlineTrackerDemoState();
}

class _DeadlineTrackerDemoState extends State<DeadlineTrackerDemo>
    with RestorationMixin {
  // ---------------------------------------------------------------------------
  // Fixed "today" anchor. Using a hard-coded DateTime (instead of
  // DateTime.now()) keeps the demo deterministic across test runs — every
  // rebuild produces the same "in N days" chips, the same ordering, and the
  // same golden output. This is important because the D4rt interpreter
  // evaluates this script in a sandboxed context where wall-clock drift would
  // make visual output non-reproducible.
  // ---------------------------------------------------------------------------
  static final DateTime _anchorToday = DateTime(2026, 4, 23);

  // ---------------------------------------------------------------------------
  // Scenario 1: Task list
  //
  // Each task owns its own RestorableDateTimeN. Some are set to concrete
  // DateTime values, others are null to represent "no deadline". The list UX
  // directly depends on this duality: null tasks render a grey "∞ no deadline"
  // pill while set tasks render a red/amber/green countdown chip.
  //
  // Notice how the nullable type is load-bearing here — we never need a
  // sentinel date, and the "no deadline" state survives hot restart just like
  // any real date would.
  // ---------------------------------------------------------------------------
  final RestorableDateTimeN _taskPresentation =
      RestorableDateTimeN(DateTime(2026, 4, 26));
  final RestorableDateTimeN _taskRent =
      RestorableDateTimeN(DateTime(2026, 5, 3));
  final RestorableDateTimeN _taskCallMom = RestorableDateTimeN(null);
  final RestorableDateTimeN _taskGroceries =
      RestorableDateTimeN(DateTime(2026, 4, 24));
  final RestorableDateTimeN _taskLearnRust = RestorableDateTimeN(null);

  // ---------------------------------------------------------------------------
  // Scenario 2: Birthday reminder form
  //
  // A single optional DateTime. The UX flips between two completely different
  // visual states — a festive pastel card when set, a dashed grey placeholder
  // when null. This is the canonical "RestorableDateTimeN makes sense here"
  // case: the property is genuinely optional.
  // ---------------------------------------------------------------------------
  final RestorableDateTimeN _birthdayReminder = RestorableDateTimeN(null);

  // ---------------------------------------------------------------------------
  // Scenario 3: Last login indicator
  //
  // The null state means "never logged in before" — a first-run experience.
  // Using RestorableDateTime (non-null) here would be wrong because there is
  // no sensible default that represents "never". The restoration bucket can
  // faithfully persist the null across process restarts.
  // ---------------------------------------------------------------------------
  final RestorableDateTimeN _lastLogin = RestorableDateTimeN(null);

  // ---------------------------------------------------------------------------
  // Scenario 4: Weekly meal reminders
  //
  // Seven independent RestorableDateTimeN instances — one per weekday — each
  // tracking an optional reminder time. Mon/Wed/Fri are pre-populated;
  // Tue/Thu/Sat/Sun start as null to showcase the 7-card null/set mix.
  // ---------------------------------------------------------------------------
  final RestorableDateTimeN _mealMon =
      RestorableDateTimeN(DateTime(2026, 4, 23, 8, 0));
  final RestorableDateTimeN _mealTue = RestorableDateTimeN(null);
  final RestorableDateTimeN _mealWed =
      RestorableDateTimeN(DateTime(2026, 4, 23, 12, 30));
  final RestorableDateTimeN _mealThu = RestorableDateTimeN(null);
  final RestorableDateTimeN _mealFri =
      RestorableDateTimeN(DateTime(2026, 4, 23, 19, 15));
  final RestorableDateTimeN _mealSat = RestorableDateTimeN(null);
  final RestorableDateTimeN _mealSun = RestorableDateTimeN(null);

  // ---------------------------------------------------------------------------
  // Scenario 5: Teaching-panel anchors
  //
  // These two values are used by the state-transition diagram to illustrate
  // what the property holds at different points in its lifecycle. They are not
  // mutated by this demo; they exist as snapshots of "before" and "after"
  // restoration states the user might observe in the devtools inspector.
  // ---------------------------------------------------------------------------
  final RestorableDateTimeN _teachingSnapshotSet =
      RestorableDateTimeN(DateTime(2026, 6, 1, 14, 0));
  final RestorableDateTimeN _teachingSnapshotNull = RestorableDateTimeN(null);

  // ---------------------------------------------------------------------------
  // RestorationMixin hookup
  //
  // `restorationId` identifies this widget's restoration bucket inside the
  // enclosing RestorationScope. If null, restoration is silently disabled for
  // this subtree — a common footgun. We use a stable, descriptive id.
  //
  // `restoreState` is called once when the bucket becomes available, and again
  // whenever the bucket is replaced. `registerForRestoration` wires each
  // property to a unique key inside the bucket. The framework writes the
  // serialized value (millisecond timestamp or null) under that key and reads
  // it back on cold start.
  // ---------------------------------------------------------------------------
  @override
  String? get restorationId => 'deadline_tracker_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_taskPresentation, 'task_presentation');
    registerForRestoration(_taskRent, 'task_rent');
    registerForRestoration(_taskCallMom, 'task_call_mom');
    registerForRestoration(_taskGroceries, 'task_groceries');
    registerForRestoration(_taskLearnRust, 'task_learn_rust');

    registerForRestoration(_birthdayReminder, 'birthday_reminder');
    registerForRestoration(_lastLogin, 'last_login');

    registerForRestoration(_mealMon, 'meal_mon');
    registerForRestoration(_mealTue, 'meal_tue');
    registerForRestoration(_mealWed, 'meal_wed');
    registerForRestoration(_mealThu, 'meal_thu');
    registerForRestoration(_mealFri, 'meal_fri');
    registerForRestoration(_mealSat, 'meal_sat');
    registerForRestoration(_mealSun, 'meal_sun');

    registerForRestoration(_teachingSnapshotSet, 'teaching_set');
    registerForRestoration(_teachingSnapshotNull, 'teaching_null');
  }

  @override
  void dispose() {
    // Every RestorableProperty must be disposed — otherwise the bucket keeps
    // a reference and the property leaks across widget rebuilds.
    _taskPresentation.dispose();
    _taskRent.dispose();
    _taskCallMom.dispose();
    _taskGroceries.dispose();
    _taskLearnRust.dispose();

    _birthdayReminder.dispose();
    _lastLogin.dispose();

    _mealMon.dispose();
    _mealTue.dispose();
    _mealWed.dispose();
    _mealThu.dispose();
    _mealFri.dispose();
    _mealSat.dispose();
    _mealSun.dispose();

    _teachingSnapshotSet.dispose();
    _teachingSnapshotNull.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Formatting helpers — no package:intl dependency.
  // ---------------------------------------------------------------------------

  String _formatDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final w = weekdays[d.weekday - 1];
    final m = months[d.month - 1];
    return '$w, $m ${d.day}, ${d.year}';
  }

  String _formatTime(DateTime d) {
    final h24 = d.hour;
    final suffix = h24 >= 12 ? 'PM' : 'AM';
    var h12 = h24 % 12;
    if (h12 == 0) h12 = 12;
    final mm = d.minute.toString().padLeft(2, '0');
    return '$h12:$mm $suffix';
  }

  String? _countdownText(DateTime? target, DateTime anchor) {
    if (target == null) return null;
    final a = DateTime(anchor.year, anchor.month, anchor.day);
    final t = DateTime(target.year, target.month, target.day);
    final diff = t.difference(a).inDays;
    if (diff < 0) return 'overdue by ${-diff} days';
    if (diff == 0) return 'today';
    if (diff == 1) return 'tomorrow';
    return 'in $diff days';
  }

  // Color-codes urgency for the task list leading icon.
  Color _urgencyColor(DateTime? target, DateTime anchor) {
    if (target == null) return Colors.grey.shade400;
    final a = DateTime(anchor.year, anchor.month, anchor.day);
    final t = DateTime(target.year, target.month, target.day);
    final diff = t.difference(a).inDays;
    if (diff < 0) return Colors.red.shade600;
    if (diff <= 2) return Colors.amber.shade700;
    if (diff <= 7) return Colors.lightGreen.shade700;
    return Colors.green.shade700;
  }

  // ===========================================================================
  // SCENARIO 1 — Task list with mixed items
  // ===========================================================================
  //
  // Dense list rendering. Each row's subtitle is driven entirely by whether
  // the underlying RestorableDateTimeN.value is null. Null rows receive a
  // grey "∞ no deadline" pill; set rows get a colored countdown chip whose
  // tone reflects urgency.
  // ===========================================================================

  Widget _buildTaskListSection(BuildContext context) {
    final tasks = <_TaskRow>[
      _TaskRow('Finish presentation slides', _taskPresentation.value,
          Icons.slideshow),
      _TaskRow('Pay rent', _taskRent.value, Icons.home_work_outlined),
      _TaskRow('Call mom', _taskCallMom.value, Icons.phone_outlined),
      _TaskRow('Buy groceries', _taskGroceries.value,
          Icons.shopping_basket_outlined),
      _TaskRow('Learn Rust', _taskLearnRust.value, Icons.memory_outlined),
    ];

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal.shade600,
                  Colors.teal.shade400,
                ],
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.task_alt, color: Colors.white),
                const SizedBox(width: 10),
                const Text(
                  'Scenario 1 — Task list with optional deadlines',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'RestorableDateTimeN × 5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Each task row's subtitle branches on `value == null`.
          for (int i = 0; i < tasks.length; i++)
            _buildTaskTile(tasks[i], isLast: i == tasks.length - 1),
        ],
      ),
    );
  }

  Widget _buildTaskTile(_TaskRow row, {required bool isLast}) {
    final countdown = _countdownText(row.deadline, _anchorToday);
    final color = _urgencyColor(row.deadline, _anchorToday);
    final hasDeadline = row.deadline != null;

    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(row.icon, color: color, size: 22),
        ),
        title: Text(
          row.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: hasDeadline
              ? Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: color.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        countdown ?? '',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(row.deadline!),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.all_inclusive,
                          size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 6),
                      Text(
                        'no deadline',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        trailing: hasDeadline
            ? Icon(Icons.event, color: color, size: 20)
            : Icon(Icons.event_busy, color: Colors.grey.shade400, size: 20),
      ),
    );
  }

  // ===========================================================================
  // SCENARIO 2 — Birthday reminder form (hero card)
  // ===========================================================================
  //
  // Shows the full set/null flip. The card's background gradient, border,
  // icon treatment, and call-to-action all change based on whether the single
  // RestorableDateTimeN carries a value.
  // ===========================================================================

  Widget _buildBirthdayFormSection(BuildContext context) {
    final value = _birthdayReminder.value;
    final isSet = value != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: isSet
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFE4F0),
                    Color(0xFFFFF5E1),
                    Color(0xFFE8F0FF),
                  ],
                )
              : LinearGradient(
                  colors: [
                    Colors.grey.shade100,
                    Colors.grey.shade200,
                  ],
                ),
          border: isSet
              ? Border.all(color: Colors.pink.shade200, width: 1.2)
              : Border.all(
                  color: Colors.grey.shade400,
                  width: 1.4,
                  style: BorderStyle.solid,
                ),
          boxShadow: isSet
              ? [
                  BoxShadow(
                    color: Colors.pink.shade100.withValues(alpha: 0.6),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSet
                        ? Colors.pink.shade100
                        : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSet ? Icons.cake : Icons.event_note_outlined,
                    color: isSet ? Colors.pink.shade700 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Scenario 2 — Optional Birthday Reminder',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Branching UI: set-state vs. null-state.
            if (isSet)
              _buildBirthdaySetState(value)
            else
              _buildBirthdayNullState(),
            const SizedBox(height: 14),
            // Teaching line: makes the property's value explicit.
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.code, size: 16, color: Colors.grey.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isSet
                          ? '_birthdayReminder.value == ${value.toIso8601String()}'
                          : '_birthdayReminder.value == null',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: Colors.grey.shade800,
                      ),
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

  Widget _buildBirthdaySetState(DateTime value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.card_giftcard,
                size: 36, color: Colors.pink.shade600),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDate(value),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.pink.shade800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _countdownText(value, _anchorToday) ?? '',
                    style: TextStyle(
                      color: Colors.pink.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.clear),
            label: const Text('Clear reminder'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.pink.shade700,
              side: BorderSide(color: Colors.pink.shade300),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBirthdayNullState() {
    return DottedBorderBox(
      color: Colors.grey.shade500,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        child: Column(
          children: [
            Icon(Icons.add_circle_outline,
                size: 34, color: Colors.grey.shade600),
            const SizedBox(height: 8),
            Text(
              '+ Add optional reminder',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'This field is nullable — leaving it empty is perfectly valid.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            FilledButton.tonalIcon(
              onPressed: () {},
              icon: const Icon(Icons.event_available),
              label: const Text('Set to May 15'),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SCENARIO 3 — Last login indicator (monochrome vs. color)
  // ===========================================================================
  //
  // Every visual token in this card switches on the null-ness of _lastLogin:
  // icon, color, typography, shadow, and accompanying microcopy.
  // ===========================================================================

  Widget _buildSessionCardSection(BuildContext context) {
    final login = _lastLogin.value;
    final isSet = login != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // Cluster I TODO #16 fix: `crossAxisAlignment: CrossAxisAlignment.stretch`
      // on a Row whose parent gives unbounded vertical extent (this widget
      // is nested in SingleChildScrollView → Column) propagates infinite
      // height into the Expanded > Container > BoxDecoration chain, which
      // fails RenderDecoratedBox's layout assertion. The session card has
      // a single child whose width is already controlled by Expanded; we
      // don't actually need cross-axis stretching here. Default
      // `CrossAxisAlignment.center` lets the Container size to its
      // children's intrinsic height.
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isSet ? Colors.blue.shade50 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color:
                      isSet ? Colors.blue.shade300 : Colors.grey.shade300,
                  width: 1.1,
                ),
                boxShadow: isSet
                    ? [
                        BoxShadow(
                          color: Colors.blue.shade200
                              .withValues(alpha: 0.4),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Scenario 3 — Last login',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: isSet
                              ? Colors.blue.shade900
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSet
                              ? Colors.blue.shade600
                              : Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isSet ? Icons.access_time_filled : Icons.lock,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isSet ? 'Welcome back' : 'Never logged in',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: isSet
                                    ? Colors.blue.shade900
                                    : Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isSet
                                  ? '${_formatDate(login)} • ${_formatTime(login)}'
                                  : 'This device has no prior session.',
                              style: TextStyle(
                                color: isSet
                                    ? Colors.blue.shade700
                                    : Colors.grey.shade500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.login, size: 18),
                        label: const Text('Simulate login'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.clear, size: 18),
                        label: const Text('Clear'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Restoration bucket peek.
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isSet
                          ? 'bucket["last_login"] = ${login.millisecondsSinceEpoch}  // int'
                          : 'bucket["last_login"] = null  // preserved across restart',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
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

  // ===========================================================================
  // SCENARIO 4 — Weekly meal reminders (7-column row)
  // ===========================================================================
  //
  // Seven independent RestorableDateTimeN cards in a scrollable row. Each
  // card reflects the null-versus-set axis with opacity, color, and CTA.
  // ===========================================================================

  Widget _buildMealPlannerSection(BuildContext context) {
    final days = <_MealDay>[
      _MealDay('Mon', _mealMon.value, Icons.wb_sunny_outlined),
      _MealDay('Tue', _mealTue.value, Icons.ramen_dining_outlined),
      _MealDay('Wed', _mealWed.value, Icons.lunch_dining_outlined),
      _MealDay('Thu', _mealThu.value, Icons.local_dining_outlined),
      _MealDay('Fri', _mealFri.value, Icons.dinner_dining_outlined),
      _MealDay('Sat', _mealSat.value, Icons.bakery_dining_outlined),
      _MealDay('Sun', _mealSun.value, Icons.brunch_dining_outlined),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.deepPurple.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.restaurant_menu,
                    color: Colors.deepPurple.shade700),
                const SizedBox(width: 10),
                Text(
                  'Scenario 4 — Weekly meal reminders',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '7 RestorableDateTimeN fields — one per weekday. '
              'Tuesday, Thursday, Saturday and Sunday start as null.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 14),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final day in days) _buildMealCard(day),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(_MealDay day) {
    final isSet = day.time != null;
    return Container(
      width: 110,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSet ? Colors.white : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSet ? Colors.deepPurple.shade200 : Colors.grey.shade300,
          width: 1.2,
        ),
        boxShadow: isSet
            ? [
                BoxShadow(
                  color: Colors.deepPurple.shade100
                      .withValues(alpha: 0.45),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Opacity(
        opacity: isSet ? 1.0 : 0.55,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: isSet
                            ? Colors.deepPurple.shade800
                            : Colors.grey.shade600,
                      ),
                    ),
                    Icon(
                      day.icon,
                      size: 20,
                      color: isSet
                          ? Colors.deepPurple.shade400
                          : Colors.grey.shade400,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isSet)
                      Text(
                        _formatTime(day.time!),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Colors.deepPurple.shade900,
                        ),
                      )
                    else
                      Text(
                        '—',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      isSet ? 'reminder' : '+ add reminder',
                      style: TextStyle(
                        fontSize: 11,
                        color: isSet
                            ? Colors.deepPurple.shade500
                            : Colors.grey.shade600,
                        fontStyle: isSet
                            ? FontStyle.normal
                            : FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (isSet)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.green.shade500,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SCENARIO 5 — State transition teaching flowchart
  // ===========================================================================
  //
  // Visually traces the lifecycle null → set → null → set and follows with a
  // three-row explanatory panel about when to prefer RestorableDateTimeN over
  // RestorableDateTime, and how the restoration bucket stores each state.
  // ===========================================================================

  Widget _buildTeachingSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo.shade50,
              Colors.cyan.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.indigo.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.school, color: Colors.indigo.shade700),
                const SizedBox(width: 10),
                Text(
                  'Scenario 5 — Lifecycle of a nullable DateTime',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.indigo.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildStateFlow(),
            const SizedBox(height: 22),
            _buildTeachingRow(
              icon: Icons.help_outline,
              color: Colors.indigo.shade400,
              title: 'Why nullable?',
              body:
                  'RestorableDateTimeN.value is DateTime? — null is a first-class '
                  'value representing "not yet provided". '
                  'RestorableDateTime requires an initial non-null DateTime, so '
                  'you would have to invent a sentinel (epoch-zero, year 9999) '
                  'and audit every read site. Prefer the nullable variant when '
                  'the property is genuinely optional.',
            ),
            const SizedBox(height: 12),
            _buildTeachingRow(
              icon: Icons.recommend_outlined,
              color: Colors.teal.shade400,
              title: 'When to reach for it',
              body:
                  'Optional deadlines, "maybe-later" prompts, lazy metadata like '
                  'last-viewed-at, first-login timestamps, optional reminder '
                  'slots, and anything that starts life with no known value.',
            ),
            const SizedBox(height: 12),
            _buildTeachingRow(
              icon: Icons.archive_outlined,
              color: Colors.orange.shade400,
              title: 'How restoration works',
              body:
                  'On `registerForRestoration`, the framework reads the bucket '
                  'slot. If it holds an int, the property rebuilds that '
                  'DateTime via millisecondsSinceEpoch. If it holds null, the '
                  'property faithfully re-enters the null state — "not set" '
                  'survives cold restart just like any real timestamp.',
            ),
            const SizedBox(height: 18),
            _buildBucketDiagram(),
          ],
        ),
      ),
    );
  }

  Widget _buildStateFlow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _flowNode(
            label: 'A',
            caption: 'null',
            isNull: true,
          ),
          _flowArrow('setState()\npicks date'),
          _flowNode(
            label: 'B',
            caption: _formatDate(_teachingSnapshotSet.value!),
            isNull: false,
          ),
          _flowArrow('user clears'),
          _flowNode(
            label: 'C',
            caption: 'null',
            isNull: true,
          ),
          _flowArrow('setState()\nnew date'),
          _flowNode(
            label: 'D',
            caption: 'DateTime(2027,1,1)',
            isNull: false,
          ),
        ],
      ),
    );
  }

  Widget _flowNode({
    required String label,
    required String caption,
    required bool isNull,
  }) {
    return Column(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isNull ? Colors.grey.shade300 : Colors.blue.shade500,
            boxShadow: isNull
                ? null
                : [
                    BoxShadow(
                      color: Colors.blue.shade300.withValues(alpha: 0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
            border: Border.all(
              color: isNull ? Colors.grey.shade500 : Colors.blue.shade700,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              isNull ? '∅' : '📅',
              style: TextStyle(
                fontSize: isNull ? 28 : 22,
                color: isNull ? Colors.grey.shade700 : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 110,
          child: Text(
            caption,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: isNull ? Colors.grey.shade700 : Colors.blue.shade800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }

  Widget _flowArrow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Icon(Icons.arrow_forward_rounded,
              color: Colors.indigo.shade400, size: 28),
          const SizedBox(height: 4),
          SizedBox(
            width: 80,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.indigo.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachingRow({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade800,
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

  // Shows a miniature RestorationBucket with two adjacent slots — one storing
  // a millisecond timestamp (set case), one storing a null marker (null case).
  Widget _buildBucketDiagram() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.inventory_2_outlined,
                  color: Colors.indigo.shade600, size: 18),
              const SizedBox(width: 8),
              Text(
                'Restoration bucket — live view',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.indigo.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _bucketSlot(
                  label: 'teaching_set',
                  value:
                      '${_teachingSnapshotSet.value!.millisecondsSinceEpoch}',
                  isNull: false,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _bucketSlot(
                  label: 'teaching_null',
                  value: 'null',
                  isNull: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Each slot is keyed by the string passed to registerForRestoration. '
            'The framework serializes RestorableDateTimeN.value as int? — '
            'preserving the null marker verbatim on cold restart.',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bucketSlot({
    required String label,
    required String value,
    required bool isNull,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isNull ? Colors.grey.shade100 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
              isNull ? Colors.grey.shade400 : Colors.blue.shade300,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isNull ? Icons.circle_outlined : Icons.circle,
                size: 12,
                color:
                    isNull ? Colors.grey.shade500 : Colors.blue.shade600,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isNull ? Colors.grey.shade600 : Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isNull ? 'DateTime? == null' : 'DateTime? == set',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Assembled scaffold.
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestorableDateTimeN — Optional Deadlines'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        restorationId: 'scroll_view',
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildIntroBanner(context),
            _buildTaskListSection(context),
            _buildBirthdayFormSection(context),
            _buildSessionCardSection(context),
            _buildMealPlannerSection(context),
            _buildTeachingSection(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal.shade700,
            Colors.cyan.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.event_available, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'RestorableDateTimeN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'nullable',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'A RestorableProperty<DateTime?> — stores an optional timestamp '
            'across state restoration. Five scenarios below explore the '
            'null-versus-set duality from multiple angles: dense task list, '
            'hero form, monochrome session card, weekly row, and lifecycle '
            'flowchart.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Supporting types
// =============================================================================

class _TaskRow {
  final String title;
  final DateTime? deadline;
  final IconData icon;
  const _TaskRow(this.title, this.deadline, this.icon);
}

class _MealDay {
  final String label;
  final DateTime? time;
  final IconData icon;
  const _MealDay(this.label, this.time, this.icon);
}

// A lightweight dashed-border wrapper for the null-state birthday placeholder.
// Avoids pulling in a third-party dotted-border package and keeps the
// null-state visual distinct from any other card in the demo.
class DottedBorderBox extends StatelessWidget {
  final Widget child;
  final Color color;
  const DottedBorderBox({
    super.key,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: color),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final radius = Radius.circular(14.0);
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      radius,
    );
    // Approximate the rounded rectangle with a Path and draw dashes.
    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        final extract = metric.extractPath(
          distance,
          end > metric.length ? metric.length : end,
        );
        canvas.drawPath(extract, paint);
        distance = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color;
}
