import 'package:flutter/material.dart';

// D4RT-SCRIPT-LIMITATION: layout cascade (Fa1 EditableText pocket)
//
// Emits 3 FE: BoxConstraints negative-minimum-height on
// `_RenderEditableCustomPaint`, RenderBox-was-not-laid-out
// (`hasSize`), and the `!childSemantics.renderObject._needsLayout`
// race (object.dart:5737).
//
// The board-game session tracker contains a TextField for entering
// player names that, when laid out within the panel chrome, hits
// the same negative-minimum-height race as the other
// EditableText-pocket scripts.
//
// Closing route documented in interpreter_unfixable.md §Fa1-N1
// (EditableText sub-pocket). Deferred — same risk/reward profile
// as select_all_text_intent_test.dart and
// transpose_characters_intent_test.dart.
//
// Sentinel: test/fa1_bisect_test.dart [fa1-2250-sentinel].

// =============================================================================
// RestorationMixin deep-demo — Board Game Session tracker
// -----------------------------------------------------------------------------
// This file walks through the complete lifecycle of a StatefulWidget that
// participates in Flutter's state restoration subsystem by applying
// RestorationMixin<S extends StatefulWidget> to its State subclass.
//
// Concepts illustrated:
//   * restorationId              — identifies the scope of restorable data.
//   * restoreState               — the hook in which registerForRestoration
//                                  must be called for every RestorableProperty.
//   * didToggleBucket            — fires when the bucket becomes available
//                                  (or goes away), not just on the first run.
//   * didUpdateRestorationId     — a subclass calls this when its restorationId
//                                  value changes at runtime.
//   * registerForRestoration     — binds a RestorableProperty to a string key
//                                  within the active bucket.
//   * unregisterFromRestoration  — removes a property from the active bucket.
//   * bucket                     — the RestorationBucket inherited from the
//                                  enclosing RestorationScope, or null if no
//                                  scope is active.
//
// The UI is framed as a *board game session tracker* so that the restored
// fields have thematic meaning: the player name, the current turn counter,
// the last dice value, the score, whether a roll is in progress, and the
// timestamp of the last dice roll. Classic board-game box palette (forest
// green, cream, burnt red) is used deliberately to keep the demo visually
// distinct from other demos in this folder.
// =============================================================================

// -- Palette ------------------------------------------------------------------
const Color _forestGreen = Color(0xFF2D5A3D);
const Color _deepForest = Color(0xFF1B3A27);
const Color _mossGreen = Color(0xFF4F8A5F);
const Color _cream = Color(0xFFF5EDD6);
const Color _creamDeep = Color(0xFFE8DCB8);
const Color _burntRed = Color(0xFFB83A2E);
const Color _burntRedDark = Color(0xFF8A2A1F);
const Color _parchment = Color(0xFFFFF8E4);
const Color _charcoal = Color(0xFF2A2620);
const Color _slate = Color(0xFF4A4438);

// -- Top-level harness entry point -------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'RestorationMixin — Board Game Session',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: _forestGreen,
      scaffoldBackgroundColor: _parchment,
      fontFamily: 'serif',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _charcoal, fontSize: 14),
        titleMedium: TextStyle(color: _deepForest, fontWeight: FontWeight.w700),
      ),
      colorScheme: const ColorScheme.light(
        primary: _forestGreen,
        secondary: _burntRed,
        surface: _cream,
      ),
    ),
    home: const RootRestorationScope(
      restorationId: 'board_game_session_root',
      child: BoardGameSessionDemo(),
    ),
  );
}

// =============================================================================
// Main StatefulWidget
// =============================================================================
class BoardGameSessionDemo extends StatefulWidget {
  const BoardGameSessionDemo({super.key});

  @override
  State<BoardGameSessionDemo> createState() => _BoardGameSessionDemoState();
}

