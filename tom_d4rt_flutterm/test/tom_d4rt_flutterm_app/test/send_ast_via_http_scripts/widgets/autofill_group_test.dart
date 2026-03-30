import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _Palette {
  final String name;
  final Color shell;
  final Color canvas;
  final Color card;
  final Color ink;
  final Color muted;
  final Color accentA;
  final Color accentB;
  final Color accentC;

  const _Palette({
    required this.name,
    required this.shell,
    required this.canvas,
    required this.card,
    required this.ink,
    required this.muted,
    required this.accentA,
    required this.accentB,
    required this.accentC,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Marine Slate',
    shell: Color(0xFF14232D),
    canvas: Color(0xFFF1F9FD),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF1E2F3A),
    muted: Color(0xFF6E8795),
    accentA: Color(0xFF1E78FF),
    accentB: Color(0xFF11A67D),
    accentC: Color(0xFFE49512),
  ),
  _Palette(
    name: 'Pine Ash',
    shell: Color(0xFF1B251D),
    canvas: Color(0xFFF3FAF4),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF273229),
    muted: Color(0xFF748677),
    accentA: Color(0xFF338045),
    accentB: Color(0xFF1F9B88),
    accentC: Color(0xFFC98C2E),
  ),
  _Palette(
    name: 'Plum Alloy',
    shell: Color(0xFF231A2A),
    canvas: Color(0xFFF8F3FB),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF32243A),
    muted: Color(0xFF88779A),
    accentA: Color(0xFF7858E8),
    accentB: Color(0xFFBC428B),
    accentC: Color(0xFF2FA59A),
  ),
];

enum _Stage {
  fundamentals,
  hintGallery,
  checkoutFlow,
  disposeTheater,
  wizardBoundaries,
  compendium,
}

enum _Density {
  sparse,
  normal,
  dense,
}

class _TraceEvent {
  final DateTime at;
  final String source;
  final String message;
  final Color tone;

  const _TraceEvent({
    required this.at,
    required this.source,
    required this.message,
    required this.tone,
  });
}

class _ProbeStatus {
  final String laneId;
  final bool hasGroup;
  final int clientCount;
  final bool mounted;

  const _ProbeStatus({
    required this.laneId,
    required this.hasGroup,
    required this.clientCount,
    required this.mounted,
  });

  String get signature => '$laneId|$hasGroup|$clientCount|$mounted';
}

class _HintSpec {
  final String title;
  final String category;
  final String note;
  final String hint;

  const _HintSpec({
    required this.title,
    required this.category,
    required this.note,
    required this.hint,
  });
}

const _hintSpecs = <_HintSpec>[
  _HintSpec(
    title: 'Email Address',
    category: 'Identity',
    note: 'Primary account contact field.',
    hint: AutofillHints.email,
  ),
  _HintSpec(
    title: 'Username',
    category: 'Identity',
    note: 'Account handle for sign-in.',
    hint: AutofillHints.username,
  ),
  _HintSpec(
    title: 'Password',
    category: 'Identity',
    note: 'Existing credential field.',
    hint: AutofillHints.password,
  ),
  _HintSpec(
    title: 'New Password',
    category: 'Identity',
    note: 'Password update flow field.',
    hint: AutofillHints.newPassword,
  ),
  _HintSpec(
    title: 'Full Name',
    category: 'Profile',
    note: 'Combined personal full name.',
    hint: AutofillHints.name,
  ),
  _HintSpec(
    title: 'Given Name',
    category: 'Profile',
    note: 'First name for profile forms.',
    hint: AutofillHints.givenName,
  ),
  _HintSpec(
    title: 'Family Name',
    category: 'Profile',
    note: 'Last name for profile forms.',
    hint: AutofillHints.familyName,
  ),
  _HintSpec(
    title: 'Phone Number',
    category: 'Contact',
    note: 'Primary telephone contact.',
    hint: AutofillHints.telephoneNumber,
  ),
  _HintSpec(
    title: 'Street Address',
    category: 'Address',
    note: 'Main street address line.',
    hint: AutofillHints.streetAddressLine1,
  ),
  _HintSpec(
    title: 'City',
    category: 'Address',
    note: 'City or locality value.',
    hint: AutofillHints.addressCity,
  ),
  _HintSpec(
    title: 'State',
    category: 'Address',
    note: 'Administrative region entry.',
    hint: AutofillHints.addressState,
  ),
  _HintSpec(
    title: 'Postal Code',
    category: 'Address',
    note: 'Postal or ZIP code field.',
    hint: AutofillHints.postalCode,
  ),
  _HintSpec(
    title: 'Country Name',
    category: 'Address',
    note: 'Country-level address value.',
    hint: AutofillHints.countryName,
  ),
  _HintSpec(
    title: 'Card Number',
    category: 'Payment',
    note: 'Payment card number input.',
    hint: AutofillHints.creditCardNumber,
  ),
  _HintSpec(
    title: 'Card Expiration',
    category: 'Payment',
    note: 'Payment card expiration date.',
    hint: AutofillHints.creditCardExpirationDate,
  ),
  _HintSpec(
    title: 'Card Name',
    category: 'Payment',
    note: 'Cardholder full name field.',
    hint: AutofillHints.creditCardName,
  ),
  _HintSpec(
    title: 'Birthday',
    category: 'Personal',
    note: 'Date of birth complete field.',
    hint: AutofillHints.birthday,
  ),
  _HintSpec(
    title: 'Birthday Day',
    category: 'Personal',
    note: 'Birth day segment field.',
    hint: AutofillHints.birthdayDay,
  ),
  _HintSpec(
    title: 'Birthday Month',
    category: 'Personal',
    note: 'Birth month segment field.',
    hint: AutofillHints.birthdayMonth,
  ),
  _HintSpec(
    title: 'Birthday Year',
    category: 'Personal',
    note: 'Birth year segment field.',
    hint: AutofillHints.birthdayYear,
  ),
];

