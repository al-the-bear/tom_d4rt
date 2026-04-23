// Deep demo of RestorableProperty<T> — the abstract base class for every
// restorable piece of state in Flutter. This file shows USERS how to roll
// their OWN subclass when none of the built-in restorables (RestorableInt,
// RestorableBool, RestorableString, RestorableDateTime, RestorableEnum, …)
// can carry the shape of data they need to persist across a
// save-and-restore cycle.
//
// The story is: a "Theme Color Editor" that lets the user pick a primary
// colour, an accent colour, a background tint, star favourite swatches,
// and flip between palette viewing modes. All of this state survives a
// restoration round-trip because we wire two custom subclasses —
// `_RestorableColor` and `_RestorableStringList` — alongside a stock
// `RestorableInt` into the `RestorationMixin`.
//
// Along the way, the UI itself teaches the five-method lifecycle of any
// RestorableProperty subclass, and a source-code box renders the
// `_RestorableColor` implementation as text so a learner can read the
// exact pattern they need to copy.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//                    Custom RestorableProperty subclasses
// ---------------------------------------------------------------------------
//
// These are the entire point of the demo. `RestorableProperty<T>` is an
// abstract class from `package:flutter/widgets.dart` (re-exported by
// material.dart) with five methods that together describe how an in-memory
// value of type T is serialised to primitives, persisted by the framework,
// and re-inflated on restoration.
//
// The contract:
//
//   1. createDefaultValue()   — called once, lazily, when the framework
//                               needs an initial value and nothing has
//                               been restored yet. Must return a fresh T.
//   2. initWithValue(T value) — called by the framework both after
//                               createDefaultValue AND after a restore
//                               round-trip. This is where you stash the
//                               live value in an internal field and
//                               notify listeners.
//   3. toPrimitives()         — called by the framework when it needs to
//                               write the current value to the restoration
//                               bucket. Must return a primitive (int,
//                               double, String, bool, List, Map of those).
//   4. fromPrimitives(data)   — inverse of toPrimitives. Called with the
//                               previously-persisted primitive on restore.
//   5. didUpdateValue(old)    — called by you whenever your value changes
//                               so the framework knows to persist again.
//                               Must call notifyListeners for the owning
//                               widget to rebuild.
//
// Implementing a subclass is NOT difficult once you see one end to end.

/// A RestorableProperty for [Color].
///
/// This is the kind of custom subclass users need to write when the
/// shipping set of RestorableFoo classes does not include their type.
/// Colour is a great example because it is conceptually simple (a 32-bit
/// ARGB integer) but is not one of the primitives the framework knows how
/// to persist directly.
class _RestorableColor extends RestorableProperty<Color> {
  _RestorableColor([Color? defaultValue])
      : _defaultValue = defaultValue ?? const Color(0xFF3F51B5);

  final Color _defaultValue;
  late Color _value;

  /// The live colour. Setting this triggers a restoration write.
  Color get value => _value;
  set value(Color newValue) {
    if (identical(newValue, _value)) return;
    final Color old = _value;
    _value = newValue;
    // didUpdateValue tells the framework "persist me again" and fires our
    // listeners so the hosting widget can rebuild.
    notifyListeners();
    didUpdateValue(old);
  }

  @override
  Color createDefaultValue() => _defaultValue;

  @override
  void initWithValue(Color value) {
    _value = value;
    notifyListeners();
  }

  @override
  Object toPrimitives() => _value.toARGB32();

  @override
  Color fromPrimitives(Object? data) {
    if (data is int) return Color(data);
    // Robustness: if anything goes wrong, fall back to the default rather
    // than blow up on restore. This is a common defensive pattern.
    return _defaultValue;
  }

  /// Called by us whenever the wrapped value changes so listeners (and,
  /// transitively, the framework) can pick up the write. The name mirrors
  /// the lifecycle vocabulary used in Flutter docs.
  void didUpdateValue(Color? oldValue) {
    // A real implementation *could* diff and only notify on change, but
    // the framework already coalesces writes so a simple notify is fine.
    notifyListeners();
  }
}

