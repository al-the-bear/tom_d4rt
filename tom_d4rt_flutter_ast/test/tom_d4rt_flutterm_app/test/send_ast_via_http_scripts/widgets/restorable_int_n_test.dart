import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// ---------------------------------------------------------------------------
// RestorableIntN — Deep Visual Demo
// ---------------------------------------------------------------------------
//
// RestorableIntN is a RestorableProperty<int?> — it stores either an integer
// or null, and takes part in Flutter's state restoration bucket. Unlike
// RestorableInt (which is always non-null), RestorableIntN is the right
// choice any time "no value" is a first-class meaning distinct from zero.
//
// Classic use cases:
//   * optional form fields ("prefer not to say")
//   * optional ratings ("not rated yet" vs. 0 stars)
//   * optional selection indices ("nothing selected")
//   * special sentinels like "unlimited" where null != 0
//
// This demo exercises five scenarios, each with its own visual shell, to
// emphasise the difference between "unknown / absent" (null) and
// "explicitly zero" (0).
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  if (kDebugMode) {
    debugPrint('[RestorableIntN demo] Building...');
  }
  return MaterialApp(
    title: 'RestorableIntN Deep Demo',
    theme: ThemeData(colorSchemeSeed: Colors.cyan, useMaterial3: true),
    restorationScopeId: 'restorable_int_n_demo',
    home: const SurveyFormDemo(),
  );
}

// ---------------------------------------------------------------------------
// Top-level stateful widget
// ---------------------------------------------------------------------------

class SurveyFormDemo extends StatefulWidget {
  const SurveyFormDemo({super.key});

  @override
  State<SurveyFormDemo> createState() => _SurveyFormDemoState();
}