dynamic build(BuildContext context) {
  return const _AutofillGroupDeepDemo();
}

class _AutofillGroupDeepDemo extends StatefulWidget {
  const _AutofillGroupDeepDemo();

  @override
  State<_AutofillGroupDeepDemo> createState() => _AutofillGroupDeepDemoState();
}

class _AutofillGroupDeepDemoState extends State<_AutofillGroupDeepDemo> {
  _Stage _stage = _Stage.fundamentals;
  _Density _density = _Density.normal;
  int _paletteIndex = 0;

  bool _showTips = true;
  bool _showMetrics = true;
  bool _showTimeline = true;
  bool _verbose = false;
  bool _billingSameAsShipping = false;
  bool _showWizardSummary = true;

  AutofillContextAction _fundamentalAction = AutofillContextAction.commit;
  AutofillContextAction _checkoutAction = AutofillContextAction.commit;
  AutofillContextAction _disposeActionA = AutofillContextAction.commit;
  AutofillContextAction _disposeActionB = AutofillContextAction.cancel;

  double _laneHeight = 380;
  final double _galleryHeight = 370;
  int _dynamicAddressLines = 1;

  int _probeEvents = 0;
  int _manualActionEvents = 0;
  int _selectionEvents = 0;

  int _wizardStep = 0;

  final List<_TraceEvent> _timeline = <_TraceEvent>[];
  final Map<String, _ProbeStatus> _probeMap = <String, _ProbeStatus>{};