/// A RestorableProperty for `List<String>`.
///
/// This exists to prove the pattern works for compound types too. The
/// primitive we hand to the framework is a `List<String>`, which is
/// allowed because its elements are themselves primitives. We defensively
/// copy on both write and read so the stored list cannot be mutated from
/// outside.
class _RestorableStringList extends RestorableProperty<List<String>> {
  _RestorableStringList([List<String>? defaultValue])
      : _defaultValue = List<String>.unmodifiable(defaultValue ?? const <String>[]);

  final List<String> _defaultValue;
  late List<String> _value;

  List<String> get value => List<String>.unmodifiable(_value);

  /// Replace the entire list.
  set value(List<String> newValue) {
    _value = List<String>.from(newValue);
    notifyListeners();
    didUpdateValue(null);
  }

  /// Add a single entry. Convenience on top of the set-everything API.
  void add(String entry) {
    _value.add(entry);
    notifyListeners();
    didUpdateValue(null);
  }

  /// Remove a single entry. No-op if not present.
  void remove(String entry) {
    if (_value.remove(entry)) {
      notifyListeners();
      didUpdateValue(null);
    }
  }

  @override
  List<String> createDefaultValue() => List<String>.from(_defaultValue);

  @override
  void initWithValue(List<String> value) {
    _value = List<String>.from(value);
    notifyListeners();
  }

  @override
  Object toPrimitives() => List<String>.from(_value);

  @override
  List<String> fromPrimitives(Object? data) {
    if (data is List) {
      return data.whereType<String>().toList();
    }
    return List<String>.from(_defaultValue);
  }

  /// Called by us whenever the wrapped list changes.
  void didUpdateValue(List<String>? oldValue) {
    notifyListeners();
  }
}

// ---------------------------------------------------------------------------
//                                Harness entry
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('[restorable_property_test] build() invoked, launching ThemeColorEditorDemo');
  return MaterialApp(
    title: 'RestorableProperty Deep Demo',
    restorationScopeId: 'theme_color_editor_root',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F51B5)),
      useMaterial3: true,
      fontFamily: 'Roboto',
    ),
    home: const ThemeColorEditorDemo(),
  );
}

// ---------------------------------------------------------------------------
//                                Main widget
// ---------------------------------------------------------------------------

class ThemeColorEditorDemo extends StatefulWidget {
  const ThemeColorEditorDemo({super.key});

  @override
  State<ThemeColorEditorDemo> createState() => _ThemeColorEditorDemoState();
}

