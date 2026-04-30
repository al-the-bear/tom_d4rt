import 'package:flutter/material.dart';

// =============================================================================
// RestorableString — Label Printer Studio demo.
//
// This deep-demo script illustrates how a SINGLE non-nullable string value,
// managed by `RestorableString`, can drive radically different visual
// representations — a shipping label, a retail price tag, a neon storefront
// sign, and a mailed envelope — all while remaining restorable across
// navigation, hot reload, and process death via the Flutter RestorationMixin.
//
// The teaching contrast against `RestorableStringN` (the nullable cousin) is
// that `RestorableString` always holds a value — even if that value is the
// empty string. There is no "unset" state. The envelope, label, and sign
// always have SOMETHING to render; the only question is WHAT.
// =============================================================================

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RestorableString — Label Printer Studio',
    restorationScopeId: 'label_printer_root',
    home: LabelPrinterStudioDemo(),
  );
}

// =============================================================================
// Palette constants — hand-tuned so every preview card has its own identity
// while still sharing a warm off-white chrome.
// =============================================================================

const Color _kChromeBackground = Color(0xFFF6F1E7);
const Color _kChromeCard = Color(0xFFFFFDF7);
const Color _kChromeText = Color(0xFF24201B);
const Color _kChromeMuted = Color(0xFF6A5F4E);
const Color _kChromeAccent = Color(0xFF7A5A2E);

const Color _kShippingPaper = Color(0xFFE8D9B4);
const Color _kShippingInk = Color(0xFF1A1611);
const Color _kShippingStripe = Color(0xFF000000);

const Color _kTagCream = Color(0xFFFFF3DC);
const Color _kTagRed = Color(0xFFB5321B);
const Color _kTagInk = Color(0xFF3A1A0F);
const Color _kTagStrike = Color(0xFF7A5A2E);

const Color _kSignBackground = Color(0xFF0A0A0C);
const Color _kSignNeon = Color(0xFFFF3B3B);
const Color _kSignDim = Color(0xFFFFB5B5);

const Color _kEnvelopePaper = Color(0xFFFFFFFF);
const Color _kEnvelopeFlap = Color(0xFFF1EEE3);
const Color _kEnvelopeAccent = Color(0xFF5F7A3A);
const Color _kEnvelopeStamp = Color(0xFFC44B3A);

// =============================================================================
// Defaults — factory values applied on first launch and on "Reset".
// =============================================================================

const String _kDefaultProductName = 'Artisan Sourdough 600g';
const String _kDefaultSku = 'SKU-00042-ASD';
const String _kDefaultTagline = 'Baked fresh, every dawn.';
const String _kDefaultAddress =
    '42 Baker Street\nLondon NW1 6XE\nUnited Kingdom';
const String _kDefaultNeonText = 'OPEN';
const int _kDefaultFontFamilyIndex = 0;

// =============================================================================
// Typography families — four synthetic "families" expressed purely via
// TextStyle combinations. The ACTIVE family is stored in a RestorableInt and
// applied to the hero shipping preview's product name.
// =============================================================================

class _FontFamilyDescriptor {
  const _FontFamilyDescriptor({
    required this.label,
    required this.style,
    required this.description,
  });

  final String label;
  final TextStyle style;
  final String description;
}

const List<_FontFamilyDescriptor> _kFontFamilies = <_FontFamilyDescriptor>[
  _FontFamilyDescriptor(
    label: 'Serif Bold',
    description: 'Traditional newspaper-style nameplate.',
    style: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w800,
      fontFamily: 'Georgia',
      letterSpacing: 0.4,
      color: _kChromeText,
    ),
  ),
  _FontFamilyDescriptor(
    label: 'Mono',
    description: 'Fixed-width, terminal-friendly identifiers.',
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      fontFamily: 'Courier',
      letterSpacing: 1.2,
      color: _kChromeText,
    ),
  ),
  _FontFamilyDescriptor(
    label: 'Italic Script',
    description: 'Soft, handwritten storefront signage.',
    style: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.italic,
      letterSpacing: 0.2,
      color: _kChromeText,
    ),
  ),
  _FontFamilyDescriptor(
    label: 'Condensed Caps',
    description: 'Tall, narrow, uppercase billboard style.',
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w900,
      letterSpacing: 2.4,
      color: _kChromeText,
    ),
  ),
];