class _BoardGameSessionDemoState extends State<BoardGameSessionDemo>
    with RestorationMixin<BoardGameSessionDemo> {
  // ---------------------------------------------------------------------------
  // Restorable properties — these survive process restart when a bucket exists.
  // ---------------------------------------------------------------------------
  final RestorableInt _score = RestorableInt(0);
  final RestorableInt _currentTurn = RestorableInt(1);
  final RestorableInt _diceValue = RestorableInt(1);
  final RestorableString _playerName = RestorableString('Player 1');
  final RestorableBool _isRolling = RestorableBool(false);
  final RestorableDateTimeN _lastRollAt = RestorableDateTimeN(null);

  // Non-restorable working state.
  late TextEditingController _nameController;
  final List<int> _rollHistory = <int>[];
  final List<int> _scoreHistory = <int>[0];
  final List<_LifecycleLogEntry> _log = <_LifecycleLogEntry>[];
  bool _diceRegistered = true;

  // The overridden restorationId is *backed by a field* so that changing it at
  // runtime has a real effect. This is the pedagogical point of
  // didUpdateRestorationId — without a mutable id, the method never fires.
  String _restorationIdState = 'board_game_session_demo';

  // ---------------------------------------------------------------------------
  // RestorationMixin overrides
  // ---------------------------------------------------------------------------
  @override
  String? get restorationId => _restorationIdState;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    debugPrint(
      '[RestorationMixin] restoreState(initialRestore=$initialRestore, '
      'oldBucket=${oldBucket?.restorationId}) fired. This is where every '
      'RestorableProperty must be registered with registerForRestoration.',
    );
    registerForRestoration(_score, 'score');
    registerForRestoration(_currentTurn, 'current_turn');
    if (_diceRegistered) {
      registerForRestoration(_diceValue, 'dice');
    }
    registerForRestoration(_playerName, 'player_name');
    registerForRestoration(_isRolling, 'is_rolling');
    registerForRestoration(_lastRollAt, 'last_roll_at');

    // Keep the name controller in sync with the restored value.
    _nameController.text = _playerName.value;

    _log.add(
      _LifecycleLogEntry(
        DateTime.now(),
        'restoreState',
        'initialRestore=$initialRestore, oldBucket='
            '${oldBucket?.restorationId ?? "null"}',
      ),
    );
  }

  @override
  void didToggleBucket(RestorationBucket? oldBucket) {
    super.didToggleBucket(oldBucket);
    debugPrint(
      '[RestorationMixin] didToggleBucket(oldBucket='
      '${oldBucket?.restorationId}). A bucket just became available or '
      'disappeared. Useful for reacting to the restoration scope changing.',
    );
    _log.add(
      _LifecycleLogEntry(
        DateTime.now(),
        'didToggleBucket',
        'oldBucket=${oldBucket?.restorationId ?? "null"}, '
            'newBucket=${bucket?.restorationId ?? "null"}',
      ),
    );
  }

  @override
  void didUpdateRestorationId() {
    super.didUpdateRestorationId();
    debugPrint(
      '[RestorationMixin] didUpdateRestorationId() fired because the subclass '
      'called it to announce a runtime change to the restorationId getter.',
    );
    _log.add(
      _LifecycleLogEntry(
        DateTime.now(),
        'didUpdateRestorationId',
        'new restorationId=$_restorationIdState',
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // Use the literal default that matches RestorableString('Player 1') above.
    // Reading _playerName.value here (before registerForRestoration runs in
    // restoreState) trips the `isRegistered` assertion in plain Flutter too,
    // so this is the script-side fix, not an interpreter limitation.
    _nameController = TextEditingController(text: 'Player 1');
    _nameController.addListener(_onNameChanged);
    debugPrint(
      '[RestorationMixin] initState: created TextEditingController for the '
      'player name field.',
    );
    _log.add(
      _LifecycleLogEntry(
        DateTime.now(),
        'initState',
        'controller created',
      ),
    );
  }

  @override
  void dispose() {
    debugPrint(
      '[RestorationMixin] dispose: disposing RestorableProperty instances '
      'BEFORE super.dispose() so registrations are cleaned up correctly.',
    );
    _nameController.removeListener(_onNameChanged);
    _nameController.dispose();
    _score.dispose();
    _currentTurn.dispose();
    _diceValue.dispose();
    _playerName.dispose();
    _isRolling.dispose();
    _lastRollAt.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Handlers
  // ---------------------------------------------------------------------------
  void _onNameChanged() {
    final String next = _nameController.text;
    if (next == _playerName.value) {
      return;
    }
    setState(() {
      _playerName.value = next;
    });
  }

  void _rollDice() {
    if (_isRolling.value || !_diceRegistered) {
      return;
    }
    setState(() {
      _isRolling.value = true;
    });
    _animateRoll(0);
  }

  void _animateRoll(int tick) {
    if (!mounted) {
      return;
    }
    if (tick >= 5) {
      final int finalValue = _pseudoRandomDice(
        DateTime.now().millisecondsSinceEpoch + tick,
      );
      setState(() {
        _diceValue.value = finalValue;
        _isRolling.value = false;
        _lastRollAt.value = DateTime.now();
        _score.value = _score.value + finalValue;
        _currentTurn.value = _currentTurn.value + 1;
        _rollHistory.insert(0, finalValue);
        if (_rollHistory.length > 10) {
          _rollHistory.removeLast();
        }
        _scoreHistory.add(_score.value);
        if (_scoreHistory.length > 16) {
          _scoreHistory.removeAt(0);
        }
      });
      return;
    }
    Future<void>.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _diceValue.value = _pseudoRandomDice(
          DateTime.now().millisecondsSinceEpoch + tick,
        );
      });
      _animateRoll(tick + 1);
    });
  }

  int _pseudoRandomDice(int seed) {
    // Deterministic-ish jitter so the demo runs under the D4rt interpreter
    // without depending on dart:math.
    final int v = (seed ^ (seed >> 5) ^ (seed >> 13)) & 0x7fffffff;
    return (v % 6) + 1;
  }

  void _toggleRestorationId() {
    setState(() {
      if (_restorationIdState == 'board_game_session_demo') {
        _restorationIdState = 'board_game_session_demo_alt';
      } else {
        _restorationIdState = 'board_game_session_demo';
      }
    });
    didUpdateRestorationId();
  }

  void _unregisterDice() {
    if (!_diceRegistered) {
      return;
    }
    setState(() {
      unregisterFromRestoration(_diceValue);
      _diceRegistered = false;
      _log.add(
        _LifecycleLogEntry(
          DateTime.now(),
          'unregisterFromRestoration',
          'property=dice',
        ),
      );
    });
    debugPrint(
      '[RestorationMixin] unregisterFromRestoration(_diceValue): the dice '
      'property is no longer tracked; its value will not survive restore.',
    );
  }

  void _reregisterDice() {
    if (_diceRegistered) {
      return;
    }
    setState(() {
      registerForRestoration(_diceValue, 'dice');
      _diceRegistered = true;
      _log.add(
        _LifecycleLogEntry(
          DateTime.now(),
          'registerForRestoration',
          'property=dice (re-registered)',
        ),
      );
    });
    debugPrint(
      '[RestorationMixin] registerForRestoration(_diceValue, "dice"): the '
      'dice property is back under the current bucket.',
    );
  }

  void _resetSession() {
    setState(() {
      _score.value = 0;
      _currentTurn.value = 1;
      _diceValue.value = 1;
      _isRolling.value = false;
      _lastRollAt.value = null;
      _rollHistory.clear();
      _scoreHistory
        ..clear()
        ..add(0);
      _log.add(
        _LifecycleLogEntry(
          DateTime.now(),
          'manual reset',
          'score/turn/dice reset',
        ),
      );
    });
  }

  // ---------------------------------------------------------------------------
  // build
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _parchment,
      appBar: AppBar(
        backgroundColor: _deepForest,
        foregroundColor: _cream,
        elevation: 4,
        title: const Text(
          'RestorationMixin — Board Game Session',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Reset session',
            icon: const Icon(Icons.refresh),
            onPressed: _resetSession,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: <Widget>[
          _buildGameDashboard(),
          const SizedBox(height: 18),
          _buildScoreboard(),
          const SizedBox(height: 18),
          _buildBucketDiagnostics(),
          const SizedBox(height: 18),
          _buildLifecycleLog(),
          const SizedBox(height: 18),
          _buildTeachingPanel(),
          const SizedBox(height: 18),
          _buildFooter(),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1 — Game dashboard hero
  // ---------------------------------------------------------------------------
  Widget _buildGameDashboard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_forestGreen, _deepForest],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _charcoal.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: _mossGreen, width: 2),
      ),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _boxBadge('BOARD GAME SESSION'),
              _boxBadge('TURN  ${_currentTurn.value}'),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Player',
                      style: TextStyle(
                        color: _creamDeep,
                        fontSize: 12,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        color: _cream,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _creamDeep, width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: _nameController,
                        style: const TextStyle(
                          color: _charcoal,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Player name',
                          hintStyle: TextStyle(color: _slate),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildScoreBadge(),
                    const SizedBox(height: 16),
                    _buildLastRollStamp(),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    _buildDiceFace(_diceValue.value, _isRolling.value),
                    const SizedBox(height: 14),
                    _buildRollButton(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _boxBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _burntRed,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _burntRedDark, width: 2),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _cream,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildScoreBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _burntRedDark, width: 3),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.stars, color: _burntRed, size: 36),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'SCORE',
                style: TextStyle(
                  color: _slate,
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${_score.value}',
                style: const TextStyle(
                  color: _burntRedDark,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLastRollStamp() {
    final DateTime? ts = _lastRollAt.value;
    final String text;
    if (ts == null) {
      text = 'No rolls yet — press Roll to begin.';
    } else {
      text = 'Last roll at ${_formatTime(ts)}';
    }
    return Row(
      children: <Widget>[
        const Icon(Icons.schedule, color: _creamDeep, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _creamDeep,
              fontStyle: FontStyle.italic,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRollButton() {
    final bool disabled = _isRolling.value || !_diceRegistered;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: disabled ? null : _rollDice,
        style: ElevatedButton.styleFrom(
          backgroundColor: _burntRed,
          disabledBackgroundColor: _burntRedDark.withValues(alpha: 0.45),
          foregroundColor: _cream,
          disabledForegroundColor: _cream.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: _burntRedDark, width: 2),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
        icon: Icon(_isRolling.value ? Icons.sync : Icons.casino),
        label: Text(
          _isRolling.value
              ? 'ROLLING…'
              : (_diceRegistered ? 'ROLL DICE' : 'DICE UNREGISTERED'),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Dice face — Stack + absolutely-positioned pips.
  // ---------------------------------------------------------------------------
  Widget _buildDiceFace(int value, bool rolling) {
    const double size = 140;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: rolling ? _burntRed : _charcoal,
          width: 3,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _charcoal.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: _pipsForValue(value, size),
      ),
    );
  }

  List<Widget> _pipsForValue(int value, double size) {
    const double pipSize = 18;
    final double edge = size * 0.18;
    final double center = (size - pipSize) / 2;
    final double far = size - edge - pipSize;
    final List<Offset> positions;
    switch (value) {
      case 1:
        positions = <Offset>[Offset(center, center)];
        break;
      case 2:
        positions = <Offset>[
          Offset(edge, edge),
          Offset(far, far),
        ];
        break;
      case 3:
        positions = <Offset>[
          Offset(edge, edge),
          Offset(center, center),
          Offset(far, far),
        ];
        break;
      case 4:
        positions = <Offset>[
          Offset(edge, edge),
          Offset(far, edge),
          Offset(edge, far),
          Offset(far, far),
        ];
        break;
      case 5:
        positions = <Offset>[
          Offset(edge, edge),
          Offset(far, edge),
          Offset(center, center),
          Offset(edge, far),
          Offset(far, far),
        ];
        break;
      case 6:
        positions = <Offset>[
          Offset(edge, edge),
          Offset(far, edge),
          Offset(edge, center),
          Offset(far, center),
          Offset(edge, far),
          Offset(far, far),
        ];
        break;
      default:
        positions = <Offset>[Offset(center, center)];
    }
    final List<Widget> pips = <Widget>[];
    for (final Offset o in positions) {
      pips.add(
        Positioned(
          left: o.dx,
          top: o.dy,
          child: Container(
            width: pipSize,
            height: pipSize,
            decoration: const BoxDecoration(
              color: _charcoal,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
    return pips;
  }

  // ---------------------------------------------------------------------------
  // Section 2 — Scoreboard + roll history
  // ---------------------------------------------------------------------------
  Widget _buildScoreboard() {
    return Card(
      color: _cream,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: _creamDeep, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.leaderboard, color: _forestGreen),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Scoreboard & Roll History',
                    style: TextStyle(
                      color: _deepForest,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  '${_rollHistory.length} rolls',
                  style: const TextStyle(color: _slate, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildRollStrip(),
            const SizedBox(height: 22),
            Row(
              children: const <Widget>[
                Icon(Icons.trending_up, color: _burntRed, size: 18),
                SizedBox(width: 8),
                Text(
                  'Score progression',
                  style: TextStyle(
                    color: _charcoal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildScoreBars(),
          ],
        ),
      ),
    );
  }

  Widget _buildRollStrip() {
    if (_rollHistory.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _creamDeep.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _creamDeep),
        ),
        alignment: Alignment.center,
        child: const Text(
          'No rolls recorded yet.',
          style: TextStyle(
            color: _slate,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _rollHistory.length,
        separatorBuilder: (BuildContext ctx, int idx) =>
            const SizedBox(width: 8),
        itemBuilder: (BuildContext ctx, int i) {
          final int v = _rollHistory[i];
          return _MiniDie(value: v);
        },
      ),
    );
  }

  Widget _buildScoreBars() {
    int maxScore = 1;
    for (final int s in _scoreHistory) {
      if (s > maxScore) {
        maxScore = s;
      }
    }
    return SizedBox(
      height: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          for (int i = 0; i < _scoreHistory.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 90 * (_scoreHistory[i] / maxScore),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[_forestGreen, _mossGreen],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
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

  // ---------------------------------------------------------------------------
  // Section 3 — Bucket diagnostics panel
  // ---------------------------------------------------------------------------
  Widget _buildBucketDiagnostics() {
    final RestorationBucket? b = bucket;
    final String bucketSummary = b == null
        ? '🚫 No bucket — restoration disabled'
        : '🗄 Bucket present';
    return Card(
      color: _cream,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: _burntRedDark, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.inventory_2, color: _burntRed),
                const SizedBox(width: 10),
                const Text(
                  'Bucket Diagnostics',
                  style: TextStyle(
                    color: _burntRedDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _parchment,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _creamDeep),
              ),
              child: Text(
                bucketSummary,
                style: const TextStyle(
                  color: _charcoal,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 14),
            _buildRestorationIdRow(),
            const SizedBox(height: 14),
            _buildRegisteredPropertiesTable(),
            const SizedBox(height: 16),
            _buildBucketActionRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildRestorationIdRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'restorationId',
                style: TextStyle(
                  color: _slate,
                  fontSize: 11,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _restorationIdState,
                style: const TextStyle(
                  color: _deepForest,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: _toggleRestorationId,
          style: OutlinedButton.styleFrom(
            foregroundColor: _burntRedDark,
            side: const BorderSide(color: _burntRedDark, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.swap_horiz),
          label: const Text('Toggle'),
        ),
      ],
    );
  }

  Widget _buildRegisteredPropertiesTable() {
    final List<_PropRow> rows = <_PropRow>[
      _PropRow('score', 'RestorableInt', '${_score.value}', true),
      _PropRow('current_turn', 'RestorableInt', '${_currentTurn.value}', true),
      _PropRow(
        'dice',
        'RestorableInt',
        '${_diceValue.value}',
        _diceRegistered,
      ),
      _PropRow('player_name', 'RestorableString', _playerName.value, true),
      _PropRow('is_rolling', 'RestorableBool', '${_isRolling.value}', true),
      _PropRow(
        'last_roll_at',
        'RestorableDateTimeN',
        _lastRollAt.value == null ? '<null>' : _formatTime(_lastRollAt.value!),
        true,
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: _parchment,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _creamDeep),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: _creamDeep,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    'ID',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: _charcoal,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: _charcoal,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Value',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: _charcoal,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: _charcoal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: i.isEven
                    ? _cream.withValues(alpha: 0.5)
                    : Colors.transparent,
                border: const Border(
                  top: BorderSide(color: _creamDeep, width: 0.5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i].id,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: _deepForest,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i].type,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: _slate,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i].value,
                      style: const TextStyle(
                        color: _charcoal,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: rows[i].registered ? _mossGreen : _burntRed,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        rows[i].registered ? 'REG' : 'OFF',
                        style: const TextStyle(
                          color: _cream,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
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

  Widget _buildBucketActionRow() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        ElevatedButton.icon(
          onPressed: _diceRegistered ? _unregisterDice : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _burntRed,
            foregroundColor: _cream,
            disabledBackgroundColor: _burntRed.withValues(alpha: 0.35),
          ),
          icon: const Icon(Icons.remove_circle_outline),
          label: const Text('Unregister dice'),
        ),
        ElevatedButton.icon(
          onPressed: _diceRegistered ? null : _reregisterDice,
          style: ElevatedButton.styleFrom(
            backgroundColor: _forestGreen,
            foregroundColor: _cream,
            disabledBackgroundColor: _forestGreen.withValues(alpha: 0.35),
          ),
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('Re-register dice'),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4 — Lifecycle log
  // ---------------------------------------------------------------------------
  Widget _buildLifecycleLog() {
    return Card(
      color: _charcoal,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: _slate.withValues(alpha: 0.8), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.receipt_long, color: _cream),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Lifecycle Log',
                    style: TextStyle(
                      color: _cream,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _mossGreen,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${_log.length} entries',
                    style: const TextStyle(
                      color: _cream,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _slate),
              ),
              padding: const EdgeInsets.all(10),
              child: _log.isEmpty
                  ? const Center(
                      child: Text(
                        '— no lifecycle events yet —',
                        style: TextStyle(
                          color: _cream,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : ListView.builder(
                      reverse: true,
                      itemCount: _log.length,
                      itemBuilder: (BuildContext _, int i) {
                        final _LifecycleLogEntry e = _log[_log.length - 1 - i];
                        return _buildLogLine(e);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogLine(_LifecycleLogEntry e) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: _cream,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: '${_formatTime(e.at)}  ',
              style: const TextStyle(color: _mossGreen),
            ),
            TextSpan(
              text: '${e.event.padRight(26)} ',
              style: const TextStyle(
                color: _burntRed,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: e.detail,
              style: TextStyle(color: _cream.withValues(alpha: 0.85)),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5 — Teaching panel
  // ---------------------------------------------------------------------------
  Widget _buildTeachingPanel() {
    return Card(
      color: _cream,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: _forestGreen, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.menu_book, color: _forestGreen),
                SizedBox(width: 10),
                Text(
                  'How RestorationMixin Works',
                  style: TextStyle(
                    color: _deepForest,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildMethodTable(),
            const SizedBox(height: 18),
            _buildCodeBlock(),
            const SizedBox(height: 18),
            _buildBucketNullBullets(),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodTable() {
    const TextStyle nameStyle = TextStyle(
      fontFamily: 'monospace',
      fontWeight: FontWeight.w800,
      color: _burntRedDark,
    );
    const TextStyle descStyle = TextStyle(color: _charcoal);
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(220),
        1: FlexColumnWidth(),
      },
      border: TableBorder.all(color: _creamDeep, width: 1),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        const TableRow(
          decoration: BoxDecoration(color: _creamDeep),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Member',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _charcoal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Responsibility',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _charcoal,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('restorationId', style: nameStyle),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Non-null string that names this scope inside the parent '
                'bucket. Return null to opt out of restoration.',
                style: descStyle,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('restoreState', style: nameStyle),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Called once on mount and again whenever the bucket changes. '
                'Register every RestorableProperty here — nowhere else.',
                style: descStyle,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('didToggleBucket', style: nameStyle),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Notifies that the bucket reference itself just came or went. '
                'React by reading `bucket` if you depend on its presence.',
                style: descStyle,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('didUpdateRestorationId', style: nameStyle),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Subclasses call this after changing the id returned by the '
                'restorationId getter so the mixin re-keys the bucket.',
                style: descStyle,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('registerForRestoration', style: nameStyle),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Attaches a RestorableProperty to the bucket under a string '
                'key; pair with unregisterFromRestoration to detach.',
                style: descStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCodeBlock() {
    const String snippet = '''class _MyState extends State<…> with RestorationMixin {
  @override String? get restorationId => 'my_scope';
  final _counter = RestorableInt(0);
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_counter, 'counter');
  }
  @override void dispose() { _counter.dispose(); super.dispose(); }
}''';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _charcoal,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _slate, width: 1),
      ),
      child: const Text(
        snippet,
        style: TextStyle(
          fontFamily: 'monospace',
          color: _cream,
          fontSize: 12.5,
          height: 1.45,
        ),
      ),
    );
  }

  Widget _buildBucketNullBullets() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _parchment,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _creamDeep),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'When `bucket` can be null',
            style: TextStyle(
              color: _deepForest,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          _BucketBullet(
            'No enclosing RestorationScope / RootRestorationScope ancestor — '
            'the widget simply has nowhere to stash its data.',
          ),
          _BucketBullet(
            'Restoration is disabled by the embedder (for example, in widget '
            'tests that do not opt in to state restoration).',
          ),
          _BucketBullet(
            'The subclass returned null from restorationId, explicitly opting '
            'out of participating in the restoration tree.',
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Footer
  // ---------------------------------------------------------------------------
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _deepForest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _mossGreen, width: 1),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.info_outline, color: _cream, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Built with RestorationMixin<BoardGameSessionDemo>. Bucket: '
              '${bucket?.restorationId ?? "null"}.',
              style: const TextStyle(
                color: _cream,
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Small helpers
  // ---------------------------------------------------------------------------
  String _formatTime(DateTime t) {
    final String h = t.hour.toString().padLeft(2, '0');
    final String m = t.minute.toString().padLeft(2, '0');
    final String s = t.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
}

// =============================================================================
// Supporting types
// =============================================================================
class _LifecycleLogEntry {
  _LifecycleLogEntry(this.at, this.event, this.detail);
  final DateTime at;
  final String event;
  final String detail;
}

class _PropRow {
  _PropRow(this.id, this.type, this.value, this.registered);
  final String id;
  final String type;
  final String value;
  final bool registered;
}

class _MiniDie extends StatelessWidget {
  const _MiniDie({required this.value});
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _charcoal, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _charcoal.withValues(alpha: 0.22),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        '$value',
        style: const TextStyle(
          color: _charcoal,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _BucketBullet extends StatelessWidget {
  const _BucketBullet(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '•  ',
            style: TextStyle(
              color: _burntRed,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _charcoal, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