class _ThemeColorEditorDemoState extends State<ThemeColorEditorDemo>
    with RestorationMixin {
  // Our custom colour properties. Notice how we can pass a default to the
  // constructor — this is a classic ergonomic escape hatch for subclasses
  // whose default value is not a compile-time constant expression.
  final _RestorableColor _primaryColor = _RestorableColor(const Color(0xFF3F51B5));
  final _RestorableColor _accentColor = _RestorableColor(const Color(0xFFFF4081));
  final _RestorableColor _backgroundTint = _RestorableColor(const Color(0xFFFAFAFA));

  // The favourite swatches list, also a custom subclass, shows the
  // `List<String>` primitive case.
  final _RestorableStringList _favoriteSwatches = _RestorableStringList(
    const <String>['#3F51B5', '#FF4081', '#FFC107'],
  );

  // A stock built-in RestorableInt — here purely to contrast what the
  // user gets "for free" versus what they build themselves. 0 = material,
  // 1 = pastel, 2 = neon.
  final RestorableInt _paletteMode = RestorableInt(0);

  // Handy preset swatches shown in the 5x5 grid. 25 entries.
  static const List<Color> _presetSwatches = <Color>[
    Color(0xFFEF5350), Color(0xFFEC407A), Color(0xFFAB47BC), Color(0xFF7E57C2), Color(0xFF5C6BC0),
    Color(0xFF42A5F5), Color(0xFF29B6F6), Color(0xFF26C6DA), Color(0xFF26A69A), Color(0xFF66BB6A),
    Color(0xFF9CCC65), Color(0xFFD4E157), Color(0xFFFFEE58), Color(0xFFFFCA28), Color(0xFFFFA726),
    Color(0xFFFF7043), Color(0xFF8D6E63), Color(0xFFBDBDBD), Color(0xFF78909C), Color(0xFF546E7A),
    Color(0xFF37474F), Color(0xFF1E88E5), Color(0xFF00897B), Color(0xFF6D4C41), Color(0xFF5E35B1),
  ];

  @override
  void initState() {
    super.initState();
    debugPrint('[ThemeColorEditorDemo] initState — custom restorables constructed');
    debugPrint('[ThemeColorEditorDemo] primary default: ${_primaryColor.createDefaultValue()}');
    debugPrint('[ThemeColorEditorDemo] accent default : ${_accentColor.createDefaultValue()}');
    debugPrint('[ThemeColorEditorDemo] favourites default size: ${_favoriteSwatches.createDefaultValue().length}');
  }

  @override
  String? get restorationId => 'theme_color_editor_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    debugPrint('[ThemeColorEditorDemo] restoreState initialRestore=$initialRestore');
    // Every RestorableProperty must be registered with a unique key.
    // The framework uses these keys to store and retrieve each value.
    registerForRestoration(_primaryColor, 'primary_color');
    registerForRestoration(_accentColor, 'accent_color');
    registerForRestoration(_backgroundTint, 'background_tint');
    registerForRestoration(_favoriteSwatches, 'favorite_swatches');
    registerForRestoration(_paletteMode, 'palette_mode');
  }

  @override
  void dispose() {
    debugPrint('[ThemeColorEditorDemo] dispose — releasing restorable properties');
    _primaryColor.dispose();
    _accentColor.dispose();
    _backgroundTint.dispose();
    _favoriteSwatches.dispose();
    _paletteMode.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  //                             State mutations
  // -------------------------------------------------------------------------

  void _handleSwatchTap(Color tapped) {
    setState(() {
      _primaryColor.value = tapped;
    });
    debugPrint('[ThemeColorEditorDemo] primary => ${tapped.toARGB32().toRadixString(16)}');
  }

  void _cyclePaletteMode() {
    setState(() {
      _paletteMode.value = (_paletteMode.value + 1) % 3;
    });
    debugPrint('[ThemeColorEditorDemo] palette mode => ${_paletteMode.value}');
  }

  void _addCurrentToFavorites() {
    final String hex = _hexOf(_primaryColor.value);
    if (_favoriteSwatches.value.contains(hex)) {
      debugPrint('[ThemeColorEditorDemo] $hex already in favourites');
      return;
    }
    setState(() {
      _favoriteSwatches.add(hex);
    });
    debugPrint('[ThemeColorEditorDemo] favourite added: $hex');
  }

  void _removeFavorite(String hex) {
    setState(() {
      _favoriteSwatches.remove(hex);
    });
    debugPrint('[ThemeColorEditorDemo] favourite removed: $hex');
  }

  void _randomiseAccent() {
    // Cycle through a small fixed set of accents. Deterministic on purpose
    // (no Random) so test harnesses stay predictable.
    const List<Color> picks = <Color>[
      Color(0xFFFF4081),
      Color(0xFF00E5FF),
      Color(0xFFFFD54F),
      Color(0xFF69F0AE),
      Color(0xFFB388FF),
    ];
    final int current = picks.indexWhere((Color c) => c.toARGB32() == _accentColor.value.toARGB32());
    final Color next = picks[(current + 1) % picks.length];
    setState(() {
      _accentColor.value = next;
    });
    debugPrint('[ThemeColorEditorDemo] accent => ${_hexOf(next)}');
  }

  void _shiftBackground() {
    const List<Color> tints = <Color>[
      Color(0xFFFAFAFA),
      Color(0xFFF1F5F9),
      Color(0xFFFFF7ED),
      Color(0xFFF0FDF4),
      Color(0xFFEEF2FF),
    ];
    final int current = tints.indexWhere((Color c) => c.toARGB32() == _backgroundTint.value.toARGB32());
    final Color next = tints[(current + 1) % tints.length];
    setState(() {
      _backgroundTint.value = next;
    });
    debugPrint('[ThemeColorEditorDemo] background tint => ${_hexOf(next)}');
  }

  // -------------------------------------------------------------------------
  //                                  Build
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final Color surface = _backgroundTint.value;
    return Scaffold(
      backgroundColor: surface,
      appBar: AppBar(
        title: const Text('RestorableProperty — Theme Color Editor'),
        backgroundColor: _primaryColor.value,
        foregroundColor: _readableForeground(_primaryColor.value),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            tooltip: 'Cycle accent',
            icon: const Icon(Icons.palette_outlined),
            onPressed: _randomiseAccent,
          ),
          IconButton(
            tooltip: 'Shift background',
            icon: const Icon(Icons.format_paint_outlined),
            onPressed: _shiftBackground,
          ),
          IconButton(
            tooltip: 'Palette mode (${_paletteModeLabel(_paletteMode.value)})',
            icon: const Icon(Icons.auto_awesome_outlined),
            onPressed: _cyclePaletteMode,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
          children: <Widget>[
            _buildHeroPreview(),
            const SizedBox(height: 28),
            _buildSectionHeader(
              title: 'Swatch picker',
              subtitle: 'Tap any swatch to set the primary colour. Starred favourites are remembered across restoration.',
              icon: Icons.grid_view_rounded,
            ),
            const SizedBox(height: 12),
            _buildSwatchGrid(),
            const SizedBox(height: 16),
            _buildFavoritesStrip(),
            const SizedBox(height: 32),
            _buildSectionHeader(
              title: 'HSL and RGB breakdown',
              subtitle: 'The same Color value, inspected two different ways.',
              icon: Icons.analytics_outlined,
            ),
            const SizedBox(height: 12),
            _buildColorBreakdownCard(),
            const SizedBox(height: 32),
            _buildSectionHeader(
              title: 'Applied samples',
              subtitle: 'Four real-world ways the restored primary appears.',
              icon: Icons.view_comfortable_outlined,
            ),
            const SizedBox(height: 12),
            _buildAppliedSamplesGrid(),
            const SizedBox(height: 32),
            _buildSectionHeader(
              title: 'Lifecycle of a custom RestorableProperty',
              subtitle: 'The five hooks you implement, in execution order.',
              icon: Icons.timeline_outlined,
            ),
            const SizedBox(height: 12),
            _buildLifecycleDiagram(),
            const SizedBox(height: 20),
            _buildSourceCodeBox(),
            const SizedBox(height: 32),
            _buildFooterNote(),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  //                          Section: hero preview
  // -------------------------------------------------------------------------

  Widget _buildHeroPreview() {
    final Color primary = _primaryColor.value;
    final Color accent = _accentColor.value;
    final Color textColor = _readableForeground(primary);
    return SizedBox(
      height: 280,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    primary,
                    Color.lerp(primary, accent, 0.5) ?? primary,
                    accent,
                  ],
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: primary.withValues(alpha: 0.25),
                    blurRadius: 28,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 18,
            left: 22,
            right: 22,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _heroBadge('PRIMARY   ${_hexOf(primary)}', textColor),
                _heroBadge('ACCENT   ${_hexOf(accent)}', textColor),
              ],
            ),
          ),
          Positioned(
            left: 22,
            right: 22,
            bottom: 18,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Hello, theme editor',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Bodies of text render in a muted slate while headlines and calls-to-action adopt the restored primary colour.',
                    style: TextStyle(fontSize: 13, color: Color(0xFF475569), height: 1.35),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: <Widget>[
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: _readableForeground(primary),
                        ),
                        onPressed: _addCurrentToFavorites,
                        child: const Text('Star this colour'),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: accent,
                          side: BorderSide(color: accent, width: 1.4),
                        ),
                        onPressed: _randomiseAccent,
                        child: const Text('Shift accent'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroBadge(String text, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          color: textColor,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  //                          Section: swatch grid
  // -------------------------------------------------------------------------

  Widget _buildSwatchGrid() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: <Widget>[
          for (final Color c in _presetSwatches) _swatchCell(c),
        ],
      ),
    );
  }

  Widget _swatchCell(Color c) {
    final bool selected = c.toARGB32() == _primaryColor.value.toARGB32();
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleSwatchTap(c),
        child: Container(
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? Colors.white : Colors.transparent,
              width: 3,
            ),
            boxShadow: <BoxShadow>[
              if (selected)
                BoxShadow(
                  color: c.withValues(alpha: 0.6),
                  blurRadius: 14,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Center(
            child: selected
                ? Icon(Icons.check, color: _readableForeground(c), size: 20)
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesStrip() {
    final List<String> favs = _favoriteSwatches.value;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Favourite swatches',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              TextButton.icon(
                onPressed: _addCurrentToFavorites,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('add current'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (favs.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'No favourites yet. Star the current primary to add one.',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (final String hex in favs) _favoriteChip(hex),
              ],
            ),
        ],
      ),
    );
  }

  Widget _favoriteChip(String hex) {
    final Color c = _parseHex(hex);
    return InputChip(
      avatar: CircleAvatar(backgroundColor: c, radius: 10),
      label: Text(hex, style: const TextStyle(fontSize: 12)),
      onPressed: () => _handleSwatchTap(c),
      onDeleted: () => _removeFavorite(hex),
      deleteIconColor: const Color(0xFF64748B),
      backgroundColor: const Color(0xFFF8FAFC),
      side: const BorderSide(color: Color(0xFFE2E8F0)),
    );
  }

  // -------------------------------------------------------------------------
  //                          Section: HSL / RGB
  // -------------------------------------------------------------------------

  Widget _buildColorBreakdownCard() {
    final Color c = _primaryColor.value;
    final HSLColor hsl = HSLColor.fromColor(c);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'H ${hsl.hue.toStringAsFixed(0)}°  ·  S ${(hsl.saturation * 100).toStringAsFixed(0)}%  ·  L ${(hsl.lightness * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 10),
          _buildHslRow(hsl),
          const Divider(height: 28),
          Text(
            'R ${(c.r * 255).round()}  ·  G ${(c.g * 255).round()}  ·  B ${(c.b * 255).round()}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 10),
          _buildRgbRow(c),
        ],
      ),
    );
  }

  Widget _buildHslRow(HSLColor hsl) {
    return Column(
      children: <Widget>[
        _barMeter(
          label: 'Hue',
          fraction: (hsl.hue / 360.0).clamp(0.0, 1.0),
          color: const Color(0xFFEF4444),
          display: '${hsl.hue.toStringAsFixed(0)}°',
        ),
        const SizedBox(height: 8),
        _barMeter(
          label: 'Sat',
          fraction: hsl.saturation.clamp(0.0, 1.0),
          color: const Color(0xFF10B981),
          display: '${(hsl.saturation * 100).toStringAsFixed(0)}%',
        ),
        const SizedBox(height: 8),
        _barMeter(
          label: 'Lig',
          fraction: hsl.lightness.clamp(0.0, 1.0),
          color: const Color(0xFF6366F1),
          display: '${(hsl.lightness * 100).toStringAsFixed(0)}%',
        ),
      ],
    );
  }

  Widget _buildRgbRow(Color c) {
    return Column(
      children: <Widget>[
        _barMeter(
          label: 'R',
          fraction: c.r.clamp(0.0, 1.0),
          color: const Color(0xFFDC2626),
          display: '${(c.r * 255).round()}',
        ),
        const SizedBox(height: 8),
        _barMeter(
          label: 'G',
          fraction: c.g.clamp(0.0, 1.0),
          color: const Color(0xFF16A34A),
          display: '${(c.g * 255).round()}',
        ),
        const SizedBox(height: 8),
        _barMeter(
          label: 'B',
          fraction: c.b.clamp(0.0, 1.0),
          color: const Color(0xFF2563EB),
          display: '${(c.b * 255).round()}',
        ),
      ],
    );
  }

  Widget _barMeter({
    required String label,
    required double fraction,
    required Color color,
    required String display,
  }) {
    final int filled = (fraction * 100).round().clamp(0, 100);
    final int empty = 100 - filled;
    return Row(
      children: <Widget>[
        SizedBox(
          width: 30,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 12,
            child: Row(
              children: <Widget>[
                if (filled > 0)
                  Expanded(
                    flex: filled,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                      ),
                    ),
                  ),
                if (empty > 0)
                  Expanded(
                    flex: empty,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: filled == 0
                            ? BorderRadius.circular(8)
                            : const BorderRadius.horizontal(right: Radius.circular(8)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 50,
          child: Text(
            display,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 12, color: Color(0xFF334155)),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  //                       Section: applied samples
  // -------------------------------------------------------------------------

  Widget _buildAppliedSamplesGrid() {
    final Color primary = _primaryColor.value;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 1.35,
      children: <Widget>[
        _buildAppliedSample(
          caption: 'Filled button background',
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(999),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: primary.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Text(
                'Tap me',
                style: TextStyle(
                  color: _readableForeground(primary),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        _buildAppliedSample(
          caption: 'Foreground text colour',
          child: Center(
            child: Text(
              'Aa',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w800,
                color: primary,
                letterSpacing: -1,
              ),
            ),
          ),
        ),
        _buildAppliedSample(
          caption: 'Border colour',
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: primary, width: 3),
              ),
              child: Center(
                child: Text(
                  'bordered',
                  style: TextStyle(color: primary, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
        _buildAppliedSample(
          caption: 'Gradient fade',
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: <Color>[
                    primary,
                    primary.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppliedSample({required String caption, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: <Widget>[
          Expanded(child: child),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Text(
              caption,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: Color(0xFF475569)),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  //                        Section: lifecycle diagram
  // -------------------------------------------------------------------------

  Widget _buildLifecycleDiagram() {
    final List<_LifecycleStep> steps = <_LifecycleStep>[
      _LifecycleStep(
        title: 'createDefaultValue()',
        detail: 'Returns a fresh T when nothing has been restored yet.',
        color: const Color(0xFF6366F1),
      ),
      _LifecycleStep(
        title: 'initWithValue(T)',
        detail: 'Framework hands you the live value; stash it and notify.',
        color: const Color(0xFF0EA5E9),
      ),
      _LifecycleStep(
        title: 'toPrimitives()',
        detail: 'Serialise the current value to a persistable primitive.',
        color: const Color(0xFF10B981),
      ),
      _LifecycleStep(
        title: 'storage',
        detail: 'Framework writes primitives to the RestorationBucket.',
        color: const Color(0xFFF59E0B),
      ),
      _LifecycleStep(
        title: 'fromPrimitives(data)',
        detail: 'On restore, rebuild the T from the stored primitive.',
        color: const Color(0xFFF43F5E),
      ),
      _LifecycleStep(
        title: 'didUpdateValue(old)',
        detail: 'Fire notifyListeners whenever the value changes.',
        color: const Color(0xFF8B5CF6),
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < steps.length; i++) ...<Widget>[
              _buildLifecycleStepBox(steps[i]),
              if (i < steps.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 40),
                  child: Icon(Icons.arrow_forward_rounded,
                      size: 22, color: Color(0xFF94A3B8)),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLifecycleStepBox(_LifecycleStep step) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: step.color.withValues(alpha: 0.08),
        border: Border.all(color: step.color.withValues(alpha: 0.5), width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: step.color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              step.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            step.detail,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF334155),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  //                        Section: source-code box
  // -------------------------------------------------------------------------

  Widget _buildSourceCodeBox() {
    const String source = '''
class _RestorableColor extends RestorableProperty<Color> {
  _RestorableColor([Color? defaultValue])
      : _defaultValue = defaultValue ?? const Color(0xFF3F51B5);

  final Color _defaultValue;
  late Color _value;

  Color get value => _value;
  set value(Color newValue) {
    if (identical(newValue, _value)) return;
    final Color old = _value;
    _value = newValue;
    notifyListeners();
    didUpdateValue(old);
  }

  @override
  Color createDefaultValue() => _defaultValue;

  @override
  void initWithValue(Color value) {
    _value = value;
    notifyListeners();
  }

  @override
  Object toPrimitives() => _value.toARGB32();

  @override
  Color fromPrimitives(Object? data) {
    if (data is int) return Color(data);
    return _defaultValue;
  }

  // Called by our setter (not an override on this Flutter SDK).
  void didUpdateValue(Color? oldValue) {
    notifyListeners();
  }
}
''';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              _dotGlyph(const Color(0xFFEF4444)),
              const SizedBox(width: 6),
              _dotGlyph(const Color(0xFFF59E0B)),
              const SizedBox(width: 6),
              _dotGlyph(const Color(0xFF22C55E)),
              const SizedBox(width: 12),
              const Text(
                '_restorable_color.dart',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            source,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.45,
              color: Color(0xFFE2E8F0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dotGlyph(Color c) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: c,
        shape: BoxShape.circle,
      ),
    );
  }

  // -------------------------------------------------------------------------
  //                          Misc small helpers
  // -------------------------------------------------------------------------

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _primaryColor.value.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: _primaryColor.value),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooterNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Why RestorableProperty exists',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            'Flutter restoration round-trips rebuild your State objects from scratch. Everything you want to survive must live inside a RestorableProperty registered on a RestorationMixin. Built-ins cover primitives and a handful of common types, but anything else — like a Color or a List<String> — needs a custom subclass. This demo hosts three `_RestorableColor` instances and one `_RestorableStringList`, all registered under `${restorationId!}`.',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF334155),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  //                            Utility functions
  // -------------------------------------------------------------------------

  String _hexOf(Color c) {
    final int argb = c.toARGB32();
    final String hex = (argb & 0xFFFFFF).toRadixString(16).toUpperCase().padLeft(6, '0');
    return '#$hex';
  }

  Color _parseHex(String hex) {
    final String cleaned = hex.replaceAll('#', '').trim();
    final int parsed = int.tryParse(cleaned, radix: 16) ?? 0x3F51B5;
    return Color(0xFF000000 | parsed);
  }

  Color _readableForeground(Color background) {
    // Standard luma weighting — dark colours get white text, light colours
    // get near-black text.
    final double luma = 0.2126 * background.r + 0.7152 * background.g + 0.0722 * background.b;
    return luma > 0.55 ? const Color(0xFF0F172A) : Colors.white;
  }

  String _paletteModeLabel(int mode) {
    switch (mode) {
      case 1:
        return 'pastel';
      case 2:
        return 'neon';
      case 0:
      default:
        return 'material';
    }
  }
}

// ---------------------------------------------------------------------------
//                        Lifecycle step value class
// ---------------------------------------------------------------------------

class _LifecycleStep {
  const _LifecycleStep({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;
}