  static const _stageTitles = <String>[
    '1 Group Fundamentals Studio',
    '2 Autofill Hint Gallery',
    '3 Checkout Flow Composition',
    '4 Dispose Action Theater',
    '5 Wizard Group Boundaries',
    '6 Verification Compendium',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  int get _effectiveDynamicAddressLines {
    switch (_density) {
      case _Density.sparse:
        return (_dynamicAddressLines * 0.7).round().clamp(1, 4);
      case _Density.normal:
        return _dynamicAddressLines;
      case _Density.dense:
        return (_dynamicAddressLines * 1.6).round().clamp(1, 4);
    }
  }

  @override
  void initState() {
    super.initState();
    _pushTrace('system', 'AutofillGroup deep demo initialized.', _p.accentA);
  }

  void _pushTrace(String source, String message, Color tone) {
    final event = _TraceEvent(at: DateTime.now(), source: source, message: message, tone: tone);
    setState(() {
      _timeline.insert(0, event);
      if (_timeline.length > 70) {
        _timeline.removeRange(70, _timeline.length);
      }
    });
    if (_verbose) {
      debugPrint('[AutofillGroup][$source] $message');
    }
  }

  void _onProbe(_ProbeStatus status) {
    final old = _probeMap[status.laneId];
    if (old != null && old.signature == status.signature) {
      return;
    }
    setState(() {
      _probeMap[status.laneId] = status;
      _probeEvents += 1;
    });
    _pushTrace(
      status.laneId,
      'group=${status.hasGroup}, clients=${status.clientCount}, mounted=${status.mounted}',
      _p.accentB,
    );
  }

  void _onManualAction(String lane, bool save) {
    setState(() => _manualActionEvents += 1);
    _pushTrace(lane, 'finishAutofillContext(shouldSave: $save)', save ? _p.accentA : _p.accentC);
  }

  void _onSelection(String lane, String note) {
    setState(() => _selectionEvents += 1);
    _pushTrace(lane, note, _p.accentC);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.canvas,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _header(),
            _toolbar(),
            Expanded(child: _stageBody()),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.shell, _p.accentA.withValues(alpha: 0.87)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.badge_outlined, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'AutofillGroup Deep Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Grouped Autofill Scope',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'AutofillGroup defines a logical autofill scope for related fields. '
            'This demo explores scope composition, hints, dynamic forms, '
            'dispose behavior, and grouped wizard flows with visual diagnostics.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.94),
              fontSize: 12.3,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      width: double.infinity,
      color: _p.accentA.withValues(alpha: 0.07),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text('Stage', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _stageTitles.length; i++) _stageChip(i),
          const SizedBox(width: 10),
          Text('Density', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          _densityChip('Sparse', _Density.sparse),
          _densityChip('Normal', _Density.normal),
          _densityChip('Dense', _Density.dense),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
        ],
      ),
    );
  }

  Widget _stageChip(int index) {
    return ChoiceChip(
      selected: _stage.index == index,
      selectedColor: _p.accentA,
      backgroundColor: Colors.white,
      label: Text('${index + 1}'),
      labelStyle: TextStyle(
        color: _stage.index == index ? Colors.white : _p.ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => setState(() => _stage = _Stage.values[index]),
    );
  }

  Widget _densityChip(String label, _Density value) {
    return ChoiceChip(
      selected: _density == value,
      selectedColor: _p.accentB,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _density == value ? Colors.white : _p.ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => setState(() => _density = value),
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () => setState(() => _paletteIndex = index),
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].accentA,
          border: Border.all(
            color: _paletteIndex == index ? _palettes[index].accentC : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _stageBody() {
    switch (_stage) {
      case _Stage.fundamentals:
        return _fundamentalsStage();
      case _Stage.hintGallery:
        return _hintGalleryStage();
      case _Stage.checkoutFlow:
        return _checkoutFlowStage();
      case _Stage.disposeTheater:
        return _disposeTheaterStage();
      case _Stage.wizardBoundaries:
        return _wizardStage();
      case _Stage.compendium:
        return _compendiumStage();
    }
  }

  Widget _fundamentalsStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Group Fundamentals Studio'),
          const SizedBox(height: 8),
          Text(
            'Fundamentals stage introduces AutofillGroup as a scope boundary. '
            'The probe card reads active group state and client registry counts.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Global Controls',
            subtitle: 'Tune lane sizes, action presets, and diagnostics visibility.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'lane height',
                  value: _laneHeight,
                  min: 300,
                  max: 620,
                  divisions: 32,
                  color: _p.accentA,
                  onChanged: (v) => setState(() => _laneHeight = v),
                ),
                _slider(
                  label: 'dynamic address lines',
                  value: _dynamicAddressLines.toDouble(),
                  min: 1,
                  max: 4,
                  divisions: 3,
                  color: _p.accentB,
                  onChanged: (v) => setState(() => _dynamicAddressLines = v.round()),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _toggleChip('show tips', _showTips, (v) => _showTips = v),
                    _toggleChip('show metrics', _showMetrics, (v) => _showMetrics = v),
                    _toggleChip('show timeline', _showTimeline, (v) => _showTimeline = v),
                    _toggleChip('billing same as shipping', _billingSameAsShipping, (v) => _billingSameAsShipping = v),
                    _toggleChip('verbose logs', _verbose, (v) => _verbose = v),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Text('fundamental onDisposeAction', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.4)),
                    const SizedBox(width: 10),
                    DropdownButton<AutofillContextAction>(
                      value: _fundamentalAction,
                      items: AutofillContextAction.values
                          .map(
                            (action) => DropdownMenuItem<AutofillContextAction>(
                              value: action,
                              child: Text(action.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _fundamentalAction = value);
                          _pushTrace('policy', 'fundamental action -> ${value.name}', _p.accentA);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              SizedBox(
                width: 510,
                child: _panel(
                  title: 'Account Group Lane',
                  subtitle: 'Single account form under one AutofillGroup.',
                  tint: _p.accentA.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _laneHeight,
                    child: _AutofillGroupLane(
                      laneId: 'fundamentals-account',
                      title: 'Account Group',
                      subtitle: 'Core identity fields grouped for sign-in profile.',
                      palette: _p,
                      onDisposeAction: _fundamentalAction,
                      dynamicAddressLines: _effectiveDynamicAddressLines,
                      includePaymentSection: false,
                      includeShippingSection: false,
                      showTips: _showTips,
                      onProbe: _onProbe,
                      onTrace: _pushTrace,
                      onManualAction: _onManualAction,
                      onSelection: _onSelection,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 510,
                child: _panel(
                  title: 'Profile Group Lane',
                  subtitle: 'Extended profile fields with optional address lines.',
                  tint: _p.accentB.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _laneHeight,
                    child: _AutofillGroupLane(
                      laneId: 'fundamentals-profile',
                      title: 'Profile Group',
                      subtitle: 'Identity + address grouping with registry probe updates.',
                      palette: _p,
                      onDisposeAction: _fundamentalAction,
                      dynamicAddressLines: _effectiveDynamicAddressLines,
                      includePaymentSection: false,
                      includeShippingSection: true,
                      showTips: _showTips,
                      onProbe: _onProbe,
                      onTrace: _pushTrace,
                      onManualAction: _onManualAction,
                      onSelection: _onSelection,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showMetrics) ...<Widget>[
            const SizedBox(height: 12),
            _metricsPanel(),
          ],
        ],
      ),
    );
  }

  Widget _hintGalleryStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Autofill Hint Gallery'),
          const SizedBox(height: 8),
          Text(
            'Hint gallery presents a visual catalog of common AutofillHints '
            'grouped by category, each rendered inside an AutofillGroup scope.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Hint Gallery Surface',
            subtitle: 'Visual cards demonstrate field semantics and intended use.',
            tint: _p.accentC.withValues(alpha: 0.04),
            child: SizedBox(
              height: _galleryHeight,
              child: AutofillGroup(
                onDisposeAction: AutofillContextAction.commit,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.55,
                  ),
                  itemCount: _hintSpecs.length,
                  itemBuilder: (context, index) {
                    final spec = _hintSpecs[index];
                    return _hintCard(spec, index);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hintCard(_HintSpec spec, int index) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: _p.muted.withValues(alpha: 0.23)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _pill(spec.category, index.isEven ? _p.accentA : _p.accentB),
              const Spacer(),
              Text(
                '#${index + 1}',
                style: TextStyle(color: _p.muted, fontSize: 10.1, fontFamily: 'monospace'),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(spec.title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text(spec.note, style: TextStyle(color: _p.muted, fontSize: 10.6, height: 1.3)),
          const SizedBox(height: 6),
          TextField(
            autofillHints: <String>[spec.hint],
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: _p.canvas,
              hintText: spec.hint,
              hintStyle: TextStyle(color: _p.muted, fontSize: 10.4),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkoutFlowStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Checkout Flow Composition'),
          const SizedBox(height: 8),
          Text(
            'Checkout stage demonstrates multiple AutofillGroup scopes for '
            'shipping, billing, and payment sections in realistic form composition.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Checkout Controls',
            subtitle: 'Toggle billing linkage and configure checkout dispose behavior.',
            child: Row(
              children: <Widget>[
                FilterChip(
                  selected: _billingSameAsShipping,
                  label: const Text('billing same as shipping'),
                  onSelected: (v) {
                    setState(() => _billingSameAsShipping = v);
                    _pushTrace('checkout', 'billing same as shipping -> $v', _p.accentB);
                  },
                ),
                const SizedBox(width: 14),
                Text('checkout action', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.3)),
                const SizedBox(width: 8),
                DropdownButton<AutofillContextAction>(
                  value: _checkoutAction,
                  items: AutofillContextAction.values
                      .map(
                        (action) => DropdownMenuItem<AutofillContextAction>(
                          value: action,
                          child: Text(action.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _checkoutAction = value);
                      _pushTrace('checkout', 'checkout action -> ${value.name}', _p.accentA);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Checkout Form Matrix',
            subtitle: 'Three groups: shipping, billing, and payment.',
            tint: _p.accentA.withValues(alpha: 0.03),
            child: SizedBox(
              height: _laneHeight + 90,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: _AutofillGroupLane(
                      laneId: 'checkout-shipping',
                      title: 'Shipping Group',
                      subtitle: 'Delivery address and recipient identity.',
                      palette: _p,
                      onDisposeAction: _checkoutAction,
                      dynamicAddressLines: _effectiveDynamicAddressLines,
                      includePaymentSection: false,
                      includeShippingSection: true,
                      showTips: _showTips,
                      onProbe: _onProbe,
                      onTrace: _pushTrace,
                      onManualAction: _onManualAction,
                      onSelection: _onSelection,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _AutofillGroupLane(
                      laneId: 'checkout-billing',
                      title: 'Billing Group',
                      subtitle: _billingSameAsShipping
                          ? 'Linked billing profile for simplified checkout.'
                          : 'Independent billing identity and address.',
                      palette: _p,
                      onDisposeAction: _checkoutAction,
                      dynamicAddressLines: _billingSameAsShipping ? 1 : _effectiveDynamicAddressLines,
                      includePaymentSection: false,
                      includeShippingSection: true,
                      showTips: _showTips,
                      onProbe: _onProbe,
                      onTrace: _pushTrace,
                      onManualAction: _onManualAction,
                      onSelection: _onSelection,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _AutofillGroupLane(
                      laneId: 'checkout-payment',
                      title: 'Payment Group',
                      subtitle: 'Payment fields grouped separately from addresses.',
                      palette: _p,
                      onDisposeAction: _checkoutAction,
                      dynamicAddressLines: 1,
                      includePaymentSection: true,
                      includeShippingSection: false,
                      showTips: _showTips,
                      onProbe: _onProbe,
                      onTrace: _pushTrace,
                      onManualAction: _onManualAction,
                      onSelection: _onSelection,
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

  Widget _disposeTheaterStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Dispose Action Theater'),
          const SizedBox(height: 8),
          Text(
            'Theater stage compares commit and cancel disposal defaults and '
            'manual finishAutofillContext actions through independent lanes.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Theater Action Selectors',
            subtitle: 'Choose per-lane onDisposeAction values for comparison.',
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              children: <Widget>[
                _actionSelector('lane A action', _disposeActionA, (v) => setState(() => _disposeActionA = v)),
                _actionSelector('lane B action', _disposeActionB, (v) => setState(() => _disposeActionB = v)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              SizedBox(
                width: 510,
                child: _panel(
                  title: 'Theater Lane A',
                  subtitle: 'Action and manual finish buttons.',
                  tint: _p.accentA.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _laneHeight,
                    child: _AutofillGroupLane(
                      laneId: 'theater-a',
                      title: 'Theater Group A',
                      subtitle: 'Use save/cancel buttons to trigger explicit context finish.',
                      palette: _p,
                      onDisposeAction: _disposeActionA,
                      dynamicAddressLines: _effectiveDynamicAddressLines,
                      includePaymentSection: false,
                      includeShippingSection: true,
                      showTips: _showTips,
                      onProbe: _onProbe,
                      onTrace: _pushTrace,
                      onManualAction: _onManualAction,
                      onSelection: _onSelection,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 510,
                child: _panel(
                  title: 'Theater Lane B',
                  subtitle: 'Independent lane for policy contrast.',
                  tint: _p.accentB.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _laneHeight,
                    child: _AutofillGroupLane(
                      laneId: 'theater-b',
                      title: 'Theater Group B',
                      subtitle: 'Contrast group behavior with alternate action default.',
                      palette: _p,
                      onDisposeAction: _disposeActionB,
                      dynamicAddressLines: _effectiveDynamicAddressLines,
                      includePaymentSection: false,
                      includeShippingSection: true,
                      showTips: _showTips,
                      onProbe: _onProbe,
                      onTrace: _pushTrace,
                      onManualAction: _onManualAction,
                      onSelection: _onSelection,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _wizardStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Wizard Group Boundaries'),
          const SizedBox(height: 8),
          Text(
            'Wizard stage models multi-step flows where each step has its own '
            'AutofillGroup boundary and focused field semantics.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Wizard Navigator',
            subtitle: 'Switch between step-scoped AutofillGroup lanes.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (var i = 0; i < 3; i++)
                  ChoiceChip(
                    selected: _wizardStep == i,
                    selectedColor: _p.accentA,
                    backgroundColor: Colors.white,
                    label: Text('Step ${i + 1}'),
                    labelStyle: TextStyle(
                      color: _wizardStep == i ? Colors.white : _p.ink,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                    onSelected: (_) {
                      setState(() => _wizardStep = i);
                      _pushTrace('wizard', 'step -> ${i + 1}', _p.accentA);
                    },
                  ),
                const SizedBox(width: 10),
                _toggleChip('show summary', _showWizardSummary, (v) => _showWizardSummary = v),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Wizard Step Lane',
            subtitle: 'Step-specific AutofillGroup structures and probes.',
            tint: _p.accentC.withValues(alpha: 0.04),
            child: SizedBox(
              height: _laneHeight + 40,
              child: IndexedStack(
                index: _wizardStep,
                children: <Widget>[
                  _AutofillGroupLane(
                    laneId: 'wizard-step-1',
                    title: 'Step 1: Identity',
                    subtitle: 'Collect name and email in dedicated group.',
                    palette: _p,
                    onDisposeAction: AutofillContextAction.commit,
                    dynamicAddressLines: 1,
                    includePaymentSection: false,
                    includeShippingSection: false,
                    showTips: _showTips,
                    onProbe: _onProbe,
                    onTrace: _pushTrace,
                    onManualAction: _onManualAction,
                    onSelection: _onSelection,
                  ),
                  _AutofillGroupLane(
                    laneId: 'wizard-step-2',
                    title: 'Step 2: Address',
                    subtitle: 'Address-focused group with dynamic optional lines.',
                    palette: _p,
                    onDisposeAction: AutofillContextAction.commit,
                    dynamicAddressLines: _effectiveDynamicAddressLines,
                    includePaymentSection: false,
                    includeShippingSection: true,
                    showTips: _showTips,
                    onProbe: _onProbe,
                    onTrace: _pushTrace,
                    onManualAction: _onManualAction,
                    onSelection: _onSelection,
                  ),
                  _AutofillGroupLane(
                    laneId: 'wizard-step-3',
                    title: 'Step 3: Payment',
                    subtitle: 'Payment data grouped independently from profile.',
                    palette: _p,
                    onDisposeAction: AutofillContextAction.commit,
                    dynamicAddressLines: 1,
                    includePaymentSection: true,
                    includeShippingSection: false,
                    showTips: _showTips,
                    onProbe: _onProbe,
                    onTrace: _pushTrace,
                    onManualAction: _onManualAction,
                    onSelection: _onSelection,
                  ),
                ],
              ),
            ),
          ),
          if (_showWizardSummary) ...<Widget>[
            const SizedBox(height: 12),
            _panel(
              title: 'Wizard Summary',
              subtitle: 'Current probe status by wizard step.',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (final id in <String>['wizard-step-1', 'wizard-step-2', 'wizard-step-3'])
                    _probeTile(id),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _probeTile(String id) {
    final status = _probeMap[id];
    return Container(
      width: 300,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(id, style: TextStyle(color: _p.accentA, fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 10.8)),
          const SizedBox(height: 4),
          Text(
            status == null
                ? 'No probe snapshot yet.'
                : 'group=${status.hasGroup}, clients=${status.clientCount}, mounted=${status.mounted}',
            style: TextStyle(color: _p.ink, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _compendiumStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Verification Compendium'),
          const SizedBox(height: 12),
          _panel(
            title: 'AutofillGroup Matrix',
            subtitle: 'Component purpose, composition patterns, and runtime behavior.',
            child: Column(
              children: <Widget>[
                _matrix('Purpose', 'Define a scope that groups related autofill fields.'),
                _matrix('Primary use', 'Wrap logically related TextField/TextFormField widgets.'),
                _matrix('Scope access', 'Use AutofillGroup.maybeOf(context) or AutofillGroup.of(context).'),
                _matrix('Client registry', 'Group state tracks active autofill clients in scope.'),
                _matrix('Dispose behavior', 'onDisposeAction controls commit/cancel intent on dispose.'),
                _matrix('Manual completion', 'TextInput.finishAutofillContext can explicitly save/cancel context.'),
                _matrix('Best practice', 'Use separate groups for independent form segments (shipping vs payment).'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Guidance for robust AutofillGroup integrations.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do align group boundaries with user intent',
                  detail: 'Separate unrelated domains into different groups for predictable behavior.',
                ),
                _doDont(
                  good: true,
                  title: 'Do provide proper autofillHints for each field',
                  detail: 'Hints guide platform autofill services to supply accurate values.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont mix payment and profile fields in one huge group',
                  detail: 'Overly broad groups can reduce autofill clarity and maintainability.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont ignore disposal semantics in flows with teardown',
                  detail: 'Explicitly choose commit or cancel semantics where group disposal is common.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common AutofillGroup implementation questions.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'When should I create multiple AutofillGroup widgets?',
                  a: 'Use multiple groups when form segments represent distinct user intents (account, shipping, payment).',
                ),
                _qa(
                  q: 'What does onDisposeAction affect?',
                  a: 'It determines whether the active autofill context is committed or canceled when the group disposes.',
                ),
                _qa(
                  q: 'Can I manually finish autofill while group is still mounted?',
                  a: 'Yes. TextInput.finishAutofillContext lets you force save or cancel from explicit actions.',
                ),
                _qa(
                  q: 'How can I verify grouping behavior visually?',
                  a: 'Use probe widgets and timeline logs to compare client counts and action events across lanes.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo acceptance for this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Fundamentals stage with two distinct AutofillGroup lane compositions.'),
                _check('Hint gallery stage with multiple hint-specific visual cards.'),
                _check('Checkout flow stage showing shipping, billing, and payment group separation.'),
                _check('Dispose theater stage comparing commit/cancel with manual finish actions.'),
                _check('Wizard stage demonstrating per-step group boundaries and probe summaries.'),
                _check('Compendium stage with matrix, do/dont, FAQ, and checklist guidance.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _notice(
            'AutofillGroup is a structure and lifecycle boundary, not just a wrapper. '
            'This deep demo visualizes grouped composition patterns that help validate '
            'interpreter interaction behavior in realistic multi-form surfaces.',
          ),
        ],
      ),
    );
  }

  Widget _actionSelector(
    String label,
    AutofillContextAction current,
    ValueChanged<AutofillContextAction> onChanged,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(label, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.4)),
        const SizedBox(width: 8),
        DropdownButton<AutofillContextAction>(
          value: current,
          items: AutofillContextAction.values
              .map(
                (action) => DropdownMenuItem<AutofillContextAction>(
                  value: action,
                  child: Text(action.name),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
              _pushTrace('policy', '$label -> ${value.name}', _p.accentA);
            }
          },
        ),
      ],
    );
  }

  Widget _metricsPanel() {
    return _panel(
      title: 'Global Metrics',
      subtitle: 'Probe snapshots and manual action counts.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _chip('probe events', '$_probeEvents', _p.accentA),
          _chip('manual actions', '$_manualActionEvents', _p.accentB),
          _chip('selections', '$_selectionEvents', _p.accentC),
          _chip('tracked lanes', '${_probeMap.length}', _p.accentA),
        ],
      ),
    );
  }

  Widget _toggleChip(String label, bool value, void Function(bool value) assign) {
    return FilterChip(
      selected: value,
      selectedColor: _p.accentA.withValues(alpha: 0.18),
      backgroundColor: Colors.white,
      checkmarkColor: _p.accentA,
      label: Text(label),
      labelStyle: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11),
      onSelected: (selected) => setState(() => assign(selected)),
    );
  }

  Widget _slider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 180,
          child: Text(
            '$label: ${value.toStringAsFixed(0)}',
            style: TextStyle(color: _p.ink, fontSize: 12),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: color,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: <Widget>[
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(color: _p.accentA, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: _p.ink, fontSize: 18, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _panel({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? _p.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 14)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 11.3)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _chip(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tone.withValues(alpha: 0.34)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _p.ink,
          fontFamily: 'monospace',
          fontSize: 10.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _pill(String text, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(color: _p.ink, fontSize: 9.9, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _matrix(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 190,
            child: Text(
              key,
              style: TextStyle(
                color: _p.accentA,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 11.1,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.33))),
        ],
      ),
    );
  }

  Widget _doDont({required bool good, required String title, required String detail}) {
    final tone = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(good ? Icons.check_circle : Icons.cancel, color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 11.3, height: 1.33)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qa({required String q, required String a}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Q: $q', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text('A: $a', style: TextStyle(color: _p.muted, fontSize: 11.4, height: 1.34)),
        ],
      ),
    );
  }

  Widget _check(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _notice(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _p.accentC.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.accentC.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.info_outline, color: _p.accentC, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12, height: 1.34))),
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _p.shell.withValues(alpha: 0.06),
      child: Row(
        children: <Widget>[
          Text(_stageTitles[_stage.index], style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _AutofillGroupLane extends StatefulWidget {
  const _AutofillGroupLane({
    required this.laneId,
    required this.title,
    required this.subtitle,
    required this.palette,
    required this.onDisposeAction,
    required this.dynamicAddressLines,
    required this.includePaymentSection,
    required this.includeShippingSection,
    required this.showTips,
    required this.onProbe,
    required this.onTrace,
    required this.onManualAction,
    required this.onSelection,
  });

  final String laneId;
  final String title;
  final String subtitle;
  final _Palette palette;
  final AutofillContextAction onDisposeAction;
  final int dynamicAddressLines;
  final bool includePaymentSection;
  final bool includeShippingSection;
  final bool showTips;
  final ValueChanged<_ProbeStatus> onProbe;
  final void Function(String source, String message, Color tone) onTrace;
  final void Function(String lane, bool save) onManualAction;
  final void Function(String lane, String note) onSelection;

  @override
  State<_AutofillGroupLane> createState() => _AutofillGroupLaneState();
}

class _AutofillGroupLaneState extends State<_AutofillGroupLane> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _address1 = TextEditingController();
  final _city = TextEditingController();
  final _postal = TextEditingController();
  final _cardNumber = TextEditingController();
  final _cardName = TextEditingController();
  final _cardExpiry = TextEditingController();

  late List<TextEditingController> _extraLines;

  @override
  void initState() {
    super.initState();
    _extraLines = List<TextEditingController>.generate(
      widget.dynamicAddressLines,
      (index) => TextEditingController(),
    );
  }

  @override
  void didUpdateWidget(covariant _AutofillGroupLane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dynamicAddressLines != oldWidget.dynamicAddressLines) {
      _syncExtraLines(widget.dynamicAddressLines);
    }
  }

  void _syncExtraLines(int target) {
    final next = target.clamp(1, 4);
    final current = _extraLines.length;
    if (next == current) {
      return;
    }
    if (next > current) {
      _extraLines.addAll(List<TextEditingController>.generate(next - current, (_) => TextEditingController()));
    } else {
      for (var i = current - 1; i >= next; i--) {
        _extraLines[i].dispose();
      }
      _extraLines = _extraLines.take(next).toList();
    }
    setState(() {});
    widget.onTrace(widget.laneId, 'extra address lines -> ${_extraLines.length}', widget.palette.accentB);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _address1.dispose();
    _city.dispose();
    _postal.dispose();
    _cardNumber.dispose();
    _cardName.dispose();
    _cardExpiry.dispose();
    for (final c in _extraLines) {
      c.dispose();
    }
    super.dispose();
  }

  void _finish(bool save) {
    TextInput.finishAutofillContext(shouldSave: save);
    widget.onManualAction(widget.laneId, save);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: AutofillGroup(
          onDisposeAction: widget.onDisposeAction,
          child: Builder(
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _laneHeader(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _identitySection(),
                                if (widget.includeShippingSection) ...<Widget>[
                                  const SizedBox(height: 10),
                                  _shippingSection(),
                                ],
                                if (widget.includePaymentSection) ...<Widget>[
                                  const SizedBox(height: 10),
                                  _paymentSection(),
                                ],
                                const SizedBox(height: 10),
                                _actionBar(),
                                const SizedBox(height: 10),
                                _AutofillGroupProbe(
                                  laneId: widget.laneId,
                                  palette: widget.palette,
                                  onProbe: widget.onProbe,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(width: 180, child: _sideRail()),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _laneHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w800, fontSize: 13.4)),
              const SizedBox(height: 2),
              Text(widget.subtitle, style: TextStyle(color: widget.palette.muted, fontSize: 10.9)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: widget.palette.accentA.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'dispose: ${widget.onDisposeAction.name}',
            style: TextStyle(
              color: widget.palette.ink,
              fontFamily: 'monospace',
              fontSize: 10.1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _identitySection() {
    return _sectionCard(
      title: 'Identity',
      tone: widget.palette.accentA,
      child: Column(
        children: <Widget>[
          _field(_name, 'Full name', const <String>[AutofillHints.name], Icons.person_outline),
          const SizedBox(height: 8),
          _field(_email, 'Email', const <String>[AutofillHints.email], Icons.alternate_email, keyboard: TextInputType.emailAddress),
          const SizedBox(height: 8),
          _field(_phone, 'Phone', const <String>[AutofillHints.telephoneNumber], Icons.phone_outlined, keyboard: TextInputType.phone),
        ],
      ),
    );
  }

  Widget _shippingSection() {
    return _sectionCard(
      title: 'Shipping',
      tone: widget.palette.accentB,
      child: Column(
        children: <Widget>[
          _field(_address1, 'Street line 1', const <String>[AutofillHints.streetAddressLine1], Icons.home_outlined),
          for (var i = 0; i < _extraLines.length; i++) ...<Widget>[
            const SizedBox(height: 8),
            _field(
              _extraLines[i],
              'Street line ${i + 2}',
              const <String>[AutofillHints.streetAddressLine2],
              Icons.short_text,
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: _field(_city, 'City', const <String>[AutofillHints.addressCity], Icons.location_city_outlined),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _field(_postal, 'Postal', const <String>[AutofillHints.postalCode], Icons.markunread_mailbox_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paymentSection() {
    return _sectionCard(
      title: 'Payment',
      tone: widget.palette.accentC,
      child: Column(
        children: <Widget>[
          _field(_cardName, 'Cardholder name', const <String>[AutofillHints.creditCardName], Icons.badge_outlined),
          const SizedBox(height: 8),
          _field(_cardNumber, 'Card number', const <String>[AutofillHints.creditCardNumber], Icons.credit_card_outlined, keyboard: TextInputType.number),
          const SizedBox(height: 8),
          _field(_cardExpiry, 'Expiry date', const <String>[AutofillHints.creditCardExpirationDate], Icons.event_outlined),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    List<String> hints,
    IconData icon, {
    TextInputType? keyboard,
  }) {
    return TextField(
      controller: controller,
      autofillHints: hints,
      keyboardType: keyboard,
      onChanged: (value) {
        if (value.isNotEmpty && value.length % 6 == 0) {
          widget.onSelection(widget.laneId, '$label reached ${value.length} chars');
        }
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: widget.palette.accentA),
        filled: true,
        fillColor: widget.palette.canvas,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _sectionCard({required String title, required Color tone, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 11.8)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _actionBar() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        FilledButton.icon(
          onPressed: () => _finish(true),
          icon: const Icon(Icons.save_outlined, size: 16),
          label: const Text('finish save'),
        ),
        OutlinedButton.icon(
          onPressed: () => _finish(false),
          icon: const Icon(Icons.cancel_outlined, size: 16),
          label: const Text('finish cancel'),
        ),
      ],
    );
  }

  Widget _sideRail() {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.palette.accentA.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Inspector', style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 11.8)),
          const SizedBox(height: 8),
          _line('lane', widget.laneId),
          _line('action', widget.onDisposeAction.name),
          _line('extra lines', '${_extraLines.length}'),
          _line('shipping', '${widget.includeShippingSection}'),
          _line('payment', '${widget.includePaymentSection}'),
          const SizedBox(height: 8),
          if (widget.showTips)
            Text(
              'Tip: grouped fields improve autofill context relevance and maintainability.',
              style: TextStyle(color: widget.palette.muted, fontSize: 10.3, height: 1.3),
            ),
        ],
      ),
    );
  }

  Widget _line(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 72,
            child: Text(
              key,
              style: TextStyle(color: widget.palette.muted, fontFamily: 'monospace', fontSize: 9.8),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: widget.palette.ink, fontSize: 10.2))),
        ],
      ),
    );
  }
}

class _AutofillGroupProbe extends StatefulWidget {
  const _AutofillGroupProbe({
    required this.laneId,
    required this.palette,
    required this.onProbe,
  });

  final String laneId;
  final _Palette palette;
  final ValueChanged<_ProbeStatus> onProbe;

  @override
  State<_AutofillGroupProbe> createState() => _AutofillGroupProbeState();
}

class _AutofillGroupProbeState extends State<_AutofillGroupProbe> {
  String _last = '';

  @override
  Widget build(BuildContext context) {
    final state = AutofillGroup.maybeOf(context);
    final hasGroup = state != null;
    final count = state?.autofillClients.length ?? 0;
    final mounted = state?.mounted ?? false;

    final snapshot = _ProbeStatus(
      laneId: widget.laneId,
      hasGroup: hasGroup,
      clientCount: count,
      mounted: mounted,
    );

    if (_last != snapshot.signature) {
      _last = snapshot.signature;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onProbe(snapshot);
        }
      });
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: widget.palette.accentC.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: widget.palette.accentC.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('AutofillGroup Probe', style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 11.8)),
          const SizedBox(height: 6),
          _row('has group', '$hasGroup'),
          _row('client count', '$count'),
          _row('mounted', '$mounted'),
        ],
      ),
    );
  }

  Widget _row(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 92,
            child: Text(
              key,
              style: TextStyle(color: widget.palette.ink, fontFamily: 'monospace', fontSize: 10),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: widget.palette.ink, fontSize: 10.4))),
        ],
      ),
    );
  }
}