// =============================================================================
// Root widget
// =============================================================================

class LabelPrinterStudioDemo extends StatefulWidget {
  const LabelPrinterStudioDemo({super.key});

  @override
  State<LabelPrinterStudioDemo> createState() => _LabelPrinterStudioDemoState();
}

class _LabelPrinterStudioDemoState extends State<LabelPrinterStudioDemo>
    with RestorationMixin {
  // ---------------------------------------------------------------------------
  // RestorableString fields. Each one is always-set (never nullable), which is
  // the key teaching distinction from RestorableStringN.
  // ---------------------------------------------------------------------------

  final RestorableString _productName =
      RestorableString(_kDefaultProductName);
  final RestorableString _sku = RestorableString(_kDefaultSku);
  final RestorableString _tagline = RestorableString(_kDefaultTagline);
  final RestorableString _recipientAddress =
      RestorableString(_kDefaultAddress);
  final RestorableString _neonSignText =
      RestorableString(_kDefaultNeonText);

  // Active typography selection for the hero preview. Stored as an int so it
  // can ride the same restoration bus.
  final RestorableInt _fontFamilyIndex =
      RestorableInt(_kDefaultFontFamilyIndex);

  // ---------------------------------------------------------------------------
  // TextEditingControllers — one per editable RestorableString. They are
  // seeded from the restorable value in initState and write back to the
  // restorable on every change.
  // ---------------------------------------------------------------------------

  late final TextEditingController _productNameController;
  late final TextEditingController _skuController;
  late final TextEditingController _taglineController;
  late final TextEditingController _addressController;
  late final TextEditingController _neonController;

  @override
  String? get restorationId => 'label_printer_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_productName, 'product_name');
    registerForRestoration(_sku, 'sku');
    registerForRestoration(_tagline, 'tagline');
    registerForRestoration(_recipientAddress, 'recipient_address');
    registerForRestoration(_neonSignText, 'neon_sign_text');
    registerForRestoration(_fontFamilyIndex, 'font_family_index');
    // Sync controllers to whatever values were restored.
    _productNameController.text = _productName.value;
    _skuController.text = _sku.value;
    _taglineController.text = _tagline.value;
    _addressController.text = _recipientAddress.value;
    _neonController.text = _neonSignText.value;
  }

  @override
  void initState() {
    super.initState();
    // Note: this script originally seeded each controller from the
    // matching `RestorableString.value` here. Under the d4rt
    // interpreter, `RestorableProperty.value` reads before
    // `restoreState` has registered the property surface a
    // `LateInitializationError` (`_value`) instead of Flutter's
    // "no value yet" message, which propagates and leaves the
    // surrounding `late final` controller field unassigned. The
    // documented D3 workaround in `interpreter_unfixable.md` is
    // to seed controllers with the *literal default* and only
    // sync from `RestorableProperty.value` inside `restoreState`,
    // which is functionally equivalent in real Flutter.
    _productNameController =
        TextEditingController(text: _kDefaultProductName);
    _skuController = TextEditingController(text: _kDefaultSku);
    _taglineController = TextEditingController(text: _kDefaultTagline);
    _addressController = TextEditingController(text: _kDefaultAddress);
    _neonController = TextEditingController(text: _kDefaultNeonText);

    _productNameController.addListener(_onProductNameChanged);
    _skuController.addListener(_onSkuChanged);
    _taglineController.addListener(_onTaglineChanged);
    _addressController.addListener(_onAddressChanged);
    _neonController.addListener(_onNeonChanged);
  }

  @override
  void dispose() {
    _productNameController.removeListener(_onProductNameChanged);
    _skuController.removeListener(_onSkuChanged);
    _taglineController.removeListener(_onTaglineChanged);
    _addressController.removeListener(_onAddressChanged);
    _neonController.removeListener(_onNeonChanged);

    _productNameController.dispose();
    _skuController.dispose();
    _taglineController.dispose();
    _addressController.dispose();
    _neonController.dispose();

    _productName.dispose();
    _sku.dispose();
    _tagline.dispose();
    _recipientAddress.dispose();
    _neonSignText.dispose();
    _fontFamilyIndex.dispose();

    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Controller listeners. Each one is a bound instance method so it can be
  // removed in dispose(). setState is called to repaint the preview cards.
  // ---------------------------------------------------------------------------

  void _onProductNameChanged() {
    if (_productName.value == _productNameController.text) {
      return;
    }
    setState(() {
      _productName.value = _productNameController.text;
    });
  }

  void _onSkuChanged() {
    if (_sku.value == _skuController.text) {
      return;
    }
    setState(() {
      _sku.value = _skuController.text;
    });
  }

  void _onTaglineChanged() {
    if (_tagline.value == _taglineController.text) {
      return;
    }
    setState(() {
      _tagline.value = _taglineController.text;
    });
  }

  void _onAddressChanged() {
    if (_recipientAddress.value == _addressController.text) {
      return;
    }
    setState(() {
      _recipientAddress.value = _addressController.text;
    });
  }

  void _onNeonChanged() {
    if (_neonSignText.value == _neonController.text) {
      return;
    }
    setState(() {
      _neonSignText.value = _neonController.text;
    });
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  void _resetToDefaults() {
    debugPrint(
      '[LabelPrinterStudio] Reset requested — restoring factory strings.',
    );
    setState(() {
      _productName.value = _kDefaultProductName;
      _sku.value = _kDefaultSku;
      _tagline.value = _kDefaultTagline;
      _recipientAddress.value = _kDefaultAddress;
      _neonSignText.value = _kDefaultNeonText;
      _fontFamilyIndex.value = _kDefaultFontFamilyIndex;

      _productNameController.text = _productName.value;
      _skuController.text = _sku.value;
      _taglineController.text = _tagline.value;
      _addressController.text = _recipientAddress.value;
      _neonController.text = _neonSignText.value;
    });
    debugPrint(
      '[LabelPrinterStudio] Reset complete: productName="${_productName.value}"',
    );
  }

  void _selectFontFamily(int index) {
    if (index < 0 || index >= _kFontFamilies.length) {
      return;
    }
    debugPrint(
      '[LabelPrinterStudio] Typography changed to "${_kFontFamilies[index].label}" for "${_productName.value}".',
    );
    setState(() {
      _fontFamilyIndex.value = index;
    });
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kChromeBackground,
      appBar: AppBar(
        backgroundColor: _kChromeAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'RestorableString — Label Printer Studio',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: _resetToDefaults,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
          children: <Widget>[
            _buildIntroHeader(),
            const SizedBox(height: 20),
            _buildHeroCarousel(),
            const SizedBox(height: 24),
            _buildEditor(),
            const SizedBox(height: 24),
            _buildTypographyRow(),
            const SizedBox(height: 24),
            _buildTransformPanel(),
            const SizedBox(height: 24),
            _buildTeachingPanel(),
            const SizedBox(height: 32),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Intro header
  // ---------------------------------------------------------------------------

  Widget _buildIntroHeader() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kChromeCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kChromeAccent.withValues(alpha: 0.3)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _kChromeAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.qr_code_2,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'One restored string — five visual lives.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: _kChromeText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Every preview card below renders the SAME RestorableString values '
            'through a different visual lens. Edit any field and watch the '
            'shipping label, price tag, neon sign, and envelope all update '
            'in lockstep — yet survive a hot restart untouched.',
            style: TextStyle(
              fontSize: 14,
              height: 1.45,
              color: _kChromeMuted,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Hero carousel — four preview cards, horizontally scrollable.
  // ---------------------------------------------------------------------------

  Widget _buildHeroCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          icon: Icons.photo_library_outlined,
          title: 'Hero preview carousel',
          subtitle:
              'Four renditions of the same restorable strings. Scroll horizontally.',
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 340,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            children: <Widget>[
              _buildShippingLabel(),
              const SizedBox(width: 16),
              _buildPriceTag(),
              const SizedBox(width: 16),
              _buildNeonSign(),
              const SizedBox(width: 16),
              _buildEnvelope(),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Preview card 1 — shipping label
  // ---------------------------------------------------------------------------

  Widget _buildShippingLabel() {
    final TextStyle heroStyle =
        _kFontFamilies[_fontFamilyIndex.value].style.copyWith(
              color: _kShippingInk,
              fontSize: 20,
            );
    return _PreviewFrame(
      label: 'Shipping Label',
      accent: _kShippingInk,
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kShippingPaper,
          border: Border.all(color: _kShippingInk, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _DottedDividerRow(color: _kShippingInk),
            const SizedBox(height: 10),
            Text(
              'SHIP TO',
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 10,
                letterSpacing: 2,
                fontWeight: FontWeight.w700,
                color: _kShippingInk,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _recipientAddress.value,
              style: const TextStyle(
                fontSize: 12,
                height: 1.35,
                color: _kShippingInk,
              ),
            ),
            const SizedBox(height: 14),
            Text('CONTENTS',
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                  color: _kShippingInk,
                )),
            const SizedBox(height: 4),
            Text(
              _productName.value,
              style: heroStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    _sku.value,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _kShippingInk,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const _BarcodeStrip(width: 130, height: 38),
              ],
            ),
            const Spacer(),
            const _DottedDividerRow(color: _kShippingInk),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  'TRK# 1Z-LP-8842',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 10,
                    color: _kShippingInk,
                  ),
                ),
                Text(
                  'CLASS A',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 10,
                    color: _kShippingInk,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Preview card 2 — retail price tag
  // ---------------------------------------------------------------------------

  Widget _buildPriceTag() {
    return _PreviewFrame(
      label: 'Price Tag',
      accent: _kTagRed,
      child: SizedBox(
        width: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _ScallopedEdge(
              color: _kTagCream,
              scallopCount: 10,
              height: 14,
            ),
            Container(
              decoration: const BoxDecoration(color: _kTagCream),
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'SALE',
                    style: const TextStyle(
                      color: _kTagRed,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _productName.value,
                    style: const TextStyle(
                      color: _kTagInk,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _tagline.value,
                    style: const TextStyle(
                      color: _kTagStrike,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Text(
                            '£9.50',
                            style: TextStyle(
                              color: _kTagStrike.withValues(alpha: 0.9),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 52,
                            height: 2,
                            color: _kTagRed,
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        '£6.25',
                        style: TextStyle(
                          color: _kTagRed,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _kTagRed.withValues(alpha: 0.08),
                      border: Border.all(color: _kTagRed, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _sku.value,
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 11,
                        color: _kTagInk,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w700,
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

  // ---------------------------------------------------------------------------
  // Preview card 3 — neon storefront sign
  // ---------------------------------------------------------------------------

  Widget _buildNeonSign() {
    return _PreviewFrame(
      label: 'Neon Sign',
      accent: _kSignNeon,
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
          color: _kSignBackground,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _kSignNeon.withValues(alpha: 0.35),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _neonSignText.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _kSignNeon,
                fontSize: 54,
                fontWeight: FontWeight.w900,
                letterSpacing: 6,
                shadows: <Shadow>[
                  Shadow(
                    color: _kSignNeon.withValues(alpha: 0.9),
                    blurRadius: 12,
                  ),
                  Shadow(
                    color: _kSignNeon.withValues(alpha: 0.7),
                    blurRadius: 24,
                  ),
                  Shadow(
                    color: _kSignDim.withValues(alpha: 0.5),
                    blurRadius: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 2,
              width: 120,
              decoration: BoxDecoration(
                color: _kSignNeon.withValues(alpha: 0.85),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _kSignNeon.withValues(alpha: 0.7),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              _tagline.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _kSignDim.withValues(alpha: 0.9),
                fontSize: 13,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Text(
              _productName.value.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _kSignDim.withValues(alpha: 0.55),
                fontSize: 11,
                letterSpacing: 3,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Preview card 4 — envelope
  // ---------------------------------------------------------------------------

  Widget _buildEnvelope() {
    return _PreviewFrame(
      label: 'Envelope',
      accent: _kEnvelopeAccent,
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kEnvelopePaper,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: _kEnvelopeAccent.withValues(alpha: 0.35),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -8,
              left: -8,
              right: -8,
              child: Transform(
                alignment: Alignment.topCenter,
                transform: Matrix4.identity()..rotateZ(0.015),
                child: Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: _kEnvelopeFlap,
                    border: Border(
                      bottom: BorderSide(
                        color: _kEnvelopeAccent.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'To',
                              style: TextStyle(
                                color: _kEnvelopeAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _recipientAddress.value,
                              style: const TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 13,
                                height: 1.4,
                                color: _kChromeText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 54,
                        height: 62,
                        decoration: BoxDecoration(
                          color: _kEnvelopeStamp,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.local_post_office,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _kEnvelopeAccent.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: _kEnvelopeAccent.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _productName.value,
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _kChromeText,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _tagline.value,
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: _kChromeText.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _sku.value,
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 10,
                          color: _kChromeMuted,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Text(
                        'Via Airmail',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          color: _kEnvelopeAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2 — editor
  // ---------------------------------------------------------------------------

  Widget _buildEditor() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            icon: Icons.edit_outlined,
            title: 'Text-input editor',
            subtitle:
                'Edit any field — previews above update live and survive restart.',
          ),
          const SizedBox(height: 14),
          _buildEditorField(
            label: 'Product name',
            hint: 'e.g. Artisan Sourdough 600g',
            controller: _productNameController,
            icon: Icons.bakery_dining_outlined,
            maxLines: 1,
          ),
          const SizedBox(height: 12),
          _buildEditorField(
            label: 'SKU',
            hint: 'e.g. SKU-00042-ASD',
            controller: _skuController,
            icon: Icons.numbers,
            maxLines: 1,
          ),
          const SizedBox(height: 12),
          _buildEditorField(
            label: 'Tagline',
            hint: 'Short marketing phrase',
            controller: _taglineController,
            icon: Icons.campaign_outlined,
            maxLines: 1,
          ),
          const SizedBox(height: 12),
          _buildEditorField(
            label: 'Neon sign text',
            hint: 'Short all-caps word',
            controller: _neonController,
            icon: Icons.tungsten_outlined,
            maxLines: 1,
          ),
          const SizedBox(height: 12),
          _buildEditorField(
            label: 'Recipient address',
            hint: 'Multi-line address',
            controller: _addressController,
            icon: Icons.mail_outline,
            maxLines: 4,
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: _resetToDefaults,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset to defaults'),
              style: FilledButton.styleFrom(
                backgroundColor: _kChromeAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required int maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, size: 16, color: _kChromeAccent),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: _kChromeText,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14, color: _kChromeText),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: _kChromeMuted.withValues(alpha: 0.7),
              fontSize: 13,
            ),
            filled: true,
            fillColor: _kChromeBackground.withValues(alpha: 0.6),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _kChromeAccent.withValues(alpha: 0.25),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _kChromeAccent.withValues(alpha: 0.25),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _kChromeAccent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3 — typography variant row
  // ---------------------------------------------------------------------------

  Widget _buildTypographyRow() {
    final int activeIndex = _fontFamilyIndex.value;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            icon: Icons.text_fields,
            title: 'Typography variant row',
            subtitle:
                'Same restored string, four visual families. Hero preview adopts the selected one.',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 130,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _kFontFamilies.length,
              separatorBuilder: (BuildContext _, int _) =>
                  const SizedBox(width: 12),
              itemBuilder: (BuildContext ctx, int i) {
                final _FontFamilyDescriptor family = _kFontFamilies[i];
                final bool selected = i == activeIndex;
                final String display = i == 3
                    ? _productName.value.toUpperCase()
                    : _productName.value;
                return GestureDetector(
                  onTap: () => _selectFontFamily(i),
                  child: Container(
                    width: 220,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selected
                          ? _kChromeAccent.withValues(alpha: 0.1)
                          : _kChromeBackground,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? _kChromeAccent
                            : _kChromeAccent.withValues(alpha: 0.25),
                        width: selected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          family.label.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            color: selected ? _kChromeAccent : _kChromeMuted,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Center(
                            child: Text(
                              display,
                              textAlign: TextAlign.center,
                              style: family.style,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: SegmentedButton<int>(
              segments: <ButtonSegment<int>>[
                for (int i = 0; i < _kFontFamilies.length; i++)
                  ButtonSegment<int>(
                    value: i,
                    label: Text(
                      _kFontFamilies[i].label,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
              ],
              selected: <int>{activeIndex},
              onSelectionChanged: (Set<int> selection) {
                if (selection.isEmpty) {
                  return;
                }
                _selectFontFamily(selection.first);
              },
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor:
                    _kChromeAccent.withValues(alpha: 0.85),
                selectedForegroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              _kFontFamilies[activeIndex].description,
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: _kChromeMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4 — length / transform helper panel
  // ---------------------------------------------------------------------------

  Widget _buildTransformPanel() {
    final String source = _productName.value;
    final List<_TransformRow> rows = <_TransformRow>[
      _TransformRow('Character count', source.length.toString()),
      _TransformRow('Word count', _countWords(source).toString()),
      _TransformRow('Uppercase', source.toUpperCase()),
      _TransformRow('Lowercase', source.toLowerCase()),
      _TransformRow('Truncated (≤16)', _truncate(source, 16)),
      _TransformRow('Reversed', _reverseString(source)),
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            icon: Icons.straighten,
            title: 'Length & transform helper',
            subtitle:
                'Derived, pure-function views over the current product name.',
          ),
          const SizedBox(height: 14),
          for (final _TransformRow row in rows) ...<Widget>[
            _buildTransformRow(row),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }

  Widget _buildTransformRow(_TransformRow row) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _kChromeBackground.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _kChromeAccent.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              row.label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _kChromeText,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.value.isEmpty ? '(empty string)' : row.value,
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 13,
                color: row.value.isEmpty ? _kChromeMuted : _kChromeText,
                fontStyle: row.value.isEmpty
                    ? FontStyle.italic
                    : FontStyle.normal,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5 — teaching panel
  // ---------------------------------------------------------------------------

  Widget _buildTeachingPanel() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(accent: _kChromeAccent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(
            icon: Icons.school_outlined,
            title: 'RestorableString vs RestorableStringN',
            subtitle: 'Choose the right flavour for your use case.',
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _buildTeachingColumn(
                  title: 'RestorableString',
                  accent: _kChromeAccent,
                  summary:
                      'Mandatory field. Always holds a value — even if that value is the empty string ("").',
                  examples: const <String>[
                    'Username entered on a sign-up screen that cannot stay blank.',
                    'A product name in a catalogue editor (default: "Untitled product").',
                    'A chat draft pinned to a conversation thread.',
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTeachingColumn(
                  title: 'RestorableStringN',
                  accent: _kTagRed,
                  summary:
                      'Optional field. `null` is a first-class value meaning "no value set at all".',
                  examples: const <String>[
                    'Optional middle-name field (null = user did not supply one).',
                    'Filter text in a search bar (null = filter disabled).',
                    'A last-saved voice memo transcript (null = never recorded).',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kChromeText,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'final productName   = RestorableString("Untitled");   // never null\n'
              'final middleName    = RestorableStringN(null);        // may be null\n\n'
              '// Register both the same way:\n'
              'registerForRestoration(productName, "product_name");\n'
              'registerForRestoration(middleName, "middle_name");\n\n'
              '// Access differs:\n'
              'String           name   = productName.value;    // String\n'
              'String?          middle = middleName.value;     // String?',
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 12.5,
                height: 1.45,
                color: Color(0xFFF6E6B4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachingColumn({
    required String title,
    required Color accent,
    required String summary,
    required List<String> examples,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: accent,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            summary,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: _kChromeText,
            ),
          ),
          const SizedBox(height: 10),
          for (final String example in examples) ...<Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 8),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    example,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.35,
                      color: _kChromeMuted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Footer
  // ---------------------------------------------------------------------------

  Widget _buildFooter() {
    return Center(
      child: Text(
        'Label Printer Studio · Tom D4rt Flutter M · RestorableString demo',
        style: TextStyle(
          color: _kChromeMuted.withValues(alpha: 0.85),
          fontSize: 11,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared helpers
  // ---------------------------------------------------------------------------

  BoxDecoration _panelDecoration({Color? accent}) {
    final Color borderColor = (accent ?? _kChromeAccent).withValues(alpha: 0.2);
    return BoxDecoration(
      color: _kChromeCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: borderColor),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _sectionTitle({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kChromeAccent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: _kChromeAccent),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _kChromeText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: _kChromeMuted,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  int _countWords(String source) {
    if (source.trim().isEmpty) {
      return 0;
    }
    return source
        .trim()
        .split(RegExp(r'\s+'))
        .where((String s) => s.isNotEmpty)
        .length;
  }

  String _truncate(String source, int maxChars) {
    if (source.length <= maxChars) {
      return source;
    }
    if (maxChars <= 1) {
      return '…';
    }
    return '${source.substring(0, maxChars - 1)}…';
  }

  String _reverseString(String source) {
    final List<String> chars = source.split('');
    return chars.reversed.join();
  }
}

// =============================================================================
// Preview framing — shared frame used around every hero card so they all have
// the same "polaroid" label above the actual illustration.
// =============================================================================

class _PreviewFrame extends StatelessWidget {
  const _PreviewFrame({
    required this.label,
    required this.accent,
    required this.child,
  });

  final String label;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: accent.withValues(alpha: 0.5)),
          ),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: accent,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(child: child),
      ],
    );
  }
}

// =============================================================================
// Dotted divider — builds a row of tiny squares to approximate a dotted line
// for the shipping label. Purely decorative.
// =============================================================================

class _DottedDividerRow extends StatelessWidget {
  const _DottedDividerRow({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        const double dotSize = 2;
        const double gap = 4;
        final int count =
            (constraints.maxWidth / (dotSize + gap)).floor().clamp(4, 200);
        return Row(
          children: <Widget>[
            for (int i = 0; i < count; i++)
              Padding(
                padding: EdgeInsets.only(right: i == count - 1 ? 0 : gap),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  color: color,
                ),
              ),
          ],
        );
      },
    );
  }
}

// =============================================================================
// Barcode strip — a row of alternating black/white narrow rectangles. The
// exact pattern is derived deterministically from the index so that the
// widget is const-buildable and does not re-randomise on every rebuild.
// =============================================================================

class _BarcodeStrip extends StatelessWidget {
  const _BarcodeStrip({required this.width, required this.height});

  final double width;
  final double height;

  static const List<int> _kPattern = <int>[
    3, 1, 2, 1, 1, 2, 3, 1, 1, 1, 2, 2, 1, 3, 1, 2, 1, 1, 2, 1,
    3, 1, 2, 1, 1, 2, 1, 3, 1, 2, 1, 1, 2, 3, 1, 1, 2, 1, 2, 1,
  ];

  @override
  Widget build(BuildContext context) {
    final int totalWeight = _kPattern.fold<int>(0, (int a, int b) => a + b);
    final double unit = width / totalWeight;
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < _kPattern.length; i++)
            Container(
              width: unit * _kPattern[i],
              color: i.isEven ? _kShippingStripe : Colors.white,
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// Scalloped edge — approximates a retail-tag scalloped top by drawing a row
// of half-circle cut-outs. Implemented via a Row of overlapping circles on a
// solid base with a contrasting background colour.
// =============================================================================

class _ScallopedEdge extends StatelessWidget {
  const _ScallopedEdge({
    required this.color,
    required this.scallopCount,
    required this.height,
  });

  final Color color;
  final int scallopCount;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          final double diameter = constraints.maxWidth / scallopCount;
          return Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                top: height / 2,
                bottom: 0,
                child: Container(color: color),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Row(
                  children: <Widget>[
                    for (int i = 0; i < scallopCount; i++)
                      Container(
                        width: diameter,
                        height: diameter,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(diameter / 2),
                            topRight: Radius.circular(diameter / 2),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// Value-type used by the transform panel to pair a label with its computed
// value. Trivial but named for readability.
// =============================================================================

class _TransformRow {
  const _TransformRow(this.label, this.value);

  final String label;
  final String value;
}