class _SurveyFormDemoState extends State<SurveyFormDemo>
    with RestorationMixin {
  // ---------------------------------------------------------------------
  // Restorable state
  // ---------------------------------------------------------------------
  //
  // Every RestorableIntN below survives app restoration. When restoreState
  // is invoked, Flutter hands us an opaque bucket that will repopulate each
  // property's .value. While the app is alive, reading/writing .value from
  // inside setState() is enough to drive UI updates.
  //
  final RestorableIntN _age = RestorableIntN(null);
  final RestorableIntN _rating = RestorableIntN(null);
  final RestorableIntN _selectedTileIndex = RestorableIntN(null);
  final RestorableIntN _quotaRemaining = RestorableIntN(750);

  @override
  String? get restorationId => 'survey_form_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // Register each property with a unique restoration key. The bucket will
    // later use these keys to return the stored int-or-null.
    registerForRestoration(_age, 'age');
    registerForRestoration(_rating, 'rating');
    registerForRestoration(_selectedTileIndex, 'selected_tile_index');
    registerForRestoration(_quotaRemaining, 'quota_remaining');
    debugPrint(
      '[RestorableIntN demo] restoreState: initial=$initialRestore '
      'age=${_age.value} rating=${_rating.value} '
      'tile=${_selectedTileIndex.value} quota=${_quotaRemaining.value}',
    );
  }

  @override
  void dispose() {
    // Always dispose each property to release its listeners.
    _age.dispose();
    _rating.dispose();
    _selectedTileIndex.dispose();
    _quotaRemaining.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------
  // Build root
  // ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestorableIntN — Deep Demo'),
        elevation: 2,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            _sectionHeader(
              icon: Icons.cake_outlined,
              title: 'Scenario 1 — Age with "prefer not to say"',
              subtitle:
                  'Stepper + chip. null = "unspecified", integer = bracketed badge.',
            ),
            _buildAgeSection(),
            const SizedBox(height: 24),
            _sectionHeader(
              icon: Icons.star_rate_rounded,
              title: 'Scenario 2 — Optional star rating',
              subtitle: 'null = "no opinion", 1..5 = tiered label.',
            ),
            _buildStarRatingSection(),
            const SizedBox(height: 24),
            _sectionHeader(
              icon: Icons.grid_view_rounded,
              title: 'Scenario 3 — Gallery selection index',
              subtitle: 'null = nothing selected, 0..5 = scaled preview.',
            ),
            _buildGallerySection(),
            const SizedBox(height: 24),
            _sectionHeader(
              icon: Icons.speed_outlined,
              title: 'Scenario 4 — Quota remaining (null = unlimited)',
              subtitle: 'int = bar, null = gradient "∞" badge.',
            ),
            _buildQuotaSection(),
            const SizedBox(height: 24),
            _sectionHeader(
              icon: Icons.school_outlined,
              title: 'Scenario 5 — Teaching panel: null vs zero',
              subtitle: 'Why RestorableIntN exists alongside RestorableInt.',
            ),
            _buildTeachingSection(),
            const SizedBox(height: 32),
            _buildSummaryFooter(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Shared helpers
  // ---------------------------------------------------------------------

  Widget _sectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.cyan.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.cyan.shade800, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // Scenario 1 — Age field with "prefer not to say"
  // =====================================================================
  //
  // A hero stepper. The central big number or em-dash reflects _age.value.
  // Pressing the chip resets the value to null. Four quick-set buttons show
  // how trivially the field jumps between brackets.

  Widget _buildAgeSection() {
    final int? ageValue = _age.value;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Quick-set row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'Quick-set:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                _quickAgeButton(5),
                const SizedBox(width: 6),
                _quickAgeButton(25),
                const SizedBox(width: 6),
                _quickAgeButton(45),
                const SizedBox(width: 6),
                _quickAgeButton(70),
              ],
            ),
            const SizedBox(height: 18),
            // Stepper: [-]  BIG NUMBER  [+]
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _ageStepButton(
                  icon: Icons.remove_rounded,
                  onPressed: () {
                    setState(() {
                      final int current = ageValue ?? 0;
                      _age.value = (current - 1).clamp(0, 120);
                    });
                  },
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 140,
                  child: Center(
                    child: Text(
                      ageValue == null ? '—' : ageValue.toString(),
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w800,
                        color: ageValue == null
                            ? Colors.grey.shade500
                            : Colors.cyan.shade900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                _ageStepButton(
                  icon: Icons.add_rounded,
                  onPressed: () {
                    setState(() {
                      final int current = ageValue ?? 0;
                      _age.value = (current + 1).clamp(0, 120);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Prefer-not-to-say chip
            Center(
              child: InputChip(
                avatar: const Icon(Icons.visibility_off_outlined, size: 18),
                label: const Text('Prefer not to say'),
                selected: ageValue == null,
                onPressed: () {
                  setState(() {
                    _age.value = null;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            // Bracket badge or unspecified card
            if (ageValue == null)
              _unspecifiedAgeCard()
            else
              _ageBracketBadge(ageValue),
          ],
        ),
      ),
    );
  }

  Widget _quickAgeButton(int age) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(44, 34),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      onPressed: () {
        setState(() {
          _age.value = age;
        });
      },
      child: Text(age.toString()),
    );
  }

  Widget _ageStepButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.cyan.shade600,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  Widget _unspecifiedAgeCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.help_outline, color: Colors.grey.shade600, size: 22),
          const SizedBox(width: 10),
          Text(
            '(unspecified)',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ageBracketBadge(int age) {
    final _AgeBracket bracket = _classifyAge(age);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: bracket.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bracket.color, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(bracket.icon, color: bracket.color, size: 28),
          const SizedBox(width: 12),
          Text(
            bracket.label,
            style: TextStyle(
              color: bracket.color,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '(${bracket.rangeLabel})',
            style: TextStyle(
              color: bracket.color.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  _AgeBracket _classifyAge(int age) {
    if (age <= 12) {
      return const _AgeBracket(
        label: 'Child',
        rangeLabel: '0–12',
        color: Colors.blue,
        icon: Icons.child_care,
      );
    }
    if (age <= 17) {
      return const _AgeBracket(
        label: 'Teen',
        rangeLabel: '13–17',
        color: Colors.teal,
        icon: Icons.sports_esports,
      );
    }
    if (age <= 64) {
      return const _AgeBracket(
        label: 'Adult',
        rangeLabel: '18–64',
        color: Colors.green,
        icon: Icons.person,
      );
    }
    return const _AgeBracket(
      label: 'Senior',
      rangeLabel: '65+',
      color: Colors.purple,
      icon: Icons.person_outline,
    );
  }

  // =====================================================================
  // Scenario 2 — Star rating (nullable)
  // =====================================================================
  //
  // A pure horizontal row of five stars wrapped in InkWell. The total row
  // collapses to a simple textual hint when _rating.value is null. Note the
  // distinction between "1 star" (a legitimate low rating) and "null" (no
  // opinion) — the former is a judgement, the latter is absence.

  Widget _buildStarRatingSection() {
    final int? rating = _rating.value;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.amber.shade50,
            Colors.orange.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(5, (int index) {
              final bool filled = rating != null && index < rating;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    setState(() {
                      _rating.value = index + 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      filled ? Icons.star_rounded : Icons.star_border_rounded,
                      size: 48,
                      color: filled
                          ? Colors.amber.shade700
                          : Colors.grey.shade500,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          if (rating == null)
            Column(
              children: <Widget>[
                Text(
                  'Not rated yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '(no opinion)',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            )
          else
            Column(
              children: <Widget>[
                Text(
                  _ratingAdjective(rating),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.amber.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$rating of 5',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.amber.shade800,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _rating.value = null;
                  });
                },
                icon: const Icon(Icons.clear),
                label: const Text('Clear rating'),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: () {
                  setState(() {
                    _rating.value = 4;
                  });
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                ),
                icon: const Icon(Icons.star_rounded),
                label: const Text('Quick rate ★★★★'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _ratingAdjective(int n) {
    switch (n) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Great';
      case 5:
        return 'Excellent';
      default:
        return '—';
    }
  }

  // =====================================================================
  // Scenario 3 — Gallery tile index
  // =====================================================================
  //
  // Six colour-coded tiles. _selectedTileIndex.value stores the index
  // (0..5) or null. When null, the preview zone below prompts the user to
  // pick one. When set, an AnimatedScale raises the matching tile and a
  // large preview icon appears. Again: "index 0" differs from "no
  // selection" — this is exactly why we use RestorableIntN.

  Widget _buildGallerySection() {
    final int? selected = _selectedTileIndex.value;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 120,
          child: Row(
            children: List<Widget>.generate(_galleryTiles.length, (int i) {
              final _GalleryTile tile = _galleryTiles[i];
              final bool isSelected = selected == i;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AnimatedScale(
                    scale: isSelected ? 1.08 : 1.0,
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutBack,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        setState(() {
                          _selectedTileIndex.value = i;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: tile.color,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? Colors.black
                                : Colors.transparent,
                            width: 3,
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: tile.color.withValues(alpha: 0.4),
                              blurRadius: isSelected ? 12 : 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            tile.icon,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),
        if (selected == null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade400,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.touch_app_outlined, color: Colors.grey.shade600),
                const SizedBox(width: 10),
                Text(
                  'Tap a tile to select',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        else
          _galleryPreview(selected),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: selected == null
                  ? null
                  : () {
                      setState(() {
                        _selectedTileIndex.value = null;
                      });
                    },
              icon: const Icon(Icons.clear),
              label: const Text('Clear selection'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _galleryPreview(int selected) {
    final _GalleryTile tile = _galleryTiles[selected];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            tile.color.withValues(alpha: 0.9),
            tile.color.withValues(alpha: 0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: <Widget>[
          Icon(tile.icon, size: 120, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            tile.name,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Index: $selected',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // Scenario 4 — Quota remaining (null = unlimited)
  // =====================================================================
  //
  // A classic null-as-sentinel use case. Here, null means "unlimited plan"
  // — a *different* semantic from 0 ("no quota left"). RestorableIntN is a
  // perfect fit because both 0 and null are meaningful, distinguishable
  // integer-ish states.

  Widget _buildQuotaSection() {
    final int? quota = _quotaRemaining.value;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.api_outlined, color: Colors.indigo.shade700),
                const SizedBox(width: 8),
                const Text(
                  'API Quota',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (quota == null) _buildUnlimitedBadge() else _buildQuotaBar(quota),
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: <Widget>[
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      final int current = quota ?? 0;
                      _quotaRemaining.value = (current - 50).clamp(0, 1000);
                    });
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                  label: const Text('Consume 50'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _quotaRemaining.value = 1000;
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refill to 1000'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () {
                    setState(() {
                      _quotaRemaining.value = null;
                    });
                  },
                  icon: const Icon(Icons.all_inclusive),
                  label: const Text('Upgrade to unlimited (clear)'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuotaBar(int quota) {
    // Colour bands: green > 500, amber 100..500, red < 100.
    final Color barColor;
    if (quota > 500) {
      barColor = Colors.green.shade600;
    } else if (quota >= 100) {
      barColor = Colors.amber.shade700;
    } else {
      barColor = Colors.red.shade600;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '$quota / 1000 remaining',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${((quota / 1000) * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 14,
                color: barColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints c) {
            final double fullWidth = c.maxWidth;
            final double fraction = (quota / 1000).clamp(0.0, 1.0);
            return Container(
              height: 18,
              width: fullWidth,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 18,
                  width: fullWidth * fraction,
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: barColor.withValues(alpha: 0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          quota < 100
              ? 'Critical — top up or upgrade soon.'
              : quota < 500
                  ? 'Running low — consider topping up.'
                  : 'Healthy usage.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildUnlimitedBadge() {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.purple.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.all_inclusive, color: Colors.white, size: 36),
              SizedBox(width: 12),
              Text(
                '∞ unlimited plan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Unlimited quota — no enforcement',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  // =====================================================================
  // Scenario 5 — Teaching panel: null vs zero
  // =====================================================================
  //
  // A static explanatory layout. Two mirrored cards demonstrate how "0" and
  // "null" render side by side; bullet-list cards explain the semantics and
  // storage mechanics. This is the didactic heart of the demo — everything
  // else above is an application of these ideas.

  Widget _buildTeachingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _teachingComparisonCard(
                heading: 'value == 0',
                big: '0',
                bigColor: Colors.blue.shade700,
                caption: 'explicitly zero',
                backgroundColor: Colors.blue.shade50,
                borderColor: Colors.blue.shade300,
                icon: Icons.numbers,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _teachingComparisonCard(
                heading: 'value == null',
                big: '—',
                bigColor: Colors.grey.shade700,
                caption: 'value absent',
                backgroundColor: Colors.grey.shade100,
                borderColor: Colors.grey.shade400,
                icon: Icons.remove_circle_outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _teachingBulletCard(
          title: 'Why nullable integers',
          icon: Icons.question_answer_outlined,
          accent: Colors.cyan.shade700,
          bullets: const <_BulletPoint>[
            _BulletPoint(
              icon: Icons.edit_note,
              text:
                  'Optional input: "prefer not to say", "not provided", skipped questions.',
            ),
            _BulletPoint(
              icon: Icons.filter_alt_outlined,
              text:
                  'Optional filters: "any" means no upper bound; null is the natural encoding.',
            ),
            _BulletPoint(
              icon: Icons.toggle_off_outlined,
              text:
                  'Unset state: a field the user has not yet touched should not pretend to be 0.',
            ),
          ],
        ),
        const SizedBox(height: 12),
        _teachingBulletCard(
          title: 'Null vs zero semantics',
          icon: Icons.compare_arrows,
          accent: Colors.deepPurple.shade500,
          bullets: const <_BulletPoint>[
            _BulletPoint(
              icon: Icons.rule,
              text:
                  'Zero is a value — it can be compared, summed, averaged. Null is the absence of a value.',
            ),
            _BulletPoint(
              icon: Icons.warning_amber_outlined,
              text:
                  'Confusing them leads to bugs: "0 items" vs "no data yet" are operationally different.',
            ),
            _BulletPoint(
              icon: Icons.lightbulb_outline,
              text:
                  'If 0 is a legal, meaningful answer, you almost always need a nullable type to mean "unknown".',
            ),
          ],
        ),
        const SizedBox(height: 12),
        _teachingBulletCard(
          title: 'RestorableIntN storage mechanics',
          icon: Icons.save_outlined,
          accent: Colors.teal.shade600,
          bullets: const <_BulletPoint>[
            _BulletPoint(
              icon: Icons.storage,
              text:
                  'Internally stored in the restoration bucket as an int or null — no sentinel constants.',
            ),
            _BulletPoint(
              icon: Icons.key,
              text:
                  'Register with a unique id via registerForRestoration; rely on restoreState to repopulate.',
            ),
            _BulletPoint(
              icon: Icons.compare,
              text:
                  'Prefer RestorableIntN whenever the field is semantically optional; otherwise use RestorableInt.',
            ),
          ],
        ),
      ],
    );
  }

  Widget _teachingComparisonCard({
    required String heading,
    required String big,
    required Color bigColor,
    required String caption,
    required Color backgroundColor,
    required Color borderColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: bigColor),
              const SizedBox(width: 6),
              Text(
                heading,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: bigColor,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            big,
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w800,
              color: bigColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            style: TextStyle(
              fontSize: 13,
              color: bigColor.withValues(alpha: 0.85),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _teachingBulletCard({
    required String title,
    required IconData icon,
    required Color accent,
    required List<_BulletPoint> bullets,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: accent, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final _BulletPoint bp in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(bp.icon, color: accent.withValues(alpha: 0.75), size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      bp.text,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.4,
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

  // =====================================================================
  // Summary footer
  // =====================================================================

  Widget _buildSummaryFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.cyan.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.check_circle_outline, color: Colors.cyan.shade800),
              const SizedBox(width: 8),
              Text(
                'Live state snapshot',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.cyan.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _footerLine('age', _age.value),
          _footerLine('rating', _rating.value),
          _footerLine('selectedTileIndex', _selectedTileIndex.value),
          _footerLine('quotaRemaining', _quotaRemaining.value),
          const SizedBox(height: 8),
          Text(
            'Each value above is stored in the restoration bucket as an int or '
            'null; all four properties survive process-kill restoration.',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.cyan.shade900.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerLine(String name, int? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              '$name:',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: value == null
                  ? Colors.grey.shade300
                  : Colors.cyan.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value == null ? 'null' : value.toString(),
              style: TextStyle(
                fontFamily: 'monospace',
                color: value == null
                    ? Colors.grey.shade700
                    : Colors.cyan.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Supporting data shapes
// ---------------------------------------------------------------------------

class _AgeBracket {
  final String label;
  final String rangeLabel;
  final Color color;
  final IconData icon;

  const _AgeBracket({
    required this.label,
    required this.rangeLabel,
    required this.color,
    required this.icon,
  });
}

class _GalleryTile {
  final String name;
  final Color color;
  final IconData icon;
  const _GalleryTile({
    required this.name,
    required this.color,
    required this.icon,
  });
}

const List<_GalleryTile> _galleryTiles = <_GalleryTile>[
  _GalleryTile(name: 'Heart', color: Colors.red, icon: Icons.favorite),
  _GalleryTile(name: 'Star', color: Colors.blue, icon: Icons.star),
  _GalleryTile(name: 'Leaf', color: Colors.green, icon: Icons.eco),
  _GalleryTile(name: 'Sun', color: Colors.amber, icon: Icons.wb_sunny),
  _GalleryTile(name: 'Gem', color: Colors.purple, icon: Icons.diamond),
  _GalleryTile(name: 'Wave', color: Colors.teal, icon: Icons.waves),
];

class _BulletPoint {
  final IconData icon;
  final String text;
  const _BulletPoint({required this.icon, required this.text});
}
